Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3D3EDFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhHPWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhHPWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:05:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C63C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 15:04:59 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h17so29480615ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e31P/2GOTWbuV4ckMdMmZ6I8R+PPJnAJhAHl1ZjYZ8Y=;
        b=edCdElcoohq5GytpdhwlPhshLDfbAh2jQXYj6et58GR+T01k1EgZoToCc2jeM3lMVd
         ycx3Io8gwiap261C2Y425b4a3KTRN4VfoqLxoQH4KG1qXQ0ILBUL/pQUZwlhjz2HLMkd
         HFHumSLdIGBYYGlKRnKqqfC/Fp4JWsKkWSw0B0iCtxRXhd56ecNT5HJZl0uW5mRHPp77
         mdHGgZMfiXShNgRy/kU/7N9MDTbLwJGS850Wa6HiXN8BEQs+q0SLdMgboC3JQ2xg6AGX
         LNrOD/8aQVxZg5KtZO3FoAIBh+U7nQ6fHNMAe7dVhGnFMI8s1FEOYl9Pz1boylAkGo8t
         yG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e31P/2GOTWbuV4ckMdMmZ6I8R+PPJnAJhAHl1ZjYZ8Y=;
        b=keqh76vT+GxmS8n+PniijhzRB/+m0VvvcTpBBHwcpnSncPpYpONi2WB4WlECQZWRH3
         Wbh3IO/fFVpx9qPAWSPClgvHxHbeKHg263D2+ZbR1c0oZVJjcT2hnowMY+ESzejHT8sl
         ZWoItO3kPZVrh53Cxrp6wQl6cUXPOG1kYM794JHoX89sPsQM0ErNqwk93+YMSRYQYvdL
         RlGPha9RbdN2YkXXjFZpUodl19+pE/kq6fQhBx8enyWyRyAS+VQXz5GcSwGtil7ChiAp
         2iqxWTAUxQdAf7qjFKLWqIP82I+rCWOI9K7AT1qE4JpAJe05Am4sZeQI3un2AXCbect6
         WGnQ==
X-Gm-Message-State: AOAM533SgnBIOfOjTRfhelpdMKH/Fr/FBU126xNMqgZ2rlA1IUk1k6pp
        pcpSYKS1Vke4wjaTqVHwjM7ktUYYSxZ2f0eU7+N34A==
X-Google-Smtp-Source: ABdhPJwxox6PXnfkmEMOrVyFZontRVeS9j/tsjqaDmcNw1hGPr+mKuthyVG+b+ZoQf9FyySDg4k5it5Il/2XusHAYTE=
X-Received: by 2002:a05:651c:83:: with SMTP id 3mr301012ljq.341.1629151498062;
 Mon, 16 Aug 2021 15:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210816185711.21563-1-nathan@kernel.org>
In-Reply-To: <20210816185711.21563-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Aug 2021 15:04:46 -0700
Message-ID: <CAKwvOdkOCraDC0QccntgWD-ZkW8c2+RG8WeOD7aQH3BHZM2BHw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xive: Do not mark xive_request_ipi() as __init
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:06 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Compiling ppc64le_defconfig with clang-14 shows a modpost warning:
>
> WARNING: modpost: vmlinux.o(.text+0xa74e0): Section mismatch in
> reference from the function xive_setup_cpu_ipi() to the function
> .init.text:xive_request_ipi()
> The function xive_setup_cpu_ipi() references
> the function __init xive_request_ipi().
> This is often because xive_setup_cpu_ipi lacks a __init
> annotation or the annotation of xive_request_ipi is wrong.
>
> xive_request_ipi() is called from xive_setup_cpu_ipi(), which is not
> __init, so xive_request_ipi() should not be marked __init. Remove the
> attribute so there is no more warning.
>
> Fixes: cbc06f051c52 ("powerpc/xive: Do not skip CPU-less nodes when creating the IPIs")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/powerpc/sysdev/xive/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index 943fd30095af..8183ca343675 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1170,7 +1170,7 @@ static int __init xive_init_ipis(void)
>         return ret;
>  }
>
> -static int __init xive_request_ipi(unsigned int cpu)
> +static int xive_request_ipi(unsigned int cpu)
>  {
>         struct xive_ipi_desc *xid = &xive_ipis[early_cpu_to_node(cpu)];
>         int ret;
>
> base-commit: a2824f19e6065a0d3735acd9fe7155b104e7edf5
> --
> 2.33.0.rc2
>


-- 
Thanks,
~Nick Desaulniers
