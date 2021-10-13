Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8EC42C1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhJMNof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:44:35 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:65090 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235360AbhJMNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:44:27 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DDLL2t007838;
        Wed, 13 Oct 2021 13:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=W7U7AV44iyVs2k46onVpdZs4NG1TL3nhPLc9+QT3N2c=;
 b=LGqmN6w7fEFT2f/nFS+fitYgVbQjUYkrGcFk8yqhp7hLiv7qgJjr7lEq+Rdqvh0jTW1p
 xcosGQgf4/HrK0HgjjtycdlIa1JWEPLb1SmpZDNnEkbNgI9C14aKEy3Riw/+wK75lSIz
 T/MI0cW7Tb97DXTXdFfwFeM0Tx04fJzrsSheN7IQumEx7gNvumv63VB0lyNUSHfnEKkd
 ha122mOYwglv/lFBJIPYHmZNdvQOQ0Qaa82t5/uhXlfcOnumkKmn/+2weO1BPaMUEuD/
 WahhPpoCYlD87ZFCYh6J4TsxUrnxvtCRaos9M4Z/W/vIPcs2hN9sU20E2vOerIabf9A8 +A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bnka70kjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 13:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWkz1p7bU10X9PghhA6PFoTWoIQZ74VIjTYvzsHmF3LdpF5psThcx8LKt+F9jp2Ni2qSnNMzzE8vglCYQ+jsZ3JPAjMQ9b3qEsuj6XQs+7UYBWdQQMw1/4aCVONjxJj1LiLVjVj7KzjvKLICdndgBfNzeQyj9kG7dISKm62sfOI+Q7SK45+0idhw0Glpf2SMLPB7Mtmy5z587HR2+yVuHtNaHsJKB78tsgqWXAuISK7XFoLx7SfqCeozPbvnV9RxyGiIzkopVvH3h9kxSYL6PL9mFsFLiDwve0hoLh3Xp0Bsm1xxjRSJwzNvpolOPeqilcgxSXBxrz7nANx1gYdd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7U7AV44iyVs2k46onVpdZs4NG1TL3nhPLc9+QT3N2c=;
 b=j7O3U6POZdG8qfu7HMejr6UFraCNzQwxxYYkfMhgridv884CvXnl01AZcpKUPSmu2viWh15kkY+FFl0RMJbDhSTbbqK0ZKR+c32frArWDWFAdXmCC+CXqs9GAD98D5ayyOgmf13q7wXpRvXlKW2cZQbbgP2dHp2kkJ6LOIRbnfwAjxXJSf4AlM0ikdoZ74NE7zllJdzc4RaXsvsYKDCInxHIb6H3AzrIw7WMt7ZQ1iu9dXFjB41K5Eqh2G7GaqgDDaLkGPKphhmSsWatC0srCs9dj3KtAvLH+pS/5jcHNpCZDJt/3wqEy6XlQAhXt642evh1gGELZ4k2KW4A6WbAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB2715.namprd11.prod.outlook.com (2603:10b6:5:be::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Wed, 13 Oct 2021 13:42:14 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%3]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 13:42:14 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] locking/rwsem: disable preemption for spinning region
