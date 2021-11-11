Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062FC44DD18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhKKVa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhKKVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:30:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D381C061208
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJdk78y6j0x/jUU5z7Aw0+3vc3UPQhcrHoUGjsszQm8=; b=jvIWwV6TFkNy8+0SjVGNBOj6jC
        eK7VFoKOCuLTlyE8tmd2Cdzz/OM9UjeP98Q52byaVv1SY/oHfkneWWRLXgblB7PMl/40OcTRGDJCm
        zL/twHUbxtTitWlKWL7ceQMVD6oFi5pwN1kLZABwqB7TOH8Z5daexsAhg8mcfEPnq2AiCqIfu+JON
        PI2PTpby4jq+zTK9S5W8y9rKtg9qIuf5C6Y49kGJe2Q3NSwEHKYGx1RnEodWxKbrKB4xGnLLeqAsT
        3SZmmvXzHRtTikxxomrgk7c5FtLMhLiGGdotL3mYDprJr3ado6fzodjfo49cApItqpNBxEjZUrRyK
        tLdTcgow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlHbL-00338E-Nt; Thu, 11 Nov 2021 21:27:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19C9A300385;
        Thu, 11 Nov 2021 22:27:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 084DB212B0E8B; Thu, 11 Nov 2021 22:27:19 +0100 (CET)
Date:   Thu, 11 Nov 2021 22:27:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <YY2Kt9pvmVA+uGmG@hirez.programming.kicks-ass.net>
References: <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
 <20211111203500.GI174703@worktop.programming.kicks-ass.net>
 <fae2008b-2cca-b483-6b40-d4b95da007d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fae2008b-2cca-b483-6b40-d4b95da007d3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 03:45:30PM -0500, Waiman Long wrote:
> 
> On 11/11/21 15:35, Peter Zijlstra wrote:
> > On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:
> > > On 11/11/21 14:20, Peter Zijlstra wrote:
> > > > On Thu, Nov 11, 2021 at 02:14:48PM -0500, Waiman Long wrote:
> > > > > As for the PHASE_CHANGE name, we have to be consistent in both rwsem and
> > > > > mutex. Maybe a follow up patch if you think we should change the
> > > > > terminology.
> > > > Well, that's exactly the point, they do radically different things.
> > > > Having the same name for two different things is confusing.
> > > > 
> > > > Anyway, let me go read that patch you sent.
> > > My understanding of handoff is to disable optimistic spinning to let waiters
> > > in the wait queue have an opportunity to acquire the lock. There are
> > > difference in details on how to do that in mutex and rwsem, though.
> > Ah, but the mutex does an actual hand-off, it hands the lock to a
> > specific waiting task. That is, unlock() sets owner, as opposed to
> > trylock().
> > 
> > The rwsem code doesn't, it just forces a phase change. Once a waiter has
> > been blocked too long, the handoff bit is set, causing new readers to be
> > blocked. Then we wait for existing readers to complete. At that point,
> > any next waiter (most likely a writer) should really get the lock (and
> > in that regards the rwsem code is a bit funny).
> > 
> > So while both ensure fairness, the means of doing so is quite different.
> > One hands the lock ownership to a specific waiter, the other arranges
> > for a quiescent state such that the next waiter can proceed.
> 
> That is a valid argument. However, the name PHASE_CHANGE sounds weird to me.
> I am not objecting to changing the term, but probably with a better name
> NO_OPTSPIN, NO_LOCKSTEALING or something like that to emphasize that fact
> that optimistic spinning or lock stealing should not be allowed.

RWSEM_FLAG_QUIESCE ?
