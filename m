Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7A436739
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhJUQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:06:18 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42126 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJUQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:06:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:35474)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdaXv-00HaQf-KY; Thu, 21 Oct 2021 10:04:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53576 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdaXu-0040hU-BR; Thu, 21 Oct 2021 10:03:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Antoine Martin <antoine@nagafix.co.uk>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Date:   Thu, 21 Oct 2021 11:02:14 -0500
Message-ID: <877de6e589.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdaXu-0040hU-BR;;;mid=<877de6e589.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/uk6fZ9fKMIhVQwLtrU1ESPIYghum/oa8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 630 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (1.9%), b_tie_ro: 10 (1.6%), parse: 0.89
        (0.1%), extract_message_metadata: 3.6 (0.6%), get_uri_detail_list:
        1.48 (0.2%), tests_pri_-1000: 4.2 (0.7%), tests_pri_-950: 1.43 (0.2%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 179 (28.4%), check_bayes:
        176 (28.0%), b_tokenize: 6 (1.0%), b_tok_get_all: 6 (0.9%),
        b_comp_prob: 2.8 (0.4%), b_tok_touch_all: 157 (24.9%), b_finish: 1.01
        (0.2%), tests_pri_0: 392 (62.2%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.80 (0.1%), tests_pri_10:
        3.6 (0.6%), tests_pri_500: 24 (3.7%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucount fixes for v5.15
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ucount-fixes-for-v5.15 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-fixes-for-v5.15

  HEAD: 5ebcbe342b1c12fae44b4f83cbeae1520e09857e ucounts: Move get_ucounts from cred_alloc_blank to key_change_session_keyring

There has been one very hard to track down bug in the ucount code that
we have been tracking since roughly v5.14 was released.  Alex managed to
find a reliable reproducer a few days ago and then I was able to
instrument the code and figure out what the issue was.

It turns out the sigqueue_alloc single atomic operation optimization did
not play nicely with ucounts multiple level rlimits.  It turned out that
either sigqueue_alloc or sigqueue_free could be operating on multiple
levels and trigger the conditions for the optimization on more than one
level at the same time.

To deal with that situation I have introduced inc_rlimit_get_ucounts
and dec_rlimit_put_ucounts that just focuses on the optimization and
the rlimit and ucount changes.

While looking into the big bug I found I couple of other little issues
so I am including those fixes here as well.


When I have time I would very much like to dig into process ownership of
the shared signal queue and see if we could pick a single owner for the
entire queue so that all of the rlimits can count to that owner.  Which
should entirely remove the need to call get_ucounts and put_ucounts
in sigqueue_alloc and sigqueue_free.  It is difficult because Linux
unlike POSIX supports setuid that works on a single thread.

Eric W. Biederman (4):
      ucounts: Fix signal ucount refcounting
      ucounts: Pair inc_rlimit_ucounts with dec_rlimit_ucoutns in commit_creds
      ucounts: Proper error handling in set_cred_ucounts
      ucounts: Move get_ucounts from cred_alloc_blank to key_change_session_keyring

 kernel/cred.c                | 9 ++++-----
 security/keys/process_keys.c | 8 ++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

Eric
