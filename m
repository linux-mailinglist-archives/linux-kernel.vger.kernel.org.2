Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA3F35A06A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhDIN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:56:57 -0400
Received: from m12-18.163.com ([220.181.12.18]:46761 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232876AbhDIN4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+M0Bg
        BEtgZBZO5v1vtqHmK6TZp2f48jMgCf3npMwpHo=; b=juc30GKKldmu3e6CQsgHW
        O5B7PMjlIGR4W1FNxGywRzdfkGSDjCdPK++R6UdKBy6YjHnyhz/yoAzwUSYmSnwl
        i14ZLAT7gqjtrHjSgLksIoH8nIVLBGeLE3PY06TB2+70twHdFOcxvJlls/TEAQOX
        m8FuQCXNtfYULd3efjUZwU=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowAB3efcKXXBg8kMqdA--.8850S2;
        Fri, 09 Apr 2021 21:56:28 +0800 (CST)
From:   angkery <angkery@163.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] pata_ipx4xx_cf: Fix unsigned comparison with less than zero
Date:   Fri,  9 Apr 2021 21:54:26 +0800
Message-Id: <20210409135426.1773-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAB3efcKXXBg8kMqdA--.8850S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1kGr4rAryUAFWruw45Jrb_yoWkZwb_CF
        yI9r1xWw4Yv3s7Kw4UGFnxAFyjyrWfWFsIgFyIgF9xt3y5Xw4UAFZ5ZrnxA3s7Ww48JFyD
        XryDGr4fC3W5CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5mYLDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiKwxvI1QHXCSP9wABs5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

The return from the call to platform_get_irq() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'irq', so making 'irq' an int, and change the position to
keep the code format.

./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
WARNING: Unsigned expression compared with zero: irq > 0

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
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


