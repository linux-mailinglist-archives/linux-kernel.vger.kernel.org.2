Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07056348ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCYLT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhCYLTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F103E619FF;
        Thu, 25 Mar 2021 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616671150;
        bh=nysmEFoQvfZJpXJDhFl1t8gREBvdDsBQeGwZ5Fr7Sfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUP0vGjS6eAYCUWV22U2DHpibo7T3P+WA9r2cD/D9f6HY64X4hqf2VZhdF5VNYi93
         lceYNxkNOzmNTdAdHcg2aTEOBwqcn54lWSAoT893/0EBLPf6wUMLjWxzOnalVmOitf
         0Dt08J6El/F5FbEJSv209cggxhcqZ8MECMuwJKHkXReiXTlPLTWPjnJmi6PU/BoDNU
         pme9wE26aJrkIzaPcIQvZZYCRnDwfuYwDQ9B1GM39a7qNm3SyDqOn+mShXG06sbGKc
         XlJr8SyyNQvgZup4AEgINMNftE6dltfJ36oShVVW4tblnZEONMrusu8SHfoJdY2zHc
         umcm7tkLNqm6w==
From:   Will Deacon <will@kernel.org>
To:     samitolvanen@google.com, amit.kachhap@arm.com,
        keescook@chromium.org, mark.rutland@arm.com, 0x7f454c46@gmail.com,
        Maninder Singh <maninder1.s@samsung.com>,
        catalin.marinas@arm.com, akpm@linux-foundation.org, pcc@google.com,
        james.morse@arm.com, vincenzo.frascino@arm.com,
        nsaenzjulienne@suse.de
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        a.sahrawat@samsung.com
Subject: Re: (subset) [PATCH 1/2] arm64/process.c: fix Wmissing-prototypes build warnings
Date:   Thu, 25 Mar 2021 11:19:03 +0000
Message-Id: <161666581740.223087.673529524234867266.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616568899-986-1-git-send-email-maninder1.s@samsung.com>
References: <CGME20210324065511epcas5p1cb74119660e2d98a381ae69d01b29275@epcas5p1.samsung.com> <1616568899-986-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 12:24:58 +0530, Maninder Singh wrote:
> function protypes are missed before defination, which
> leads to compilation warning with "-Wmissing-prototypes"
> flag.
> 
> https://lkml.org/lkml/2021/3/19/840
> 
> arch/arm64/kernel/process.c:261:6: warning: no previous prototype for '__show_regs' [-Wmissing-prototypes]
>     261 | void __show_regs(struct pt_regs *regs)
>         |      ^~~~~~~~~~~
> arch/arm64/kernel/process.c:307:6: warning: no previous prototype for '__show_regs_alloc_free' [-Wmissing-prototypes]
>     307 | void __show_regs_alloc_free(struct pt_regs *regs)
>         |      ^~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kernel/process.c:365:5: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
>    365 | int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>         |     ^~~~~~~~~~~~~~~~~~~~
> arch/arm64/kernel/process.c:546:41: warning: no previous prototype for '__switch_to' [-Wmissing-prototypes]
>    546 | __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
>         |                                         ^~~~~~~~~~~
> arch/arm64/kernel/process.c:710:25: warning: no previous prototype for 'arm64_preempt_schedule_irq' [-Wmissing-prototypes]
>    710 | asmlinkage void __sched arm64_preempt_schedule_irq(void)
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~

Applied first patch ONLY to arm64 (for-next/fixes), thanks!

[1/2] arm64/process.c: fix Wmissing-prototypes build warnings
      https://git.kernel.org/arm64/c/baa96377bc7b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
