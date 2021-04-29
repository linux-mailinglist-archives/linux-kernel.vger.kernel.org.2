Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A987136E723
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbhD2Ihk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239901AbhD2Ihh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:37:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C084261186;
        Thu, 29 Apr 2021 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619685410;
        bh=+OylOm4Xj8hBbMUtVil2h9pLATRR6MkYlmUTGrTyvwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNhuNvCOvWoT5QiNHqzkYjm4/oZfCG9xk1G8IbaSStbr0eaedpPsbdCOdspR/6hjW
         rJ664iDKPkaiLOy+d7Uxu/rKH5XOj4Hs6W/FMJR8XknFuAzTsmzW4q+UtIdv3uuP5e
         JYrfjDUtHQLYYUswY2BvUtLpW65G6r+H8X2OxTmzaBsyw7VaGNh3/Q1WY8BzKVNUTy
         scz3TXBpWQSjHPlawqd6od+MKB9qzK7BsxSc7uwnbl570ITBlbLtAj+d1oTwHEygnl
         kuOsRf5WlCMg2PXmsmVaOD5DZftBbkkaEBoTvE74ac3NsA/C1BihITZliIjEAr2jM3
         gu1bx+d8AsHEQ==
Received: by pali.im (Postfix)
        id 79FB37DF; Thu, 29 Apr 2021 10:36:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 mvebu + mvebu/dt64 4/6] firmware: turris-mox-rwtm: show message about HWRNG registration
Date:   Thu, 29 Apr 2021 10:36:34 +0200
Message-Id: <20210429083636.22560-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429083636.22560-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210429083636.22560-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it is hard to determinate if on Armada 3720 device is HWRNG
by running kernel accessible or not. So print information message into
dmesg when HWRNG is available and registration was successful.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
---
 drivers/firmware/turris-mox-rwtm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 3ef9687dddca..1cf4f1087492 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -542,6 +542,8 @@ static int turris_mox_rwtm_probe(struct platform_device *pdev)
 		goto free_channel;
 	}
 
+	dev_info(dev, "HWRNG successfully registered\n");
+
 	return 0;
 
 free_channel:
-- 
2.20.1

