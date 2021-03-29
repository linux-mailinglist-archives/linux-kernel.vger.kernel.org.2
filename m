Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10D434CD71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhC2J5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhC2J5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:57:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/TxZye4/Hu8uIyAyFOXSED4o2sCKVRpCpOWqX8q9jJk=; b=q48GVPqhqcqlFe3D5Rdz/xZtag
        k5cM5qHiSFhG3NEhrVb+F4M3BRDvDN1GZUJSRTxWmIKRzjwd4ybiGAtJ95Wb1j5qIB9Klkw87rgVf
        /sYazUSfkTfw1ATbhFJ+NkVa6ExZIYXhHXV6fXZG4U9rWwUFWong1Wt3JDs4iI/smchtgSsmHR0sa
        YORcQdaH1JqsoxMX/O/rdfpa+RKu/WFcI1Iz/1AY5W4eQ4n41hju9cEp8B2yGgW5TFu5B+FrSqx50
        oJSzvSvTZ+B7V+LRJUlOBdRgeX0VcXXaJ+ytchsV01kMK8J9DF/qdfgLBR6Yj4YuapojsD2Pd5xhk
        3b2TejTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQocJ-000Yeh-W0; Mon, 29 Mar 2021 09:55:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 589523007CD;
        Mon, 29 Mar 2021 11:55:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38AA920709457; Mon, 29 Mar 2021 11:55:24 +0200 (CEST)
Date:   Mon, 29 Mar 2021 11:55:24 +0200
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
Message-ID: <YGGkDHWQkYLyrVJW@hirez.programming.kicks-ass.net>
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-3-joel@joelfernandes.org>
 <20210327000943.GQ4746@worktop.programming.kicks-ass.net>
 <CABk29NthG_W_GyBknf1rZ35xbkppdPwosR+6ka=kCs70teoEqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NthG_W_GyBknf1rZ35xbkppdPwosR+6ka=kCs70teoEqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 08:19:57PM -0700, Josh Don wrote:
> On Fri, Mar 26, 2021 at 5:10 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > I've spend the past few hours rewriting patches #2 and #3, and adapting
> > #4. The thing was working before I added SHARE_FROM back and introduced
> > GET, but now I'm seeing a few FAILs from the selftest.
> >
> > I'm too tired to make sense of anything much, or even focus my eyes
> > consistently, so I'll have to prod at it some more next week, but I've
> > pushed out the lot to my queue.git:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/core-sched
> 
> Thanks, I'll take a look next week.

OK, fixed the fails. My tired head made it unconditionally return the
cookie-id of 'current' instead of task. Pushed out an update.

> > Also, we really need a better name than coretag.c.
> 
> Yea, we don't really otherwise use the phrase "tagging". core_sched.c
> is probably too confusing given we have sched/core.c.

Right, so I tried core_sched and my fingers already hate it as much as
kernel/scftorture.c (which I'd assumed my fingers would get used to
eventually, but noooo).

Looking at kernel/sched/ C is very overrepresented, so we really don't
want another I think. B, E, G, H, J, K, N, seem to still be available in
the first half of the alphabet. Maybe, bonghits.c, gabbleduck.c ?
