Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B03B768C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhF2Qi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:38:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44425 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhF2Qi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:38:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lyGim-00008b-SB; Tue, 29 Jun 2021 16:36:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Fix while-loop that iterates only once
Date:   Tue, 29 Jun 2021 17:36:24 +0100
Message-Id: <20210629163624.41543-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The while-loop only iterates once becase the post increment test of count
being non-zero is false on the first iteration because count is zero. Fix
this by incrementing count using pre-increment. Static analysis found the
issue on the count > POLLING_LLT_THRESHOLD check always being false since
the loop currently just iterates once.

Addresses-Coverity: ("Logically dead code")
Fixes: 615a4d12e556 ("staging: r8188eu: Add files for new driver - part 14")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index d1086699f952..db57f04e7e56 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -185,7 +185,7 @@ static s32 _LLTWrite(struct adapter *padapter, u32 address, u32 data)
 			break;
 		}
 		udelay(5);
-	} while (count++);
+	} while (++count);
 
 	return status;
 }
-- 
2.31.1

