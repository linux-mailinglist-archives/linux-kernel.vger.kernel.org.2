Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C703D42AAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhJLRdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 13:33:12 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55466 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhJLRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:33:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:51984)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1maLcJ-00Ca0L-CA; Tue, 12 Oct 2021 11:31:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60918 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1maLcI-00Gtkd-Gi; Tue, 12 Oct 2021 11:31:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rune Kleveland <rune.kleveland@infomedia.dk>
Cc:     Yu Zhao <yuzhao@google.com>, Alexey Gladkov <legion@kernel.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        containers@lists.linux-foundation.org
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
        <87ee9pa6xw.fsf@disp2133>
        <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
        <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
        <878rzw77i3.fsf@disp2133>
        <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
        <20210929173611.fo5traia77o63gpw@example.org>
        <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
        <20210930130640.wudkpmn3cmah2cjz@example.org>
        <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
        <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133>
        <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
Date:   Tue, 12 Oct 2021 12:31:00 -0500
In-Reply-To: <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk> (Rune
        Kleveland's message of "Sun, 10 Oct 2021 10:59:10 +0200")
Message-ID: <87o87u2lrf.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1maLcI-00Gtkd-Gi;;;mid=<87o87u2lrf.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/mi8WNgfr/F/tuuyDRQWaOtXEfsPIVixM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=8.0 tests=ALL_TRUSTED,BAYES_05,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_12,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0486]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rune Kleveland <rune.kleveland@infomedia.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 287 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (4.3%), b_tie_ro: 11 (3.8%), parse: 1.11
        (0.4%), extract_message_metadata: 13 (4.6%), get_uri_detail_list: 1.11
        (0.4%), tests_pri_-1000: 5 (1.8%), tests_pri_-950: 1.28 (0.4%),
        tests_pri_-900: 1.08 (0.4%), tests_pri_-90: 57 (19.9%), check_bayes:
        55 (19.3%), b_tokenize: 6 (1.9%), b_tok_get_all: 4.7 (1.6%),
        b_comp_prob: 1.93 (0.7%), b_tok_touch_all: 40 (13.9%), b_finish: 0.91
        (0.3%), tests_pri_0: 174 (60.7%), check_dkim_signature: 0.59 (0.2%),
        check_dkim_adsp: 3.0 (1.0%), poll_dns_idle: 0.76 (0.3%), tests_pri_10:
        2.2 (0.8%), tests_pri_500: 16 (5.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rune Kleveland <rune.kleveland@infomedia.dk> writes:

> Hi!
>
> Just wanted to let you know that I still get these on stock Fedora kernel
> 5.14.10 on the IBM blades. But it took 10 hours before the first server
> crashed. The other 4 still runs fine since 15 hours ago. So for me it seems more
> stable now, but that could just be a coincidence.

Alex and I have been working on this and we are still tracking down
whatever is going on.

While we haven't found the issue yet we have found a trivially correct
change that allows us to reproduce the issue faster.

Hopefully this will allow us to narrow down on whatever it is soon.

diff --git a/kernel/ucount.c b/kernel/ucount.c
index bb51849e6375..3b7e176cf7a2 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -203,6 +203,7 @@ void put_ucounts(struct ucounts *ucounts)
 
 	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
 		hlist_del_init(&ucounts->node);
+		ucounts->ns = NULL;
 		spin_unlock_irqrestore(&ucounts_lock, flags);
 		kfree(ucounts);
 	}

Eric
