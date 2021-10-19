Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE4433FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhJSUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:37:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FBCC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jQk7zjHB0gPoX00cDocKNrAvGgoKnQS6YZIN9q19mQU=; b=Kc3bNV+r3pphi8bq2HNYdy5jYA
        3bppYx5YRml80T6wJb2fzwechqqOpsEIPJWku3v7aJtZ1Dy1DS3bAWoJJnqzGZYR2NRdNIG6yM9eK
        uCM8QcZV2OfAzeF0he5wvZ07ClTDSBMnLmGBTNQl4hVltqvARN1cZuBQzh+EDrR4svFDMz6GsJ4Zv
        KbOVJ9PW0CEv5VRmB63ZP3b1vUykECddU2BjZ5O4mBXu41KWMchLuSMwDUmU/KrQBYr4Lr3Kzr3yY
        1NjhCJFlO/p6hxyOKKvAFX+c939PuV90lX65xYOXDRckYTa2kl2UntzZIZSL6/ic9aP4G3qpnA10Z
        01ifadcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcvi2-00BzTi-Js; Tue, 19 Oct 2021 20:28:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0E56986DD9; Tue, 19 Oct 2021 22:27:41 +0200 (CEST)
Date:   Tue, 19 Oct 2021 22:27:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     syzbot <syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com>,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        gor@linux.ibm.com, jgross@suse.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        mingo@redhat.com, namit@vmware.com, rdunlap@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        vincent.guittot@linaro.org
Subject: Re: [syzbot] possible deadlock in wake_up_all_idle_cpus
Message-ID: <20211019202741.GN174703@worktop.programming.kicks-ass.net>
References: <000000000000cf252605ce67014a@google.com>
 <00000000000041567305ce80b8af@google.com>
 <20211019190811.ubam63tfv33c7lmx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019190811.ubam63tfv33c7lmx@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 09:08:11PM +0200, Sebastian Andrzej Siewior wrote:
> Does this do anything useful?

I've got https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core&id=3dfddc2f0f76525218dd2d0c8725d9f21dd411e2

There's like 3 or 4 threads on this :/ I just got a tested-by on that.
