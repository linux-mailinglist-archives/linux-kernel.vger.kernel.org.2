Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1244DD56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhKKV4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKKV4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:56:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8BC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 13:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wJGYNi/IUwMAvyqo2DoDo2Wg9faUWg7yyelsmIHdJCs=; b=lf28jWG974biqEVbWiIBn9sk6M
        jUNsSEyt7jYpwIWMMlRbCSoLO5Mje2ITHZsMnBJ050xeOswrV19hE5f2WqMrwMDmZJYZ80EcBOjvB
        AiqhHkZlTKcWDLybD8RcLBhwYGhoJDgoXKemM/Cpkmate7otmDH9KFmhnAdBwQj01Lsb7ptGvhH/E
        jTsRHKMrOaIj+29qdXqWU7QKjX3pbhn3JC1egoP8DnvfBXufd21SEyy8CLovBkChcwKJFt/g16i9J
        jM27vbLAM4GnVqmEA5yHnUiI5IPY9outgWBPWj/+4bwaH28LMpbuJTJCk5RNFOFna+21qs4X7Hktj
        MROmgzUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlI0i-00341i-GP; Thu, 11 Nov 2021 21:53:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1762930001B;
        Thu, 11 Nov 2021 22:53:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3C112C25B0B6; Thu, 11 Nov 2021 22:53:31 +0100 (CET)
Date:   Thu, 11 Nov 2021 22:53:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <YY2Q220iEiFdaKlT@hirez.programming.kicks-ass.net>
References: <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
 <20211111202647.GH174703@worktop.programming.kicks-ass.net>
 <be3dc705-494a-913e-230f-9533c7404ac2@redhat.com>
 <436bcf39-297a-f5a6-ac58-a82e77cb3b83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <436bcf39-297a-f5a6-ac58-a82e77cb3b83@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 04:25:56PM -0500, Waiman Long wrote:
> 
> On 11/11/21 16:01, Waiman Long wrote:
> > 
> > On 11/11/21 15:26, Peter Zijlstra wrote:
> > > On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:
> > > 
> > > > @@ -434,6 +430,7 @@ static void rwsem_mark_wake(struct
> > > > rw_semaphore *sem,
> > > >               if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
> > > >                   time_after(jiffies, waiter->timeout)) {
> > > >                   adjustment -= RWSEM_FLAG_HANDOFF;
> > > > +                waiter->handoff_set = true;
> > > >                   lockevent_inc(rwsem_rlock_handoff);
> > > >               }
> > > Do we really need this flag? Wouldn't it be the same as waiter-is-first
> > > AND sem-has-handoff ?
> > That is true. The only downside is that we have to read the count first
> > in rwsem_out_nolock_clear_flags(). Since this is not a fast path, it
> > should be OK to do that.
> 
> I just realize that I may still need this flag for writer to determine if it
> should spin after failing to acquire the lock. Or I will have to do extra
> read of count value in the loop. I don't need to use it for writer now.

Maybe it's too late here, but afaict this is right after failing
try_write_lock(), which will have done at least that load you're
interested in, no?

Simply have try_write_lock() update &count or something.
