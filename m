Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3F43885E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJXKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 06:48:59 -0400
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:59456
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229861AbhJXKs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 06:48:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcuxsX1Pp+2c1m8UZAYI+ecEiG+Gjl/5BoBjuiXlNeF6kg/TCzzB/sg9eLsH2Co9ZUiESVa5HbizzMiptOy2RRHBILfi+atDqMMWvQudWIZdzn9sqXBS+KHOpTakccyqhpG/QOngjaaCUj83scyUNdZ4cUTGGkTQx+DTrkKppysJeCqaFrsEDYXEz6DLjK1rZEMLbgtBMhFHeOVc8tXwMdF7OHH1u7X50iXLuuiDxdtdAR+Kl6GlEKnqDdFrbqgLQhWg9jfZTsgUmqAyHXA2fX0QZCgXQ6uUHI1WbezLqAPQYQ+hFTO8ngP0piqE1VxDzt7cFvM64/e9VthNhwJ29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Dewy3dgB78l2PF/aeF/8sLTjjGMgHWyudSzx4NB4nc=;
 b=GU3Cy5GdP+AO22WPy0CLwRkF6TzP8NNICp7tOay+VKYUWeFMe3YiCo6ZaNxQk5hhasiVXTPHA94Pb5beHjLXfaWNRxsCwz67fvm1K7xoLFvjUYa6TCHU0dLrk1qNLiLTDQFAg2Nlk4SvGRcw60BhcP4Z0skOeM5uFiNnmoaVMT6Htudv9TD3YY524KvOtgBOq54+Rf0XLYQaLnh+oBQrYcP9H7nemVkMfgvoCtikdf7Jc8Js3hfnsD6/weYFLx6MGMcs0bwZBH+WyA8aFXm96bsF7SRUBgQmRM2YnvfL+vOnAEqSkVivr/XIeJug5FCAFZczgXyYPcm7nXa51jv7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dewy3dgB78l2PF/aeF/8sLTjjGMgHWyudSzx4NB4nc=;
 b=aEdsYw5dyTl/sMooEHKgud9agnWZiX+pAAFHMsbSGs6QvaRgfRKExY9GSiWLaRYF8HrcuPiuntyXKMZWscljprq6s8r5JKhi9PevaesiJBpOBFESyQlYLaiDSDnL9fOjqeR+M5neTZIqPKlfNomXImOWu8vQw0/1MBOl9pveO7Y=
Authentication-Results: perex.cz; dkim=none (message not signed)
 header.d=none;perex.cz; dmarc=none action=none header.from=connect.ust.hk;
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYAP286MB0121.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:803a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 10:46:36 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Sun, 24 Oct 2021
 10:46:36 +0000
