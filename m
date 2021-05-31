Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192DC395800
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhEaJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:22:27 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:39493
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230397AbhEaJWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:22:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lnvrx3ZEMnnzzZ78kgtqVSKrytVdVn2N/T1Nl+xZ35Cdw14RwWzZWymMoc17tNkg2yct08tBZ52AFC+CJ2bEThiZOKhY872IaWM7KBHa/V5qNfMVWWUAK8NyVPi/OcBX8aspEUtol0VZQB2PZT/nAkzUnPuPIySajn2vAUxTsBn8ryMRdtWUowrFAZe1B307lx7nIW5Zd+dihjSNFEGSuC0WeKQuJk25TJLIXDIO9Ylu/Sl5zCwP6MuPCMdETxJr2svR92gEFsKpVvKkOWQZi9fR+iCTeXY94PNG+O1HZhl0bTbgN12FOKhlniiMo13qFkVAr6oAV/Uo19OIvqA21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czgGOWFp2k9A8B02QUUubkisJmsd+8tSzjW7al0LkrA=;
 b=P11QZw+asOTLkjBW2yfYEfdFkTvtvcBEN9riyrLYxdu4UdhCxaL0gZ0OSwepEU9IufqC4OszllGxIKnNfTZG9XyX4e8OKWSNV83OMVQqDlVrhqofG2/+mgfQKQ6OGxnYDoSuXec9I3uWYlec+Usq+Slje60euHkVTiG9tBB+FhG9QSAFc0MNt3ft5KTy3hzYl0PxRopmQm1ZW6+mmUKP6z6cwogLdxuvP+YqZFJOVROlV5+AalKrLOCQjxI0AKKb6LtBasxjLES+noRdqMf2hZtZMudu8NzHXVzqAhz2lkEwQsALexBgs4CGYECSAPa49phY6JaGDvcosprt4GneJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czgGOWFp2k9A8B02QUUubkisJmsd+8tSzjW7al0LkrA=;
 b=aZ0VPLZN/U8BMmXragYv0QVMH4LOc/O1LgoKIx6i+eiR1EzPErPlOQFS08ySEyO6HRhF1TrwtHT5FaFtESm2iPRj7kpv2HqmMcR1+dtx2apBnDAd8QjDtWPWZIYXaJHnampTz7VigjhtNqjg24HGMUA6J3x8PH8JDnhfQQEATBs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 09:20:23 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:20:23 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH V2 5/6] mm/page_alloc: improve memmap_pages dbg msg
