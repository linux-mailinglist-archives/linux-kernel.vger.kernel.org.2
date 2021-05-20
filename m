Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB0438ACE7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbhETLvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242611AbhETLkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:40:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AFE86105A;
        Thu, 20 May 2021 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510733;
        bh=HVYynEyNs7+lz4BTSOmzDBvk2qTTG1wa3FCY3BfOY5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrYVXIUANk9TSn5qY4SywPbJ/oPgWQva4NNAqsRGWWgBHQQ6OPoI8mOThShFe7mJm
         VwaLMNk7eCLm0Xs44xQu20ag+8H6TtB+72lNKypiYWvEjAnWHy2SnwbdvjN+RbUFWY
         2EIKtNVB36SvTq24+uEGnallCZk3CoHSTF9Zci2ryHmxQtCdm7UVF85HcFus7SmVp9
         bdhAkJYOd3SbviLSc9jiDf2ZUYDX7RuORL0JOakmrZkWKfqUEkVy4uZ5+TQ5ntInzt
         v4yi7EItXQzKMSAFhavc0ah3sbAx269t8SrS7/f8a2u0QEbYstrlvC1B9/1B0BZIim
         D3rP2GP6exI+Q==
Received: by pali.im (Postfix)
        id 74AF49D7; Thu, 20 May 2021 13:38:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 mvebu + mvebu/dt64 1/2] firmware: turris-mox-rwtm: add marvell,armada-3700-rwtm-firmware compatible string
Date:   Thu, 20 May 2021 13:38:43 +0200
Message-Id: <20210520113844.32319-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520113844.32319-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113844.32319-1-pali@kernel.org>
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

