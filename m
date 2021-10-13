Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAC42B358
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhJMDZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:25:20 -0400
Received: from mail-eopbgr1320107.outbound.protection.outlook.com ([40.107.132.107]:43648
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237098AbhJMDZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:25:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+GKGGDITVPANpmaARggUjaWX3l9few7be7vRgIfZBJF8ClJLH32VXmTrjZtBSVFtIfQlY1O4BmrYg1ZGX6GxSKY6Z87ULtic8Iq2GK+je0AWYwll+KOhVKPj31zOez1YJAJN/iZVnMVykPR7QWpLdzuWXHNB181oEoDxWB5CazrfJXbEU1De8f4e/WaH4LxNuEr4eREMmctzx1Pr+AceQ9saAnPnev50RY56hdACLwuAiup6ea0q+6Z1P/9vj1HcBJ7SCITpNsAX0sf6VIfXhRLz4q1P3ULof8nqofdGW4nb+xzu6NFC/+8BRHcHCafZBN0xwOg5doYSAGB2GobHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDMU/ZG7Zaqf6XBvWKKC0oNkHrOLg3jrsorE0ODmZZA=;
 b=AEHx+dnVSqPKhzslbCwty7wrJER4lHYWDjSrk+1QrkXqT+q6oOkrvQwmrPV+MCFsiSARq0xNCFsUMlp2F5v9UR5LJ4R+oFWBfXPX5mNUFJkyIsbZtS4EolWYRtTxpBPLZlK8UdjfRrMyP20gkjQXxLVb7EWBV9892OzUwMjhnb0gLmmTKlrZZHCYNHFF+bs6lUQcRGYbZg3ncr7BoQwUcggELv52EK7HtfGFLd6LszRU8gdgrvYUjl5tCAAs6eI6zCuGO51WF5zTht0IOKepE4nTtvpgtE5XBDvQ1CLstWdrS7lg8YsPtNzqWE75kWPKGnOMptyRf94O9eKRzvgQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDMU/ZG7Zaqf6XBvWKKC0oNkHrOLg3jrsorE0ODmZZA=;
 b=EM2Yq7jyOXhyzf5+Rbt2HIaTMZGdMJVp6b9nn7XGtZsN7YN4FE7eWIX6Qwz/i4nWokaaq6SB+e3Gu6Zw6eO4mQ6zLVobpiKC5yZ05fz0TlunTqoZk+nYxY77t13xRb7wyx5ajUIySkmK49rQBij9UKHeuoKtAFwr3uaQsEGNzF0=
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3387.apcprd06.prod.outlook.com (2603:1096:100:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Wed, 13 Oct
 2021 03:23:13 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:23:13 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] arm: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:22:56 -0700
Message-Id: <1634095380-3673-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.4 via Frontend Transport; Wed, 13 Oct 2021 03:23:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea71d7e1-5bca-408c-111e-08d98df8c9cb
X-MS-TrafficTypeDiagnostic: SL2PR06MB3387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3387F5A393C0E13FAE95C8FABDB79@SL2PR06MB3387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYMJaN+WBcPdzbwB/qyOAWiyE0JM+wMjkEkY47UG4lnh7yvFfYBaZKuJxz6wx+FHdTgJAkJembCflCfkYjlxe3pLXTEGWeQl1ReiYhmpfc2kP84MdybpY0GDwkxJ4QLISgYSy4jtofIEI1NgzG3TcMZN78WF8MGVVeUWAG5zObNHudFt1XXK3dPuXwtzXvrtXwr3iYxa+6JStEc80FNTJ19PeruH55EHeV03X/RVYYXFZQPNzmWiFmymQCTCPP9Eg4KCVaiomFVVdg09bCmj0lRcoRKSh/o+Wb20i9UuD7SNmEeABPRTzZ6pdk6cSuThp3pliGk1a6b3uk/P0Ll7pkqJJbP7TYAaAn8XplXS5kpTPyQRfKwKkDai/pucEQwE37K5FZGvVoduhyH/xdkPmeeFTLEF4jsNkYfKFzbkZYT4S3iTYs90Jkyf/YGhlZaEc2N8A1z1idOfQkPg4h27xOwtOPLAaXk4E89//087MUXFGe8NIG/bclePOx9JqBTKsRNj4WTDP70X5Fe9eXDjdmpgvviR9C/ktiMXJUYZPqiN7pdngxFNRvLhUVSHowOMC7fVRQ//4xHG+f4kVFTbpRxEKbk4R3b0Zb9wmx1kJY1XoVg5r3zIXO3uY3ruwDDfXbs7bxTy/OyBoEIQblXZU7NFluVG/ltisXRuTGgblXOogr0BwT6PhAYF27pmPXPEINx1AY1wHgQ6+2eECMW+Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(26005)(6486002)(316002)(38100700002)(5660300002)(66476007)(6666004)(83380400001)(4326008)(6506007)(38350700002)(66946007)(107886003)(508600001)(66556008)(2616005)(4744005)(8936002)(2906002)(52116002)(8676002)(6512007)(36756003)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUodiIrf5IkncrNumPXKS7qbxFe7dVO0hU2/sK+UdYwpMqYzs6/ldn68ZGQL?=
 =?us-ascii?Q?WIhsML89jr1YRKtmC9dOmSctmJxXjqX7Eafui8OMdbrn1dsSR2o2IdFjLl7Y?=
 =?us-ascii?Q?TVGWO+ljxLjmV7MngobCEJ9dT4/Ppt/GSNP+85raSpYFrlO9htuFTxtNNoNP?=
 =?us-ascii?Q?Lioqh4rRxUhC/tWazLE4vh2ksugWcC16hYpwN07F36Vhmg4LQrNdNWnoUC45?=
 =?us-ascii?Q?zBoNqI1yAV1v35DeCCGn2mpu0rkzM/W7fSwU3FiyoTG53Kt9r3lVvVXKxLNt?=
 =?us-ascii?Q?PxO7LaCMAVQSlSAVr29dr9qCWxzRA10j2BRV5qW8vLk31HLVJIRpgVe46Heg?=
 =?us-ascii?Q?sFQ7gfpwc/Ch+9SezxCnnnzTh/p8BNYHbplq6v0uYLFzKIHVaQszo+GLjK4x?=
 =?us-ascii?Q?9McxP5uwZ2RhBfBtkaSlwT5KlWtmQpjvGkUrYWyqBQH88z7A1bAHyqTFpb9Z?=
 =?us-ascii?Q?au0kpF/4eQXrA8IiyVrzxiWD0EahdzCu+V5kxC24tGb+Z3+A90kqyIL3n1As?=
 =?us-ascii?Q?DlKWKr2XAM6dAdz341VXVG4FG7k6w7rDbrv6ggxdKx9rZwwEodNrlY2WeudE?=
 =?us-ascii?Q?f3113J71Kx6oB0jV+SvSLETbWchrcOKJPozXuZUbYkVuHlyLBa/XEKp0BNM0?=
 =?us-ascii?Q?eOFvYQ8l1NdnaQrFc2ib45sbw/3bQCFSmgMs5wCt890rZBEFo4o11/ejLYgb?=
 =?us-ascii?Q?iHc7khHnOYmo0vVPc8g2qWulA6u1hScSA9/N27PMB+mNDXiFDl15UzzftYGp?=
 =?us-ascii?Q?YyK/fZ9l3Jjnk0mgF/h43bC1AU3A5XlOUjVWo+no3htRc9sGtxk+RwDisVl7?=
 =?us-ascii?Q?4FFw868vtKQtnqWqyKXt5XCHHw8kyDKaKa5Vy9uw2/Cci8YjGieTjwyO0p0Q?=
 =?us-ascii?Q?6bhPY4F42zJ9wcHrwlQsU9UNurOjeHrTmEPnM3wwupJOPrHUr/FkMxNGRLxF?=
 =?us-ascii?Q?cF0YLTrzWwQ08BthGoTvTTtEYwaZOd07G2qkNuyUDOMgfmXjCFBobmNnqxw+?=
 =?us-ascii?Q?i7Q0aCpzC6VI3J5trkee0gLVAvsmy28cLLWX3qxvGy7liwCSwKGHv/s7FtB4?=
 =?us-ascii?Q?fBtNIGu0cHjQKx3Xd9oFlP67GmRaVX/QfCI8fIrGyZwwVCEqPCMDXXZJWSdN?=
 =?us-ascii?Q?feBvnQ8GClZbPyBi8PW17SAa7a8xV0F+N76EAHM+/99xBK5tddPIvv45kxNm?=
 =?us-ascii?Q?zHtLU1V15IH2uuWQRQcnSCygIwlnP6BeGEfcmRpslkZdVBbEQBTMrCDIcKvc?=
 =?us-ascii?Q?oC8RDqtZXpI5oTmbQBVhi8No9mBlBkJhNlo/c1BC+ZSPdsS+8sgJQYy7+RkV?=
 =?us-ascii?Q?tpuzXy66fl6ZyZbvyW+PaeJv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea71d7e1-5bca-408c-111e-08d98df8c9cb
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:23:12.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNrjUTpkZBbI4Jfm3n5RAcGF5ubPL1FleXkTzXGP58d/SMtHhT2lNttvJADSSe9F4r0yNBN6F7xQL88zGbd1ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3387
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions:

WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefd..a9bd05b 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
 	struct l2x0_event_attribute *lattr;
 
 	lattr = container_of(attr, typeof(*lattr), attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+	return sysfs_emit(buf, "config=0x%x\n", lattr->config);
 }
 
 static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
-- 
2.7.4

