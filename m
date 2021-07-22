Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB77F3D2335
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhGVLgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:36:00 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:17178 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231724AbhGVLf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:35:56 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16MBxbXZ018417;
        Thu, 22 Jul 2021 05:15:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=PWxHI2Ndb0Bj4j1Ym7PtjhswsiefocKLzYiE4KYIp2I=;
 b=hLvAOckHKlNlgW50FleQArBAoS+rQ+XZ9t/eiWaO4kzeHcKmlzPl9/RE0zYgS/mrvIEv
 HyL5R6cgnWYWCLO3FJyizpMKYEt2r9nEDC6omVkYM975kzHizBc+2cPqGuob4IYnZj0X
 FeB/PwAMuzQB9L7lno7vFjIV0TDqcNwxdzoCm1zD/0UudLmRvqzSVRn+DqJgvZy8dp+z
 EHufOsAe0om8+Vb+/shvPnqmTN9+udCMKZK48f2fonmxeJpeafGRZHSUHWRrcdDRtIHn
 a5NBJaq2KukWmq6f9zoptYs3kOaS2bwkOflFGg3UMSaFjDSo7CJ3XPe99uMVaLRwX7Lo CA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by mx0a-0064b401.pphosted.com with ESMTP id 39y66p82vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 05:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LY21CcZE2YBxj7f8c4QHaivXL/f/FmHGZYjeTml1ngZ8ji6Y56fkbDFuRFEnFMZ0YQhp5OzDmbK0z1Svy0X+/dCWP9xQ7Fth992J6LnFWTuGAzR2jV9o0U6Yw1HCg0V3mcZ/nR9BXb39gujWdU/jHlwWrEzoKvGV0WEWuXbmcuo3gdlxGNDDXFyeTxHjRDBxK9PYP7g2yKcMQxH3gEkI4udCpsG6mLx4+Nb/HLLuXPBoVxhx9t1+mggFAVL/lPZMWo6RFZtJODKjBQ/wV61cJPZbj1So+MCx2r4V5vDGzeFfLOtB5auxdBRm0FWYN/GfBQwyZPmzPfM3/nOE95OmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWxHI2Ndb0Bj4j1Ym7PtjhswsiefocKLzYiE4KYIp2I=;
 b=FR5lGbAfXL1SC+plFjQLVfWSMv8T1Z0m0F7bHGncMNjwsr79SrjsFKtv++4AI8tXTJe77Rby5t8akReMkb2PaRbiGc4QRzqGjTW6VdXZePxs154ZErHe8+MXwxAJepsWg6lpO8gKfe+cnaSpy5/eZDySPh6c8CgiQ1p68KFw4GrqTMkqCvNmINgWKdOFwJkoTbeJtjzbz/vKOg4niyVVoYtmQm9c+fFNbjPLQF66qR0tDqzsmf1Sndi65YHjM/NlNrQovob2GjAeUSpR8ETxycXZ3i6WN444hIm5dkplI6PCkUUZbFFLtEfAVQmkUU26oBl7G1WEsAY4zIHN62Dprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1416.namprd11.prod.outlook.com (2603:10b6:903:2e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 12:15:54 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::def:cd0:ce93:8a7]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::def:cd0:ce93:8a7%7]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 12:15:54 +0000
