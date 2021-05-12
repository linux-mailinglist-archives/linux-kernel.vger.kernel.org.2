Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45D637BB64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhELLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhELLB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:01:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF2FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+2JqDURQ4NfYeJG41cbfu5+yywBSW9JE5vYZt2sYJm8=; b=gY2AFbr23XMuHDYQfvAsDNHHIJ
        1wwg00mKczf72UDNWCKzlr+2UttqeaQciFFEHXEEcdAEOorpg/uSU4szstKBYs40mc8UH3bxR7nNo
        GCK/c+AG7eaAa1oXowuc+glaDe7ntBl80J8ko61DOGABbRup6JzFbYWXd/NGJ1SC7myj+QD22wSnO
        4IdeufEWe9fYTgKGiWk9E/DBRhqlgp8jzAoxcTL+2heD238cJSrgrNQMu0LEkw5EIYy+oKiMJiMaQ
        v2NOPkv3KWodz3p11R7R2sQC2iefo+HENV+w018Jt/TCY3zXwdPEd2uaAkCJIw/OvCnim/2p1R2Hi
        fZrq6Eiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgmb1-008CXB-Oc; Wed, 12 May 2021 11:00:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01D79300242;
        Wed, 12 May 2021 13:00:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D65B820B5CA9B; Wed, 12 May 2021 13:00:06 +0200 (CEST)
Date:   Wed, 12 May 2021 13:00:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        bristot@redhat.com, yejune.deng@gmail.com
Subject: Re: [PATCH 0/2] sched: Address idle task vs pcpu kthread checks
Message-ID: <YJu1NpMt3BcLYGHh@hirez.programming.kicks-ass.net>
References: <20210510151024.2448573-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510151024.2448573-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 04:10:22PM +0100, Valentin Schneider wrote:
> Note: I remember seeing some patch(es) from Peter tackling this exact
> problem, but I couldn't find them again.

Found it (by accident), yours is nicer though :-)

> Valentin Schneider (1):
>   sched: Make the idle task quack like a per-CPU kthread
> 
> Yejune Deng (1):
>   lib/smp_processor_id: Use is_percpu_thread() instead of
>     nr_cpus_allowed
> 
>  include/linux/kthread.h |  2 ++
>  kernel/kthread.c        | 30 ++++++++++++++++++------------
>  kernel/sched/core.c     | 21 +++++++++++++++------
>  lib/smp_processor_id.c  |  6 +-----
>  4 files changed, 36 insertions(+), 23 deletions(-)

Thanks!
