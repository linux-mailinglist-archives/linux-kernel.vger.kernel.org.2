Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8B45B712
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbhKXJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:05:52 -0500
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:20033
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230262AbhKXJFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:05:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLY0g9A6m+gkEkB0F6WUcdR/0WjvhpY1VN70r7qbzcwgVuguWuHIZ90sBI6dm52XHoLm4/h4/MU/uZKnw1LX0wDXqwR8hyLLoCMjz8dICpMwsqiXvDbePCsHpwdtYA/uPFKgq/KKtOXsaiBT3dphRlyvUZFOwWWmGBqaB83hRc6EK2Dpnc/4UkvzIx6IIHGyWAWPRELArd+zn84GFEUN1ZZkswzb5aXw1PmQevpjZVQnAdvwK8TYE7TYcXmyqiCQ8wl3paKUGSivuHrq/EU6/yTmYeB2VggiUog73jwMHF7YrcFTVs7Lec/WqHwXHTkSHw0wmijL4vp3nwgqcBOxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94e4wITuPqwFa+S6fMJPAk3ZA77L1/XcstosJqwIb2M=;
 b=Zg+eACBs/kKKvLXh7HMEeF7ssldaqJWVypyEISztphRzdKHYBJhZbIE6KDwa7IB79poOm9RMCR146NRXri0QBP0s/Q9OvITgFns71pH1DypH4oipCpoajxep+uawU4yVwdbJ0a+86Lkaa/uaGxm51Gc6yoMBeuWeMiusGwPV5s8tS+5QznHqwXqBfJXcBSr995Ot8n4YzSlzZnISFgZQdLtmyM59BTUhqd3RDb+TmJ3GujiVuKWuuY8vNkaUmV5O20Apa3A4mw+MZ4Maa9fhyfYFVpWR5FFgfn6I823FnlwpfasxGp/6nmXB087p3MkW4R8GTtiF1qEg94yjdkU0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94e4wITuPqwFa+S6fMJPAk3ZA77L1/XcstosJqwIb2M=;
 b=fYGel9agbvZF6gsphWXtDW4HCDS4cl7nklv2Kd/1xaATqAesyzlScJS+VGdWY/UxwqH4aZFKdwZz22g2QUET1CUeqKd4uUCD2lkB0j+CtXnq5+kUNCO7SpEQLtBASDpWMd5uca/PNjoweabiouK3HPz+qjckhojboHlGPxuuU7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9)
 by AS8PR04MB9061.eurprd04.prod.outlook.com (2603:10a6:20b:444::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 09:02:39 +0000
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::b179:dae8:20d0:5905]) by AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::b179:dae8:20d0:5905%3]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 09:02:39 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] arm64: dts: lx2162a: Add CAN nodes for LX2162A-QDS
Date:   Wed, 24 Nov 2021 14:32:14 +0530
Message-Id: <20211124090214.1475159-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To AS8PR04MB8673.eurprd04.prod.outlook.com
 (2603:10a6:20b:428::9)
