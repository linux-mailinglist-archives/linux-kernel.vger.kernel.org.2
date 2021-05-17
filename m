Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20C0382AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhEQLXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:23:09 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:4657
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236528AbhEQLXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:23:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu7ZTRkX2fs9uP1x38tZg3xlV6h2CIh86Wz1tDK4TExm+7qVjQAfH/ihqdivkXrORKXajqZXvqZ4g0U0L25MRWnxLJpsQWhPAyOdcMxSmhl4eluUo2vb+iOp/6HXkKrgVWawDXcYF1h4IblQICY8rHSzhScbj/ob295IqMbjFDULWm3Hf5PMasVKxRF61Wfd0bCrD2TJ8y3UghQKCk7Mkgv/511l1CX+z7IH8+TwmeF6mX3BDaNJLVdCB15/gNL5YyDzOycAnP09c5/AGrVIbRnpeV8z79LQGK1I2Q87OeB+17Tyl8w8hMQPehr3vKV4IM6mfYMzYBdJCOC32tvYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwW92HBJU5WjrGe7Btqq0B/Cfc7JuiDDyJ4PvMDwULg=;
 b=nMtSpqvB0MIu1tRVBb2SAK0G1zACQZKOgdvnxHJdK9Ed+dlZlc9P433rsftCjyWU+7kc6/H13PaJhlMNFprKGinGcZ3HYzo5aLo4OuQtDWsFoH1hXoBP2eZt1WHhjJXQbxGbe//N8Um7KJKWHaV8JzjvnMfHhZ0RU/N+LqOje9jJY9IWtVG6Is5/lhu1sX0xUbjTFWGU+oP+h91FWmO5Iofk1EYEO5XMgV9/17SpNJufvKOP7xxs6/luHFqvpujVgk8JfuKVuYS1vQHV0tKa0PvXBrMRAfl/GFJVzBekLbpoNoB84d9Bgagm6v2zh77lEex5yECwieLti8HVOI4zPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwW92HBJU5WjrGe7Btqq0B/Cfc7JuiDDyJ4PvMDwULg=;
 b=PT6m3w0VzTeE1vXWw90wf1s8l0UX4C8lmID3Di47fZaM6cDd1LK8QzG5PAfCO10YnAKr+oeP/DKHT60PgpF4Pc5U3ZXUj/UaWmHOG0N7J1InnwLuBozYAQ0eShJMt++qVkJNFmXdQaEmwDytqSkN4LeFiUsl2tZLdwqkYDJAueY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6776.eurprd04.prod.outlook.com (2603:10a6:20b:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 11:21:47 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 11:21:47 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/5] mm: correct SECTION_SHIFT name in code comments
