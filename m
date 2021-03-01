Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D6327F4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhCANUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:20:31 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:37768 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhCANSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:18:48 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121DFe7R026106;
        Mon, 1 Mar 2021 22:15:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121DFe7R026106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614604541;
        bh=gJTB/sCnF9oKN0HSr5hqsCuTGabQiE8Oyz/pm90esf0=;
        h=From:To:Cc:Subject:Date:From;
        b=vvY5Pnss4Du15BODazwKNN7Q741N6EAzPW0CU/cwr0OifzXTJMmzdQDeNhK8wOj1+
         HJVb01GXOPtlrXZQ6A1c1RioYFMO2QB7KnRVeJ5cTJlf5d0j11ZJBUUm+/0wwEunFh
         uGtZnVvxz9IdY1l4IJafnGzbMmLKRKt1+VchY9z6LnGJGU58W275bWtcHNiqo7bQIZ
         lpD3je8mR7eurBH8DwRVwf0ysD42A5N59o/F7DWMg15vx13EnYTYOigK0yDeyIARwN
         cAOdmVnrn/UuwAvE0hwf6vwaHzFazqETQ7DpjllLz87m67SwTjwXqhqE9kmY2V6YzJ
         98tXFjVpHa/gQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Dike <jdike@addtoit.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCH 0/7] x86: fix warnings and refactor syscall code
Date:   Mon,  1 Mar 2021 22:15:25 +0900
Message-Id: <20210301131533.64671-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series makes a lot of cleanups.
We can remove a lot of lines.
The code diff is attractive.



Masahiro Yamada (7):
  x86/syscalls: fix -Wmissing-prototypes warnings from COND_SYSCALL()
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
 arch/x86/include/asm/syscall_wrapper.h | 11 +++---
 arch/x86/include/asm/unistd.h          |  8 ++---
 arch/x86/um/sys_call_table_32.c        | 14 +++-----
 arch/x86/um/sys_call_table_64.c        | 15 ++-------
 12 files changed, 61 insertions(+), 179 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscallhdr.sh
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh

-- 
2.27.0

