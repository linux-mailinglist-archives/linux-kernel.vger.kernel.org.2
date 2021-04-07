Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD323565CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhDGHvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbhDGHvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:51:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022BC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CHFFE0IfNGrwjKPVmMEwSeRRbfQevybTuM/Pl0JrUSg=; b=F5UdTDJm6I56taSSiF57+ZOAvH
        +nPR0SdTuHJFbeq7q1z4avxpubf/M10mvQJK1l/N37NwEwqN9UQZF9efRkYfdOwZppSnGqNHnlGPQ
        Cg5d1NJ912g2j7WDnGRPgcoZo4I7YrH4KOEhoAVlEnraL5Mffv3ZjXadH/ICO7FrE+1ECfFY5jVx4
        RpjcsB1ZrBWUc6q7K4jd4NzAXFuY2DLMTT6WWD3oLINTLSnTA3VqtYfqlHJPrHDw6spKDXLIixFPw
        NvZcdLqK3frMhGq7f0Pjkz/qgYPlEYa+WRuHe+bDzhRhvYU5i7UKE6ejmjHDA466feyRIxnAu1yo4
        3WclzIlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU2xh-00E76k-Nd; Wed, 07 Apr 2021 07:50:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C767B3008B7;
        Wed,  7 Apr 2021 09:50:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB74924403DA3; Wed,  7 Apr 2021 09:50:52 +0200 (CEST)
Date:   Wed, 7 Apr 2021 09:50:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>, Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        syzbot <syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: perf_buffer.event_list is not RCU-safe?
Message-ID: <YG1kXApqMm/XOcDR@hirez.programming.kicks-ass.net>
References: <00000000000030aca605be6e0102@google.com>
 <20210327042150.7460-1-hdanton@sina.com>
 <20210328025217.7312-1-hdanton@sina.com>
 <20210401092907.1098-1-hdanton@sina.com>
 <20210402074636.1270-1-hdanton@sina.com>
 <20210406172322.GA13270@redhat.com>
 <20210406174352.GB13270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406174352.GB13270@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 07:43:53PM +0200, Oleg Nesterov wrote:
> On 04/06, Oleg Nesterov wrote:
> >
> > perf_mmap_close() was added by 9bb5d40cd93c9 ("perf: Fix mmap() accounting hole")
> 
> I meant perf_mmap_close() -> put_event()
> 
> > and this commit doesn't look right anyway
> 
> It seems there is another problem or I am totally confused. I do not
> understand why can we use list_for_each_entry_rcu(event, rb->event_list)
> if this can race with perf_event_set_output(event) which can move "event"
> to another list, in this case list_for_each_entry_rcu() can loop forever.
> 
> perf_mmap_close() even mentions this race and restarts the iteration to
> avoid it but I don't think this is enough,
> 
> 	rcu_read_lock();
> 	list_for_each_entry_rcu(event, &rb->event_list, rb_entry) {
> 		if (!atomic_long_inc_not_zero(&event->refcount)) {
> 			/*
> 			 * This event is en-route to free_event() which will
> 			 * detach it and remove it from the list.
> 			 */
> 			continue;
> 		}
> 
> just suppose that "this event" is moved to another list first and after
> that it goes away so that atomic_long_inc_not_zero() fails; in this case
> the next iteration will play with event->rb_entry.next, and this is not
> necessarily "struct perf_event", it can can be "list_head event_list".

We observe an RCU GP in ring_buffer_attach(), between detach and attach,
no?

Normally, when we attach to a rb for the first time, or when we remove
it first, no GP is required and everything is fine. But when we remove
it and then attach it again to another rb, we must observe a GP because
of that list_rcu, agreed?

The cond_synchronize_rcu() in ring_buffer_attach() should capture
exactly that case.
