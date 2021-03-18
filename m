Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB75340DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCRTKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:10:13 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36222 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhCRTJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:09:55 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lMy1o-00CBXb-FY; Thu, 18 Mar 2021 13:09:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lMy1n-005G50-9e; Thu, 18 Mar 2021 13:09:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     qianli zhao <zhaoqianligood@gmail.com>, christian@brauner.io,
        axboe@kernel.dk, Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
        <20210317143805.GA5610@redhat.com>
        <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
        <20210318180450.GA9977@redhat.com>
Date:   Thu, 18 Mar 2021 14:08:46 -0500
In-Reply-To: <20210318180450.GA9977@redhat.com> (Oleg Nesterov's message of
        "Thu, 18 Mar 2021 19:04:51 +0100")
Message-ID: <m1pmzwb7pd.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lMy1n-005G50-9e;;;mid=<m1pmzwb7pd.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+TtoASd1XmXw5HMxYbwYrSN320qrWPuLw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 487 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.0 (0.8%), b_tie_ro: 2.7 (0.6%), parse: 1.13
        (0.2%), extract_message_metadata: 4.7 (1.0%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 3.1 (0.6%), tests_pri_-950: 1.19 (0.2%),
        tests_pri_-900: 0.91 (0.2%), tests_pri_-90: 169 (34.7%), check_bayes:
        168 (34.4%), b_tokenize: 6 (1.2%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 151 (30.9%), b_finish: 0.72
        (0.1%), tests_pri_0: 289 (59.4%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 1.87 (0.4%), poll_dns_idle: 0.51 (0.1%),
        tests_pri_10: 1.75 (0.4%), tests_pri_500: 5 (1.1%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 03/18, qianli zhao wrote:
>>
>> Hi,Oleg
>>
>> Thank you for your reply.
>>
>> >> When init sub-threads running on different CPUs exit at the same time,
>> >> zap_pid_ns_processe()->BUG() may be happened.
>>
>> > and why do you think your patch can't prevent this?
>>
>> > Sorry, I must have missed something. But it seems to me that you are trying
>> > to fix the wrong problem. Yes, zap_pid_ns_processes() must not be called in
>> > the root namespace, and this has nothing to do with CONFIG_PID_NS.
>>
>> Yes, i try to fix this exception by test SIGNAL_GROUP_EXIT and call
>> panic before setting PF_EXITING to prevent zap_pid_ns_processes()
>> being called when init do_exit().
>
> Ah, I didn't notice your patch does atomic_dec_and_test(signal->live)
> before exit_signals() which sets PF_EXITING. Thanks for correcting me.
>
> So yes, I was wrong, your patch can prevent this. Although I'd like to
> recheck if every do-something-if-group-dead action is correct in the
> case we have a non-PF_EXITING thread...
>
> But then I don't understand the SIGNAL_GROUP_EXIT check added by your
> patch. Do we really need it if we want to avoid zap_pid_ns_processes()
> when the global init exits?
>
>> In addition, the patch also protects the init process state to
>> successfully get usable init coredump.
>
> Could you spell please?
>
> Does this connect to SIGNAL_GROUP_EXIT check? Do you mean that you want
> to panic earlier, before other init's sub-threads exit?

That is my understanding.

As I understand it this patch has two purposes:
1. Avoid the BUG_ON in zap_pid_ns_processes when !CONFIG_PID_NS
2. panic as early as possible so exiting threads don't removing
   interesting debugging state.


It is a bit tricky to tell if the movement of the decrement of
signal->live is safe.  That affects current_is_single threaded
which is used by unshare, setns of the time namespace, and setting
the selinux part of creds.

The usage in kernel/cgroup/cgroup.c:css_task_iter_advance seems safe.
Hmm, Maybe not.  Today cgroup_thread_change_begin is held around
setting PF_EXITING before signal->live is decremented.  So there seem to
be some subtle cgroup dependencies.

The usages of group_dead in do_exit seem safe, as except for the new
one everything is the same.

We could definitely take advantage of knowing group_dead in exit_signals
to simplify it's optimization to not rerouting signals to living
threads.


I think if we are going to move the decrement of signal->live that
should be it's own patch and be accompanied with a good description of
why it is safe instead of having the decrement of signal->live be there
as a side effect of another change.

Eric
