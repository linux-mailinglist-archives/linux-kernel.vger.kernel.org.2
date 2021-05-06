Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197A0375144
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhEFJJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234028AbhEFJJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:09:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D5FB613BA;
        Thu,  6 May 2021 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620292109;
        bh=J5vHzzxX2VNER+zka6PEWkClrD68ro+cEjhzakb7mic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jl68ZHPzHp69/VBzzo+viUX2tfWeKoenhWdHPbM0lMCb1vd4LaNv50fHjAqNdVPEt
         7YY15+ZbvaDV8nQFlWszQI0EMbBDHW/DnudHAY9aVuwWOrlv8RN1xGgLiSW1a9z3Wc
         ItdWI7HbY7f2hBbMafTj04865PbcSPMVSPi/BJQdzW3+z2H3imIC9MuRZ4bXS/d9Xk
         jjaKXLS3sLrUOrQvTRfQKJgOK7cI0i7Otv825Syi4Wsdom6HvEDCt3uVDwb8eJHS8o
         37BP28rtIuPWy3uh/9Q96V6Uz6BK8bcXC07GJcUiMx/O10LYDDKBjcSV7cUtuxq85t
         0DseSDrPs2jYw==
Received: by pali.im (Postfix)
        id 3BE76732; Thu,  6 May 2021 11:08:29 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 mvebu + mvebu/dt64 5/6] firmware: turris-mox-rwtm: add marvell,armada-3700-rwtm-firmware compatible string
Date:   Thu,  6 May 2021 11:08:01 +0200
Message-Id: <20210506090802.14268-5-pali@kernel.org>
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

Add more generic compatible string 'marvell,armada-3700-rwtm-firmware' for
this driver, since it can also be used on other Armada 3720 devices.

Current compatible string 'cznic,turris-mox-rwtm' is kept for backward
compatibility.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")

---
We are also planning to work on extending this driver to support
accessing OTP, which will also work with Marvell's default WTMI
firmware.
---
 drivers/firmware/turris-mox-rwtm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 1cf4f1087492..c2d34dc8ba46 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -569,6 +569,7 @@ static int turris_mox_rwtm_remove(struct platform_device *pdev)
 
 static const struct of_device_id turris_mox_rwtm_match[] = {
 	{ .compatible = "cznic,turris-mox-rwtm", },
+	{ .compatible = "marvell,armada-3700-rwtm-firmware", },
 	{ },
 };
 
-- 
2.20.1

