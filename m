Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6442EAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhJOIFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:05:55 -0400
Received: from mail-eopbgr1300124.outbound.protection.outlook.com ([40.107.130.124]:52718
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236559AbhJOIFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfo7ZPf4QjW+P/PYmR8rDrjKgvrxHO4o6niEJFrKwPirA+6CtB7WcNGc1M85bECWp+nba56pSuGLgW34GIPpyIk9OdTCqpG3dxX3iVCDsqSQg8HLHCHEp45+A/AL+XmnhoFiQEdxnu91WUEWqpX6xgHtdHv0DILzho05iPY+QuLdr2YQDHLiPjZFfeuE8FpmnoK52bt8JDqMKrhXerzDLaeT5e28RAzcDh8R+tRzz5iJR8uU1KtiSaNy+QvtjIEu65EL+m9CNxIaUfH/UCGVSVGZUYHTinjbP7uEsrrUKLJjvpKQOjMYiU+Nc7uJ613uMLZw3e7Zyj0Rn7vpefSThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkd+leT8vf7gUfOfNF8FsZ5g5p6I+5D18M8HiUZ+vus=;
 b=gQCKserErms9n2LkuOqQDp4M1ZzFRzTrzlDiIIlTBo+7A9jbL3C/UJlv6FoWjmNuTzMH3bcaOW+88bPcwvsAObutOAzRVKi50frZro4xdprLUujDMA4d4BD9Jt77XJiJ5ELwSw4O3NPSAeumZn8oPuVVYYbV8WUzFYaKv+wjWVfn6BnKmrdtW7AEQa/umt83ylmJf6905L72mqc0qzCldnfNxgbMvflmpVFcKv9X8p9dV8mll41Pte4HprutyieH0gBdWLg3z9Unu8+/iEXqgr0/UmRKy1LPca3OsKTGuAWSYBb/88jvleUNyZlOw/6imjGShwLtauwS1/3VSAAg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkd+leT8vf7gUfOfNF8FsZ5g5p6I+5D18M8HiUZ+vus=;
 b=Yqz9XKVhuItkWP/vNq1OazFv0DGl6iM97oEfd1PQ4SZRGWeJOtY2Xp2S/8euoXYk9iMJJLoWLMQu8IrinmDMjvKS93b7g/3TiFPgH59bq8lQiHIP2LrJY/RP09Ql5moPEj561KkUM1vOvU0fDHp4VwUmTzE0Tln8/w2J5u44g0w=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3191.apcprd06.prod.outlook.com (2603:1096:4:6b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 08:02:27 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 08:02:27 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] phy: hisilicon: Add of_node_put() in phy-hisi-inno-usb2
Date:   Fri, 15 Oct 2021 04:01:51 -0400
Message-Id: <20211015080154.16016-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0006.apcprd06.prod.outlook.com (2603:1096:3::16)
 To SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by SG2PR0601CA0006.apcprd06.prod.outlook.com (2603:1096:3::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 08:02:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0237720-f743-4957-07ce-08d98fb22114
X-MS-TrafficTypeDiagnostic: SG2PR06MB3191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB3191A76CDAA17C1E8722FC13ABB99@SG2PR06MB3191.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKIYo+vNAFDZ6eRNTWVKIM8aX2s9bKQtTC4dMwJpuyXLkCMN7z69u3Pz9pABLsA1gU7INQjifyGvWGUC1qIN3X7i1KspEJSlKuqUalbpgsVQySa1aE0P5LxxZkdrNbgqi+sfCf0feZyHg7cls3Foh2fUCWLRcrj+2Dz65PQLGaDWw9CPbzEYEH9CScfR0AvcxCv5cMQxeCwG08yF771rVFmeGlI04DXvfkGJuWWaBdxIz/J5GHQLasZmNepa6EZlfOLq3rQOZB2MGOB/eIsS6Z1tonJ/JmeSXMTk+omWd7qlW5PuJnKItmI2Q5tiWAsY+Z1KrG0XGJ2/XgfDjEmlutD+L7lQdZNvEmSsuDwUc5fOn+I0umXWv80SwJZOpNLVp/ZcLNhjBzrjQ0bIozWf48OZ//JlvJxGhQWtGmLI4Pn7QYXDKeJXo1KyuUsciNc1f2xIWxWrJuq/vP9LMBqRJ3+w+NYYVUukDVh9vmZ8NO9nJd9WthvE8bA9IU/qnJi4qlkrX5nYyl0lYR9KNmWZx6PiB6ysOabOjSGynOkXPH94PD3kr4ZAD8LMi3qEbsTeegqMIrCeg2ISfXMamC9kLMDVbRtQVKzDuE8vd9beEJ9oFtrPViIllieY2y02MFZVr3oeics6iyJcZP04F+4dQMb1b7hvIjdFRiA1VtjO/UJkx0V7ualqyz7s8VxIG5OudMmYBMMJdRlR+Ob3r+zuGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(1076003)(66476007)(66556008)(36756003)(186003)(2906002)(26005)(956004)(110136005)(52116002)(316002)(6506007)(8936002)(8676002)(4326008)(66946007)(6512007)(5660300002)(508600001)(6486002)(38350700002)(38100700002)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x7s17ndFkEeeYaGaPmSQ5snwMj9eJiSt8tNaZ8GMcsSvVDsNjJ9/kl6qk6Ng?=
 =?us-ascii?Q?BpAu1wV/uK8fv/paVy/938lU2aDPZJ6fmUzUISs9803/14xG2fUSvfhiWamz?=
 =?us-ascii?Q?aANKRT5l50aRFZabnN1plEQzHUz9KAoHBGpDIvDvSFgilL2con0XQ5lTo3fs?=
 =?us-ascii?Q?RmPX4E2VWHqvyVbI0StQ7F8ByiFtgtSn0w+/Q8HENAXJyO7fn93O1GQK4OgK?=
 =?us-ascii?Q?ffEpjGqo4/fEhNq5QmPj8h7ikxF+d2M2Jsrd5emlzLRxmvzt6EPFFekXyAjZ?=
 =?us-ascii?Q?wOgEXbShBE7SGLFqRGxKy279wpJsqOepd7mUyMolYDahkJH9e91h3RJrakPq?=
 =?us-ascii?Q?Iddp5MeDsJQ+WZPDwauiMBCwTfwVH3dVClX6dzxdOEjxUVYi/290xlgDp7k9?=
 =?us-ascii?Q?FWol90U/NFXNKzDOyfIX98Ew14crDvNDTu5ShYCW7aLrPBq8xnw+hGGGRFLW?=
 =?us-ascii?Q?lnt3F2dceMVxFlO348+8uN919qQoGPWDkx2WsORquDWur0BXp5mYayxrcYOC?=
 =?us-ascii?Q?8pvn5FS18rGnjD9ha168uYpqsiCKsgXk1w0m+i45OeyxzKpghABgEwR9uiHs?=
 =?us-ascii?Q?avl4PEPeOWaMiYInI4KBnVWPMf+NinR76k1Q9ItbH0WRACxwyLm57Urjb5lF?=
 =?us-ascii?Q?vLQSEhtPTOqeuZ30uGAXIVuYkN0C9s6dyhxb8NVVMcQbeqL2KYTHGEYxKh6b?=
 =?us-ascii?Q?fn7hdMLUqU2bNNQFpHhPdzdWwtjsz54DZPpRyp6c5aKea8eMzHHrZTKrafB2?=
 =?us-ascii?Q?ZhJJC8au60Uy3iC2xdEcobZjxhQ8KoLL8DAlkbu124pqbUrE1gVI3VPbPqMP?=
 =?us-ascii?Q?WsdVLLLc22QtEisZ/wi3ItxGm0szM72wDN18rH6utJP7KM8xqyxuuM7SJicf?=
 =?us-ascii?Q?c1tXax4L9Xd5tQc2+IS7DbagLYs3Rkz43uKPyzqUzhZzqRU9u11dlxvMzKK/?=
 =?us-ascii?Q?RsLI39tWBcPJjl5eHf3Un3nRbuNGebtAvczto3c4h12znsLHzbpo0wc0fhjj?=
 =?us-ascii?Q?HGf7HWsgHBhtvLEGPY5fVRTuA/50iqBJezWbENPbZKtaUn7XTA7yuE5efrMq?=
 =?us-ascii?Q?aY/8zfXmj7g/e2JHq3nL7ohinPvVvGdfoAZnScP8lfh03Csrn9NFVYzH9Zf6?=
 =?us-ascii?Q?5MozyaEo3hc+4atBcPDMgszf8gGlBt4uw1/gFIiLFbGlZh/9y3+uhNgF3ghW?=
 =?us-ascii?Q?MRGm54VyY+tFG38YdVoQc/rIh+inx75nirUrox2HUt69fFmjErBDdt7lMrKf?=
 =?us-ascii?Q?9fKXxpiyWoILNBYaH6dGGPtPOYpedVkHT4C55A8gXGVCgM5pknhTMKe6tRGL?=
 =?us-ascii?Q?Q/hjzOUBro1l8UJLb0JMF7RN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0237720-f743-4957-07ce-08d98fb22114
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 08:02:27.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf8wQKLK2kH0iqQZu0AmA+hIDxF9b5eYMSNOd47YUhsDOjm45ULUkiIu5jjc9N+p78X7K0s78gc7iX3xD/LWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/phy/hisilicon/phy-hisi-inno-usb2.c:138:1-23: WARNING: Function
for_each_child_of_node should have of_node_put() before break

Early exits from for_each_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index 34a6a9a1ceb2..b133ae06757a 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -140,14 +140,19 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		struct phy *phy;
 
 		rst = of_reset_control_get_exclusive(child, NULL);
-		if (IS_ERR(rst))
+		if (IS_ERR(rst)) {
+			of_node_put(child);
 			return PTR_ERR(rst);
+		}
+
 		priv->ports[i].utmi_rst = rst;
 		priv->ports[i].priv = priv;
 
 		phy = devm_phy_create(dev, child, &hisi_inno_phy_ops);
-		if (IS_ERR(phy))
+		if (IS_ERR(phy)) {
+			of_node_put(child);
 			return PTR_ERR(phy);
+		}
 
 		phy_set_bus_width(phy, 8);
 		phy_set_drvdata(phy, &priv->ports[i]);
@@ -155,6 +160,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 
 		if (i > INNO_PHY_PORT_NUM) {
 			dev_warn(dev, "Support %d ports in maximum\n", i);
+			of_node_put(child);
 			break;
 		}
 	}
-- 
2.20.1

