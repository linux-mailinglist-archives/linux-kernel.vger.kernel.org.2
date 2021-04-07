Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDDC356C15
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352166AbhDGMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235368AbhDGMa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617798647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4b/W7JPg97GIaUB3j27+Wc4inyOV6OIcHslxI1MfBYQ=;
        b=i5iTHdkf3/f8sqDpmlK7/KgW3O4Gmuc/mwu7+DfFRmSJ8pW5svNcQrLQ/MnVlHaclPEyDX
        yT/M7x0AhrwcGt0z71J3Cbudj1Yf1W4WwibVMS5ZX/ye8B+z26ns7JcK3GZAwvklv1Cr8m
        N3UJJTnnXChsm/dn1Jc+9bwqkQ+Zz9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-4F18YzVNMB-NZzPU5Luxgw-1; Wed, 07 Apr 2021 08:30:44 -0400
X-MC-Unique: 4F18YzVNMB-NZzPU5Luxgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C6ED802B7E;
        Wed,  7 Apr 2021 12:30:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.196.68])
        by smtp.corp.redhat.com (Postfix) with SMTP id C660E10246F1;
        Wed,  7 Apr 2021 12:30:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Apr 2021 14:30:42 +0200 (CEST)
Date:   Wed, 7 Apr 2021 14:30:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>, Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        syzbot <syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: perf_buffer.event_list is not RCU-safe?
Message-ID: <20210407123038.GA22407@redhat.com>
References: <00000000000030aca605be6e0102@google.com>
 <20210327042150.7460-1-hdanton@sina.com>
 <20210328025217.7312-1-hdanton@sina.com>
 <20210401092907.1098-1-hdanton@sina.com>
 <20210402074636.1270-1-hdanton@sina.com>
 <20210406172322.GA13270@redhat.com>
 <20210406174352.GB13270@redhat.com>
 <YG1kXApqMm/XOcDR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1kXApqMm/XOcDR@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07, Peter Zijlstra wrote:
>
> On Tue, Apr 06, 2021 at 07:43:53PM +0200, Oleg Nesterov wrote:
> > On 04/06, Oleg Nesterov wrote:
> > >
> > > perf_mmap_close() was added by 9bb5d40cd93c9 ("perf: Fix mmap() accounting hole")
> >
> > I meant perf_mmap_close() -> put_event()
> >
> > > and this commit doesn't look right anyway
> >
> > It seems there is another problem or I am totally confused. I do not
> > understand why can we use list_for_each_entry_rcu(event, rb->event_list)
> > if this can race with perf_event_set_output(event) which can move "event"
> > to another list, in this case list_for_each_entry_rcu() can loop forever.
> >
> > perf_mmap_close() even mentions this race and restarts the iteration to
> > avoid it but I don't think this is enough,
> >
> > 	rcu_read_lock();
> > 	list_for_each_entry_rcu(event, &rb->event_list, rb_entry) {
> > 		if (!atomic_long_inc_not_zero(&event->refcount)) {
> > 			/*
> > 			 * This event is en-route to free_event() which will
> > 			 * detach it and remove it from the list.
> > 			 */
> > 			continue;
> > 		}
> >
> > just suppose that "this event" is moved to another list first and after
> > that it goes away so that atomic_long_inc_not_zero() fails; in this case
> > the next iteration will play with event->rb_entry.next, and this is not
> > necessarily "struct perf_event", it can can be "list_head event_list".
>
> We observe an RCU GP in ring_buffer_attach(), between detach and attach,
> no?

Aaah yes, I didn't notice cond_synchronize_rcu() in ring_buffer_attach().

Thanks!

Oleg.

