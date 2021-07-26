Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78C3D59C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhGZMIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:08:18 -0400
Received: from smtpbg127.qq.com ([109.244.180.96]:24119 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234049AbhGZMIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:08:17 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 08:08:16 EDT
X-QQ-mid: bizesmtp43t1627303183t6lqoppg
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 26 Jul 2021 20:39:41 +0800 (CST)
X-QQ-SSF: 0100000000200090B000B00A0000000
X-QQ-FEAT: qYS6qym2pYeA45yuN4nf/+aDG2t5kxly0vXseIOnyJAdhOXtqqrlYVX0DqAXj
        HjsMS/+Yju9KyMHlnENhRw9iHmHr23npeWov34zQGeviijgSkN78afe/mzNqikKWtMfUo+C
        B81FNupkGjVcRtk+/23gUkNoDSsbyhFOPH2uj01fzuaGxOrdTfqj3uOPQbXGGsAqKghnDXL
        1nwhbLmUFnsoKB365S7MFEqc+XZEdUtM3ju5b7JGVziEXrdWhnxaFTVuwSowtZ+43umxHBD
        kMJnRANN+UNt8+bkj/4QvHhJFUWiVggD3+ARqugnfgbIwXn5K2K36l/iSvzPScMmVIY+/zh
        tht4bbGz9kGuwdXLzsdsmYAV52o9w==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, amit.kachhap@arm.com, dbrazdil@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] arm64: unnecessary end 'return;' in void functions
Date:   Mon, 26 Jul 2021 20:39:40 +0800
Message-Id: <20210726123940.63232-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The end 'return;' in a void function is useless and verbose. It can
be removed safely.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm64/kernel/cpufeature.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0ead8bfedf20..23c3456f0aa2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1561,8 +1561,6 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 
 	if (!cpu)
 		arm64_use_ng_mappings = true;
-
-	return;
 }
 #else
 static void
-- 
2.32.0

