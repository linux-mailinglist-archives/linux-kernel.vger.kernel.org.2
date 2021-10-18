Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50843232B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhJRPo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:44:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37076 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhJRPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:44:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:46662)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcUmD-008WoB-Kb; Mon, 18 Oct 2021 09:42:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:40538 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcUmC-00D1TG-KO; Mon, 18 Oct 2021 09:42:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Yu Zhao <yuzhao@google.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
References: <878rzw77i3.fsf@disp2133>
        <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
        <20210929173611.fo5traia77o63gpw@example.org>
        <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
        <20210930130640.wudkpmn3cmah2cjz@example.org>
        <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
        <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133>
        <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
        <87mtnavszx.fsf_-_@disp2133>
        <20211015230922.7s7ab37k2sioa5vg@example.org>
        <87zgr8vpop.fsf@disp2133>
        <CAOUHufbbPMzMLaPH8o+PKG64RQaO7=09nv1hBnQY8SRAW+Jd-g@mail.gmail.com>
Date:   Mon, 18 Oct 2021 10:35:12 -0500
In-Reply-To: <CAOUHufbbPMzMLaPH8o+PKG64RQaO7=09nv1hBnQY8SRAW+Jd-g@mail.gmail.com>
        (Yu Zhao's message of "Sun, 17 Oct 2021 13:35:37 -0600")
Message-ID: <8735oyuz0v.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcUmC-00D1TG-KO;;;mid=<8735oyuz0v.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19IRU+fje8+4Jcix4fh8vbtCkuc+2VVzC0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1530]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Yu Zhao <yuzhao@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 470 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (2.2%), b_tie_ro: 9 (2.0%), parse: 0.82 (0.2%),
         extract_message_metadata: 11 (2.3%), get_uri_detail_list: 0.90 (0.2%),
         tests_pri_-1000: 13 (2.8%), tests_pri_-950: 1.26 (0.3%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 188 (40.0%), check_bayes:
        187 (39.7%), b_tokenize: 5 (1.1%), b_tok_get_all: 5.0 (1.1%),
        b_comp_prob: 1.57 (0.3%), b_tok_touch_all: 172 (36.6%), b_finish: 0.80
        (0.2%), tests_pri_0: 231 (49.1%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 0.83 (0.2%), tests_pri_10:
        2.8 (0.6%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [CFT][PATCH] ucounts: Fix signal ucount refcounting
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Sat, Oct 16, 2021 at 11:35 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Alexey Gladkov <legion@kernel.org> writes:
>>
>> > On Fri, Oct 15, 2021 at 05:10:58PM -0500, Eric W. Biederman wrote:
>> >> +                    goto dec_unwind;
>> >> +    }
>> >> +    return ret;
>> >> +dec_unwind:
>> >> +    dec = atomic_long_add_return(1, &iter->ucount[type]);
>> >
>> > Should be -1 ?
>>
>> Yes it should.  I will fix and resend.
>
> Or just atomic_long_dec_return().

It would have to be atomic_long_sub_return().

Even then I would want to change all of kernel/ucount.c to use
the same helper function so discrepancies can easily be spotted.

It is a good idea, just not I think for this particular patch.

Eric
