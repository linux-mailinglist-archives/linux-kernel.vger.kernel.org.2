Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A7E3F77D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbhHYOzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:55:16 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38482 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbhHYOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:55:15 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:58038)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mIuIO-00BAd0-0H; Wed, 25 Aug 2021 08:54:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:54606 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mIuIN-00D901-5O; Wed, 25 Aug 2021 08:54:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>,
        "Ma\, XinjianX" <xinjianx.ma@intel.com>
Date:   Wed, 25 Aug 2021 09:54:20 -0500
Message-ID: <871r6ho9r7.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mIuIN-00D901-5O;;;mid=<871r6ho9r7.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+AXkxzxj1ZAa4HQNgApbm3PwqpXf2lU84=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2607]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 316 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.7 (1.2%), b_tie_ro: 2.6 (0.8%), parse: 0.60
        (0.2%), extract_message_metadata: 2.0 (0.6%), get_uri_detail_list:
        0.65 (0.2%), tests_pri_-1000: 2.7 (0.9%), tests_pri_-950: 1.02 (0.3%),
        tests_pri_-900: 0.84 (0.3%), tests_pri_-90: 120 (37.8%), check_bayes:
        118 (37.5%), b_tokenize: 3.4 (1.1%), b_tok_get_all: 4.3 (1.4%),
        b_comp_prob: 1.08 (0.3%), b_tok_touch_all: 107 (33.9%), b_finish: 0.70
        (0.2%), tests_pri_0: 171 (54.0%), check_dkim_signature: 0.34 (0.1%),
        check_dkim_adsp: 3.3 (1.0%), poll_dns_idle: 1.38 (0.4%), tests_pri_10:
        2.7 (0.8%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucount fixes for v5.14
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the for-v5.14 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14

  HEAD: bbb6d0f3e1feb43d663af089c7dedb23be6a04fb ucounts: Increase ucounts reference counter before the security hook

This branch fixes a regression that made it impossible to increase
rlimits that had been converted to the ucount infrastructure, and also
fixes a reference counting bug where the reference was not incremented
soon enough.

The fixes are trivial and the bugs have been encountered in the wild,
and the fixes have been tested. 

Alexey Gladkov (1):
      ucounts: Increase ucounts reference counter before the security hook

Eric W. Biederman (1):
      ucounts: Fix regression preventing increasing of rlimits in init_user_ns

 kernel/cred.c | 12 ++++++------
 kernel/fork.c |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

Thank you,
Eric
