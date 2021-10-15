Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943AC42FB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbhJOSfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:35:34 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:58400 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231254AbhJOSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:35:30 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FI8tS7002268;
        Fri, 15 Oct 2021 11:33:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=DLttT7EtM3qJ0p7gkiTjosemwqANSh66uuv5iLbNKO4=;
 b=czhKxrcfMluz2kzXzgsGu59IC1oBeiDLXHsxb96dwTGaiefSP4fLIjZfJz5NkpDgiFnn
 7VV7UZr72z0ZyeaQ8GaIvBJ6u970ix3fy6NmzI93UWK4Z04fyxYEKB9ypH77LcUwLL/W
 ZzC0k7wwDhTgW4OoCv0LtYt9E37XBMNG1yrbKYeTYL6IE+CfhepsnaubRvqNU+Ko1Cec
 r1GS3REhGIoGTAq8xu4OXPQsQxmU6H1ACHU8sRbdhSXp6p8gdBLpMlEkqK2EkBIm2SrL
 9Mpk1QzZLRjBEel8E0XNh/gRWTQXnc20VUgY/tEUs8pmug5xsG8eS1U3icc0AAadtOcR kQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bq4shgjxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 11:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJPattpRc9Fb6RiJH5PKLCeV7/6ZkJxOhrPS2ga0C8QHXXOXScZYpgT1IDRjN3O8E4LMe15JKPHWELGHVz4WGJTc5ivm102jXrAhWHkq9UpaLAyAYbacvjD5poVFuNQeyrAaWLaPOI/Rlc2cTHHXQfTg2hAwNVXpb2NpTAfq8A00l2BJNiATZd8Xz1mv1wAcvu2NHV8Ee4x7/0jDadwJla5sOz52ezWjibc9F8DaATBzgwvG8rN9gZwd1XZlt2IhUlglneXFtG1nNuWxtEZl2pgKT/zj82jbMwdrmLpFcMMSTfcKyJcBUEImqaPC2toUJ+cMbcXmiOGd8yWHfIbH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLttT7EtM3qJ0p7gkiTjosemwqANSh66uuv5iLbNKO4=;
 b=F4lOkpZz8CsoePHWPgDN2ZVzt67kKxKL2d1TIYLV83CYDXF397fj3cFGdgJSrgWtV5u1ZRTVa+XHcp2lnaonStkwjl3WfJ4TRkpHTm5CvEPAPtQyS7CU3mu3O/Pg4ZeqdGzFTTS8n5IvLvPtZAEeWwMKWx2S2stgQv+kch7/r1sL0VcjA59FDniQBq8VM+SkuD4qU7Wi+QYpjHeU/+IphUqJNaoD+3m1pMpw5QG7VMv2zdRNP/gmJ2K2DVmbQ/MXI0tiax2W2wCZQxfrf5nzZLewYyLIbjOBh9G4Nn/HXVmEaxGeDTa+Un40B1+/WBK9Ib5KTKbat/SotSWIgQd8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB4201.namprd11.prod.outlook.com (2603:10b6:5:200::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 18:33:09 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%3]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 18:33:08 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/rwsem: Introduce __rwsem_spin_on_owner()
