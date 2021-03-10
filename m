Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494B333478D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhCJTHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:07:31 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:49030 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhCJTHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:07:25 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK4B0-00EQ1X-Q9; Wed, 10 Mar 2021 12:07:23 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK4Az-0001C2-U2; Wed, 10 Mar 2021 12:07:22 -0700
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
Date:   Wed, 10 Mar 2021 13:07:26 -0600
In-Reply-To: <20210310173236.GB8973@redhat.com> (Oleg Nesterov's message of
        "Wed, 10 Mar 2021 18:32:37 +0100")
Message-ID: <m1v99yrfo1.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lK4Az-0001C2-U2;;;mid=<m1v99yrfo1.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX197e9Zu2/idl9WAj6+hcO+r4gTwQm4FBHA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
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
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 513 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.8%), parse: 0.82 (0.2%),
         extract_message_metadata: 2.7 (0.5%), get_uri_detail_list: 0.79
        (0.2%), tests_pri_-1000: 3.7 (0.7%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 0.95 (0.2%), tests_pri_-90: 226 (44.1%), check_bayes:
        224 (43.6%), b_tokenize: 5 (1.0%), b_tok_get_all: 5 (1.1%),
        b_comp_prob: 1.90 (0.4%), b_tok_touch_all: 208 (40.5%), b_finish: 0.92
        (0.2%), tests_pri_0: 241 (47.0%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.44 (0.1%), tests_pri_10:
        4.3 (0.8%), tests_pri_500: 14 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exit: trigger panic when init process is set to SIGNAL_GROUP_EXIT
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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

My code above is designed so that every thread calls panic.
Only the first thread into panic actually writes the panic (That is in
panic itself).

By testing for thread_group_empty() || SIGNAL_GROUP_EXIT
I am just trying to allow threads of init to exit.

Maybe thread_group_empty isn't the exact test we need to allow those.


Eric
