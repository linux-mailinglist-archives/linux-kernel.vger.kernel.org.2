Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5413F6621
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhHXRUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:20:41 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:53216
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233726AbhHXRSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:18:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi6nbfNyR+VzE5ho8huNQg8ULQNQUPhAiHk1CQKQ4XeBWehHCk57FYaJ/KFPloSsWdPdohLgNpaq5lk3dnpMyxJXbwDJPRTm8JWsspMEkA9smNgVl+YRCXOPkTy04GQdg3rE8pbVLNKLtn2yF/rhF85ndxI9BNwQnDAk+Xu8TSEUFxr+R0g0jXRamzmPwY2uHNRk3QWM7JTyFFl2j19VLSCMT6S0rQTrHbrHwlkkjZWoR9u3EZZiJ/m2Ghcezkmp3ooDpoS61aqyTtk97Hrs6Ko2nGh3p00eptJYfcyCEJagEMBDWnbVmcHVgnBZFjp/zCCl6VOXxwGVR6Dwm0xMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4ADCqfJjuJ02u4rET5jF2ZfTTT2AcEoc5lUlRM+ykY=;
 b=j0xA4MIrOOZo4uk/8ZwbbQInl/k5aE3fPMuqPLJ1T803Gknzb7YpcV/wrjj0uoOlKvRp4WR94+/utKg3ymhwQO+4hC1M7EXYYoz5/PW0Z5CzQpvXufywRTNZ5noYs2/vj07MDpqVBvoS5o/J9eee0Dc5i6K5A4ReUlXAoQ3jaHn1AB7leTvC8SrUkkH9cpMa3xHTdVXWvu6AvZnoxYJ3KRhBV0leMMNl6/r+Qxx3rvnNQlGUSvgIh/67L4OgQxE3mU77r6sRqlr7/k4dz+jvvl6H6tAmoybU1VwhSEKXsVvCA7moXbxQiQmPu14hOtOpFDQPX2nod6mtTt8nyVe2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4ADCqfJjuJ02u4rET5jF2ZfTTT2AcEoc5lUlRM+ykY=;
 b=gGAlYUnsShYsdEJRuhfkF+navHRHbQmRM/VPlqHZzn+55O3wHDmMjEHhbKkDShjad3VdRGzjYShD4SRhlRinNUhTZJGg84VcVUaKjOv7DnNMfPn266BXpLVzVibfVPbSlltjs/nxlQiSyES05p2GCe0hUId+Lu6OvyLCBEcIrGE=
Received: from BN9PR03CA0094.namprd03.prod.outlook.com (2603:10b6:408:fd::9)
 by SJ0PR02MB7264.namprd02.prod.outlook.com (2603:10b6:a03:291::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 17:17:17 +0000
Received: from BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::8c) by BN9PR03CA0094.outlook.office365.com
 (2603:10b6:408:fd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 17:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT045.mail.protection.outlook.com (10.13.2.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 17:17:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 10:16:53 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 10:16:53 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=48478 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1mIa2e-000EdE-7c; Tue, 24 Aug 2021 10:16:52 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id DC834604AE; Tue, 24 Aug 2021 22:46:31 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        "Subbaraya Sundeep Bhatta" <sbhatta@xilinx.com>
Subject: [PATCH 2/6] usb: chipidea: Use usb2 phy for Zynq platform
Date:   Tue, 24 Aug 2021 22:46:14 +0530
Message-ID: <1629825378-8089-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf1267a5-e6b6-4724-327b-08d9672305cc
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7264:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB72645B94EC458F97B6220C27C1C59@SJ0PR02MB7264.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc02GI1pSqDkjLAgHzf6YM38aw6ktUNwUXXtBZhHwEj9n6CjoX/jhhgfFTWsdmChamcJA4hrZyHv+s29Sa9opUW2iij2zJPyhSpgZhYTq2GyK6JYUMJ7KYv3FXXRQ5C9K9VQoY5+bhpB5r/EYLLPPGLj9qCtOpVpW2rkKK7kykMGgIe8TXN8j6AKz8v/edYBplfnz68Il530SKDMf5nw9KOg7bPwbY6WYAM+D7wU0ULbX3zcmjRaHtjqCwODPNyY0AZDO0w6xG9+DfGRZjIDf9IKtVCEpUQC8qVJOMJwvCoi0VP6J+Qp7kEsIjg5zhTyl6oMSe+RnAeJtlNuWjQ/xf9YDXxnnrsKJyKlhnxAn1XTRB4llRTHNzDt+EtGXmQ6Nk5mrGWnNLPXW0trPXMQexdIK6FuXs9SVw/Die1VzNMqP5tV5UUzr5zIQMg+syd6LSvfYD9divF+5E6FGPdPChpvTZlNXLhZiZt0zJ3SNuGRxC/uAq44QeHUSzBB0P7pHsDPOg/BSnIJx97/5NMeW4nIo+hG3DnPm/+k+3ZP0QTjqQIdD76PVUqPVc8XngsLaIuuUCyUt3ZywhUrAPOeqq0LZEsIxwmdA9QVZqB64GnKu90ZvQsjXoUl/xIuBSMb5YKuXMPx6Wd+zxcqH0m4I8TD2KjlI7E1I0TyqvbSCqG5vEzNeDkMciuRFp9G6Ua7DEtjRwnCo0f4kybbxTY8MIyKlKYhJLPwXKT1mXfWSJk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(36860700001)(70206006)(82310400003)(70586007)(4326008)(4744005)(6636002)(478600001)(186003)(426003)(336012)(5660300002)(6266002)(110136005)(26005)(44832011)(316002)(47076005)(8676002)(2906002)(8936002)(54906003)(42186006)(36906005)(82740400003)(7636003)(356005)(6666004)(2616005)(36756003)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:17:16.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1267a5-e6b6-4724-327b-08d9672305cc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7264
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb2 phy to Zynq platform data.

Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index dc86b12..be58869 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -65,6 +65,10 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 	if (match && match->data) {
 		/* struct copy */
 		*ci_pdata = *(struct ci_hdrc_platform_data *)match->data;
+		ci_pdata->usb_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy",
+								0);
+		if (IS_ERR(ci_pdata->usb_phy))
+			return PTR_ERR(ci_pdata->usb_phy);
 	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-- 
2.1.1

