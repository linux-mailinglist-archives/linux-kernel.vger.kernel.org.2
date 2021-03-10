Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88E33344D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhCJRKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:10:22 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:49156 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhCJRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:10:07 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK2LN-00E697-2Y; Wed, 10 Mar 2021 10:09:57 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK2LL-000QlE-92; Wed, 10 Mar 2021 10:09:56 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Filippo Sironi <sironi@amazon.de>
Cc:     <linux-kernel@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <christian.brauner@ubuntu.com>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>, <keescook@chromium.org>,
        <krisman@collabora.com>, <peterx@redhat.com>, <axboe@kernel.dk>,
        <surenb@google.com>, <shakeelb@google.com>, <guro@fb.com>,
        <elver@google.com>
References: <20210310123703.27894-1-sironi@amazon.de>
Date:   Wed, 10 Mar 2021 11:09:58 -0600
In-Reply-To: <20210310123703.27894-1-sironi@amazon.de> (Filippo Sironi's
        message of "Wed, 10 Mar 2021 13:37:02 +0100")
Message-ID: <m1pn07rl3t.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lK2LL-000QlE-92;;;mid=<m1pn07rl3t.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19mcqpwDm93cSui+dUoiUk0SpN8vkf2Q9I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_12,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Filippo Sironi <sironi@amazon.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 734 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.4 (0.5%), b_tie_ro: 2.3 (0.3%), parse: 0.95
        (0.1%), extract_message_metadata: 3.3 (0.5%), get_uri_detail_list:
        1.36 (0.2%), tests_pri_-1000: 4.0 (0.5%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 119 (16.2%), check_bayes:
        118 (16.0%), b_tokenize: 8 (1.1%), b_tok_get_all: 7 (1.0%),
        b_comp_prob: 2.3 (0.3%), b_tok_touch_all: 97 (13.2%), b_finish: 0.68
        (0.1%), tests_pri_0: 585 (79.8%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 380 (51.8%), poll_dns_idle: 379 (51.6%),
        tests_pri_10: 1.60 (0.2%), tests_pri_500: 5 (0.7%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [RFC PATCH] mm: fork: Prevent a NULL deref by getting mm only if the refcount isn't 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filippo Sironi <sironi@amazon.de> writes:

> We've seen a number of crashes with the following signature:
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     ...
>     Oops: 0000 [#1] SMP PTI
>     ...
>     RIP: 0010:__rb_erase_color+0xc2/0x260
>     ...
>     Call Trace:
>      unlink_file_vma+0x36/0x50
>      free_pgtables+0x62/0x110
>      exit_mmap+0xd5/0x160
>      ? put_dec+0x3a/0x90
>      ? num_to_str+0xa8/0xc0
>      mmput+0x11/0xb0
>      do_task_stat+0x940/0xc80
>      proc_single_show+0x49/0x80
>      ? __check_object_size+0xcc/0x1a0
>      seq_read+0xd3/0x400
>      vfs_read+0x72/0xb0
>      ksys_read+0x9c/0xd0
>      do_syscall_64+0x69/0x400
>      ? schedule+0x2a/0x90
>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     ...
>
> This happens when a process goes through the tasks stats in procfs while
> another is exiting.  This looks like a race where the process that's
> exiting drops the last reference on the mm (with mmput) while the other
> increases it (with mmget).  By only increasing when the reference isn't
> 0 to begin with, we prevent this from happening.

For this to be a race with exit this would require racing with exit_mm
where current->mm is cleared.

Looking at exit_mm() the code does:

	struct mm_struct *mm = current->mm;

	mmap_read_lock(mm);
	mmgrab(mm);
        task_lock(current);
	local_irq_disable();
        current->mm = NULL;
        local_irq_enable();
        task_unlock(current);
        mmap_read_unlock(mm);

	mmput(mm);

Which seems to guarantee "mm_users > 0" if "task->mm != NULL" under
tasklist_lock.

So I suggest you instrument your failing kernels and find what is
improperly decrementing mm_users.

Eric
