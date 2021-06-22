Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECE3AFD98
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFVHLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:11:45 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:62788 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhFVHLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:11:36 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M79IXq017937;
        Tue, 22 Jun 2021 07:09:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0064b401.pphosted.com with ESMTP id 39av710hwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 07:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5o/PAib+lSgKRANMWaxhh52icNy/QovK9aQ2uS588kRH1HiP/2Xlbm3NGTI4eDZp/SJQ6stV2UT/8fOnPeJMxx3RMEwB/LnIoaQRHkMmcI59yKcqQs02qkLCqQu8H4lRmx4u8FNCmNn1lVRjf2XnaHnk+WuT5jz6WwUQupMjnzqS9iBtgGaVvjCPDt4H0XDjpr7/LClJfmUmQX1GbB/MWzF26aPhmum4TC8zOSNzMHPJA4oa32s0B+zVjEhIAzVaSzxtX4TeKYgWOM1MLJp6a3co7MokjJ542U+DDD9wPLEVbi8bpLCN0JbOjwxS+MIjk0y97WBM6/jIfIE3NpWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKSojNmXt83yBg6VNFo36Ty5vt61ITsh9aF3aMCooA4=;
 b=bHnWsto/1iJHLHA5l0PDCT5EeHPlRo9WnKo2uOK/gU8KUuh5UAbtUUzhkRX7ilxpXyT1JWfPHc2HAIbpCnzlREnBCi5JrnSdBMsSlUCfNjV+XsZ4r39SqPQNdPAzFtvZHBX1sT9/Krl5PjEbEI5/cwWUFS1rOZO+ZHJPR4Fd6A/BMQsbGddRxM1XEozSXidT25M8cC8OuJPnB8A+AcAUuer6caTiX3bV4vd1hgSo4b1LfktpZNUo6LkEf2WOzePlP5vU8xE8kM5wBW4+uVpXZLjAvHyoZr9AbCCkebCyiwBJh0+C7dzB+ATZSFwvNEt9RcppTnYtuFsm8Lvb8LeZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKSojNmXt83yBg6VNFo36Ty5vt61ITsh9aF3aMCooA4=;
 b=mETg0s0tEm9lGGGbcy7ZZBSbNAFnN4xjmiMERXJqurPhEc9b+a8DDX3K2yFx/kcxkCrMkSYjmY2F8C22DLD9pDxvafPEE4PmgcFo2qmJkbSHnHmPBuVO0wyToTiFbENYk581buf5wKzRxpt1f2hguaylR4Gmi3QcdeUT5soDD/A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by MN2PR11MB4237.namprd11.prod.outlook.com (2603:10b6:208:195::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 07:09:16 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::9967:5190:1cd4:bb93]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::9967:5190:1cd4:bb93%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:09:16 +0000
