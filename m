Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31B331E473
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBRDR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:17:57 -0500
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:54344
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229720AbhBRDRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:17:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoA++f4htvJRddHerlqGDbQr7570ZwWwo/+DFGJXg64q4II3ToJbJoSgVyVfsFxboNIHfoZm9soHPQ9S9jkSYBzAf1VlnttZC3b1Qg6NGHzwgUQhxzcVpORMPlWjyP9XMW0elAZI89ujaGYnIO1aKPkPgCMeHL1C2Cupfhug5SiRKiPApEgot8OAG2KbLuOayr3oM2HxsBJ1n3R/kSrxjWN6buc9bEzAE/i/oINX+Sb6bv62K6XwiqDHmhhsYigQREXdj8MMMZnbKCZ90mQQzkWZRefgoWaHi6Xdhod3pHDFOgy59VruLXYaHww1LBOeMG26p4FYgQSaltFArbRicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKI0KCpKo67SrAq3G92KIEQWfjs5TatCc5Awsz92a7s=;
 b=EK9MJ2lIqlgHMJNC57SDzDUb5Y02MlveHMSi8UpOuS8/r5rgvjNzRRoCJcEgpyj5dBKclwvuXBADzveZXvPAxg5U1F7LUnd80tuVPkHm+R6JDD9PY8T04wWItF/kFSjYqWcm31AaNWMFYyfB+Yo0oXigaCt7QOm2YZeQTPU8rIYQ509XaXTubVIfZ8U0fYbmH3JQk5/RSdh+izHIZoqcraiW2TChEiOY2/adVr+aeNUFcxBmuRphsGKn4fW/3cEhVGEiQHzm2FK44yLYrXFue0MBfm5P95EU3IJ7ErcoN2LOFcuq4nxpLjbQM65VszNtzOQAT5+8q1g5+S8IUUFjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKI0KCpKo67SrAq3G92KIEQWfjs5TatCc5Awsz92a7s=;
 b=ioo13lEeMEeIiDQysh/IdOw/H3mV+PP3gcZ8lV7K0K1OrZglmj7LgxYHjqacqm3d4btnCPnlHRojbbSP7vycnAEOvXtFIRLEYq3l4VOWz8zm6jWhsDKEBvOBWd+oz1Sv9pJyHuRwc6pHp+2N2+b8VDKLIDhJlmKT/mjQFsl57Kk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2600.namprd11.prod.outlook.com (2603:10b6:a02:c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 03:17:07 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.030; Thu, 18 Feb 2021
 03:17:07 +0000
From:   qiang.zhang@windriver.com
To:     jiangshanlai@gmail.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: Move the position of debug_work_activate() in __queue_work()
Date:   Thu, 18 Feb 2021 11:16:49 +0800
Message-Id: <20210218031649.151638-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.39.148.242]
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (106.39.148.242) by HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 03:17:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec8c09b3-b500-493a-61cc-08d8d3bbabad
X-MS-TrafficTypeDiagnostic: BYAPR11MB2600:
X-Microsoft-Antispam-PRVS: <BYAPR11MB260009ACFB89D1838543AACFFF859@BYAPR11MB2600.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QiYy3/K3obwUExEBqbTko9Y5d2QrCNfE2g6MYzryJr2aqGbCoXyygnv+XUDi6foQhHPqR8m1gx4QqyUBA6PXKgSthWvoCn80ey6YzYQRafn4LkYsURp6dfkBMYoZLO4XK40ngb9fMmQZQkaicxfQERs+3y2F+RizfjU5q64Z+Pa9S69hBDfrAnpJ+4CyNT+aL/5OlPm26Vi9Z/kQyYMSqZZKamxmOzWAScNp2PH3sNpBE9upaEYlqpeOiCEZb+yAlcau1SuLD231cv2cQEUwA8A0388oTTTXcbyLzMDBT3h3j2oxuI0GTL+8ZwcGZnM1CoNArCojjxhmHYLoUo+tUfwLVKyZWPclTMiDmFPg6ZliELOvixjAV8d0v6WhJf54O7DYsebZTDaQiyVsFJuIB1FwuOsitrnrHOSDeORoUl9gXQaDjtlbl8Yhd+YDBUY6c548nfcIYSkz0RRkksukW47qvMVUbpanzUcaERej+x4Q7v1fs5SivwJPZK8XBU7bSQ0Kv4tFl5+Kddq1Q5f41k6Yavt95XBkt4c8zuACowOwVEt9PJv6QQGUbwCVzgTrs2ObnmcQtVoVPZsxRwxfVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(136003)(366004)(346002)(396003)(69590400012)(6506007)(8936002)(6512007)(66556008)(6486002)(9686003)(66476007)(16526019)(83380400001)(86362001)(186003)(36756003)(4326008)(2906002)(8676002)(5660300002)(478600001)(316002)(2616005)(6666004)(66946007)(1076003)(52116002)(26005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3hxz4v3eq2KeJmtxPPNWLW+9/NxFa8H3jnNpKlVunLLIMKAw5Hv9JtPuEMGr?=
 =?us-ascii?Q?ksicnolXOrtktFkFfG/ViwQv/XGbVnbpvo0EW99fJlxVmLf7XOwVTf8OcZa2?=
 =?us-ascii?Q?sw6TDpp66IGRv21I6symjJChnMPARVj5ZZPGiBdmVh6y3laFtFPtUPtPYvEz?=
 =?us-ascii?Q?OePnH+A7VwvsbB7PyEc3JdmEq29AtKT1yeVp1i5WBnkEDeRIsRnpays/1whQ?=
 =?us-ascii?Q?SxhGu0aKwgjzhTRdSxcnrMssT4UK3ks5OLS29QxW3D1jdD+fvrDvMKEJk3bW?=
 =?us-ascii?Q?+tE9CRnNZb9QkVFPo0NmfQbv5KPl8vgnfohbxq8YR6TqfG9fdTwBH5xhtzdl?=
 =?us-ascii?Q?x5MtmiqqRHcmFB3KCcibpYoz2ORnWRctdPc4pZ4yyXPW+2m+qDfEUhWNgOe+?=
 =?us-ascii?Q?f7tk0mrKxYQFrPQ9+a+KjI5TOw4XLEsgHZaVTb6bRxiVdeV0+biocrfX/tp7?=
 =?us-ascii?Q?qm10o+fw9bfB5Ga592CcTMaa4bNcAm2DfkLxFd1Ohpym0Um7DhgzQSOBQkxl?=
 =?us-ascii?Q?DIywBXmxglw9CUg1QjhFUVhljJOfgGWTJMQ9Iw4oSUtnXLzxiRpPrlVDIfP3?=
 =?us-ascii?Q?K/SzaydaHmgHR/kmh/oYk/20om2L9ulpsthCwO+H1zN1Z8rmSUgaotcJABWT?=
 =?us-ascii?Q?/hyOmokXceaU/S+O+hwLZvgBiNsGBjzenBD+P15KLB7HOohgIW8yG5IbnfiM?=
 =?us-ascii?Q?PX3zziBsRFltruxDkQ4s8WOgXrgddXZFY1Z/c9GNx7SeGIzmzfHWtHZ8PZ8f?=
 =?us-ascii?Q?j7kK0lWiKElxDhNH6BQsfrci3dY2CiMcgfV8xBXKz3Dq80JMt5EHNAOjPcWG?=
 =?us-ascii?Q?Rig03T+18beo8C2ob50F1wz67i22W2DM8VQ5jnp9XLB50beLydcwjgDxPChu?=
 =?us-ascii?Q?hvOfsvTu5zNiKT11FUmpbIPuQEEjPul9Tv1Ajm7gjunnwXtqsqGY0pDxVb8C?=
 =?us-ascii?Q?3lrBmQMRSj3Rb1ED4g6O3L0bbKtlPX8BULhx0djzv+oyiSVgTHgpIu4J9/UQ?=
 =?us-ascii?Q?Z8ST0rbaHXuxQqVgTt9U41WLwKkmqQXnyk2/7OQ54+Xj9UcAA2dOI5k/GUiP?=
 =?us-ascii?Q?sU8grjsVIuwc8rz7cIXJml0kGJ7yFG9ieUM/tXmpNcash+R2Mj2Vt1eWmkqI?=
 =?us-ascii?Q?EMyctDxzLAkybSoiWucdo8iA5TDQyUSvbRs+a13ue10R6IBvxckj6mZLPLuX?=
 =?us-ascii?Q?rZE7mQu3wgnSQmHkjzIuB+RdY9R6brtFan3TpYaCsB5nAlE4wKS5U8xL3NH1?=
 =?us-ascii?Q?bBOyrNY/Y/+y4rTXVNV4J12a5Vw/czNI5CogoefbNQJrx1IcpHrlc+CeNMAv?=
 =?us-ascii?Q?r0jITAG9czxM5mCCwY8znoMi?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8c09b3-b500-493a-61cc-08d8d3bbabad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 03:17:06.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXYtIYaCfDrWNvvboITwUq9Z0wwkKwbZkOIzXRPRNgo+xQfBbycw3Qaoau8ddjAq9ac2i6qSu2tZ0gj0TFNkOZJpp2wg4xqZIGTKFgCqMCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

The debug_work_activate() is called on the premise that
the work can be inserted, because if wq be in WQ_DRAINING
status, insert work may be failed.

Fixes: e41e704bc4f4 ("workqueue: improve destroy_workqueue() debuggability")
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 v1->v2:
 add Fixes tag.

 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..21fb00b52def 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1412,7 +1412,6 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 */
 	lockdep_assert_irqs_disabled();
 
-	debug_work_activate(work);
 
 	/* if draining, only works from the same workqueue are allowed */
 	if (unlikely(wq->flags & __WQ_DRAINING) &&
@@ -1494,6 +1493,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		worklist = &pwq->delayed_works;
 	}
 
+	debug_work_activate(work);
 	insert_work(pwq, work, worklist, work_flags);
 
 out:
-- 
2.25.1

