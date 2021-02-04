Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9830F48E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhBDOGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhBDODJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:03:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A40C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VztaVznlyZ8WvSiLqwXtYdsmsMSaitBvK3Cu+lMYbkw=; b=K3XcZhaxMQiaojRgRo5vD9cEN8
        O9y+aTAG+aYLkKn2BQgYNllvjuwx/i3/wDJgeIn58TU3Z2XoBdxu1OjknLSHk6c2l+DAF0Xt8EaLN
        ghOpATEaEzDcmgF+rv5F+8w/ZCxW7vj4YmZXs1+CztWBQtDF/jxW2wVlOi6Vwhq0kLggvp3nCO4qb
        l2RQCl0OKFTW1sc/ZFOCzvvtvGJvDb2bal9qfXX4HcvZ89npwSEsnrc9D1LXNXhvwurODS3JZIgp4
        6MLrt6zJPkbXT1h1aC4BY5yyNfKdnJOm3/7tbALUL1yHOwG2oYLATbK+ghHZ6Kp3oHvJjW6wbgDQs
        lrAgj0fQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7fCS-0000NP-HQ; Thu, 04 Feb 2021 14:01:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA88730066E;
        Thu,  4 Feb 2021 15:01:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B90052C12E919; Thu,  4 Feb 2021 15:01:34 +0100 (CET)
Date:   Thu, 4 Feb 2021 15:01:34 +0100
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
Message-ID: <YBv+Ps8F2eho77qh@hirez.programming.kicks-ass.net>
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

> +#ifdef CONFIG_SCHED_DEBUG
> +	/* Read the group cookie. */
> +	{
> +		.name = "core_group_cookie",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_u64 = cpu_core_group_cookie_read_u64,
> +	},
> +#endif

> +#ifdef CONFIG_SCHED_DEBUG
> +	/* Read the group cookie. */
> +	{
> +		.name = "core_group_cookie",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_u64 = cpu_core_group_cookie_read_u64,
> +	},
> +#endif

AFAICT this leaks kernel pointers. IIRC that was a bad thing.
