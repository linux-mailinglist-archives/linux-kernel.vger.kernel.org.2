Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168414429EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhKBI6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:58:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3964EC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N33l6RiSSmHSLpi/enAK4GkMnnrIZ0H/1hmbYMetRIU=; b=fBuAAvAEK9/BDQCpfhmxGmlLNE
        Pr3F4uuk6nNxlnFgD08p0ZAtBdepU3Z7dCIzwWH5WeAS21iMMdxLj3v8mSIg5C0Rtx86vVT0fFAv+
        3thkSwROhgSO3P3JsZGQdZt/Eiz0FiGjYlN/QbRfTvx5sQCRP3yiDH3yVAgeNXFiXH4aN9DdcAQCN
        vs+vJEjzhuqNtGbnO+bZjHuJ5cxikTNt2uXpcTAf47rFQosgPGcAeRIuMymcLfkICxgOFW5cXTID5
        rBHSVZjG+DFJS6ekNJHzX4u3ts9zr0q+j+XoSXiRQsObH0Z9qVocw7DTDdpgCpIBQyxN9fXF+PK3o
        Ro3WmaLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhpYR-004Nrs-3C; Tue, 02 Nov 2021 08:54:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D213300366;
        Tue,  2 Nov 2021 09:54:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D5032D202F07; Tue,  2 Nov 2021 09:54:02 +0100 (CET)
Date:   Tue, 2 Nov 2021 09:54:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] sched/core for v5.16-rc1
Message-ID: <YYD8qi/GsTrTlPMh@hirez.programming.kicks-ass.net>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864855.3357115.17938524897008353101.tglx@xen13>
 <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:01:13PM -0700, Linus Torvalds wrote:
> On Sun, Oct 31, 2021 at 6:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >  - Make wchan() more robust and work with all kind of unwinders by
> >    enforcing that the task stays blocked while unwinding is in progress.
> 
> Ugh. This not-very-important data is protected by a rather core lock.
> 
> Is this yet another example of "unwinding is so fragile that it can
> screw up unless we take a lock that is seriously overkill for a not
> very important operation"?
> 
> Unwinders that need locks because they can do bad things if they are
> working on unstable data are EVIL and WRONG.

Because of that :/ The eventual plan was to implement wchan in core code
using the 'regular' stack unwinding functions we have, the diffstats are
nice, but the unwinders not so. Also see my other reply.

  https://lkml.kernel.org/r/20211022152104.487919043@infradead.org

> I guess I don't care too much about the pi_lock, and the actual
> unwinding is hopefully done on tasks that don't care about it, but
> this smells suspicious to me.

You do in fact care about pi_lock. The name is very wrong these days
(and I've been very tardy with renaming it because I can't seem to come
up with a good name).

It is in fact the core lock involved with regular wakeups. The lock was
initially PI only, but it got co-opted into common scheduler use a fair
number of years ago. These days it serializes pretty much all per-task
scheduling state, not only the pi-chain. So perhaps I should do:

  s/pi_lock/sched_lock/ ?

