Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D33CFF84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGTPwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:52:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42868 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhGTPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:49:18 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m5scr-006k9t-Cx; Tue, 20 Jul 2021 10:29:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:50058 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m5scp-006F6J-As; Tue, 20 Jul 2021 10:29:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+b6e65bd125a05f803d6b@syzkaller.appspotmail.com>,
        legion@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000efe97f05c74bb995@google.com>
        <20210719094432.425-1-hdanton@sina.com>
        <20210720041451.766-1-hdanton@sina.com>
Date:   Tue, 20 Jul 2021 11:29:09 -0500
In-Reply-To: <20210720041451.766-1-hdanton@sina.com> (Hillf Danton's message
        of "Tue, 20 Jul 2021 12:14:51 +0800")
Message-ID: <87y2a1q78q.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m5scp-006F6J-As;;;mid=<87y2a1q78q.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/CsiqgU4gH+PrUqxRLgvuy1Drl/YoBycA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4416]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Hillf Danton <hdanton@sina.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1422 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 9 (0.6%), parse: 0.78 (0.1%),
         extract_message_metadata: 11 (0.8%), get_uri_detail_list: 1.05 (0.1%),
         tests_pri_-1000: 19 (1.3%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 0.99 (0.1%), tests_pri_-90: 71 (5.0%), check_bayes: 68
        (4.8%), b_tokenize: 5 (0.4%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        1.88 (0.1%), b_tok_touch_all: 52 (3.7%), b_finish: 1.07 (0.1%),
        tests_pri_0: 1295 (91.1%), check_dkim_signature: 0.78 (0.1%),
        check_dkim_adsp: 3.5 (0.2%), poll_dns_idle: 0.84 (0.1%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [syzbot] KASAN: use-after-free Write in put_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> writes:

> On Mon, 19 Jul 2021 12:24:41 -0500 Eric W. Biederman wrote:
>>>
>>> To fix the uaf, add a couple of changes. Now only for thoughts.
>>>
>>> 1/ s/atomic_add_negative/atomic_inc_not_zero/ to correct the get
>>> method.
>>
>>I really don't think so.  The use of atomic_add_negative is very
>>deliberate.  Changing that fundamentally changes the algorithm into used
>
> Given atomic_dec_and_test() in put_ucounts(), what sense are you
> deliberately trying to make by bumping up a zero count?
>
>>to keep track of things.  Definitely not something to lead with.
>>
>>Before it even makes sense to talk about how to change the code,
>>a plausible explanation for how a use after free happens is needed.
>
> I am trying just to avoid touching zero count. That is it.

Observing a zero-reference count in this case is a result of a
use-after-free.  So that is definitely not what needs to be fixed.

>>That explanation should account for the fact this code was in linux-next
>>the since last -rc1 without any kind of issue with the test code.
>
> The code is no good without surviving syzbot, right? And -rcX does not
> matter.

That was with syzbot running against linux-next for 8ish weeks.

Something changed that syzbot is now reporting an error.

It is definitely worth fixing but we need to track down and understand
what the bug is.

Eric




