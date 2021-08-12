Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F413EA7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbhHLPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232854AbhHLPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628783230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbiO+MMva1fa8LvmVgmRyZgOmFEpvjj/UPm96j5b36w=;
        b=ZlTIC8pL7aIZ6GUjbEoSxD8Ke1dEHLy3gdHtbeoZxPQloa79vWIAUuj/5Y98XWXp0jVva6
        ppsqGCgDr6Ebj19iVo20lL6/2x5ojRm07KpDMRirUT3PnzTw9jtqYjpdY/N8LuUd+040qz
        OwgRCO4iI2JJP10HEVVaeTUuFjhdwD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47--wulLrj2NJyuBjQkfQcq6w-1; Thu, 12 Aug 2021 11:47:08 -0400
X-MC-Unique: -wulLrj2NJyuBjQkfQcq6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C0F1082922;
        Thu, 12 Aug 2021 15:47:07 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D80571B5C0;
        Thu, 12 Aug 2021 15:46:58 +0000 (UTC)
Date:   Thu, 12 Aug 2021 11:46:56 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Shirish S <shirish.s@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: print column titles of show_state_filter()
Message-ID: <YRVCcKcqPQz9VHZL@lorien.usersys.redhat.com>
References: <20210812140934.87476-1-shirish.s@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812140934.87476-1-shirish.s@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 12, 2021 at 07:39:34PM +0530 Shirish S wrote:
> This addition in the debug output shall improve readablitly..
> Its not intuitive for users that the pid printed in last column
> is of parent process.
> 
> Without this patch:
> 	localhost ~ # dmesg -w &
> 	localhost ~ # echo w > /proc/sysrq-trigger
> 	[22148.730225] sysrq: Show Blocked State
> 	localhost ~ #
> 
> With this patch:
> 	localhost ~ # dmesg -w &
> 	localhost ~ # echo w > /proc/sysrq-trigger
> 	[   99.979365] sysrq: Show Blocked State
> -->	[   99.983471]   task                        PC stack   pid father
> 	localhost ~ #

Thanks. Probably want to update this "father" too.

And as Steve said, maybe a line or 2 of actual data?

Cheers,
Phil

> 
> v2: Dropped #ifdef logic
> v3: Sample output in commit message
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 20ffcc044134..d9c7014870d5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8174,6 +8174,9 @@ void show_state_filter(unsigned int state_filter)
>  {
>  	struct task_struct *g, *p;
>  
> +	pr_info("  task%*s", BITS_PER_LONG == 32 ? 38 : 46,
> +		"PC stack   ppid\n");
> +
>  	rcu_read_lock();
>  	for_each_process_thread(g, p) {
>  		/*
> -- 
> 2.17.1
> 

-- 

