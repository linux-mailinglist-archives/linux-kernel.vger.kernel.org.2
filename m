Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41D93AFD17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFVGgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhFVGgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624343656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=51tMBAdUEeHRgckbJmhxfUqrbmN0kqw76xvf9UF6WQg=;
        b=ZAmBeAwCsucPm1sE1qK6HhlNvRa/iMbgb8V91iMkPdm0nfE34axgZIaZGtT+0abEua34IO
        yScngSFPfD20i6RR9zbbR/jGPKKUQv6vmogRVsxc20vLLHgvtQP4gp89VLjeNp0gtiw2+T
        zd/vrdGE3nG5Wf6wz2/2CcI0uIhIrHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-G-U7zedxNiiG-hx6P8ia0A-1; Tue, 22 Jun 2021 02:34:12 -0400
X-MC-Unique: G-U7zedxNiiG-hx6P8ia0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51826800C60;
        Tue, 22 Jun 2021 06:34:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE1385D6AD;
        Tue, 22 Jun 2021 06:34:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Jun 2021 08:34:09 +0200 (CEST)
Date:   Tue, 22 Jun 2021 08:34:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+0bac5fec63d4f399ba98@syzkaller.appspotmail.com>,
        axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        elver@google.com, linux-kernel@vger.kernel.org, pcc@google.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] signal: Prevent sigqueue caching after task got released
Message-ID: <20210622063405.GA7570@redhat.com>
References: <000000000000148b4b05c419cbbb@google.com>
 <878s32g6j5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s32g6j5.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22, Thomas Gleixner wrote:
>
> syzbot reported a memory leak related to sigqueue caching. This happens
> when a thread group leader with child tasks is reaped.
>
> The group leader's sigqueue_cache is correctly freed. The group leader then
> reaps the child tasks and if any of them has a signal pending it caches
> that signal.

I guess you mean the race with exit_notify() ? Could you spell please?
I am just curious how exactly this problem was found.

This doesn't really matter, because damn yes, a task T can call
release_task(another_task)->sigqueue_cache_or_free() after
exit_task_sigqueue_cache(T) was already called. For example, a last non-leader
thread exits and reaps a zombie leader.

Somehow I thought that exit_task_sigqueue_cache() at the end of __exit_signal()
should fix this problem, but this is obviously wrong.


> @@ -463,13 +469,18 @@ void exit_task_sigqueue_cache(struct tas
>  	struct sigqueue *q = tsk->sigqueue_cache;
>  
>  	if (q) {
> -		tsk->sigqueue_cache = NULL;
>  		/*
>  		 * Hand it back to the cache as the task might
>  		 * be self reaping which would leak the object.
>  		 */
>  		 kmem_cache_free(sigqueue_cachep, q);
>  	}
> +
> +	/*
> +	 * Set an error pointer to ensure that @tsk will not cache a
> +	 * sigqueue when it is reaping it's child tasks
> +	 */
> +	tsk->sigqueue_cache = ERR_PTR(-1);
>  }


Reviewed-by: Oleg Nesterov <oleg@redhat.com>

