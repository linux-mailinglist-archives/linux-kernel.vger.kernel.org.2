Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6147940A6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhINGsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbhINGsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:48:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3127AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 23:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ZO60xPfR/5kWP62g09zkdcNbotpPgXXz+Skh0BtYgc=; b=pIkyPjf992AX+tJJpT9IP31WB4
        ZEU5sLR9wyeNdpksPxkQE5BygsU0j5xTegoYA9uhFGlKzN+0g7tSypTXEVp3A/Y7N/9gTK41kL9mW
        oR+14UjXfW0BCJZnKBNUl69U0c2Idbn/VhKQ36P/Ht63zSv2k45SIXgwIYIvZhF2n0xcoObfH2UME
        rFeL0JffyaX9sXXQ+NNE18t1g/YmoMd3q14IbvCOhAi5d+6jiMrZDugvcWPbzSal+kt2j0v9uOlxa
        ZGBoAxzG0XJPjbQ4CiLSjg8WOzQo4BBXy20qEp8jiogdVH3JiEynLbkc/dbLhEvymxigyzrd7xfvZ
        IsHIBPaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ2Br-00ELtR-13; Tue, 14 Sep 2021 06:45:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92EF6300129;
        Tue, 14 Sep 2021 08:45:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7942B2C44FF70; Tue, 14 Sep 2021 08:45:08 +0200 (CEST)
Date:   Tue, 14 Sep 2021 08:45:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
Message-ID: <YUBE9EmnOTc0TK1b@hirez.programming.kicks-ass.net>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <871r5sf7s1.ffs@tglx>
 <87pmtcdr6a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmtcdr6a.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:52:29AM +0200, Thomas Gleixner wrote:
> On Tue, Sep 14 2021 at 00:08, Thomas Gleixner wrote:

> If your reasoning would be correct, then set_special_state() would be
> broken as well.

I've dropped the patch.
