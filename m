Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499FC4214E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhJDRMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:12:34 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45012 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhJDRMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:12:32 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:56088)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mXRUA-00AIQb-9M; Mon, 04 Oct 2021 11:10:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:35024 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mXRU8-00FQAR-W9; Mon, 04 Oct 2021 11:10:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Yu Zhao <yuzhao@google.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        containers@lists.linux-foundation.org,
        Rune Kleveland <rune.kleveland@infomedia.dk>
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
Date:   Mon, 04 Oct 2021 12:10:05 -0500
In-Reply-To: <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
        (Yu Zhao's message of "Thu, 30 Sep 2021 16:27:34 -0600")
Message-ID: <878rz8wwb6.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mXRU8-00FQAR-W9;;;mid=<878rz8wwb6.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/fW4fqBtqqTCbM1YFal6ou2aHs6gF4F48=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_12,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3212]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Yu Zhao <yuzhao@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 484 ms - load_scoreonly_sql: 0.37 (0.1%),
        signal_user_changed: 12 (2.6%), b_tie_ro: 10 (2.1%), parse: 1.54
        (0.3%), extract_message_metadata: 3.8 (0.8%), get_uri_detail_list:
        1.14 (0.2%), tests_pri_-1000: 4.2 (0.9%), tests_pri_-950: 1.47 (0.3%),
        tests_pri_-900: 1.25 (0.3%), tests_pri_-90: 111 (22.9%), check_bayes:
        109 (22.5%), b_tokenize: 7 (1.5%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 81 (16.8%), b_finish: 1.37
        (0.3%), tests_pri_0: 328 (67.7%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 3.3 (0.7%), poll_dns_idle: 1.24 (0.3%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding Rune Kleveland to the discussion as he also seems to have
reproduced the issue.

Alex and I have been starring at the code and the reports and this
bug is hiding well.  Here is what we have figured out so far.

Both the warning from free_user_ns calling dec_ucount that Jordan Glover
reported and the KASAN error that Yu Zhao has reported appear to have
the same cause.  Using a ucounts structure after it has been freed and
reallocated as something else.

I have just skimmed through the recent report from Rune Kleveland
and it appears also to be a use after free.  Especially since the
second failure in the log is slub complaining about trying to free
the ucounts data structure.

We looked through the users of put_ucounts and we don't see any obvious
buggy users that would be freeing the data structure early.

Alex has tried to reproduce this so far is not having any luck.
Folks can you tell what compiler versions you are using and share your
kernel config with us?  That might help.

The little debug diff below is my guess of what is happening.  If the
folks who can reproduce this issue can try the patch below and let me
know if the warnings fire that would be appreciated.  It is still not
enough to track down the bug but at least it will confirm my current
hypothesis about how things look before there is a use of memory after
it is freed.

Thank you,
Eric

diff --git a/kernel/cred.c b/kernel/cred.c
index f784e08c2fbd..e7ffaa3cf5a6 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -120,6 +120,12 @@ static void put_cred_rcu(struct rcu_head *rcu)
 	if (cred->group_info)
 		put_group_info(cred->group_info);
 	free_uid(cred->user);
+#if 1
+	if ((cred->ucounts == cred->user_ns->ucounts) &&
+	    (atomic_read(&cred->ucounts->count) == 1)) {
+		WARN_ONCE(1, "put_cred_rcu: ucount count 1\n");
+	}
+#endif
 	if (cred->ucounts)
 		put_ucounts(cred->ucounts);
 	put_user_ns(cred->user_ns);
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32e..60fd88b34c1a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -743,6 +743,13 @@ void __noreturn do_exit(long code)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
 
+#if 1
+	if ((tsk->cred->ucounts == tsk->cred->user_ns->ucounts) &&
+	    (atomic_read(tsk->cred->ucounts->count) == 1)) {
+		WARN_ONCE(1, "do_exit: ucount count 1\n");
+	}
+#endif
+
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
 	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before


