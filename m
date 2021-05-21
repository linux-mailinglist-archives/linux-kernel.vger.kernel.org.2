Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D167138BB60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhEUBOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236385AbhEUBOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:14:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4D6561353;
        Fri, 21 May 2021 01:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621559606;
        bh=Q53uLt058VqqMq7piTaVF16wJNWWvSaaXUZvYmks+k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wa3x4reIsA97+00X/REPgrpX59dUttps4HSTPOhCqH07y/eUa4+/8zgqQ/3khDt6G
         RIJCLNkrFpEn+absROamc2tuQukdS4TaT8wAzI/xfz5W9R7MVKwgFHupVqK8csuB+F
         8Z+fbFbpVeSW+gTOW7czbbwG+fbCd/GWUhPhJ09Mm2hSBcTGcty/9Mj+oHQZtz3XTz
         4ysVq6gN3lUB/zeQu80ySO+wbMrGcuJh10xZ2y4TP0+P6CPSrdKxLRz9SLeVhfUiKn
         kfoVlg+NGOPzJ1YEQ428QJRywPr6TNt3DCY59UTJF+FDEdeW7aRLSqug1qUGPSPoIE
         twCmlhgyvNXyA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/3] hexagon: Use common DISCARDS macro
Date:   Thu, 20 May 2021 18:12:38 -0700
Message-Id: <20210521011239.1332345-3-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521011239.1332345-1-nathan@kernel.org>
References: <20210521011239.1332345-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ld.lld warns that the '.modinfo' section is not currently handled:

ld.lld: warning: kernel/built-in.a(workqueue.o):(.modinfo) is being placed in '.modinfo'
ld.lld: warning: kernel/built-in.a(printk/printk.o):(.modinfo) is being placed in '.modinfo'
ld.lld: warning: kernel/built-in.a(irq/spurious.o):(.modinfo) is being placed in '.modinfo'
ld.lld: warning: kernel/built-in.a(rcu/update.o):(.modinfo) is being placed in '.modinfo'

The '.modinfo' section was added in commit 898490c010b5 ("moduleparam:
Save information about built-in modules in separate file") to the
DISCARDS macro but Hexagon has never used that macro. The unification of
DISCARDS happened in commit 023bf6f1b8bf ("linker script: unify usage of
discard definition") in 2009, prior to Hexagon being added in 2011.

Switch Hexagon over to the DISCARDS macro so that anything that is
expected to be discarded gets discarded.

Fixes: e95bf452a9e2 ("Hexagon: Add configuration and makefiles for the Hexagon architecture.")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/hexagon/kernel/vmlinux.lds.S | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 20f19539c5fc..57465bff1fe4 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -61,14 +61,9 @@ SECTIONS
 
 	_end = .;
 
-	/DISCARD/ : {
-		EXIT_TEXT
-		EXIT_DATA
-		EXIT_CALL
-	}
-
 	STABS_DEBUG
 	DWARF_DEBUG
 	ELF_DETAILS
 
+	DISCARDS
 }
-- 
2.32.0.rc0