From:   qiang.zhang@windriver.com
To:     jiangshanlai@gmail.com, tj@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: set the rescuer worker that belong to freezable wq is freezable
Date:   Tue, 22 Jun 2021 15:08:59 +0800
Message-Id: <20210622070859.4942-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To BL1PR11MB5478.namprd11.prod.outlook.com
 (2603:10b6:208:31d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:202:16::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 07:09:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f5a357-d839-4fb0-18fe-08d9354ca553
X-MS-TrafficTypeDiagnostic: MN2PR11MB4237:
X-Microsoft-Antispam-PRVS: <MN2PR11MB423707FBADC711E5B2C7BB48FF099@MN2PR11MB4237.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9k712VVYl3EYE/tXG9qN9TDQk+XP+36L1EdLS5AmXRVfKQJY/atg62Vdaz6qn5CgCZQqynf2FE1O9ulss4dCBnsxbIfWt7efXwlawo1tYL/coPWpevLGrd4T6mOH4SSEz21Z+OxrWWQCkce54XtsGkzQV4pyXAxIXlh0JqZrSRaaFPH2VpFuHZmy1rGeeiWrDo8sfxhzKvaPmKhQfbp8vlnKOsPg+IvULksDltju8qNnqrk2CkxubnPRjFTKymGit7zKJkvQtZGy7JQMYJfP/r5nG+y28Fo9nJgw6BWIk+GlVsgibScDc+OxCBvazQUXpu5tX+XA1S1OV8n1b82YS9UC5k9xY884FJEhWuSWByVNRZ7APMaEIxWMJ4HkZ84zclUNn2YPa4jToeoh4UGooyQlWL00uWID8godcRODnCKDLZ0u4OrQUfoqKzZJOjDbQfcjy5ISiQHQkoGWLSX7zWMjOZxpvmPQvpul3CtdSHT3aRQdjIdJv3YZM5sz/527zUkqk1mHQefUgHXkwkBCO99Pw+CgusHyoPdmXg+7GCHk00xw4xo6sW4cBuqPZbgQOrTzfAH6HmipqVHRRTRIfsHSRj4olHRIDl+H19Eyt/jO3s/8o7EO0keH7HLgQULsAPTPZC+7OI0MWaVSPShsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39830400003)(4744005)(8936002)(66476007)(66556008)(66946007)(6666004)(2616005)(956004)(8676002)(316002)(478600001)(52116002)(83380400001)(9686003)(2906002)(38350700002)(6506007)(6486002)(1076003)(38100700002)(186003)(86362001)(6512007)(16526019)(4326008)(36756003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vma4w+HJykZc6s4Q2L2QN9aD3NcQbCBvqdUy3Vizx7cG9PmcA5xnMJysOCI2?=
 =?us-ascii?Q?7+ug1FLYK9Sm/baGRroATpCtPo+aKXZYr5D77ZsYfQGt9nn3c8ybX2ZeYBkk?=
 =?us-ascii?Q?7LP8sQUF0/pK2mozBZQv65l97LxN2GPDBd5oJaA7PQlpbp0TlYb70dzIcwuD?=
 =?us-ascii?Q?c3vEBCpNptr1M72LvABBx3IRQWMKWUx9vqbVu9GahILxRLGlSiJPvmxxwGO3?=
 =?us-ascii?Q?pTtVDkE1ObhbGV8/EcBd4tC+f9Nlqnv/rUFmNTESWbrJfv6NE2UZ/NxbswKO?=
 =?us-ascii?Q?X4T2umLI6If+l3JLAccZ6KbfMd08NhyBqm0jBI8nsn7sqiqu9IfsVqpRNBVn?=
 =?us-ascii?Q?PlIAVQGK/KoHMmccWEdxU5qL15onMutfOICrVrxrn/4D1lawcAC0990WVqYR?=
 =?us-ascii?Q?lOJqS1z38SyICfMJyDCzKiBINye6ACJCcXaHCSvjpMTDX/GuYZoV+kGeIY5C?=
 =?us-ascii?Q?3Y/ZIs7foLAHXpNrpNYYqL0MXDAqAFBPs06/rY5CEz7LkJo9RUoMy6T2b22i?=
 =?us-ascii?Q?nRVtwN6eHOotz4LhqtR4MCaloh1w6p8J7ShF0Ep0QNvtCB4d79oXYD2tUvkI?=
 =?us-ascii?Q?z9Pdvl//8uWXkoHzI3znmGyPKHSF85Qh7eJe3zFhkCpsAHlb+MAqsrFyE8qL?=
 =?us-ascii?Q?bP/Z8PPhUZkVTm8syIHAUyVZDKKDSr70BSymdEVPHZ5G4YVcUZAmsASBlmKg?=
 =?us-ascii?Q?lq7X7nNiJoA9hHumZtSB1v+4K07QxBH/MIGkWs66Auwy4+H01pL6l9QtXdcg?=
 =?us-ascii?Q?2CQOo0q6n9WbNBqCkYu7S15y2SzR5mDjL6BIEGjuTBUSBApo0hqV8DPQnRLp?=
 =?us-ascii?Q?PpHH5QlFhcx7L8pn3PBhq9liKTY/EKKVCtK4YfRmrUIC7vJn9GkjE8LfILQy?=
 =?us-ascii?Q?196zn3P0AAx0dqU9Tw0QG+Mkr/hyLImbTKLS1BWP/WmldP8byzdMeMOdGdks?=
 =?us-ascii?Q?xOEzmyERsy+Y/5t5jJmFsZK2qnWCSW2Zs82v9scsqqyigwC3iFO8BTc4UFco?=
 =?us-ascii?Q?jNzpzIi5WzNlAf5CTFpocUAsFZPkPyeVbAo+8gV+AmEdxm8OTxMj0GfkwaIR?=
 =?us-ascii?Q?m36UdLVDOX3hClOTzsqULO68EuC2qzPoGKbQtkCkD9YGRsCnlipqnM9dFND2?=
 =?us-ascii?Q?btWscMK0CncmwwpneiNDNQp9YN/hR5JSJHGiCzfaSVile7nnB7uDgoy6ewgK?=
 =?us-ascii?Q?0dk/IV3XjHFikPz25JtIFyV/U0gYmSl2ifW0m0A1QLLleNcAeA67IZha7mrf?=
 =?us-ascii?Q?c2/5HErPCDP/YzoYNlKb98ihfG36FY5NmrD8WWpo5KPbLDUzWk+KtuRDHpeK?=
 =?us-ascii?Q?XOmImnzPYgAkCg+4qrN+Lb1l?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f5a357-d839-4fb0-18fe-08d9354ca553
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 07:09:16.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRvrF/IT1RD5+QyU2mfK9eLw4UIkBPpkSYkl5a2LrMEukBHiGObEcaDPavmICCKjbPS7MbXbsijThDNzELqmLq8Ey7qMTm5i9yEd3OpOLBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4237
X-Proofpoint-ORIG-GUID: 1lOv_V018nLpv8exsIbsa0gSRwNhIYg8
X-Proofpoint-GUID: 1lOv_V018nLpv8exsIbsa0gSRwNhIYg8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_04:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=578 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

If the rescuer worker belong to freezable wq, when this wq is
frozen, the rescuer also need to be frozen.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/workqueue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 104e3ef04e33..ccd6ee8f3dc6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2476,6 +2476,9 @@ static int rescuer_thread(void *__rescuer)
 	 * doesn't participate in concurrency management.
 	 */
 	set_pf_worker(true);
+
+	if (wq->flags & WQ_FREEZABLE)
+		set_freezable();
 repeat:
 	set_current_state(TASK_IDLE);
 
@@ -2504,6 +2507,9 @@ static int rescuer_thread(void *__rescuer)
 
 		raw_spin_unlock_irq(&wq_mayday_lock);
 
+		if (!kthread_should_stop())
+			try_to_freeze();
+
 		worker_attach_to_pool(rescuer, pool);
 
 		raw_spin_lock_irq(&pool->lock);
-- 
2.17.1

