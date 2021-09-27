Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3650D419956
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhI0Qlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:41:39 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:47222 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235463AbhI0QlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:41:04 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RAvAEj030439;
        Mon, 27 Sep 2021 16:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=PNWIA5DaiJHAs+7aYCZx/UbqEjI0XEhol8L/Dm/H2f4=;
 b=mGHwvKpX73Xf7SYDasUZRKIDe/w0fZu1/BtlX0rzWd55VdlL1imCLmXhmr/VlDjRtRyO
 f0ucfdyHFmiFwxX/RQ98Pdig0CrjdoWyC9xGEaDERM+iWLyF+15kcCqP75MV/LMGWQC1
 dz+oKaYRy1JFQBFQ+iL2hOX6uSHIGcTNRWW5lKlRXjbdgsugAy46FKXAT6+iI4I/wMMU
 a8GW2nTNxqX8VKwarQ9pD2Yn+7v/jvXDvZPO7jYU+/10b72dmxVvfiISpOmifQlIG2M8
 deO7BaIssFTPlWaGIWWm8i0spBRr1Rgl4hT2eMAEJbn5QhT+Sp/XJHy8gYHjhY5QTKaQ Kg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bbbxh8978-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 16:39:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX32wTRnzfuVLenUzmyfEgt1Dgwhn9wfYjvXVREv5aWGpkQ64+nsSkuU+k7D++WQyrIBVPZVlkcqK8G0/6HzGQShjNeGlVGDdNrBljtOWrUrwd5EeQszvp8+h8Xgrr808DvGMJsTsMhE6EzFOOBRXOJwYkCflODpy9iam38+anE34/J/bU6NMCPT+c+G0JDnWw3T/LF4EeeB1W4pcMRNHk8OGpvVtBuY2PNW8XLtmoP4Wy7x0qHkpef+bQzTmaLmydU6XtoA9v4j5y6Sd9LSNZTO1roJj+Oz2A69Ha+7DMQnFjs68/QuEV1qyzKd6Ig9NswVqo1S9mnN1E32A3kWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PNWIA5DaiJHAs+7aYCZx/UbqEjI0XEhol8L/Dm/H2f4=;
 b=iDQINOMT4dAnuYNa4s3KaZwtSSlp7pDcIJ0ERh9ZPt1HfudqBfmSdRo213eX1ugHF1fYCVI0pl4Agh47XCAZQXp68PjCJbKJ7JzQSuqukb/jei7QqjIhfx7q21d2tXR1DjoI6itqPRqLGt6OawZ0u0zZVLG/S4rafz8UIpjHVxGDYmbiHExZBXnMXb98ehIISrEwMh5KK+Uko8nMsI6vP9hZk7PA6i2qNTdZ4K0AO39KOZcw/sIU8CnunPUVQ068Sd05u0FDGN7ZwcM83j8e3leQ05cd3ynVgdXgACkeiSSADDW+lX3qRlNHAYsYCLhsZcPxJXeNqcoiiWaOtmMHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3593.namprd11.prod.outlook.com (2603:10b6:5:138::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Mon, 27 Sep 2021 16:39:17 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 16:39:17 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] locking/rwsem: add preempt_disable/enable for spin region
