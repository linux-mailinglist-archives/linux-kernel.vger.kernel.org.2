Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8EF4325BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhJRR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:59:46 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44704 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhJRR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:59:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:54484)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWt9-008qvU-Mx; Mon, 18 Oct 2021 11:57:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47776 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWt8-004BEZ-T2; Mon, 18 Oct 2021 11:57:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Rune Kleveland <rune.kleveland@infomedia.dk>,
        Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        containers@lists.linux-foundation.org,
        Hillf Danton <hdanton@sina.com>
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
        <87mtnavszx.fsf_-_@disp2133> <87fssytizw.fsf_-_@disp2133>
        <871r4itfjw.fsf_-_@disp2133> <877dearzfo.fsf_-_@disp2133>
Date:   Mon, 18 Oct 2021 12:57:24 -0500
In-Reply-To: <877dearzfo.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 12:54:35 -0500")
Message-ID: <87k0iaqkqj.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWt8-004BEZ-T2;;;mid=<87k0iaqkqj.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/7j5xL28hfY6kDtmDx4X8fp6SFa2Mv6DA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4772]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 257 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (4.2%), b_tie_ro: 9 (3.6%), parse: 0.83 (0.3%),
         extract_message_metadata: 9 (3.4%), get_uri_detail_list: 0.95 (0.4%),
        tests_pri_-1000: 11 (4.3%), tests_pri_-950: 0.99 (0.4%),
        tests_pri_-900: 0.79 (0.3%), tests_pri_-90: 56 (22.0%), check_bayes:
        55 (21.5%), b_tokenize: 5 (2.1%), b_tok_get_all: 5 (2.1%),
        b_comp_prob: 1.47 (0.6%), b_tok_touch_all: 40 (15.7%), b_finish: 0.72
        (0.3%), tests_pri_0: 157 (61.2%), check_dkim_signature: 0.50 (0.2%),
        check_dkim_adsp: 2.5 (1.0%), poll_dns_idle: 0.89 (0.3%), tests_pri_10:
        1.77 (0.7%), tests_pri_500: 6 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/4] ucounts: Use atomic_long_sub_return for clarity
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Decrement ucounts using atomic_long_sub_return to make it
clear the point is for the ucount to decrease.

Not a big deal but it should make it easier to catch bugs.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 133b6044fda4..4f5613dac227 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -282,7 +282,7 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 	struct ucounts *iter;
 	long new = -1; /* Silence compiler warning */
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long dec = atomic_long_add_return(-v, &iter->ucount[type]);
+		long dec = atomic_long_sub_return(v, &iter->ucount[type]);
 		WARN_ON_ONCE(dec < 0);
 		if (iter == ucounts)
 			new = dec;
@@ -295,7 +295,7 @@ static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
 {
 	struct ucounts *iter, *next;
 	for (iter = ucounts; iter != last; iter = next) {
-		long dec = atomic_long_add_return(-1, &iter->ucount[type]);
+		long dec = atomic_long_sub_return(1, &iter->ucount[type]);
 		WARN_ON_ONCE(dec < 0);
 		next = iter->ns->ucounts;
 		if (dec == 0)
@@ -332,7 +332,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 	}
 	return ret;
 dec_unwind:
-	dec = atomic_long_add_return(-1, &iter->ucount[type]);
+	dec = atomic_long_sub_return(1, &iter->ucount[type]);
 	WARN_ON_ONCE(dec < 0);
 unwind:
 	do_dec_rlimit_put_ucounts(ucounts, iter, type);
-- 
2.20.1

