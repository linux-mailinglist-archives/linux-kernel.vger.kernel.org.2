Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E211E33971A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhCLTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhCLTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:06:06 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:06:06 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C0EFD2224E;
        Fri, 12 Mar 2021 20:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615575964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bcjeaOvsIJqEoG91kpU1zOMrmJbEeoZZ6ee1XBJrTMY=;
        b=JD23R/rpOboZgZkxgVqCjnNqj1tGEG3NOZuTVEW+KhmN3KHYc6/ugNrOh7sB2GNwzp0+p1
        hQh2Bokb1YOYZTS9FgRcW1oiZu3UxOXAdWnrkaTTUjPM0xmFdgnkXGuJkKZGGeAwyClrkN
        IMSOxA44zW5FjcGJa4QY4B5PqFmVn38=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 2/3] mtd: spi-nor: sfdp: fix spi_nor_read_sfdp()
Date:   Fri, 12 Mar 2021 20:05:47 +0100
Message-Id: <20210312190548.6954-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312190548.6954-1-michael@walle.cc>
References: <20210312190548.6954-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If spi_nor_read_sfdp() is used after probe, we have to set read_proto
and the read dirmap.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index b1814afefc33..47634ec9b899 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -179,19 +179,27 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
 			     size_t len, void *buf)
 {
 	u8 addr_width, read_opcode, read_dummy;
+	struct spi_mem_dirmap_desc *rdesc;
+	enum spi_nor_protocol read_proto;
 	int ret;
 
 	read_opcode = nor->read_opcode;
+	read_proto = nor->read_proto;
+	rdesc = nor->dirmap.rdesc;
 	addr_width = nor->addr_width;
 	read_dummy = nor->read_dummy;
 
 	nor->read_opcode = SPINOR_OP_RDSFDP;
+	nor->read_proto = SNOR_PROTO_1_1_1;
+	nor->dirmap.rdesc = NULL;
 	nor->addr_width = 3;
 	nor->read_dummy = 8;
 
 	ret = spi_nor_read_raw(nor, addr, len, buf);
 
 	nor->read_opcode = read_opcode;
+	nor->read_proto = read_proto;
+	nor->dirmap.rdesc = rdesc;
 	nor->addr_width = addr_width;
 	nor->read_dummy = read_dummy;
 
-- 
2.20.1

