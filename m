Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C7E4324F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhJRR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:26:00 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46070 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhJRRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:25:58 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:51982)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWMV-00A8a6-4c; Mon, 18 Oct 2021 11:23:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:46216 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWMU-0045zF-90; Mon, 18 Oct 2021 11:23:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Rune Kleveland <rune.kleveland@infomedia.dk>,
        Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        containers@lists.linux-foundation.org,
        Hillf Danton <hdanton@sina.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
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
        <871r4itfjw.fsf_-_@disp2133>
Date:   Mon, 18 Oct 2021 12:23:39 -0500
In-Reply-To: <871r4itfjw.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 12:21:07 -0500")
Message-ID: <87pms2s0v8.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWMU-0045zF-90;;;mid=<87pms2s0v8.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/V1ZFMdVPsJ2CxIQJt/vIa0Zcg4nDjRmY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4958]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 293 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (3.0%), b_tie_ro: 8 (2.6%), parse: 0.88 (0.3%),
        extract_message_metadata: 11 (3.7%), get_uri_detail_list: 1.04 (0.4%),
        tests_pri_-1000: 14 (4.7%), tests_pri_-950: 1.24 (0.4%),
        tests_pri_-900: 1.04 (0.4%), tests_pri_-90: 56 (19.1%), check_bayes:
        54 (18.5%), b_tokenize: 6 (2.2%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 1.89 (0.6%), b_tok_touch_all: 37 (12.7%), b_finish: 0.95
        (0.3%), tests_pri_0: 189 (64.5%), check_dkim_signature: 0.55 (0.2%),
        check_dkim_adsp: 2.8 (1.0%), poll_dns_idle: 0.92 (0.3%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 7 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/3] ucounts: Proper error handling in set_cred_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Instead of leaking the ucounts in new if alloc_ucounts fails, store
the result of alloc_ucounts into a temporary variable, which is later
assigned to new->ucounts.

Cc: stable@vger.kernel.org
Fixes: 905ae01c4ae2 ("Add a reference to ucounts for each cred")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/cred.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 3d163bfd64a9..16c05dfbec4d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -669,7 +669,7 @@ int set_cred_ucounts(struct cred *new)
 {
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
-	struct ucounts *old_ucounts = new->ucounts;
+	struct ucounts *new_ucounts, *old_ucounts = new->ucounts;
 
 	if (new->user == old->user && new->user_ns == old->user_ns)
 		return 0;
@@ -681,9 +681,10 @@ int set_cred_ucounts(struct cred *new)
 	if (old_ucounts && old_ucounts->ns == new->user_ns && uid_eq(old_ucounts->uid, new->euid))
 		return 0;
 
-	if (!(new->ucounts = alloc_ucounts(new->user_ns, new->euid)))
+	if (!(new_ucounts = alloc_ucounts(new->user_ns, new->euid)))
 		return -EAGAIN;
 
+	new->ucounts = new_ucounts;
 	if (old_ucounts)
 		put_ucounts(old_ucounts);
 
-- 
2.20.1

