Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE10445649A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhKRVCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:02:03 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:41574 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKRVCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:02:02 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:33074)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnoUm-00DoTt-H5; Thu, 18 Nov 2021 13:59:00 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:51282 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnoUl-00Akvn-Ga; Thu, 18 Nov 2021 13:59:00 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Alexey Gladkov <legion@kernel.org>, Yu Zhao <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
        <875ysptfgi.fsf@email.froward.int.ebiederm.org>
        <YZa4YbcOyjtD3+pL@fixkernel.com>
Date:   Thu, 18 Nov 2021 14:57:17 -0600
In-Reply-To: <YZa4YbcOyjtD3+pL@fixkernel.com> (Qian Cai's message of "Thu, 18
        Nov 2021 15:32:33 -0500")
Message-ID: <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnoUl-00Akvn-Ga;;;mid=<87k0h5rxle.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xFxhvjIdEI4qeidXSmsLguyRERS2BhmM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4979]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Qian Cai <quic_qiancai@quicinc.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 451 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 0.84
        (0.2%), extract_message_metadata: 12 (2.6%), get_uri_detail_list: 1.66
        (0.4%), tests_pri_-1000: 14 (3.1%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 0.98 (0.2%), tests_pri_-90: 113 (25.0%), check_bayes:
        111 (24.5%), b_tokenize: 10 (2.2%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 3.3 (0.7%), b_tok_touch_all: 80 (17.8%), b_finish: 1.56
        (0.3%), tests_pri_0: 279 (61.9%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 3.4 (0.8%), poll_dns_idle: 1.00 (0.2%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 14 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <quic_qiancai@quicinc.com> writes:

> On Thu, Nov 18, 2021 at 01:46:05PM -0600, Eric W. Biederman wrote:
>> Is it possible?  Yes it is possible.  That is one place where
>> a use-after-free has shown up and I expect would show up in the
>> future.
>> 
>> That said it is hard to believe there is still a user-after-free in the
>> code.  We spent the last kernel development cycle pouring through and
>> correcting everything we saw until we ultimately found one very subtle
>> use-after-free.
>> 
>> If you have a reliable reproducer that you can share, we can look into
>> this and see if we can track down where the reference count is going
>> bad.
>> 
>> It tends to take instrumenting the entire life cycle every increment and
>> every decrement and then pouring through the logs to track down a
>> use-after-free.  Which is not something we can really do without a
>> reproducer.
>
> The reproducer is just to run trinity by an unprivileged user on defconfig
> with KASAN enabled (On linux-next, you can do "make defconfig debug.conf"
> [1], but dont think other debugging options are relevent here.)
>
> $ trinity -C 31 -N 10000000
>
> It is always reproduced on an arm64 server here within 5-minute so far.
> Some debugging progress so far. BTW, this could happen on user_shm_unlock()
> path as well.

Does this only happen on a single architecture?  If so I wonder if
perhaps some of the architectures atomic primitives are implemented
improperly.

Unfortunately I don't have any arm64 machines where I can easily test
this.

The call path you posted from user_shm_unlock is another path where
a use-after-free has show up in the past.

My blind guess would be that I made an implementation mistake in
inc_rlimit_get_ucounts or dec_rlimit_put_ucounts but I can't see it
right now.

Eric

>  Call trace:
>   dec_rlimit_ucounts
>   user_shm_unlock
>   (inlined by) user_shm_unlock at mm/mlock.c:854
>   shmem_lock
>   shmctl_do_lock
>   ksys_shmctl.constprop.0
>   __arm64_sys_shmctl
>   invoke_syscall
>   el0_svc_common.constprop.0
>   do_el0_svc
>   el0_svc
>   el0t_64_sync_handler
>   el0t_64_sync
>
> I noticed in dec_rlimit_ucounts(), dec == 0 and type ==
> UCOUNT_RLIMIT_MEMLOCK. 
>
> [1] https://lore.kernel.org/lkml/20211115134754.7334-1-quic_qiancai@quicinc.com/
