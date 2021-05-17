Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D4B382324
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhEQDpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhEQDpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:45:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A41C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 20:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VGRd0IE1vCkKbTyY/fVFkbcp25z0BZiNr5D9btdzjTc=; b=TlKIDO280BFTi2QIUzOWN8XsTb
        SYrgDY/2edqDlvHejxh4X6Tab+lw5iTd2II1K+2nX9weccME/Cl5XYapu8ILOiyr2PwyT7wvUPyOk
        a7X5+sm2W2xoayoFy55E8UfD3WD98h32qFggUNuiaC04Dlh/9vWP7pIb3PrQvTZH1oZlnGIOTOdWE
        3JpGZkg3njrt3jW3QPYfjzwihnB88mr9qWdc0IUlMJsHIMlDnDAyYgdonyQa8TY3TxUbGhxFmYF9I
        CnDtBNQOZM8W0WXRP6cyoYbJ9j3SiURF0oQsC2Nz6H4NJIxt8ODdoFJg2G9iEIV34zfaAaQmZqX3y
        QoOY2XQg==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liUBD-00DSWJ-J1; Mon, 17 May 2021 03:44:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH list
Date:   Sun, 16 May 2021 20:44:30 -0700
Message-Id: <20210517034430.9569-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both arch/um/ and arch/xtensa/ cause a Kconfig warning for LOCKDEP.
These arch-es select LOCKDEP_SUPPORT but they are not listed as one
of the arch-es that LOCKDEP depends on.

Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
intend to have LOCKDEP support, replace the awkward list of
arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.

Fixes this kconfig warning: (for both um and xtensa)

WARNING: unmet direct dependencies detected for LOCKDEP
  Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
  Selected by [y]:
  - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
  - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
  - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
 lib/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210514.orig/lib/Kconfig.debug
+++ linux-next-20210514/lib/Kconfig.debug
@@ -1383,7 +1383,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select STACKTRACE
-	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
+	depends on FRAME_POINTER || LOCKDEP_SUPPORT
 	select KALLSYMS
 	select KALLSYMS_ALL
 
