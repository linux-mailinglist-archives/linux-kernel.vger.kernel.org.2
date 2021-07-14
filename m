Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCEE3C8183
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbhGNJ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhGNJ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:27:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32677C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tUduBOkYiAiQvpqP+UoyvDWtfkTyBcV2MFwxlDV89tM=; b=oeSi9UyAyJEzy3vKgXOeCl8Ys9
        xsuxyjVhwvewohVSIC6O0XFiDsAEI0tg66bgIV1w/RVO5eNmeB2C+s15xj0Qh8HxD3X5KKfhXStly
        xsALji3t7h/c3PsMZR/k37e9E0BtLO7v96nTntMukKjf9zT8ZSlaJkv0yTF0crRXjKPbkqFV9/Z/6
        esx3F+g9+l3AEbK2LcVKBhWruHXShmLp8dTTk2Y3/PvosLxr7gFbCxrD7v3eak1GJCo3llPBlWC+y
        YJf11ecB/4R4NGsDjvRhccJFsk7iRnFLBaPqtld4TEi0eKstMO0pLS5uuYfamagR9nm7z1Jyl/LPb
        bS8Hw54g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3b7q-00HRRs-RY; Wed, 14 Jul 2021 09:24:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B928798689D; Wed, 14 Jul 2021 11:24:16 +0200 (CEST)
Date:   Wed, 14 Jul 2021 11:24:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [patch 22/50] rbtree: Split out the rbtree type definitions
Message-ID: <20210714092416.GE2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160748.090645860@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160748.090645860@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:11:16PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> rtmutex.h needs the definition of struct rb_root_cached. rbtree.h includes
> kernel.h which includes spinlock.h. That works nicely for non-RT enabled
> kernels, but on RT enabled kernels spinlocks are based on rtmutexes which
> creates another circular header dependency as spinlocks.h will require
> rtmutex.h.
> 
> Split out the type definitions and move them into their own header file so
> the rtmutex header can include just those.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/rbtree.h       | 30 +-----------------------------
>  include/linux/rbtree_types.h | 34 ++++++++++++++++++++++++++++++++++

This will mess up the tools/include/linux/ copy of these headers...
