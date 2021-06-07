Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62439D953
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGKMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:12:17 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:22657
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230127AbhFGKMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grtP3/T1Jz3Ovh62Na4flwao2HTyMauhDhA0HLoL+M1qLG7Vi9rIxYEevl36tofBnigZVdOAklhZ/BEwKcwMpM3s+Gh5sTm3WU9X4ngw29FLXJ1rCej+wpPCjhh6kPMNwQWQfD+7B7JPjBvLlPrEEnvnny/pxb6GkGrGdfTwMHAHFJeQlwQp6ngGV5/d1izb0HMPbLFaj/OmUgF/puWPeKT+rZ+C6Sq5TcM9IJX8UFhW76AlEqfAXQ79Q5vDpUWeG8lt07ZxVHVMaWmMlI2nKovsTvxvqNlR2UWwMY7ayXSNmD7moBTT2ShWmbX5w+8CKvFMYmIcWV05+9/3ludKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UQUx77gNXnWMMm8BtV+IhmV6WM6J2iMGWMvfzXe20I=;
 b=hdOD0Q9w9h0ntC91Z2csqDx16W+iGEhWDeQTxZd2u/6/Of4Q/vGFeHZDsuQxdEHHGTZ0+MiZKsZenYVRz0CINXNN8p50cIwW1nyNbWGoKPauT5Po/NtmMRrFzOc3af7SZDAo1o3UJWy0r7W597McNxve720dl7VOV7xixb/BEW1FTtt4kNMzwbgSwZub37DYkrOhMgAASdfgPnMlEI7ZzdqowEdm5obHAQ1ZcUEDheigc7khV3AhSYIQQ1ZNBAJi6iiu/SKZS2QprRWp0/kJSWEOjCUSV9E1XprHjbeakRRl5VPW5uB509RDjmUklrHkaA+TNH+1ZxeUM4PGBa5NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UQUx77gNXnWMMm8BtV+IhmV6WM6J2iMGWMvfzXe20I=;
 b=HdLwU3A07LxhuU6liXVgQL10wed6rS5uFU5IhauETnbRfQySq2+HkV1RpvXGckD5HX0UjSTtKRUPNsmmUIsJqi+w6W9uy3QFwGZT0dDiPdgLIvB6JJs/P7qwH1av+TFbDAQwMvC0PHTGYNtP/PsAJ0ykZ8tizgqq9Va3PYkLGdE=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN7PR03MB4306.namprd03.prod.outlook.com (2603:10b6:408:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 10:10:23 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 10:10:23 +0000
Date:   Mon, 7 Jun 2021 18:10:15 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] reset: berlin: support module build
Message-ID: <20210607181015.5b8d3711@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 10:10:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 603a001e-2e1a-45e7-b801-08d9299c7671
X-MS-TrafficTypeDiagnostic: BN7PR03MB4306:
X-Microsoft-Antispam-PRVS: <BN7PR03MB430699F79A4C375977ABC173ED389@BN7PR03MB4306.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8n1DXH4x1jjh+eDBfmYffzMeIt76QKwQ1e77uQnO/Pc48m1AzMQxS6d1rih1v34pBoBQLe0J7bW5mmStD34QhOQAEyjUgk/EcI7rKSSQdSv7n4/YISfKEitr/OHFiX19BqlRtsKAlN5gQiydQsn8TYve1KUOvECCkiXwVI7uM9a+UglGuzr3PPcGVbHteOIHsbtIvFc9P/9PPsQn5wzglvySKNRt/D65HZgYjHC4AuP+TI0sfEDVMHHsZ4ksrvWze+OFqt0aJtaTxs9ZVF+IrJtOalbt8JAoSFTUeN6P4/KJpw3WOStdjuOjtDw6pMsbeQOyOpeDNEeeu5qZoaU6KAVn5HQkypc41YiYA37ERqlSWnrSParDMO/a+M0xRgqyhivzmiCJL3QATrZrmzJ+8y1grbVmDP1arIE3IJ9OlZ4f5yb3H4xvKiGdMHzne+xdxn5uKdvEWVizXnHNQosOfF1ezJSLwAnq4ju5s2YAJvZ/v2zUx0O2/g0fZYqjXnUsnVy6pQy9s6552M8TWlw5mXWbw9rG5RXIWIat1JimwVQyt6ggSPNv7QNEmPmJ991kNS3d4FpjadTjWvUqiITQNPV3keI84EJP+o9OMYzFoUgRAS9C+2Og39rFxjcYqwbWAzQA0cjbCBdiepiZ7itRX+tr+LHKZGorqsm2XXw/FP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(376002)(366004)(4326008)(52116002)(5660300002)(55016002)(7696005)(6916009)(316002)(2906002)(6506007)(83380400001)(9686003)(26005)(8676002)(1076003)(186003)(956004)(66946007)(8936002)(478600001)(38350700002)(38100700002)(66476007)(66556008)(16526019)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9PWvlH9IG335F129oafBLIpxf7mgsQxnF5l9uPFTrJrHSc7f++vL2sZr/f8v?=
 =?us-ascii?Q?O8E3HQH0wVVdkwmBbIrPtwedPtDr26Mrax5TU5p5h0edErrJK5OeftTzBLfc?=
 =?us-ascii?Q?WowRZwKIf9XWpn5XFbIoVsYBbkrtl/9vtHtKSnOH3ZDS/3Ki0e/8VgHdRxig?=
 =?us-ascii?Q?RP62gHDlcjvMPSmmWOM4mIRKs/F3iTLrVRDmunjs8un93DhvQtViu+ZrKhxP?=
 =?us-ascii?Q?Gu9Oexzq5XzhN/Tto2WAtktkFJNbdIO+h/KyFZ2j6CoPuDJHMqsDE0DCVw5T?=
 =?us-ascii?Q?ft/2dap5maLltOYz8OKalODvNt28NPFcqbmkZXqE18B6C6dYaiWfLpD7An8W?=
 =?us-ascii?Q?EctMLShO0JAPzmHSPh2sfGwYQ53pmdxQGht+n4K6jrAzv8Rc62G66xbVMS7R?=
 =?us-ascii?Q?Q1MNUCOqJru8m4q3kYwiiJSLPnRW7EXOUWejS4L73i3ahpqJw0RRVn68KTRu?=
 =?us-ascii?Q?pnZYeqTAVi++XQ2eLUZN03HfXlaXI4OHWZ7oH9b6Ip2JECz9Zk5WfS0x0UKk?=
 =?us-ascii?Q?y1BiTycqmosiuVjlPmvkKlz1GPzMjA0lDRnXnBY+n5WJ69/RB+lXKcE6Vgxn?=
 =?us-ascii?Q?lOJwgIwBoQKdFlypLEbFG7fflTGYsUg5x+ZfH9y0Y1JODmf4tb9Wg+nayiXT?=
 =?us-ascii?Q?aP84Cat2lR8246MRsvBbM8Zd0eR4WcIxk/l6tAwGTSSv/I8Lu62Pz6vhQuHe?=
 =?us-ascii?Q?Mk+Sr7xheU6UL3s6QVZmOzbgEZB5Oi5szXKz4ZCF7WCitSFVtmco5yp1zdjF?=
 =?us-ascii?Q?9hZ5mT0FzyZdQZs6SZa9Wjmq34SqaXZW1twPGWOwWR1Q/04ovdwZt01o/2nm?=
 =?us-ascii?Q?LQ5qxHRCAdbZeYlTeCM21UUxR0cP6e21pCL01EpHQaph5xkcfbb1C41dbybe?=
 =?us-ascii?Q?8H2IZNZzY+7xci0sBXqCVZfywoCNLCIm0fEF8RJyWlWQ6ok49o1xiKKCljaJ?=
 =?us-ascii?Q?HUdcZG+1LBFgXHVRHe6pXbRLQPfPCeLvy7lR0TcEnyOSfDB94MnvGJwUfl0d?=
 =?us-ascii?Q?m5f87W7jcfm3YN/lmUfqgMGt6pAc4G+Do+K3LW/xCaaeZ7yuGfwxoClwi+ig?=
 =?us-ascii?Q?VnfdUXn7Lt//0feMCmIYjaR+Vtv6HYbJ1eFgpfOxBVNF3HSOmHpwtBmRvqtY?=
 =?us-ascii?Q?1xfLSc5QYwPbhlMZ4HgLgBLyHT1XMDHiyZG7cZRMv1VkdaQo0GwshgpPbghd?=
 =?us-ascii?Q?umVgSZ3NBt/mq/s9+o6x2pKQzf9sDsMMCMKtWFwpcoTmevg+gr+IJKJa8vux?=
 =?us-ascii?Q?3m1ZBs6YVouw05xGaFp90zYQNbxidm33jREWXoZbC6+VpwyPc1DlVoWzRBQq?=
 =?us-ascii?Q?lbVGI8EkCEL3UicTUXzRY8cM?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603a001e-2e1a-45e7-b801-08d9299c7671
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 10:10:22.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lPV+CnoWkbWFL7ymLIn6liFi+sAbSZAd+IS/j3wO05IyBbu3BRPYYJc5u3Zai0ktwKJcDaZIQwT4TbYPXi0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4306
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make reset-berlin driver to be tristate module, support to build as
a module, this is useful for GKI.

