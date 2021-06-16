Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF13AA2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhFPRy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:54:27 -0400
Received: from mail.efficios.com ([167.114.26.124]:52058 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:54:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E22C434A83B;
        Wed, 16 Jun 2021 13:52:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9ZYE4D70ELzT; Wed, 16 Jun 2021 13:52:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 67C0B34A83A;
        Wed, 16 Jun 2021 13:52:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 67C0B34A83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1623865938;
        bh=4Pql156OANcBAMgk+nu7NzfwOJ207oQZemvg3h8Ppcw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XliKh7qEgz1tjdc+X0m8DH60/LgoWT3zYRHvbWVq/EezHiYRVFhFcJnxW2OL2/Yxy
         CjWtHq2tBuEv7Y5vLTda2YQnYw2qRfYAtXwwI0kHjwSnfgEFARo7mCMIViaJaizIoG
         3Bs2vIQR5JXlVnVeXqR3ZQHfMTOe//45C02h8Tj+9IpIspbOqGdthl2y3ZtU/9/5xF
         Y/004qg8YKTc/3qIxWdLwz41GxgV1NpCzCjBGjAp3EWUOOH8i0PqbkPpVvkO5iGpkf
         GJSQLGd8cQ0p2jt/nb0vvuGSHSq6Kpiu5CtmrGGIwYdplMay37q9T34VpQZZVkY+yP
         YEuyHEKOwGC1g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l8S-TV0E36aw; Wed, 16 Jun 2021 13:52:18 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 57CBB34AA02;
        Wed, 16 Jun 2021 13:52:18 -0400 (EDT)
Date:   Wed, 16 Jun 2021 13:52:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86 <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1990263287.9043.1623865938326.JavaMail.zimbra@efficios.com>
In-Reply-To: <2d45c55c4fbbe38317ff625e2a2158b6fbe0dc2d.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org> <2d45c55c4fbbe38317ff625e2a2158b6fbe0dc2d.1623813516.git.luto@kernel.org>
Subject: Re: [PATCH 3/8] membarrier: Remove membarrier_arch_switch_mm()
 prototype in core code
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4026)
Thread-Topic: membarrier: Remove membarrier_arch_switch_mm() prototype in core code
Thread-Index: po3kb64XWToyumkqJkr6VhDu+QTKbw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 15, 2021, at 11:21 PM, Andy Lutomirski luto@kernel.org wrote:

> membarrier_arch_switch_mm()'s sole implementation and caller are in
> arch/powerpc.  Having a fallback implementation in include/linux is
> confusing -- remove it.
> 
> It's still mentioned in a comment, but a subsequent patch will remove
> it.
> 

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> include/linux/sched/mm.h | 7 -------
> 1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 24d97d1b6252..10aace21d25e 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -350,13 +350,6 @@ extern void membarrier_exec_mmap(struct mm_struct *mm);
> extern void membarrier_update_current_mm(struct mm_struct *next_mm);
> 
> #else
> -#ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
> -static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
> -					     struct mm_struct *next,
> -					     struct task_struct *tsk)
> -{
> -}
> -#endif
> static inline void membarrier_exec_mmap(struct mm_struct *mm)
> {
> }
> --
> 2.31.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
