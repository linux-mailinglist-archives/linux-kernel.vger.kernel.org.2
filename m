Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A43D597F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhGZLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:49:17 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:37830 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233859AbhGZLtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:49:16 -0400
X-QQ-mid: bizesmtp32t1627302550tjpsdmuf
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 26 Jul 2021 20:29:08 +0800 (CST)
X-QQ-SSF: 0100000000200090B000000A0000000
X-QQ-FEAT: TU3YmX8YeZlr3Nmz/xxSsEKHOejKyWDkJFJmwM5Trfiyymw1SMHScRFOXMKBQ
        Gfq1R7I14kJO8I7iPovmgcIVlIfLldZC+CuAk+JP67xMHmGpALRjKzcarJg46WYwfQQnjmG
        qLsxUeYM+t4J4akxpuvPfHcAOvibueH6yXui+ECC5BmBSTQ6OxWdDDQpWwaL/p319rjt2er
        u0oBzWuTqrRNp/+LLeLF5wV7tNiD6x40m1Hnb/jjxamM0D1YD+v+eGaTAQjQXmz/FdnDrUI
        4vEe2Y4jIUQbLe3UFOJKeNVYPrUl6OqFUuPWLCVpy5drSfQlbOku3R63i39fqVzLOrdzBDW
        7ple6fK4vFveBjKE98HH7G0IddlHg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, jthierry@redhat.com, amit.kachhap@arm.com,
        dave.martin@arm.com, mark.rutland@arm.com, tabba@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] arm64: use __func__ to get function name in pr_err
Date:   Mon, 26 Jul 2021 20:29:07 +0800
Message-Id: <20210726122907.51529-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer using '"%s...", __func__' to get current function's name in
a debug message.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm64/lib/insn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index b506a4b1e38c..fccfe363e567 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -185,7 +185,7 @@ u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn)
 		break;
 	default:
 		if (aarch64_get_imm_shift_mask(type, &mask, &shift) < 0) {
-			pr_err("aarch64_insn_decode_immediate: unknown immediate encoding %d\n",
+			pr_err("%s: unknown immediate encoding %d\n", __func__,
 			       type);
 			return 0;
 		}
@@ -215,7 +215,7 @@ u32 __kprobes aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 		break;
 	default:
 		if (aarch64_get_imm_shift_mask(type, &mask, &shift) < 0) {
-			pr_err("aarch64_insn_encode_immediate: unknown immediate encoding %d\n",
+			pr_err("%s: unknown immediate encoding %d\n", __func__,
 			       type);
 			return AARCH64_BREAK_FAULT;
 		}
-- 
2.32.0

