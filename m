Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5235B739
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 00:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhDKW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhDKW24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 18:28:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31585C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 15:28:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g35so7878116pgg.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=NL103HsN0FLtSC0bDkk0cKVEMZDZXWVDk3KCjvpyLsg=;
        b=JRntyPFBVIaenW3MYt0SEjXz8mFFPhPnj1KcZs2ugZaRP5y8k+W1stlu/6fVvKvx3m
         WZbR/L/phUEhsex1JyC/00jlyufHtgnn51gPrCh81724AK/uuIYW3WlgoYXT9Dv0U5L6
         Y7Y2Q94KJA/fzaHWtE//AinMUjRweE2F55l079/XaLJT/L0oBtBY4e4SmWUktf8DD4U0
         EnmtwdmWsAk2e0/JfDqu62TB3toJRz0Z6Z4nyEya7AQiYjt4nykVqwkOFc9VryhXjpHa
         ad6txIJwmpSe3Z5CazDQzGOlsaVXPelugZxzu+xP5ngEgRvWnicbI1XUK+5V/+wnYwDU
         so4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=NL103HsN0FLtSC0bDkk0cKVEMZDZXWVDk3KCjvpyLsg=;
        b=jevGM8adI400GLF3p0hxmX5HKqN+3VboXKRdmC8ymbHxgoytTS2ED80wzcnd5DQ7xG
         sPq2fdWNl1u22KSiu/WXR6hCnRUrOpMZ084udG8QoUWeozxp/7p7u9ozxsJALs/Ej7PF
         VYxTV4o4sg81bEl7zK84N2AaqBgAIHetFzfiz5QlkvdQarR2+2zx/FSrwPuLW5OUOnJC
         DKDFvLDCAMkGpKGX+drMyRphpI3ZrOcsdYPFScMEfVUgUc6txYAq2KU7hUSaIhGR+A5r
         Mieb6+ap+gNvZ1VwXq8WpyZIw5zvPvW0pVqJy85+bjjNcj6s4c2SWK3+Pef/0bVTmBoo
         BGTg==
X-Gm-Message-State: AOAM533erzuJrENscs1HNKztChHClmqsQEOUekSQgs7E0ihzm7wdLcf5
        iVFYkUSyaCTHj/76yrYqFPJpuA==
X-Google-Smtp-Source: ABdhPJwh75ar/j8paxM9YzIOWuxm/rCiYRHozOlQyZ1WOu9vu4T0wL6pxR+AUFRP+0FiIpZwfqa30Q==
X-Received: by 2002:a65:5849:: with SMTP id s9mr24542845pgr.309.1618180118609;
        Sun, 11 Apr 2021 15:28:38 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y193sm8307600pfc.72.2021.04.11.15.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 15:28:38 -0700 (PDT)
Date:   Sun, 11 Apr 2021 15:28:38 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Apr 2021 15:28:36 PDT (-0700)
Subject:     Re: [PATCH] samples/kprobes: Add riscv support
In-Reply-To: <20210330020416.129505e6@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        corbet@lwn.net, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-8e3addbd-903d-43ee-b16b-e81919583271@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 11:04:16 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Add riscv specific info dump in both handler_pre() and handler_post().
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  samples/kprobes/kprobe_example.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index 331dcf151532..c495664c0a9b 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -47,6 +47,10 @@ static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
>  	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, cpsr = 0x%lx\n",
>  		p->symbol_name, p->addr, (long)regs->ARM_pc, (long)regs->ARM_cpsr);
>  #endif
> +#ifdef CONFIG_RISCV
> +	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
> +		p->symbol_name, p->addr, regs->epc, regs->status);
> +#endif
>  #ifdef CONFIG_S390
>  	pr_info("<%s> pre_handler: p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->psw.addr, regs->flags);
> @@ -80,6 +84,10 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>  	pr_info("<%s> post_handler: p->addr = 0x%p, cpsr = 0x%lx\n",
>  		p->symbol_name, p->addr, (long)regs->ARM_cpsr);
>  #endif
> +#ifdef CONFIG_RISCV
> +	pr_info("<%s> post_handler: p->addr = 0x%p, status = 0x%lx\n",
> +		p->symbol_name, p->addr, regs->status);
> +#endif
>  #ifdef CONFIG_S390
>  	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->flags);

Thanks, this is on for-next.
