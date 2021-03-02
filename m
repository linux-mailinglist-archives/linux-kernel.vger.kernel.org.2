Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB50432A0B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576397AbhCBE2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348837AbhCBBZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:25:54 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4120C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 17:25:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so12711001pfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 17:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w2cDiHHglHuB5mGGdEuC7VQLUN/CSTFV8JDYjWUbTgg=;
        b=zEhsTynx85JLmRtT08BID+SxvX6bd+PFxk03gGyaACQM3T+IJ+BbntOVtkixIt2ZGf
         N3zHoZQOxZmc6MQ6AmWJ8xNrRuBLLzXeKZJDpWGqLokfMlTxXy5sQwv+XU2zL55OkWz7
         OdZsdq50wKAjgE3eMoCl7c5yEJKQ1bP5S9gn8FohUfD0KjhpSsakkcrbvBSzi37X6Py7
         raQ9aei/yvdnXKytrGUTXDAMXyfUh714zH2OcH+mlaZkLVEEI5QH5kNIaAYAIE84tWQG
         R2Z9ru6nH7mTFKfG4b9aM2wTi9+fzUF+cIZPQQ8sYErpEvTm/AVFhreH8WLaR6tK22Pw
         6FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w2cDiHHglHuB5mGGdEuC7VQLUN/CSTFV8JDYjWUbTgg=;
        b=fbAwCIjfS4VqF1I7e52cDNamDiaYttol1ppR26PwF4EIyTG/CbDqNlotDvKiHTo0/C
         qdNTi96Po3rbm7IHitr0FoDK9QRceVswSTt4Z/1HAC1b26/oZLwQEtS4rOeqf/iPuaG0
         WslIPF6VrPkh4JmZuQ65uqu3xVO/awT56MsJtQbGA15Ds5vPOSbOa4d7CxijOEOHgMnd
         uOE0IVlloUKxCfWEpBu1uCg/3829C2eVtsO2GU9UE3SKMettR32BxGALfV1MfZ32n/WW
         sQ80wu9GzNEUOTOrWtlxQoIkUQ9A0QUMz1YaAxogpPTqLbx8SkZ7CGqE3mufa47KMZDw
         v0rA==
X-Gm-Message-State: AOAM530Ct2QbezhFJxZbdf8RYuSr9zje2AkOFN8GhU3yKdLnf8Uso0p1
        a0wAE9NSQ+0BLlD3qZwuhvrURPoplw+4Nw==
X-Google-Smtp-Source: ABdhPJxH6uC0qV7oFW6rBJnGXPGIKEfpsCPJGj3yzDEordOJsjs8FPNFs1Non+jjQrhZ4cazRDo28Q==
X-Received: by 2002:a63:6402:: with SMTP id y2mr15943951pgb.106.1614648309053;
        Mon, 01 Mar 2021 17:25:09 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a9sm681822pjq.17.2021.03.01.17.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 17:25:08 -0800 (PST)
Subject: Re: 5.12-rc1 regression: freezing iou-mgr/wrk failed
From:   Jens Axboe <axboe@kernel.dk>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <1614646241.av51lk2de4.none.ref@localhost>
 <1614646241.av51lk2de4.none@localhost>
 <ad672889-2757-142b-9259-3e0aee6d8078@kernel.dk>
