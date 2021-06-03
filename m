Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E079339ACF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFCVew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:34:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33846 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFCVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:34:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1louxY-009GBF-OD; Thu, 03 Jun 2021 15:33:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1louxJ-001qXz-2s; Thu, 03 Jun 2021 15:33:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jiashuo Liang <liangjs@pku.edu.cn>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20210601085203.40214-1-liangjs@pku.edu.cn>
        <YLkhV+lSqXlcfUc5@zn.tnic>
Date:   Thu, 03 Jun 2021 16:31:46 -0500
In-Reply-To: <YLkhV+lSqXlcfUc5@zn.tnic> (Borislav Petkov's message of "Thu, 3
        Jun 2021 20:37:11 +0200")
Message-ID: <87lf7qocsd.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1louxJ-001qXz-2s;;;mid=<87lf7qocsd.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19oKlE0ZcoHvyEY4dg6KJQPCD/7/4WpgNs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=8.0 tests=ALL_TRUSTED,BAYES_05,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0149]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Borislav Petkov <bp@alien8.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15045 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (0.1%), b_tie_ro: 10 (0.1%), parse: 1.45
        (0.0%), extract_message_metadata: 18 (0.1%), get_uri_detail_list: 2.4
        (0.0%), tests_pri_-1000: 4.3 (0.0%), tests_pri_-950: 1.76 (0.0%),
        tests_pri_-900: 1.42 (0.0%), tests_pri_-90: 103 (0.7%), check_bayes:
        100 (0.7%), b_tokenize: 10 (0.1%), b_tok_get_all: 8 (0.1%),
        b_comp_prob: 3.0 (0.0%), b_tok_touch_all: 76 (0.5%), b_finish: 1.16
        (0.0%), tests_pri_0: 7374 (49.0%), check_dkim_signature: 0.81 (0.0%),
        check_dkim_adsp: 6008 (39.9%), poll_dns_idle: 13515 (89.8%),
        tests_pri_10: 4.1 (0.0%), tests_pri_500: 7521 (50.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] signal/x86: Don't send SIGSEGV twice on SEGV_PKUERR
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Jun 01, 2021 at 04:52:03PM +0800, Jiashuo Liang wrote:
>> Before this patch, the __bad_area_nosemaphore function calls both
>> force_sig_pkuerr and force_sig_fault when handling SEGV_PKUERR. This does
>> not cause problems because the second signal is filtered by the
>> legacy_queue check in __send_signal.
>
> I'm likely missing something but the first signal gets filtered by that
> same legacy_queue() check too, no?
>
> Because both calls end up in
>
> 	force_sig_info_to_task(info, current);
>
> with the info struct populated with:
>
> 	info.si_signo = SIGSEGV;
>         info.si_errno = 0;
>         info.si_code  = SEGV_PKUERR;
>         info.si_addr  = addr;
>         info.si_pkey  = pkey;
>
> except the second call - force_sig_fault() - doesn't put pkey in
> ->si_pkey.
>
> So what's up?

There are two ways signals get delivered.  The old fashioned way in the
signal bitmap, and the new fangled way by queuing sigqueue_info.  In the
old fashioned way there is no information except that the signal itself
was delivered, and if the signal is sent twice it is impossible to find
out.  In the new fangled way because the sigqueue_info can vary between
different times a signal is sent you can both see that a signal was
delivered twice (because there are two distinct entries in the queue),
but also possibly tell those two times a signal was sent apart.

The new real time signals can queue as many sigqueue_info's as their
rlimit allows.  The old signals are limited to exactly one sigqueue_info
per signal number.

In this case the legacy_queue check tests to see if the signal is
already pending (present in the signal bitmap) and not a new real time
signal (which means only one sigqueue_info entry is allowed in the
signal queue).

Or in short I think everything turns out ok because the first signal is
delivered, and the second just happens to get dropped as a duplicate by
__send_signal.  That is fragile and confusing to depend on so we should
just fix the code to not send the wrong signal.

> Thx.

I hope that clears things up.

Eric






