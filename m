Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE930F532
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhBDOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbhBDOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:37:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F178C06178B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/GkRez+1PkbxCa9YZ0etbBj2+WDcPws6GaLqihnkBkI=; b=nxoDtgTgihpE2ub7zFWbF/sgL7
        uNuzJjFRXFWPNTtf4HCd7PElFKrdRtu78G2+duqtZ3wYldcYQk2kI32WDZAQJmkl0ISqPW+zLGqp1
        pGt7oZoF2sKYomC8+XjYh057ydZ7A4cB2ySoNwT/151pXOWp1dUFLH4btrh3kj6Fqwp4zEOh6Xlhh
        ahv3CHVxizgdkHihJ6rU0437QoqchJ4s3LujF9PInQgLmN0zxQSNWmzQnQjzLSpfPvd4ItaesM5F4
        +LZ6nh+mirSRbdpbznhKzguPo8pkDJ+6DIZ9Gpy+99nRaqPhcwS55MnjPnHyhSI7kKqpk+LBRPAk3
        l5ki/I6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7fjf-0003Yg-Ui; Thu, 04 Feb 2021 14:35:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11A08301CC4;
        Thu,  4 Feb 2021 15:35:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E582A2C1C47A2; Thu,  4 Feb 2021 15:35:50 +0100 (CET)
Date:   Thu, 4 Feb 2021 15:35:50 +0100
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
Message-ID: <YBwGRpnISmwkJ2i8@hirez.programming.kicks-ass.net>
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
> +static inline void __sched_core_erase_cookie(struct sched_core_cookie *cookie)
> +{
> +	lockdep_assert_held(&sched_core_cookies_lock);
> +
> +	/* Already removed */
> +	if (RB_EMPTY_NODE(&cookie->node))
> +		return;
> +
> +	rb_erase(&cookie->node, &sched_core_cookies);
> +	RB_CLEAR_NODE(&cookie->node);
> +}
> +
> +/* Called when a task no longer points to the cookie in question */
> +static void sched_core_put_cookie(struct sched_core_cookie *cookie)
> +{
> +	unsigned long flags;
> +
> +	if (!cookie)
> +		return;
> +
> +	if (refcount_dec_and_test(&cookie->refcnt)) {
> +		raw_spin_lock_irqsave(&sched_core_cookies_lock, flags);
> +		__sched_core_erase_cookie(cookie);
> +		raw_spin_unlock_irqrestore(&sched_core_cookies_lock, flags);
> +		kfree(cookie);
> +	}
> +}

> +static void __sched_core_update_cookie(struct task_struct *p)
> +{

> +	raw_spin_lock(&sched_core_cookies_lock);

> +		/*
> +		 * Cookie exists, increment refcnt. If refcnt is currently 0,
> +		 * we're racing with a put() (refcnt decremented but cookie not
> +		 * yet removed from the tree). In this case, we can simply
> +		 * perform the removal ourselves and retry.
> +		 * sched_core_put_cookie() will still function correctly.
> +		 */
> +		if (unlikely(!refcount_inc_not_zero(&match->refcnt))) {
> +			__sched_core_erase_cookie(match);
> +			goto retry;
> +		}

refcount_dec_and_lock() avoids that complication.
