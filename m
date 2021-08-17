Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308343EEB95
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbhHQLZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:25:48 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:59020 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231515AbhHQLZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:25:47 -0400
X-QQ-mid: bizesmtp49t1629199503tl9nxqiz
Received: from localhost.localdomain (unknown [125.69.42.50])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 17 Aug 2021 19:25:02 +0800 (CST)
X-QQ-SSF: 01000000004000B0C000B00A0000000
X-QQ-FEAT: E35I0CyQR8OS92NvTVxc7V3QIeX7HEFo+Ft+PyTOhA92pqpZ74iXDfRXkXy0W
        gsqgs+gfZf5bceT/1mKI1MMujn8ETUXiCQH81AlL2Vi7BLHZv+rCVvMf2eZQkE5g5EYlsVC
        4OmDnXoB0YJ4prUa/4FhuslRapE5R4GjOdVm8uX1SUWz2rNk9Mnl3bbsTO+dE9AefZPrpBd
        FrRAfFaQ3mZZeqfTMcuP/m9IwkO4NrjQ+3EEz6CYBGUsaoIWEg7ka6mbgtkgL3eRRK7mRG7
        n0WDCfipyZaFEGCWQq5F5Chg1nKM4WtpDBfaRGUAWV3YId3AzcDr/QpEcDG7LwPy/DbZnPq
        xjQvpKY
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     valentin.schneider@arm.com
Cc:     akpm@linux-foundation.org, wangborong@cdjrlc.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: fix typo in a comment
Date:   Tue, 17 Aug 2021 19:25:00 +0800
Message-Id: <20210817112500.12848-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `when' in comment `TBD when when IA64 starts to support
suspend...' is repeated. Consequently, one `when' should be removed
from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/ia64/kernel/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index e2af6b172200..96d13cb7c19f 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -906,6 +906,6 @@ EXPORT_SYMBOL(acpi_unregister_ioapic);
 /*
  * acpi_suspend_lowlevel() - save kernel state and suspend.
  *
- * TBD when when IA64 starts to support suspend...
+ * TBD when IA64 starts to support suspend...
  */
 int acpi_suspend_lowlevel(void) { return 0; }
-- 
2.32.0

