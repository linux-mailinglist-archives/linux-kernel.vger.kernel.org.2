Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79B6323070
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhBWSQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:16:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233083AbhBWSPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:15:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAD2664DD3;
        Tue, 23 Feb 2021 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614104112;
        bh=IWQxG5xNjf9kfS3uo/zpofVF2LyYATjrsEZ+rVk5dC0=;
        h=From:To:Cc:Subject:Date:From;
        b=LrLSDI5eMLZhIM6QR+JbMqu4n7Kg7M6S2a4dh5LRC1/+hOH2RfYQ/JOJIVYhlaJSO
         lmXTamu2BHlhphQsoTQ6QnrzZ9U+VL2da2KljhBKGGX0Kbu1zgcRnrs9hYetHlpWv/
         7KgIQMT7jon9mnNC6RXOv4CxyjlUR868s7NTJ+aXfBszT9YVKkwAts9SvoCXdDELHN
         cS9kFLR04Ik0WV8encezuC6mfHSx+zzynNFzVrr447H1ZEJE5lirG3nU41kLcc/zPw
         sapk2PvaXIiIon+AICIo1l4Or6f/3Gp9rM7WtFR8HXaWVPySKPu2ecEPSoqxl6Xwcx
         cG+xJoL0ZgbwQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/3] x86/entry: A compat syscall bugfix and some test stuff
Date:   Tue, 23 Feb 2021 10:15:07 -0800
Message-Id: <cover.1614104065.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compat syscall argument fixup error path is wrong.  Fix it.

This also adds some sanity checks to the kernel that catch the bug
when running selftests.

Changes from v1:
 - The fix is actually correct this time, I hope

Andy Lutomirski (3):
  entry: Check that syscall entries and syscall exits match
  x86/entry: Fix entry/exit mismatch on failed fast 32-bit syscalls
  selftests/x86: Add a missing .note.GNU-stack section to thunks_32.S

 arch/x86/entry/common.c                 |  3 ++-
 include/linux/entry-common.h            | 11 +++++++++++
 include/linux/sched.h                   |  1 +
 init/init_task.c                        |  9 +++++++++
 kernel/entry/common.c                   | 25 ++++++++++++++++++++++++-
 tools/testing/selftests/x86/thunks_32.S |  2 ++
 6 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.29.2

