Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3910358A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhDHQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:56:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:30383 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhDHQ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:56:21 -0400
IronPort-SDR: 3D9Brw+reSuj0p+fNIIk2kn/S/HXiz6ZpBMJj3JdMPQlQb3g2qIocOWqgUjyvKTdksxV7gACeX
 IjIE2KhefwHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="191434213"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="191434213"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 09:56:10 -0700
IronPort-SDR: a8MADxb3Ms9DdyTFjGVgq2fXsYUZ2SqdPL30GmYgSsIOQUf9DeFQwbeMtB4VClucjaUfAgm2LA
 R5XBUFZo3kfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="415857545"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga008.fm.intel.com with SMTP; 08 Apr 2021 09:56:07 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 08 Apr 2021 19:56:06 +0300
Date:   Thu, 8 Apr 2021 19:56:06 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Fix invalid access to ACPI _DSM
 objects
Message-ID: <YG81picGSzpb84fU@intel.com>
References: <20210402082317.871-1-tiwai@suse.de>
 <YG3fJq6wkeQGafSS@intel.com>
 <s5ho8eq824w.wl-tiwai@suse.de>
 <YG4kEEqExSUjA0kh@intel.com>
 <s5hk0pd8b9l.wl-tiwai@suse.de>
 <s5h1rbk7n29.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5h1rbk7n29.wl-tiwai@suse.de>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:34:06PM +0200, Takashi Iwai wrote:
> On Thu, 08 Apr 2021 09:51:18 +0200,
> Takashi Iwai wrote:
> > 
> > On Wed, 07 Apr 2021 23:28:48 +0200,
> > Ville Syrjälä wrote:
> > > 
> > > Oh, could you ask the bug reporter to attach an acpidump to the
> > > bug? Might be good to have that stuff on record somewhere if/when
> > > someone wants to actually figure out what's going on here.
> > 
> > OK, I'll ask.
> 
> Available at
>   acpidump: https://susepaste.org/59777448
>   hwinfo: https://susepaste.org/86284020

Those will apparently expire real soon. I took local copies out
of morbid curiosity, but that's not going to help anyone else 
in the future. I rather wish bug reporting tools would flat out
refuse to accept any pastebin links.

-- 
Ville Syrjälä
Intel
