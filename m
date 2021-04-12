Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994DB35B7E3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhDLBJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhDLBJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:09:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66439C06138C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 18:09:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k8so8116880pgf.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 18:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZVBss4/3ekyTIH1ouL6bPm/k9eU1VUeYjR3azQV62c=;
        b=IR66+KeOkOLdyMnM8msMSje5sU5MC4MAptc+qLv1U0FVQkWXZ5CwCbZTzw/SGQ0TQl
         VRG0fiNF/WE/jeQMCB1iHovSPHVGM4EUNfxT0LamN+u8UI2Bq2bC7fl8CVr9mEB5TK1s
         HAwcsrApxvPFHZfz2kmxyRIhYt2n+1Y54tAgZ/NQavuhlSYkz+cehErZX9n/xOelLV68
         hH4ivaoWIU6vndS/ie6lTsoFRrmPtnAglDNcI4ihHW37dRqYc0CSjf2ZOfoQXCr7F0Fl
         7oshUaU3Nyks87TFq4NoU1P1cR99bzYtKXtv8/1DFUwpEKbUySmcydCoGPnkaPEySGhO
         N+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8ZVBss4/3ekyTIH1ouL6bPm/k9eU1VUeYjR3azQV62c=;
        b=Hs025bpLRcJLRwI9ArSDEB8H8h3du/UOSBkoEOExAzgqe7WAFhjvM8zPeU2XFrosp5
         Hen+VR+X4MJaOzJnL1/k7WA7K/0Us96uV5HKfbaO987YjcBf/rTt3pXWcoN6/MJXPQ8K
         m+W9g9C9AeVE3CdpYn+1yvhYUyWp2WXb+BIGO4llph2qXn4lO4+pMfpG2AoyP/eMveb4
         cVYp8nxgBOrvaulVDKn7FHgyXseglUfANyHZfaCbkc11wKQQN1b9rN6mGrGQUZLcrRWE
         3Uy246lBoBE6QZL1Ml6kwwMBJJHH5VoKVAGEDoTAUPA35lEcP8z2tFRiHlWx/HjGKho9
         4SRA==
X-Gm-Message-State: AOAM5300JIJGMxxvntcfM3tBpaGiQLkaCQOQZY1uDzLI1LUJOCAZcI/D
        4YR2Jph4NWboqC2kdk2LTEWS9g==
X-Google-Smtp-Source: ABdhPJwvJHzqk4ALT52DIaXKxdmhHchtsvItXuCmZ4JAOIMAyWpEbTACKByV3SSo9Ep60xmLezqsFg==
X-Received: by 2002:a62:2943:0:b029:24b:f35d:2565 with SMTP id p64-20020a6229430000b029024bf35d2565mr4211322pfp.52.1618189747978;
        Sun, 11 Apr 2021 18:09:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l25sm10052449pgu.72.2021.04.11.18.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 18:09:07 -0700 (PDT)
Date:   Sun, 11 Apr 2021 18:09:07 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Apr 2021 17:44:48 PDT (-0700)
Subject:     Re: [PATCH] riscv: kprobes/ftrace: Add recursion protection to the ftrace callback
In-Reply-To: <20210330021440.44280b7f@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, rostedt@goodmis.org, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-b1f80b4e-5e45-4ad0-8a80-1f0d8522e4dc@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 11:14:40 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Currently, the riscv's kprobes(powerred by ftrace) handler is
> preemptible. Futher check indicates we miss something similar as the
> commit c536aa1c5b17 ("kprobes/ftrace: Add recursion protection to the
> ftrace callback"), so do similar modifications as the commit does.
>
> Fixes: 829adda597fe ("riscv: Add KPROBES_ON_FTRACE supported")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/probes/ftrace.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
> index 17ca5e923bb0..aab85a82f419 100644
> --- a/arch/riscv/kernel/probes/ftrace.c
> +++ b/arch/riscv/kernel/probes/ftrace.c
> @@ -9,10 +9,16 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	struct kprobe *p;
>  	struct pt_regs *regs;
>  	struct kprobe_ctlblk *kcb;
> +	int bit;
>
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0)
> +		return;
> +
> +	preempt_disable_notrace();
>  	p = get_kprobe((kprobe_opcode_t *)ip);
>  	if (unlikely(!p) || kprobe_disabled(p))
> -		return;
> +		goto out;
>
>  	regs = ftrace_get_regs(fregs);
>  	kcb = get_kprobe_ctlblk();
> @@ -45,6 +51,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  		 */
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
> +out:
> +	preempt_enable_notrace();
> +	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);

Thanks, this is on fixes.
