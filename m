Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B713B434532
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 08:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJTGes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 02:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:34:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278F5C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 23:32:33 -0700 (PDT)
Date:   Wed, 20 Oct 2021 08:32:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634711551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2EzcaJsHoclkkFmC9co6PrDzTCp/HjVc2eV8xmo/iY=;
        b=16opjXvsmp0cBuE8fy2YEPxnTZ4MCnsTx3EQ21GN0kpGG2EP6swrV/Rl9It/ANs0Bkfq0I
        jgDucSkAHnwxSfwbVGzagPrdEeKz1t7B47YqMqE+B9ct27Z0NVj2RY764P84DPF//I+tAx
        bDJNnMshblJTo0XqD68nUYPLSmIH/skDN+sL70w6+CIocGhBcGMYYJ+acgKIwEFlJbP8YF
        kKgeT3/KzasmdcUB2OZ36DwZ5HNu5VpoMyPlBKst8bAOXQp8o2p7DShN0K8P6vFNm2KCdz
        /vpkYI0CLCTL2NJ3vw065VDOjYIqVfzOCwzPk8P8QAPOuD5EfdmMyWp86mQVag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634711551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2EzcaJsHoclkkFmC9co6PrDzTCp/HjVc2eV8xmo/iY=;
        b=lcFZBaJ5B5xZjxVVFPqboacLDk5AF0mRERpaD/+SWV2+Mt60h71W6njcoFyadIlLfcpQpc
        fK50/T74Z2rytLCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com>,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        gor@linux.ibm.com, jgross@suse.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        mingo@redhat.com, namit@vmware.com, rdunlap@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        vincent.guittot@linaro.org
Subject: Re: [syzbot] possible deadlock in wake_up_all_idle_cpus
Message-ID: <20211020063230.r3cm2ubpmps3lcgo@linutronix.de>
References: <000000000000cf252605ce67014a@google.com>
 <00000000000041567305ce80b8af@google.com>
 <20211019190811.ubam63tfv33c7lmx@linutronix.de>
 <20211019202741.GN174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211019202741.GN174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-19 22:27:41 [+0200], Peter Zijlstra wrote:
> On Tue, Oct 19, 2021 at 09:08:11PM +0200, Sebastian Andrzej Siewior wrote:
> > Does this do anything useful?
> 
> I've got https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core&id=3dfddc2f0f76525218dd2d0c8725d9f21dd411e2
> 
> There's like 3 or 4 threads on this :/ I just got a tested-by on that.

Yeah I saw a few emails and wanted to talk to the bot, assuming it would
keep quiet then.

for_each_possible_cpu looks big but is probably equal to online_cpu in
most cases.

Thanks ;)

Sebastian
