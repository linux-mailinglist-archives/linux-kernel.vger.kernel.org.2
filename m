Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985740B2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhINPTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhINPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:19:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D17C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:17:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r3so24604424ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASAhUY+G41HZqeopdHM7aTSiw9njl3EyKHtj3rFVhDs=;
        b=ak1UeKaRxOfiClhnXWFlc5Tj5KPMuwNRFkYKCr7CwkblbA9Paw3cSpCmNNjhx8WlAR
         mQVYneNQpWpRsZWGMZ81ZIH34dZdZtDMUoN3cV1bET1XUla44MYMFwHm0OhiEQ8yDSmx
         qIaoPgDcted70DTDgGFCvmz8jNdMD5pdByWJCotfqt94eCEE9xwH05GjiwEKYbRedWR4
         30qkyVGox3STWReT2o7u8OHwQAuOXe+zFCSrKHiFssbja0kfMIeSsjW2Sr2fq8/kTIQF
         +/vCVb4lldH/n0uweX+WPK3fJki6M57mqQNhADYjgGtODprzhcTxJXAhbuz6QZRBBdd7
         OpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASAhUY+G41HZqeopdHM7aTSiw9njl3EyKHtj3rFVhDs=;
        b=LXeYhqnbRQEIlE7B1sF5hqpGJfngrX6v1DhFU4pmmNMVwdxKfeqDKb6wOrvAUyEZMp
         mTWnTzYwR4H8GcZcWULpO3sUy6t3b7Z55EESyPHLoSk6CEJFF3xL4Mx3OEM4mLa55jH8
         uUzHVNLoqt2SBbyZNH85mam3YKMY8ADLsxk/iWUr5uprbkw2k4dyCm3pN8PnTklKcdlD
         C0kMwFlCAnBQa3lPR2J0jPUIpFm4/Ju96PU2RXwGXKdbpcMKj2S9jZlmuV7c8KxJeFve
         UGSrMK67s0QHfZLOILAgNN6RqJDfkYa6AxgQ/fSQJjUF8OEsvUwRy+MYD5qf1Xe6nusN
         HDKg==
X-Gm-Message-State: AOAM532e0e50do3eAdFTlY64ith7TwAhsWCtd8LsaqYhyxGNp3GkwFIg
        kdyN4u6VaLzt38fM8+ZE9sToGfNKWo1EFj5h3lSJiQ==
X-Google-Smtp-Source: ABdhPJxrwrgQsvLdH3TFcygl7m8RHug7EOm+c31xSSPd1GollBX37JTf9f8IkkS/AT1bBnL51Z4Z9YyVU7EsQK1Cxs0=
X-Received: by 2002:a2e:99da:: with SMTP id l26mr15293313ljj.339.1631632667834;
 Tue, 14 Sep 2021 08:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210824225427.2065517-1-nathan@kernel.org> <20210824225427.2065517-4-nathan@kernel.org>
In-Reply-To: <20210824225427.2065517-4-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 08:17:36 -0700
Message-ID: <CAKwvOdmASG7XM5Lkv5aVttwQZkaLjm2jo+-BxBkG97h3hZ_Pew@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/i915: Enable -Wsometimes-uninitialized
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 3:54 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> This warning helps catch uninitialized variables. It should have been
> enabled at the same time as commit b2423184ac33 ("drm/i915: Enable
> -Wuninitialized") but I did not realize they were disabled separately.
> Enable it now that i915 is clean so that it stays that way.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the series!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/i915/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 642a5b5a1b81..335ba9f43d8f 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -19,7 +19,6 @@ subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
>  subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
>  # clang warnings
>  subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
> -subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
>  subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
>  subdir-ccflags-y += $(call cc-disable-warning, frame-address)
>  subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
