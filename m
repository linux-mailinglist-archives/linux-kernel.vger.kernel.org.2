Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F20930F47F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhBDODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhBDN7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:59:24 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156D3C06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y3YvMfYAL6UgrJ9vkGGctIPfcXYu1VvCoq1uURArgQI=; b=2LW3GcAhXz9LNG0iistWQ2pHa+
        6632w7xkeHvCe2570eFslk8aq9C+aJ9ITc+SRW8keQfSFMN7RvQIWZJnuG97CA8H1kq19cZ3tEcE4
        7JNSNVYXNi4YsNYaRCSfCQmm9XYtHybqVY0HHnahYwgFvC2GXyAWZEDxfWbqqHoHqxngJedGonR6r
        aDxSsHbqAvQUu/jUistYlEeTKkcI0p37Bd9cwuf1q+ywgcvyPjbMGIIpoP3fx5q7pVE+yT0Iu+yhb
        bT/Pf9HgNoekPnfWULFtRWXja3MzCxeVuZ6tlAkd5++7IhbFmYKWVkJykLl2OUXfzXIYopcxYv1fg
        duhJ2Apg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7f8f-0008FV-U6; Thu, 04 Feb 2021 13:57:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 763CE3003D8;
        Thu,  4 Feb 2021 14:57:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4902E2C12E919; Thu,  4 Feb 2021 14:57:39 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:57:39 +0100
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
Message-ID: <YBv9Uy1dyv8E2LAz@hirez.programming.kicks-ass.net>
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
> +/* Request the scheduler to share a core */
> +#define PR_SCHED_CORE_SHARE		59
> +# define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
> +# define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
> +# define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */

Why ?

Also, how do I set a unique cookie on myself with this interface?
