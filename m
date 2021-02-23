Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC56432277F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhBWJIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhBWJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:08:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D095C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=90CYvbRkeTtw2LjHxZUF9fRU7+4Z7FPgkvOsHErySow=; b=n13MigGwlenLA9Izui3+NOrScn
        QKrPaD75AzEo96ZYQcdh/80/x0Xo0u0FyAdUcn+bSPDg45RnATGbuMxli40MBFzco9me/hdTR3vl/
        1NSHF2a3luZR/NYtrZ7MfbM6mita8J6N6IOzAm4qGAasVLUpos916s7wlwjs1MhdNka9INVBwh6nw
        hpP/F6f0LgzttRpqdXYpJXrp5afsvnZMra1pursiUjvn+dyr9H8yAzzpu+sXT279c4T1XBFAfq+0x
        nsQk2tmiQIBG7IBvnhpNkD9yFik+adXET0xVh8v3i3y8mTZTTOtNa93shrVK+FW/THS93yto0/4l3
        4zB6g+Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lETdN-007kad-Jv; Tue, 23 Feb 2021 09:05:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF3DD30477A;
        Tue, 23 Feb 2021 10:05:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DD732BF456FC; Tue, 23 Feb 2021 10:05:29 +0100 (CET)
Date:   Tue, 23 Feb 2021 10:05:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
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
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
Message-ID: <YDTFWZPdmrDuYd91@hirez.programming.kicks-ass.net>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:00:37PM -0500, Chris Hyser wrote:
> On 1/22/21 8:17 PM, Joel Fernandes (Google) wrote:
> While trying to test the new prctl() code I'm working on, I ran into a bug I
> chased back into this v10 code. Under a fair amount of stress, when the
> function __sched_core_update_cookie() is ultimately called from
> sched_core_fork(), the system deadlocks or otherwise non-visibly crashes.
> I've not had much success figuring out why/what. I'm running with LOCKDEP on
> and seeing no complaints. Duplicating it only requires setting a cookie on a
> task and forking a bunch of threads ... all of which then want to update
> their cookie.

Can you share the code and reproducer?
