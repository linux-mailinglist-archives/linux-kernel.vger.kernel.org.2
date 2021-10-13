Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96442C1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhJMNo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:44:29 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:9328 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233922AbhJMNo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:44:26 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DC03tH003533;
        Wed, 13 Oct 2021 06:42:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=65krhgoCUj/ONJv4jCXUGa9wiynpcZwonBYO0JuHmHM=;
 b=i6KgWO7UY8OYuaHb6vZqXUHZBIjuXDAzHhclFI+AW0T6lP4fZocA1JxplMGj5Oe0P4tq
 +yGLej1fSQS0P5ZcfQv41Mqky2QLQK41DPPR3fHlOKljvSU+qB2BDRuPUrBr7gRczXN2
 JUPK0o3+uAUet15H9fpGzfWxzFEcK0QLJAA72+S868dm6GhQzpN5QCh4pFoOigypoIuy
 rdUPt61Nog/uoaHo2HOj8cN/BKlQ5Gvv0DqOuGsRRrFPSaiAXDxsLTCArvEjLKyfQqmZ
 UnnwYYEYah3GzdUjPrbeQIIeVaL3Qrro/GtmU1McPlB1F7nlPo/FyXLW87JKMCHPnHd5 cA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bnka70k5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 06:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6dwcnG8MORjXHRq6uJbBef2S1bUaqQ2+T3u4zagoWdVo+A7bjJ9nquWPj+HQoEeaOo8rNPR9GXmWhgWJ6SVT0brQlbX2cpOLc3eGDy2gea3MgBiPvQw2PgLMNxN73T5QSfbGUS5HlYHlGRHY/eScVJ2d9WJnP+QRBtlfJ2H65A1jD9u2/jwAwW8Dp2BrYqnq7lx03ND2TOVZ88TeUltssrvd0CoXOSBybrJ4XDgYuezAAH1CzKt/Q1lrymQxz9rt4g84vef5iHKDSvk2MsHZuMLI4klgcl8Veef3syfFj60o0LnnwTE/rkif+gqLYptbbT+zyc+zBxxq++5x2ZFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65krhgoCUj/ONJv4jCXUGa9wiynpcZwonBYO0JuHmHM=;
 b=mPxU6P/ji3uzJu43/FaiBmZaIzmVRNUzgXAT5rEQyUxjt7FOgGXTY3F6d1/IK+d3O2TRxbNKgBU8dDkdk9h3qXsDsqxETWpU2754MsZp/oOiKq/dEKE3jIX76V+3MNdKT+V4UrurJ9fY5lIKvCgRu+aPX28UEpOevQN4g9HXu6Vtuf4ckTMeaMun8uUEuYwJk3kFe4nNqYQT9ZE/L+QaOOoT/RMOfyhnCDkGzkCqSC26mqw0BdS9K3FBW5SkXNl01mLQtY548DxCtIuVuoKdOXftRg9dExhyy06Lcm5HT3iunV/NWittL7qqpKbf5u5mHyIFH7I6vJR0F2JemSliSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB2715.namprd11.prod.outlook.com (2603:10b6:5:be::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Wed, 13 Oct 2021 13:42:17 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%3]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 13:42:17 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] locking/rwsem: fix comments about reader optimistic lock stealing conditions