From:   quanyang.wang@windriver.com
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Jungseung Lee <js07.lee@samsung.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] mtd: spi-nor: swp: fix unlock lower area failure
Date:   Thu, 22 Jul 2021 20:14:00 +0800
Message-Id: <20210722121400.171083-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 12:15:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d360a741-8034-4d47-03c6-08d94d0a73b3
X-MS-TrafficTypeDiagnostic: CY4PR11MB1416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB141624AD478BD562409540D4F0E49@CY4PR11MB1416.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AsbHfdEYX9vtGsRyQiG+wcWW7Q3u0HkAdFQObFRidjNwsudIpzOo+xvU+xiyoUOUwbLRPaoqpxKgaQ4dG/cVbnrNklkTsCEu1wWi4ZGrpG8qXMv0cpyLzzcguVmcNxSgujgQdH+AbacddvcR3qplCzqrcBYvpJjHoJQzhKQvoMxZF4Pe/ygh028MMjh02gRzzvhSmopkXPT+0mB9fXU2BQuonr2zVXcBPAvncl0DjZCyvnSi/L8NLnCdEPAoRUJyxxXFkj6rjBk/M7iPxlMYNg7yNJvv3J2y2EzJ8Q1JhXM1XssLV9VnFsEOfui/5fekM6zoxukHV01DVoa8EmC7zxWLZyex6MsVhU4KSrqEdd9aok29ssJy//wwtpQ/xsxHKpBYmlJ/+7o4s9q/VTZznnx+PC+nfUr/Ymi0eGWc69fMP7od/MABoryoJ9QsUyKgU3ebulVJxjHpdgyOhfX6uakhQkpRODJwgqMaWXHw46WHX0TPoPilM7bx7ZsbYfN/p6vwPGeK71JQfu/iNEzNpG7Ol9WpjP92mDdmGxMMov6YZJhIfJnpQlFPiS6Cbd65EoqGFZwM/cD4zByfOym44O/cZI8iez7WlGBYiVl/N999uAeptZjmvCHh5ArcQNhpb7YEe0EMCgFDC3qsvLLWqiC3LTAhjayT8+zQXWHlajJ5cqfu4GNgaGECuVN5MfrWSTyZR7xLo3bPBHEzUKr7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(86362001)(6506007)(6512007)(9686003)(66946007)(2906002)(110136005)(36756003)(2616005)(6486002)(54906003)(4326008)(52116002)(478600001)(38100700002)(8676002)(186003)(66556008)(956004)(66476007)(316002)(107886003)(1076003)(5660300002)(83380400001)(38350700002)(26005)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lw5XU/b7ai6aLtkjfvP5tzTFSb3B6/vcrIwEBxI1PRSd46Z5rcfaS4snA5Me?=
 =?us-ascii?Q?Gn6bFy4Eg8FVkoe52DPZdNYTU2plwU8Q7HS9PQefrWUZFn9/NFRl0uJQjgYO?=
 =?us-ascii?Q?p4F1oNES1675xajs46E0rrtMEpCv1FVkYEgGBVVPTJfetSyeSqbN6HA0z6Sz?=
 =?us-ascii?Q?gQQiuWa1yPU/bdk9ec/34lbQtSZbWDxeIAXSUeQGzTfWj/YUIXROq6YuF0Vb?=
 =?us-ascii?Q?7oku20M04Uu4kmlD/8hxNAIHLCi2vEoB0YnA7yC0nUf1LRtOY/O7L2bVoR3X?=
 =?us-ascii?Q?SbjUkwc0r/Y7ILR/wglnI4rKfICz3Y4oNfcf0OaX5nVgWkPkHaGiYl1SyUd5?=
 =?us-ascii?Q?Nzie9W7vOVM9QYbl2Rw7k5P5+jX2vZyjInZqX2C5fgX6e+W3QOV/NS2ssC1p?=
 =?us-ascii?Q?Z1VYR3pf6y0nUXjtMEc8srMR3suqpeOu2w/zMGvZxBB1LD6ZWokgIZ1JoXQI?=
 =?us-ascii?Q?hF+kZolALM71f2LOCGM+tLidWZIQ/NQlGC+GBwf06m8zl7szEX5E5o2DJLaU?=
 =?us-ascii?Q?tIYS4OzvC7G4DcmVVSCR/U+OEW9Zd3SUyQxtp96KOe9IKrDLcm8YJ7bjfSuD?=
 =?us-ascii?Q?L6WrfTiDVK2IQCsr3aszLlFOW//08sD0k7DIusNnOhJw/cD2z8PsKmjRmR/b?=
 =?us-ascii?Q?IrcvmmWzhxdS2dLyVPEknPzPVE9AcwZ88yPN5U2LjNWMYj59RAgBEnc4qkdu?=
 =?us-ascii?Q?/wVvpHU4y5pOw59sVvR3wm2hWo5/lc+l73h7WLfwkEo8dunvUo1OIBEg9ouL?=
 =?us-ascii?Q?8SKu+TL3yMUArd0CsovhGZl4x1weKJVI/9gEoFD9VTck73U8/2hZJEIMkq86?=
 =?us-ascii?Q?yxPLoWvhL5U2D7bde3P61EU3I5sq3kpu+R1CaavEg6WYcqtw3rCFEokJYnYK?=
 =?us-ascii?Q?G73d70Q9Qe0adD2UpxQUSo4g/B32n2KcRxRm6QLXq5Bu6M9EQNZMsfe/xRvd?=
 =?us-ascii?Q?joLAsa+4pjzPen3wtA7SF/vIs+9l3y7ansMuEDqHFVZARjwh2eZCqdr2EuHj?=
 =?us-ascii?Q?W1ti2Qtgx5uBWHmKuWyx6besxeYkbwT2epl4s7a4FSSgHGRZEXfCjq8awlOi?=
 =?us-ascii?Q?ds7ETuB+R2zvmbt1cS7VQFLmHRoiWnjtXsIlwFZXFhIj2Lm2ym82vRO54ngh?=
 =?us-ascii?Q?x1lqNwleuSugcO6LpFsOIiVx+aUEBjfRXxxH+4EZNwO3V9XDZObl1+16UFx9?=
 =?us-ascii?Q?cIOT2cC7tZxD0Djust7A5ROlD+fZuCpbFIDwK5s+NRVU6s2x8z/CiRKJIeVd?=
 =?us-ascii?Q?eKmUmnNLiqmqR6Jsr6xnA4/AlxBYI5m7++oTIhtN9/3dWNXl0w3o2IdwiQk1?=
 =?us-ascii?Q?I8UmPHVfMw0H8AMEz3bi+VGs?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d360a741-8034-4d47-03c6-08d94d0a73b3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 12:15:53.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBa0pMcfcU5TUUxcDXBn8WK3X74qaAUihGi7huL7jnbxVVqJEG9w8g8W/OCqsYBl4Wwgk66Ld5eiC33V8ro+XFZ/aLXKBHZkPaewwuyeyNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1416
