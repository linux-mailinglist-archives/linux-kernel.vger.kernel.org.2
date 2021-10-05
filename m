Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB7422C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhJEPSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:18:50 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:55884
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhJEPSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:18:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp/7fhjN06Yl8RCxSuejEtLYZf/JFbEVrgUgwcfVFowH0tDqB+kHrXDm5Gzc//TVa8Hph/h3Kp3JBCYZoQ4X488wkFUfo6WAt1KKrjwvolt/wgaHXYiXZYcltIEWYMnxaU4wum1fHSFf7iogzt6ByuvWZiITgzEtrak3Zl1xrxFI78Zoodl4NsND8DQMAC8SBe12fzTlQnkM2Mnbe/0ZfN3DKZkNo42ZiNMPp8sjQ9m3cMSmKp/LGEEI1+XatQsZoPtBL25kfj2V2hLEn5ZD9x6UqC631rTtzkFiQQDrDoIS/q49XhV3KubUBBkTlLTihiuhtwmLC6gAiHnhWslpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a2o7j0HBCUIVJzeUoGv/YaDZFbTNpi1Gh/S09E89Nw=;
 b=Uc/o+UkUNC8JGuYg7zBbHFsOy1f6Nae8QjQ3VuS6kwhgBn2NF/r/PnwXn3c6X6yWbfRgNCAXySqYUzu2DbLCLGAUKKQgB/nO5W5+vn4sT6n4vz7Qn8h9wykfprppTgaSimOL79ufjl/Qv5Tbn2u7Z41FmXRekSjza4XkA5KcfCNIxt8tr2nhfnRH9gjkyNk2OvV4hADvm04FMA5DIDzMIj/YkBQTV1HSlGCAQ4iVlhZmEN34igsTttYvb8NlKg/BKVDXS8fjFh1cAlhVsFJagdNeLz5bGxYt0ZEgSLvfxJMK9sjPt3HBKwgP8G3oBJQkNvJX2xxwGdaL8KvipIU4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a2o7j0HBCUIVJzeUoGv/YaDZFbTNpi1Gh/S09E89Nw=;
 b=DRKvGAJnnhBViOnFc0+RuXp+ev2fhUPDlL7s6OSWBwgnxJNQDsWKHdVvi27/GhBZ+TF2vPQEzH8IyI+wDcpiR0UFvD64wCXj54Mzzjog75kHWAuTJnI3KE8rFtgrJ8mr0UYcIKYRBSE2DcjRDyxBfUiesTgApLeXZqxGG7ZYtdE=
