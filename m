Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014D741E0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353386AbhI3STk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3STg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:19:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D872619F6;
        Thu, 30 Sep 2021 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025873;
        bh=4RQ1qh5PQ7XM7RwFtMMOsRZbOrpcEDqV2LixdSXaqaQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NcMcIOIVUYpLNdjieMCxW9vTCZQkAPA1RTJIT+vAMSCii54OoZLqYFL1QDtG400Da
         s1rb2RbSVw3N8vQgqrk/0btNwqIT/wGpQFKpotYEeOFivMbN57aHGYp59s/ZtUZ0B2
         sEskWcLRzTHv8tV4HNUM78y9tmMYtnd2aFLP3bAwS3A2EOnpe85/Dk9m0LW1/mE9xx
         HTdCrrVQMghy4IKs6ixn+TxCODgibDVhBc/li+66lPTKhmxrY6BAdDussWa3ADpa6O
         kRbyhUNjbH15m6SuxTOL5moe0FCYOKWEsRiGk+e/r962eb4Ts6SqpIcfm8E+9yzsHw
         dCTbPDWB35JZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E6EA5C0433; Thu, 30 Sep 2021 11:17:53 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:17:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au
Subject: Re: [PATCH] tools/memory-model: Provide extra ordering for
 unlock+lock pair on the same CPU
Message-ID: <20210930181753.GH880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210930130823.2103688-1-boqun.feng@gmail.com>
 <20210930152033.GD464826@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930152033.GD464826@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:20:33AM -0400, Alan Stern wrote:
> On Thu, Sep 30, 2021 at 09:08:23PM +0800, Boqun Feng wrote:
> > A recent discussion[1] shows that we are in favor of strengthening the
> > ordering of unlock + lock on the same CPU: a unlock and a po-after lock
> > should provide the so-called RCtso ordering, that is a memory access S
> > po-before the unlock should be ordered against a memory access R
> > po-after the lock, unless S is a store and R is a load.
> > 
> > The strengthening meets programmers' expection that "sequence of two
> > locked regions to be ordered wrt each other" (from Linus), and can
> > reduce the mental burden when using locks. Therefore add it in LKMM.
> > 
> > [1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/
> > 
> > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > Alan,
> > 
> > I added the "Co-developed-by" and "Signed-off-by" tags since most of the
> > work is done by you. Feel free to let me know if you want to change
> > anything.
> 
> It looks good to me.  However, do we really want to add these litmus
> tests to the kernel source, or would it be better to keep them with
> the thousands of other tests in Paul's archives?

Either way works for me.  But if they are referred to from within the
kernel, it is best to have them in the kernel source.  Which might be seen
as a reason to minimize referring to litmus tests from the kernel.  ;-)

							Thanx, Paul
