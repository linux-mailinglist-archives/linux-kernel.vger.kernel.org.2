Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22388334B42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhCJWNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:13:24 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:60958 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCJWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:13:05 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK74h-00DtU4-9O; Wed, 10 Mar 2021 15:13:03 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK74f-001ESM-Lp; Wed, 10 Mar 2021 15:13:02 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     qianli zhao <zhaoqianligood@gmail.com>, christian@brauner.io,
        axboe@kernel.dk, Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
References: <1615296712-175334-1-git-send-email-zhaoqianligood@gmail.com>
        <20210309182657.GA1408@redhat.com>
        <CAPx_LQEQto2fget=kCnfjSCdAp9XCwc2AWgzwxpbxdyCgNs5Mg@mail.gmail.com>
        <m1lfavufep.fsf@fess.ebiederm.org> <20210310173236.GB8973@redhat.com>
Date:   Wed, 10 Mar 2021 16:13:06 -0600
In-Reply-To: <20210310173236.GB8973@redhat.com> (Oleg Nesterov's message of
        "Wed, 10 Mar 2021 18:32:37 +0100")
Message-ID: <m1zgzamzd9.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lK74f-001ESM-Lp;;;mid=<m1zgzamzd9.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19JTdV5RIzKGymacZ8wCcU3mj4/k7hHExw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1020 ms - load_scoreonly_sql: 0.26 (0.0%),
        signal_user_changed: 13 (1.2%), b_tie_ro: 10 (1.0%), parse: 0.96
        (0.1%), extract_message_metadata: 3.5 (0.3%), get_uri_detail_list:
        1.07 (0.1%), tests_pri_-1000: 5 (0.5%), tests_pri_-950: 1.46 (0.1%),
        tests_pri_-900: 1.40 (0.1%), tests_pri_-90: 739 (72.5%), check_bayes:
        737 (72.3%), b_tokenize: 6 (0.6%), b_tok_get_all: 631 (61.8%),
        b_comp_prob: 2.4 (0.2%), b_tok_touch_all: 93 (9.1%), b_finish: 1.09
        (0.1%), tests_pri_0: 230 (22.6%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.6 (0.3%), poll_dns_idle: 0.47 (0.0%), tests_pri_10:
        3.0 (0.3%), tests_pri_500: 12 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exit: trigger panic when init process is set to SIGNAL_GROUP_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 03/10, Eric W. Biederman wrote:
>>
>> 	/* If global init has exited,
>>          * panic immediately to get a useable coredump.
>>          */
>> 	if (unlikely(is_global_init(tsk) &&
>> 	    (thread_group_empty(tsk) ||
>>             (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
>> 		panic("Attempted to kill init!	exitcode=0x%08x\n",
>>                 	tsk->signal->group_exit_code ?: (int)code);
>> 	}
>>
>> The thread_group_empty test is needed to handle single threaded
>> inits.
>
> But we can't rely on thread_group_empty(). Just suppose that the main
> thread exit first, then the 2nd (last) thread exits too.

It took me a minute.  I think you are pointing out that there is a case
where we do not set SIGNAL_GROUP_EXIT and that init actually exits.

The case where all of the threads do pthread_exit() aka do_exit().

I think that implies that to have a comprehensive test would
need to do:

	group_dead = atomic_dec_and_test(&tsk->signal->live);

	/* If global init has exited,
	 * panic immediately to get a useable coredump.
	*/
	if (unlikely(is_global_init(tsk) &&
	    (group_dead || thread_group_empty(tsk) ||
             (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
		panic("Attempted to kill init!	exitcode=0x%08x\n",
		tsk->signal->group_exit_code ?: (int)code);
	}

Leaving the test where it is.  Yes.  I think that should work.


Eric

