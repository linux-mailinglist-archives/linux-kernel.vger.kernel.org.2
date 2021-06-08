Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEA539FA4A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFHPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:24:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51432 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhFHPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:24:13 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 158FMH79040867;
        Wed, 9 Jun 2021 00:22:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Wed, 09 Jun 2021 00:22:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 158FMGgF040862
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 9 Jun 2021 00:22:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
To:     Michal Hocko <mhocko@suse.com>, Aaron Tomlin <atomlin@redhat.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
References: <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz> <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210608100022.pzuwa6aiiffnoikx@ava.usersys.com>
 <YL93eXFZodiCM509@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <931bbf2e-19e3-c598-c244-ae5e7d00dfb0@i-love.sakura.ne.jp>
Date:   Wed, 9 Jun 2021 00:22:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL93eXFZodiCM509@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/06/08 22:58, Michal Hocko wrote:
> I do not see this message to be ever printed on 4.18 for memcg oom:
>         /* Found nothing?!?! Either we hang forever, or we panic. */
>         if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
>                 dump_header(oc, NULL);
>                 panic("Out of memory and no killable processes...\n");
>         }
> 
> So how come it got triggered here? Is it possible that there is a global
> oom killer somehow going on along with the memcg OOM? Because the below
> stack clearly points to a memcg OOM and a new one AFAICS.

4.18 does print this message, and panic() will be called if global OOM
killer invocation were in progress. 

4.18.0-193.51.1.el8.x86_64 is doing

----------
        select_bad_process(oc);
        /* Found nothing?!?! */
        if (!oc->chosen) {
                dump_header(oc, NULL);
                pr_warn("Out of memory and no killable processes...\n");
                /*
                 * If we got here due to an actual allocation at the
                 * system level, we cannot survive this and will enter
                 * an endless loop in the allocator. Bail out now.
                 */
                if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
                        panic("System is deadlocked on memory\n");
        }
----------

and this message is printed when oom_evaluate_task() found that MMF_OOM_SKIP
was already set on all (possibly the only and the last) OOM victims.

----------
static int oom_evaluate_task(struct task_struct *task, void *arg)
{
(...snipped...)
        /*
         * This task already has access to memory reserves and is being killed.
         * Don't allow any other task to have access to the reserves unless
         * the task has MMF_OOM_SKIP because chances that it would release
         * any memory is quite low.
         */
        if (!is_sysrq_oom(oc) && tsk_is_oom_victim(task)) {
                if (test_bit(MMF_OOM_SKIP, &task->signal->oom_mm->flags))
                        goto next;
                goto abort;
        }
(...snipped...)
next:
        return 0;
(...snipped...)
}
----------

Since dump_tasks() from dump_header(oc, NULL) does not exclude tasks
which already has MMF_OOM_SKIP set, it is possible that the last OOM
killable victim was already OOM killed but the OOM reaper failed to reclaim
memory and set MMF_OOM_SKIP. (Well, maybe we want to exclude (or annotate)
MMF_OOM_SKIP tasks when showing OOM victim candidates...)

Therefore,

> 
> That being said, a full chain of oom events would be definitely useful
> to get a better idea.

I think checking whether

        pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
                task_pid_nr(tsk), tsk->comm);

and/or

        pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
                        task_pid_nr(tsk), tsk->comm,
                        K(get_mm_counter(mm, MM_ANONPAGES)),
                        K(get_mm_counter(mm, MM_FILEPAGES)),
                        K(get_mm_counter(mm, MM_SHMEMPAGES)));

message was already printed prior to starting infinite
"Out of memory and no killable processes..." looping
(this message is repeated forever, isn't it?) will be useful.

Note that neither of these messages will be printed if hitting

----------
        /*
         * If the mm has invalidate_{start,end}() notifiers that could block,
         * sleep to give the oom victim some more time.
         * TODO: we really want to get rid of this ugly hack and make sure that
         * notifiers cannot block for unbounded amount of time
         */
        if (mm_has_blockable_invalidate_notifiers(mm)) {
                up_read(&mm->mmap_sem);
                schedule_timeout_idle(HZ);
                return true;
        }
----------

case, and also dmesg available in the vmcore might be too late to examine.
Maybe better to check /var/log/messages instead of vmcore file.

