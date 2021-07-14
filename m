Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB963C83EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhGNLfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhGNLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:35:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6346EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:32:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626262377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1qWCK0RQ57NjZHmP+mdTUr72CZPEysuuwKFequOuG8=;
        b=j+5GJVHyIefGeX9yGFjaZXLQF8iok9YrzARwBO+CXmznumu1iNWJJ8HniQ0OeLZDrG7tCX
        kCPb31er76rpndD2A0eZ2Hj730/ykk9glF4EiUr6DSbp+0tgj5z/KGb51nsBbHEAiruGgh
        9mERb4s4st+4oxv8YsUt2HXDvF84YRbzyT3+BexkqUo6T2w5FKQnsdjckqqTM6OzcsAE4l
        zysxhYvrhiWYOEBrsecH7KpnccHrdKnZB6EeBJ+lhqPmQUxW75her9pcKVVD0WNaAc52m1
        Nk2nsCZgmShiBj/NtNC/aEt8/IotjI71dJ4Il+taCEdQi5DjUxwsU0c0wb0N9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626262377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1qWCK0RQ57NjZHmP+mdTUr72CZPEysuuwKFequOuG8=;
        b=QsPos8q5sHWaU+G3OfI5rJ9i0Y4GwFpKuW3Mdx4gop8ebh+aPuJ9lwjBUJ6ZVv5HKuNnbK
        LSxRf8EdqEIJjzAg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 05/50] sched: Provide schedule point for RT locks
In-Reply-To: <20210714101705.GB2591@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de> <20210713160746.410991567@linutronix.de> <20210714082820.GB2725@worktop.programming.kicks-ass.net> <87y2a9b4xw.ffs@nanos.tec.linutronix.de> <20210714101705.GB2591@worktop.programming.kicks-ass.net>
Date:   Wed, 14 Jul 2021 13:32:56 +0200
Message-ID: <87o8b5b05z.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14 2021 at 12:17, Peter Zijlstra wrote:
> On Wed, Jul 14, 2021 at 11:49:47AM +0200, Thomas Gleixner wrote:
>> On Wed, Jul 14 2021 at 10:28, Peter Zijlstra wrote:
>> >
>> > #define SM_MASK_STATE          (~0U)
>> >
>> > Be even better?
>> 
>> SM_MASK_STATE is overengineered. See combo patch 4+5 below
>
> Yep, that should result in similar code as my proposal, thanks!
>
> nit: you like UINT_MAX better than (~0U) ?

No strong preference.
