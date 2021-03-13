Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFBB339F31
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhCMQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 11:45:33 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:44450 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhCMQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 11:45:32 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lL7ON-00AKP2-4o; Sat, 13 Mar 2021 09:45:31 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lL7OM-008iL3-8G; Sat, 13 Mar 2021 09:45:30 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m1lfasf44s.fsf@fess.ebiederm.org>
        <CAHk-=whw8w_a727dqokA3AsifsMQ2=qZYt1Go8+KCTKczxxSWQ@mail.gmail.com>
Date:   Sat, 13 Mar 2021 10:45:36 -0600
In-Reply-To: <CAHk-=whw8w_a727dqokA3AsifsMQ2=qZYt1Go8+KCTKczxxSWQ@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 12 Mar 2021 14:33:38 -0800")
Message-ID: <m1o8fnc89b.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lL7OM-008iL3-8G;;;mid=<m1o8fnc89b.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+S0rtzRS/8rD9lr+H8WDPjfjjo+8krTvM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4703]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 256 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (4.1%), b_tie_ro: 9 (3.5%), parse: 0.79 (0.3%),
         extract_message_metadata: 14 (5.3%), get_uri_detail_list: 1.25 (0.5%),
         tests_pri_-1000: 14 (5.5%), tests_pri_-950: 1.26 (0.5%),
        tests_pri_-900: 0.96 (0.4%), tests_pri_-90: 51 (19.8%), check_bayes:
        49 (19.3%), b_tokenize: 5 (2.0%), b_tok_get_all: 6 (2.3%),
        b_comp_prob: 1.91 (0.7%), b_tok_touch_all: 34 (13.2%), b_finish: 0.80
        (0.3%), tests_pri_0: 153 (59.6%), check_dkim_signature: 0.51 (0.2%),
        check_dkim_adsp: 11 (4.3%), poll_dns_idle: 0.15 (0.1%), tests_pri_10:
        2.1 (0.8%), tests_pri_500: 7 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] userns regression fix for v5.12-rc3
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Mar 12, 2021 at 1:34 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Please pull the for-v5.12-rc3 branch from the git tree.
>>
>> Removing the ambiguity broke userspace so please revert the change:
>> It turns out that there are in fact userspace implementations that
>> care and this recent change caused a regression.
>>
>> https://github.com/containers/buildah/issues/3071
>
> Pulled.
>
> But please cc the kernel mailing list (or something like that) for
> these things, so that you get the pr-tracker-bot reply automatically.
>
> Perhaps you don't care about the pr-tracker-bot that much, but even
> aside from that, I just like the pulls to be cc'd on the lists, if
> only as "documentation".
>
> (Plus since I've gotten used to seeing the pr-tracker-bot
> confirmations, I then get antsy and wondering if something is wrong
> with the bot when it doesn't respond fully when I push things out,
> which is how I noticed this one).

Sorry about that.  I meant to CC lkml but my fingers forgot to include
it this time.

I just knew I had to get this out so we could start unbreaking users.

Eric