Date:   Mon, 31 May 2021 17:19:07 +0800
Message-Id: <20210531091908.1738465-6-aisheng.dong@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0157.apcprd01.prod.exchangelabs.com (2603:1096:4:28::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:20:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5408deda-089a-48b8-207b-08d924155185
X-MS-TrafficTypeDiagnostic: DU2PR04MB8998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8998A83E15CA397E3CD675A5803F9@DU2PR04MB8998.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:164;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nuw6b212DdR92oYQDvBCrEeDoGu7E5eRWA7I7ZnTHJjcYNtfxzpL9aPj0XZnis7/HUCR4nNnH5++KtnJlymOMqGpk+2YT1z0FjSBrHl/iDc4KdB0QlGuxbJMfC+EBH96iee+1UlQQjgruIwgExQChDUKTkkXrded0ta3QAjb/oB7HH0dHEy2tORgOdzxcEkK6CLb2ld5PjZsc8xyB+jpzXA1QGRQYlIXLQzHdeKSrIn3JmWHuTDJBBQt9cNihCL0UwXhxV76xWHg2nBhTbgJE8Nf9LbpdiAfUZ1NSR9IEFrEsff8u9IXNDuuT2y+PzMpbuDSryTge4I1wZ5mjBphSvs/WkGulcXSuoJxDllZoT5GXOQEe2VCQzmMy+LK229JjcG3r9KHmRewOT3oA5tRn+PwqWG0xSwr4oTChympF2gg2iH4jpExca5y2lmIV+r+UjNXyasVyjO3flfb8G2vKZq6onNOwGt3itoFsjcTO//Ex8QffWjJJIIbnFlYdGc2T/thcb9dFcgBHmg47EHye7HLZKn8LSOA8mQGtdls3wf96olmLudyZRFnJ/vOPcmCDd3SW5TN9zXXSr0bo6VULco61mNSmZFOwHWkbl7SdHBMxkivCkFl2rqYhw3H8ptzLffFG8NEZjanJKhtf8W7SuOK3/U+0L2eTs9bSja+7Hcot0G1zKg/I83PY8Xipyd9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6666004)(38100700002)(38350700002)(956004)(6916009)(83380400001)(6486002)(86362001)(16526019)(8936002)(2616005)(186003)(8676002)(478600001)(6512007)(316002)(5660300002)(4744005)(52116002)(4326008)(26005)(6506007)(36756003)(2906002)(1076003)(66476007)(66946007)(66556008)(54906003)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kj3PtdhSpRDgB27RqqMch93/4dMPepn8k3UpQkLydvooG0h2ht3qIDpBouT5?=
 =?us-ascii?Q?uJIZXfFFas4mHjC4SiuM4ZxD/NPKxZSiYu1O3RICwTSahjDJG5uuR6v+97SH?=
 =?us-ascii?Q?VdmVi/tWIroDU4oWerj41wE9iOZdOKk6LxJzSwkViIFBnSp9kykchYNfi53R?=
 =?us-ascii?Q?QZ/Gkt1462JRMzmuraPg1vFyGyLOpctkauYO+zfICQTaKH7sPNvC3ENodzO8?=
 =?us-ascii?Q?YIz47eYT1xksDitekBKZmAwcbcXrEgQvJhSMJbLTc+wwCyto7tObtC4O6Cu2?=
 =?us-ascii?Q?hbIm0ntAVsjU4wR9awfv+WGdNsojBfeud4TwzXQDUhxQJ/qudHE1/D3GFTKI?=
 =?us-ascii?Q?HSRKuzsezg031LQOALKPfOvXema/FVmdZVdjFc9MXVBHk4VY8sqfKo0ulpFF?=
 =?us-ascii?Q?sw3NwYlM5KY3OxWdSTTFpyaTgdaYA94dg87GnAZpgG450go5K3QX6qDKfAez?=
 =?us-ascii?Q?ttkY1JBNFME9EBUPUuNnN2tJVAt5Gk28O2s9Grw+OVuXLdDTZZXkP3ZuNbie?=
 =?us-ascii?Q?j1Rwh3lVDaw1T40GMNIi16I1FcgqgHwxzq/esjtpSQnon2r7jI5Da2JieOe5?=
 =?us-ascii?Q?Cvo4wWr9gRFB2oYNbAz07SxODw3hU6IOgYA+y4glCGSTIwXLHkQuWd/59YoC?=
 =?us-ascii?Q?DYnB9DwwS/uGBRQoeiOr36vwnfELBz4o7wORtc67EsIxUb2owrpMxYe4wtHK?=
 =?us-ascii?Q?Oxp84dR7dWpejl3inj5rO7TqU+u9rDtCepzSLw/OSKkg14VGtzMrELmvRNSX?=
 =?us-ascii?Q?5VH7H6rOsNBoUPeQWZfiH5tQla2McA1p/1IZFUKDlHrvmAbHXQNjyBhJc95h?=
 =?us-ascii?Q?VmrEv/EogIo7DRehbuxFbZKakE4YMw6Du9oY2MDUZ3h+Of6bBKq7s/g3yhWz?=
 =?us-ascii?Q?LeDoQfFyEeCgY3hZvwPUfa7MIyObeLraMXOXC3tLEwsDecqZN1Ukz0ifa/Ht?=
 =?us-ascii?Q?+1uu6nlog2/0iskJrQ2GE3EsdjbfmFQkM81ZxmNLKgoWOMbyJs8wBO6ymKfp?=
 =?us-ascii?Q?Fca1X1nCP8EApAVGgXu1YuHhxBRiFr2Hm2gRPPRldpIqjUgzw+QTOt0wK5Zd?=
 =?us-ascii?Q?15aKCD4nv3TKC9vEkBc8U97bO04cs+duwqqdiodefN7pUihic4qSvfCj3nby?=
 =?us-ascii?Q?4WTu0CWxbLf7BVWwNKXTxCBJEK1S5o0Z46OMYNLPAfdM7XdUOCpWcA/VwnGH?=
 =?us-ascii?Q?BbjNx6XBabmbVBRgrF1fClSATLwLVT10m5k0DBUJ/tKEMiyuSRC4g8w9Ne1l?=
 =?us-ascii?Q?6mgR1aSFm+3mJLHv2qXe1sNMY4sx8qbCz691B3hvBLh9zBFhRRMt2K+6Ojg1?=
 =?us-ascii?Q?qrqBOmB2voQG8lBTJ4uj2qr3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5408deda-089a-48b8-207b-08d924155185
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:20:23.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YXqvGRgzS2gLhJ9jusmNSKjegp+x4gHoYvTOgz8hL2/svLuHhHA0t+agi6ANzdNSQwsK3MQegDuS7eyDLJHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make debug message more accurately.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * drop dma_reserve log changing
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1786a24cdc5a..1bfbe178a9ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7347,7 +7347,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 					pr_debug("  %s zone: %lu pages used for memmap\n",
 						 zone_names[j], memmap_pages);
 			} else
-				pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
+				pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
 					zone_names[j], memmap_pages, freesize);
 		}
 
-- 
2.25.1

