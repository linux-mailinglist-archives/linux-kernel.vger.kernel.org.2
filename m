Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2341453F22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhKQDw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:52:28 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:29052 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229910AbhKQDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:52:27 -0500
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AH3nNiC007191;
        Tue, 16 Nov 2021 19:49:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=Fag5kBgZX7XHiiFE6XQFewI3mx7Fyk4LFZ/R8o1pv8A=;
 b=G4/XMAUizdbGST6MSIsRbaQQ18xMnvrB4HR07FU3DybJ7KtRO9Jfk1+oxEC68yzV4AxN
 nyUqftexItinTlcAb7KNCgeVLJsIrKvpP4ifHWOV/+a0WD5OvOq2SPgN0g/lHpyWbrCi
 YTmdIou67nQvhPlmv6podO5n9kSANCEIFs/HKLNzFIzmkyqlUE/zXOfIuT13LuRa5eEt
 uAxr+yKFTrU1uXDylO+5zrPayzAXgsH/tPY4Yq5j0YuOEubanBmrD/23OaEDL7Lot2pH
 yzq362Ictc+hLUTjQHDUlUaVLCLYCC9tPS5s5R777kCgApqUQ3nfS30yyGfpNi5TSvKp tg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cbqrusnyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 19:49:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFogRxz2hIP0ZeuKKXtE+Bht9H3ENRlg7dTQWCrFtDXxWC4sTcu5IXErLjKuR+kWnMWOUFfaXQvk0lkChBQA7hdEYaHdn1KXbRCAhaMBL4GgH7HAMugfyGQ4jFgGzcAUUGKwHHP1OwoCLEC4RdR/dZ+TNCkkgs6flRrddcg+QRI9Gzn6JpN3Ji/2akPesmVxcogizxyBFLZH8OOzXoxjk/K768Ik3Fwo3tou+FCNzUm6Gt+SuGo60TghpS3htb7nstCtzdWyO2Y67LOOuBs+jFjCD/gpRO+/kr9Vflg4tfjAmJJuhUg6blPtI6fhajwhgCHJ01eF+J5P8zMj0n7QJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fag5kBgZX7XHiiFE6XQFewI3mx7Fyk4LFZ/R8o1pv8A=;
 b=kNbKX3l9px/HIsufoTt2BiDPHkrfk5lp0AUVTSLhojRQsHR5oVqEMPkZOFJYFly0ANfmk8dYhUJsT7Caj8ZM/4GiyvuKV4pXYC+K9fv8+nAqjy7WYodL5Q0j3K9p969R5J5B7YnripbUSQ+mm5PV6XaVIaF+g0BJJBzsRHNOX2Hzs8xN15RRKD9iW01pjcpybBkW0y2dK0YfCuBaK6bz7rKBOeASaLtks9DVnQwzW0eW6jAZVXDwTHFzfwM/9ODUueO3LVafyMHIJriNgUc3nMDavTh8z+/M5qrKuHc8lxwRdlittH5rufLB5PJKEmbpLTInPjGIV3Et+KiSZaQ6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 17 Nov
 2021 03:49:19 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 03:49:19 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     thor.thayer@linux.intel.com, lee.jones@linaro.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH v3] mfd: altera-sysmgr: enable raw spinlock feature for preempt-rt kernel
