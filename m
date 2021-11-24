Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DB545C807
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351637AbhKXOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:55:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17790 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233662AbhKXOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:55:18 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOEevAS030846;
        Wed, 24 Nov 2021 14:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=9uOYJmyvQfzRpgkgcP6yaiRF9SX4ynMX6YNSa7RzHfI=;
 b=rTF8oh6oykLydmXtB2U2Glc50B7aETrY4f1Ka8zVXD2Jeg58o6PhZo0/D2nI2sIAEwAM
 2K82O9oKthNtH9aetoavN3pPtfVGD2O6kuYLJgwAFsefUCQLunlPTbB5pH8aguk41tLd
 B0hhnFU4JokVVfCEKo944vyp3WuJbYlVPlj+cBueHXtS/0KwtcW1cfe7uDaHhLg2vqXU
 tOotikwMcJF9YHt8eVA4+CMxrKjRRgx+oDqMvJfDIqOcTxr/HfywAOakLeiK6lzoXKlX
 Xn6Z20u0+5ECS0mcmbl3msrmgc/IrU5cCKKwTk1qhSxzUmGSESMtoLmlk9v3YHMWcDk+ Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chmyy8xnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 14:51:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AOEpIYx164249;
        Wed, 24 Nov 2021 14:51:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3ceru74s7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 14:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKU5x4zWfjWKTT9d+KMkY+jn1vjR+K232RLh0mNCcFMTBr59YTYB5aD+tNrN5Kr8M8SKD/MngDbG+5doI09GKo0/0COa/OofheWXN8QqjXWiMfGDRoK+syifGVF6DHBF6tHFklsScujSDfk0j0QyVOP3jtRiObxcyewvFOzd7zx6jhj0BY5V7ppt5SAqMb1x69QxToL8BvIrtEvydp3BSakCO6LB5MXhmasSJ07lpOZTiGfINBfnAUFSKVv1oywM1VooT5bleSgw956nllyv5ktS5M9c7BGpo/CXg/tsxpaUhIKM000IaA5kOz8lScaApqn9WZf5cTnqZ1Veqrt+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uOYJmyvQfzRpgkgcP6yaiRF9SX4ynMX6YNSa7RzHfI=;
 b=h+KtE/seeNOFVe6omc/UyV0rsTOrHahhVg+fnGwGqdWSsdepG4Yst+UiZXBZHf5qWn9Bw3U+zWMt/ThysNpVqPUdGpl4pVF+u9qMxu9SOy9zkcb0CCrfc4Eu14zUPU9cECnW5KjXKnU1GPFCHVTByf0ausLjt8AbZgY8WlSq+rSDQKrcTRxLZ7ziWTykacq1J68DHNxiRTX8nQg3+YmUmdF67f3hP6ouEaid0S1IDxIXppTbhhCd2ryuTI4T04gTDHAnke9c9wvqpnVlHJFISWhbnr+kSVN99zjDLeJYHFY/qYg6Q3UlrKgfWs/f0oThjv6LMV7thhacTlow2XYAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uOYJmyvQfzRpgkgcP6yaiRF9SX4ynMX6YNSa7RzHfI=;
 b=FgK9hOdJV6V6Vah9eXDZOIObkr8h+xJkCXcXIVeFLQy7liI8DA6tQZzeEB+ytnCe3k20fDGJUt09O95iU+RplhBKefluZUflVc79tgVOnrD0LWgobELQiugmrD0frbH/pCnY7Pu5fA7bHES2IB1bynPmm5Teehpl2hlPday3qyc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4707.namprd10.prod.outlook.com
 (2603:10b6:303:92::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Wed, 24 Nov
 2021 14:51:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 14:51:40 +0000
Date:   Wed, 24 Nov 2021 17:51:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mailbox: imx: Fix an IS_ERR() vs NULL bug
Message-ID: <20211124145126.GC13656@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Wed, 24 Nov 2021 14:51:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 363758b9-e1b8-4c88-28e5-08d9af59ec5a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4707:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4707C4A42CA7EAB6E2E9E1488E619@CO1PR10MB4707.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5SpR6bYyWACdThapqVVqXeVtgihrXJylYtcfRDm0rxNA3o80xLf0k4AiLJPZDpkIdR/wE4m2wGuGYUeFcfcAhMA1IGBlwB/QZVng8W54032mBg96xr87Z/v2jot2PZvGPKo3kbCTSoZAM6rSXTt9miZsVpAUi16Cv5PhE71iXOxUK7tFZHl5nYYof1gCvhUXrj5tI3z9hOSeM0Q48JSFZvt7NRiOqGVMrgMVpm3bX/FG4TGkheGyCkC7zti7rz46mxZr6S8m85f1GDsuzO2g4uA0YqvGdB8SnzKVt9elmbUPaap0sTUGfZ3489jhBGNJECOjHTwL/vZYpu62jKClUvhIqkSjY6R/cxhsDSUvKVV8NY945JaHu6yuSNKn5v3ZEqltELmfPWmRW6dgBq33AqspgJRg2wAzTaBjlUQUMwnWVT7IaPbHlIPUoikl3aOt09yTFySHIcEPhfvIZKduDNInnBtKXdXxVoGuSwns1avAILWqH/lQC19Q/hfxzLNgyYc8T7a5V7bJnxkgFRWID6AiFy+pEm8fSsvk6uDvg7SjUr2gBNvNFinpV6o5madmJ6rA7H48rEDALxwpcnzbUpihOJhaWht6R6G2vdKyKZrdq6QRzVHEcwlUkNDztFzf3BoCVj6l3u/TdZdTlN3E7+hjbNi+m50r9ls8r3xzFlt/2xCR19yuTKZTb5iXBYnE3qiSG1Gs7HOCo2a5Br+AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(6666004)(9686003)(4326008)(55016003)(33656002)(8936002)(66476007)(66556008)(316002)(6496006)(38100700002)(26005)(33716001)(83380400001)(186003)(110136005)(508600001)(38350700002)(86362001)(54906003)(4744005)(44832011)(2906002)(8676002)(9576002)(1076003)(52116002)(7416002)(15650500001)(956004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/koNRum5Ahqaa7Z6A1vu9hDxz0vOuyaUICtkmzhpyfXNLUrDXOtZu9m35Z+i?=
 =?us-ascii?Q?+k5uoJcdjOK1MUwrB6n+Q5DRM3LGIdZE+akzXls/lS43mQZhWsrtboYnJ4pa?=
 =?us-ascii?Q?mcjOwFMHA81O5tFrbyXkbMLRh+1WkPYnjdrYllCROIfHj7S2Ls1gBAyYAxnf?=
 =?us-ascii?Q?7l4mK3pyFhlAkY4gAWbTglwQs0yS9Bi+4YonsW95wXjp4xIbXyAgiUqeSANj?=
 =?us-ascii?Q?qjFX2eGhoxNsrCOlYbl8NvK/auF6hEvgf27JdsqBKZQtCimx1Yuu8GqTbjWC?=
 =?us-ascii?Q?+8w6exsDA8Mku6LmKdeygaJsyQUJw+mf4+QbUU/qQ/psAfGviujcagRoYphj?=
 =?us-ascii?Q?CFRvUF8mfrn/9cvwi7qFlB8IrVfbj4rR3ANIFqCy0x6Uoai0mEAmO9a0Y/a5?=
 =?us-ascii?Q?RdiPYbd47fuslE9l4slDzoELP7GvRdUl131jm1G+VlgePoNMRLilQ5PuIeot?=
 =?us-ascii?Q?2ts7tusamdtHAzaI7nddBDYZ91ytZZzlSC6lLxmKsVQXOVL5HcZZnxhrOG2b?=
 =?us-ascii?Q?X76/QR8papMO+ki3HnSO/PzUnqfQyrMe6cVerXLc1+7c7QcKgXlQGtOWygUN?=
 =?us-ascii?Q?wgGV/5P9IgDrSR4dc7x01HHeJUfMvwZP6cTmomZsA/Hm+fW10QVAi0OvUYjF?=
 =?us-ascii?Q?lDe50y2jztdCJ4En6RKtaPZeZ8WMX6Qwcp9zmyZqo/lZKvULE0DoUKOmDuem?=
 =?us-ascii?Q?2zQsGutxEEC4lwp1gvH1txQIQMGW0FOzKyKzfGAx+8W41SKw0vbQJ2xVm4Q9?=
 =?us-ascii?Q?4Icnda3uM/dUXTJ+CsCFYFbnofcr+uwzgWu9/0CxXxPzmRoBjyPHrHkICoMj?=
 =?us-ascii?Q?i0mPSxxsJeggG2CWIHiAADNU07ZZ68j3O15zPY1Su/NSPBaSavflq9d8TQuD?=
 =?us-ascii?Q?PYlx6Wo4U3J7o3CzHt/UL45DDgJBgNt75zeIdA23LCPTb/2VZW3DJLC2uBxI?=
 =?us-ascii?Q?rPdZ5rQ+6Bn6MP07z0GW/ANH6jjPwQ6fezAt+B5zof+C7k/y8Mdr87a8MiAN?=
 =?us-ascii?Q?sLEyUjOLx3PsScRR/97U7UuNL8MFQddlPjflHJLeByt7l9ZEZ3i6Tl00QHcN?=
 =?us-ascii?Q?ImY8PE6QoTg9QkS+I5nTLLMGK+abBBF8MD2qzkrs8l+QeYmSiheHmZU8ZpUb?=
 =?us-ascii?Q?tCkPWbW6Iia5MobuYcXZgR404uB/6JsZ4SPVQIvUCz/TrBu0E55kp2sP+w8i?=
 =?us-ascii?Q?dzVztZUFZHRqRpSKcv/oNB6emz7Jdo4wGrxaMij4nnZwnh6HshLd9grwlkpv?=
 =?us-ascii?Q?vQR+aGIs7MHnWj09tG5xX3MA8N5mSxgId6L6bjj95JGpXSGQ3AmgJ6FWOIfo?=
 =?us-ascii?Q?yte72/UiKpZ+VR1fENkksfsTm1Ny7jj1an3VLmr+W8v97bHyMKOQ5Y29ld4H?=
 =?us-ascii?Q?BKa5EeISjrYnYF17MCAMXTNwOJ5cJW1prdh0WepuDFfwYo+TSjdTdlaC1a+N?=
 =?us-ascii?Q?JDaEU2HBtB46Nc2YSkjYn3rXfx30MzQMv9R404t2GK1nDm6KU5w/RUnxvzBp?=
 =?us-ascii?Q?j4VHUMOrrl0xtE4lHJeuonOdFIn9Jv1WSTWONqVZmoFlDttR+t5q2rATf1oU?=
 =?us-ascii?Q?ZjnmefPM9hXnkDCRQimas2gbTK6PKBLdru4c6mDn06koU8IWhHVS5FKEJtR+?=
 =?us-ascii?Q?mDmor/4zN/6Q8i0B9mmr54rFSW0AxmZnCwWmNWq+wYDEZbuLJfNKLL6Uex3G?=
 =?us-ascii?Q?ceSu0uMAD1aeJPaPNIpvZPEy7G4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363758b9-e1b8-4c88-28e5-08d9af59ec5a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 14:51:40.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ROsEP/JwG+mOykS8HK2Q8hzNu5PZ8/IH3eIq95cKlx2EkmfsQKK+ZRm+cdV3FUSfkW1qrXx1J0aeN1qX4d/4b3Qr7m1NYACVKEW6aJOgtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240083
X-Proofpoint-ORIG-GUID: akrlHRW3jLiGkuFyJ0tLAAHzXyyxSZL0
X-Proofpoint-GUID: akrlHRW3jLiGkuFyJ0tLAAHzXyyxSZL0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_kzalloc() function does not return error pointers, it returns
NULL on failure.

Fixes: 97961f78e8bc ("mailbox: imx: support i.MX8ULP S4 MU")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mailbox/imx-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index ffe36a6bef9e..544de2db6453 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -563,8 +563,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 		size = sizeof(struct imx_sc_rpc_msg_max);
 
 	priv->msg = devm_kzalloc(dev, size, GFP_KERNEL);
-	if (IS_ERR(priv->msg))
-		return PTR_ERR(priv->msg);
+	if (!priv->msg)
+		return -ENOMEM;
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
-- 
2.20.1

