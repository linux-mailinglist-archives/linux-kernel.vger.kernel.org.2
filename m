Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B503443636
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 20:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBTDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 15:03:45 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59496 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhKBTDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:03:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:45766)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhz1w-00EdGr-Do; Tue, 02 Nov 2021 13:01:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:38626 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhz1u-006oyn-QO; Tue, 02 Nov 2021 13:01:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Antoine Martin <antoine@nagafix.co.uk>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Date:   Tue, 02 Nov 2021 14:01:00 -0500
Message-ID: <87bl325qmr.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mhz1u-006oyn-QO;;;mid=<87bl325qmr.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19QwnNL3n7EIzbBrvxjzcJUMDV2bTOoDzI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 363 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (2.8%), b_tie_ro: 9 (2.4%), parse: 0.72 (0.2%),
         extract_message_metadata: 2.6 (0.7%), get_uri_detail_list: 0.85
        (0.2%), tests_pri_-1000: 3.6 (1.0%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 0.97 (0.3%), tests_pri_-90: 87 (24.0%), check_bayes:
        86 (23.6%), b_tokenize: 4.7 (1.3%), b_tok_get_all: 5 (1.5%),
        b_comp_prob: 1.74 (0.5%), b_tok_touch_all: 71 (19.4%), b_finish: 0.94
        (0.3%), tests_pri_0: 241 (66.4%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.9 (0.8%), poll_dns_idle: 1.01 (0.3%), tests_pri_10:
        2.0 (0.6%), tests_pri_500: 6 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucount cleanups for v5.16
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ucount-fixes-for-v5.16 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-fixes-for-v5.16

  HEAD: 32342701b4ba57a6fd77e8aca2f65f68c0fa1da6 ucounts: Use atomic_long_sub_return for clarity

While working on the ucount fixes a for v5.15 a number of cleanups
suggested themselves.  Little things like not testing for NULL when a
pointer can not be NULL and wrapping atomic_add_negative with a more
descriptive name, so that people reading the code can more quickly
understand what is going on.

Eric W. Biederman (4):
      ucounts: In set_cred_ucounts assume new->ucounts is non-NULL
      ucounts: Remove unnecessary test for NULL ucount in get_ucounts
      ucounts: Add get_ucounts_or_wrap for clarity
      ucounts: Use atomic_long_sub_return for clarity

 kernel/cred.c   |  5 ++---
 kernel/ucount.c | 20 +++++++++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

Eric
