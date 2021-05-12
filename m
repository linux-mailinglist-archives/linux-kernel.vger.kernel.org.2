Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A816237BF65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhELOKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhELOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:10:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFB4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y7UUqSC5YygtyOLuSAqM+kSVGDcF3hhEDi3+UNe+ksA=; b=m1MBdkmviLmNBBMYlpisRg5CaE
        SRoCx43tcrLcsKRhhBum43akFcTVRwGH1u2On+XznUWB5PWo0bsz/QMkTPOZ5x/N+Tnz1Jn6o9i8w
        axI8FWyWxHwNvcVLYvX4yJyZ6cQMYdTRhYw31RriKd6JXWVy6dFu30uPxm2JQyvupYxKUSw3gScrz
        A9BPt2T0cMEFeokK22PtVdgl/Y3Pgz3JBJB7k+XuMfLHV7w19kWqZN66pYOJkiX7q3+FCaLZ9s7VR
        csC5NPDwVUzk6LVEXiHqfuqWX9VJrYuPHWtgDhmQSnEGpYnUZ1wkH3trXf7jzQqlsdsh2dYFzORRk
        8Ck8WhPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgpUV-008Kyv-1E; Wed, 12 May 2021 14:06:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BA5B3002C1;
        Wed, 12 May 2021 16:05:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00DF328B2AEC4; Wed, 12 May 2021 16:05:33 +0200 (CEST)
Date:   Wed, 12 May 2021 16:05:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Correct calling tracepoints
Message-ID: <YJvgreWRNgkloeuh@hirez.programming.kicks-ass.net>
References: <20210512120937.90211-1-leo.yan@linaro.org>
 <YJvL+IvlTtoNv2c7@hirez.programming.kicks-ass.net>
 <20210512093202.5fca1259@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512093202.5fca1259@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 09:32:02AM -0400, Steven Rostedt wrote:
> On Wed, 12 May 2021 14:37:12 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, May 12, 2021 at 08:09:37PM +0800, Leo Yan wrote:
> > > The commit eb1f00237aca ("lockdep,trace: Expose tracepoints") reverses
> > > tracepoints for lock_contended() and lock_acquired(), thus the ftrace
> > > log shows the wrong locking sequence that "acquired" event is prior to
> > > "contended" event:
> > > 
> > >   <idle>-0       [001] d.s3 20803.501685: lock_acquire: 0000000008b91ab4 &sg_policy->update_lock
> > >   <idle>-0       [001] d.s3 20803.501686: lock_acquired: 0000000008b91ab4 &sg_policy->update_lock
> > >   <idle>-0       [001] d.s3 20803.501689: lock_contended: 0000000008b91ab4 &sg_policy->update_lock
> > >   <idle>-0       [001] d.s3 20803.501690: lock_release: 0000000008b91ab4 &sg_policy->update_lock
> > > 
> > > This patch fixes calling tracepoints for lock_contended() and
> > > lock_acquired().
> > > 
> > > Fixes: eb1f00237aca ("lockdep,trace: Expose tracepoints")
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>  
> > 
> > No idea how that happened, curious. Thanks for fixing though!
> 
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Tested-by: Marco Elver <elver@google.com>
> 
> That's embarrassing :-p

Thing is, if you look at the list copy:

  https://lore.kernel.org/lkml/20200821085348.782688941@infradead.org/

things were okay. I suspect there was a conflict at some point and
resolution got it backwards because the hunks are so similar and I never
noticed :/