Date:   Wed, 13 Oct 2021 21:41:53 +0800
Message-Id: <20211013134154.1085649-3-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013134154.1085649-1-yanfei.xu@windriver.com>
References: <20211013134154.1085649-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 13:42:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a85f040-06bc-45cc-1963-08d98e4f43e4
X-MS-TrafficTypeDiagnostic: DM6PR11MB2715:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2715734BEC7068BAE2D0D716E4B79@DM6PR11MB2715.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8gFHS3SdcyRLE2BaoSwHnI2vpOxJoCYiupJvz6cUi6aQbC2I54ZyJBXLOBte+nuHER3McrX7SOjxxhHPBZFR/KiLPIfFAs12rFv14+jSJfTm5WqNPajs1gM4Pn0HwvlyDf9opQXrtFfV5GzQ6g7hUM9V1wCGIHCJ1EKjzqIcrTrWRg7mxumbnR2Ak4PTs8h/3d2GnemxAEBzlJeEoCZODo+y5wW5zY7xWczDVKYaKTYXWokR6HwIeoHp0e/qDKTdTpnytrZ55dBssf3cIzigRO2T0VMSV1ci7rDEQiehMOR+lHgIADJ+7fwdyjgUlRE49Cj2ZHAeZL0M15muh2D0+f0pN0QD4kEKkv/mt/hqpO09KPcmqozFNMadGHe/PgYRg7/SDiMtgKxQAGXyvfxmHdppy5V9yW4P73RtKtXVh07IDojSMZNerbalHuYzNlrxPf65Z195TChEJmfVcDWPayt7JaPLKp4BKinkfrf/HQIcxD7NDQldVJ8kq5qh8TpXlXNAMpKocjUwR3TQQjhVP0H66qi5j90rF8KA4rfRd3mjpHOtnqU+N5oLXLT2FMpwwl1Yv17lD5cfURcBPKc/cWCabdSdP4wZdwv5KfEtb2lXMUg1ukHi9UZSbZuvLG7J33YRhDaXRfU8FIsZDB+KZ18t13+TtdCrvix5Lc6dcjVZuONetCNTT6T0LoSd3kVRAhbkvtTNgIqkwnUWG48Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(6512007)(83380400001)(86362001)(2616005)(52116002)(5660300002)(316002)(44832011)(8936002)(956004)(8676002)(6666004)(6486002)(6506007)(2906002)(186003)(38350700002)(38100700002)(66946007)(508600001)(26005)(4326008)(66556008)(36756003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k6l0DwavuO8Uj2uYiP27or6kH2nBL5WXqmkHhMyN+G1OeT41ePmletADY57c?=
 =?us-ascii?Q?LbO1Rofe+uzwLFwzQVZBn0vPOFfR6RiBy4u81rkwnSHRWVZoBA9AmXwwzd2I?=
 =?us-ascii?Q?plPUNHdvdJBex6f5FXdrZH1YwhJdicXQfSKXDmGT/6SPLF2hcYTjm9GwI5hv?=
 =?us-ascii?Q?grPXRvGZxTpEDxVaeXeKxgT6gKipta6j2wK9WM+n8yK+C5f6ERBA1jYtiJ4w?=
 =?us-ascii?Q?B2jTKAJ6OthMAmL3ex9KMKnMa9n+UOyXzpa54LrAw+9C+5rCApWfeh6EAtk4?=
 =?us-ascii?Q?RwZmMmS0DOQTAL17vvBhDatt9Yg1kk/qR3wR05lWAmR1koDEdIgsl+dnc6Pb?=
 =?us-ascii?Q?/lmwX8BFLvUV7HIR0Yp4t2D8d84HYdc2gY29G2WFWGti7SCTfKk2yiy+/oxb?=
 =?us-ascii?Q?HqMoaA6RPgMpnMt9GvGnT0AhJIKaxuO72YGn6OYKxCLmyG2QO1IGSxWYKaPj?=
 =?us-ascii?Q?FGZJtAlF9cAdZCI1Op6T3I/qbx++n94S5qWBK5KE9/XnR17AzTgk+r4MqST+?=
 =?us-ascii?Q?QUFEHFSz1CQIwwu82dqZ7oiWlZIHu92QQ+vLQFTSS8SBvSAaW1ENeNi5WFZ5?=
 =?us-ascii?Q?YCwar6v0WXztk6G899dl8wscbZYK1i6l3O+NBt1tD0l2o2KjHCatFrEg7GCh?=
 =?us-ascii?Q?IK4JOOdw319765oozOjXSx78AZ4UGAYoHJdIAntqMuefkoz+4n5y5S97SZge?=
 =?us-ascii?Q?gh8KnjWGai+W3KHuydn2TBuTzTzuAhbta/XdwaVMom12fvGZTN06xMzqxWYx?=
 =?us-ascii?Q?IKEbq6SSgzWZ6YjGo7ukstxLEGN00YXvolAgP53sX0IbN565FAzZmXITxDYy?=
 =?us-ascii?Q?cHTKii3VAJUmXqjaNq77ca7b4rZNxHzzzWG6DAzJqhCdZ761AZg/M5X5xMhl?=
 =?us-ascii?Q?mCJsXFDVXPRnFJa1NU5TLglRSuExmqxwGR0tJUEj011Djhrd4aRz5X4iPd95?=
 =?us-ascii?Q?D9my7v16ANLyQN/jC6lWppPgNWc0pu4HjDxw7rucmcH0W96HpKYPvPH6lmeM?=
 =?us-ascii?Q?q7rBkU6DoNdWe+Z7KnN44ZLbY2Kn1OfqZF9dTvez7vdAI9qZA7NaLQd6a6vA?=
 =?us-ascii?Q?XfO113QD/X140b05lWNY9g+EjkSwaT9KiwWRktWmbPyq6cN4fdwI2+k0HzOx?=
 =?us-ascii?Q?2XzIbyNVZSc5CHZv1y/0dWq2oYRYfTrG1T0DF5YfagTzXMi7SnT8rPHriA2U?=
 =?us-ascii?Q?FJQ2Rdk7A0rvI2eAbd5ki30vbClvTMRFEOt8VeMvZ/jXkoznb+5wP7Vwgj4q?=
 =?us-ascii?Q?CP3opibtmrm+Bg5BQiRwye2N5oHic9ohjlZ5coaMebkG6hn4QnWTOLt6nI1l?=
 =?us-ascii?Q?BYhIBaLjZ/RKUkX5TZ8IaX4V?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a85f040-06bc-45cc-1963-08d98e4f43e4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 13:42:14.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6froXDLmDZ88pAvjXt/CihTwoQbJjpkmvlKiqrN7s7DrjK02qtVC8n2tRN7QiDj7F09NzX59G/oxZEZGcDDjhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2715
X-Proofpoint-GUID: b7xsSs3VwchAKinU_4Ukqwbt5_rJ73qg
X-Proofpoint-ORIG-GUID: b7xsSs3VwchAKinU_4Ukqwbt5_rJ73qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=513 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spinning region rwsem_spin_on_owner() should not be preempted,
however the rwsem_down_write_slowpath() invokes it and don't disable
preemption. Fix it by adding a pair of preempt_disable/enable().

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/locking/rwsem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 7b5af452ace2..06925b43c3e7 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1024,6 +1024,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
+	enum owner_state owner_state;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
@@ -1099,9 +1100,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (wstate == WRITER_HANDOFF &&
-		    rwsem_spin_on_owner(sem) == OWNER_NULL)
-			goto trylock_again;
+		if (wstate == WRITER_HANDOFF) {
+			preempt_disable();
+			owner_state = rwsem_spin_on_owner(sem);
+			preempt_enable();
+			if (owner_state == OWNER_NULL)
+				goto trylock_again;
+		}
 
 		/* Block until there are no active lockers. */
 		for (;;) {
-- 
2.27.0

