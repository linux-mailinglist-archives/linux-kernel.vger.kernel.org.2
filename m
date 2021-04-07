Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD70C3576D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhDGV3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:29:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:7164 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232762AbhDGV3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:29:06 -0400
IronPort-SDR: IFW3DBuIPxtFyzpq727AuuvLUSUDiQxOJi6egkr5G9rIGJRFnd8Q1qORRQiYuk2U3/8hzqknbJ
 TfJNkhKwiqfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="254740001"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="254740001"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 14:28:52 -0700
IronPort-SDR: KQrS4tTE9U49Ey/tU4WtUCsHHYZyvz+Qt5XrN1kzop9rEudlwazfJyaUuE2EcEjd4bX97/ErhT
 uZHzVYSNId8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="387143406"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga007.fm.intel.com with SMTP; 07 Apr 2021 14:28:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 08 Apr 2021 00:28:48 +0300
Date:   Thu, 8 Apr 2021 00:28:48 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Fix invalid access to ACPI _DSM
 objects
Message-ID: <YG4kEEqExSUjA0kh@intel.com>
References: <20210402082317.871-1-tiwai@suse.de>
 <YG3fJq6wkeQGafSS@intel.com>
 <s5ho8eq824w.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5ho8eq824w.wl-tiwai@suse.de>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 06:56:15PM +0200, Takashi Iwai wrote:
> On Wed, 07 Apr 2021 18:34:46 +0200,
> Ville Syrjälä wrote:
> > 
> > On Fri, Apr 02, 2021 at 10:23:17AM +0200, Takashi Iwai wrote:
> > > intel_dsm_platform_mux_info() tries to parse the ACPI package data
> > > from _DSM for the debug information, but it assumes the fixed format
> > > without checking what values are stored in the elements actually.
> > > When an unexpected value is returned from BIOS, it may lead to GPF or
> > > NULL dereference, as reported recently.
> > > 
> > > Add the checks of the contents in the returned values and skip the
> > > values for invalid cases.
> > > 
> > > v1->v2: Check the info contents before dereferencing, too
> > > 
> > > BugLink: http://bugzilla.opensuse.org/show_bug.cgi?id=1184074
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  drivers/gpu/drm/i915/display/intel_acpi.c | 22 ++++++++++++++++++++--
> > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > > index e21fb14d5e07..833d0c1be4f1 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > > @@ -84,13 +84,31 @@ static void intel_dsm_platform_mux_info(acpi_handle dhandle)
> > >  		return;
> > >  	}
> > >  
> > > +	if (!pkg->package.count) {
> > > +		DRM_DEBUG_DRIVER("no connection in _DSM\n");
> > > +		return;
> > > +	}
> > > +
> > >  	connector_count = &pkg->package.elements[0];
> > >  	DRM_DEBUG_DRIVER("MUX info connectors: %lld\n",
> > >  		  (unsigned long long)connector_count->integer.value);
> > >  	for (i = 1; i < pkg->package.count; i++) {
> > >  		union acpi_object *obj = &pkg->package.elements[i];
> > > -		union acpi_object *connector_id = &obj->package.elements[0];
> > > -		union acpi_object *info = &obj->package.elements[1];
> > > +		union acpi_object *connector_id;
> > > +		union acpi_object *info;
> > > +
> > > +		if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
> > > +			DRM_DEBUG_DRIVER("Invalid object for MUX #%d\n", i);
> > > +			continue;
> > > +		}
> > > +
> > > +		connector_id = &obj->package.elements[0];
> > 
> > You don't want to check connector_id->type as well?
> 
> I added only the minimal checks that may lead to Oops.

OK. I guess misinterpreting something else as an integer isn't
particular dangerous in this case.

Pushed to drm-intel-next. Thanks.

Oh, could you ask the bug reporter to attach an acpidump to the
bug? Might be good to have that stuff on record somewhere if/when
someone wants to actually figure out what's going on here.

That said, maybe we should just nuke this whole thing instead?
Unless I'm missing someting this code doesn't seem to actually
do anything...

-- 
Ville Syrjälä
Intel