Partially reverts commit ed4dba99cae8 ("reset: berlin: make it
explicitly non-modular")

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1:
 - Add default m if ARCH_BERLIN per Philipp's suggestion

 drivers/reset/Kconfig        |  5 +++--
 drivers/reset/reset-berlin.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3e7f55e44d84..4d64f5cc1677 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -43,8 +43,9 @@ config RESET_BCM6345
 	  This enables the reset controller driver for BCM6345 SoCs.
 
 config RESET_BERLIN
-	bool "Berlin Reset Driver" if COMPILE_TEST
-	default ARCH_BERLIN
+	tristate "Berlin Reset Driver"
+	depends on ARCH_BERLIN || COMPILE_TEST
+	default m if ARCH_BERLIN
 	help
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index 371197bbd055..72d8ea554d5f 100644
--- a/drivers/reset/reset-berlin.c
+++ b/drivers/reset/reset-berlin.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -93,6 +93,7 @@ static const struct of_device_id berlin_reset_dt_match[] = {
 	{ .compatible = "marvell,berlin2-reset" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, berlin_reset_dt_match);
 
 static struct platform_driver berlin_reset_driver = {
 	.probe	= berlin2_reset_probe,
@@ -101,4 +102,9 @@ static struct platform_driver berlin_reset_driver = {
 		.of_match_table = berlin_reset_dt_match,
 	},
 };
-builtin_platform_driver(berlin_reset_driver);
+module_platform_driver(berlin_reset_driver);
+
+MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
+MODULE_AUTHOR("Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>");
+MODULE_DESCRIPTION("Synaptics Berlin reset controller");
+MODULE_LICENSE("GPL");
-- 
2.31.0

