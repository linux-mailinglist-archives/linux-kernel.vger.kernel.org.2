Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0F35052B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhCaRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhCaQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g05R8Yy+XA44utnVM16DiFGbfCNFYBqjlIJvIBrHV+s=;
        b=AP2RWCc7uqgF8xPjD3cW3hZQonVp2AHTVCoPhOufxmRNLEAI1Y44NvyfyzpX/tUS+iYB1e
        3Prht0PLxxbIX+XdUroPrbNgCFUr29a+plkA2j8FK/sA/ZhraiuIhnKn4y3UPissEUtQsK
        BV90T6VdsIgYh6oyXcblP3uh0RwprjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-K9UNeakjNmG2HDEY58K0xA-1; Wed, 31 Mar 2021 12:59:25 -0400
X-MC-Unique: K9UNeakjNmG2HDEY58K0xA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F22D1018F70;
        Wed, 31 Mar 2021 16:59:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.171])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3CF7419D80;
        Wed, 31 Mar 2021 16:59:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 Mar 2021 18:59:23 +0200 (CEST)
Date:   Wed, 31 Mar 2021 18:59:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Hillf Danton <hdanton@sina.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        peterz@infradead.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in register_for_each_vma
Message-ID: <20210331165918.GA10434@redhat.com>
References: <00000000000030aca605be6e0102@google.com>
 <20210327042150.7460-1-hdanton@sina.com>
 <20210328025217.7312-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328025217.7312-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28, Hillf Danton wrote:
>
> On Sat, 27 Mar 2021 18:53:08 Oleg Nesterov wrote:
> >Hi Hillf,
> >
> >it seems that you already understand the problem ;) I don't.
>
> It is simpler than you thought - I always blindly believe what syzbot
> reported is true before it turns out false as I am not smarter than it.
> Feel free to laugh loud.

I am not going to laugh. I too think that lockdep is more clever than me.

> >Could you explain in details how double __register is possible ? and how
>
> Taking another look at the report over five minutes may help more?

No. I spent much, much more time time and I still can't understand your
patch which adds UPROBE_REGISTERING. Quite possibly your patch is fine,
just I am not smart enough.

And I am a bit surprised you refused to help me.

> >it connects to this lockdep report?
>
> Feel free to show the report is false and ignore my noise.

Well, this particular report looks correct but false-positive to me,
_free_event() is not possible, but I can be easily wrong and we need
to shut up lockdep anyway...


-------------------------------------------------------------------------------
Add more CC's. So, we have the following trace

	-> #0 (dup_mmap_sem){++++}-{0:0}:
        check_prev_add kernel/locking/lockdep.c:2936 [inline]
        check_prevs_add kernel/locking/lockdep.c:3059 [inline]
        validate_chain kernel/locking/lockdep.c:3674 [inline]
        __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
        lock_acquire kernel/locking/lockdep.c:5510 [inline]
        lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
        percpu_down_write+0x95/0x440 kernel/locking/percpu-rwsem.c:217
        register_for_each_vma+0x2c/0xc10 kernel/events/uprobes.c:1040
        __uprobe_register+0x5c2/0x850 kernel/events/uprobes.c:1181
        trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
        probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1134
        trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1461
        perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
        perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
        perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
        perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9754
        perf_try_init_event+0x12a/0x560 kernel/events/core.c:11071
        perf_init_event kernel/events/core.c:11123 [inline]
        perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11403
        perf_event_alloc kernel/events/core.c:11785 [inline]
        __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11883
        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
        entry_SYSCALL_64_after_hwframe+0x44/0xae


which shows that this path takes

	event_mutex -> uprobe.register_rwsem -> dup_mmap_sem -> mm.mmap_lock

Not good. If nothing else, perf_mmap_close() path can take event_mutex under
mm.mmap_lock, so lockdep complains correctly.

But why does perf_uprobe_init() take event_mutex? The comment mentions
uprobe_buffer_enable().

If this is the only reason, then why uprobe_buffer_enable/disable abuse
event_mutex?

IOW, can something like the stupid patch below work? (Just in case... yes
it is very suboptimal, I am just trying to understand the problem).

Song, Namhyung, Peter, what do you think?

Oleg.


--- x/kernel/trace/trace_event_perf.c
+++ x/kernel/trace/trace_event_perf.c
@@ -327,16 +327,9 @@ int perf_uprobe_init(struct perf_event *p_event,
 		goto out;
 	}
 
-	/*
-	 * local trace_uprobe need to hold event_mutex to call
-	 * uprobe_buffer_enable() and uprobe_buffer_disable().
-	 * event_mutex is not required for local trace_kprobes.
-	 */
-	mutex_lock(&event_mutex);
 	ret = perf_trace_event_init(tp_event, p_event);
 	if (ret)
 		destroy_local_trace_uprobe(tp_event);
-	mutex_unlock(&event_mutex);
 out:
 	kfree(path);
 	return ret;
--- x/kernel/trace/trace_uprobe.c
+++ x/kernel/trace/trace_uprobe.c
@@ -857,6 +857,7 @@ struct uprobe_cpu_buffer {
 };
 static struct uprobe_cpu_buffer __percpu *uprobe_cpu_buffer;
 static int uprobe_buffer_refcnt;
+static DEFINE_MUTEX(uprobe_buffer_mutex);
 
 static int uprobe_buffer_init(void)
 {
@@ -894,13 +895,13 @@ static int uprobe_buffer_enable(void)
 {
 	int ret = 0;
 
-	BUG_ON(!mutex_is_locked(&event_mutex));
-
+	mutex_lock(&uprobe_buffer_mutex);
 	if (uprobe_buffer_refcnt++ == 0) {
 		ret = uprobe_buffer_init();
 		if (ret < 0)
 			uprobe_buffer_refcnt--;
 	}
+	mutex_unlock(&uprobe_buffer_mutex);
 
 	return ret;
 }
@@ -909,8 +910,7 @@ static void uprobe_buffer_disable(void)
 {
 	int cpu;
 
-	BUG_ON(!mutex_is_locked(&event_mutex));
-
+	mutex_lock(&uprobe_buffer_mutex);
 	if (--uprobe_buffer_refcnt == 0) {
 		for_each_possible_cpu(cpu)
 			free_page((unsigned long)per_cpu_ptr(uprobe_cpu_buffer,
@@ -919,6 +919,7 @@ static void uprobe_buffer_disable(void)
 		free_percpu(uprobe_cpu_buffer);
 		uprobe_cpu_buffer = NULL;
 	}
+	mutex_unlock(&uprobe_buffer_mutex);
 }
 
 static struct uprobe_cpu_buffer *uprobe_buffer_get(void)

