Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD27730F460
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhBDN52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbhBDN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:56:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC2C06178B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DiD2UYQ2vcS4PPPHWLsjWMJjVSogeh5wJNa3h5rO1CY=; b=NnzATUNpRVNSOsY8FrBXNrcu54
        MswekwphsKgfAfqRV9+X/gjwlt4eltuOy9xD/TB0CfKh7KuSukcxagOLcr7hVEXGoep5NU+E5qhXF
        XTuLZV/b21gkaPQlKvRMd9WDwUfuTjuzdqJhUNetw0xlNcd6ZMpXrIpCWLK222kWwA/g4DA0/j6LU
        VSS1CC2tYqdZqqyJwCZAsck0PeWs52bNmYGDeyKH9JFHAZYsdgCVn7iBXW/ngUtAset/y9uhFJ++r
        Pazjk1UdeRTvMdMLTVZqzidWL2a5iIh3opCTkuH2DttXurkHTtfEpc0L9pw0IXS+bWONBqvXua75P
        4tKw09qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7f5I-000wig-Gx; Thu, 04 Feb 2021 13:54:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6931F3003D8;
        Thu,  4 Feb 2021 14:54:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 452182C12E917; Thu,  4 Feb 2021 14:54:08 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:54:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
Message-ID: <YBv8gBSKU1MdtXuW@hirez.programming.kicks-ass.net>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123011704.1901835-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>

I'm thinking this is too much credit, I didn't write much of this.

> Marks all tasks in a cgroup as matching for core-scheduling.
> 
> A task will need to be moved into the core scheduler queue when the cgroup
> it belongs to is tagged to run with core scheduling.  Similarly the task
> will need to be moved out of the core scheduler queue when the cgroup
> is untagged.
> 
> Also after we forked a task, its core scheduler queue's presence will
> need to be updated according to its new cgroup's status.
> 
> Use stop machine mechanism to update all tasks in a cgroup to prevent a
> new task from sneaking into the cgroup, and missed out from the update
> while we iterates through all the tasks in the cgroup.  A more complicated
> scheme could probably avoid the stop machine.  Such scheme will also
> need to resovle inconsistency between a task's cgroup core scheduling
> tag and residency in core scheduler queue.
> 
> We are opting for the simple stop machine mechanism for now that avoids
> such complications.
> 
> Core scheduler has extra overhead.  Enable it only for core with
> more than one SMT hardware threads.

Very little actual words on the desired and implemented semantics of the
interface, while the patch contains much non-obvious complication.
