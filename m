Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6DD3F0725
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhHROxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:53:22 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:39310 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbhHROxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:53:21 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 17IEqL1F025131
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:52:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 17IEqL1F025131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629298342;
        bh=4xBGs3s+HePiP6vkus0TyPzdPu7uR7OKLc02dzXS7u4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lZGGxLUUHrhtHkZPTAUqet0YfI41L3F/zspbG7DFSHrljmdSAG7P9lZOZB6Y6tnUf
         wM7diSdV44gB4K9kzHBnRzDqIPOB4pazeIPRzm/X3P8WYnPQZn3uJ8oXwlTcjSaUFa
         dJ5HRMYc9e2VwfdhtQGrzK+YMXOOGN97ttRA9IIH//f33MtOzZ5ZFsr1xywScWoPjs
         KeH+CQcl2MV75Fv6RbRimZMtAgP7nsjzxOpo0/PZWTkKo1vWi7X8xmH7Ween6Ps60q
         BcPFr0XeIIoqB13ZpWfmMEV933cslp6LEHBo0x49GfLaRWHaJB6KD3aHdYKq8SyIYX
         oJAzshsiaS/4w==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id bo18so2851498pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:52:21 -0700 (PDT)
X-Gm-Message-State: AOAM531GkxjWHErFrtQvDMXKgxbr4xlJXWognx2ouuBPFH9vaMWPamyH
        sFuPhMyzz6cccTn/vjczZzXy6t0Rah/AZTVd2Us=
X-Google-Smtp-Source: ABdhPJwCI4esRQd0Q2sKZc8wzvn5zqM3bZ2TDGOQB8jCKcQcgn336SWMhx33PcRV1FZPFXN1xhmgmSYgYJzkymCNE1Q=
X-Received: by 2002:a17:90a:7384:: with SMTP id j4mr9455656pjg.153.1629298340800;
 Wed, 18 Aug 2021 07:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <269701460.117528.1629210189833@office.mailbox.org>
In-Reply-To: <269701460.117528.1629210189833@office.mailbox.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 18 Aug 2021 23:51:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQh6kM3k4=UP9R1HQ5+QWzRZZ1Cse_nWv8nOOSkJ93wQ@mail.gmail.com>
Message-ID: <CAK7LNAQQh6kM3k4=UP9R1HQ5+QWzRZZ1Cse_nWv8nOOSkJ93wQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86, Makefile: Move the CPU-specific 64-bit tuning
 settings to arch/x86/Makefile.cpu
To:     Tor Vic <torvic9@mailbox.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23 PM torvic9 via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> In accordance with the FIXME comment in arch/x86/Makefile, move the
> CPU-specific 64-bit tuning settings to arch/x86/Makefile.cpu.
>
> Signed-off-by: Tor Vic <torvic9@mailbox.org>
> ---
>  arch/x86/Makefile     | 11 ++---------
>  arch/x86/Makefile.cpu | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 9 deletions(-)
>  create mode 100644 arch/x86/Makefile.cpu
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 307fd0000a83..94105d7ad22c 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -119,15 +119,8 @@ else
>         # Use -mskip-rax-setup if supported.
>         KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
>
> -        # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
> -        cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
> -        cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
> -
> -        cflags-$(CONFIG_MCORE2) += \
> -                $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
> -       cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
> -               $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
> -        cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
> +        # CPU-specific tuning (64-bit).
> +        include arch/x86/Makefile.cpu




See
https://patchwork.kernel.org/project/linux-kbuild/patch/20210724183556.76680-1-masahiroy@kernel.org/





>          KBUILD_CFLAGS += $(cflags-y)
>
>          KBUILD_CFLAGS += -mno-red-zone
> diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
> new file mode 100644
> index 000000000000..fb407ae94d90
> --- /dev/null
> +++ b/arch/x86/Makefile.cpu
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# CPU tuning section (64-bit) - shared with UML.
> +# Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
> +
> +cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
> +cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
> +
> +cflags-$(CONFIG_MCORE2) += \
> +       $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
> +cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
> +       $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
> +cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
> --
> 2.32.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/269701460.117528.1629210189833%40office.mailbox.org.



-- 
Best Regards
Masahiro Yamada
