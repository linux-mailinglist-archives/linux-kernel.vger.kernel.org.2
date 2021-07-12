Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5130D3C5E94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhGLOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:55:06 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:38514
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230363AbhGLOzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:55:03 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7F50840333;
        Mon, 12 Jul 2021 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626101534;
        bh=6mChaTRrRo5NJxfSodjvtDgtiVHur+FmvKowXRGTUv4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=quluxzmNdNi2uCeQui6xbaakshfBlhRPDysfwhQycHbV0OoIJ4uDbIpki35krlu7A
         d0BvpjZfmzLldwOpelIqfdRFKUCRAyL7h7cmIsOemNS/jAfH3etyolNSXPpZK30PRq
         mY3t48FtzMNufTeF64IRcbhRZ97j7DeyXDVqqZIVo2Y2Abnk9FZXjg74rsYzcJKZxJ
         PzdrQo7uBXkE8dsY3TcLet0UWXNtNNh1d/keAZnlbtQm62xjv4I51mzVOYHBk5zXiH
         WFcfPzOsjRO10aAekG/M//H4qT9/BrQsbDjx7OyWaZWW2T9tHAW/GxrjC3WpIVyAMI
         DS2J0jB/u8p/Q==
From:   Colin King <colin.king@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Schocher <hs@denx.de>, linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: devices: mchp48l640: Fix memory leak on cmd
Date:   Mon, 12 Jul 2021 15:52:14 +0100
Message-Id: <20210712145214.101377-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The allocation for cmd is not being kfree'd on the return leading to
a memory leak. Fix this by kfree'ing it.

Addresses-Coverity: ("Resource leak")
Fixes: 88d125026753 ("mtd: devices: add support for microchip 48l640 EERAM")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/devices/mchp48l640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/mchp48l640.c b/drivers/mtd/devices/mchp48l640.c
index efc2003bd13a..c0b1a7bb7d13 100644
--- a/drivers/mtd/devices/mchp48l640.c
+++ b/drivers/mtd/devices/mchp48l640.c
@@ -255,6 +255,7 @@ static int mchp48l640_read_page(struct mtd_info *mtd, loff_t from, size_t len,
 	if (!ret)
 		*retlen += len;
 
+	kfree(cmd);
 	return ret;
 
 fail:
-- 
2.31.1