Received: from DU2PR04CA0180.eurprd04.prod.outlook.com (2603:10a6:10:2b0::35)
 by VI1PR01MB3904.eurprd01.prod.exchangelabs.com (2603:10a6:802:66::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 15:16:54 +0000
Received: from DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b0::4) by DU2PR04CA0180.outlook.office365.com
 (2603:10a6:10:2b0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 15:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=asem.it;
Received-SPF: PermError (protection.outlook.com: domain of asem.it used an
 invalid SPF mechanism)
Received: from asas054.asem.intra (151.1.184.193) by
 DB5EUR01FT007.mail.protection.outlook.com (10.152.4.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 15:16:54 +0000
Received: from flavio-x.asem.intra ([172.16.17.208]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.0);
         Tue, 5 Oct 2021 17:16:53 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] usb: core: hub: improve port over-current alert msg
Date:   Tue,  5 Oct 2021 17:16:44 +0200
Message-Id: <20211005151644.288932-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Oct 2021 15:16:53.0039 (UTC) FILETIME=[06F5D3F0:01D7B9FC]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d45b54cd-e6ca-437b-3755-08d988132a1d
X-MS-TrafficTypeDiagnostic: VI1PR01MB3904:
X-Microsoft-Antispam-PRVS: <VI1PR01MB3904AC28BC50A36BE7646866F9AF9@VI1PR01MB3904.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDXdkskunQC6FjKXehFGLYGoa/XkKsF6aDxmVreuyTp5PrZqsLTnzHD0MO5LI2KSQV22GLgll4ALSweZB893U9z6nKCB/70jrUQjuWUqdJoes5FagHhSgXfKWmFPJYDotmMHeSZbdKMP+xd8mktbl6UAPaLYVAue0o8Gs/DDhctc+9AZ2I44ND5hQ099y4yVUXgKeXW6Xufj0ThJmMAuBq4e/c+fTglaCzqZgOH7MkzA1vq0QCN+hZBcU4O5nmo9hxAkKw3edYDXUbDaIh7TEASVaew5TeXB+i8GCKPYa4CL4NSBWKghi4kkmG4sznfAz78N3h71prBpjLQgPewnbSvs4b6PWKcox6XiesuHYJDHM48Qaz9wvwEFGA0S+kQsNO0wGXBKxe9MY22M9R3Ul2cMA+raeUxm32jTwRBM5E2o9Q7xi7MIA9cAasAzzPw1VJVrgRVK3d4ezNmpk+YlX5RWQMVdfOUeCrMzzuHiqUp+szCUa8Br9X0Q30hOT32te3I6GIJmyTE6ZKW8g5tZZ5QHlcQTVm+iLXvBKmv8RGnqClOyuH0CB6D4xMAmsrqtu0T5TkZCI5JyChBwf3uv262QsUggTGxDLcGBLCr5dEv9uAa2e3Dgnizy5GPiMEssnuW008XcjzDWbGYShIx12oWBdSIHfa9CgXJnp0ezIVWukDYIEcUn2WA0G6yex2cVcFGCQ2JjwXyvyIabjtJWqjsLmywIYJsCc7L99x3jwGQ=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(39850400004)(376002)(346002)(396003)(136003)(36840700001)(46966006)(47076005)(8676002)(6666004)(8936002)(36860700001)(26005)(36756003)(186003)(508600001)(336012)(2906002)(5660300002)(2616005)(107886003)(15650500001)(82740400003)(82310400003)(70586007)(1076003)(356005)(81166007)(70206006)(450100002)(316002)(110136005)(83380400001)(4326008)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 15:16:54.0600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45b54cd-e6ca-437b-3755-08d988132a1d
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB3904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the port over-current message is
displayed only if the over-current condition is permanent.

But in case of permanent short-circuit or
over-current, some USB power-distribution switches
(such as the TPS20xx, etc.), after the over-current
detection and the consequent shutdown, return
in the normal state.

So, in these cases, the over-current error message
never appears.

To overcome this problem, the "over-current condition"
message is displayed even after some over-current events.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm64/boot/dts/Makefile | 1 +
 drivers/usb/core/hub.c       | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 639e01a4d855..bf26ce60d78a 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -8,6 +8,7 @@ subdir-y += amlogic
 subdir-y += apm
 subdir-y += apple
 subdir-y += arm
+subdir-y += asem
 subdir-y += bitmain
 subdir-y += broadcom
 subdir-y += cavium
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 86658a81d284..ff6c8e0e2673 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5577,7 +5577,8 @@ static void port_event(struct usb_hub *hub, int port1)
 		msleep(100);	/* Cool down */
 		hub_power_on(hub, true);
 		hub_port_status(hub, port1, &status, &unused);
-		if (status & USB_PORT_STAT_OVERCURRENT)
+		if ((status & USB_PORT_STAT_OVERCURRENT) ||
+		    !(port_dev->over_current_count % 15))
 			dev_err(&port_dev->dev, "over-current condition\n");
 	}
 
@@ -5738,7 +5739,7 @@ static void hub_event(struct work_struct *work)
 			u16 status = 0;
 			u16 unused;
 
-			dev_dbg(hub_dev, "over-current change\n");
+			dev_info(hub_dev, "over-current change\n");
 			clear_hub_feature(hdev, C_HUB_OVER_CURRENT);
 			msleep(500);	/* Cool down */
 			hub_power_on(hub, true);
-- 
2.25.1

