Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40E4324E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhJRRXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:23:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45498 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhJRRXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:23:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:36310)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWK3-00A8AD-BK; Mon, 18 Oct 2021 11:21:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:45976 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWK2-00DI9w-Gk; Mon, 18 Oct 2021 11:21:14 -0600
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
Date:   Mon, 18 Oct 2021 12:21:07 -0500
In-Reply-To: <87fssytizw.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 11:06:43 -0500")
Message-ID: <871r4itfjw.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWK2-00DI9w-Gk;;;mid=<871r4itfjw.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19OjurVpKQBBR89AM56Z2+P1ypTc7sc73E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3388]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 273 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (4.4%), b_tie_ro: 10 (3.6%), parse: 0.94
        (0.3%), extract_message_metadata: 2.7 (1.0%), get_uri_detail_list:
        0.43 (0.2%), tests_pri_-1000: 4.2 (1.5%), tests_pri_-950: 1.23 (0.5%),
        tests_pri_-900: 0.95 (0.3%), tests_pri_-90: 63 (23.2%), check_bayes:
        62 (22.8%), b_tokenize: 4.5 (1.7%), b_tok_get_all: 6 (2.1%),
        b_comp_prob: 1.85 (0.7%), b_tok_touch_all: 47 (17.4%), b_finish: 0.78
        (0.3%), tests_pri_0: 170 (62.2%), check_dkim_signature: 0.62 (0.2%),
        check_dkim_adsp: 2.6 (1.0%), poll_dns_idle: 0.85 (0.3%), tests_pri_10:
        2.3 (0.9%), tests_pri_500: 7 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/3] ucounts: misc fixes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While digging into the previous ucount kernel crashes I found some minor
bugs in the ucount code.  When hit these bugs all result in a ucount
either being counted in the wrong location or leak of a struct ucounts.

Nothing particularly serious but certainly things that should be fixed.

Eric W. Biederman (3):
      ucounts: Pair inc_rlimit_ucounts with dec_rlimit_ucoutns in commit_creds
      ucounts: Proper error handling in set_cred_ucounts
      ucounts: Move get_ucounts from cred_alloc_blank to key_change_session_keyring

 kernel/cred.c                | 9 ++++-----
 security/keys/process_keys.c | 8 ++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

Eric
