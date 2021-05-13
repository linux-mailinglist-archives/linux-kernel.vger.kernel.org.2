Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7337F387
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhEMHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhEMHY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:24:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122C0C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 00:23:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x8so3669073wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d/xMPZN/gkmLGfGxs7msx2GU38JzvKK2WFczkjQZpiI=;
        b=dB0fAMfFuQVGYCrgNpX+RwED0/vQye1LAK4k6YNq5K723Hbb1ds0TCT6alwocBwcAq
         3PEmJaJ6ca3+Wue+somAn6R0+N0/1t7Uk7bElSGYy6+ZdhKLWUv1XhoqvpCE1CcNbkyV
         hhH0XyghKV4mCvtqGAWOyFAUcpFwIvsGyroiaBb2RaAk2yDi614+1xdus2eOTV2xoQqZ
         vxqsyBCXlVCu/9NSha3CbL5V2woXsN+VaMkVItithBIlhsiFRkdE2dFm/R/2O42f28cj
         3e/GVke6prmVv8tjyEJpwL1p8NR1vmn4xu0HCsxVM1vNwDwRJ+HooyW88VHLgleRuz7D
         JepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/xMPZN/gkmLGfGxs7msx2GU38JzvKK2WFczkjQZpiI=;
        b=nBCeTAipG73tkBtVPyx2Sf6bwJ6FPVFcIbeGLAW0iWE1QWI52WQHs6fzXzgvf+JwkW
         WPeSAUrrUaB9loGWctNeocuE7EbOtgEtCp6LQqDtpSEIueKvd7vsy66MEj6aQ+SyLJ/L
         R1kpPyYHY3vYTXdn7EuxJawPC4tKer7vwQWYQnlf+UzOxvKtGyiF75YTCpQFLwYCgLC8
         FDM/0lEZlmmCTsIseV+ouxTzEhFh845HR2Pf+aoT5g8wcEKupXrFqujm8nQmRannM+3N
         kJj6eN6sTirPcedUqh/FViyFTefqYnfi5sxdkfD5H5BsvifMs+op8tgSzeg/SResKIJI
         3ArQ==
X-Gm-Message-State: AOAM532gaz+ZD3FwUSk6twAiNOuUvF4vfc7bnSoZaCdkdWY9Ll2fB6iw
        Ta5XgmP134NbJ5zl2bvoug==
X-Google-Smtp-Source: ABdhPJwZCf98tsoyYoYqUPuhoStuVW7xWIO7jN8+/hTfY08peaZXJ4st+ZfCRPDEEWUqWBomORbaog==
X-Received: by 2002:adf:e3c6:: with SMTP id k6mr50347217wrm.236.1620890626749;
        Thu, 13 May 2021 00:23:46 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.101])
        by smtp.gmail.com with ESMTPSA id i11sm1932816wrp.56.2021.05.13.00.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 00:23:46 -0700 (PDT)
Date:   Thu, 13 May 2021 10:23:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/4] sched: make nr_running() return 32-bit
Message-ID: <YJzUAHQwFj1x2HCH@localhost.localdomain>
References: <20210422200228.1423391-1-adobriyan@gmail.com>
 <87fsyr5wtj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fsyr5wtj.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:58:16AM +0200, Thomas Gleixner wrote:
> Alexey,
> 
> On Thu, Apr 22 2021 at 23:02, Alexey Dobriyan wrote:
> > Creating 2**32 tasks is impossible due to futex pid limits and wasteful
> > anyway. Nobody has done it.
> >
> 
> this whole pile lacks useful numbers. What's the actual benefit of that
> churn?

The long term goal is to use 32-bit data more. People will see it in
core kernel and copy everywhere elase.

> Just with the default config for one of my reference machines:
> 
>    text		data	bss	dec	 hex	 filename
> 16679864	6627950	1671296	24979110 17d26a6 ../build/vmlinux-before
> 16679894	6627950	1671296	24979140 17d26c4 ../build/vmlinux-after
> ------------------------------------------------------------------------
>      +30
> 
> I'm truly impressed by the massive savings of this change and I'm even
> more impressed by the justification:
> 
> > Bring nr_running() into 32-bit world to save on REX prefixes.

I collected numbers initially but then stopped because noone cared and
they can be config and arch dependent.

> Aside of the obvious useless churn,

oh... Sometimes I think churn is the whole point.

> REX prefixes are universaly true for
> all architectures, right? There is a world outside x86 ...

In general, 32-bitness is preferred for code generation.

32-bit RISCs naturally prefers 32-bit.

64-bit RISCs don't care because they remember 32-bit roots and
have necessary 32-bit fixed width(!) instructions.

x86_64 is the only arch where going 64-bit generally adds more bytes
to the instruction stream.

Effects can be smudged by compilers of course, in this case, percpu
stuff. That "unsigned int i" is a mistake. Proper diff looks like this:

	-ffffffff811115fa: 8b 44 18 04      mov    eax,DWORD PTR [rax+rbx*1+0x4]
	-ffffffff811115fe: 49 01 c4         add    r12,rax
	+ffffffff811115fa: 44 03 64 18 04   add    r12d,DWORD PTR [rax+rbx*1+0x4]

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4348,9 +4348,10 @@ context_switch(struct rq *rq, struct task_struct *prev,
  * externally visible scheduler statistics: current number of runnable
  * threads, total number of context switches performed since bootup.
  */
-unsigned long nr_running(void)
+unsigned int nr_running(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int sum = 0;
+	unsigned long i;
 
 	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_running;
