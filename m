Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046DA310AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhBEMEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBEMBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:01:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F4C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N+gr+woLTLTNRWLX/vD2ETBGIX1Ifu4DYG7FuQNse1k=; b=hCxamAsHHyDAuVzWIFep9r9AiT
        gQ9TBgt87Ye3nGZDVRVVHs2yT2VHkhxvjJi++AfGfu+HdEAI/heLBOEozSGXvkzlK4eWGtB6pOTrj
        nT8va00Ofe+D7enlu2iUJZ3MF+ph5G5w+4R9zGwmR7EyvDleOsfu7mJHptff1MXheQugPPZcJ8nfy
        auWm0iyq7WPDQbD+8LcDUnlnHmjBJS7M+ZGqqdaJZh3W9LjXHvY7s/XMrloWpQX7h0873VzRqKc5N
        PiDz41u5tfGEWWNuQvpkwhRl3f3dz4aCyhtWo/zWBKi7NdjXfukya0piKU2iYCVp8BNVt8zmh7NI7
        qd0au5MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7zmY-0002BK-0t; Fri, 05 Feb 2021 12:00:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C85C305C1C;
        Fri,  5 Feb 2021 13:00:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31D1E236804AF; Fri,  5 Feb 2021 13:00:11 +0100 (CET)
Date:   Fri, 5 Feb 2021 13:00:11 +0100
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
Message-ID: <YB0zSwrAozzRxhFV@hirez.programming.kicks-ass.net>
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
> +int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
> +{
> +	static DEFINE_MUTEX(sched_core_tasks_mutex);
> +	unsigned long cookie;
> +	int ret = -ENOMEM;
> +
> +	mutex_lock(&sched_core_tasks_mutex);
> +
> +	if (!t2) {
> +		if (t1->core_task_cookie) {
> +			sched_core_put_task_cookie(t1->core_task_cookie);
> +			sched_core_update_task_cookie(t1, 0);
> +			sched_core_put();
> +		}

So this seems to be the bit that implements _CLEAR. ISTR there were
security implications / considerations here.

When the machine is vulnerable to L1TF/MDS and the like, clearing the
cookie would gain privilege and should thus be subject to some checks,
but I can'd find anything.

At the very least that deserves a comment I'm thinking.