Date:   Mon, 17 May 2021 19:20:40 +0800
Message-Id: <20210517112044.233138-2-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517112044.233138-1-aisheng.dong@nxp.com>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0132.apcprd01.prod.exchangelabs.com (2603:1096:4:40::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 11:21:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86e53752-c17a-49d0-568f-08d91925f549
X-MS-TrafficTypeDiagnostic: AM7PR04MB6776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6776EA0E9E4E2E040CEC2EFE802D9@AM7PR04MB6776.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frxuYLbM5SH2XRzEdVeK2t+LUa85GFcVA/wfk2hKtIt2KnQammEBnRIcnekhDgCfXyRbrsYjxDFJY8T/rQVmVI5dMhLehW6X9fh0ru3kjtJ/szcA8pCHFTxIZ0hdgWAlGA5vk/0GzYZY0OJ+vhn+DpJJIDS1i+Y/hH9PkAgq2PE9QP3Ir/G0loicYAqI945ruclr/ou9GZB+Tgfxww8Etmm/dnVTCam43sii6iT/6ICHdNj+f+Xtyzb44sluj5nduEtGDQMY93ppFKpYYplxQnXCrt3TXBOV/JAmhY3UqXcKWxNkk2ovl8ihUKTWqJgnP/qM3wyfZFW/iM5HNv8HifSTKq1Geqz2xDikFtPkf+rQMIiL2U7ckYPSmInRgLasDgOV+OPuqp4fX9U8sv6yc77I1ioI/MyT1QQdhSTuQl+UJ+wJ4Qu9z8hJOeJiYjsGQm/fRivOic9UKWYXLEQMdj17RCBL5s82FlP71A2j0sLtv2Ko+XlJ7UpZVQm40qogibwyYQBqwyYTd/0LWzOsz0QgMJKSBRv9iYa2bhoYJNGqm1LHzUSKUJs9wWtgu9LkAhDFjJMAlk7lc7VrNOBf2M1Ajl6asHwEmUQkL1dV1tJEd7u/LMUz8yhoBQz8lV1YcxI9OUoPM4G9BtM2GSc+q2JhP/OH1V/gFHadTFtVbiX+ZPho3vwl8i+bxXbSnm8A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(6486002)(52116002)(54906003)(16526019)(66556008)(66476007)(2616005)(956004)(36756003)(8676002)(2906002)(5660300002)(186003)(6916009)(478600001)(8936002)(4326008)(26005)(1076003)(6506007)(83380400001)(38100700002)(38350700002)(66946007)(6512007)(6666004)(316002)(86362001)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n6ExkmGs+j+hgxt6IjW0fDSof6vev0+LpGk54SIVdMaXVfWqY8v7dZpWGlP7?=
 =?us-ascii?Q?YqkLswxHLaSOWE5wZNmmna2iGzgOy4MS7IGsk8/nLvhK2K/jxq2nEFFc54LL?=
 =?us-ascii?Q?zjZvhsCXIWtLHh1HkBWTvM9KTMRLErJ9DIwBOWCK3obz0uIktJJcEneEq2Y4?=
 =?us-ascii?Q?NB5xhCuYSzw5yj9XAMKFn+jzbAzjP48a95wuIVp1xxA/kdFrMNdsnTWGKe55?=
 =?us-ascii?Q?IwjRAFCRd0zPt9kB8W47hxx1tFApbgAY+QtEkNT2U6DT9AHHHu9awq9pW+J3?=
 =?us-ascii?Q?STL80MME8FJH+QvdYpgc6pi4N7f7JVwOpaMjZrpoetSgxZl/XcisrkfymY5B?=
 =?us-ascii?Q?mwgo7VxkTKxw5P+HQucjwT6taiZ4koA9JZnA++OR1P0pgu3Ek76gXJAbvfop?=
 =?us-ascii?Q?fX8uIVHkv4tbUTJpOLxBaV/Qcd9EJrKENrZ6PeV66qik6afH2PDQOxqx21Sz?=
 =?us-ascii?Q?8ca9tME8OzfOGh4+SmgrormoB15Ikbi8iIOjXGiVSE5Gbco4Hzt1GQ752v9U?=
 =?us-ascii?Q?REkdIEbgAwrXS/jiZvv6wHV3Gz0kTFbL60bqOoSUzQX5RRvXWROoVWu9sgZb?=
 =?us-ascii?Q?0TLkTT4n/ss7Ui7W/3jWjlFMMvrVsYD90GuDgnJhjcLfKRMYe23e3TEDDbR1?=
 =?us-ascii?Q?edtMRosoxRHb1qp/LWrfVB+y+Ci7gGk2dw6K4nALQf4C0HhB/1H6trJPYXff?=
 =?us-ascii?Q?xO8j6BPRzzfpabc5UoOEtr+/y7kTY82LesrF8YW7VHQtnJhrbuc1mry7jWo1?=
 =?us-ascii?Q?i2Iujm41DKjINxA3zffEaN/8AGKLJbKj1Cf1/gItvcFfebaftz6zHrbLZ/8l?=
 =?us-ascii?Q?rgIsPti5qkMq8zFiYPZ/dPYJ2AbvJKq9BxkmTToPYXmul/FlGdpNzfSdnYTt?=
 =?us-ascii?Q?JxcsGKl1z+oc5QZUyZZv2L55s9cshuicHBmK0zvhUN+3MFs/0hgjWHJYjbSS?=
 =?us-ascii?Q?DPk2ccpn+9Bxe0b8nMsRVCfq5Jy42OPXCgw6ia0CFuFjWLNk7zKAmi75Cwse?=
 =?us-ascii?Q?Dkp/M2AsJqP8F7nx1uPwJ/tbedc5U51DTc7RkTExaP/E5PawziolpLGnI6qj?=
 =?us-ascii?Q?GTDEoQ+MsUGviKqTpp0KbvcnrtmJuLm41GEHwx9ot4ZMRVfU5D9z8IrBqrts?=
 =?us-ascii?Q?izcGgGwCsBQ4nCHgke3BOO5qYi3bANG3rH8hbzYkoITIrxXhpxVBW17XxmwL?=
 =?us-ascii?Q?v41sNPzwW2h+MIfsWxygR5IIvc2GtGu4U3lgrj7odkY9VcOaefuFBioJ2f8l?=
 =?us-ascii?Q?nFJEMGDytI2NeTXwOCVo50OYK4dBjaOBCSqBvUaU4s0ShDmuEcuWI9pSmXMK?=
 =?us-ascii?Q?uEe1MR6PimWliGrJitvFsDko?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e53752-c17a-49d0-568f-08d91925f549
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 11:21:47.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6V1HzG2EK68nue8aH7x3sBCSSiwoepvqynfDVnIiQPp8HkQb9XcXM36vs3TL7FwKufJU5XiGdmY1aO6TWklP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually SECTIONS_SHIFT is used in the kernel code, fixed the code
comments. BTW, also moved the code comment to where it's defined.

Also fixed a checkpatch complain derived from the original code:
WARNING: please, no space before tabs
+ * SECTIONS_SHIFT    ^I^I#bits space required to store a section #$

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/linux/mmzone.h            | 2 --
 include/linux/page-flags-layout.h | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9cdc88d09f2b..fc23e36cb165 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1198,8 +1198,6 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 #ifdef CONFIG_SPARSEMEM
 
 /*
- * SECTION_SHIFT    		#bits space required to store a section #
- *
  * PA_SECTION_SHIFT		physical address to/from section number
  * PFN_SECTION_SHIFT		pfn to/from section number
  */
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index ef1e3e736e14..aff616855492 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -26,6 +26,9 @@
 
 #define ZONES_WIDTH		ZONES_SHIFT
 
+/*
+ * SECTIONS_SHIFT		#bits space required to store a section #
+ */
 #ifdef CONFIG_SPARSEMEM
 #include <asm/sparsemem.h>
 #define SECTIONS_SHIFT	(MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
-- 
2.25.1

