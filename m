Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3952E4324F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhJRR0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:26:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46158 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhJRR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:26:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:52192)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWMy-00A8cf-8s; Mon, 18 Oct 2021 11:24:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:46272 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWMw-00463S-VO; Mon, 18 Oct 2021 11:24:15 -0600
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
Date:   Mon, 18 Oct 2021 12:24:08 -0500
In-Reply-To: <871r4itfjw.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 12:21:07 -0500")
Message-ID: <87k0ias0uf.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWMw-00463S-VO;;;mid=<87k0ias0uf.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0fhu872FHY1s+bYbBvVsOhuRB8zrXdPs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4962]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 581 ms - load_scoreonly_sql: 0.14 (0.0%),
        signal_user_changed: 14 (2.4%), b_tie_ro: 11 (1.9%), parse: 2.1 (0.4%),
         extract_message_metadata: 20 (3.4%), get_uri_detail_list: 3.2 (0.6%),
        tests_pri_-1000: 20 (3.4%), tests_pri_-950: 1.83 (0.3%),
        tests_pri_-900: 1.43 (0.2%), tests_pri_-90: 153 (26.4%), check_bayes:
        151 (26.0%), b_tokenize: 11 (1.9%), b_tok_get_all: 9 (1.5%),
        b_comp_prob: 3.2 (0.6%), b_tok_touch_all: 124 (21.4%), b_finish: 1.20
        (0.2%), tests_pri_0: 335 (57.7%), check_dkim_signature: 0.99 (0.2%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 0.97 (0.2%), tests_pri_10:
        4.6 (0.8%), tests_pri_500: 23 (4.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/3] ucounts: Move get_ucounts from cred_alloc_blank to key_change_session_keyring
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Setting cred->ucounts in cred_alloc_blank does not make sense.  The
uid and user_ns are deliberately not set in cred_alloc_blank but
instead the setting is delayed until key_change_session_keyring.

So move dealing with ucounts into key_change_session_keyring as well.

Unfortunately that movement of get_ucounts adds a new failure mode to
key_change_session_keyring.  I do not see anything stopping the parent
process from calling setuid and changing the relevant part of it's
cred while keyctl_session_to_parent is running making it fundamentally
necessary to call get_ucounts in key_change_session_keyring.  Which
means that the new failure mode cannot be avoided.

A failure of key_change_session_keyring results in a single threaded
parent keeping it's existing credentials.  Which results in the parent
process not being able to access the session keyring and whichever
keys are in the new keyring.

Further get_ucounts is only expected to fail if the number of bits in
the refernece count for the structure is too few.

Since the code has no other way to report the failure of get_ucounts
and because such failures are not expected to be common add a WARN_ONCE
to report this problem to userspace.

Between the WARN_ONCE and the parent process not having access to
the keys in the new session keyring I expect any failure of get_ucounts
will be noticed and reported and we can find another way to handle this
condition.  (Possibly by just making ucounts->count an atomic_long_t).

Cc: stable@vger.kernel.org
Fixes: 905ae01c4ae2 ("Add a reference to ucounts for each cred")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/cred.c                | 2 --
 security/keys/process_keys.c | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 16c05dfbec4d..1ae0b4948a5a 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -225,8 +225,6 @@ struct cred *cred_alloc_blank(void)
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	new->magic = CRED_MAGIC;
 #endif
-	new->ucounts = get_ucounts(&init_ucounts);
-
 	if (security_cred_alloc_blank(new, GFP_KERNEL_ACCOUNT) < 0)
 		goto error;
 
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index e3d79a7b6db6..20cc5a9a05fd 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -918,6 +918,13 @@ void key_change_session_keyring(struct callback_head *twork)
 		return;
 	}
 
+	/* If get_ucounts fails more bits are needed in the refcount */
+	if (unlikely(!get_ucounts(old->ucounts))) {
+		WARN_ONCE(1, "In %s get_ucounts failed\n");
+		put_cred(new);
+		return;
+	}
+
 	new->  uid	= old->  uid;
 	new-> euid	= old-> euid;
 	new-> suid	= old-> suid;
@@ -927,6 +934,7 @@ void key_change_session_keyring(struct callback_head *twork)
 	new-> sgid	= old-> sgid;
 	new->fsgid	= old->fsgid;
 	new->user	= get_uid(old->user);
+	new->ucounts	= old->ucounts;
 	new->user_ns	= get_user_ns(old->user_ns);
 	new->group_info	= get_group_info(old->group_info);
 
-- 
2.20.1

