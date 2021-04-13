Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB235E47C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346991AbhDMRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:00:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:14038 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345936AbhDMRAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:00:02 -0400
IronPort-SDR: 5mB13PZ24mG0r+mMVE2i236uN1HMXlk+a/cJ5k3d7msMUcWuwMWM7sScNiI8euwQknGe0PTVGa
 lIqlGmdddO4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="214941197"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="214941197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 09:59:41 -0700
IronPort-SDR: b9JQnHmyNK9H0SxG2ldlD6mtXXg/Cwe1SH7FDueh3LgvnB1ET5V2880Yxkm6i8xK9N1XD7izze
 ToJ8S6k9gT4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="424337626"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga008.jf.intel.com with SMTP; 13 Apr 2021 09:59:35 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 13 Apr 2021 19:59:34 +0300
Date:   Tue, 13 Apr 2021 19:59:34 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jon Bloomfield <jon.bloomfield@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Fix "mitigations" parsing if i915 is builtin
Message-ID: <YHXN9lqtdvisT8gn@intel.com>
References: <20210413170240.0d4ffa38@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210413170240.0d4ffa38@xhacker.debian>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 05:02:40PM +0800, Jisheng Zhang wrote:
> I met below error during boot with i915 builtin if pass
> "i915.mitigations=off":
> [    0.015589] Booting kernel: `off' invalid for parameter `i915.mitigations'
> 
> The reason is slab subsystem isn't ready at that time, so kstrdup()
> returns NULL. Fix this issue by using stack var instead of kstrdup().
> 
> Fixes: 984cadea032b ("drm/i915: Allow the sysadmin to override security mitigations")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/gpu/drm/i915/i915_mitigations.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/i915/i915_mitigations.c
> index 84f12598d145..7dadf41064e0 100644
> --- a/drivers/gpu/drm/i915/i915_mitigations.c
> +++ b/drivers/gpu/drm/i915/i915_mitigations.c
> @@ -29,15 +29,13 @@ bool i915_mitigate_clear_residuals(void)
>  static int mitigations_set(const char *val, const struct kernel_param *kp)
>  {
>  	unsigned long new = ~0UL;
> -	char *str, *sep, *tok;
> +	char str[64], *sep, *tok;
>  	bool first = true;
>  	int err = 0;
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(names) >= BITS_PER_TYPE(mitigations));
>  
> -	str = kstrdup(val, GFP_KERNEL);
> -	if (!str)
> -		return -ENOMEM;
> +	strncpy(str, val, sizeof(str) - 1);

I don't think strncpy() guarantees that the string is properly
terminated.

Also commit b1b6bed3b503 ("usb: core: fix quirks_param_set() writing to
a const pointer") looks broken as well given your findings, and
arch/um/drivers/virtio_uml.c seems to suffer from this as well.
kernel/params.c itself seems to have some slab_is_available() magic
around kmalloc().

I used the following cocci snippet to find these:
@find@
identifier O, F;
position PS;
@@
struct kernel_param_ops O = {
...,
        .set = F@PS
,...
};

@alloc@
identifier ALLOC =~ "^k.*(alloc|dup)";
identifier find.F;
position PA;
@@
F(...) {
<+...
ALLOC@PA(...)
...+>
}

@script:python depends on alloc@
ps << find.PS;
pa << alloc.PA;
@@
coccilib.report.print_report(ps[0], "struct")
coccilib.report.print_report(pa[0], "alloc")

That could of course miss a bunch more if they allocate
via some other function I didn't consider.

-- 
Ville Syrjälä
Intel
