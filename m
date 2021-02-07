Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476EA31241D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhBGLwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 06:52:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:33378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhBGLn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 06:43:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1549AD24;
        Sun,  7 Feb 2021 11:43:14 +0000 (UTC)
Date:   Sun, 7 Feb 2021 12:43:12 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] core/urgent for v5.11-rc7
Message-ID: <20210207114312.GD32127@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pls pull two core/urgent fixes for v5.11.

Thx.

---
The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.11_rc7

for you to fetch changes up to 36a6c843fd0d8e02506681577e96dabd203dd8e8:

  entry: Use different define for selector variable in SUD (2021-02-06 00:21:42 +0100)

----------------------------------------------------------------
- For syscall user dispatch, separate ptctl operation from syscall
redirection range specification before the API has been made official in 5.11.

- Ensure tasks using the generic syscall code do trap after returning
from a syscall when single-stepping is requested.

----------------------------------------------------------------
Gabriel Krisman Bertazi (2):
      entry: Ensure trap after single-step on system call return
      entry: Use different define for selector variable in SUD

 Documentation/admin-guide/syscall-user-dispatch.rst        |  4 ++--
 arch/x86/include/asm/entry-common.h                        |  2 --
 arch/x86/kernel/step.c                                     | 10 ++++++++--
 include/linux/entry-common.h                               |  1 +
 include/linux/thread_info.h                                |  2 ++
 include/uapi/linux/prctl.h                                 |  3 +++
 kernel/entry/common.c                                      | 12 ++----------
 kernel/entry/syscall_user_dispatch.c                       |  4 ++--
 .../selftests/syscall_user_dispatch/sud_benchmark.c        |  8 +++++---
 tools/testing/selftests/syscall_user_dispatch/sud_test.c   | 14 ++++++++------
 10 files changed, 33 insertions(+), 27 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
