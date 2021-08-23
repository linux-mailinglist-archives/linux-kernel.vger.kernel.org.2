Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50F03F495C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhHWLIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:08:22 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7996 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhHWLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:08:19 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee561238164ea9-04b8e; Mon, 23 Aug 2021 19:07:17 +0800 (CST)
X-RM-TRANSID: 2ee561238164ea9-04b8e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1612381613f8-c3e66;
        Mon, 23 Aug 2021 19:07:17 +0800 (CST)
X-RM-TRANSID: 2ee1612381613f8-c3e66
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] tty: serial: linflexuart: Remove redundant check to simplify the code
Date:   Mon, 23 Aug 2021 19:07:54 +0800
Message-Id: <20210823110754.11232-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function uart_add_one_port(), it can return zero or non-zero,
so remove redundant check to simplify the code.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index d87048073..283757264 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -861,11 +861,7 @@ static int linflex_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sport);
 
-	ret = uart_add_one_port(&linflex_reg, sport);
-	if (ret)
-		return ret;
-
-	return 0;
+	return uart_add_one_port(&linflex_reg, sport);
 }
 
 static int linflex_remove(struct platform_device *pdev)
-- 
2.20.1.windows.1