From:   Chengfeng Ye <cyeaa@connect.ust.hk>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <cyeaa@connect.ust.hk>
Subject: [PATCH] sound/isa/gus: fix null pointer dereference on pointer block
Date:   Sun, 24 Oct 2021 03:46:11 -0700
Message-Id: <20211024104611.9919-1-cyeaa@connect.ust.hk>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b7::8)
MIME-Version: 1.0
Received: from ubuntu.localdomain (175.159.121.169) by HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 10:46:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5954bbb8-661b-4488-d946-08d996db8d06
X-MS-TrafficTypeDiagnostic: TYAP286MB0121:
X-Microsoft-Antispam-PRVS: <TYAP286MB01211B49DEDC95FEDBD573E48A829@TYAP286MB0121.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bl9f+MpZE2JpRXxQGWqppaDI1oI82UTOJuIsNfDH2waRVzsnuPUUG9azj++7IC0lG59ewH1Z3Nd7j7cH51MnYtTAaM1Mx/lbaur0cLnfOnHvZmWkTW2WmZJOZOOTdBa20FL+tgyxEf02DIHPzr+kqi/HB6GzVqrPBRB9iMjLbkH9vztt4yoYoiSFoZxtn1NJZFPslDqUMH9kFIpHTVjg4k/AKdKvEiD78vX1BI2lh1YptJq+fnj6uh0uqf1nNp4lEjIwdHZ+fOqpnCodytj/gRdt5ErJYqeEhi3RWWTJbHPYWmePrKSIMQ9rpPvVPKuVIalQBcMy3Yjq8EAN/hHyQXoftzS+ajQ0xqpqbz1C2W4Z+L52HgUH3A1JTRbICtpxUy1qiQtjY9LVy2P7lNRWvbrWvbSYdbz5D+bzF4rBSUwWTFuVZtkJuqckbRuMnLWjNPzBov4NXaqyw9mvvRhZnCTIymGnbXLv89Oyq/Z+vxKh58cOpUdjdHKzyAglApWHGpEi8xWwWIzICpmATeoGEZD8+jjBNPO6shbJMDnhZxCPobT0EkgbtlfLByoXWUWHa52kPJAbw+RNl5EPVBLY2fEw/jpA3cdZ/yWyYoeTIA813VLK0dVu9LDyQuNxmdZbUoZ4s4ub8mjfdjS8hxDUJ9V/PTZ2qRGVr1ckTz7kaU8b3UrWV87864x53VKSfs08aM6PmGOB82Z/MEniwemvSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(52116002)(38350700002)(86362001)(26005)(6486002)(508600001)(4326008)(786003)(66556008)(186003)(6512007)(4744005)(36756003)(316002)(2906002)(6506007)(5660300002)(8936002)(66946007)(107886003)(66476007)(2616005)(1076003)(6666004)(956004)(83380400001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WwLpxYRfGCkOceagcLi6xw+1Des1NGal02Qo+AweNfxmeGekojHVGPM8LfYG?=
 =?us-ascii?Q?t4/Otvyd6XO7wIBfDyVpVgmPULWnX0MXYAM98JYRNCXDtxPtgTs68h76m1u2?=
 =?us-ascii?Q?vifUv8N79AUJalOKz1/AUulCkjB99yCjBXiqVHbGyabFgwCdfNbO9lpaAMNi?=
 =?us-ascii?Q?beGNLBC2EMmqwtAoTBsxCwBjpmMoH+gi/G1plUzpr7BnNlqKfe5I7yDSPXix?=
 =?us-ascii?Q?vnv3zb8tdwEU0b2nkNjI7kjP2XjNbvsibOXkoYxPXb+aklC6/kB4CEfBfAMn?=
 =?us-ascii?Q?XAmOVdENwGc0KJCBTkNM/ciI2+FUfJiH85iV3P935Ws6N19vVOpLf9stJgCw?=
 =?us-ascii?Q?B0wXQtE+H7VJFuMRm/HsJI4HdcyVnJLnK3ZoCScTILx3EIFcXxOoo+2rz+ET?=
 =?us-ascii?Q?w3ZdhYlXZ/GTTtSas7Qaq13hkjTK654TL8b6QMdXwBhpcUDNp4UpNTlvtNzR?=
 =?us-ascii?Q?q0/8u8QyJ6ZzgJk5FS+Nd6alRuJtUAasD8mXpwzWv3VYzNHEzL13dZ3eECQy?=
 =?us-ascii?Q?3sZgAJ+Ii4JZ9Jr76Xk2dgF4wI+AJ6fjPmlkcA4m35l09Nux+VP5tDYCYslB?=
 =?us-ascii?Q?FzsvIqrCP1XFqTrTyl2g7/f6GBL+vTD/Tq4OGg2PN2bb6btdDFhYs6xWPirN?=
 =?us-ascii?Q?tUJ/NXKQbJG5DXRpbUD6f1YUpsc4xFwHgjmfoww1r34E895+J7vqHgHyWRLG?=
 =?us-ascii?Q?zQWv2SAyPvLSGak2IXs10CYi3xb9JcJno1jY5/z6LhWonp9j4G1C+gtu/eM8?=
 =?us-ascii?Q?K9JyfobPMlYG/6AbtBmW/A5DFPaEH5K2R4TwUjfZ2OrrOoQ6Gy967rGRFnqN?=
 =?us-ascii?Q?c1szqIVNjlXmQA2FHHykx6UfkFr1uQxxxIWlYPmOkkQ/Sj8OA7GQZtVbCi+W?=
 =?us-ascii?Q?oMD7UFkw9IoNs3Mum2yF+gPd+jGDgEoDUn8PBaXVau0oogWIFvpJA6suFI7m?=
 =?us-ascii?Q?c/s4lXNun1LTeWVxgmxL+tYT0Ogg3MKTokORJGsNWEkR36bp9Er7qA3bBcgn?=
 =?us-ascii?Q?L+R+O/PZ1VUD6JVau6h8vUoBCe6Db2OqbIRVZFLtAJnYUHunVEOg5Qjd3m6A?=
 =?us-ascii?Q?Lz3PUk9qfEzWHz8Dhu0dY12jxtl74R9MMZHkj9idySwqL38gENcLW75DaDhU?=
 =?us-ascii?Q?+91r75AdEdwu6SrMvttZv4mveyEM6evIiAOwA7Bz+honoIUk0hd2ycbdyJMw?=
 =?us-ascii?Q?odCU4gILaLl/g3NEyCdW9v2qJjGVPz+1hrVa2n9PKFSRVftIiSzXw5amNbrn?=
 =?us-ascii?Q?SilgCtWYrxtqfuuyptpUKPUoMvrOKqEPm2DSBJpSSPKKNW4WKIIctIDoH8W4?=
 =?us-ascii?Q?j7auB7eLpKiuPd+3ArICMFQJYDHoDmSfG/XfVqQiQev71IG4oUag5PjvWJE2?=
 =?us-ascii?Q?pudeKaregwRgh1yTVZG+cav8hmKzpc43ISJ2EupGrtULumQfVQzbkAHG7Zc6?=
 =?us-ascii?Q?vmyiBj9+EEZQfJzLCS2MTyMbb6MzdDcugRXBGRlOt6YTfz8yw3QEGT/Nx1UM?=
 =?us-ascii?Q?q9wvNxAhTxrQ/PfDrc2j4lyxLHNlNraMI9/96vzYP+PmWi31NfnPliXw+Cb3?=
 =?us-ascii?Q?faoZmh+RcPxpnSm6MojR0AGSl8SfJvHU3SfDOI1t2fSKtY8bxfiVU/q3d7fn?=
 =?us-ascii?Q?ptrRJ7zuFr/PDf1p8auGMiM=3D?=
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5954bbb8-661b-4488-d946-08d996db8d06
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 10:46:36.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdg7IOCTq+Gl6FkeXDiPfgEe2mpXF2tnWtTndboCL0WYK5ptuE9e0DDwlqwJ2dEwznKTfDsWnFB4VoKARihDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer block return from snd_gf1_dma_next_block could be
null, so there is a potential null pointer dereference issue.
Fix this by adding a null check before dereference.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
---
 sound/isa/gus/gus_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/isa/gus/gus_dma.c b/sound/isa/gus/gus_dma.c
index a1c770d826dd..6d664dd8dde0 100644
--- a/sound/isa/gus/gus_dma.c
+++ b/sound/isa/gus/gus_dma.c
@@ -126,6 +126,8 @@ static void snd_gf1_dma_interrupt(struct snd_gus_card * gus)
 	}
 	block = snd_gf1_dma_next_block(gus);
 	spin_unlock(&gus->dma_lock);
+	if (!block)
+		return;
 	snd_gf1_dma_program(gus, block->addr, block->buf_addr, block->count, (unsigned short) block->cmd);
 	kfree(block);
 #if 0
-- 
2.17.1

