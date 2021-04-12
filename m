Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8715135B7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhDLBJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbhDLBJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:09:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9579AC06138C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 18:09:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cu16so3747695pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 18:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HPxg5JSgOsrOfTmvP3UDKjG3tm7XrRd5oWLPunngUEc=;
        b=sBa6N1X77FArEiHJP7AorZoNOGY8WZi+cW3Z1YuxkJVRXbFD68A86GDaI0bDNOzGj9
         /6Re15e/JfsCr6ttGzDD0HtYiWOQ/XLuBum81cyWucslVyIgnArWQbsZ1aqtJEB/NgxB
         EeJK1aog2kaOitpm4TaaOzkidN4HycJj/UCNBUigOlnVbxhja8sih6FtEBXTQBCIpYQQ
         qMDEQT5L3gQyql0eIhp74ngVXSRTSy4Ls6O7y5UFUR/RP3XCH77aa0iWE0ZhdY1yWeV0
         tHq1ganMvkNdiEfX+mgWQNH72tEv53Jw1E6ing7qMqB2D5lv3J+DMTUIsFjK3lrNPfsx
         RDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HPxg5JSgOsrOfTmvP3UDKjG3tm7XrRd5oWLPunngUEc=;
        b=f2Dq3LhVgXyu+XOxpa1qnwmeIMhJpaqFM4F/YPoPcus4KeCBnToPEX5TYzXV/0eeRs
         nqrzt2V7F8jCgEgMh9PDZGbDLDtFZmYJHKp2kxUwny2ALP/k6jvB6yPBZi6Sfw+klf0P
         oRz/EDXKnHJQcSrANWRb3dArGyN/rJXig9ySxA7khygsIXpvlnsJGl46I/uHM0yDMTln
         L7/+vnjP4qb6QVt58FeHeugdfIvBxMasVPiBQTo3duPF02nD6wO/0hj0r03grnkBh7+D
         zyGEklsJjc2kFfav0L3goyrVT0WxB84BIslyHeIivIRWi9mQ4isEMSxZMn/SfKrnC2Ke
         ZAbg==
X-Gm-Message-State: AOAM531cb9It6CtmNnNfUES9GNZKVjslaP3IcF4FjoOO/WY5sVM69BBw
        rmvqMiZ51yr1WvtmS6K1Ai1caw==
X-Google-Smtp-Source: ABdhPJyyy2bH9fp122etCL1m7vyy654HUV5AqMoCtOX1TBeYgBkF/YBr59h9BQXdOQ80oEkGZ6uzOQ==
X-Received: by 2002:a17:90a:3902:: with SMTP id y2mr26519541pjb.202.1618189749186;
        Sun, 11 Apr 2021 18:09:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g14sm3223291pjh.28.2021.04.11.18.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 18:09:08 -0700 (PDT)
Date:   Sun, 11 Apr 2021 18:09:08 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Apr 2021 18:08:08 PDT (-0700)
Subject:     Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT exception
In-Reply-To: <20210330021624.2b776386@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        guoren@linux.alibaba.com, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-658942ec-8ce7-42d7-87bf-79deb0d0989b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 11:16:24 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Current riscv's kprobe handlers are run with both preemption and
> interrupt enabled, this violates kprobe requirements. Fix this issue
> by keeping interrupts disabled for BREAKPOINT exception.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/entry.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 744f3209c48d..4114b65698ec 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -130,6 +130,8 @@ skip_context_tracking:
>  	 */
>  	andi t0, s1, SR_PIE
>  	beqz t0, 1f
> +	li t0, EXC_BREAKPOINT
> +	beq s4, t0, 1f
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	call trace_hardirqs_on
>  #endif

This is on fixes, with a comment as otherwise I'm just going to forget 
why.
