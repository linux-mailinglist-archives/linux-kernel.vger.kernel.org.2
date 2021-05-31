Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCCB3957F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhEaJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:22:13 -0400
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:65229
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230400AbhEaJVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:21:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyBL3TIlHuzKh7skByJgCh/fNTKm6figAyiAqVAcH/OU+7UtOuilfwL4TRMuAUJJ8cETLZGQOJ2n32EHtWRuzd6zOKs8w1EdOQi8VMC+XSlpxYkZj2UYzdi/CThfVld4l66+/uHe2WNYzcjrieIBA39UIFHF7kiguBlMV8h3a4+VlI52B2TxslLTMCQfkuF1k+domLNEpKlS9H5yiJkyznmEp3LEUTJW4dIymH1w46tplVOGNOxsYwMJutEa2XPJKQbHmlsuzCpmU9jCG07IS2NH/moCVU+AEjWam9huq70rYI5OI33uqBfuNaF4WtWB1fcbJ5muT5sxXoeE/0Wb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPv1wRI9XvEkhRLDXXnfrp6emKshJq8Undcr82BiBt0=;
 b=C6AvsUGVXCQ9FPIfcOQTBpJaKL6wk0Gp95MkpopMsTt45piI/cDKTwzyYwebaafsUZ9UF4qNGYkvIT3r1/upX4ojLD47YjpWRTwYZpvOGzhZDC8h/8DeVMI7kPkpMK+JsIBvLsL/EAOI+TaRaVZfUhuIhhInk0fDV0X6q7w8wwCkLvm4IKl3d4KEv8n4NSHYi8cBoh+ef7UDzjBJ2jifBXtn1VuJenQvNolPayMSDQ8IAv9GJTPQnPEp3qthrXJgsfSmqvEUJhQmi6f7E2vyu5wKXBPtYut9IL2EGZGFK9s511wwhlcMQLs41GSXcIqXDTB3hwNmpv6uFbnBosMbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPv1wRI9XvEkhRLDXXnfrp6emKshJq8Undcr82BiBt0=;
 b=GVKyq5tQ7i1i9n/iOmPlHIohRf5FGwQfm+jF72BMu3kqvuAikvGkgwQZB5Q4+5hx/lYlT73/b5Y9Q5nvlFKGnhdXcVOcXtA+EkGYUK9Efy4s6E4yWX/ifNeJsjOUYQUJzBy4tn/35SLmV1mCyoQ7MRiftRrWZCCyloPk38Xm4ro=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 09:20:12 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:20:12 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH V2 1/6] mm: drop SECTION_SHIFT in code comments
