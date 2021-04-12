Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FDD35B7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhDLBJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbhDLBJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:09:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A36C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 18:09:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso6164486pje.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=H0g+omOZRisVxOUCibASZBPuFW5oO6sfiDj+exX2xb8=;
        b=QJKFUkch8Spoy4s9wnEGAx0YrpcEpV64JASS356NZi9pczejxlp7M1g+XZ32G8+c8i
         wnHFYd93yMA7dXnTzY0wQUOu/qiAFFBkUBXHJfOglrZeeizgg419wphgscbmtxfwr9dS
         EDsL0wPGZu/WxO3qw3vbTb2ez9xdEwfiV0IbVOMB7YNdd0sUtVLVqugDtrP4bErJqHLh
         4hGCYpinVOuk9NSDFJweiFYZAbXA37YHdMeBud1NwVmj2S7EQHUe+pJ8r80C3BwVm8h1
         Wqskp+vm5aXgWBlK+5Odymy5gEKsQThYbX8KARX7OUSp5y4hfDiC+g/2ZKiBl8zlowDu
         5EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=H0g+omOZRisVxOUCibASZBPuFW5oO6sfiDj+exX2xb8=;
        b=GMKp5RB+Qz7inPT4kL92gc3yFfXnsche8U7dI7FiUq+HE4Cpr1zm+wuqEkMOxqyMdl
         xwF3uLawqmNDTHxebZDcuKO2FZ2/NUQnkc2UHt0K0Ws9bBllTNodgbVynFmn1Ad4mLo4
         urOGAgRNycgaSLK6VAKmEJJCSE2yLjTRgphNblYyiHnSBoZkKzqnoYryH666kVdNv5yi
         +0jvj6LNb4NzmGt7VUIB/5PRsZSNsKS//NayKqZmiaBNs4ObQhg5ajA9bl/bqyPT9MMN
         h3YWcTqrtIoBFzrCkZijmPiZCOrUe3U94T15i5u8FxJJPhwn4dir+wk/Uf7LWuxP2MSj
         AwlQ==
X-Gm-Message-State: AOAM532DYi+2cHW7SJWJD0EjpFEEuaecN9d2YgTZAU2cmcz20WSAS7Lo
        sptipKEZXP04eO9xg1AXnG+h/g==
X-Google-Smtp-Source: ABdhPJwvuSL0mkG9IZzcdprvLrtsE1aVfrEWlk2Lz1Skb6+IGoNfACxrBt5na7A3HahfIdueYHTclw==
X-Received: by 2002:a17:90a:990a:: with SMTP id b10mr25844340pjp.178.1618189747014;
        Sun, 11 Apr 2021 18:09:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e1sm9385380pgl.25.2021.04.11.18.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 18:09:06 -0700 (PDT)
Date:   Sun, 11 Apr 2021 18:09:06 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Apr 2021 17:38:25 PDT (-0700)
Subject:     Re: [PATCH] riscv: add do_page_fault and do_trap_break into the kprobes blacklist
In-Reply-To: <20210330021226.2fc7b2ec@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-91078457-1fd6-425a-a7d8-d18be7088cea@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 11:12:26 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> These two functions are used to implement the kprobes feature so they
> can't be kprobed.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/traps.c | 1 +
>  arch/riscv/mm/fault.c     | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 0879b5df11b9..1357abf79570 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -178,6 +178,7 @@ asmlinkage __visible void do_trap_break(struct pt_regs *regs)
>  	else
>  		die(regs, "Kernel BUG");
>  }
> +NOKPROBE_SYMBOL(do_trap_break);
>
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long pc)
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 8f17519208c7..c5dbd55cbf7c 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -328,3 +328,4 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	}
>  	return;
>  }
> +NOKPROBE_SYMBOL(do_page_fault);

Thanks, this is on fixes.
