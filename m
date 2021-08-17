Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE953EEBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhHQLdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:33:54 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:41494 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231515AbhHQLdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:33:53 -0400
X-QQ-mid: bizesmtp37t1629199896tohp35h0
Received: from localhost.localdomain (unknown [125.69.42.50])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 17 Aug 2021 19:31:35 +0800 (CST)
X-QQ-SSF: 01000000004000B0C000B00A0000000
X-QQ-FEAT: VM477jCxEMjpxWcg2ZXubi3ZjfaeY+wqXWbCqmU0fFD9YsyNh+Fn+61qUcUih
        rDjcZBwRNFXAWu/kZOb2kpIlILsTUPWJwK9PJ/94s0aq3RbLrLE3aWG578pcm30Jchp2ngj
        sR0e9Yz720wDi7WW8YF4vjf/uAflh/1LoQyMW1SJQggMiawcOh5AkR/hVcdvI5xLfLEEY3M
        ECScfFImrYEYrU1LN5+stUZRrFogdDWNeb0iY2026CezFc6zPKuP21Ps/WuR8GoIFIFSkS+
        jPCjytUyrMpxMUn/QWObeABBxI7kIr64EpM0+OS+oNPmU/tGbkC3c1uNeRSkrxQo5CioXU2
        FpbRF8vpeMSxFaPTZA=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     nsekhar@ti.com
Cc:     bgolaszewski@baylibre.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ARM: davinci: dm355-evm: Fix typo in a comment
Date:   Tue, 17 Aug 2021 19:31:12 +0800
Message-Id: <20210817113112.17936-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in the comment `Keep the the order same as that of
encoders.' is repeated. Consequently, one 'the' should be removed
from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 3c5a9e3c128a..4aeda9bd8029 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -296,7 +296,7 @@ static struct vpbe_enc_mode_info dm355evm_enc_preset_timing[] = {
 
 /*
  * The outputs available from VPBE + ecnoders. Keep the
- * the order same as that of encoders. First those from venc followed by that
+ * order same as that of encoders. First those from venc followed by that
  * from encoders. Index in the output refers to index on a particular encoder.
  * Driver uses this index to pass it to encoder when it supports more than
  * one output. Application uses index of the array to set an output.
-- 
2.32.0

