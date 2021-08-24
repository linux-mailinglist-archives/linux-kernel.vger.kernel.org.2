Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B03F663E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhHXRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:21:43 -0400
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com ([40.107.244.57]:18657
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233045AbhHXRSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:18:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIf71Bw0LueNY3hYBLGVxix0YF1c+9vHUHk6DPvEvRPz1zyY1jgSj7n1lsExHf6SHpdsvoxh43m/oWMKhl3UqZyHFT94PxD0WpK6KVizrkzOM7KFVN6qTDOU3oAc5zf8jMBCrLzJxSNGiQ16uTReGFRppXGk9adSJDOpYHybyFhtGao70HdO/zIHkrNlyHXfZ+HhFQls0T8MSrpaNP7NCa+9YaGxK6OkG4Zt+m7514nsS81ObObhCltOMAxRNNooylrYrn3A5sfeDIn4DmdCv9DAkYT9oeX0Yo38Jz4yi7lEWGGNNNUs5YZCCoOhH2bMKzloEmGkJUbSfr95IjHoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPe9yQ1qhJzQqArksSp1RSTlaT0uzYtV2w49DQfVp3g=;
 b=ReNGT4ryqX0qv0NsTv+o44EnuyrQ/6WcjRvGe7pXQ51k8cdFMo5R83YlP4d1e+WRjK7BPGL4pGv7JopFV8dZLoApiiaIun5nMLP8Et2VCuUeiWESIrf0mEMfPluzhuDcHBi/y3sTYwnbp1CmM7KJuiNGAdjOibGslJWRMFsJ0I339PETc8XWroqjEpRslg85A/GVcy5CU4qy4ODmgzZo0+B97NWhvTioPmIKbhkYundPowHBC+7gsZz5bAW+Z1GuQ43wSvPCwmmchzz1UMm6Gs5vZLtQfK6k5+WQ4ysh7nkv7dBLtje6EBIhE7M0DhAScnNZ2WFvW0d4Nq63sCQt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPe9yQ1qhJzQqArksSp1RSTlaT0uzYtV2w49DQfVp3g=;
 b=FUM4UqcFE+xFUivObWbiFQTBpvSRSR1yGC7ew1XFzS8XTFsgTf6NuRiKWVy2ZTRxZAGkXk8Wi8FrxHBzBRyi0oJDVWE3iQe3k1rFYtD2DQ9xUEm8Nu3tdeZHpOw4yxh0zA6/7lAgIzggjxxnbvRumM0WGGHNs0C1FEelg/aJiHE=
Received: from DM5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:3:d4::30) by
 CY4PR02MB3208.namprd02.prod.outlook.com (2603:10b6:910:7d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.19; Tue, 24 Aug 2021 17:17:29 +0000
Received: from DM3NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::fc) by DM5PR05CA0020.outlook.office365.com
 (2603:10b6:3:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend
 Transport; Tue, 24 Aug 2021 17:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT045.mail.protection.outlook.com (10.13.4.189) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 17:17:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 10:17:19 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 10:17:19 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=48483 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1mIa34-00008Y-DA; Tue, 24 Aug 2021 10:17:18 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id B4F916053F; Tue, 24 Aug 2021 22:46:36 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 4/6] usb: chipidea: Fix return value handling
