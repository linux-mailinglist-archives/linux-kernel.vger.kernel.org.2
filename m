Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80C441E5CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 03:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351282AbhJABck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 21:32:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38105 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230256AbhJABcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 21:32:39 -0400
Received: (qmail 489090 invoked by uid 1000); 30 Sep 2021 21:30:55 -0400
Date:   Thu, 30 Sep 2021 21:30:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20211001013055.GA489012@rowland.harvard.edu>
References: <20210930130823.2103688-1-boqun.feng@gmail.com>
 <20210930152033.GD464826@rowland.harvard.edu>
 <20210930181753.GH880162@paulmck-ThinkPad-P17-Gen-1>
 <20210930204634.GB482974@rowland.harvard.edu>
 <YVZSiCFAc2RdmeD9@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVZSiCFAc2RdmeD9@boqun-archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 08:12:56AM +0800, Boqun Feng wrote:
> On Thu, Sep 30, 2021 at 04:46:34PM -0400, Alan Stern wrote:
> > On Thu, Sep 30, 2021 at 11:17:53AM -0700, Paul E. McKenney wrote:
> > > On Thu, Sep 30, 2021 at 11:20:33AM -0400, Alan Stern wrote:
> > > > On Thu, Sep 30, 2021 at 09:08:23PM +0800, Boqun Feng wrote:
> > > > > A recent discussion[1] shows that we are in favor of strengthening the
> > > > > ordering of unlock + lock on the same CPU: a unlock and a po-after lock
> > > > > should provide the so-called RCtso ordering, that is a memory access S
> > > > > po-before the unlock should be ordered against a memory access R
> > > > > po-after the lock, unless S is a store and R is a load.
> > > > > 
> > > > > The strengthening meets programmers' expection that "sequence of two
> > > > > locked regions to be ordered wrt each other" (from Linus), and can
> > > > > reduce the mental burden when using locks. Therefore add it in LKMM.
> > > > > 
> > > > > [1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/
> > > > > 
> > > > > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > > ---
> > > > > Alan,
> > > > > 
> > > > > I added the "Co-developed-by" and "Signed-off-by" tags since most of the
> > > > > work is done by you. Feel free to let me know if you want to change
> > > > > anything.
> > > > 
> > > > It looks good to me.  However, do we really want to add these litmus
> > > > tests to the kernel source, or would it be better to keep them with
> > > > the thousands of other tests in Paul's archives?
> > > 
> > > Either way works for me.  But if they are referred to from within the
> > > kernel, it is best to have them in the kernel source.  Which might be seen
> > > as a reason to minimize referring to litmus tests from the kernel.  ;-)
> > 
> > In this case the litmus tests are not referred to within the kernel 
> > source.
> > 
> 
> I'm OK to drop the litmus tests, but the reason I add the two litmus
> tests is that they directly describe one of our memory model rules. The
> two litmus tests tells developers "you can use unlock+lock on the same
> CPU to order READ->WRITE or WRITE->WRITE", so they are kind of part of
> the manual of our memory model. Thoughts?

The explanation.txt file already contains example litmus tests (not 
in a form acceptable to herd7, though) for these things.

Alan
