Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E683CE803
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355359AbhGSQgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 12:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348067AbhGSPYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:24:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC63861408;
        Mon, 19 Jul 2021 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626710473;
        bh=tZxCDtutOCGv0LQUUftzR3sRL4VvazvHKluusFcmX40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5qMG0tn/ZOVBKk+OWhZ+vbC8NW/tKVXRQbzxCS5gSXSv56oOGENrMMqN2hWemCFP
         QgLeibKAPoAmgJNR0CT/p0GkxAADIKqTsvnotZIV8c7aAAQp8Co5sT16m1BuE80sbM
         DpwAiDny6Zi/Y4k580pMPjVE7tpdrGJk5Ep8fPWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 232/243] firmware: turris-mox-rwtm: show message about HWRNG registration
Date:   Mon, 19 Jul 2021 16:54:21 +0200
Message-Id: <20210719144948.415008690@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144940.904087935@linuxfoundation.org>
References: <20210719144940.904087935@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

[ Upstream commit fae20160992269431507708fb74c1fd9f3c309c1 ]

Currently it is hard to determinate if on Armada 3720 device is HWRNG
by running kernel accessible or not. So print information message into
dmesg when HWRNG is available and registration was successful.

Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/turris-mox-rwtm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 2b56dd05961f..03f1eac9ad69 100644
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
2.30.2



