Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DF394E37
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhE2VLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 17:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhE2VLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 17:11:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85320C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 14:09:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k22-20020a17090aef16b0290163512accedso195126pjz.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rnn+IDCEsDQ25SwgXB0vROKvgVGkyNLlJmZoTTAxvuo=;
        b=ibRtK9S0207hZoE19mkys3fz/PjntSlAuyWW77pHju6/AM7gC2u32QvV0SA0D2Om+j
         U0FgEsLX/WesFWD87GV7I5o9IBS50BFVZDmW62WSTtjTxxh9QZbmoL7OgEJFS4bjYoWw
         2hOaQX5EuGbvmfHy62iT9eAPVkeOWz+NxGNUwQbN8jN0LfY6oC0pJOV4F336w3tOIkcA
         rv3gVjeEJQVEP+8rANcn3wEL5q6iGBTykiAgoYOKxivxBU2Ic7sd3tgM19QOB5ZQnaba
         t5nGgxSsJ48lOjCajmcuJZEGuEw8RFRrLoBkd8LQd18k9O2FXWakwqxEzGsBbste6QHo
         Avrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rnn+IDCEsDQ25SwgXB0vROKvgVGkyNLlJmZoTTAxvuo=;
        b=KpTW7zJajHt7i343kJKPRJzJBh2BRGecKnwTKA/cfuikaj9Lb7AYghYuUB8Ou2VuQS
         UzlcySyRO5i6mofM3CQdz9CSgXF6vTqN4qu77eOWWcecKb7JkTk+HtXp4o9yf81/ukds
         3fU0OIZbF4MCnRRv7wciO0lV90+ChkGc0KrV5YtnoCTRLEk5MhZmSuehXwDU6fE8hf5D
         GntnOG0YttpPJuirXC2Oj7Ohy8jRZDhjDRCRmEhipTa215bl/5O4SmH8Kv6s4rsXX4/1
         /4ac671aJ9UEzxAtSYX2FDgFVT6I8XMqcYaIMDKpI6cJbp5s53CUXJSqe12AT/HqgCZV
         0xcw==
X-Gm-Message-State: AOAM533CdAp4nX66vOBxShTJcWGvn9sDeICJzqX0PMMH0a6kuo/duqGy
        B14gh+HshRApMD6jXKTjRVBA7g==
X-Google-Smtp-Source: ABdhPJxuQEeCxsOobD1eRLVatbSbAdA4RG2xlwkhznzOxBL+vK6qltN/wCGjH0HAK1aRRDn+N4wcyg==
X-Received: by 2002:a17:902:bcc7:b029:ed:6f73:ffc4 with SMTP id o7-20020a170902bcc7b02900ed6f73ffc4mr13672583pls.1.1622322564565;
        Sat, 29 May 2021 14:09:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h1sm7191398pfh.72.2021.05.29.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 14:09:23 -0700 (PDT)
Date:   Sat, 29 May 2021 14:09:23 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 13:39:41 PDT (-0700)
Subject:     Re: [PATCH] riscv: Add __init section marker to some functions again
In-Reply-To: <20210516205942.4671f4e6@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-ed3b99bd-e31b-4fa1-b147-26cce86942aa@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2021 05:59:42 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> These functions are not needed after booting, so mark them as __init
> to move them to the __init section.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  arch/riscv/mm/context.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index a2848dc36927..d959d207a40d 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -59,7 +59,7 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
>  }
>  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
>
> -void riscv_fill_hwcap(void)
> +void __init riscv_fill_hwcap(void)
>  {
>  	struct device_node *node;
>  	const char *isa;
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 6d445f2888ec..63dc0b9bd8aa 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -213,7 +213,7 @@ static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
>  		set_mm_noasid(mm);
>  }
>
> -static int asids_init(void)
> +static int __init asids_init(void)
>  {
>  	unsigned long old;

Thanks, this is on for-next.
