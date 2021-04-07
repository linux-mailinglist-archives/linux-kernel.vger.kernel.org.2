Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038FD35727E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354415AbhDGQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:56:54 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35300 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354403AbhDGQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:56:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lUBTt-00CZh7-I0; Wed, 07 Apr 2021 10:56:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lUBTs-0007Tf-91; Wed, 07 Apr 2021 10:56:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <cover.1616533074.git.gladkov.alexey@gmail.com>
        <8f0c2888b4e92d51239e154b82d75972e7e39833.1616533074.git.gladkov.alexey@gmail.com>
        <m1y2dwllfg.fsf@fess.ebiederm.org>
        <20210406154444.icpvezlq3izzxf5t@example.org>
Date:   Wed, 07 Apr 2021 11:56:36 -0500
In-Reply-To: <20210406154444.icpvezlq3izzxf5t@example.org> (Alexey Gladkov's
        message of "Tue, 6 Apr 2021 17:44:44 +0200")
Message-ID: <m1eefmjanv.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lUBTs-0007Tf-91;;;mid=<m1eefmjanv.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18gGOagHueeOSvjjB9O1FjohVGYorUmAaY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 494 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 10 (2.0%), parse: 0.87
        (0.2%), extract_message_metadata: 2.9 (0.6%), get_uri_detail_list:
        0.87 (0.2%), tests_pri_-1000: 12 (2.5%), tests_pri_-950: 2.9 (0.6%),
        tests_pri_-900: 1.89 (0.4%), tests_pri_-90: 214 (43.4%), check_bayes:
        212 (43.0%), b_tokenize: 9 (1.9%), b_tok_get_all: 67 (13.5%),
        b_comp_prob: 3.4 (0.7%), b_tok_touch_all: 127 (25.8%), b_finish: 1.34
        (0.3%), tests_pri_0: 207 (41.9%), check_dkim_signature: 0.74 (0.2%),
        check_dkim_adsp: 3.5 (0.7%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 29 (5.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v9 4/8] Reimplement RLIMIT_NPROC on top of ucounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Mon, Apr 05, 2021 at 11:56:35AM -0500, Eric W. Biederman wrote:
>>
>> Also when setting ns->ucount_max[] in create_user_ns because one value
>> is signed and the other is unsigned.  Care should be taken so that
>> rlimit_infinity is translated into the largest positive value the
>> type can hold.
>
> You mean like that ?
>
> ns->ucount_max[UCOUNT_RLIMIT_NPROC] = rlimit(RLIMIT_NPROC) <= LONG_MAX ?
> 	rlimit(RLIMIT_NPROC) : LONG_MAX;
> ns->ucount_max[UCOUNT_RLIMIT_MSGQUEUE] = rlimit(RLIMIT_MSGQUEUE) <= LONG_MAX ?
> 	rlimit(RLIMIT_MSGQUEUE) : LONG_MAX;
> ns->ucount_max[UCOUNT_RLIMIT_SIGPENDING] = rlimit(RLIMIT_SIGPENDING) <= LONG_MAX ?
> 	rlimit(RLIMIT_SIGPENDING) : LONG_MAX;
> ns->ucount_max[UCOUNT_RLIMIT_MEMLOCK] = rlimit(RLIMIT_MEMLOCK) <= LONG_MAX ?
> 	rlimit(RLIMIT_MEMLOCK) : LONG_MAX;

Yes.

I only got as far as:
if (rlimit(RLIMI_NNN) == RLIM_INFINITY) {
	ns->ucount_max[UCOUNT_LIMIT_NNN] = LONG_MAX;
} else {
	ns->ucount_max[UCOUNT_LMIT_NNN] = rlmit(RLIMIT_NNN);
}
But forcing everything about LONG_MAX to LONG_MAX actually looks better
in practice.  Especially as that is effectively RLIMIT_INFINITY anyway.

Eric