Message-ID: <fd148797-d8cb-7597-8612-83ddfafac425@kernel.dk>
Date:   Mon, 1 Mar 2021 18:25:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ad672889-2757-142b-9259-3e0aee6d8078@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 6:11 PM, Jens Axboe wrote:
> On 3/1/21 5:57 PM, Alex Xu (Hello71) wrote:
>> Hi,
>>
>> On Linux 5.12-rc1, I am unable to suspend to RAM. The system freezes for 
>> about 40 seconds and then continues operation. The following messages 
>> are printed to the kernel log:
>>
>> [  240.650300] PM: suspend entry (deep)
>> [  240.650748] Filesystems sync: 0.000 seconds
>> [  240.725605] Freezing user space processes ...
>> [  260.739483] Freezing of tasks failed after 20.013 seconds (3 tasks refusing to freeze, wq_busy=0):
>> [  260.739497] task:iou-mgr-446     state:S stack:    0 pid:  516 ppid:   439 flags:0x00004224
>> [  260.739504] Call Trace:
>> [  260.739507]  ? sysvec_apic_timer_interrupt+0xb/0x81
>> [  260.739515]  ? pick_next_task_fair+0x197/0x1cde
>> [  260.739519]  ? sysvec_reschedule_ipi+0x2f/0x6a
>> [  260.739522]  ? asm_sysvec_reschedule_ipi+0x12/0x20
>> [  260.739525]  ? __schedule+0x57/0x6d6
>> [  260.739529]  ? del_timer_sync+0xb9/0x115
>> [  260.739533]  ? schedule+0x63/0xd5
>> [  260.739536]  ? schedule_timeout+0x219/0x356
>> [  260.739540]  ? __next_timer_interrupt+0xf1/0xf1
>> [  260.739544]  ? io_wq_manager+0x73/0xb1
>> [  260.739549]  ? io_wq_create+0x262/0x262
>> [  260.739553]  ? ret_from_fork+0x22/0x30
>> [  260.739557] task:iou-mgr-517     state:S stack:    0 pid:  522 ppid:   439 flags:0x00004224
>> [  260.739561] Call Trace:
>> [  260.739563]  ? sysvec_apic_timer_interrupt+0xb/0x81
>> [  260.739566]  ? pick_next_task_fair+0x16f/0x1cde
>> [  260.739569]  ? sysvec_apic_timer_interrupt+0xb/0x81
>> [  260.739571]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>> [  260.739574]  ? __schedule+0x5b7/0x6d6
>> [  260.739578]  ? del_timer_sync+0x70/0x115
>> [  260.739581]  ? schedule_timeout+0x211/0x356
>> [  260.739585]  ? __next_timer_interrupt+0xf1/0xf1
>> [  260.739588]  ? io_wq_check_workers+0x15/0x11f
>> [  260.739592]  ? io_wq_manager+0x69/0xb1
>> [  260.739596]  ? io_wq_create+0x262/0x262
>> [  260.739600]  ? ret_from_fork+0x22/0x30
>> [  260.739603] task:iou-wrk-517     state:S stack:    0 pid:  523 ppid:   439 flags:0x00004224
>> [  260.739607] Call Trace:
>> [  260.739609]  ? __schedule+0x5b7/0x6d6
>> [  260.739614]  ? schedule+0x63/0xd5
>> [  260.739617]  ? schedule_timeout+0x219/0x356
>> [  260.739621]  ? __next_timer_interrupt+0xf1/0xf1
>> [  260.739624]  ? task_thread.isra.0+0x148/0x3af
>> [  260.739628]  ? task_thread_unbound+0xa/0xa
>> [  260.739632]  ? task_thread_bound+0x7/0x7
>> [  260.739636]  ? ret_from_fork+0x22/0x30
>> [  260.739647] OOM killer enabled.
>> [  260.739648] Restarting tasks ... done.
>> [  260.740077] PM: suspend exit
>>
>> and then a set of similar messages except with s2idle instead of deep.
>>
>> Reverting 5695e51619 ("Merge tag 'io_uring-worker.v3-2021-02-25' of 
>> git://git.kernel.dk/linux-block") appears to resolve the issue. I have 
>> not yet bisected further. Let me know which troubleshooting steps I 
>> should perform next.
> 
> Can you try and pull in:
> 
> git://git.kernel.dk/linux-block io_uring-5.12
> 
> and see if that resolves it? I usually always run -git on my laptop as
> well, but something broke it in the merge window so I need to figure
> out what that is first...
> 
> What distro are you running?

You probably want this on top...


diff --git a/fs/io-wq.c b/fs/io-wq.c
index 1fdb2b621b51..a763e1b09073 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -567,7 +567,7 @@ static int task_thread(void *data, int index)
 	worker->task = current;
 
 	set_cpus_allowed_ptr(current, cpumask_of_node(wqe->node));
-	current->flags |= PF_NO_SETAFFINITY;
+	current->flags |= PF_NO_SETAFFINITY | PF_NOFREEZE;
 
 	raw_spin_lock_irq(&wqe->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list);
@@ -722,7 +722,7 @@ static int io_wq_manager(void *data)
 
 	sprintf(buf, "iou-mgr-%d", wq->task_pid);
 	set_task_comm(current, buf);
-	current->flags |= PF_IO_WORKER;
+	current->flags |= PF_IO_WORKER | PF_NOFREEZE;
 	wq->manager = get_task_struct(current);
 
 	complete(&wq->started);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2757675ab417..e7aaf56b4dea 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6679,6 +6685,7 @@ static int io_sq_thread(void *data)
 	set_task_comm(current, buf);
 	sqd->thread = current;
 	current->pf_io_worker = NULL;
+	current->flags |= PF_NOFREEZE;
 
 	if (sqd->sq_cpu != -1)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));

-- 
Jens Axboe

