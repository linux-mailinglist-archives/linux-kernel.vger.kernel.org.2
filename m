Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D763F705A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbhHYH0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:26:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1818 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238677AbhHYHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:25:52 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P4JUf2015024;
        Wed, 25 Aug 2021 07:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=7y6HS730loG1mEgNVjdx+a8DCIlkpiq6aAoKhves8LI=;
 b=ahDN9w8yGo4OCXfBf+frrlB2+FH3Hh1WOOUnyLRsLGNcAty12QZ/PSkxFcmmVzB6DohS
 I2HSbJjDoC/S8xiOBmxVWMToEBMCm7wkso9nxqGSo8iUmcKXBskEXwI5yFEgLQOlW+kM
 mPNNtIS9q23kLCQNzD62uW7n9ZcFAbttywVET8GVajs4mZgLQ8bCm3bMTlDPleY3cljm
 uYPpTbFAFsRkL05IHDgg1TKzHe/NpYkvpa0E9QB/nG7zmNSumvQ0476QCQ3x+Wmhb83L
 2/xCkem9dT0js2RNzDVp0lJyoZOz3JjxQB3ubiwWaJ/KkDDti+jMF5fsNRXncfJLCVku DA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=7y6HS730loG1mEgNVjdx+a8DCIlkpiq6aAoKhves8LI=;
 b=jsGD32lRbqp/kuGnj/VZQ4VM8ZaNWc0Joh6XRivOIAPbRB+oUQwiaf9IhKUKpjFWii74
 G1JiupcwjSitFy2T+uD8oUknyxQgNSYHlkI/lL8iavdcBPIXrO24jwJsQoAkvrjxumtS
 h1HYJ/dzlmEJjC555q0Y2prR3bt9zVNTwZACMWd4tiNMblmdibxknpRUPtbiu+VSCvJ7
 FD0sls0uIbm+NLyeBL+7hVS9lAV2aKaLg6skYXQnv8xr339PCNCt99gornZg7DQbQMj3
 REFuoC/0xqi+EkwQCouwC18LWFKlXIZqcODAV4fv1q/pwYTwJtteTmbNgVGDfW2MVb9a mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6jmtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 07:24:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P7FHZ1020004;
        Wed, 25 Aug 2021 07:24:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3ajsa6rngb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 07:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8L14y8VaJDbrUasng82Rs8PAPP29iECrFo8DRbpV/2Y7RJ/ZWWT2qoHHhuLiS9i0QMF6gWiOqdHNF0u99+D75M9mpv27I+V5dSGlXZmR47Hc1wIFeYT7j4yhHLeDPX+qSAN/FFBJsO7OThdqVET5GfASVWQvVhV8Hz4rA5LO1lzKNau3hb92YUnUvYcrDvxsNwSJxDETlVpOqjv3xt6fRP5VDZFpMccCT53SzsawpTxGlPPowSBURV1fs2t5gZJwoAJTKC35SAHMgVRSmCEQT8+9mDDBNKIPw8QnMaKExMcpd3J2/YKB8ZW8JDA2MSkhk6VC4zfcX0bYHqiw8t4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y6HS730loG1mEgNVjdx+a8DCIlkpiq6aAoKhves8LI=;
 b=DFD5e9W2pP0vSTorosIi3X/T0OZAUNR4laI4relkPR/W7XeRyqU6552gIciwE3IQmDlUzlun9arcvQ/7ZiK9OtLtB5fNrYuyhR4ezVt1L0V50byjWZ+PRrkPshrCIIizn7bFGSyyO7gqocDIpQXXjjq5DpoirlB5vo8cmwue44D9M+dlzKoYMhQKVNNAM1n3lks7pHbT1i5d2o3g4MCjMWcKq/h/PNE9UloMmZPQNCDmvcrvTllPc4w49WFP8xJWZVxHZOyvuHcq3YGbhhMn9T6zoDnm4Zb4mjSDYvmEBUF7XNhKrsX+Dvu0Mz2uCDzx/jKQ0jZSvwM0HLiZqYLL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y6HS730loG1mEgNVjdx+a8DCIlkpiq6aAoKhves8LI=;
 b=uIu8VpORVA1dOrLN5eOnyRSthayU1gdg2MXpYcTncJyU/b2XEq984hr/s7ErCNJ10OKdFX31zrCaNAsLBQDHFDnj7D1AttmGCkMZRinwDs3uR3cYIfLecBqR08FxFK8Ia9oxc6j9yQYEpJ4S3NBeCpJY2qRnD2aNW/Kg6wkx4zM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2096.namprd10.prod.outlook.com
 (2603:10b6:301:2c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 07:24:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 07:24:50 +0000
Date:   Wed, 25 Aug 2021 10:24:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mxser: use semi-colons instead of commas
Message-ID: <20210825072435.GB13013@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO2P265CA0375.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by LO2P265CA0375.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 07:24:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d2bc46-1084-47e1-f76a-08d967996d06
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2096E4B7810C2A207210E4F98EC69@MWHPR1001MB2096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oups4NC2e1tebJQFqyT2eOAp1fhQ1Vl4FJJXl1q3PdFvQ+zQGNta0EPYg7ebkjRwwF1vW/aBbCGeXLxCq8JiNuO9iep1/LRHc0I+m+ITLfFkfr+Zdf/pVBC71w9FQmbx0UNl8LkR9JbT/ogEyWaHb3WN+//EUyQWjMO7hthyoeq14UTPKcZWTTWzMt6lKN842IGNUata1LQWhF7cme7NZuUXtPzvW1GNaGnsYT8OWMBltQfoaWuol48X11ldOan4XEb2el6K3nzocG3YLSdgs9MkjyDUvsHtjME/TM7eBjhUz6tvQ0+O4u8m7ZlP/MJxth+bIabPWVXILqbXpvO5DnicyAigv0YiRVB3pw8NPjuMhFnoTfiaP3h3VLVEX1O/a4cReIMWJe1DqN+Ilt2Zq6Hd2dQ+ZwlUkvOD21x936Cq74uy6ssvy18Wh2B02fi2BFqq0gKElgZ5Vfj33EeSA75zrd3LhuGcGnlp/WbXSNhDm7Ts+II55m9CZBpL6esgzPtgqQTQle1K3a3c4wm6hJMggWTQ43SYXMeVezYxqTDcEB8EhqaQBzxZLw0Iqr0PY2KZGSckhRis7UWETNy3p00cExIjZDUMMDhh4/2piOvYSfjkrMS5G7+0l8rVlBELE+LOpKrGN+gYjBHGyuZ5VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39860400002)(478600001)(66476007)(66556008)(6666004)(186003)(33656002)(54906003)(86362001)(8676002)(38100700002)(9686003)(83380400001)(5660300002)(8936002)(33716001)(66946007)(9576002)(6916009)(55016002)(1076003)(4326008)(6496006)(44832011)(316002)(7416002)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iz/wnWN7HT3U/dyR6KjnJY9A+bqq50CHJ3wpch9UtfrgQeaSgXWWo8xCPQhm?=
 =?us-ascii?Q?fMJda+lHT/gAyM+DhbOGK8/oHmxsKrRbh9hJ3bzIDz/+n93xGQ3ycMlnTxKC?=
 =?us-ascii?Q?KM7bCLdRBwvIkkl1Q3Z4UBr6KN3C5adfpa8opBnokhTilY6E4VhvN4aSUx3S?=
 =?us-ascii?Q?+Hm+H/9Cw0Dm2jz2nWF3WlFltYjyl5R35XLkvJzE/eN10hwp6bM2lHxkV51N?=
 =?us-ascii?Q?TqwLGJd8HoSpcfiOKa+utQI8TEFKwWypM+tivN4LVnJbBSlUbxwZp8qoMvkk?=
 =?us-ascii?Q?54u+AMEyQcvhK/XctR33X1dY2eH02MKK1S14hdSCsIk9m0GIF7dEaoQMCjN6?=
 =?us-ascii?Q?uUNzLrG1ktu2iisvCYDN3OBfeDAUeDJuuvZO+n6Ld1zDB2hHnZsg242rJrcr?=
 =?us-ascii?Q?sJD/64C2YDr/ZpjOea03LdMjUQU3fP/HeAwymxRF8pbGpy8qHGGvH29IPczT?=
 =?us-ascii?Q?kg1tWwX7xuhV/gENatWrhWTf2WLk0NWCZ3JTZDK69l1mJx29THekftU66B0P?=
 =?us-ascii?Q?F906MJiIUzTFYEffbyfKyWBSW3f+L34JErAgWA8NpX68NwyQB45wxcDANe77?=
 =?us-ascii?Q?+94+OopuYRMhDGkds9qmQYO5ZW158/tCY7lB9Js0ndgsFxBS/3uo8z0qbaap?=
 =?us-ascii?Q?lO7monfPuGvQwyXLMk4j34Y4TkdV7Ur7WoYEsSQcdnuD/2eqIYsiHWABGVPz?=
 =?us-ascii?Q?tVjP8/g7//chMjMkGrzhv8vN2xjcZVs5m7sx8JafRJElFzKVGIxwDpgSJxJo?=
 =?us-ascii?Q?TwTT63NG74l+Te+NKTubKJp2KTDfCNlkCTGKj/2t+8yRKSI9btIUWDQPevn2?=
 =?us-ascii?Q?X9b5t52wgJ94kvdve2Ko4Ash/0443UiI2t6VbfohxDIbIHarzQ1Y1Tn8YAoG?=
 =?us-ascii?Q?V8D+BUVYEqelSaFgjDzAi+tRLY8BWmtOlLCJphHTEZLMhnP2drsHfCGGc0i0?=
 =?us-ascii?Q?kMBxJD7tDzItiEbaLM9/ra9DnvA7deZrZuH1hb38QTXhkFqlD00isdUtkrd8?=
 =?us-ascii?Q?i4hrv8i2ej+kqbDxc5BfsunRAas3N4hdOGX9t3tTbj9gfjdPO8E962rHAkVr?=
 =?us-ascii?Q?u2ZXub+5Oj2UZos8o94UXwaYhSShvEuNpisraaBguS0rwLxOCVzK3NDylGnr?=
 =?us-ascii?Q?P+TAPafGmnKjcHygRPfjr03cYzBNTOgEeC7keUitQw6jl4xoVWVXs+VoQCpR?=
 =?us-ascii?Q?WMj9VKJT7vkNDAeKO7gIueEExL3qNimVAme1V2eL1liFh2t9Ul0SteWZsf2L?=
 =?us-ascii?Q?02q6eFk+7C3wQyAPNLAQA7GfOAVUQeGPKyYiT4P/Iwk50/WAMJ43o0Fxks+8?=
 =?us-ascii?Q?j87rdL39Yg0bRNgzdxd3Zecbnugo9U+Lk4kf1xIfw3sVYt2nUecHjuD6RUxf?=
 =?us-ascii?Q?kutVK1M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d2bc46-1084-47e1-f76a-08d967996d06
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 07:24:50.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDvKo1Pvrw3Use0NbtEY4zct0tyU7eOMHjIoW8EX0dW08dOQ88dAZXKPCYrbSoxq/CYIHhDp/88jrJoY6vN8Q6qzKiCmGtd0sxHuubxrdfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2096
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250043
X-Proofpoint-ORIG-GUID: 71R97Xx3OeRH-BnnRnJsCpa9b6MWYiuF
X-Proofpoint-GUID: 71R97Xx3OeRH-BnnRnJsCpa9b6MWYiuF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code works, but it's cleaner to use semi-colons at the end of
a statement instead of a comma.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tty/mxser.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 335e4e50d679..1216f3985e18 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1039,12 +1039,12 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 	if (closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		closing_wait = jiffies_to_msecs(closing_wait) / 10;
 
-	ss->type = info->type,
-	ss->line = tty->index,
-	ss->port = info->ioaddr,
-	ss->irq = info->board->irq,
-	ss->flags = info->port.flags,
-	ss->baud_base = MXSER_BAUD_BASE,
+	ss->type = info->type;
+	ss->line = tty->index;
+	ss->port = info->ioaddr;
+	ss->irq = info->board->irq;
+	ss->flags = info->port.flags;
+	ss->baud_base = MXSER_BAUD_BASE;
 	ss->close_delay = close_delay;
 	ss->closing_wait = closing_wait;
 	ss->custom_divisor = MXSER_CUSTOM_DIVISOR,
-- 
2.20.1

