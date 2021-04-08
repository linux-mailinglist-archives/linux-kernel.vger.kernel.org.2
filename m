Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D12358BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhDHRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:55:25 -0400
Received: from mail-dm6nam08on2066.outbound.protection.outlook.com ([40.107.102.66]:4096
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232617AbhDHRzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTL1eZ/PAA0zI7hF5NDjkUElSCQMtmxo0JcHCVUy6fygDgZigOU/XZrdQA0i8MLyIgZBvNk+/sgpKAR6DUKrm2aOKyBwkw7y+Uj85xw0Rx0zZS1ebpsKwAhr8CVVW0HXkCzri+YNnmjj9UvhhanbYywZXUMTnVwFeZK1O21WLjyVAqYg7QEdKCzgE2+X7RLsorWvC3pyoRIGCh8Y9Wo47GDUZSn32fbngNzKlHZT/5qhyGhfbfP9TBR8Xo/p2ylYOFnB9u10Iu9y3EMdCjpECh8IN7PAdUxYNgJeXD8tLM3T2Wg/p3R/YMdhUBCW5OJf9g30MhLSS8OgUjEz0ZzAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5BQWPUZ7GBSzUV1wg/QTKwT4E5dhO4twiw5+yNB2RA=;
 b=MnQ8ks8iE1FE0iSfbSOxbJe8zRA8snl7gNcUFirYBgzdJF2XWsFKrgfo7tOnuyrUo4IxF2AqNcKVWuBeHAHrqRTOWtAqftSBQakfhXyxpzXDshOLKK+K3Rl9VqN7zTrmBl/e1+RGF3vueHTsVQLyVNj00ey9yKyXk8IxospDvahoFmAtkqrecwUXeWPHfTy6rGPaeK+eJ7CAqIp2R9NSLDd89xdnA3rnL2nDiD2zrvAQT4tq2EiSF/1HTJ7kQuayn2lWbCPm0ObzpZEO8/dldP7mACC1jLjoe54NSgXny2/HcGgAu28bf5W7SX0RFjLkfi1Z0beLTSG2w6QRWVCwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5BQWPUZ7GBSzUV1wg/QTKwT4E5dhO4twiw5+yNB2RA=;
 b=jOxpl9Eos0J1eeFre9fa7f75fHSki360sW6Q7CGApXOYzbTEfDj8peXbKq201+paNR20IwnEelNdqxq4qfIJr2rFOHPfawRav8Krf1/LIWzR6lkHxCAsJ0FfVZJsN82JKmKcEIqXNAv3kOT0pWMVW6koZRLdRb6O0gr3igrEdZo=
Received: from SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43) by
 CH2PR02MB6837.namprd02.prod.outlook.com (2603:10b6:610:ae::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Thu, 8 Apr 2021 17:55:09 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::17) by SN2PR01CA0033.outlook.office365.com
 (2603:10b6:804:2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 17:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 17:55:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 10:54:47 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 8 Apr 2021 10:54:47 -0700
Envelope-to: git@xilinx.com,
 balbi@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=38719 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lUYre-0002jP-65; Thu, 08 Apr 2021 10:54:46 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 5426912155A; Thu,  8 Apr 2021 23:24:23 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@xilinx.com>,
        <balbi@kernel.org>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 2/2] usb: dwc3: xilinx: Remove the extra freeing of clocks
Date:   Thu, 8 Apr 2021 23:24:08 +0530
Message-ID: <1617904448-74611-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617904448-74611-1-git-send-email-manish.narani@xilinx.com>
References: <1617904448-74611-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844a859d-9b1e-418f-def8-08d8fab7736d
X-MS-TrafficTypeDiagnostic: CH2PR02MB6837:
X-Microsoft-Antispam-PRVS: <CH2PR02MB68371508483DAF21B4930500C1749@CH2PR02MB6837.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irTnSky9qVGQ1ioXYLkKr39KCpdMXYBf/sye9aH/+V2V53FvC6fkHFlI1T0jEfJFo8xvZN82WzROQIo6qGccAQF3rwYfsxxF5VAlQGiyTiAemVqotzXlGgk/POCqFVMpYxNKEJrzldCc8zoGwXDX8OkNc8EdyTOrbftqQrp/qN9xldcbK24OdiussUaBeReuQGebbqgVi3AsJouNGWw/8bDyULorjBfzxZRtVeSU/mhQLPlP6SxVMgTxcd6KGKd3iqWcPYDkYQtmaRa5qdLvQEYOW9rtjGa+GC7InxyGJxtZtwrgfCWEWmHuUAkdZEB7YdMhguMrCWHACD0WcFTmViro4wT1+Mt58pzpuSQ3ZrJvmfRYX7NImcWeCVS5peqWauG4dEKkaTdOxhfnnfLojvFSr3rQxz2TMGbphs1/KmMds1jdhNWEx4d8S8iMH9KyVwMz3e8IrERbchSXMc4CJQwUGxk3B5vw7EoxxXvrI2h3iISEsWBPPy2ozlseOFZdqNLOH0JIqrlh4RNhyC5zG5d22g18DJWI9/16v0slfxvS71vD28BnSIK2wOdPjIyxsykUpogTKXPas/fjFfHjbqkiISNrEAFuF9Aht8x8dgrS+f/rJlflL8cX34D55IOK+X+Qgtgy45Pnb1WGlaWN/ff0ylktym+h7fgNJuUL4BLXFJxcJnWzZuuQorvro9a7
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(8676002)(36860700001)(83380400001)(70206006)(70586007)(2906002)(6666004)(107886003)(6266002)(36906005)(47076005)(26005)(54906003)(2616005)(426003)(4326008)(82310400003)(316002)(44832011)(36756003)(42186006)(356005)(110136005)(8936002)(478600001)(82740400003)(7636003)(5660300002)(336012)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 17:55:09.4665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844a859d-9b1e-418f-def8-08d8fab7736d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks are configured by devm_clk_bulk_get_all() in this driver. In
case of any error the clocks freeing will be handled automatically.
There is no need to explicitly free the clocks. Fix the same.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index f42f4cb..9cc3ad7 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -271,7 +271,6 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 
 err_clk_put:
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
-	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
 
 	return ret;
 }
@@ -284,7 +283,6 @@ static int dwc3_xlnx_remove(struct platform_device *pdev)
 	of_platform_depopulate(dev);
 
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
-	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
 	priv_data->num_clocks = 0;
 
 	pm_runtime_disable(dev);
-- 
2.1.1

