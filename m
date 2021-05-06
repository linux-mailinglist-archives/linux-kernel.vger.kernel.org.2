Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5821C375142
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhEFJJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234003AbhEFJJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:09:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68F6861378;
        Thu,  6 May 2021 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620292108;
        bh=+OylOm4Xj8hBbMUtVil2h9pLATRR6MkYlmUTGrTyvwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSwtFYhbtp+nn8QhfWN1UuMceplu/ZIR5t0I4DQrzHlefkT/sHW68U/gBo+r/TceQ
         gYDl3BaOMu3yWm/TWqILzc6sMBEGXjyho4ek4PPPUSYxphsLO7J7PIfjVr/gmg5EDj
         wvB00Xh8vQHKuu4tjoGAGX2dA5Ur/dwIusYex2OW5jliXVh1LzGhZ3eH5u93sTYS60
         fBKdkGQXvU4n/UCOQvKo1qva1bMaT1d/BOzrxQsnzfJg9M+6WNzNozvp2raj7z2/HI
         OFr3V+dGJUqhqtuyJ08ngRPiySudMGEvJ2++YkP5f23J8RJTDu7zD54odtPB6hJlWc
         ftB1HF7mWVT4w==
Received: by pali.im (Postfix)
        id 27D88732; Thu,  6 May 2021 11:08:28 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 mvebu + mvebu/dt64 4/6] firmware: turris-mox-rwtm: show message about HWRNG registration
Date:   Thu,  6 May 2021 11:08:00 +0200
Message-Id: <20210506090802.14268-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506090802.14268-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210506090802.14268-1-pali@kernel.org>
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

