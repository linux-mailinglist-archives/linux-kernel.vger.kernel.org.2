Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364294282BA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhJJRvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhJJRvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:51:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFADC061745
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:49:22 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r1so33454769ybo.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m0tVlWSXIOyQB2dgqv4j2n31BilYhoZPAwFWKrJU88=;
        b=PsUvnSdUSAmqKwDzNq9WJnFPKcbpdmRh5/jw66XAt9hP/tWSJAb/4w/SNgIAPG5Aox
         mX2G/aDq1B5rPRE46cQTRb2XuHG9e/SSVWq8F53f4DR0mkYuD9jP54/hCWXqUXQxI0Zf
         pAcHnFJISheLru/OQ8lMIla4gFwGM5gL1R7J8H7bhKtQNeIbU5OS8k2xbFAqEvNyYkq9
         gNdSwnxBTvz5lkNBP7Dsjn+NJVtuyUR28qOL1AmfDyi9eroRguVFqfbi9gZjfk9qXLmd
         utsIGcSdYnV2MSanTe+6k1r61+/oFVTNB7smQDAR4XjowUMUmZgtO5J3dPU+BQVD5T6H
         SWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m0tVlWSXIOyQB2dgqv4j2n31BilYhoZPAwFWKrJU88=;
        b=paUbk+EtYVrSJ5FcCZLY2mrF8MiHYPtoFgNPKBujK19Qr3blQoF2et5sQ5JUIGN66b
         AJ6h+c9IWdnh7f7qpgJyHiT4jsaJZpgh1iESgekZK8FRGSFGUpuiD+ATWrY5K2wgcIVW
         s+I7Lptsg5Vk+YQhFZ1DI/4QWQBtj8bgCieLSpYiUiHlXiunzFhYQZNms2+s14AWmn/U
         VzeDtwhUVI+SbSfI+6euSuKdMIz2SeCg/0Mg7BiAezWCo+NYt5UQVs6PsEjDswDiEACF
         VRZBSq9CLMgAWZbVCC523+Iqg+T0WNSqS7/UmyuQdy0JRFNP059ldQB5WPsT8OUERj3H
         ZKJg==
X-Gm-Message-State: AOAM5307V0tSMjtjJirUclElu9JKHHB9fmuEd8kJVrl3dgLNGh40qT1h
        kSCqWpu+0r1IRBKer4KF+0bFG6HMrNgoPLZMh2Jqwg==
X-Google-Smtp-Source: ABdhPJzkZnpQTV5Qp77PgEJ34HsJPqCmVi+ZOVVGOe/uHLDMUs6H/ZfgHJrleyk4/1QDC55+WeC+DLC/a9G2zdhlXUE=
X-Received: by 2002:a25:c006:: with SMTP id c6mr16530910ybf.480.1633888161709;
 Sun, 10 Oct 2021 10:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <1633777076-17256-1-git-send-email-yangtiezhu@loongson.cn> <1633777076-17256-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1633777076-17256-2-git-send-email-yangtiezhu@loongson.cn>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Sun, 10 Oct 2021 19:49:11 +0200
Message-ID: <CAM1=_QT_vR5EZyt6kVVWHJi3rpervkiO4HRrpvRgh2sh6J7yrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, mips: Clean up config options about JIT
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 12:58 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> The config options MIPS_CBPF_JIT and MIPS_EBPF_JIT are useless, remove
> them in arch/mips/Kconfig, and then modify arch/mips/net/Makefile.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/Kconfig      | 9 ---------
>  arch/mips/net/Makefile | 6 +++---
>  2 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 38468f4..9b03c78 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1214,15 +1214,6 @@ config SYS_SUPPORTS_RELOCATABLE
>           The platform must provide plat_get_fdt() if it selects CONFIG_USE_OF
>           to allow access to command line and entropy sources.
>
> -config MIPS_CBPF_JIT
> -       def_bool y
> -       depends on BPF_JIT && HAVE_CBPF_JIT
> -
> -config MIPS_EBPF_JIT
> -       def_bool y
> -       depends on BPF_JIT && HAVE_EBPF_JIT
> -
> -
>  #
>  # Endianness selection.  Sufficiently obscure so many users don't know what to
>  # answer,so we try hard to limit the available choices.  Also the use of a
> diff --git a/arch/mips/net/Makefile b/arch/mips/net/Makefile
> index 95e8267..e3e6ae6 100644
> --- a/arch/mips/net/Makefile
> +++ b/arch/mips/net/Makefile
> @@ -1,10 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # MIPS networking code
>
> -obj-$(CONFIG_MIPS_EBPF_JIT) += bpf_jit_comp.o
> +obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
>
>  ifeq ($(CONFIG_32BIT),y)
> -        obj-$(CONFIG_MIPS_EBPF_JIT) += bpf_jit_comp32.o
> +        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
>  else
> -        obj-$(CONFIG_MIPS_EBPF_JIT) += bpf_jit_comp64.o
> +        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
>  endif
> --
> 2.1.0
>

Looks good to me.

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
