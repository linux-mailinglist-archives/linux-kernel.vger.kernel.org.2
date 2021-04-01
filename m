Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D86351E67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbhDASlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbhDASQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19782C08EC70
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ub+Ha4nXTmBsloPL+8igKYF5FjjF7AK2h2f/8UZReEc=; b=emBewg5mlmkm2K8JaUjKohgsd0
        ByQKXNJzKisWdEIUgXpm6Ptab7VhviEW1Gypp+AWr6I33s3YIzZU6WblR8lUhPxLqDjtCobeaFlhC
        5sehXNmgMFxSiiOg4+bxGlmop4f6IVqOrpQyNtf3eZsTaYP0SqyXJiT+m6s/ZuiP2MNayq+4PjQOU
        Z9u6xK+m0xeAzNKtsc6zQSMmEIy0GgJUaPLz1pw2zspY68nvt8TjbUN5yaWLlTKNfRQpNaqnC51r3
        tp6dqHPPy3iclgaU/plitAC3QLFvSdovzxsazwn7T2ZmrY9794bPd7Vo0oUnRhY+jWEmaxHMIqj57
        KvodG4pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxeo-006C8Z-VJ; Thu, 01 Apr 2021 13:46:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0043E303DA3;
        Thu,  1 Apr 2021 15:46:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4261235FA3BF; Thu,  1 Apr 2021 15:46:44 +0200 (CEST)
Date:   Thu, 1 Apr 2021 15:46:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        fweisbec@gmail.com, Kees Cook <keescook@chromium.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Steven Rostedt <rostedt@goodmis.org>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, dhiatt@digitalocean.com
Subject: Re: [PATCH resend 2/8] sched: core scheduling tagging infrastructure
Message-ID: <YGXOxIZezDHYvmNK@hirez.programming.kicks-ass.net>
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-3-joel@joelfernandes.org>
 <20210327000943.GQ4746@worktop.programming.kicks-ass.net>
 <CABk29NthG_W_GyBknf1rZ35xbkppdPwosR+6ka=kCs70teoEqA@mail.gmail.com>
 <YGGkDHWQkYLyrVJW@hirez.programming.kicks-ass.net>
 <CABk29NuHgtZdMb8usEk+ZELe8PaVejpJuhuR4DHaN-VmjJ=7eQ@mail.gmail.com>
 <YGQgng4Gbv7197hQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGQgng4Gbv7197hQ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 09:11:27AM +0200, Peter Zijlstra wrote:
> On Tue, Mar 30, 2021 at 02:29:06PM -0700, Josh Don wrote:
> > On Mon, Mar 29, 2021 at 2:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > OK, fixed the fails. My tired head made it unconditionally return the
> > > cookie-id of 'current' instead of task. Pushed out an update.
> > 
> > I see you have the per-task and prctl stuff pulled into your tree. I
> > can rebase the compound cookie and cgroup api patches on top if you'd
> > like; not sure if you've already re-ordered it locally. Any other
> > comments on the former?
> 
> Hold off on that for a little while; i've been grubbing through the
> cgroup code as well, just haven't had anything that actually works yet.
> I'll hopefully have something soon (I really want to quickly forget all
> the cgroup details again).

With a significantly trimmed Cc list:

https://lkml.kernel.org/r/20210401131012.395311786@infradead.org

