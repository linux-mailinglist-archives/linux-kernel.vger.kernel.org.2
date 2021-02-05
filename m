Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893DB310AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBEL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhBELzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:55:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B14C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ae5DQR4ZoHUZ8GoUSPLSVluq4lgx/12YQSO36BQONXk=; b=iqvj0gy3tOUtgw050OYxxZYsKG
        k/nqHlhVzSvRCyDDu3tJzX7eAlG80gGOLZvEpVN2AywuJuRNI9DRXAogntHfbkyL85SvrtuMd1JZ0
        bovinx2osD8NgjksjtTbqdj6cIg27f9JozRJUOSbS+v6buRAJOXZfEAjMf+ERUqC3Km45PPQgfAIE
        Mgo5E9eSDF3HYVwbj/98QXTJhcUhmYauRsf+ls1JHQBt3xHOY1IwOf74JeMu6XgbtQEwG7blxMeLz
        ccdHc2ufgFe9diHqtP+w31/UbDNY8TZPlLeBfn0Aj2hRh2nda4XlgaLT/nrP7XoCl48OaSbGR49aX
        mwsNBGKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7zf8-002FHo-V9; Fri, 05 Feb 2021 11:52:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9011305C1C;
        Fri,  5 Feb 2021 12:52:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB1CB2BBE1CB1; Fri,  5 Feb 2021 12:52:32 +0100 (CET)
Date:   Fri, 5 Feb 2021 12:52:32 +0100
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
Message-ID: <YB0xgL5x1RM7DJ49@hirez.programming.kicks-ass.net>
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

> +/* All active sched_core_cookies */
> +static struct rb_root sched_core_cookies = RB_ROOT;
> +static DEFINE_RAW_SPINLOCK(sched_core_cookies_lock);

> +/*
> + * Returns the following:
> + * a < b  => -1
> + * a == b => 0
> + * a > b  => 1
> + */
> +static int sched_core_cookie_cmp(const struct sched_core_cookie *a,
> +				 const struct sched_core_cookie *b)
> +{
> +#define COOKIE_CMP_RETURN(field) do {		\
> +	if (a->field < b->field)		\
> +		return -1;			\
> +	else if (a->field > b->field)		\
> +		return 1;			\
> +} while (0)					\
> +
> +	COOKIE_CMP_RETURN(task_cookie);
> +	COOKIE_CMP_RETURN(group_cookie);
> +
> +	/* all cookie fields match */
> +	return 0;
> +
> +#undef COOKIE_CMP_RETURN
> +}

AFAICT all this madness exists because cgroup + task interaction, yet
none of that code is actually dependent on cgroups being on.

So this seems to implement semantics that will make two tasks that share
a cookie, but are then placed in different cgroups not actually share.

Is that desired? Can we justify these semantics and the resulting code
complexity.
