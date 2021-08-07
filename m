Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7713E33F6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 09:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhHGHZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 03:25:33 -0400
Received: from smtpbg511.qq.com ([203.205.250.109]:43487 "EHLO
        smtpbg511.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhHGHZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 03:25:32 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Aug 2021 03:25:31 EDT
X-QQ-mid: bizesmtp33t1628321103t79kuz7l
Received: from localhost.localdomain (unknown [125.69.42.194])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 07 Aug 2021 15:25:02 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: FsG0r2mBeluv3Zd9YWfYoh+AeeQRy3mwRvhGF/vi0SQ8PvrFHvtPsenqipt2u
        nQYQ+mvnRsp2/+RsuU7KsxD8TtXzL8kT+dqidTfLRsmt1rX95RGtB+NEiGUglWXK9n16Rhu
        OQfdZE/gWhHz9bJ0HRmy6nxoeU4+bBKiHmoeuezT9zzJNtmJx8SI/3KUmWu9nDhnMR0z9EF
        0i6USB7MTzzX9TapcAP9dqZCCpK0vxbCruZzhEFH8Hugwj1E9hC2ikRbcKarFxppoAj92ec
        KKyjCMDeIRV7pdT7FwboFQUHLzJXP29NxEsPvbZ7dFJBMbvhgUm+gdfljv55DCegSwVd7gl
        8/LEMVK
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ley.foon.tan@intel.com
Cc:     akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        wangborong@cdjrlc.com, andreas.oetken@siemens.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nios2: use strscpy to replace strlcpy
Date:   Sat,  7 Aug 2021 15:24:31 +0800
Message-Id: <20210807072431.66478-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy should not be used because it doesn't limit the source
length. As linus says, it's a completely useless function if you
can't implicitly trust the source string - but that is almost always
why people think they should use it! All in all the BSD function
will lead some potential bugs.

But the strscpy doesn't require reading memory from the src string
beyond the specified "count" bytes, and since the return value is
easier to error-check than strlcpy()'s. In addition, the implementation
is robust to the string changing out from underneath it, unlike the
current strlcpy() implementation.

Thus, We prefer using strscpy instead of strlcpy.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/nios2/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index cf8d687a2644..02fe70b6d78e 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -121,7 +121,7 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 		dtb_passed = r6;
 
 		if (r7)
-			strlcpy(cmdline_passed, (char *)r7, COMMAND_LINE_SIZE);
+			strscpy(cmdline_passed, (char *)r7, COMMAND_LINE_SIZE);
 	}
 #endif
 
@@ -129,10 +129,10 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 
 #ifndef CONFIG_CMDLINE_FORCE
 	if (cmdline_passed[0])
-		strlcpy(boot_command_line, cmdline_passed, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, cmdline_passed, COMMAND_LINE_SIZE);
 #ifdef CONFIG_NIOS2_CMDLINE_IGNORE_DTB
 	else
-		strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif
 #endif
 
-- 
2.32.0



