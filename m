Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A677844DC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 20:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhKKTXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 14:23:13 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:32866 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhKKTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:23:11 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:35046)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlFcS-00G5IZ-0h; Thu, 11 Nov 2021 12:20:20 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57210 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlFcQ-00AYdr-VM; Thu, 11 Nov 2021 12:20:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, thuth@redhat.com,
        frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, heiko.carstens@de.ibm.com,
        david@redhat.com, ultrachin@163.com, akpm@linux-foundation.org,
        vbabka@suse.cz, brookxu.cn@gmail.com, xiaoggchen@tencent.com,
        linuszeng@tencent.com, yihuilu@tencent.com, mhocko@suse.com,
        daniel.m.jordan@oracle.com, axboe@kernel.dk, legion@kernel.org,
        peterz@infradead.org, aarcange@redhat.com, christian@brauner.io,
        tglx@linutronix.de
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
        <20211111095008.264412-4-imbrenda@linux.ibm.com>
Date:   Thu, 11 Nov 2021 13:20:11 -0600
In-Reply-To: <20211111095008.264412-4-imbrenda@linux.ibm.com> (Claudio
        Imbrenda's message of "Thu, 11 Nov 2021 10:50:06 +0100")
Message-ID: <874k8ixzx0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mlFcQ-00AYdr-VM;;;mid=<874k8ixzx0.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+bxi+7685Pl1xvVwEi+cW0dk+MrWm70bM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_08,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4177]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Claudio Imbrenda <imbrenda@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 492 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.54
        (0.3%), extract_message_metadata: 4.2 (0.9%), get_uri_detail_list:
        1.52 (0.3%), tests_pri_-1000: 4.5 (0.9%), tests_pri_-950: 1.43 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 143 (29.0%), check_bayes:
        141 (28.6%), b_tokenize: 8 (1.6%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 118 (24.0%), b_finish: 0.98
        (0.2%), tests_pri_0: 302 (61.3%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 3.1 (0.6%), poll_dns_idle: 1.06 (0.2%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 12 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC v1 2/4] kernel/fork.c: implement new process_mmput_async syscall
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Imbrenda <imbrenda@linux.ibm.com> writes:

> The goal of this new syscall is to be able to asynchronously free the
> mm of a dying process. This is especially useful for processes that use
> huge amounts of memory (e.g. databases or KVM guests). The process is
> allowed to terminate immediately, while its mm is cleaned/reclaimed
> asynchronously.
>
> A separate process needs use the process_mmput_async syscall to attach
> itself to the mm of a running target process. The process will then
> sleep until the last user of the target mm has gone.
>
> When the last user of the mm has gone, instead of synchronously free
> the mm, the attached process is awoken. The syscall will then continue
> and clean up the target mm.
>
> This solution has the advantage that the cleanup of the target mm can
> happen both be asynchronous and properly accounted for (e.g. cgroups).
>
> Tested on s390x.
>
> A separate patch will actually wire up the syscall.

I am a bit confused.

You want the process report that it has finished immediately,
and you want the cleanup work to continue on in the background.

Why do you need a separate process?

Why not just modify the process cleanup code to keep the task_struct
running while allowing waitpid to reap the process (aka allowing
release_task to run)?  All tasks can be already be reaped after
exit_notify in do_exit.

I can see some reasons for wanting an opt-in.  It is nice to know all of
a processes resources have been freed when waitpid succeeds.

Still I don't see why this whole thing isn't exit_mm returning
the mm_sturct when a flag is set, and then having an exit_mm_late
being called and passed the returned mm after exit_notify.

Or maybe something with schedule_work or task_work, instead of an
exit_mm_late.  I don't see any practical difference.

I really don't see why this needs a whole other process to connect to
the process you care about asynchronously.

This whole thing seems an exercise in spending lots of resources to free
resources much later.

Eric