Date:   Tue, 24 Aug 2021 22:46:16 +0530
Message-ID: <1629825378-8089-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a9266e2-e869-4bfd-0ab0-08d967230d06
X-MS-TrafficTypeDiagnostic: CY4PR02MB3208:
X-Microsoft-Antispam-PRVS: <CY4PR02MB3208DED55646C54FD354CCA2C1C59@CY4PR02MB3208.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUMbi+EWJEAR644EBYkNOEQdjjrixPMzOgGptm29QDKEwVroZXzbwaY5djPUxIK20qxbU30EhpoXFphVvajJ/Vnw7Nr5qSDg1PljM6lW6v1Y46g6Mu4lAdUWiyAE/4XkdzbuILGF3Ha0fxkYwm1eQUUYcaSa8NM+Bcie/G96mFJTCnB2TTd1MOOnk80O5VUJzgtYCt3iPIHNZlGsGvdu6VN9kTxH7fGxVt1mHlbgaSrKH7h0yUVJ8ZIe6dMvwytBCh/jwke9HF/+YkxfWSrqMafHN6Hvdgrw0I8s5WR/oZYN0BtNH0sQlSbZf/EaUYg7a1/naLNOnXKpawQSSpxh82AT1q+iYwwp4hHtYi9XfnVuLf29KX6lMP5uKecpoUQqQefPqA2TtaBZ8+5TuwlTL7EGtJfn6jtwISCN0UaiKJIF56S2WLb35H5IyIdUE4fz6DP793YVV+sFzlVthRZtJpMIfIMNylBAbE7r6xAHW6nmL3DrZIyLLo9JgRfCMa767U8nNh5KZz8LP/yfuKKWV+4wKKY63WTup29+BacafZ5kuazQyHBzyOTCL2SRdlaGF9iYgqmmmbWj5STPhsvv2maRTe1igLmXpV+agpoXUvvMxb509pdypEt4iHgAKvU7+D0ucmEi3Oc5K8J54oBmCHHDp1Xq5mjvbh53Coq0+EPiDnrkT6cctLnr0sn0y9j968xPa7n0yoIkO6cZ7dQPDzZXV7Zze9/OzRxLshxvBKo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(356005)(4326008)(26005)(36756003)(82310400003)(83380400001)(36906005)(110136005)(70586007)(47076005)(44832011)(107886003)(54906003)(2616005)(6266002)(426003)(8676002)(316002)(82740400003)(6666004)(42186006)(70206006)(7636003)(8936002)(5660300002)(6636002)(478600001)(2906002)(336012)(36860700001)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:17:28.8742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9266e2-e869-4bfd-0ab0-08d967230d06
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

API was neither captured nor checked.Fixed it by capturing the
return value and then checking for any error.

Addresses-Coverity: "Calling without checking return"
Addresses-Coverity: "CHECKED_RETURN"
Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/chipidea/core.c | 11 +++++++----
 drivers/usb/chipidea/otg.c  |  6 +++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 2b18f50..676346f 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -700,13 +700,16 @@ static int ci_get_platdata(struct device *dev,
 	if (usb_get_maximum_speed(dev) == USB_SPEED_FULL)
 		platdata->flags |= CI_HDRC_FORCE_FULLSPEED;
 
-	of_property_read_u32(dev->of_node, "phy-clkgate-delay-us",
-				     &platdata->phy_clkgate_delay_us);
+	if (of_property_read_u32(dev->of_node, "phy-clkgate-delay-us",
+				 &platdata->phy_clkgate_delay_us))
+		dev_dbg(dev, "Missing phy-clkgate-delay-us property\n");
 
 	platdata->itc_setting = 1;
 
-	of_property_read_u32(dev->of_node, "itc-setting",
-					&platdata->itc_setting);
+	if (of_property_read_u32(dev->of_node, "itc-setting",
+				 &platdata->itc_setting))
+		dev_dbg(dev, "Missing itc-setting property\n");
+
 
 	ret = of_property_read_u32(dev->of_node, "ahb-burst-config",
 				&platdata->ahb_burst_config);
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 8dd5928..d527d9d 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -168,6 +168,7 @@ static int hw_wait_vbus_lower_bsv(struct ci_hdrc *ci)
 static void ci_handle_id_switch(struct ci_hdrc *ci)
 {
 	enum ci_role role = ci_otg_role(ci);
+	int ret;
 
 	if (role != ci->role) {
 		dev_dbg(ci->dev, "switching from %s to %s\n",
@@ -193,7 +194,10 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
 			 */
 			hw_wait_vbus_lower_bsv(ci);
 
-		ci_role_start(ci, role);
+		ret = ci_role_start(ci, role);
+		if (ret < 0)
+			dev_dbg(ci->dev, "switching err %d\n", ret);
+
 		/* vbus change may have already occurred */
 		if (role == CI_ROLE_GADGET)
 			ci_handle_vbus_change(ci);
-- 
2.1.1

