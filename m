Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08D636924A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhDWMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:42:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:9511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhDWMmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:42:04 -0400
IronPort-SDR: vyq1Nnn/YmJrMTx82quo8iLAlwwGPR7IBlaQ1+1ccB/OKLLrrBXF8cLMREFhPb5D2fjXxVpova
 Hc3qp8meBWbg==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="260014674"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="260014674"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 05:41:27 -0700
IronPort-SDR: QPHLW8jG5xCo83/70ShTBOMYCGWqTGw2QkEAqFlaekBZ1w5gwgawbZM/mw7M8sIz0e302n+OVA
 0polxrY4qHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="386380029"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 23 Apr 2021 05:41:23 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 23 Apr 2021 15:41:23 +0300
Date:   Fri, 23 Apr 2021 15:41:23 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Takashi Iwai <tiwai@suse.de>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915: Invoke BXT _DSM to enable MUX on HP
 Workstation laptops
Message-ID: <YILAc6EhoWWhENq8@intel.com>
References: <20210423044700.247359-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423044700.247359-1-kai.heng.feng@canonical.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 12:46:54PM +0800, Kai-Heng Feng wrote:
> On HP Fury G7 Workstations, graphics output is re-routed from Intel GFX
> to discrete GFX after S3. This is not desirable, because userspace will
> treat connected display as a new one, losing display settings.
> 
> The expected behavior is to let discrete GFX drives all external
> displays.
> 
> The platform in question uses ACPI method \_SB.PCI0.HGME to enable MUX.
> The method is inside the BXT _DSM, so add the _DSM and call it
> accordingly.
> 
> I also tested some MUX-less and iGPU only laptops with the BXT _DSM, no
> regression was found.
> 
> v2:
>  - Forward declare struct pci_dev.
> 
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3113
> References: https://lore.kernel.org/intel-gfx/1460040732-31417-4-git-send-email-animesh.manna@intel.com/
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_acpi.c | 17 +++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_acpi.h |  3 +++
>  drivers/gpu/drm/i915/i915_drv.c           |  5 +++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index 833d0c1be4f1..c7b57c22dce3 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -14,11 +14,16 @@
>  
>  #define INTEL_DSM_REVISION_ID 1 /* For Calpella anyway... */
>  #define INTEL_DSM_FN_PLATFORM_MUX_INFO 1 /* No args */
> +#define INTEL_DSM_FN_PLATFORM_BXT_MUX_INFO 0 /* No args */
>  
>  static const guid_t intel_dsm_guid =
>  	GUID_INIT(0x7ed873d3, 0xc2d0, 0x4e4f,
>  		  0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
>  
> +static const guid_t intel_bxt_dsm_guid =
> +	GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> +		  0x9d, 0x15, 0xc7, 0x1f, 0xba, 0xda, 0xe4, 0x14);
> +

I think this dsm is just supposed to be more or less an
alternative to the opregion SCI stuff. Why there are two
ways to do the same things I have no idea. The opregion
spec does not tell us such mundane details.

It's also not documented to do anything except list the
supported functions:
"Get BIOS Data Functions Supported “Function #0"
 This function can be called to discover which “_DSM” Functions are
 supported. It may only return success if the return value accurately
 lists supported Functions."

But what you're apparently saying is that calling this changes
the behaviour of the system somehow? That is troubling.

-- 
Ville Syrjälä
Intel
