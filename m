Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5264D40FDBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhIQQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:18:22 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44866 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhIQQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:18:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:56088)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mRGXo-007cbr-4X; Fri, 17 Sep 2021 10:16:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:58680 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mRGXm-00AKXd-TA; Fri, 17 Sep 2021 10:16:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Yu Zhao <yuzhao@google.com>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "legion\@kernel.org" <legion@kernel.org>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
        <87ee9pa6xw.fsf@disp2133>
        <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
        <CAOUHufahZsYOddtioPEqf=wFtD_HQ4pTo3XJLaSkcm4T3T5MZA@mail.gmail.com>
Date:   Fri, 17 Sep 2021 11:15:57 -0500
In-Reply-To: <CAOUHufahZsYOddtioPEqf=wFtD_HQ4pTo3XJLaSkcm4T3T5MZA@mail.gmail.com>
        (Yu Zhao's message of "Wed, 15 Sep 2021 17:44:40 -0600")
Message-ID: <87zgsb5gaq.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mRGXm-00AKXd-TA;;;mid=<87zgsb5gaq.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/grErXj5tSFynsqep0mW0e7iUUYvH9i9w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_12,XMSubLong,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2548]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Yu Zhao <yuzhao@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 647 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.5%), b_tie_ro: 8 (1.3%), parse: 1.01 (0.2%),
         extract_message_metadata: 16 (2.4%), get_uri_detail_list: 1.94 (0.3%),
         tests_pri_-1000: 16 (2.4%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 117 (18.1%), check_bayes:
        115 (17.7%), b_tokenize: 7 (1.1%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 2.6 (0.4%), b_tok_touch_all: 93 (14.4%), b_finish: 1.08
        (0.2%), tests_pri_0: 333 (51.4%), check_dkim_signature: 1.01 (0.2%),
        check_dkim_adsp: 2.9 (0.4%), poll_dns_idle: 131 (20.2%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 147 (22.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Wed, Sep 15, 2021 at 4:42 PM Jordan Glover
> <Golden_Miller83@protonmail.ch> wrote:
>>
>> On Wednesday, September 15th, 2021 at 9:02 PM, <ebiederm@xmission.com> wrote:
>>
>> > Jordan Glover Golden_Miller83@protonmail.ch writes:
>> >
>> > > Hi, recently I hit system freeze after I was closing few containerized apps on my system. As for now it occurred only once on linux 5.14.3. I think it maybe be related to "Count rlimits in each user namespace" patchset merged during 5.14 window
>> > >
>> > > https://lore.kernel.org/all/257aa5fb1a7d81cf0f4c34f39ada2320c4284771.1619094428.git.legion@kernel.org/T/#u
>> >
>> > So that warning comes from:
>> >
>> > void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
>> >
>> > {
>> >
>> > struct ucounts *iter;
>> >
>> > for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>> >
>> >       long dec = atomic_long_dec_if_positive(&iter->ucount[type]);
>> >
>> >       WARN_ON_ONCE(dec < 0);
>> >     }
>> >     put_ucounts(ucounts);
>> >
>> >
>> > }
>> >
>> > Which certainly looks like a reference count bug. It could also be a
>> >
>> > memory stomp somewhere close.
>> >
>> > Do you have any idea what else was going on? This location is the
>> >
>> > symptom but not the actual cause.
>> >
>> > Eric
>>
>> I had about 2 containerized (flatpak/bubblewrap) apps (browser + music player) running . I quickly closed them with intent to shutdown the system but instead get the freeze and had to use magic sysrq to reboot. System logs end with what I posted and before there is nothing suspicious.
>>
>> Maybe it's some random fluke. I'll reply if I hit it again.
>
> I have been able to steadily reproduce this for a while. But I haven't
> had time to look into it. I'd appreciate any help.

It would be very helpful if you could look farther back in your logs and
see if you can also see:
WARNING: CPU: 1 PID: 351 at kernel/ucount.c:253 dec_ucount+0x43/0x5

Or anything else preceding the use-after-free.

I am inclined to think they are the same issue but without seeing the
WARN_ON_ONCE I can't safely conclude that.

Eric
