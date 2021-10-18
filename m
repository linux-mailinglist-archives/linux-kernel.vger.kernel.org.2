Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4547C430D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhJRBg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:36:56 -0400
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:42577
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233527AbhJRBgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:36:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGREIAlXjDIri11xYC7YuXjpX/+g/EA5IrdbdeA8phFj8bc9NbbQiZxqhfThYUYGcaNlF8fGfppElOgdrkdE61QDX0RqF8hhmaaicE0934VS9n7K0ffByWDxhv2pZknfwTMyI1XpBA2wD8v5WAa5Zgjyr9Ccpi8zQPebN8yzmYCNUCrCA16hvPrALxCAfYyK3khRzeYGx7CbDApiCmvzBKvgDnV2qUFzSqYbbrCoWTiCH906DsRPr4G/R+RhFDIg1iFOBvndKvJU3e9ow1dl5TgW1t0la95UCNuT2Ri5ZMaNvGF1Ke7/HsAu6oysK2hdtO7zqrZ/o8G/+DP+e4+NDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t63B5VarYLSA4JP5pJwxOovatdyKCl0EekNhCh9Buk=;
 b=oOTEOiCpjlXf2y3asTQ4MRsvJ2XJ99h+fo4hh+llAoygJwNHpGx89KwgDYRmoMRXxW5Phsa3nsVYdh5UVUErPTlpgCK3USjX1mlO/qbQ2AvloScyqoR7AmK2thRJpQ99F4IHBR94u5f5UHOgbYUI7Z0IbbnEU2CWq9psjIJLpkW7dCF4lEgUXcJup4jFWsnOPc2FmCn0m9oY+5sWBrAprVJZmBPfBHl+nhFcVDoGwBqar2HXqos//+LGHQ6oP/wWeIw9WFPzQB0SN/Vf+XBuNy3FxWe5rtGVo27edPRn5E5BAlaXwDvD0e379y38aNWlLHglRcVQY5rHky8pjChnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t63B5VarYLSA4JP5pJwxOovatdyKCl0EekNhCh9Buk=;
 b=R9BrqlhWTqOt1CtUqZ0UzO2KbT+u5VEZez41zvP0yHw4HlShHhbQ+WlYXs5Uomh49Qa6f1r9OfV+AFDc+rvEiaF9LOyh7BodBf6ZcKcvE677tTVIR4gPMMxeEZbHur28HfO3DyaJAZlylbhYue+KurKwOOnWUdhau5VxaSX7Vgc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2523.apcprd06.prod.outlook.com (2603:1096:4:5e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Mon, 18 Oct 2021 01:34:42 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 01:34:42 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mailbox: zynqmp-ipi: Add of_node_put() before goto
Date:   Sun, 17 Oct 2021 21:34:27 -0400
Message-Id: <20211018013427.5476-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:203:c8::22) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HKAPR03CA0017.apcprd03.prod.outlook.com (2603:1096:203:c8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Mon, 18 Oct 2021 01:34:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c96581-495e-40c3-6bb2-08d991d77539
X-MS-TrafficTypeDiagnostic: SG2PR06MB2523:
X-Microsoft-Antispam-PRVS: <SG2PR06MB25235BEA6092FA70B20DEFFBABBC9@SG2PR06MB2523.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRzG9wiIPGZ7eHRIeur8FaVVbXO/KBYiPotOUHvyZZFTigNx0jBZjfu0+h2wNsKMMqbkf+iDfRYBVlHwGJSr5Rnv/JOdWnTSPQCuTBOmEk1U1JL++g4GizXCLs9mzgW1S0RiI4StMIO3pPUGC9Q2qPSKi/SMZFRIsEP+9UlyTIzCtO6UFjQw3QUOHtzmgmmxL+UCAIfR9vUfP/fM1ddlCOKSuVvIFN0Y4XtvqyoxXUlxX5bbo1hwVdvHe0HlmPpzaNvUmW7jQzx6rxQkKFhqpLeW/eNT/pOhn917bUl8eglRmtI2rNP+z8Tuz25p10Oz8CP0SQgMzQUGIsxG1YWQnsMtmYlKz6yFSNuKPbb+SZG0roKu2eZH9TZ1yF8sOagmq3m1HZHwVa0kgUC3oU5WjP04/R1tnurwj/D9N9IbrvgbPqbUPxZtOqK5i2Bh2Ctj1av9nAPZGjSYt17a+K2vsQFFIwpo8vXDbJqUlOCXwGJHFXWa7lnO6OthNZQfy0vOQe/9tSCY503DjQ9r5C0uCpyIaT/NOt+TPWKSgitwmFh5cXyAyen6+l8iCURARcj5SVLUOsZ8cnwKl2LAfgC7LPM+jI69iZCsahNBigobSZzyN9SRsmxJ9LoovDOZcQrjWGlQWhZ4hAXwG1E83bgwGgpQ96bbFLdBpHJ29nevSXbXoKBd/uQdqJSI9NagJndB7sOebi69Tvc1Fkjy+nhhaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(86362001)(6512007)(26005)(316002)(5660300002)(36756003)(186003)(6486002)(6506007)(83380400001)(956004)(38100700002)(38350700002)(4326008)(15650500001)(66556008)(4744005)(66476007)(2906002)(107886003)(66946007)(110136005)(6666004)(2616005)(8676002)(508600001)(8936002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OTD5GvLD4gfjUVgruqTjw6lFxQlyHJ66jU4gaFuGxnn7qMzhZiWnoEbaXYhu?=
 =?us-ascii?Q?GAS7WI+3i+ja06ySQ8o8XVie7Kt3P78Sm0XGe1zERzW9WPe0vO62pzjZwo1S?=
 =?us-ascii?Q?aK6Zpweobe2R8W4/xI8U8QdJrKA+cMyk5tFF7jYnHTPUKXQVbQx4876dASQp?=
 =?us-ascii?Q?ipYAu+1jP5FqCMBa3lghc48izev+6vVf/GVAAHVyRzi0FwS+lzRDjq7H41Zx?=
 =?us-ascii?Q?ftd1fxAx910pTUSsM+6Od18foVMNHeBzPi1iADi27dqkyV/B/RUs/4+ebqgJ?=
 =?us-ascii?Q?a1Bh7+CuxjcoZlMVlS0d63jWigBanBCPaBrwJoFQWHXCDH6cKTM4lanfqdK+?=
 =?us-ascii?Q?jC4DdnyL/HSHYwT0VPonBQNGts/rWds/BHZufhx6vh48unB1ymPe3EUXg58J?=
 =?us-ascii?Q?KVzOghv6H4AtO1qjSUg2CMI6KGUc7vyMe9zEedvy8Q0oerDQd4HrPNSByfW3?=
 =?us-ascii?Q?9MsuGPmrlqcL3R3ZeEn3Wp8ivHZuAsav06+KWSzh3hVsT0MiuiROwDzRMYD9?=
 =?us-ascii?Q?yovrokbUVUjya+kdH2lQuEy0By+iPkkbeqFyP4pV4ulxenDedHpcu+Fn+cPm?=
 =?us-ascii?Q?/wQajnkbE4ydZsyM32OzYxqqVs5PfIo1nw7goIzzC80IY9VGuiEsHyn+5hH8?=
 =?us-ascii?Q?SwmePsBtLaNRkpJpOqq9y/2irVGS9af5KUHeCYHDaohwSS2VPGcnici0oJEo?=
 =?us-ascii?Q?JDMB3MeJfhBmmftO1t6uHkKfDK9jGfapAqVjiqrvzlP9f7yUSBBcnNHfRR5M?=
 =?us-ascii?Q?KmJYepXS+fePD2Ze44j8Q0lS6xXLkbuct4zcZYLRcIOoUrtM+7GlUF32Xvax?=
 =?us-ascii?Q?ambzaHyIXPStTFhXrLrCK48GuO5TrHYGdcWKyXsa4UhHhUF3BVBrWIReWrvg?=
 =?us-ascii?Q?xAv2OrNUcwUP7RFN6n9ryhvnp0WW6vkbVr5CnGV09o1kmxfxK8HYZip7ZNOl?=
 =?us-ascii?Q?YQl2UGYMT2tnpjToQp68xXrAm8823Y1f5s5XSiLAVWnv3u3/yfTOUSj8VHm0?=
 =?us-ascii?Q?X1RZC+QhroncGRk+/eiG93RY8/Q6Cbk5/h0HQvHtGEwEd+ROIyMRxGjK46dU?=
 =?us-ascii?Q?U2qNno2BnZUyFVUD/v1LcAhlaF9ih/vns4NkFkBY6+S0JnbG6OEmBqRx8XMC?=
 =?us-ascii?Q?QYH3VXdRw6wgFfZsyzqfK5K9WpKvVPw+sh7qhvZk25VlG/ou+5+sbLHMYO+A?=
 =?us-ascii?Q?ycOfKm1Us0+iaA/Tep4SQS9a4RBRRqKEEExdTqNAyY803rUavWYwReS+MICq?=
 =?us-ascii?Q?yY3G8EYp3yzX3v+YnbXD0O4f1Tw188SwlTx1Z1dEFVV0vNDlA8MGjR5MEhSI?=
 =?us-ascii?Q?VU5sBp7S/6hDjMdQIQvAUtSY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c96581-495e-40c3-6bb2-08d991d77539
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 01:34:42.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gRasS60neRj9m/2BsbPhjjsvEHIbdUk7fMnNZ+8nHrlRNWxl6pMOfvsPqAclOXFPMjFVr4zJFWKUwGEL3n+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2523
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/mailbox/zynqmp-ipi-mailbox.c:654:1-33: WARNING: Function
for_each_available_child_of_node should have of_node_put() before goto

Early exits from for_each_available_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index f44079d62b1a..67d4203fb4f5 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -657,6 +657,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(dev, "failed to probe subdev.\n");
 			ret = -EINVAL;
+			of_node_put(nc);
 			goto free_mbox_dev;
 		}
 		mbox++;
-- 
2.20.1

