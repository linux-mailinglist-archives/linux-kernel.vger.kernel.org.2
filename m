Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC3315387
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhBIQOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhBIQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:14:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xtgAIQYjeBASeA4Agwd12ZucFnQjR7z/f0eu8R/GUN0=; b=2VDQIOmIudcOMOMzJw66jqPAUM
        b9RZzQOVo7xx8LzQSZXlXulEnGIupcizoo49TqbSVgbk200PElrHvYgHRl8wcHaYMkvMjMgsAGSLT
        lkeHD1nkq+ySaul95oGvMfc0ztAgGweJXjn/WU9FRg8dI/9Ip6DxykvlyqJTxfDH7RK//NmqTOnc4
        NZYNHTNgRQrEcal/AvA8dceGBahmDhoblZ41mHs/mFbE/9GDM+HHvhqHGtSIF2KaxgLh0crz8AQkA
        kiAEFL/C8EWz+HQHfFhXncyhAnSIEt5eA4zrjxWVKdjlAlfwXoosGiOUkwXsBL4YaolzFJ63WO46J
        /vM51Qsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9Vdf-0005Ss-Op; Tue, 09 Feb 2021 16:13:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1BDE301324;
        Tue,  9 Feb 2021 17:13:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B324F20084EAD; Tue,  9 Feb 2021 17:13:15 +0100 (CET)
Date:   Tue, 9 Feb 2021 17:13:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] preempt: select PREEMPT_DYNAMIC under PREEMPTION instead
 of PREEMPT
Message-ID: <YCK0m8FD9kp8QZWJ@hirez.programming.kicks-ass.net>
References: <7d129a84b0858fd7fbc3e38ede62a848fbec536e.camel@gmx.de>
 <YCKmhnoSKgdYqxOL@hirez.programming.kicks-ass.net>
 <269ee10aac93d819e48dc81f09a01d01fcd44fb1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269ee10aac93d819e48dc81f09a01d01fcd44fb1.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:05:14PM +0100, Mike Galbraith wrote:

> ld: init/main.o: in function `trace_initcall_start':
> /backup/usr/local/src/kernel/linux-tip-rt/./include/trace/events/initcall.h:27: undefined reference to `__SCT__preempt_schedule_notrace'

Ooohh... this is because x86 can't build PREEMPT without PREEMPT_DYNAMIC
anymore. Maybe I should fix that. Lemme see what that would take.