Date:   Wed, 13 Oct 2021 21:41:54 +0800
Message-Id: <20211013134154.1085649-4-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013134154.1085649-1-yanfei.xu@windriver.com>
References: <20211013134154.1085649-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 13:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b10941c0-7c0a-49b4-c39c-08d98e4f457c
X-MS-TrafficTypeDiagnostic: DM6PR11MB2715:
X-Microsoft-Antispam-PRVS: <DM6PR11MB27150D9FB2EE42EC2862AD04E4B79@DM6PR11MB2715.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieg9/H5UZ8Px+N100AimUFgJetMDd1oSdK7LL9wJ3t8I9e+aBAHdTs4Xe06u2Y2EPT1vmHsTId3O2m7s21wox0KJ3I6pshysA4WRsw6y1p1um4gACqZj5K4GvT5VBAsp85bD4GazmN2RBAUBDoXwfvznRznfWlU+WvrMBsDzRVylFx6UW9Y5McEqtbT6WgAUwAIaWtPNSOzhrEXT+NBF7gW8BfRA1A0sQkoL+Nb+BDR0U/K0eGA9mpbzEP1vFSlcADT97G+djASjpwDFgS5tvCiz8x5l5m4r727V9QVQOfBNhvViCQVABW/fRPiHOFSbb/6L7Qp5g1MLi/aq2Dn0Irt0h7+OxMr/r3N1gbBP9HjhXV3lpLEG98vWHqUh3hXNb2jysxLHRHhPlyCCRpisb6D62PGYxa35/0150NfGg0x+qN9VmG04pQ9Q6/sn8/H6vis3YPC9WQhNLYpHXPKGm8/s5Y7+N2PlQpHbg9L09m7NcsEZv7TYD0WSfmFxAqvfn6/FpfWXHkS8F+1EjE8Nz8nYKuQuJ8l9moqgQeI+o1tMWxYIr0U4zyfkSgsX1BE9AVGD779d+3B6qzDFW5/3Q8nmbOlWbrH+MS5TQPGHNDnOeN+t47Ev8AG3wd2695OD1R0L8Toeh6wZJV1ZSoWNaxmT5YJyrzhn7gL0JUqkUedmSrtjg1mmcbvgHTU1hJIUOJi0FEg44WTyYWFsvTPiRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(6512007)(83380400001)(86362001)(2616005)(52116002)(5660300002)(316002)(44832011)(8936002)(956004)(8676002)(6666004)(6486002)(6506007)(2906002)(186003)(38350700002)(38100700002)(66946007)(508600001)(26005)(4326008)(66556008)(36756003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mIhB7kdP87eDyyEVGGgGYo0l6h+qaXyv2LeX51QA8KnXogVUoJ2ZXjYycHRl?=
 =?us-ascii?Q?RLsN6XTLllit5WFibupmjfVH4DaBZzpH11GPVuEGspmwf7g/0Ae8KNVmuQe/?=
 =?us-ascii?Q?8ro8tj2PsaCRy9g3ufzXJADvY73rGzAcfyCYl3nIQRttTdbQSy9O3ztAg+7C?=
 =?us-ascii?Q?zcNpvOt01IuXkhwP0mPy6ZFTw2lxnR7bsVxqIZdAE0nm2K+kBqrvY1xiFQJ8?=
 =?us-ascii?Q?IWDe0OY2SRE78YAOJmWBAwsrwD1/OsFrMMIkXuVF9EJmcuvyJZHN+Vf+r/yC?=
 =?us-ascii?Q?gbi+yEmj4EcaquC326fS031ClLct3IwpohUF+jfhjMeUs/G5InsVejID/eSd?=
 =?us-ascii?Q?W2CGIXMnlFNc4DpEYlIRqVFzf2vTjJAYwF6Ybo6VTy5yD8rzrVYTm0iSCmDm?=
 =?us-ascii?Q?ztMN29HDMdAHeFCvvtApD7V9HY/+JQR+Y0FuuLqhqdIwKT91XpPOXGvt7l6i?=
 =?us-ascii?Q?0hJ5Dm9WuqWAClgGcCKSsYxaqxqlz1Z/Z0EJRXG+VfV5MlchKhzdbEhwqPmh?=
 =?us-ascii?Q?x4KP/DULpDRzCX6leTjPfVUDNTvj8KGYjQWSOAzzbkhf+MNrqU8r+sjJRVhB?=
 =?us-ascii?Q?pKTDiltS+0o645FufsddT08gaZDJXurOLZGhvWI2kPiDlpChMdPTb2eR0Jcj?=
 =?us-ascii?Q?bllxveqrDhHQvOtnmdQgp3nUKcqU+cyaWaqIyQN92aOpybD8uY1kvTMqx+vR?=
 =?us-ascii?Q?7CPnVBHiW/ZOsjEUEC8D5XT1mrqhonBXLcKOnGYkH1E5j8tBICrjjdKfnWbD?=
 =?us-ascii?Q?dd7maz++8cEV8XgJXsiWtkhMC11U0QQcWYryOPjC5VQlxA6O1kNBGb6gw7Vz?=
 =?us-ascii?Q?Eeju4h3t1bxArF5pEOk62Tn3lQqO+0EgJm9OBwK8G+NwJDXVYj5nRLjoFdqY?=
 =?us-ascii?Q?LwkpXspeNLNbz6SAGjNHnKc5N5QxmdEW56SB4Xdpy43Vj3v2kzq+XPS6muM/?=
 =?us-ascii?Q?Z7d0C1ywJxgm6seew5+QeoQ8wMZRQfhQXDRfQ/AitY+lz23PFME+BI551mcm?=
 =?us-ascii?Q?Q/4XwgwYVgkr4GaLlLNLkIqAR59hvd8bmdzCRqc6HJt5E/TexIXLz7DGsq3c?=
 =?us-ascii?Q?TwuXaUu/quWR3iy6yg04rLP1r6+UarZGIfduX0UTeDxUjrkkIfCxoQtNOhx9?=
 =?us-ascii?Q?96XEZMOKbcZilZtVI31MOCbhT4ff6Ff2z12s4LcsyM4zYknBU8kJxUMpmlVQ?=
 =?us-ascii?Q?3JczEKnTlAKhuevJEVjOyhClsgm13uRKo4SEKGkv0ykIMPqhnPpNcOUbmWYt?=
 =?us-ascii?Q?8LyQ1vSfiRocsz/KprU8PkFUI+QlWfWD00pBXRargRof9+1hFK0MTAY8f+/u?=
 =?us-ascii?Q?YNc6IFNPBne40Wb+tLedc5k/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10941c0-7c0a-49b4-c39c-08d98e4f457c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 13:42:17.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XChc3Xfs23b/nE+n7uKXBZdkn0C3iiDEEpgEXnurjRyt7cWAP+q7Pmv9bgbR1iZEeu5CXb/f3borF4jbP3HCvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2715
X-Proofpoint-GUID: F40Ty0WdAx0rQFLLLVQd5101_lBA2wk9
X-Proofpoint-ORIG-GUID: F40Ty0WdAx0rQFLLLVQd5101_lBA2wk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=889
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 617f3ef95177 ("locking/rwsem: Remove reader
optimistic spinning"), reader doesn't support optimistic spinning
anymore, there is no need meet the condition which OSQ is empty.

BTW, add an unlikely() for the max reader wakeup check in the loop.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/locking/rwsem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 06925b43c3e7..2bd914187399 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -56,7 +56,6 @@
  *
  * A fast path reader optimistic lock stealing is supported when the rwsem
  * is previously owned by a writer and the following conditions are met:
- *  - OSQ is empty
  *  - rwsem is not currently writer owned
  *  - the handoff isn't set.
  */
@@ -485,7 +484,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		/*
 		 * Limit # of readers that can be woken up per wakeup call.
 		 */
-		if (woken >= MAX_READERS_WAKEUP)
+		if (unlikely(woken >= MAX_READERS_WAKEUP))
 			break;
 	}
 
-- 
2.27.0

