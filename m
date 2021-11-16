Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76854452DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhKPJRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhKPJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:17:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787A0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zkLYYonpkwq4W/TxH0MsYqMOCn0M4pAk8e6MrhyKizU=; b=oAmVbpBpFcctb2zi19vfxPp4xv
        6j2elpONPwkByOBMIh68IWhnWc8mtmq5I7KbXneB+ageDcz71ZNp2LHDZHwTUhT6Y90lhIVsKDD1c
        uynfSOTMNShuc/4zItuIK/bx/5G4xsAIOVIyzXXKfH63cdvItI0R4k2JfXYR+VEpdr/nET4oK8dzN
        goT/n9KcyMtO0vpndjaGiI1SrjC4oGEYOsspullwJGucllXgTK/nE1XsJONgOcfYdxkqrM9DpsYOT
        diMpxiByt3cKIBNfzsn+rGeaHspqcUwXMtnRxkGAAubTx33H5DHRxlG/ZXk5f1rRR1Q92b4hDWolv
        6dNiqThw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmuXl-006cF5-Es; Tue, 16 Nov 2021 09:14:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD66698651D; Tue, 16 Nov 2021 10:14:20 +0100 (CET)
Date:   Tue, 16 Nov 2021 10:14:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <20211116091420.GA174703@worktop.programming.kicks-ass.net>
References: <20211116012912.723980-1-longman@redhat.com>
 <32b433a1-31f9-14ba-e8f6-87b69c2c4ac9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b433a1-31f9-14ba-e8f6-87b69c2c4ac9@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:52:42AM +0800, Aiqun(Maria) Yu wrote:
> On 11/16/2021 9:29 AM, Waiman Long wrote:
> > There are some inconsistency in the way that the handoff bit is being
> > handled in readers and writers.
> > 
> > Firstly, when a queue head writer set the handoff bit, it will clear it
> > when the writer is being killed or interrupted on its way out without
> > acquiring the lock. That is not the case for a queue head reader. The
> > handoff bit will simply be inherited by the next waiter.
> > 
> > Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
> > the waiter and handoff bits are cleared if the wait queue becomes empty.
> > For rwsem_down_write_slowpath(), however, the handoff bit is not checked
> > and cleared if the wait queue is empty. This can potentially make the
> > handoff bit set with empty wait queue.
> > 
> > To make the handoff bit handling more consistent and robust, extract
> > out handoff bit clearing code into the new rwsem_del_waiter() helper
> > function.  The common function will only use atomic_long_andnot() to
> > clear bits when the wait queue is empty to avoid possible race condition.
> we do have race condition needed to be fixed with this change.

Indeed, let me edit the changelog to reflect that. Also, I think, it
needs a Reported-by:.

> > If the first waiter with handoff bit set is killed or interrupted to
> > exit the slowpath without acquiring the lock, the next waiter will
> > inherit the handoff bit.
> > 
> > While at it, simplify the trylock for loop in rwsem_down_write_slowpath()
> > to make it easier to read.
> > 
> > Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Waiman Long <longman@redhat.com>
