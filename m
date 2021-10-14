Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184D742E330
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhJNVYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhJNVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:24:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E9C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:21:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u21so29460942lff.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kQwUmmPeJ8Hce507ICCeYLH5aPrCZw/ZIJrPidgd9ZE=;
        b=HMN7qIWonn2K5R4zTQ2lDey6lWwmzqJlSStqviM7qxSdzciKyT9pSF7PvGKF5nZtKe
         bIzc4Wim9DKWdo0s7t/S4Stw+bjX4NTSbQrEJXGloTpUc6lXYgElEKn+fmaT+mtRsmGm
         xGbMRdPYm9U4MsGWGEUCFlmSokKe85X36P7IgBgCqzKY4ZNddAphaTGb0qrQCavQXL1W
         rKbTCLqs/PIp8yRaN2vjKJ7nxoHhOh98POPoAqbsDljCp1c04VsHN4U+di73gsd3JdGJ
         EMi0ZmE1nolIZ2ZQmA0xOep6o/wongsjBW0ShfD0eCV2it/KczUx6S47vV01tPsfoEzY
         f14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kQwUmmPeJ8Hce507ICCeYLH5aPrCZw/ZIJrPidgd9ZE=;
        b=1EJZw5BHlP4uKD2XXoN2tuOBl9kGSxTA7Y9S65s7uhBwBcZcPNvPzGrOefqNGTe5Fa
         2tQcxpBVWj8jc32giwWc2od363o4acV1MHKYDd+q8070d19eeScOTCbvt7o5uZrh8M1G
         M7YVmFegZ6NY0BAK0fKPVb4j83XHc0wnIO4ES28VH6iQI2ClgJ7YlxOFXholpYxrT4rn
         VbdExBN2W2M6QGLz04dRBtepFoOa1lwIqZdsJJTms6Ce59NS5nV3kO3Z/xn6ZBQYYfYI
         YQOtPxe8ZOCLCvrO9VaPNukn6PbGjP8KayW1hQnUhZ9ERrRP3uavUMsX29FDh3XAgT9y
         snGA==
X-Gm-Message-State: AOAM533n875lu7bvTc/r7eUxexvkeDIuPq8U7QoJC86dpFP5fNt/d4ff
        4BPvx4R6/O5lh/TtyEv9PEOw4k2R/4uMSdFZHk5DSA==
X-Google-Smtp-Source: ABdhPJzcKBq6vCrkR8ENl9gj9IqS485yrxDyz2P7VIjz8eeAT/1thN0HtZ0Fi2grgZQEmwtsIyFcjiem2P07eTN9XKg=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr8609302lja.198.1634246515116;
 Thu, 14 Oct 2021 14:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211014211916.3550122-1-nathan@kernel.org>
In-Reply-To: <20211014211916.3550122-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 14:21:43 -0700
Message-ID: <CAKwvOdmSFP98Mc1u2b+=_Dux9eB_yumRvxOx7UTXuyXOYzG3uA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Avoid bitwise vs logical OR warning in snb_wm_latency_quirk()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 2:19 PM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> A new warning in clang points out a place in this file where a bitwise
> OR is being used with boolean types:
>
> drivers/gpu/drm/i915/intel_pm.c:3066:12: warning: use of bitwise '|' with=
 boolean operands [-Wbitwise-instead-of-logical]
>         changed =3D ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_la=
tency, 12) |
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>
> This construct is intentional, as it allows every one of the calls to
> ilk_increase_wm_latency() to occur (instead of short circuiting with
> logical OR) while still caring about the result of each call.
>
> To make this clearer to the compiler, use the '|=3D' operator to assign
> the result of each ilk_increase_wm_latency() call to changed, which
> keeps the meaning of the code the same but makes it obvious that every
> one of these calls is expected to happen.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1473
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch!
Suggested-by: D=C3=A1vid Bolvansk=C3=BD <david.bolvansky@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/i915/intel_pm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel=
_pm.c
> index f90fe39cf8ca..aaa3a0998e4c 100644
> --- a/drivers/gpu/drm/i915/intel_pm.c
> +++ b/drivers/gpu/drm/i915/intel_pm.c
> @@ -3050,9 +3050,9 @@ static void snb_wm_latency_quirk(struct drm_i915_pr=
ivate *dev_priv)
>          * The BIOS provided WM memory latency values are often
>          * inadequate for high resolution displays. Adjust them.
>          */
> -       changed =3D ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_la=
tency, 12) |
> -               ilk_increase_wm_latency(dev_priv, dev_priv->wm.spr_latenc=
y, 12) |
> -               ilk_increase_wm_latency(dev_priv, dev_priv->wm.cur_latenc=
y, 12);
> +       changed =3D ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_la=
tency, 12);
> +       changed |=3D ilk_increase_wm_latency(dev_priv, dev_priv->wm.spr_l=
atency, 12);
> +       changed |=3D ilk_increase_wm_latency(dev_priv, dev_priv->wm.cur_l=
atency, 12);
>
>         if (!changed)
>                 return;
>
> base-commit: d73b17465d6da0a94bc0fcc86b150e1e923e8f71
> --
> 2.33.1.637.gf443b226ca
>


--=20
Thanks,
~Nick Desaulniers
