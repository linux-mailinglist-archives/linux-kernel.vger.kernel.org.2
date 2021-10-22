Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611084373D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhJVIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:48:21 -0400
Received: from ssh248.corpemail.net ([210.51.61.248]:22353 "EHLO
        ssh248.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhJVIsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:48:20 -0400
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((LNX1044)) with ASMTP (SSL) id QKQ00054;
        Fri, 22 Oct 2021 16:45:54 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2308.14; Fri, 22 Oct 2021 16:44:48 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kai Song <songkai01@inspur.com>
Subject: [PATCH] hwmon: (xgene) fix return value in xgene_hwmon_probe()
Date:   Fri, 22 Oct 2021 16:44:46 +0800
Message-ID: <20211022084446.16728-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   202110221645544c835134fcdd29043a56be9d49a3d297
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It uses IS_ERR to judge the return value of mbox_request_channel()
and pcc_mbox_request_channel().If it is invalid, maybe we should
use PTR_ERR to get the correct return value.

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 drivers/hwmon/xgene-hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 382ef0395d8e..fd0847f251c0 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -648,7 +648,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 		if (IS_ERR(ctx->mbox_chan)) {
 			dev_err(&pdev->dev,
 				"SLIMpro mailbox channel request failed\n");
-			rc = -ENODEV;
+			rc = PTR_ERR(ctx->mbox_chan);
 			goto out_mbox_free;
 		}
 	} else {
@@ -675,7 +675,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 		if (IS_ERR(ctx->mbox_chan)) {
 			dev_err(&pdev->dev,
 				"PPC channel request failed\n");
-			rc = -ENODEV;
+			rc = PTR_ERR(ctx->mbox_chan);
 			goto out_mbox_free;
 		}
 
-- 
2.27.0

