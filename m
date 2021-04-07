Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97B2357236
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbhDGQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:35:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:47362 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236269AbhDGQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:35:03 -0400
IronPort-SDR: 6X284qua5KEzvc9w5bAR5IWfLRW4AFLTWZCLxef9vId0i8AHJTyOL85lKG/0wbWfM/HnqtAYx7
 HO42nxorwuSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="254686626"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="254686626"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 09:34:53 -0700
IronPort-SDR: MH5hwMcGRORpjQZqM8n+1N8J6UzzEX28yImqYCH1YSGUEV6xgVXxn74zn82rdoSTBPD2yGtNDn
 MgQHjQjBS7uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="415347307"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga008.fm.intel.com with SMTP; 07 Apr 2021 09:34:50 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 07 Apr 2021 19:34:46 +0300
Date:   Wed, 7 Apr 2021 19:34:46 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Fix invalid access to ACPI _DSM
 objects
Message-ID: <YG3fJq6wkeQGafSS@intel.com>
References: <20210402082317.871-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210402082317.871-1-tiwai@suse.de>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 10:23:17AM +0200, Takashi Iwai wrote:
> intel_dsm_platform_mux_info() tries to parse the ACPI package data
> from _DSM for the debug information, but it assumes the fixed format
> without checking what values are stored in the elements actually.
> When an unexpected value is returned from BIOS, it may lead to GPF or
> NULL dereference, as reported recently.
> 
> Add the checks of the contents in the returned values and skip the
> values for invalid cases.
> 
> v1->v2: Check the info contents before dereferencing, too
> 
> BugLink: http://bugzilla.opensuse.org/show_bug.cgi?id=1184074
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/gpu/drm/i915/display/intel_acpi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index e21fb14d5e07..833d0c1be4f1 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -84,13 +84,31 @@ static void intel_dsm_platform_mux_info(acpi_handle dhandle)
>  		return;
>  	}
>  
> +	if (!pkg->package.count) {
> +		DRM_DEBUG_DRIVER("no connection in _DSM\n");
> +		return;
> +	}
> +
>  	connector_count = &pkg->package.elements[0];
>  	DRM_DEBUG_DRIVER("MUX info connectors: %lld\n",
>  		  (unsigned long long)connector_count->integer.value);
>  	for (i = 1; i < pkg->package.count; i++) {
>  		union acpi_object *obj = &pkg->package.elements[i];
> -		union acpi_object *connector_id = &obj->package.elements[0];
> -		union acpi_object *info = &obj->package.elements[1];
> +		union acpi_object *connector_id;
> +		union acpi_object *info;
> +
> +		if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
> +			DRM_DEBUG_DRIVER("Invalid object for MUX #%d\n", i);
> +			continue;
> +		}
> +
> +		connector_id = &obj->package.elements[0];

You don't want to check connector_id->type as well?

> +		info = &obj->package.elements[1];
> +		if (info->type != ACPI_TYPE_BUFFER || info->buffer.length < 4) {
> +			DRM_DEBUG_DRIVER("Invalid info for MUX obj #%d\n", i);
> +			continue;
> +		}
> +
>  		DRM_DEBUG_DRIVER("Connector id: 0x%016llx\n",
>  			  (unsigned long long)connector_id->integer.value);
>  		DRM_DEBUG_DRIVER("  port id: %s\n",
> -- 
> 2.26.2
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
