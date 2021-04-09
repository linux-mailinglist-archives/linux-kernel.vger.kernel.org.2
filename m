Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0477D35A950
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhDIXnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 19:43:47 -0400
Received: from m12-18.163.com ([220.181.12.18]:53313 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235096AbhDIXnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 19:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=itB/r
        /hBoTOXTc28lZNT+u1t0TPcb3x7r2ZTxlSn9lU=; b=YNFLt+ha5YXnN4t/LZlvh
        +97cNHgvlTepSHiXOEtJ4ErE+dMbvPvTlmYeJxjqu0EI3Odut4bZDnnlTQ3u7FWI
        Pl4u1gx5cMPIWV5oeO6rKStGH8GTxcYjOMzXmOAePLdP+DXaYL39i0ckO9AaSV+H
        hzUoSMWOiopSLyjz8tf4bo=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowABnbeWc5nBguXVqdA--.36829S2;
        Sat, 10 Apr 2021 07:43:25 +0800 (CST)
From:   angkery <angkery@163.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH v1] pata_ipx4xx_cf: Fix unsigned comparison with less than zero
Date:   Sat, 10 Apr 2021 07:42:42 +0800
Message-Id: <20210409234242.1979-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABnbeWc5nBguXVqdA--.36829S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZF1kGr4rAryUAFWruw13twb_yoW8JrW8pF
        47Cay8urWkXas0kw4kJr47ZF13J3Z5WrWIv3y3C3yavwn5Xr95JFySgFyjvF1qkrZ7Gr13
        try5tr4UWFsrZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bUvtZUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBRh1vI13l-NlhUwAAs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

The return from the call to platform_get_irq() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'irq', so making 'irq' an int, and change the position to
keep the code format.

Fixes coccicheck warnings:
./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
WARNING: Unsigned expression compared with zero: irq > 0

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
changes in v1:
update the commit information.

 drivers/ata/pata_ixp4xx_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index abc0e87..43215a4 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -135,12 +135,12 @@ static void ixp4xx_setup_port(struct ata_port *ap,
 
 static int ixp4xx_pata_probe(struct platform_device *pdev)
 {
-	unsigned int irq;
 	struct resource *cs0, *cs1;
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct ixp4xx_pata_data *data = dev_get_platdata(&pdev->dev);
 	int ret;
+	int irq;
 
 	cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
1.9.1


