Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5CC3630B2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbhDQOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbhDQOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 10:38:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E127AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l3T4NKXuj5bajMrk/OIXwH4WBKYIfPqVTOo37Ue8jmA=; b=oBjfi46PYZUAuElktRLsV4dYwL
        tF5WkLyrZt/8+IQzlEt/GfnwwCggR2ckcjIJAcs3o80RAEr81I2eWU9R4D57A4tMT+IgeQ0408qo4
        rakRrmvrepx3UhI8qq+5QOEVoSD8SS5r0eFoEC2ujftYbzbtnG6/XSX//SUfHSaOJrzIfYpUIdEqq
        paCaYFWBcbbsYDtZWEbgwoVsoBGReR4/KkEdxvLnc1dCkc480j7T3RJdd9uHVwlBkiuGygjvrlVUN
        j7wd86ulxgb4lFTq5a7uZF2z7fE/GCrVlXpLXcdC8ig5dMF/RXV/d+nMdc9F00rJKIEr9EPHG90mG
        gS/EJnrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXm3f-00BM7k-8m; Sat, 17 Apr 2021 14:36:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F48D3001D0;
        Sat, 17 Apr 2021 16:36:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DBF8201F8C56; Sat, 17 Apr 2021 16:36:25 +0200 (CEST)
Date:   Sat, 17 Apr 2021 16:36:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/hung_task: Add a whitelist and blacklist
 mechanism.
Message-ID: <YHryaegfV9jo6aiL@hirez.programming.kicks-ass.net>
References: <1618668783-39601-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618668783-39601-1-git-send-email-zhouchuangao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 07:13:01AM -0700, zhouchuangao wrote:
> eg:
> In Android system, we usually and some processes to the whitelist.
> static task_t task_whitelist[] = {
> 	{"mdrt_thread", HUNG_TASK_WHITELIST},
> 	{"chre_kthread", HUNG_TASK_WHITELIST},
> 	{"scp_power_reset", HUNG_TASK_WHITELIST},
> 	{"ccci_fsm1", HUNG_TASK_WHITELIST},
> 	{"qos_ipi_recv", HUNG_TASK_WHITELIST},
> 	{NULL, 0},
> };

What are these tasks doing that the hung-task detector fires on them?
Should you fix that instead?
