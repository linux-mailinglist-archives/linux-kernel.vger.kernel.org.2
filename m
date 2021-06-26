Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5313B8230
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhF3MfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234679AbhF3MfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:35:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F9A561607
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 12:32:38 +0000 (UTC)
Envelope-to: broonie@sirena.co.uk
Delivery-date: Sat, 26 Jun 2021 11:25:23 +0100
Received: from mail.kernel.org ([198.145.29.99])
        by cassiel.sirena.org.uk with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <SRS0=kbgQ=LU=cdjrlc.com=wjc@kernel.org>)
        id 1lx5V3-007oEx-0Z
        for broonie@sirena.co.uk; Sat, 26 Jun 2021 11:25:23 +0100
Received: by mail.kernel.org (Postfix)
        id 57A6F6192F; Sat, 26 Jun 2021 10:25:19 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 510F361926
        for <broonie@kernel.org>; Sat, 26 Jun 2021 10:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510F361926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cdjrlc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=wjc@cdjrlc.com
X-QQ-mid: bizesmtp37t1624703103tpmlyk5h
Received: from localhost.localdomain (unknown [182.148.13.245])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 26 Jun 2021 18:25:00 +0800 (CST)
X-QQ-SSF: 0100000000200060B000C00A0000000
X-QQ-FEAT: Uuh1NBTppyEyK2SURCp4CsrfBl2RcZ1GetA5kdx6TEwQjznuezS5eNfsGn8pN
        x5iI9nEj+bX/KICmTDYHaPk6Im8UVUq+77x7Lf6Z1F4BReqsqvRjva8PMUC7+Zi8F6/63oF
        obSqvxGaH6vNRi3Lf3x1VsvCPeskEtYlK+jrIffnBoTNInRCs4tCAMSXXrV8oS3gpQWsI6C
        YcdMbzdsJe4jhAAmL/Z/kzJaz9TUjmL2dSXyhd2wxLUCmu7P8aRh+coatrC5q40wgP4YJDw
        HgfjjIsmBWx+iBLOukudtAIw5foSelJr6DLrEBzasqwjZoV4UNgyoTiT3y8Z1+KsYmVyGXd
        uXkHlxbDTv5PCJ0+ro=
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, wjc@cdjrlc.com
Date:   Sat, 26 Jun 2021 18:24:54 +0800
Message-Id: <20210626102454.54931-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-SA-Exim-Connect-IP: 198.145.29.99
X-SA-Exim-Mail-From: SRS0=kbgQ=LU=cdjrlc.com=wjc@kernel.org
Subject: [PATCH] regulator: Replace symbolic permissions with octal permissions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); Unknown failure
X-TUID: zFq4QFtMDGGG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve following checkpatch issue,
Replace symbolic permissions with octal permissions

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
 drivers/regulator/dbx500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index 8b70bfe88019..a45c1e1ac7ef 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -117,11 +117,11 @@ ux500_regulator_debug_init(struct platform_device *pdev,
 	rdebug.dir = debugfs_create_dir("ux500-regulator", NULL);
 
 	/* create "status" file */
-	debugfs_create_file("status", S_IRUGO, rdebug.dir, &pdev->dev,
+	debugfs_create_file("status", 0444, rdebug.dir, &pdev->dev,
 			    &ux500_regulator_status_fops);
 
 	/* create "power-state-count" file */
-	debugfs_create_file("power-state-count", S_IRUGO, rdebug.dir,
+	debugfs_create_file("power-state-count", 0444, rdebug.dir,
 			    &pdev->dev, &ux500_regulator_power_state_cnt_fops);
 
 	rdebug.regulator_array = regulator_info;
-- 
2.31.1



