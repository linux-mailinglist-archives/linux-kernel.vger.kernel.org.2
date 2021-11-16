Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B280452DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhKPJ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhKPJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:27:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7834C061204
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jecz0EX3fRk/4nkzPYIZc8nwZI9hhWG3nRNpNrjDnLE=; b=QpV46pi6Tj2p7mOIxmCUNVOorj
        XIIZ6mDQ2pP6No7jXxkPaTeaDUIjkVrHdRyhd6R8hZ7rnRmDWvCtKHw/mtw/asQXiRgGfOXtCTPo2
        jAwfs57b7TDTampMTflTiEUs3rxlKJd/zH5dvFyKaZA5ovbsmtrGnM3/tJQ1p0etfFcoaXvk5FDzw
        /Jez4R3m5i5YnxOUyf6x96UJn28wERXVGYxKjIWEYtNGh3051+cZQZotCdhOg5/7Wv1eLkwrczEFA
        55KokglTtjEMvEXhnQCvQBCNTT4tPlTW8lYT5nLwLeLG06yKroo5sJ4z9kOUpYM7ShoOtdisHTJ2V
        dKyAsIkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmuhJ-00GHuD-PA; Tue, 16 Nov 2021 09:24:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF09498651D; Tue, 16 Nov 2021 10:24:12 +0100 (CET)
Date:   Tue, 16 Nov 2021 10:24:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <20211116092412.GL174730@worktop.programming.kicks-ass.net>
References: <20211116012912.723980-1-longman@redhat.com>
 <32b433a1-31f9-14ba-e8f6-87b69c2c4ac9@quicinc.com>
 <20211116091420.GA174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116091420.GA174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:14:20AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 16, 2021 at 10:52:42AM +0800, Aiqun(Maria) Yu wrote:
> > On 11/16/2021 9:29 AM, Waiman Long wrote:
> > > There are some inconsistency in the way that the handoff bit is being
> > > handled in readers and writers.
> > > 
> > > Firstly, when a queue head writer set the handoff bit, it will clear it
> > > when the writer is being killed or interrupted on its way out without
> > > acquiring the lock. That is not the case for a queue head reader. The
> > > handoff bit will simply be inherited by the next waiter.
> > > 
> > > Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
> > > the waiter and handoff bits are cleared if the wait queue becomes empty.
> > > For rwsem_down_write_slowpath(), however, the handoff bit is not checked
> > > and cleared if the wait queue is empty. This can potentially make the
> > > handoff bit set with empty wait queue.
> > > 
> > > To make the handoff bit handling more consistent and robust, extract
> > > out handoff bit clearing code into the new rwsem_del_waiter() helper
> > > function.  The common function will only use atomic_long_andnot() to
> > > clear bits when the wait queue is empty to avoid possible race condition.
> > we do have race condition needed to be fixed with this change.
> 
> Indeed, let me edit the changelog to reflect that. Also, I think, it
> needs a Reported-by:.

How's something liks so then?

---
Subject: locking/rwsem: Make handoff bit handling more consistent
From: Waiman Long <longman@redhat.com>
Date: Mon, 15 Nov 2021 20:29:12 -0500

From: Waiman Long <longman@redhat.com>

There are some inconsistency in the way that the handoff bit is being
handled in readers and writers that lead to a race condition.

Firstly, when a queue head writer set the handoff bit, it will clear
it when the writer is being killed or interrupted on its way out
without acquiring the lock. That is not the case for a queue head
reader. The handoff bit will simply be inherited by the next waiter.

Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
the waiter and handoff bits are cleared if the wait queue becomes
empty.  For rwsem_down_write_slowpath(), however, the handoff bit is
not checked and cleared if the wait queue is empty. This can
potentially make the handoff bit set with empty wait queue.

Worse, the situation in rwsem_down_write_slowpath() relies on wstate,
a variable set outside of the critical section containing the ->count
manipulation, this leads to race condition where RWSEM_FLAG_HANDOFF
can be double subtracted, corrupting ->count.

To make the handoff bit handling more consistent and robust, extract
out handoff bit clearing code into the new rwsem_del_waiter() helper
function. Also, completely eradicate wstate; always evaluate
everything inside the same critical section.

The common function will only use atomic_long_andnot() to clear bits
when the wait queue is empty to avoid possible race condition.  If the
first waiter with handoff bit set is killed or interrupted to exit the
slowpath without acquiring the lock, the next waiter will inherit the
handoff bit.

While at it, simplify the trylock for loop in
rwsem_down_write_slowpath() to make it easier to read.

Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
Reported-by: Zhenhua Ma <mazhenhua@xiaomi.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211116012912.723980-1-longman@redhat.com
---