Date:   Wed, 17 Nov 2021 11:49:03 +0800
Message-Id: <20211117034903.28588-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR03CA0058.apcprd03.prod.outlook.com (2603:1096:202:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Wed, 17 Nov 2021 03:49:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129a9928-394b-46dd-7256-08d9a97d3bfa
X-MS-TrafficTypeDiagnostic: PH0PR11MB5206:
X-Microsoft-Antispam-PRVS: <PH0PR11MB52063920BC2953B9298F5316F19A9@PH0PR11MB5206.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHwgrHsMgTRyP/eSuqYAodIig30+5yVYjf6BHNKth6/xEuSe2Qn7uML/AkECkpPkwxou5ntbAV0udF+dAT7HQ6Li+hUgjTzlviFb3EgpjUuUkbZk6RKdbJMfNYK6vSLUgm39xMBYgkx3NS3Zchztr3+DJMVm52UqksOaWRck/IqseqdLb4LXdPQ925+lX8JwD0LevCakn5Q4uEELHHKefT9oiaVJUvRWJ/scgUP5FJVgmiAbb8hAsotDSegr4q2R+ZTPnWfs+xha1veSZGZ+32dD4dRVNkzvPoneHni1uqXyT9DkqGxZgBsYzscRUt7rly6w+cEZ/gE8Zp0WCuD9sKsLOS3ceOOhGALHF+kLU0Fasig9HsjooMztkBvACKoDqRtg2T4huXhzRkpN0QHPaDNUCE+5iEBFfegihIgCvt53CHUJrD/cGQcxPLd8pyhALZ2Ozd95GYPjdeY/xEiaUo60GKAyhRqgUoWems6aymEfPLBS4oJSnmXvDTglSJKC2RurSYA8r2jbucrFIdxXSjrziKncWrMVKQz52tWPS93/OVvApg8BayzMohLZMSnPzJSRP1cteBDOGO3D336WkmkMTkm2XxUy1+JCu/OHjjMI150gtZmKoUJ4EQVaglsBgIXovLUM3BKex1hB6EWxxdEaPKCcGtJZN+w83ZkM02t0nUSdfcfvMAhLBSK5eqcJZXYX6CVXxjzcGOrKg3B4Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(4326008)(6512007)(86362001)(36756003)(107886003)(1076003)(508600001)(5660300002)(26005)(8936002)(6506007)(6486002)(316002)(66946007)(186003)(8676002)(6666004)(2906002)(66476007)(66556008)(83380400001)(956004)(38100700002)(2616005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OEkohnxLj0Jr1/D9BSvXuuooAQhKHh947xDZ/pis9wfDWTKau0+S6fMQ8ARZ?=
 =?us-ascii?Q?kd9eYo6OMu8EO6wIm+mBxHtzYMvTtogWQm7tozLYaXlxD1ypYhcbQ6p3g2cB?=
 =?us-ascii?Q?qxh3pdnW32Z1XSBGNRiECpYu12qw04qnQIHqO6D+MtuxJoAAWGNAaREuCqQK?=
 =?us-ascii?Q?HwY7YKvhd2UdMad+2Kbbtm7tGhUtqyJPyzx/srMs1APNAy+/Gi8lMGyoq9o4?=
 =?us-ascii?Q?biJRyBvjTK/H2ea5gzHUbwx+9YrMGjpBrkl2weeOB0KcsABJeUTWwU6QmeA8?=
 =?us-ascii?Q?5rhC5dKC7/VPySBiSEAiAtlmMUFD10e77tbykwkEem463iUkMuGooETDHy1T?=
 =?us-ascii?Q?xHOh1GgtQF8txEXkv49OnRjeFpsuoJCTfq8gOQ3dCSTjeXI1gxER9tcSb4wr?=
 =?us-ascii?Q?gYtuH/7H+D0nr2Z2bPVk3nDrip+FEk/lWrlHhkHmQN9chN/NAtXP2DSceiDN?=
 =?us-ascii?Q?BxzTEjyak7qldjZdErgmC/hFjOiIxBr2AAZ/ABM0VL625aKvSmJW/wUnIVuC?=
 =?us-ascii?Q?a62f/vnW8DhLgywJAmU3ZLiPMzrl8rS6WeFTSV6q9RDn7XnsE/qGwqcPcID6?=
 =?us-ascii?Q?fp2l0Bj+AuOwJxQIxaXYLj+KmYAnneXP9NpGAuqA44Gqt6bzvT/yaW1LAhRk?=
 =?us-ascii?Q?BSHtvNH64zLSIIEYKRNxTF3ycmNxXN4av4ZHmZSL3c0xVGiae79WhehuUmjM?=
 =?us-ascii?Q?Yo3qbWY0EEzSbYbNtBotpipnLPUBanhwQkP/WKdKBd5kM/D26WS9h01ay9bY?=
 =?us-ascii?Q?PukxaWoNeI2UIqJVizsvXxoTMTTuvHlulX/SScumZmx5GvbLkufMnqyYUXO7?=
 =?us-ascii?Q?tWgNqKko9PmdK4/stnHnkqUx5kUR+60m3SRNYm4u2XiajZv+37KiXT/TMcKG?=
 =?us-ascii?Q?kbDyuGGNiTA+VW0v+vo7D5MbwlUrTd5FUYDNuF0EHKwQshEgo5mpOF0438E3?=
 =?us-ascii?Q?dPurbiXSemv/xu/x3q1X+SHV4gPudZGgblStNZPFu7frgOQ8heBVyp8lINJ0?=
 =?us-ascii?Q?mDXXUuUCRgpviTvzCdvH+CZ7kxRYbgZDGw+r5PmbZgeFXwoyDjbHdZitZDig?=
 =?us-ascii?Q?AIE2n1+6CtV9B6EFa9Ed+ptzXEPdfIbkF/g7udjlsr5CqbXOfju541azC8A2?=
 =?us-ascii?Q?mMdFRNII471Bsx/TbRnYaVA5ni3wlHa8z24WRJSHhsxd0qOWgLbK8KVjC+Mw?=
 =?us-ascii?Q?W1xgYuv6ZlP7PHL7KoXud7QKFN4FMpt1/G5ugVTQhLFBnoEDJtfpMwQqI92Y?=
 =?us-ascii?Q?RbnaZUWHyQ2EwLlyxcgG7SmRJ0Gjqausf3VGBQSvxnuRi7+vkS1NyvsrySW0?=
 =?us-ascii?Q?1q0j/Wi/2mcIkJ/DI5aJeM1x8TtUPMkLK/Oy4HeZQTDBpjPLQrd4Ih7ATd0d?=
 =?us-ascii?Q?ytDTNOykmf9tL9yXOTa9T8MUfbRKCbKRUEvJpSt7x3DliVQfoH+wULrzZI8h?=
 =?us-ascii?Q?GN/e5WWgO/I13ln5TPBfYlHPITzat5mQgqRC4BYrVI8phm6ppRGBgEYrPmu6?=
 =?us-ascii?Q?bGrxWFoUHBRU9+z4jKbNiNov21vJKeBElu/eBe71QjiFV9axsU9ErHU4V41R?=
 =?us-ascii?Q?5EPMb13F4FASA6RlQO3rHrxW2FkOm7+ACHLmqja1wl3v+4soe+HqJmU+oYYH?=
 =?us-ascii?Q?gTlZktgmp0zXj1Ip+qDam2M=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129a9928-394b-46dd-7256-08d9a97d3bfa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:49:19.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Hx08OHNZhMe6yD6ekyZol1ojWFJM/T3nNMzajU2EuAimNMABrqaA2xxNk2zY4Pu6mALL/UOBdm2nsnzZ4Lrow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
X-Proofpoint-ORIG-GUID: vS7hBJHGmPt1LfBaNhIGqyTndjWrHFjj
X-Proofpoint-GUID: vS7hBJHGmPt1LfBaNhIGqyTndjWrHFjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_01,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111170016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting up preempt rt kernel on stratix10 platform, there is
below calltrace:
BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper/0
Preemption disabled at:
[<ffff8000100b25b0>] __setup_irq+0xe0/0x730
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.78-rt54-yocto-preempt-rt #1
Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
Call trace:
 ......
 ___might_sleep+0x144/0x180
 rt_spin_lock+0x34/0x9c
 regmap_lock_spinlock+0x24/0x40
 regmap_write+0x48/0x84
 a10_eccmgr_irq_unmask+0x34/0x40
 ......
 altr_edac_a10_probe+0x16c/0x2b0
 platform_drv_probe+0x60/0xb4
 ......
 ret_from_fork+0x10/0x38

Because regmap_write is invoked under preemption disabled status, and
might trigger sleep.
Recently, the commit 67021f25d952("regmap: teach regmap to use raw
spinlocks if requested in the config ") add an option for regmap to use
raw spinlock. So, enable raw spinlock in preempt-rt kernel to avoid the
might sleep issue.
Note: The commit 67021f25d952 is only in kernel v5.15, not included in
earlier versions. So, if intend to fix this issue in earlier preempt-rt
kernel, it is need to backport the 2 patches together, otherwise there
will be building issue.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---

v3:
 - remove #ifdef CONFIG_PREEMPT_RT

v2:
 - improve the patch title.
 - improve the commit log. Clear which commit is depended by this patch.

---
 drivers/mfd/altera-sysmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 5d3715a28b28..ac350b4ca486 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -83,6 +83,7 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
 	.fast_io = true,
 	.use_single_read = true,
 	.use_single_write = true,
+	.use_raw_spinlock = true,
 };
 
 /**
-- 
2.17.1

