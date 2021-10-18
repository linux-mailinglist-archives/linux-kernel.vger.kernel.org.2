Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B83D4325AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhJRR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:58:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59834 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhJRR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:58:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:47288)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWrW-00ET5m-JR; Mon, 18 Oct 2021 11:55:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47652 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWrV-00DNSF-HH; Mon, 18 Oct 2021 11:55:50 -0600
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
Date:   Mon, 18 Oct 2021 12:55:43 -0500
In-Reply-To: <877dearzfo.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 12:54:35 -0500")
Message-ID: <871r4irzds.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWrV-00DNSF-HH;;;mid=<871r4irzds.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PGUj1NtV6RMjI6pPae8N954hBqET1VDE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 360 ms - load_scoreonly_sql: 0.34 (0.1%),
        signal_user_changed: 13 (3.6%), b_tie_ro: 11 (3.0%), parse: 1.50
        (0.4%), extract_message_metadata: 18 (5.0%), get_uri_detail_list: 1.58
        (0.4%), tests_pri_-1000: 22 (6.2%), tests_pri_-950: 1.80 (0.5%),
        tests_pri_-900: 1.60 (0.4%), tests_pri_-90: 67 (18.5%), check_bayes:
        65 (17.9%), b_tokenize: 6 (1.7%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 2.1 (0.6%), b_tok_touch_all: 46 (12.8%), b_finish: 1.08
        (0.3%), tests_pri_0: 220 (61.2%), check_dkim_signature: 0.89 (0.2%),
        check_dkim_adsp: 3.2 (0.9%), poll_dns_idle: 0.94 (0.3%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/4] ucounts: In set_cred_ucounts assume new->ucounts is non-NULL
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Any cred that is destined for use by commit_creds must have a non-NULL
cred->ucounts field.  Only curing credential construction is a NULL
cred->ucounts valid.  Only abort_creds, put_cred, and put_cred_rcu
needs to deal with a cred with a NULL ucount.  As set_cred_ucounts is
non of those case don't confuse people by handling something that can
not happen.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/cred.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 1ae0b4948a5a..473d17c431f3 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -676,15 +676,14 @@ int set_cred_ucounts(struct cred *new)
 	 * This optimization is needed because alloc_ucounts() uses locks
 	 * for table lookups.
 	 */
-	if (old_ucounts && old_ucounts->ns == new->user_ns && uid_eq(old_ucounts->uid, new->euid))
+	if (old_ucounts->ns == new->user_ns && uid_eq(old_ucounts->uid, new->euid))
 		return 0;
 
 	if (!(new_ucounts = alloc_ucounts(new->user_ns, new->euid)))
 		return -EAGAIN;
 
 	new->ucounts = new_ucounts;
-	if (old_ucounts)
-		put_ucounts(old_ucounts);
+	put_ucounts(old_ucounts);
 
 	return 0;
 }
-- 
2.20.1

