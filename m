Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044493B7D09
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 07:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhF3FpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 01:45:22 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:11380 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhF3FpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 01:45:20 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U5e64Y002147;
        Tue, 29 Jun 2021 22:42:43 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-0064b401.pphosted.com with ESMTP id 39gf0u04bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 22:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFFJG0AkS28B/Eu3evZ0bFmm6nZHKZpQT42UjUY9WFLSW26e8Kgjh0CX6/N3lUpJ+reuYIwc+RLywdW36eCwvqMC3jIYRVvXmVMZuDZOeRHUZk5CdszmLAFapre6EZv9YhmSUPvmlIGtJxwrNQDF7x2aTCwVhILGPgEyrgwq6YIV4nCgJ6SSsjbBLqxzisdA4v1RMdHZ7P5Z3x8npvuRw1SVEAAuSNyJH/sRU/S217Dt4LaIQi70L4FnEuOpMfZ9Og84eJkljCmHtE8ouSu6x9E/DM0JryTHmkib1qoPBpaOvdqFs7uIbyU+WzIdzQzMCbcQg6F1ELwSrVxXufvU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtgx8v3WNV/YOPPzQ1uPGVYAf86/hkFIiXCSh7XdQxA=;
 b=X0g8IMrsIl1weSPlL1xYJBsIJzQrqrkTX3OBmMabl35IA4DbOnAS+vjlffZMZN8NtmUwjPQ0yBw7EhePpKmNhOLFmKfolZMB+sYNuqBi9IQM9k8XDSjq63B5oziP+Zs1lIxzJ8b96oRNaX9RJ6mHHzXDw/usXKwzDlWeBLsI0Lj62j/i80rQBgAfYhCL/WzoaJHqkCLH9CyROMeU3kXwbn24leIphP2R5bgJyS5c+x+IB5z8YOqwp5NadVP5pF8ltC5yfb/bsUjA8zPuhyTcHYWrbcAgks7hG5NjgkmcozTSnKNFnA46OtcHml7xoCXWfcxyqRRwQx3HuTGk5bcDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtgx8v3WNV/YOPPzQ1uPGVYAf86/hkFIiXCSh7XdQxA=;
 b=pCZLUVME3Q34vGEomosC7qN7xx4LOI5o+++RlCRt8L2l0dBea8nqoyg1n404wN8ZQXmwL8NDK4wu6seuA5QrkhrsTcxkp0DMF4Ka0BWiGJ6LEUg3qSftpGQ7tVn30jJFJX9JyepSSMg1LCEzJlItTrhhmSynJaFpdHBLFRprTTA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 05:42:39 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 05:42:39 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] locking/mutex: Fix the handoff mechanism doesn't take effect
