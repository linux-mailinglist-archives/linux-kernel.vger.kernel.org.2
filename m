Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086B932F6C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCEXqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:46:17 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33397 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCEXqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:46:05 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6C2BD22172;
        Sat,  6 Mar 2021 00:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614987964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eN73zw785LDN9Maeb4EKVdz3vl/qy3K7dluHlBvPFMk=;
        b=C21hvFv5AvHFAKzlLETGUAPy+zSKh7Gbr9wZeOEcMLzMI0wxnGDaurc3hoPxM5dvbsryi/
        pR9HFxa9aBByDCZBvCIUMWvR+plslxrddbYSMwpBQ4Fypwd2QSlRwU3XapccSQWxyNWX9E
        KY2TaCucxZXx0wP+pTp0CxN6rsXhNvU=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mtd: spi-nor: use is_power_of_2()
Date:   Sat,  6 Mar 2021 00:45:52 +0100
Message-Id: <20210305234552.19204-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a function to check if an integer is a power of 2. Use
it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0522304f52fa..4a315cb1c4db 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2336,11 +2336,8 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		 * If page_size is a power of two, the offset can be quickly
 		 * calculated with an AND operation. On the other cases we
 		 * need to do a modulus operation (more expensive).
-		 * Power of two numbers have only one bit set and we can use
-		 * the instruction hweight32 to detect if we need to do a
-		 * modulus (do_div()) or not.
 		 */
-		if (hweight32(nor->page_size) == 1) {
+		if (is_power_of_2(nor->page_size)) {
 			page_offset = addr & (nor->page_size - 1);
 		} else {
 			uint64_t aux = addr;
-- 
2.20.1

