Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D03FCB81
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbhHaQ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:29:06 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49742 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhHaQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:29:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:55254)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mL6cJ-00FbWO-LQ; Tue, 31 Aug 2021 10:28:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:35292 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mL6cH-00AJJR-Dd; Tue, 31 Aug 2021 10:28:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>
Date:   Tue, 31 Aug 2021 11:24:54 -0500
Message-ID: <877dg1a8fd.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mL6cH-00AJJR-Dd;;;mid=<877dg1a8fd.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1893cfw/E+6DFEAFpKapNQGUVX4LkQWL/U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2633]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1609 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.2 (0.2%), b_tie_ro: 2.2 (0.1%), parse: 0.57
        (0.0%), extract_message_metadata: 2.6 (0.2%), get_uri_detail_list:
        1.22 (0.1%), tests_pri_-1000: 2.7 (0.2%), tests_pri_-950: 0.98 (0.1%),
        tests_pri_-900: 0.76 (0.0%), tests_pri_-90: 346 (21.5%), check_bayes:
        345 (21.5%), b_tokenize: 5 (0.3%), b_tok_get_all: 213 (13.2%),
        b_comp_prob: 1.47 (0.1%), b_tok_touch_all: 123 (7.6%), b_finish: 0.69
        (0.0%), tests_pri_0: 1236 (76.8%), check_dkim_signature: 0.57 (0.0%),
        check_dkim_adsp: 2.4 (0.1%), poll_dns_idle: 1.09 (0.1%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] Final si_trapno bits for v5.15
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the siginfo-si_trapno-for-v5.15 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-si_trapno-for-v5.15

  HEAD: ee53488cc74143cadbe752d5332b1e3fd87eed49 Final si_trapno bits

The full set of si_trapno changes was not appropriate as a fix
for the newly added SIGTRAP TRAP_PERF, and so I postponed the
rest of the related cleanups.

This is the rest of the cleanups for si_trapno that reduces it from
being a really weird arch special case that is expect to be always
present (but isn't) on the architectures that support it to being yet
another field in the _sigfault union of struct siginfo.

The changes have been reviewed and marinated in linux-next.  With the
removal of this awkward special case new code (like SIGTRAP TRAP_PERF)
that works across architectures should be easier to write and maintain.

Eric W. Biederman (5):
      signal/sparc: si_trapno is only used with SIGILL ILL_ILLTRP
      signal/alpha: si_trapno is only used with SIGFPE and SIGTRAP TRAP_UNK
      signal: Remove the generic __ARCH_SI_TRAPNO support
      signal: Verify the alignment and size of siginfo_t
      signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency

Marco Elver (3):
      sparc64: Add compile-time asserts for siginfo_t offsets
      arm: Add compile-time asserts for siginfo_t offsets
      arm64: Add compile-time asserts for siginfo_t offsets

 arch/alpha/include/uapi/asm/siginfo.h |  2 --
 arch/alpha/kernel/osf_sys.c           |  2 +-
 arch/alpha/kernel/signal.c            |  4 +--
 arch/alpha/kernel/traps.c             | 26 +++++++--------
 arch/alpha/mm/fault.c                 |  4 +--
 arch/arm/kernel/signal.c              | 39 ++++++++++++++++++++++
 arch/arm64/kernel/signal.c            | 39 ++++++++++++++++++++++
 arch/arm64/kernel/signal32.c          | 39 ++++++++++++++++++++++
 arch/mips/include/uapi/asm/siginfo.h  |  2 --
 arch/sparc/include/uapi/asm/siginfo.h |  3 --
 arch/sparc/kernel/process_64.c        |  2 +-
 arch/sparc/kernel/signal32.c          | 37 +++++++++++++++++++++
 arch/sparc/kernel/signal_64.c         | 36 ++++++++++++++++++++
 arch/sparc/kernel/sys_sparc_32.c      |  2 +-
 arch/sparc/kernel/sys_sparc_64.c      |  2 +-
 arch/sparc/kernel/traps_32.c          | 22 ++++++-------
 arch/sparc/kernel/traps_64.c          | 44 +++++++++++--------------
 arch/sparc/kernel/unaligned_32.c      |  2 +-
 arch/sparc/mm/fault_32.c              |  2 +-
 arch/sparc/mm/fault_64.c              |  2 +-
 arch/x86/kernel/signal_compat.c       |  6 ++++
 fs/signalfd.c                         |  4 +--
 include/linux/sched/signal.h          | 11 ++-----
 include/linux/signal.h                |  2 +-
 include/uapi/asm-generic/siginfo.h    |  5 +++
 kernel/signal.c                       | 62 +++++++++++++++++++++++++----------
 26 files changed, 305 insertions(+), 96 deletions(-)

Eric

