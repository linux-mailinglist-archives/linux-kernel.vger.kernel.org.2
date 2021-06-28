Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C23B6641
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhF1P5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:57:55 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:1918 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235476AbhF1P5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:57:13 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SFY5WZ022726;
        Mon, 28 Jun 2021 08:52:14 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0064b401.pphosted.com with ESMTP id 39et3ygs8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 08:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBA0dWpdrFAObjtibW+TZ/nPXoUmcjEzEJaEJDAx2xn2cFvO0k2PU8k27mG9ZtlDN1UKEkcv/O1X6TaGjq2tDlCfK6hFPPRBtBaVQXY6/2PtnrG7eo0nw4XFTZWZWcbVRZ4VV/Y9jNDdZEsuzaLXz/Y/FeabJdAjGdr8yqwG3osmyS+5V1l4jGc8cRZTGZDVfj0c6F5Fiyxkq9X94M6O9l7I9Z0jEFq6TPaSZyKA/Aoa2o6Y41/TMOOLwNDb419DUlvMUMUnbDvYP1R/R3R2g8O1znzep+Pboe9881HVTfXFk1mg1e5fuM7goXZfz/Jm+dtjFbX3ypyDttmqcEk7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNEnlm4SPovRXdmb6p0fpyKnkrR89DVT1nKLcqcbnPc=;
 b=R0N1o0O9rpqNwfYk3HKmXXzoMfjkqOYnvAJMzOihAVKYLXcomxD7StqGLVyK232usTbET9cRVwoGH0p8wKyJ7NL2RTEX1dGqOOM1TzYasqaPvAc+o5MoIl4Wf+2UtBqbm2hc4BNnrZQzPeXDG1xMjkTrrfenpp85dL8x4PgBFyCkLp5+pxbD4twwqVDxTZNEb0f+lTD6Y9h3OwChLgDZksL2qbkZRRvTZX7cyoLfLqsufrHx1G1FzU8b15kTkLNF/ZfQF5K00kuUMdOJeIZB62WvUS2cCVIbEDki7ynlgG4HXqjHRz9Q9A9dYxR5ndJyblNITnk3eUGUNkKJHI1cIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNEnlm4SPovRXdmb6p0fpyKnkrR89DVT1nKLcqcbnPc=;
 b=dOmW5ddnknl8O424fjqE/AyOSMxhOIJHHLueE9cet/axIVyUD2Br+/833S3ABP5gToEm++udAxcrKduykMB4/ga3FJZpeEgtqbg5I7cBdloKNoxJ43iB72cJtfzldtqX8QYf6qt3qI3Stm6wPqhKGa++ouqLyga0vcRUUnzvenI=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4101.namprd11.prod.outlook.com (2603:10b6:a03:18e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 15:52:09 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 15:52:09 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/mutex: fix the MUTEX_FLAG_HANDOFF bit is cleared unexpected
Date:   Mon, 28 Jun 2021 23:51:55 +0800
Message-Id: <20210628155155.11623-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0023.apcprd03.prod.outlook.com
 (2603:1096:202::33) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR0302CA0023.apcprd03.prod.outlook.com (2603:1096:202::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.14 via Frontend Transport; Mon, 28 Jun 2021 15:52:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f874262f-b7c6-452f-9c64-08d93a4cafba
X-MS-TrafficTypeDiagnostic: BY5PR11MB4101:
X-Microsoft-Antispam-PRVS: <BY5PR11MB41013892026D8F28DB9018A6E4039@BY5PR11MB4101.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu9OnPOkV14GTNEy5ONtVJjbmJ3gfX6x8n1Sm7lVpVarehqnm0yWHHE69YBrqPoHP0nD0AWofJQU2TtoRgEO3qlfB3LcIxkBdSMc5vCqg9xz+WvTDV2S2xYeys7095D13lg3r6Xr4tvMLeXYcVKX6XhX1PrQI+tqUFY0vR7BN14l1aBNR3P0HKiQp8onIMl1bqGMckrpGIIU1XcPPHmrjHIIeae7AtHpNsRAwwbR91Bzm/9day6uZkCU385vPgXvtO6cMrxbp/D1EenId69vXMV1X9SWqUg5xVtGOGTreayjesluRGgSuCMzHaV4LbqWwUaXV36Nx86z/UIVAjfMzeBySYHrLdARuNFF99f7VIR5w2yD5M9YyW9/759wBk95KyBa5iMxD1rPHhBe4SkLyeLu0rVx55APB2H5wD2ltQXQujCrl6ja0wfySkW2zW1aXz2wPFa7elrJmd1T8qHOrXBwYwTcv883pIgoba7b9IYydxPxSP+pARlY7jycnRpa3j6JfqPwEHCyyvOOfXqHyCkoubkY2IWryQlot2mZ/Vuv50ECC2vfZWBICj7oDs2VrWFdQnOHyzMOcnkni9zsRVZADqlYiqYRiwb7fmhLIc3uAtqtor6IL07BvREaC6TEr/UG/7APwv1pwChvANl6+xBGA1VZ/RAJFX9M9id09ULwIAtchQDNy1KtcmsxmT+v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(396003)(366004)(2906002)(16526019)(83380400001)(26005)(66476007)(66556008)(186003)(66946007)(52116002)(6666004)(6506007)(8936002)(1076003)(44832011)(8676002)(478600001)(36756003)(316002)(6486002)(2616005)(956004)(4326008)(38350700002)(5660300002)(86362001)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3bxPhBbr+k9O6xIJxTGSQSZKVM4DY3ZquSWQ3Rpf5ou6DNrrGY5s/Ql/jQs?=
 =?us-ascii?Q?dXrwREPF3O/c4PpGR4qv/sfNNiQanEFYmXvhbYUgqGFlCmS9aASY6+pzMSJ/?=
 =?us-ascii?Q?iSbiiTOez2qF92tQKClPcSCOuTb7BlWFfRWuZ9/ZRHemfguuZQ1QZ49jFC3n?=
 =?us-ascii?Q?+G+RYrDcU0WsmjUZm5+ZJZshibuSVgJ1mhuToy5TfAyqEBsaJ4w++3luvf+J?=
 =?us-ascii?Q?47nR8ynGBJgbWFwJzC5KC7WbAZc7S5jt5Y0AYQ3e1bWf+p9vubh09Cy+5QYu?=
 =?us-ascii?Q?ds8UfNBF6s+GWb/HPH3qcCy2+k0ecrzExh0S0QHk+aJVWE3AwRsDCw9sMK40?=
 =?us-ascii?Q?yp4Y5qDYdK0DrOlbzUFLENg0fyr2BwL/uwyBGlM7oZpSj0z99omRT1USJlco?=
 =?us-ascii?Q?5ewvoGqBL13d/mbiKqtTlUuYyXCUFXzPjCXt9pSndF2cjXb8+hBAu1LubJnB?=
 =?us-ascii?Q?hG12D7CSqyHAM1zDCWuHAunksExileBC8vEZuuaifRBz+IGYLHtHlfcSCEsd?=
 =?us-ascii?Q?Zmsos9EvskZOM/VpSg2camJycjHwAqVvQ0T7e81lr5912asbVSuzBwyBh27Q?=
 =?us-ascii?Q?jflR7DPBTBr0gKhNJIoJEUer1GrzXAt18d3JWtOjOIGhvgZRQnQ0W7NTdGk8?=
 =?us-ascii?Q?Kpt8ICSY6i4QMuhXJXFkKYD4sHNkeFZjGv7OQeATxCvI0JYBmJnMP1dL/U8T?=
 =?us-ascii?Q?RAugoNMbJN7yDNByPfkWApYKawU27/AXBmVjGLmaiLMgKJFK8VFBmSvbktT/?=
 =?us-ascii?Q?WPc9ZXaovxAhqebPwvTZt9uoflM+GgWEzltRRI0boKzwl6AJFTgUiAjjAOjH?=
 =?us-ascii?Q?2kcMSrhj3je6FGhNnAOf4YZ4WUJU+r/0MkZ4hl/4b292eiGDcsw9/ydY3xoj?=
 =?us-ascii?Q?TbVQkqrO6Z9oc2Qw4mGjKEhPoxVeE1EoC2rUqBNtPnQ3smnIkkj1Rme7qqZV?=
 =?us-ascii?Q?ZUhwd5Ui+zdEm+Y5VcC7w6avRd+ikUuint2A9p6npnO2ay3LoP20vJgVdmPG?=
 =?us-ascii?Q?Z+nHGbRmPErWX2Nu3OPNN4qqkAAaib+UIsHG/BVEgdp3ORu25oFuhmGxr8HB?=
 =?us-ascii?Q?aB6O2DTvR5Gk5u55MvDDzRWrxoY0nEYFH0O06oUihwvnnbjlCrnW0PzlfKl/?=
 =?us-ascii?Q?AUvGNTXFYpeA7C7aaiq+eDC/A7/1GVPe2vAWjCqQvYIcG4vdMB2VRl1hYznZ?=
 =?us-ascii?Q?SNJLu2qp/Yl3t4vhMCNm+COzR3Gzv8Gqj/1/PtRkmTj1JHMtI4mqS0WQV+SV?=
 =?us-ascii?Q?dO5uiw6dJDVuY84T/wrGnvgBi1cAJRMxR6hnWj4qgfdTjh4I/TYkDdtWQv8I?=
 =?us-ascii?Q?7MT4xmiaPSWN3CcIb0VuTcHG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f874262f-b7c6-452f-9c64-08d93a4cafba
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 15:52:09.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +I4NlGNIPhhB+7XKiac2WRHHDMyrQWWkOuSnb+rDqxCYu62hzNayukDEHzg46F83o3VIaN5SB75ONJ7BTZy3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4101
X-Proofpoint-GUID: iBxNtcT-q5dkK9Y62uI7vW-GifJQ1Ro_
X-Proofpoint-ORIG-GUID: iBxNtcT-q5dkK9Y62uI7vW-GifJQ1Ro_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_12:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the mutex unlock path is excuted with WAITERS bit and without
HANDOFF bit set, it will wake up the first task in wait_list. If
there are some tasks not in wait_list are stealing lock, it is very
likely successfully due to the task field of lock is NULL and flags
field is non-NULL. Then the HANDOFF bit will be cleared. But if the
HANDOFF bit was just set by the waked task in wait_list, this clearing
is unexcepted.

__mutex_lock_common                   __mutex_lock_common
  __mutex_trylock                       schedule_preempt_disabled
    /*steal lock successfully*/         __mutex_set_flag(lock,MUTEX_FLAG_HANDOFF)
    __mutex_trylock_or_owner
      if (task==NULL)
      flags &= ~MUTEX_FLAG_HANDOFF
      atomic_long_cmpxchg_acquire
                                        __mutex_trylock  //failed
                                        mutex_optimistic_spin  //failed
                                        schedule_preempt_disabled  //sleep without HANDOFF bit

So the HANDOFF bit should be set as late as possible, here we defer
it util the task is going to be scheduled.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---

Hi maintainers,

I am not very sure if I missed or misunderstanded something, please help
to review. Many thanks!

 kernel/locking/mutex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 013e1b08a1bf..e57d920e96bf 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -1033,17 +1033,17 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		}
 
 		spin_unlock(&lock->wait_lock);
+
+		if (first)
+			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
 		schedule_preempt_disabled();
 
 		/*
 		 * ww_mutex needs to always recheck its position since its waiter
 		 * list is not FIFO ordered.
 		 */
-		if (ww_ctx || !first) {
+		if (ww_ctx || !first)
 			first = __mutex_waiter_is_first(lock, &waiter);
-			if (first)
-				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
-		}
 
 		set_current_state(state);
 		/*
-- 
2.27.0