Date:   Tue, 28 Sep 2021 00:38:47 +0800
Message-Id: <20210927163847.3308333-2-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210927163847.3308333-1-yanfei.xu@windriver.com>
References: <20210927163847.3308333-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7 via Frontend Transport; Mon, 27 Sep 2021 16:39:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07e3acae-1348-451e-8c9d-08d981d5593c
X-MS-TrafficTypeDiagnostic: DM6PR11MB3593:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3593DE726B16E5011295B206E4A79@DM6PR11MB3593.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qpt/CyPDGk+RURaT5vg6oS3zVT+4ylRexTNeQtzqjxwsazIeo2kpXQxUSxqbOKrlAce899pn2h727xjVboSq62e43GLz+Gsr/w+n26AfCM3jvK5mM0kyKVHVvMi01DzkwIvmTogcSj47SLgDUhT1MTZ7uZqvGPKBv3/0vA3KPUKNAnaG6NVzJMFwhDd+esnTMpjcT7dkwtiVP4c06pxZG+V8NKITonTy1EUXmchXmsxhQKb0wDVgWSb1lEoKF6+4z+gFfvUDRM/Au6ocFxINgL0w21AFy2Ixbm+rQlQFHQjy76nbXa+ZEb1iWO8Q07NMlhQyvSt63mHDcbfgPosoaTMgPFWKVrMKQP/cj5pCUTi+ZW84L8wECXSwaPJsbkB/Eq6iFjEV3d2z2aBgv92AdmYYgEig6dmIAoBWtzngDgqBSO4pAUGKb3we9PcNxkM7+62G8RZIVTADyPgrtJqdN2AjUBIzq36FpJEn5aNbUA3RQKnfM9ZmihaQq1YXqxLX7HY6RkySmsYDMeeM9eAMpWLZ1SGsK9jxIaFgaXouP1bmmKrwyjoYLooXu2FpQc9SEBJG5/U0R3bxiZJIUPPbsZNaed9pIYxqGGmGEBkxcIsLHP+ek5bBSksxsGQrMOb5WUgW6WeywypPExLOufLRWFyhnSpV60fPkPiBSfkNhXf9/R83kHhus0xNEk0Fl3VXsBa2/rmfdQoVHzf9CtQiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(52116002)(4744005)(44832011)(316002)(6486002)(5660300002)(83380400001)(6512007)(38350700002)(38100700002)(6506007)(36756003)(4326008)(26005)(66556008)(186003)(508600001)(66476007)(6666004)(86362001)(2616005)(2906002)(8936002)(66946007)(956004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jPvfYfGClgjpJbNMLOCCZ4PxvrySh5wUG0ldNB9vxQOAqIH9RoADYRJyqp5E?=
 =?us-ascii?Q?J9nCqr27c3ChEjlScAaKmhZEUHgbxLBktJii+IbTM3UMnRt7NCeHjo6jDZOg?=
 =?us-ascii?Q?3U7kVdTjCOS0zibo3jwcvB2kr+0mqb20qtwGEKRUGgX56fwRbUfmr0smHSaq?=
 =?us-ascii?Q?Z5ru14FCSTB79dKzcDHGDJZpolv8uCRDV1vGZalV/+G2t3vdno4VV/UM2Uor?=
 =?us-ascii?Q?WcwakQu7p8Bo03Hk8/oys+4S0JWqpZuGwILIlz31BFZF42yPKW5RcZtCvYvn?=
 =?us-ascii?Q?N6hvbi6R4E4+/zYEPJWXtUy8KlG/Fy5xgJrY/HTDMSM6/d3kaoV/3py51btZ?=
 =?us-ascii?Q?wf1yE4KYt9FW4rWgAcH49BKJ2qP++2i2jiwb17wDcP2R38b//lZoPhF7rZKS?=
 =?us-ascii?Q?Gdun8PRMHG12PikrZ9pFzFdFk0Legs7DtAW+TENj1ND7oLX+sIH4SqIS0htM?=
 =?us-ascii?Q?0pi+AQW5c4LXUoyJDUDdVHDGM9CAwtlwGhWNBuJK7G2narGdMPgZ1lNM3SNZ?=
 =?us-ascii?Q?tReI9/dn7r0ogz5rChluAD5PAMm9EjaYeeD5E9tiUIlsk7HWAsd0fxG3XrGg?=
 =?us-ascii?Q?PAIPEj7TzbFgyIUx87eCdxXfVyXytZmbtyLH4TmPmJw3DIX2GQSFkt5Z2MV0?=
 =?us-ascii?Q?iDwppaJzU2RqSaX8GFsAMJ0G3V3Ghb41VArEYbcWcEsjLfjb+X+uU+dFj3ux?=
 =?us-ascii?Q?p31R1yvhhDwdUD0axw24bAz++vm2l6eATuhuYvW3BD8bgTYRCEkMqJtAx6Y+?=
 =?us-ascii?Q?HIyRQF1AewYmOZZgSGPIIpFWWKmv5OxrKj8vJHjiDsboXN1uzVL+7i73+Jlf?=
 =?us-ascii?Q?BlHfdRXQBIcbjN0yNUY9l+9udn9Zvn52bCya58sKOovZ2oCG/vaF27Y5+IYC?=
 =?us-ascii?Q?vuiX+k/ApfJPWPunEJPqGxjlZiIgH/mkOeYSPnfeV/o6SugqFHKP8Ac8Ukok?=
 =?us-ascii?Q?+QsJOZnS2BADC9gcljPKiz2yEUsbCz4RHdDkH7fiXDEVf0Q+VdBFuZIyLjrL?=
 =?us-ascii?Q?eMggfyFCZE+KkAd3oVLtjZfF7suHWs/n7ZYgdlDdQqRmoYD94znETRW9Cf3a?=
 =?us-ascii?Q?Mlg66C8uZXrlI7KfGAuYD+USxiAGkqaykEStv6qofh7isq/tADGeh5S5HtvL?=
 =?us-ascii?Q?bW9Wj+sK6DyhB26vfoNqiwjQ5qu+0YNXSPtv466oHT4OKmTH9fCpPA5rbKoo?=
 =?us-ascii?Q?puo4dpw5wr561+FADbujvMXQRuWIbqffhaHm5DF4DT57huc+kWq1uf8TQ16Q?=
 =?us-ascii?Q?jz1ACsDYE4G91BQQb41aZyLkJwSZGAnSZWg0L1wY3MSTKqKoY42I+z9WHcCF?=
 =?us-ascii?Q?b9Rlfkqnyq7yUkZocGioNsKV?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e3acae-1348-451e-8c9d-08d981d5593c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 16:39:17.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECpw0CuSkWYErrIOSRwZ7qe0P8Q2DDXHPwOpr8BY56XSEau9M1YK14uhUbpI+6GN+MNVObLiTsOR4zVtnt/IEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3593
X-Proofpoint-ORIG-GUID: epdzOOs-iNZye75HixbdnI7GjUXAdYVU
X-Proofpoint-GUID: epdzOOs-iNZye75HixbdnI7GjUXAdYVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 mlxlogscore=469 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rwsem_optimistic_spin() invokes the rwsem_spin_on_owner() with
preemption disabled, but rwsem_down_write_slowpath() doesn't. Because
the spin region should not be preempted, add preempt_disable/enable()
in rwsem_spin_on_owner().

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/locking/rwsem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2907f9d8e4a6..db3a6a06a9c8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -674,6 +674,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 	if (state != OWNER_WRITER)
 		return state;
 
+	preempt_disable();
 	rcu_read_lock();
 	for (;;) {
 		/*
@@ -704,6 +705,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 		cpu_relax();
 	}
 	rcu_read_unlock();
+	preempt_enable();
 
 	return state;
 }
-- 
2.27.0

