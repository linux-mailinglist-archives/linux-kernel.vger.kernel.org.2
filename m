Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418AA4325AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhJRR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:58:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44454 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhJRR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:58:35 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:54064)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWs2-008qnN-Uk; Mon, 18 Oct 2021 11:56:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47688 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWs1-004B69-TT; Mon, 18 Oct 2021 11:56:22 -0600
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
Date:   Mon, 18 Oct 2021 12:56:15 -0500
In-Reply-To: <877dearzfo.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 12:54:35 -0500")
Message-ID: <87v91uqksg.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWs1-004B69-TT;;;mid=<87v91uqksg.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+x/oKEKjfMZ4oFtprE1q52ZoFCksH/iBo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 333 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (3.2%), b_tie_ro: 9 (2.8%), parse: 0.86 (0.3%),
         extract_message_metadata: 12 (3.5%), get_uri_detail_list: 1.02 (0.3%),
         tests_pri_-1000: 15 (4.4%), tests_pri_-950: 1.35 (0.4%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 50 (15.1%), check_bayes:
        49 (14.6%), b_tokenize: 6 (1.8%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 1.62 (0.5%), b_tok_touch_all: 32 (9.6%), b_finish: 0.73
        (0.2%), tests_pri_0: 226 (67.8%), check_dkim_signature: 0.58 (0.2%),
        check_dkim_adsp: 2.9 (0.9%), poll_dns_idle: 0.85 (0.3%), tests_pri_10:
        2.3 (0.7%), tests_pri_500: 12 (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/4] ucounts: Remove unnecessary test for NULL ucount in get_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


All of the callers of get_ucounts are passeds a non-NULL value so stop
handling a NULL ucounts pointer in get_ucounts.

It is guaranteed that ever valid fully formed cred that is passed to
commit_cred contains a non-NULL ucounts pointer.  This in turn
gurantees that current_ucounts() never returns NULL.

The call of get_ucounts in user_shm_lock is always passed
current_ucounts().

The call of get_ucounts in mqueue_get_inode is always passed
current_ucounts().

The call of get_ucounts in inc_rlmit_get_ucounts is always
passed iter, after iter has been verified to be non-NULL.

The call of get_ucounts in key_change_session_keyring is always passed
current_ucounts().

The call of get_ucounts in prepare_cred is always passed
current_ucounts().

The call of get_ucounts in prepare_kernel_cred is always
passed task->cred->ucounts or init_cred->ucounts which
being on tasks are guaranteed to have a non-NULL ucounts
field.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index eb03f3c68375..708d05164a7d 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -152,7 +152,7 @@ static void hlist_add_ucounts(struct ucounts *ucounts)
 
 struct ucounts *get_ucounts(struct ucounts *ucounts)
 {
-	if (ucounts && atomic_add_negative(1, &ucounts->count)) {
+	if (atomic_add_negative(1, &ucounts->count)) {
 		put_ucounts(ucounts);
 		ucounts = NULL;
 	}
-- 
2.20.1