Date:   Mon, 31 May 2021 17:19:03 +0800
Message-Id: <20210531091908.1738465-2-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531091908.1738465-1-aisheng.dong@nxp.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0157.apcprd01.prod.exchangelabs.com (2603:1096:4:28::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:20:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78674a51-0f01-46b1-d421-08d924154ae0
X-MS-TrafficTypeDiagnostic: DU2PR04MB8599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB85995E8524CDAC0732149115803F9@DU2PR04MB8599.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9Rguln8CSazijC159nm1ftMbL/z0IIXzfwL0nJy1lnA4/4XEOHlfmB5dTBqU5QqJgJwUmmTvYlz8stp/4JITA0g/lMOQe+lE5NxZj59OFUmuWe6jUEkafjyXieNlibXyBdSpv6b+ZQR8eCWYHNMUrXfIl/Hblo2hEZv4Cq4DqK5hp6cq/ROkYAiGW2FfPp+8gnj9qqA579ZYm7PWHulONhALj24WRYC+tHouMWwUfZV7eaxflLHsTyY6t5Fmiw6CkPiw1KKjFqhKzl/6cF7in384uFTD8LlXSV/ZfovWGrRnq3lqjmveRJxWtl2XdREHTEwyDGC9SbXp8mWTojEAF1vQizUKY605dPtovoQlurq1h337ceKxvtTk6Zr8at3Q5RZsmuzbom9ipgXAQ7c/BqQ05n8UjrEmdVr9er/3m4ye93SayVEtM/YM7oOxW199Fd9rhbhzRGoGLcHUejXZbdsp6+/6AblI/aAN+CrL6uUkXh/jVuobI+0vCnGstD51sItGSe5NClI2zivjm9/lJmZfvriyeChIQN/MS6WFMJqfRxiQn/1zFaAl9WvylCTXUE9onrATLMwK6FWFCodFhnyZo7DSVloLOYBSP8mD6asOmdkMOT/TuCoiOe3BLNaTvdC2Qm9Uf1X+d3xyZHE7neI3NWoJ+Zo+/wHRpQPdBHXKZ9uS4BiR57GAVnMeaXd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(478600001)(83380400001)(86362001)(6666004)(36756003)(38350700002)(38100700002)(8676002)(8936002)(4326008)(2616005)(6512007)(6506007)(5660300002)(1076003)(52116002)(16526019)(66946007)(2906002)(186003)(66476007)(66556008)(6486002)(316002)(956004)(54906003)(26005)(6916009)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DyzCS5b77UJSfd03emwpw2gXJNerJQ6DiH2+QEpU4bv0Z/EBIcFYjUZRZs6Z?=
 =?us-ascii?Q?PleW9Dq+kwiQd9aB3w/ouxx06JYxSrkSsgWEwMi/4D4jbpwQxWYKfVFotxQR?=
 =?us-ascii?Q?gu53kCu0jQI/hl+v6XKbfRDa/HMGsKGD5JEZFRoekN+VO1/35g72VKSca/bE?=
 =?us-ascii?Q?ZuZhFQM6vhQOJuKLPTQWNltYwjLv4FQkI9/W8b6lII1lPwDSpYIFk7CU6Ln8?=
 =?us-ascii?Q?I62gAbkqYhQtdbGiTvTHR5QCqeZFfS/X3oXwXfQjNwzv5eZ54uPRGRAnS7Zh?=
 =?us-ascii?Q?bfzyyBMgehbnBI17qGqx4VZEyicDHRJQEOLvVOqk0niR2vje6l7BxRIHdCnJ?=
 =?us-ascii?Q?9C6SjtnYydt4fA/nUgBVAXLhw1wcjxvKZuwMKJp7HsOi9Xl363cxIzX9499i?=
 =?us-ascii?Q?W7GCz+YLbjcOcL56LP1ZUUowAFZA5Gk6D4YNGwLf0bZZYk2408+Ykj6wOmA4?=
 =?us-ascii?Q?7OH6ctKeSSFyxpOmt5Rs8hs0qfxn1kHWsBEOFnkSUuVgU2It99mEe7+woMVN?=
 =?us-ascii?Q?+Zw5HjHjM9j8G6ZYUNfjOp55Hu5rxzdM5MO+KeYXZvK3qyGNckQTZF96M93Z?=
 =?us-ascii?Q?huCC/NW+pHOc5EqDGZvlw8a/gdXjIB9lDuWqDj5Yl4oySRk+H2j134akiB5k?=
 =?us-ascii?Q?tLrvEJcgmMc5dVP4nsMgfPh8X3BlPPXzjghzglUIELA1MS/51h3/MQBbIp3J?=
 =?us-ascii?Q?R21q2rbntybbcazw8V7K+LYwF6zdUtDHhX9Ud6jlK+qG9hfYM8OKeQ291ObY?=
 =?us-ascii?Q?fNXAcyubwM//uSD5N3N0keBBStVPtDd0OZJC08tM0unBnpnRUfBRVerAZ0aj?=
 =?us-ascii?Q?/gG6nTvSJNq2QtLailyN/bOW0bJkEtnT6UOknIwrOZR+rEtpEvpydHC7OrqO?=
 =?us-ascii?Q?yz6jZeh0JL/RtI4YnOzgqbv5iT2sVJ0z3o9P0s0AeSXpqSsj8iFi9B389OnN?=
 =?us-ascii?Q?z6aprnlk3MpBxRiLVIYsGjggLi7TrdSmqBSC+M68D8zCYINcp1M5TIVdAlkJ?=
 =?us-ascii?Q?TRe8QvVPPcR7BzVDDcHvPRvPUnqqp+M5Xiy+LnGOBngf4Y5zWuxUBqCHcC7s?=
 =?us-ascii?Q?zfTl5ES/haeI1T3dgcqrAmIoC0w8Et2MztuojHSWkse4vawTt++BpbsZlPYL?=
 =?us-ascii?Q?79/hq7FtjabP3Y+IRuu+PxKF/3r4LAPh/ZdGJ8e9eXVIcvpLm1HXU6fOwmxO?=
 =?us-ascii?Q?WkuWsLTsWz8FEWCkBtmGXCfbLK2Om/ifqqCwZ5CWngduT3PyuOvwOnlROG8m?=
 =?us-ascii?Q?P2o8MDGlnjxVkDjXHrLDUirklNYgy4xASa6rt5HM2q2cr4aN5CMCErM5YvjA?=
 =?us-ascii?Q?F3RH3aXWeQv9ccnMSwVIikNf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78674a51-0f01-46b1-d421-08d924154ae0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:20:12.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JoRx4JY6/IEOPTx4wyf6vd1I0m3Prq7U6YISdX6gFWoa8soJ3/hqvduU9DtGj3u+W8MFOWCyrEloW1ySb7mOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually SECTIONS_SHIFT is used in the kernel code, so the code
comments is strictly incorrect. And since
commit bbeae5b05ef6 ("mm: move page flags layout to separate header"),
SECTIONS_SHIFT definition has been moved to include/linux/page-flags-layout.h,
since code itself looks quite straighforward, instead of moving
the code comment into the new place as well, we just simply remove it.

This also fixed a checkpatch complain derived from the original code:
WARNING: please, no space before tabs
+ * SECTIONS_SHIFT    ^I^I#bits space required to store a section #$

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Changelog:
v1->v2:
 * drop the SECTION_SHIFT code comments instead of moving it
---
 include/linux/mmzone.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 05cbcddbf432..a6bfde85ddb0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1203,8 +1203,6 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 #ifdef CONFIG_SPARSEMEM
 
 /*
- * SECTION_SHIFT    		#bits space required to store a section #
- *
  * PA_SECTION_SHIFT		physical address to/from section number
  * PFN_SECTION_SHIFT		pfn to/from section number
  */
-- 
2.25.1

