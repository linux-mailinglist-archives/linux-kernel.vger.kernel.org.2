Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E81452A55
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbhKPGJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:09:16 -0500
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:38057
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232488AbhKPGIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:08:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/K/3DSsw3yneylc0kH5Yr71myLN26MSuDgUO3iICWhlh95/693VY3XmD9y+xz//0YM4Z1V/RFY64eM2Yk1sGEuCyMjsxIJvavVnBK3S/ZJsFqn58VB11yw2dADFwpf62K/xTk2MnuKDgUtcDdQMuc0h3UpQx/s5KLEaHCPXCD0O7QmzPpK0AxeUNE1tmkdutnBrlXcuBp8jvWS3Wn/Dp4NVe9byLInBWc6gt718DYkqPrRTAC/Hxs/4K4A9w6a+3VD5V8P25zQjpUPbbyw3gu2hQt/rycHHpQiCTIMVpVQG69pfhEeh/5G3C/BvHnmkbuuFViZ3UA6gGo8I+HblAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC78z2g98bW1uSH7tLZ7gTd0IympCsAzPT3Mx99CA8s=;
 b=kCO6/9yAtUtqng7c+HgDaas6GMsCmoGASac+M5BivdPv8UzaB0qp6xHIsF9TRsuTXsXOAXKAFrWBHDTt9MfztSAbsjDZyq+1jtHOJLRNleD8f8LECR+QxkrCU37l1CbJZmTjnZ3ZJZLMCpKkbSvP729N7XXUdf/K9SPUizZ8ycnlzlr2V879QQ+61fRzH4RRSS1eUVD/rj+rEOHtxpuALKDQk6cX+EoBjBuwleA84YwrKbdt9QdPN7e/6xfOfl2G6cqd02QRNUFM5Rc0ag/cauUvIyjxEhd95Uu4kQ68+/QrYAJEacUjkpR5zwcIHT5nkczm12Ur7YnzjMQ2V/tbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC78z2g98bW1uSH7tLZ7gTd0IympCsAzPT3Mx99CA8s=;
 b=f/d5INViV1OFSk+Uk25bmPhARwbgPr1Y+wrhjrPR0mgChIkd1zu7AEGb19xehAkSY4NT1dgzTuHRBqZj3FrcTxL7BXdHaBZbGqShqkFrpmrBdlZAcM6tzASCVdr+H6GRJASyCcHIr3HMkja6UlJHUxueotGu09GHWKSzuSV+DoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9331.eurprd04.prod.outlook.com (2603:10a6:10:36d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 06:05:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Tue, 16 Nov 2021
 06:05:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: arm_scmi: pm: propagate return value to caller
Date:   Tue, 16 Nov 2021 14:42:27 +0800
Message-Id: <20211116064227.20571-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SI2PR04CA0008.apcprd04.prod.outlook.com (2603:1096:4:197::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Tue, 16 Nov 2021 06:05:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93751a51-c491-47dd-334c-08d9a8c70e79
X-MS-TrafficTypeDiagnostic: DB9PR04MB9331:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB93313A66A9F2B4D2F63DD099C9999@DB9PR04MB9331.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1erfkNUX92EL0NOFaUqQXxwQOsLsMMgWy/Um5IQnRoTJxPnP27R8KvjURB6RsOAEHW1CEER5q/sqDD+D5D/DXCTLCUaFd8u8FBLYLIlp/NF0S+Bf3JV9Xpf+52qWA4LaEUrIry0tudkledJhT3oAjgeOEdRAm7sUkoPl1cfoWb/HnKp16iR1HaNV0sdVhikiZkOC6ushhL9zkeHN0aClnArO+WaN3KaGjOF4qDpDodHTjx4Bx+yoXOUxxydbjqieCnBzDRFxL10M1ct+pg4+BF17x+HOE3An2CVBaV59BbGbdzrXuBC3UJehRjK036dAxcbnJN7wI8mvM9mL4R6nfZlyOy3jfJAq7KY0kc3LuV0tQyrdDNo8M+7YTkHzbauX3iG21WLWjMoNXBKFwvrV+H85qDxGKOwk/h8bns6O8pOBpt6CBc2rs/t+gJs7royOUD3gNXuJVZudaAiIQspZEJBkKefAAyQCaU28FgGwGwK5cu4/b4ooaIvLwt6AtpO6ZzM+TTGdYQ5tdm/yIiZ79kfHRnNfDqzgb+Wcqv6DkXqcCfeU/NnFIYciIr85mvn3smrdGPotZQBc9SCXFtZ2eZbAouCxf2Op97C/dzKzV/WKXSUr8Q0mc1zJFMNEEtHUfFSUHKqBH/u+IJnH8HKNKfBphcbynNjIjsmLgpjOuSoEV9EVxT+BYVDu1Nicw7eB9DU8v6WbzPQNZCXgwhHAFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8676002)(38100700002)(38350700002)(52116002)(6512007)(66946007)(66476007)(83380400001)(66556008)(316002)(6486002)(86362001)(508600001)(186003)(5660300002)(2616005)(956004)(1076003)(6506007)(6666004)(26005)(4744005)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvaIPhe5jp99VJIkI/nHo0JBTm2JcELT9RMVM1ZOpfoJ16/pAPpNeLg8yR3z?=
 =?us-ascii?Q?OPl95/IWqP9LtucEaBP/dOTcMuHgZuk4NyJfPFh1MiLEsIxrIgzMWjbGTMXu?=
 =?us-ascii?Q?bA688TkGwhvXib8uJV6T9JKdozksYYur4gRHMHM0u0V2X3L8di9m2sOXJuPn?=
 =?us-ascii?Q?zqyoipuin4sNoueA4TYPjajPUfizIq5E07qAn+EGamrH7p/zk4bxPd5+biOz?=
 =?us-ascii?Q?h6BNBKHDWZXjS8C+QZOoWFIk7lkKQsworGFJ9e8iyydKFSWiNM/J0EkZy2W3?=
 =?us-ascii?Q?GJDB6T/BPanja0Cxeaiodb1AqdcwYgq/Adnl0lx8eeY/ykM0EzuDEAeBDxb+?=
 =?us-ascii?Q?1w7ma3aKxrKO6A0j+HpZRcBQI4dHTw/DIQROfSjSwGeGRISD8QEIF27jmfo9?=
 =?us-ascii?Q?A/3wDQMutPaJONb43ChhllOWz6enihXohuq4E31crU5zcJPjjDBCLZfFyv8Q?=
 =?us-ascii?Q?6WODS+ehezP/MMZ5+cUmimaLnDTIvETQ75m7UZ5wa81BfRxJlAohgUDdy3BO?=
 =?us-ascii?Q?bcKxdDjJDza6jAG0cK3v1Vf14XUm+86ridDmyBFJ69PPFOr8FUCJgNvPWAWv?=
 =?us-ascii?Q?a1y60kJRYgP7UFNVJOCBv2uhlBq6rwebKLwvt6GkSJViCqXHaQFi3n4gms67?=
 =?us-ascii?Q?CLUGo08YMUDj8O6YfO5UYnzlwFooamt9xR+Tn5NODk31kBTT7apZDj4UQY4p?=
 =?us-ascii?Q?nFxcHxeoyGtlj9Mujapk6av6CIc0NCx49USm4q8gC6aAqsVicJKjZn3ankNa?=
 =?us-ascii?Q?/N8yNiUJEkI6+ABc9iP90ErjuqMPL59VASzM15kO4TUd6YuPVGxOqMs3tcqd?=
 =?us-ascii?Q?f4BuvuMvvB07KOvrWb6qFQA6ceUUXpA78LYARNP+R4SyOajS8Qkoapg243fL?=
 =?us-ascii?Q?kfsCIwEtdCBpjBBPeYBXc02Jvue4vjQQIZAmUZspQbLjxObvM1BQqNQ+uSAP?=
 =?us-ascii?Q?02fv0NruP38IvP0N/gEPwY7t40vMzv9RyMs/J/OO8wwEO7DGPLeKj2eBGEgv?=
 =?us-ascii?Q?JD3VhO2gKUaNY4N1ylJ4NwJi3BXzrItZL7DcRu0qbgIclc4RHZ907bRigLtr?=
 =?us-ascii?Q?53vFLAMDaXFPej9/hBrDLGhZhrDPgiwnpBscAqqPi2hA/bXGFbUSE0OsUp3D?=
 =?us-ascii?Q?L0it6YVCCTmyFZdBTPbApLowibnsbsJ2JE73H42vPLqVHOjb2xi0nRkUabRb?=
 =?us-ascii?Q?D8aAO8o8oK2ijfxAvHWMYDmZ4ELs8REK6pQc9ZTZz3XsAoE77NqI9yLjnjuJ?=
 =?us-ascii?Q?UMzlS8TtMdG8DwXskapIVkDLSqhGbWFV4DBBpD24NecTkC1HQH5x/jhBjNF8?=
 =?us-ascii?Q?D4fn0YdUXEB7Akk51PdnMwMrGzxasEtLlNg+urtcQUb22UOjQaj4XfKygLxb?=
 =?us-ascii?Q?KtLylKujQMH//tEkqwLpe3gtVq574216/hoW5vYTmcnvqSIFTfoBGVvO2rbk?=
 =?us-ascii?Q?X4YQNFYlh5rgXRsdRQMtI1QkGdMkBrTN0zmCiw5UXPIubBaaFljuVUsPpehH?=
 =?us-ascii?Q?83nIUxoK9c37L3xtOKlgGmgRv5gVKlEVQX0j40qwvbzrQ1ztJfmGCVz32nSv?=
 =?us-ascii?Q?vhLHr1zAiTprwEUNzeDxJGsS6yo62HWKbPe7wZN3qhNs/p7k/Vy6zYZ6D90T?=
 =?us-ascii?Q?nmW8x2ll1Xm2b1xvNWvTouw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93751a51-c491-47dd-334c-08d9a8c70e79
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 06:05:14.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRI5R6RswK2Po5aEb1rh5Rx/WKVcuruCwOomPJ0PiDjcuepfaqJEOH1+Z5elhpbNMAYWOS8RvKvXvACiU3wyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

of_genpd_add_provider_onecell may return error, so let's propagate
its return value to caller

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/scmi_pm_domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
index 4371fdcd5a73..581d34c95769 100644
--- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -138,9 +138,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 	scmi_pd_data->domains = domains;
 	scmi_pd_data->num_domains = num_domains;
 
-	of_genpd_add_provider_onecell(np, scmi_pd_data);
-
-	return 0;
+	return of_genpd_add_provider_onecell(np, scmi_pd_data);
 }
 
 static const struct scmi_device_id scmi_id_table[] = {
-- 
2.30.0

