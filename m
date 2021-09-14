Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726B040A872
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhINHrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:47:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbhINHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:46:34 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631605512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nMIAonN/hzUSuGk60HD8q1xVwCYMSQjQiTEL6zcE47I=;
        b=uyrEwqOJdUQDMUgZeHx/N1mKKFkyp25w2ulkpk2HkTFSo1is4RXoncwNFC170IIdPR5Pqq
        Cx8+9bSXj569emBoP1BjVbtxJE0qkXuGm+HZL2XUp6rZLWHpPOuEPboC39YMGS3m6aq7V/
        SQENvnMDs0jWkY8qSz2EQkzRluvhgQ7vdxO9MosPvWc6/6nWdkXPPfBFS86IN/da4qQTkA
        jAW1Bm/Lb1wdGvuMtAJUMxxetWxkqBAJZpIMmFsgm02QMEg3fShx8crsqFIyZcmL7VVTHs
        N9NhBwZzslWNEItYJSdkPvb5OuNhrfoX5iDymPuFyB/jV8fR8bXwmBOsOXy/IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631605512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nMIAonN/hzUSuGk60HD8q1xVwCYMSQjQiTEL6zcE47I=;
        b=2FE5vmVscw0U1jtxK2uXZg0Ll/Yb+jWArjOiTrXjfnW3K8XiNyQozWy5P96v2J2ovsJQf5
        +monIl7OyhKuCwDw==
To:     Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 3/4] locking/rwbase: Fix rwbase_write_lock() vs
 __rwbase_read_lock()
In-Reply-To: <20210909110203.893845303@infradead.org>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.893845303@infradead.org>
Date:   Tue, 14 Sep 2021 09:45:12 +0200
Message-ID: <87k0jjeh2v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2021 at 12:59, Peter Zijlstra wrote:

> Boqun noticed that the write-trylock sequence of load+set is broken in
> rwbase_write_lock()'s wait-loop since they're not both under the same
> wait_lock instance.

Confused.

lock(); A

for (; atomic_read(readers);) {
   ...
   unlock();
   ..
   lock(); B
}

atomic_set();
unlock(); A or B

The read/set is always in the same lock instance.

> Restructure the code to make this more obvious and correct.

I agree that it's easier to read, but I disagree that it makes the code
more correct.

Thanks,

        tglx
