Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66453FCC48
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhHaR0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:26:35 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54370 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhHaR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:26:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:47848)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mL7Vu-008hvQ-8M; Tue, 31 Aug 2021 11:25:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:36834 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mL7Vr-00AVTR-JA; Tue, 31 Aug 2021 11:25:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, Cyril Hrubis <chrubis@suse.cz>,
        Kees Cook <keescook@chromium.org>
Date:   Tue, 31 Aug 2021 12:25:24 -0500
Message-ID: <87bl5d7chn.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mL7Vr-00AVTR-JA;;;mid=<87bl5d7chn.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18iBrMNkuLmZ+Ti0q7xXkYSKxgmQoYwcqM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_XMDrugObfuBody_08,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4619]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1501 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 10 (0.7%), b_tie_ro: 8 (0.6%), parse: 1.95 (0.1%),
         extract_message_metadata: 7 (0.5%), get_uri_detail_list: 3.2 (0.2%),
        tests_pri_-1000: 7 (0.5%), tests_pri_-950: 2.1 (0.1%), tests_pri_-900:
        1.76 (0.1%), tests_pri_-90: 70 (4.7%), check_bayes: 68 (4.5%),
        b_tokenize: 14 (1.0%), b_tok_get_all: 9 (0.6%), b_comp_prob: 2.9
        (0.2%), b_tok_touch_all: 38 (2.5%), b_finish: 1.08 (0.1%),
        tests_pri_0: 1367 (91.1%), check_dkim_signature: 0.65 (0.0%),
        check_dkim_adsp: 3.6 (0.2%), poll_dns_idle: 1.22 (0.1%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 14 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] exit cleanups for v5.15-rc1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the exit-cleanups-for-v5.15 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.15

  HEAD: d21918e5a94a862ccb297b9f2be38574c865fda0 signal/seccomp: Dump core when there is only one live thread

In preparation of doing something about PTRACE_EVENT_EXIT I have started
cleaning up various pieces of code related to do_exit.  Most of that
code I did not manage to get tested and reviewed before the merge window
opened but a handful of very useful cleanups are ready to be merged.

The first change is simply the removal of the bdflush system call.  The
code has now been disabled long enough that even the oldest userspace
working userspace setups anyone can find to test are fine with the
bdflush system call being removed.

Changing m68k fsp040_die to use force_sigsegv(SIGSEGV) instead of
calling do_exit directly is interesting only in that it is nearly the
most difficult of the incorrect uses of do_exit to remove.

The change to the seccomp code to simply send a signal instead of
calling do_coredump directly is a very nice little cleanup made possible
by realizing the existing signal sending helpers were missing a little
bit of functionality that is easy to provide.

Eric W. Biederman (4):
      exit/bdflush: Remove the deprecated bdflush system call
      signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
      signal/seccomp: Refactor seccomp signal and coredump generation
      signal/seccomp: Dump core when there is only one live thread

 arch/alpha/kernel/syscalls/syscall.tbl             |  2 +-
 arch/arm/tools/syscall.tbl                         |  2 +-
 arch/arm64/include/asm/unistd32.h                  |  2 +-
 arch/ia64/kernel/syscalls/syscall.tbl              |  2 +-
 arch/m68k/fpsp040/skeleton.S                       |  3 +-
 arch/m68k/kernel/syscalls/syscall.tbl              |  2 +-
 arch/m68k/kernel/traps.c                           |  2 +-
 arch/microblaze/kernel/syscalls/syscall.tbl        |  2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl          |  2 +-
 arch/parisc/kernel/syscalls/syscall.tbl            |  2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl           |  2 +-
 arch/s390/kernel/syscalls/syscall.tbl              |  2 +-
 arch/sh/kernel/syscalls/syscall.tbl                |  2 +-
 arch/sparc/kernel/syscalls/syscall.tbl             |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl             |  2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl            |  2 +-
 fs/buffer.c                                        | 27 --------------
 include/linux/sched/signal.h                       |  1 +
 include/linux/syscalls.h                           |  1 -
 include/uapi/linux/capability.h                    |  1 -
 kernel/seccomp.c                                   | 42 ++++------------------
 kernel/signal.c                                    | 30 +++++++++++++---
 kernel/sys_ni.c                                    |  1 -
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  2 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  2 +-
 25 files changed, 53 insertions(+), 87 deletions(-)

Eric
