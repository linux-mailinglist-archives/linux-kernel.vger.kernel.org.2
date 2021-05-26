Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7923391213
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhEZIMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhEZIMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11DC961441;
        Wed, 26 May 2021 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622016667;
        bh=IRRZpq7Jq6eVb7k8X++aNz0iYj4Kp1VdyKG7JS2CUdw=;
        h=From:To:Cc:Subject:Date:From;
        b=DypxiYV4EnmWqr5/BrbqHnWa0itvvbKhLPZnOXah/J2MH9u8gzy87JqJJGXUxRYql
         fwVHz/s+RghDND7X/6lM7uMixQdzsIErwcFklg9jTh4aXzKmMJcln5dlpgI/hLz0Hx
         1L5usGbfKci1ZZjdSdhQydzDNwGCBV5qMUWg3o0d4C38+kV2CqaFnnMw8SWFa75JY3
         Xre+eIFrICLFkLQ/BxlcayKk0iS20HcLQCuG79XZxV+BVhYJkLLjweUSdLSqlv3Iqs
         m0OEHpAB+NkHijJJqfjC7ZST1Aa/xRnlKaNcwXrjcCPXqSscibitL3BS+k0nwih0L3
         ItvvBf9Qc7zpA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Date:   Wed, 26 May 2021 11:11:00 +0300
Message-Id: <20210526081100.12239-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

After the consolidation of early memory reservations introduced by the
commit a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
the kernel fails to boot if X86_RESERVE_LOW is set to 640K.

The boot fails because real-time trampoline must be allocated under 1M (or
essentially under 640K) but with X86_RESERVE_LOW set to 640K the memory is
already reserved by the time reserve_real_mode() is called.

Before the reordering of the early memory reservations it was possible to
allocate from low memory even despite user's request to avoid using that
memory. This lack of consistency could potentially lead to memory
corruptions by BIOS in the areas allocated by kernel.

Decrease the maximum of X86_RESERVE_LOW range to 512K to allow blocking the
use of most of the low memory by the kernel while still leaving space for
allocations that should be compatible with real mode.

Update the Kconfig help text of X86_RESERVE_LOW to make it explicit that
kernel requires low memory to boot properly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=213177
Fixes: a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..7a972b77819e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1696,7 +1696,7 @@ config X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK
 config X86_RESERVE_LOW
 	int "Amount of low memory, in kilobytes, to reserve for the BIOS"
 	default 64
-	range 4 640
+	range 4 512
 	help
 	  Specify the amount of low memory to reserve for the BIOS.
 
@@ -1711,8 +1711,11 @@ config X86_RESERVE_LOW
 	  You can set this to 4 if you are absolutely sure that you
 	  trust the BIOS to get all its memory reservations and usages
 	  right.  If you know your BIOS have problems beyond the
-	  default 64K area, you can set this to 640 to avoid using the
-	  entire low memory range.
+	  default 64K area, you can set this to 512 to avoid using most
+	  of the low memory range.
+
+	  Note, that a part of the low memory range is still required for
+	  kernel to boot properly.
 
 	  If you have doubts about the BIOS (e.g. suspend/resume does
 	  not work or there's kernel crashes after certain hardware

base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.28.0