MIME-Version: 1.0
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by SI2PR02CA0047.apcprd02.prod.outlook.com (2603:1096:4:196::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 09:02:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0249f4db-7043-49d8-7164-08d9af292a90
X-MS-TrafficTypeDiagnostic: AS8PR04MB9061:
X-Microsoft-Antispam-PRVS: <AS8PR04MB9061CC74AC7D73A775E2EE62E0619@AS8PR04MB9061.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yatcXs7NxB9RTgEWqWVanwsH/HzawbE0sEvIocUaOzRivOmUv0gnDrnBCZ7EbIY5v9UOlSauXYcjTsVq8n8uMo745cSDoX7VLI/D3XeNOv8Yg0Z4Wu++FtPcAAKicKuW4kD6mcmsvFGgidUZgYLK5HrDTU7OOfA+XMzB8u9DdtiKV6uV7eOAhgU3t2Kh053gffPC2TBIwT+mPvRYQN7Ny4Reei6+kZFH+L04uokX50m2gk2w44sKKv/jT5Ual19rYKndnUE/EfmzMlLtDudvN28pPCk4NAv/ZFW1nokxtG/HycFHOhBaGshOISnL4+LDRai+rmjXL52iu6hIlfTMIWfU5oskPxkhY6AccXbExAj2ZES7RN8btqskPjlUkhiTfYkvOfxF55O8xGzfDHwb5oXQwJbTt97bbI0SHcNzosDvAUXXeNEvHbrKZYA5z7AT9ViCj+8DGYqFwTWrXkqe8WguEIRezNVZ4YW4mz2qVLkOyFBYSOz1QmYxIwi9DfDNbR21FSuOzukaJYHwNS0kZ9KQk+mv9QwNOMOt0LHV9GHE9vox88ekMTWR0/KcmZnTwKWJV7gupiJHI8Bq0y0lLkO+PdeiVkrlZ7zsnlySEryxWUNKn7+ywy8ab7TMXlTgouN42ebBok1oEegBoe2z4+USa0rCcwUMBtqDk0OIkHO3z3zCo/1w8gONDCFpITGD1FrVgNUP7I2RloY0fVDCuy4bU/qDkyCIHfWeCaI5S+uVmS9tubLUqDWfCzD/o9p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(44832011)(508600001)(1076003)(66556008)(66476007)(2616005)(5660300002)(38350700002)(4326008)(55236004)(26005)(4744005)(6666004)(1006002)(186003)(66946007)(2906002)(38100700002)(86362001)(54906003)(6486002)(36756003)(52116002)(7696005)(316002)(8936002)(956004)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7BKaXYV7BUTs/X+TLpkWknCJrW4Isy942EaDWGI9IN7TspHykI/M4Q57gpIV?=
 =?us-ascii?Q?2ShzSLBiyP1T7Ka2Z2ahf2du/+H3Rk5/HLJ3f/5PHpE4YgGWV5/BrR8tkC+h?=
 =?us-ascii?Q?hBo+FneCpIHqR2Bzib+0xdFeA7Uirn1yBDhMHSvdhz3Vc5Eey2qBlquoFNK/?=
 =?us-ascii?Q?FHWStSuWSAcCznZL5nbPNxrVcGDdxAdQxGOIcMfKWC6crrFqlYa9nfNA4SAZ?=
 =?us-ascii?Q?/YpQp+FwpJReMjjUNqmk+Ae/0AgkMP2YTOoBis2+/P6tNnidZA6Nw9U/6cM3?=
 =?us-ascii?Q?E0qqWeNW9rkZ+OQ0tDqs5gzRQ46LlsE8zfjk0012k5C1LFI+Fq1kWIPPUD11?=
 =?us-ascii?Q?F7yqzhpFuAT7tYsPfzIpdn6QwHviV5xqbFEPK9aJ1wnP5ztf7lZYF3VQsy9h?=
 =?us-ascii?Q?KKGT1LV0Hc3DPuQfaKM2Gz6yTKocpx0JAgU1VcaGIS8LESu8dQCKpGyHrMWv?=
 =?us-ascii?Q?Uc9VPZPvjBx0VN9PzP43UhWeeDviioVEF/sdnJ6LIjAXwHOttXoDjOjoZaUM?=
 =?us-ascii?Q?WJyGARG1eqidQyqct6f5aR0iuy5PQkyZX9VtfewUp05bcgWdwzwZ5vo5HdVZ?=
 =?us-ascii?Q?PxlyvWg9NCbnLw06HxRLvjTXTRlm0ajXpq0x8cAT9uWwHZ5Tomb8HVwK+oJF?=
 =?us-ascii?Q?FdtrnRDRljQ5ga1mRqMWOQrmx5NPqaXsUvqu4a5qo0019XXatVU83D5zBZl9?=
 =?us-ascii?Q?IGaNbI5b6gHPz6uA914TIJhaIlxkD+twFQ6qzsIzliGGprl43CMzwlTHtNi3?=
 =?us-ascii?Q?/O1Q0wxcuGysQj3Wf4bsnn9Xh1EpQRthk2gNbZCERRIjhhx/W27cMgtiYoZz?=
 =?us-ascii?Q?5gJUdBLx2wzc4pivwlbq156u1P1JMnlGLj/azB0n/doMVJriBTGGotwGQcvX?=
 =?us-ascii?Q?r6g3WXUIYcmnv0hkE3PzYXYmTWcq20OLOGlwtRf1r+XwXPVqOSXPWKnW1jr2?=
 =?us-ascii?Q?XfeZb5YUMkWbbJVaLAwrhy8I840+8Yp4gDrq66P13/i/cxxhL/INo50bYAw2?=
 =?us-ascii?Q?Sp7MZB8MQtpr8F1+SgGYihOJG8aVlBzCPdlm/aM/mUGLfVmCmGipJXfs+w7M?=
 =?us-ascii?Q?wq/nCHjkbq31aAno1n1psUkqpKV07fjTLRMFlaZSTMZ0Mg71I7Bvg7OA4Iq8?=
 =?us-ascii?Q?mpzAKqwQJj3hMcNM4EGQOjhCoBAqeJP7YNn22DY8JD3dsnw6eiY1dDd5zRWw?=
 =?us-ascii?Q?NfehkrE5D3ExAw6pIb936MgYZa6yd7LmsN9zlGxiaMNAnwePNTYByB0xWVBc?=
 =?us-ascii?Q?9jPjtbgHXwVQ7VM3JQDPIQkYiXUftV+J8TLJuoMxbnOr8oB+gkW/m2Mh/Pd7?=
 =?us-ascii?Q?nF3cTXCLDA9uQB7VSNuxUTb4DhwDdNgyotjigMFLn2haqzXc+y+wGyIt2Z7x?=
 =?us-ascii?Q?p1uYlojQj66yX/dlMEG+Yd/SybbRtYRljp/HSF3CVgACJ1c/gDYv39qTbfYV?=
 =?us-ascii?Q?0XnLtkhtvc0OmSc2yLraW1dcnvvVQZsIQ9f0yBuXJrF7sDoTUUaKJ42XW8As?=
 =?us-ascii?Q?mpTlF9hyQTbInd+UhjdO3g9adfaMzkYZ15tf1yO5rEdL2Mlk+SLlQvk9NYhN?=
 =?us-ascii?Q?xpkK70XuT9K2gCqyvcHU6MzrRUb/s3xdTa9kQNPzg7DYCi1h9uO76ux4JFJ9?=
 =?us-ascii?Q?pgfiOxnGUV9YK1xTcKw22TI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0249f4db-7043-49d8-7164-08d9af292a90
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 09:02:39.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuXQf2ZoeJmArwhV2WFkXp6Py2e2+rUSMPMCqirwiGLRTG06CCdAia+o8pb31gwMTW+sBl0SaLWdvMr3zO9ofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CAN support for LX2162A-QDS in board dts.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
index e1defee1ad27..67e07a8a42bd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
@@ -167,6 +167,14 @@ mdio@7 { /* Slot #8 (secondary EMI) */
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &crypto {
 	status = "okay";
 };
-- 
2.25.1

