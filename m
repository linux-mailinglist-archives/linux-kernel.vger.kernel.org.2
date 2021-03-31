Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67D134F995
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhCaHNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbhCaHMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:12:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7963C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qHiOnGMp4uE6DKxTBB9AarnFY8Tq/0U6+q4gwBSPKU8=; b=pM36lpRFm69bjFmDBOqcmpekqQ
        cKYUSzUcjbpAojfl4Q1gNmBHdNpSKiuutlL035OG+qtKARagUqtuT5NeHE4qrgi7VSlMAuVveGyT/
        hZdsZl0a4T8Kabde7W3P3lfmvQ9qvGOxYT1UcgO9GGWtv8Ans39Tmc/bwh2SWkwoS5mI3NiDdtsh9
        F1PdfzbdmY5cTq1kBKIwO+AzBuEP5lTIdqaNm66QVojo6PzNqK2sLTKAsY+N3jiLzY/qfrN6jPM+C
        dlnjYAreZCAxz2pfMiVtRfq2cmjjYKezljMyPUtbrSIbBvet6RVg/a+48B4dG3+EfUzf7GibuUOp0
        D5GZEFIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRV0k-005kI3-0a; Wed, 31 Mar 2021 07:11:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20736300B22;
        Wed, 31 Mar 2021 09:11:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CCC32B878545; Wed, 31 Mar 2021 09:11:27 +0200 (CEST)
Date:   Wed, 31 Mar 2021 09:11:26 +0200
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
Message-ID: <YGQgng4Gbv7197hQ@hirez.programming.kicks-ass.net>
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-3-joel@joelfernandes.org>
 <20210327000943.GQ4746@worktop.programming.kicks-ass.net>
 <CABk29NthG_W_GyBknf1rZ35xbkppdPwosR+6ka=kCs70teoEqA@mail.gmail.com>
 <YGGkDHWQkYLyrVJW@hirez.programming.kicks-ass.net>
 <CABk29NuHgtZdMb8usEk+ZELe8PaVejpJuhuR4DHaN-VmjJ=7eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NuHgtZdMb8usEk+ZELe8PaVejpJuhuR4DHaN-VmjJ=7eQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 02:29:06PM -0700, Josh Don wrote:
> On Mon, Mar 29, 2021 at 2:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > OK, fixed the fails. My tired head made it unconditionally return the
> > cookie-id of 'current' instead of task. Pushed out an update.
> 
> I see you have the per-task and prctl stuff pulled into your tree. I
> can rebase the compound cookie and cgroup api patches on top if you'd
> like; not sure if you've already re-ordered it locally. Any other
> comments on the former?

Hold off on that for a little while; i've been grubbing through the
cgroup code as well, just haven't had anything that actually works yet.
I'll hopefully have something soon (I really want to quickly forget all
the cgroup details again).
