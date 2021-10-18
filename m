Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202B64325A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhJRR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:57:22 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59572 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhJRR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:57:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:44280)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWqp-00ESzV-HC; Mon, 18 Oct 2021 11:55:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47614 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcWqo-004AnW-NK; Mon, 18 Oct 2021 11:55:07 -0600
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
        <871r4itfjw.fsf_-_@disp2133>
Date:   Mon, 18 Oct 2021 12:54:35 -0500
In-Reply-To: <871r4itfjw.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 18 Oct 2021 12:21:07 -0500")
Message-ID: <877dearzfo.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcWqo-004AnW-NK;;;mid=<877dearzfo.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/tEUz60tuIgGwnBsMjtXOnMtSfTAnHyoE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4618]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 234 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (4.5%), b_tie_ro: 9 (4.0%), parse: 0.78 (0.3%),
         extract_message_metadata: 2.1 (0.9%), get_uri_detail_list: 0.44
        (0.2%), tests_pri_-1000: 3.3 (1.4%), tests_pri_-950: 1.22 (0.5%),
        tests_pri_-900: 0.94 (0.4%), tests_pri_-90: 54 (23.2%), check_bayes:
        53 (22.6%), b_tokenize: 4.4 (1.9%), b_tok_get_all: 6 (2.4%),
        b_comp_prob: 1.58 (0.7%), b_tok_touch_all: 39 (16.5%), b_finish: 0.76
        (0.3%), tests_pri_0: 143 (61.0%), check_dkim_signature: 0.45 (0.2%),
        check_dkim_adsp: 2.3 (1.0%), poll_dns_idle: 0.64 (0.3%), tests_pri_10:
        2.3 (1.0%), tests_pri_500: 8 (3.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/4] ucounts: misc cleanups
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes are a set of miscellaneous fixes that makes
the ucount code a little bit easier to read.  There are all things
that I ran into while helping hunt the crazy reference count
bug.

I am aiming these at the next merge window and 5.16 rather than bug
fixes to get into the current 5.15.

Eric W. Biederman (4):
      ucounts: In set_cred_ucounts assume new->ucounts is non-NULL
      ucounts: Remove unnecessary test for NULL ucount in get_ucounts
      ucounts: Add get_ucounts_or_wrap for clarity
      ucounts: Use atomic_long_sub_return for clarity

 kernel/cred.c   |  5 ++---
 kernel/ucount.c | 20 +++++++++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

Eric