X-Proofpoint-GUID: Is6T1y080BOkmipCHa2ecNZaFa5eZjls
X-Proofpoint-ORIG-GUID: Is6T1y080BOkmipCHa2ecNZaFa5eZjls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-07-22_04,2021-07-22_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

In the function spi_nor_sr_unlock, the variables "can_be_top" and
"can_be_bottom" determine how to calculate the value of "lock_len".

When we try to unlock a locked region in the lower area of flash,
the variables "can_be_top" and "can_be_bottom" may be all true and
this is not right because for this case "lock_len" is only "ofs"
but not "mtd->size - (ofs + len)".

So introduce spi_nor_is_lower_area() to check if the area to be
unlocked is in the lower and use it to exclude "can_be_top".

It's similar to spi_nor_is_upper_area() which is used to exclude
"can_be_bottom".

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/mtd/spi-nor/swp.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 63512ff3b184..3214b644f093 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -118,6 +118,26 @@ static bool spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs,
 	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, false);
 }
 
+static bool spi_nor_is_lower_area(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (nor->flags & SNOR_F_HAS_SR_TB)
+		return ((ofs + len) <= (mtd->size >> 1));
+	else
+		return false;
+}
+
+static bool spi_nor_is_upper_area(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+
+	if ((nor->flags & SNOR_F_HAS_SR_TB))
+		return (ofs >= (mtd->size >> 1));
+	else
+		return true;
+}
+
 /*
  * Lock a region of the flash. Compatible with ST Micro and similar flash.
  * Supports the block protection bits BP{0,1,2}/BP{0,1,2,3} in the status
@@ -259,12 +279,13 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 		return 0;
 
 	/* If anything below us is locked, we can't use 'top' protection */
-	if (!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old))
+	if ((!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old)) ||
+				    spi_nor_is_lower_area(nor, ofs, len))
 		can_be_top = false;
 
 	/* If anything above us is locked, we can't use 'bottom' protection */
 	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				    status_old))
+				    status_old) || spi_nor_is_upper_area(nor, ofs, len))
 		can_be_bottom = false;
 
 	if (!can_be_bottom && !can_be_top)
-- 
2.25.1

