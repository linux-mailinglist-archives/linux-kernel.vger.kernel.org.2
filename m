Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0604563A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhKRTtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:49:16 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:42156 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhKRTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:49:14 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:45014)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnnML-000oY8-MV; Thu, 18 Nov 2021 12:46:13 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:48772 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnnMK-003oBG-Co; Thu, 18 Nov 2021 12:46:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Alexey Gladkov <legion@kernel.org>, Yu Zhao <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
Date:   Thu, 18 Nov 2021 13:46:05 -0600
In-Reply-To: <YZV7Z+yXbsx9p3JN@fixkernel.com> (Qian Cai's message of "Wed, 17
        Nov 2021 17:00:07 -0500")
Message-ID: <875ysptfgi.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnnMK-003oBG-Co;;;mid=<875ysptfgi.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/TnzlgEA7YGDyydVrGjr/zPCC+vAMjgt0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2102]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Qian Cai <quic_qiancai@quicinc.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 282 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (1.7%), b_tie_ro: 3.2 (1.1%), parse: 0.99
        (0.4%), extract_message_metadata: 11 (4.1%), get_uri_detail_list: 1.29
        (0.5%), tests_pri_-1000: 10 (3.6%), tests_pri_-950: 1.03 (0.4%),
        tests_pri_-900: 0.80 (0.3%), tests_pri_-90: 66 (23.6%), check_bayes:
        65 (23.2%), b_tokenize: 3.7 (1.3%), b_tok_get_all: 5 (1.9%),
        b_comp_prob: 1.31 (0.5%), b_tok_touch_all: 52 (18.5%), b_finish: 0.71
        (0.3%), tests_pri_0: 173 (61.5%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.1 (0.7%), poll_dns_idle: 0.62 (0.2%), tests_pri_10:
        2.7 (1.0%), tests_pri_500: 7 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <quic_qiancai@quicinc.com> writes:

> Hi there, I can still reproduce this quickly on today's linux-next and all
> the way back to 5.15-rc6 by running a syscall fuzzer for a while. The trace
> points out to this line,
>
>         for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>
> It looks KASAN indicated that that "ns" had already been freed. Is that
> possible or perhaps this is more of refcount issue?

Is it possible?  Yes it is possible.  That is one place where
a use-after-free has shown up and I expect would show up in the
future.

That said it is hard to believe there is still a user-after-free in the
code.  We spent the last kernel development cycle pouring through and
correcting everything we saw until we ultimately found one very subtle
use-after-free.

If you have a reliable reproducer that you can share, we can look into
this and see if we can track down where the reference count is going
bad.

It tends to take instrumenting the entire life cycle every increment and
every decrement and then pouring through the logs to track down a
use-after-free.  Which is not something we can really do without a
reproducer.

Eric
