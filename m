Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969503392D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhCLQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:12:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbhCLQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615565528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q0ZLKm22VzjnGNccJiybRGoEZMoAdDQLE4Y7IRxbG8c=;
        b=dl2tH/BW7e1WjqKgUUd1EEKFOQJkyFOdaUiCkkCcg5S6fh/vXcDz+GZTYur2EeDNUPtc32
        4Nu78IAKsfOXWLsHg1kZhkp+LjbSHbKwnowfHXTT4BERCoRvZw1SPnuNej0EbwDbZmJtcz
        S+65GlwVP12M5HHDFh1eaUNMf7Rcv3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-ApRPWfc8OGOPYG4ohn3f0A-1; Fri, 12 Mar 2021 11:12:05 -0500
X-MC-Unique: ApRPWfc8OGOPYG4ohn3f0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 694E28015BD;
        Fri, 12 Mar 2021 16:12:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id 44F6E5D6D7;
        Fri, 12 Mar 2021 16:11:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 12 Mar 2021 17:12:02 +0100 (CET)
Date:   Fri, 12 Mar 2021 17:11:51 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch V2 3/3] signal: Allow tasks to cache one sigqueue struct
Message-ID: <20210312161148.GA25946@redhat.com>
References: <20210311132036.228542540@linutronix.de>
 <20210311141704.424120350@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311141704.424120350@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11, Thomas Gleixner wrote:
>
> @@ -456,7 +460,12 @@ static void __sigqueue_free(struct sigqu
>  		return;
>  	if (atomic_dec_and_test(&q->user->sigpending))
>  		free_uid(q->user);
> -	kmem_cache_free(sigqueue_cachep, q);
> +
> +	/* Cache one sigqueue per task */
> +	if (!current->sigqueue_cache)
> +		current->sigqueue_cache = q;
> +	else
> +		kmem_cache_free(sigqueue_cachep, q);
>  }

This doesn't look right, note that __exit_signal() does
flush_sigqueue(&sig->shared_pending) at the end, after exit_task_sighand()
was already called.

I'd suggest to not add the new exit_task_sighand() helper and simply free
current->sigqueue_cache at the end of __exit_signal().

Oleg.

