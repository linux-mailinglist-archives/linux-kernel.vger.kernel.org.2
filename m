Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2AF38ACDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbhETLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241776AbhETLgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:36:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBB236139A;
        Thu, 20 May 2021 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510534;
        bh=+OylOm4Xj8hBbMUtVil2h9pLATRR6MkYlmUTGrTyvwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dd2G9td5G8U2vepQ8ECKHyqFX2sgaknt7JBZMpDznOWe2eHaYjRaUssw9mQBdcwOJ
         o1UyU/ws56UB0xma4x5fRaSAoVDPxVG00Ld0atahY+rNsdz0XcHpo45sEm1+o+cefj
         dnoBGEoBQKkHwEYtHxVeLFoWVDj0EzEx//xUn4EYhc588GJ30X/XPi5FmThhk0l7C7
         I+nbPW+OjNjn+kcz586nO9D4VW1YgsWQ4sfDj/dJ3l6oeUHX4HV9OdYbAqhd9xNe77
         BhXtjIy/nvojQPjQ9QYrNi3D5ymuCnjPI1xbWWKKUM7egx328CU3i2YeGrMCNKywJS
         w7MeVDJhjuhdA==
Received: by pali.im (Postfix)
        id ADE929D1; Thu, 20 May 2021 13:35:33 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 mvebu 4/4] firmware: turris-mox-rwtm: show message about HWRNG registration
Date:   Thu, 20 May 2021 13:35:20 +0200
Message-Id: <20210520113520.32240-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520113520.32240-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
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

