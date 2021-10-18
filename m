Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE2C4324EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhJRRZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:25:31 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46006 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhJRRZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:25:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:37056)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWLz-00A8XQ-Va; Mon, 18 Oct 2021 11:23:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:46156 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWLy-00DIW3-Ik; Mon, 18 Oct 2021 11:23:15 -0600
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
Date:   Mon, 18 Oct 2021 12:23:07 -0500
In-Reply-To: <871r4itfjw.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 12:21:07 -0500")
Message-ID: <87v91us0w4.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWLy-00DIW3-Ik;;;mid=<87v91us0w4.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+RRgCxuK6GlU72QyxwBWhkat3FU8+uoaU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_BayesUnsub,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong,XM_B_Unsub autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_B_Unsub Unsubscribe in body of email but missing unsubscribe
        *       header
        *  1.5 TR_XM_BayesUnsub High bayes score with no unsubscribe header
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 806 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.2%), b_tie_ro: 8 (1.0%), parse: 0.93 (0.1%),
         extract_message_metadata: 10 (1.2%), get_uri_detail_list: 0.71 (0.1%),
         tests_pri_-1000: 12 (1.5%), tests_pri_-950: 1.58 (0.2%),
        tests_pri_-900: 1.15 (0.1%), tests_pri_-90: 497 (61.7%), check_bayes:
        495 (61.5%), b_tokenize: 5 (0.6%), b_tok_get_all: 6 (0.7%),
        b_comp_prob: 1.62 (0.2%), b_tok_touch_all: 478 (59.3%), b_finish: 1.29
        (0.2%), tests_pri_0: 255 (31.7%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 3.3 (0.4%), poll_dns_idle: 1.21 (0.2%), tests_pri_10:
        2.8 (0.3%), tests_pri_500: 12 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/3] ucounts: Pair inc_rlimit_ucounts with dec_rlimit_ucoutns in commit_creds
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The purpose of inc_rlimit_ucounts and dec_rlimit_ucounts in commit_creds
is to change which rlimit counter is used to track a process when the
credentials changes.

Use the same test for both to guarantee the tracking is correct.

Cc: stable@vger.kernel.org
Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/cred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index f784e08c2fbd..3d163bfd64a9 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -501,7 +501,7 @@ int commit_creds(struct cred *new)
 		inc_rlimit_ucounts(new->ucounts, UCOUNT_RLIMIT_NPROC, 1);
 	rcu_assign_pointer(task->real_cred, new);
 	rcu_assign_pointer(task->cred, new);
-	if (new->user != old->user)
+	if (new->user != old->user || new->user_ns != old->user_ns)
 		dec_rlimit_ucounts(old->ucounts, UCOUNT_RLIMIT_NPROC, 1);
 	alter_cred_subscribers(old, -2);
 
-- 
2.20.1