Date:   Sat, 16 Oct 2021 02:32:55 +0800
Message-Id: <20211015183255.3788750-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0195.apcprd02.prod.outlook.com (2603:1096:201:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 18:33:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d85c5484-5eda-485f-41bc-08d9900a3c47
X-MS-TrafficTypeDiagnostic: DM6PR11MB4201:
X-Microsoft-Antispam-PRVS: <DM6PR11MB4201F9380B6F96A11AED6183E4B99@DM6PR11MB4201.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKH/3TbGmEBiD966I9gMF8q1t2duxXRibrKafiaUQkO1PLKFQD8tA3/3v522+NZjg3tiE5y8WVZtRcYwjRdxX90BE3HdA3jWkbHwn4tcTrGXqzopsW9Fcjh1m3vfCxxTD0xVE95eIiGbJaLVTLrBAXCKfo+p7eQttH/y6BMVDm/J/q/c53PwFsK7UI5G63IRu+DxlYtT1Ury+p3o3RaDGDQj9tSNAz5vUSwWE2IhtfCbaRk38vXDO50av1nofQh+cY26CBJlkbTWsfGu1pbFeEtSMqGGbIsyx0K2LeX8sH9zwptP+EfOf6J87HESJcd/JQs8AIZvKrcDTZc4D5+8hSwAnklaas+tQr+Pbv3mWDI7QkTVEI8oQdtWOkhRZABLFFfIEJO2dZMIVKMY9AYrEos1+XuN2TsIm4GcWjaBn24B6NykvWuwccDtPz9GvnMTho91rO6DIlBozis2aTF2ywsk1XiUqUYUFsgBwc1HAdw8lIKv25qN7938kJpbFzQ6CKtjOpLjTfidO8A1QQyOrYx1+LmoW7D/xey7HO3CD8nSYFBIFUfttYWD4eOr3HE33EL9h+ts0RFcwGiJn/F0CPpZAL/Eeaf6vjilYnS1ob02QO2YPS/vTAh0iNlx6/pcPVYu3sg5RH/K8zooMy2YAoeUOtg9CuXDIFytl9qsMgeHrZLhhtlB51mE9jrBHxHRVXD3EDZ79203k2TW7pxy1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(66476007)(956004)(8676002)(2616005)(508600001)(38100700002)(6512007)(316002)(52116002)(6506007)(66946007)(6666004)(66556008)(5660300002)(36756003)(8936002)(83380400001)(26005)(2906002)(6486002)(4326008)(86362001)(1076003)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/K5RPZdktkFkDbFVgTP3tiTQPYo0cbepVPHDETUrTrFbn1waCwOiCGQLBdy?=
 =?us-ascii?Q?x6x6wu3pHTQAWVM0IhddmFCoSsf/IfoUGDlJzpLuU6kjrZFemyK5T50629LY?=
 =?us-ascii?Q?kfGxAJ/+lRZ3XrUfLzsezkKvX+JDCHuEI37TY+gqcrojpVCyUHEsWbwyy8u7?=
 =?us-ascii?Q?2CnPEE2QP+SA9SwDEihrgUM6PzX22jIO/paAUZPlBUolLXE2OMPGwEHnd800?=
 =?us-ascii?Q?sCSejwjSOItbtSIBOXU0ZkxNH3/ptw6iCDN/NjaaFhjszVVrF6GsDEimrBzd?=
 =?us-ascii?Q?WhiAxQn0GHofz3ozpk00xuujxrID4qan9HXj6jZW6eUfwoLK21N4mZEsYg27?=
 =?us-ascii?Q?XontMa9iUh7eRkRaL04jFR4vb3G6zP41gqmZwrpqeXHScuoLbNIYzmD8iYWm?=
 =?us-ascii?Q?XGf7s4ZvfWa5jVhPj/+tbUKjXvOJzaLr6Z3NSmcu+TDyaqvgm/znKGE3+qnf?=
 =?us-ascii?Q?/FCRYE6lAkCAq64tnxS0Dp7n9Dl8Yduk/wMuA+BuEV23IXBKqioiD57bSOa5?=
 =?us-ascii?Q?yZFbu0Cwm/a+5d+FozmRZ+VTeOhMSLxjh4ANGOnMoYn5tpEN4K3GQDYkMH2D?=
 =?us-ascii?Q?k2FTFfTP5WptF7mA6IjMH9CuUplp9Rjbeq1NrPE52COppkGHwcAFT20+3qq4?=
 =?us-ascii?Q?5+B/QLTdLfvtnl6D53q+jDj9wKCx8B0e+3dSeY2fs4KkDJGagSWdQKaLZGs9?=
 =?us-ascii?Q?BmCj9xVGqaDQJ9h27gJrJiS9mU4EXUzlcBSzAJEw1sSpmhy78sYDWyyypizU?=
 =?us-ascii?Q?FK8XBSBahgKjBLTSPOsVQFCbot83iwTh8qcivP3rs5H77gJM377Zw5PluFRP?=
 =?us-ascii?Q?iRWRPyGEfWt2f/2Obc7ic/mtnpsrQn0deb08Cec6SQ2TTnfNcn9J0oGdqHbM?=
 =?us-ascii?Q?b0DvGw+SZjCLdQCD+SyB2zN7JXLmNSYVDAXXbC1/5XsjTj4/avck38ULStav?=
 =?us-ascii?Q?f2g+qYTt/qem05YwiCsb+ir+VlP4p9sKIl8LA8PXQqPFqP0+hM9aBTGB/cok?=
 =?us-ascii?Q?NLA8QYDV696o+4odCKMd6O/kso8/ztWjEjPNRgxk3jZn4C6HwqIzsvBll6Lb?=
 =?us-ascii?Q?aFpPy05vJevCQ7b7VEfFPQBQkYTCdeIlg0X3pCqdMSPzlUqUAUm/JmtAFd83?=
 =?us-ascii?Q?5aYvXuXqPOdpGdAt/DJVlDm3TJXnvC8pD6QECAEUOS/8Rdg3mr80huvlxZPO?=
 =?us-ascii?Q?O6r+rf8Q/Z2dWUyrYHw1iyZ1Z1dmCAXrw7XenrRGCPwiwAyvZ0rhx9FhjWtr?=
 =?us-ascii?Q?q26xa0S8PZ/Loo+laQcLiiDSvdZIPT9qBlZVLHt8UnCGyEmqvF4TagVJjJY1?=
 =?us-ascii?Q?6nGZjiCwMVFndLI8QFfFFNTq?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85c5484-5eda-485f-41bc-08d9900a3c47
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:33:08.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CppVSlnm5jCavUM3jCm56+GZXxQuWNpu2wjUkf6t57tdI3l/bMwSbxrthPw4HiW0qYdTi7FeLUrLB6q6/idtQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4201
X-Proofpoint-GUID: dqn9W2JMGaytInGweXHL_Rj4RabQfqE6
X-Proofpoint-ORIG-GUID: dqn9W2JMGaytInGweXHL_Rj4RabQfqE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_06,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=535
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110150112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'enum owner_state' is only declared when CONFIG_RWSEM_SPIN_ON_OWNER
is selected. To avoid the build failure, we introduce
__rwsem_spin_on_owner function.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/locking/rwsem.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2bd914187399..7d85c85ad8a5 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -634,7 +634,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 }
 
 /*
- * The rwsem_spin_on_owner() function returns the following 4 values
+ * The __rwsem_spin_on_owner() function returns the following 4 values
  * depending on the lock owner state.
  *   OWNER_NULL  : owner is currently NULL
  *   OWNER_WRITER: when owner changes and is a writer
@@ -665,7 +665,7 @@ rwsem_owner_state(struct task_struct *owner, unsigned long flags)
 }
 
 static noinline enum owner_state
-rwsem_spin_on_owner(struct rw_semaphore *sem)
+__rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *new, *owner;
 	unsigned long flags, new_flags;
@@ -712,6 +712,17 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 	return state;
 }
 
+static inline enum owner_state
+rwsem_spin_on_owner(struct rw_semaphore *sem)
+{
+	enum owner_state state;
+
+	preempt_disable();
+	state = __rwsem_spin_on_owner(sem);
+	preempt_enable();
+	return state;
+}
+
 /*
  * Calculate reader-owned rwsem spinning threshold for writer
  *
@@ -759,7 +770,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	for (;;) {
 		enum owner_state owner_state;
 
-		owner_state = rwsem_spin_on_owner(sem);
+		owner_state = __rwsem_spin_on_owner(sem);
 		if (!(owner_state & OWNER_SPINNABLE))
 			break;
 
@@ -831,7 +842,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 * quit spinning.
 		 *
 		 * If the owner is a writer, the need_resched() check is
-		 * done inside rwsem_spin_on_owner(). If the owner is not
+		 * done inside __rwsem_spin_on_owner(). If the owner is not
 		 * a writer, need_resched() check needs to be done here.
 		 */
 		if (owner_state != OWNER_WRITER) {
@@ -1023,7 +1034,6 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
-	enum owner_state owner_state;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
@@ -1099,12 +1109,9 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (wstate == WRITER_HANDOFF) {
-			preempt_disable();
-			owner_state = rwsem_spin_on_owner(sem);
-			preempt_enable();
-			if (owner_state == OWNER_NULL)
-				goto trylock_again;
+		if (wstate == WRITER_HANDOFF &&
+		    rwsem_spin_on_owner(sem) == OWNER_NULL) {
+			goto trylock_again;
 		}
 
 		/* Block until there are no active lockers. */
-- 
2.27.0