Date:   Wed, 30 Jun 2021 13:42:24 +0800
Message-Id: <20210630054224.13495-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HKAPR04CA0001.apcprd04.prod.outlook.com (2603:1096:203:d0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 05:42:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c33679-b4ef-43ff-69c8-08d93b89df28
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4816:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB48162AA6B057DBA69D7482E7E4019@SJ0PR11MB4816.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShnNacyCKX1oq8bXtel0mEbzC8vhHCjAsUNlFHBJm1edOY/44Xb5lSUUarQB5KhbsC4hGwsMl/++nptOBFlwCiEGuGQ9e3Qjtw8AV57Rq1r6aIzrSoIIp/gFYLyVIIa7tDHkKDuS8ozjzL9n4g9FFH4EOQ0DXqh4HgpCaS0ZUSZDP4OkRrbecoGfsoQxqd/Ec4k0eYuYR18CReUhWxnmU5FTwyuAxQNLD1FHTN8Bb8dkhYmq9bTqYoRw6KOJR3c8M0a9biou2Xd10/wZFR/5i0R4RGEbN4f4e3owln/AvDoXmGUzL6+z9Da2Qa2FzolJUAszci5em6WYRJ3YR4JSIIMFDvXGrFYVmnEh+8fdJcAJ4/tszJJPQDaeAgJ8WZS2e5rlEtNa8uHtNZYOLuyksA975NAjCzqLWdZW0vI1NTqQjLtO/0X9aMrx+Jrpu5LkT4OgMR65HI0m3YlYLTS5udrjuKazVJM4FnwT/crWBRonJDd3ztzjkY3gRuLkbrMoyNMuHfddxYuDVaVHDvMg6D8yqFNZDA4dAMnPp7XpPrp2lCWL2XvwHsn2zMnBMkw8PRiITiYsgavTycRuTLeL66Pv1AP3IKPX1JscAN8Fuv1dGV4bBxo6eUnuT1S6H478antkiBE3mJGKSzwWwpz8QbeCwUUD8ow3VyZv9sciAvtxEva/DDkJpOAMUa+VArIc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39850400004)(83380400001)(44832011)(38100700002)(4326008)(2616005)(36756003)(5660300002)(16526019)(86362001)(52116002)(38350700002)(26005)(6506007)(186003)(6512007)(8676002)(956004)(2906002)(66946007)(316002)(6486002)(66476007)(8936002)(478600001)(66556008)(1076003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+sKaDm8ww5v+ONknYoYcrFLxIV6IrRAV/txKkwCrLSy1R4+pbBDXU0ZfOI7c?=
 =?us-ascii?Q?zdz9P71dceg7IWcskoYW8oKFnhwJrRMt7KURnjUNXSFpZl6S10Jz4oap6+GC?=
 =?us-ascii?Q?T0IpYvRsXBYuXw8VFImU63RqT8kTy17HtdNDY8aSYHxg/+5TJKY0lzDuKcps?=
 =?us-ascii?Q?GkpKmRNA4encKIUvQtYSy8rNaqa7nwOEoU35oyUdav82tIGYCpR+i2/1R2oK?=
 =?us-ascii?Q?GWDg0fBilW64wNJksK1ly4RKMLnOyIYoUVqhds1MwmaUU9bVu74VTQH0u9f2?=
 =?us-ascii?Q?Hb3AYmNXnHcWekQO1Aw5mGR355BVhc98cBlqZi59YHqsO4elGnM1H3Ix25xT?=
 =?us-ascii?Q?LJ/Ux1CMWarCRTjEYA/ye8wZPpSb1ljLTioO3t/vPkTZRSJPk+ixQqsMV1lp?=
 =?us-ascii?Q?x2lYLX/6UzdzuqrGTdl9hs0eZgkt02nLxPZVmfC+L2dXizhqNkRt4EZHNtRK?=
 =?us-ascii?Q?CtAZ67mbFdWFcEfCjmLrmsrYwOEgnWLPOZE8EFDwVO2teSCpFgL2DHmQDWdZ?=
 =?us-ascii?Q?fGff2dKw6PE/Lr1PfJeHlDJF8IWX6qApCMzUlvEIHX6GkaBO9ALwdQXhA5FX?=
 =?us-ascii?Q?Hul0LhoucumbcbYAI9kL2WqqHBCkBsNdQauDQ0nAJERMoUUNh2gz99KzMXKD?=
 =?us-ascii?Q?+Ci+RFp2rrva6D69HoYvt6yGEZOMdyDRX3dhVhzgWXiLEp5SELnBjIMjM1vv?=
 =?us-ascii?Q?btJvv1blFGAXuEyQIgJX3PfgJgetkoUtwj7Q1i2lo6evG8JBIkNP2IYQlFii?=
 =?us-ascii?Q?9kyA1t2d0mj8Pah6rw6ZtDUnJOC2our36N6DqAOgHzANjUzwaHwq7mRbHp8Q?=
 =?us-ascii?Q?HN74qAD5gG0SdXyQVv65m3/ue2vdX3vpAV1mZ3pefx68U0Xpv06lq/ifFFvn?=
 =?us-ascii?Q?poFdEsHia2Wt2JEpv4QHq0/fMTzSFVOcNB5gziZMsTdmQKujVvEQZ+dN8bL7?=
 =?us-ascii?Q?mVgoyqahNQ23TvEKAXy7LUf2QMHY60hP4mn+8uGg1w3w85XDsNpxt0WA/jfx?=
 =?us-ascii?Q?4acks9AkGIGAILvatEKJevMdasK4huLJGAeljpyGwM14IGE73dRzlIsHgDEj?=
 =?us-ascii?Q?hNjm0t17U0dMeVgQgEOoK4o10/F1Q/TiWdyHzJYpxIZnz5UZNbKQ3X1H5sDy?=
 =?us-ascii?Q?VQmTVfwmlQi33wtMrvyuwb+/rCEX30h4vBbCM/72pUbeyxi5I+KKtU134piX?=
 =?us-ascii?Q?u5BQ/9SQugY5wnOL3LMkGsutBEZrNP8XYH7fBYyByCr1e3+a7UUsGx8/A/yr?=
 =?us-ascii?Q?+uU+9Gz8mG0frFreeJyiN1MFpmxbqqVoRDkrMnB6a1SkaFg75wZlL7bKP5r5?=
 =?us-ascii?Q?wNFGoZEo3aUdhL8jkRlthG+F?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c33679-b4ef-43ff-69c8-08d93b89df28
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 05:42:39.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4ut/qEruwPvZI9dPzi6jheKtugpsOKF5ItCmRxGyl1oLhskY69UnJwi4wLjmmrrSL8pUArmEkvtoYccWDgvgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-Proofpoint-GUID: HoCrGUlXZfWh38kx0BPLGlgPSa7y8a7H
X-Proofpoint-ORIG-GUID: HoCrGUlXZfWh38kx0BPLGlgPSa7y8a7H
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_01:2021-06-29,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e274795ea7b7 ("locking/mutex: Fix mutex handoff") removes the
judgment of "handoff" in __mutex_trylock_or_owner() as blow, it makes
anyone can clear MUTEX_FLAG_HANDOFF bit when it gets the lock, even it
is the stealing lock. That makes set of MUTEX_FLAG_HANDOFF by the
top-waiter in vain.

-               if (handoff)
-                       flags &= ~MUTEX_FLAG_HANDOFF;
+               flags &= ~MUTEX_FLAG_HANDOFF;

We could fix it by setting MUTEX_FLAG_HANDOFF bit before the top-waiter
in wait_list falls asleep, then It must can grab the lock after being
woken up. Instead of probably being stolen lock by a optimistic spinner,
and being cleared MUTEX_FLAG_HANDOFF bit by the task which stole the lock,
and probably fall to sleep again without MUTEX_FLAG_HANDOFF due to the
task which stole the lock falls asleep.

Note: there still is a very small window that the top-waiter can't get
the lock after being awoken because no MUTEX_FLAG_HANDOFF bit is observed
in unlock path and then wake up the top-waiter. But it doesn't matter,
the top-waiter will optimistically spin on the lock or fall asleep with
MUTEX_FLAG_HANDOFF bit again.

Also correct a obsolete comment in __mutex_trylock_or_owner().

Fixes: e274795ea7b7 ("locking/mutex: Fix mutex handoff")
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
v1->v2:
1. Bring the assignment of "first" variable to the front of
   schedule_preempt_disabled() to make the top-waiter can grab the
   lock when it wakes up for the first time.
2. Correct the comments in __mutex_trylock_or_owner by Waiman.
3. Rename this patch name form "locking/mutex: fix the 
   MUTEX_FLAG_HANDOFF bit is cleared unexpected" to "locking/mutex: Fix
   the handoff mechanism doesn't take effect"

 kernel/locking/mutex.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 013e1b08a1bf..ba36d93e65e8 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -118,9 +118,9 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
 		}
 
 		/*
-		 * We set the HANDOFF bit, we must make sure it doesn't live
-		 * past the point where we acquire it. This would be possible
-		 * if we (accidentally) set the bit on an unlocked mutex.
+		 * Always clear the HANDOFF bit before acquiring the lock.
+		 * Note that if the bit is accidentally set on an unlocked
+		 * mutex, anyone can acquire it.
 		 */
 		flags &= ~MUTEX_FLAG_HANDOFF;
 
@@ -1033,17 +1033,17 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		}
 
 		spin_unlock(&lock->wait_lock);
-		schedule_preempt_disabled();
 
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
+		if (first)
+			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
+
+		schedule_preempt_disabled();
 
 		set_current_state(state);
 		/*
-- 
2.27.0

