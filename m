Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B464310AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhBELvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhBELoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:44:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA2C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nl7Es33RglJi5M577nsXKOYWkoErq5Nld+CzMmd6CVY=; b=vjafwLoBHmmliGXRQHWIep7BeM
        KIQdRBpfgUdy7T7Sb7qoRiXXq7NHNx0tiqCqPwPQ813WcXHRhwTDQcwHtw9LLCBscx7JGeMgekXOF
        Zp2hEta5uH3qmuesF9uXFfUkb6Goeu11CdSOO78KTySDclh8sVkfEnYyUC1UUwyh7V8zO2clREB/3
        LtZI9DVs92TKfpIJfnunjUcqg85CKyeo3ah3iEsEb7X+fT/H+ZSCkV+WzImqCWEPgJU0OArdoyTTB
        L0w1hbOcBKNpnnaIjU+PlbrwqfXAHCd4bm4q7Ne32v7AeSQpTI/Nuyajup1zrhKraFwkIXdTEJtwR
        keaNGQnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7zUw-002EbY-Vo; Fri, 05 Feb 2021 11:42:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EB26301CC4;
        Fri,  5 Feb 2021 12:41:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81A162BBE1CB0; Fri,  5 Feb 2021 12:41:58 +0100 (CET)
Date:   Fri, 5 Feb 2021 12:41:58 +0100
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
Message-ID: <YB0vBpumsoraM23g@hirez.programming.kicks-ass.net>
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
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -736,6 +736,7 @@ void __put_task_struct(struct task_struct *tsk)
>  	exit_creds(tsk);
>  	delayacct_tsk_free(tsk);
>  	put_signal_struct(tsk->signal);
> +	sched_tsk_free(tsk);
>  
>  	if (!profile_handoff_task(tsk))
>  		free_task(tsk);

> +struct sched_core_task_cookie {
> +	refcount_t refcnt;
> +	struct work_struct work; /* to free in WQ context. */;
> +};

> +static void sched_core_put_cookie_work(struct work_struct *ws);
> +
> +/* Caller has to call sched_core_get() if non-zero value is returned. */
> +static unsigned long sched_core_alloc_task_cookie(void)
> +{
> +	struct sched_core_task_cookie *ck =
> +		kmalloc(sizeof(struct sched_core_task_cookie), GFP_KERNEL);
> +
> +	if (!ck)
> +		return 0;
> +	refcount_set(&ck->refcnt, 1);
> +	INIT_WORK(&ck->work, sched_core_put_cookie_work);
> +
> +	return (unsigned long)ck;
> +}

> +static void sched_core_put_task_cookie(unsigned long cookie)
> +{
> +	struct sched_core_task_cookie *ptr =
> +		(struct sched_core_task_cookie *)cookie;
> +
> +	if (refcount_dec_and_test(&ptr->refcnt))
> +		kfree(ptr);
> +}

> +static void sched_core_put_cookie_work(struct work_struct *ws)
> +{
> +	struct sched_core_task_cookie *ck =
> +		container_of(ws, struct sched_core_task_cookie, work);
> +
> +	sched_core_put_task_cookie((unsigned long)ck);
> +	sched_core_put();
> +}

> +void sched_tsk_free(struct task_struct *tsk)
> +{
> +	struct sched_core_task_cookie *ck;
> +
> +	sched_core_put_cookie((struct sched_core_cookie *)tsk->core_cookie);
> +
> +	if (!tsk->core_task_cookie)
> +		return;
> +
> +	ck = (struct sched_core_task_cookie *)tsk->core_task_cookie;
> +	queue_work(system_wq, &ck->work);
> +}

*groan*.. so the purpose of that work is to be able to disable
core-scheduling after the last such task dies.

Maybe add sched_core_put_async() instead?
