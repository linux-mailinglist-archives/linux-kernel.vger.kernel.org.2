Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F154838257D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhEQHlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:41:36 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:34335 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhEQHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:41:33 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 14H7cLoI027919;
        Mon, 17 May 2021 16:38:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 14H7cLoI027919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621237102;
        bh=dO9DwLaY/vwEhj304AHP4220fuSdeZe2U8+mt+m9UWM=;
        h=From:To:Cc:Subject:Date:From;
        b=GFZ9w+GW31YXRrmal/aHhZXwy9Fk8pA9XlnvUh6bLpZ5kSG26W8dtxR5lO8BK/IqX
         QPW8gpRpDXbPqsR24QXy9zF0O2hev3hY9DZJbAt/3AXjeefz5QsjMpSDsI94y1aXxW
         roalE0nq9adIRSOgcOET93lIoUd35CKfnu4cgKatfKYgG0pJ/emXm4YKrThNB/KeWY
         zwTwDGUq7jEZgOiSGHV+ANRTTGte3+XHzXB2Hgc1ahAt4Ca/QdfAUa1/84GCpWJIFm
         0ckMHsyTdvPdMTh8uKQr/98L59ZkAV99PBwVCV/Rpz+G7SjceFTaZVTUwsGb5w/cFZ
         uzx10+1PyJVrQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: [RESEND PATCH 0/6] x86: switch to generic syscall{tbl,hdr}.sh with various syscall code cleanups
Date:   Mon, 17 May 2021 16:38:08 +0900
Message-Id: <20210517073815.97426-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Previously, many architectures duplicated similar scripts to
generate syscall headers.

For v5.11:

  $ find  arch  -name syscalltbl.sh
  arch/parisc/kernel/syscalls/syscalltbl.sh
  arch/alpha/kernel/syscalls/syscalltbl.sh
  arch/microblaze/kernel/syscalls/syscalltbl.sh
  arch/powerpc/kernel/syscalls/syscalltbl.sh
  arch/arm/tools/syscalltbl.sh
  arch/sparc/kernel/syscalls/syscalltbl.sh
  arch/sh/kernel/syscalls/syscalltbl.sh
  arch/xtensa/kernel/syscalls/syscalltbl.sh
  arch/ia64/kernel/syscalls/syscalltbl.sh
  arch/x86/entry/syscalls/syscalltbl.sh
  arch/mips/kernel/syscalls/syscalltbl.sh
  arch/m68k/kernel/syscalls/syscalltbl.sh
  $ find  arch  -name  syscallhdr.sh
  arch/parisc/kernel/syscalls/syscallhdr.sh
  arch/alpha/kernel/syscalls/syscallhdr.sh
  arch/microblaze/kernel/syscalls/syscallhdr.sh
  arch/powerpc/kernel/syscalls/syscallhdr.sh
  arch/arm/tools/syscallhdr.sh
  arch/sparc/kernel/syscalls/syscallhdr.sh
  arch/sh/kernel/syscalls/syscallhdr.sh
  arch/xtensa/kernel/syscalls/syscallhdr.sh
  arch/ia64/kernel/syscalls/syscallhdr.sh
  arch/x86/entry/syscalls/syscallhdr.sh
  arch/mips/kernel/syscalls/syscallhdr.sh
  arch/m68k/kernel/syscalls/syscallhdr.sh

They were mostly consolidated by the time of v5.13-rc1:

Now:

  $ find  arch  -name syscalltbl.sh
  arch/x86/entry/syscalls/syscalltbl.sh
  $ find  arch  -name  syscallhdr.sh
  arch/x86/entry/syscalls/syscallhdr.sh

x86 is a remaining bit because x86 maintainers did not respond.

This patch series makes a lot of cleanups.
We can remove a lot of lines.
The code diff is attractive.

No code change since the previous submission.
(Only 1/7 was applied, so dropped from the series)

https://lore.kernel.org/lkml/20210301131533.64671-1-masahiroy@kernel.org/



Masahiro Yamada (6):
  x86/entry/x32: rename __x32_compat_sys_* to __x64_compat_sys_*
  x86/syscalls: switch to generic syscalltbl.sh
  x86/syscalls: stop filling syscall arrays with *_sys_ni_syscall
  x86/unistd: define X32_NR_syscalls only for 64-bit kernel
  x86/syscalls: use __NR_syscalls instead of __NR_syscall_max
  x86/syscalls: switch to generic syscallhdr.sh

 arch/um/kernel/skas/syscall.c          |  2 +-
 arch/x86/entry/syscall_32.c            | 20 +++++------
 arch/x86/entry/syscall_64.c            | 17 +++-------
 arch/x86/entry/syscall_x32.c           | 35 ++++----------------
 arch/x86/entry/syscalls/Makefile       | 36 +++++++++++---------
 arch/x86/entry/syscalls/syscallhdr.sh  | 35 --------------------
 arch/x86/entry/syscalls/syscalltbl.sh  | 46 --------------------------
 arch/x86/include/asm/Kbuild            |  1 +
 arch/x86/include/asm/syscall_wrapper.h | 10 +++---
 arch/x86/include/asm/unistd.h          |  8 ++---
 arch/x86/um/sys_call_table_32.c        | 14 +++-----
 arch/x86/um/sys_call_table_64.c        | 15 ++-------
 12 files changed, 60 insertions(+), 179 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscallhdr.sh
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh

-- 
2.27.0

