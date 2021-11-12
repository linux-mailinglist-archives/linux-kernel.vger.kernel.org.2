Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5354544E94D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhKLPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:00:35 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:33000 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhKLPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:00:34 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:50636)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlXzn-00HWsa-Qj; Fri, 12 Nov 2021 07:57:39 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:59588 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlXzm-004yOw-NQ; Fri, 12 Nov 2021 07:57:39 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, thuth@redhat.com,
        frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, david@redhat.com, ultrachin@163.com,
        akpm@linux-foundation.org, vbabka@suse.cz, brookxu.cn@gmail.com,
        xiaoggchen@tencent.com, linuszeng@tencent.com, yihuilu@tencent.com,
        mhocko@suse.com, daniel.m.jordan@oracle.com, axboe@kernel.dk,
        legion@kernel.org, peterz@infradead.org, aarcange@redhat.com,
        christian@brauner.io, tglx@linutronix.de
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
        <20211111095008.264412-4-imbrenda@linux.ibm.com>
        <874k8ixzx0.fsf@email.froward.int.ebiederm.org>
        <20211112103439.441b4c12@p-imbrenda>
Date:   Fri, 12 Nov 2021 08:57:13 -0600
In-Reply-To: <20211112103439.441b4c12@p-imbrenda> (Claudio Imbrenda's message
        of "Fri, 12 Nov 2021 10:34:39 +0100")
Message-ID: <87v90xv2uu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mlXzm-004yOw-NQ;;;mid=<87v90xv2uu.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+wBl5g38NSHPTN02ZFFZ0GiUCvSiN8pBE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_08,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4915]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Claudio Imbrenda <imbrenda@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 534 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 9 (1.6%), parse: 1.02 (0.2%),
         extract_message_metadata: 13 (2.4%), get_uri_detail_list: 2.1 (0.4%),
        tests_pri_-1000: 16 (2.9%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 114 (21.3%), check_bayes:
        112 (21.0%), b_tokenize: 9 (1.7%), b_tok_get_all: 11 (2.0%),
        b_comp_prob: 3.6 (0.7%), b_tok_touch_all: 85 (15.9%), b_finish: 0.80
        (0.2%), tests_pri_0: 364 (68.2%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.65 (0.1%), tests_pri_10:
        3.0 (0.6%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC v1 2/4] kernel/fork.c: implement new process_mmput_async syscall
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Imbrenda <imbrenda@linux.ibm.com> writes:

> On Thu, 11 Nov 2021 13:20:11 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> Claudio Imbrenda <imbrenda@linux.ibm.com> writes:
>> 
>> > The goal of this new syscall is to be able to asynchronously free the
>> > mm of a dying process. This is especially useful for processes that use
>> > huge amounts of memory (e.g. databases or KVM guests). The process is
>> > allowed to terminate immediately, while its mm is cleaned/reclaimed
>> > asynchronously.
>> >
>> > A separate process needs use the process_mmput_async syscall to attach
>> > itself to the mm of a running target process. The process will then
>> > sleep until the last user of the target mm has gone.
>> >
>> > When the last user of the mm has gone, instead of synchronously free
>> > the mm, the attached process is awoken. The syscall will then continue
>> > and clean up the target mm.
>> >
>> > This solution has the advantage that the cleanup of the target mm can
>> > happen both be asynchronous and properly accounted for (e.g. cgroups).
>> >
>> > Tested on s390x.
>> >
>> > A separate patch will actually wire up the syscall.  
>> 
>> I am a bit confused.
>> 
>> You want the process report that it has finished immediately,
>> and you want the cleanup work to continue on in the background.
>> 
>> Why do you need a separate process?
>> 
>> Why not just modify the process cleanup code to keep the task_struct
>> running while allowing waitpid to reap the process (aka allowing
>> release_task to run)?  All tasks can be already be reaped after
>> exit_notify in do_exit.
>> 
>> I can see some reasons for wanting an opt-in.  It is nice to know all of
>> a processes resources have been freed when waitpid succeeds.
>> 
>> Still I don't see why this whole thing isn't exit_mm returning
>> the mm_sturct when a flag is set, and then having an exit_mm_late
>> being called and passed the returned mm after exit_notify.
>
> nevermind, exit_notify is done after cgroup_exit, the teardown would
> then not be accounted properly

So you want this new mechanism so you can separate the cleanup from
the exit notification, and so that things are accounted properly.

It would have helped if you had included a link to the previous
conversation.

I think Michal Hoko has a point.  This looks like a job for
"clone(CLONE_VM)" and "prctl(PR_SET_PDEATH_SIG)".  Maybe using a pidfd
instead of the prctl.

AKA just create a child that shares the parents memory, and waits for
the parent to exit and then cleans things up.

That should not need any new kernel mechanisms.



There is the other question: why this is disastrously slow on s390?
Is this a s390 specific issue?  Can the issue be fixed by optimizing
what is happening on s390?

Eric
