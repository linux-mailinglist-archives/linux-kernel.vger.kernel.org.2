Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDB4325B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhJRR7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:59:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52854 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhJRR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:59:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:49952)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWsj-00AD1S-7x; Mon, 18 Oct 2021 11:57:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47744 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWsi-00DNfi-Bj; Mon, 18 Oct 2021 11:57:04 -0600
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
Date:   Mon, 18 Oct 2021 12:56:58 -0500
In-Reply-To: <877dearzfo.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 12:54:35 -0500")
Message-ID: <87pms2qkr9.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWsi-00DNfi-Bj;;;mid=<87pms2qkr9.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18BEv5XCVyJCuAJC34qBS/evW4UzTtN/tE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4980]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 327 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (3.0%), b_tie_ro: 9 (2.6%), parse: 1.01 (0.3%),
         extract_message_metadata: 11 (3.4%), get_uri_detail_list: 1.04 (0.3%),
         tests_pri_-1000: 14 (4.3%), tests_pri_-950: 1.24 (0.4%),
        tests_pri_-900: 1.02 (0.3%), tests_pri_-90: 78 (23.9%), check_bayes:
        76 (23.4%), b_tokenize: 6 (1.9%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.75 (0.5%), b_tok_touch_all: 59 (18.2%), b_finish: 0.91
        (0.3%), tests_pri_0: 196 (59.9%), check_dkim_signature: 0.64 (0.2%),
        check_dkim_adsp: 3.2 (1.0%), poll_dns_idle: 0.89 (0.3%), tests_pri_10:
        3.2 (1.0%), tests_pri_500: 8 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/4] ucounts: Add get_ucounts_or_wrap for clarity
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Add a helper function get_ucounts_or_wrap that is a trivial
wrapper around atomic_add_negative, that makes it clear
how atomic_add_negative is used in the context of ucounts.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 708d05164a7d..133b6044fda4 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -150,9 +150,15 @@ static void hlist_add_ucounts(struct ucounts *ucounts)
 	spin_unlock_irq(&ucounts_lock);
 }
 
+static inline bool get_ucounts_or_wrap(struct ucounts *ucounts)
+{
+	/* Returns true on a successful get, false if the count wraps. */
+	return !atomic_add_negative(1, &ucounts->count);
+}
+
 struct ucounts *get_ucounts(struct ucounts *ucounts)
 {
-	if (atomic_add_negative(1, &ucounts->count)) {
+	if (!get_ucounts_or_wrap(ucounts)) {
 		put_ucounts(ucounts);
 		ucounts = NULL;
 	}
@@ -163,7 +169,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
 	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
 	struct ucounts *ucounts, *new;
-	long overflow;
+	bool wrapped;
 
 	spin_lock_irq(&ucounts_lock);
 	ucounts = find_ucounts(ns, uid, hashent);
@@ -188,9 +194,9 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 			return new;
 		}
 	}
-	overflow = atomic_add_negative(1, &ucounts->count);
+	wrapped = !get_ucounts_or_wrap(ucounts);
 	spin_unlock_irq(&ucounts_lock);
-	if (overflow) {
+	if (wrapped) {
 		put_ucounts(ucounts);
 		return NULL;
 	}
-- 
2.20.1

