Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83298344E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhCVSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCVSfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:35:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF60CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BnYLpkvlSXiHqmO0XOcDbtxxMVP4XszzvtQMRIoe6/E=; b=QFC71dYafwKTD7mmv8LoESqFYC
        jjtiKIF74NP1KTWzUVCwnxsgM55CWQpXmKIR3+8/svhvsprtawyExP5kSv7eEbS0iprWAgnPRF7Eh
        DZTeboeFE0rJAo+ooqv1YFyAeVWLOLla4+DgHS1tY1js9+OeGCG77UcQQHMafsSvU7sGg1nXOvyD9
        WMBPiaS87Y/NrVvE6KYqJNebhQ5vpeeTCZcym+Fq1oH2q+sTFOeMGSFQBVd+TOMLU5zyvLpeHqMdm
        8BkntYkG0ocxxC6IvGY1ebY0xVRBRK7fLvVAHb8Er5AxUznBtEl8/k36MeSnWgKNwgqOqa3PsrTlu
        vbgECHaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPND-00CGew-I3; Mon, 22 Mar 2021 18:33:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAFD9301A32;
        Mon, 22 Mar 2021 19:33:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E5912BD11CB6; Mon, 22 Mar 2021 19:33:52 +0100 (CET)
Date:   Mon, 22 Mar 2021 19:33:52 +0100
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
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 2/6] sched: tagging interface for core scheduling
Message-ID: <YFjjECKVskE01076@hirez.programming.kicks-ass.net>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-3-joel@joelfernandes.org>
 <20210320154632.GZ4746@worktop.programming.kicks-ass.net>
 <ff9c63f2-0953-03c1-9b1c-25cb90954dee@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9c63f2-0953-03c1-9b1c-25cb90954dee@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:57:48PM -0400, Chris Hyser wrote:
> On 3/20/21 11:46 AM, Peter Zijlstra wrote:
> > On Fri, Mar 19, 2021 at 04:32:49PM -0400, Joel Fernandes (Google) wrote:
> > > From: Josh Don <joshdon@google.com>
> > > 
> > > Adds per-task and per-cgroup interfaces for specifying which tasks can
> > > co-execute on adjacent SMT hyperthreads via core scheduling.
> > > 
> > > The per-task interface hooks are implemented here, but are not currently
> > > used. The following patch adds a prctl interface which then takes
> > > advantage of these.
> > > 
> > > The cgroup interface can be used to toggle a unique cookie value for all
> > > descendent tasks, preventing these tasks from sharing with any others.
> > > See Documentation/admin-guide/hw-vuln/core-scheduling.rst for a full
> > > rundown.
> > > 
> > > One important property of this interface is that neither the per-task
> > > nor the per-cgroup setting overrides the other. For example, if two
> > > tasks are in different cgroups, and one or both of the cgroups is tagged
> > > using the per-cgroup interface, then these tasks cannot share, even if
> > > they use the per-task interface to attempt to share with one another.
> > > 
> > > The above is implemented by making the overall core scheduling cookie a
> > > compound structure, containing both a task-level cookie and a
> > > group-level cookie. Two tasks will only be allowed to share if all
> > > fields of their respective cookies match.
> > > 
> > > Core scheduler has extra overhead.  Enable it only for machines with
> > > more than one SMT hardware thread.
> > 
> > Oh man.. I'd soooo hoped to first see the simple task interface and then
> > see the cgroup patch on top of that... I'll see if I can flip them
> > myself (on monday).
> 
> Peter, given we need to rebase this and we have some cleanup, we can go
> ahead and flip the order if you have not yet done so yet.

I didn't get around to it yet :/ So yes, please! Also can you then split
the selftest thingies?
