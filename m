Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ECA418815
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 12:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhIZKTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 06:19:23 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:13514 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhIZKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 06:19:22 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18QAGg9n002394;
        Sun, 26 Sep 2021 03:16:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=VnibkcL22fu3ZjWjrkgpXfl9nam5z58iQQGugxxoGuI=;
 b=frv1QELN9xzXEXbe/ci9OHmLuIaKF/myJSYsYqR91O78rvnPPO1XublNDWKCIwOPCfxr
 5xAILVVMZwEsPQ/KcXn03N75d0+Nf+BUSxZrrL/pwxhA2vF9lUJdLamT+N2iokDTHthF
 nzGnMDb5n7mfV9Ga0YhsK1VQiXEUz1SFanRGCf4s6Ym2XA2+BGqDH1wEL8QaCabJBAcE
 NnEK6C5VyIt4jsCdnfWmu/VvTIGJwLORvppwtFHVFAq2rv4O15V142AmcJBB6EYQ4f4z
 ZJiGQpmm20pj28HCzjYihpQ5fgpjpdgLeQK9v1+i4dI4E7Iuk2pBA5S5LAhTTehasqo3 5g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com with ESMTP id 3b9y220ks5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Sep 2021 03:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIonhtcqr5KS7PnNMR0G0mJ6v3gN82RHXESbzfTY77aOk6GtavOJzG+yAUKgnp3mw9XIry2eXdwb68K9qzJR8A3TncBDACAw0aPzSsujk72OYslM34wcnKHWj9UdecjW/zc6oSzCkRmPGAfbPKh5QHkaaPPI4O8xhiU6eu6MOFHxYl/GP5nDCuCzhZkS3Wc5fkZ0VGW+lQUmnevKNiewY5ehb1g1zzkwbP0ElgyeGJGOSdWYMaZDL+hJtOnhMFf+3XZRz4UI+d1TEB4ODr7ZFE/epvTee1TWjYXI2REvrBmZuLJApK6tWLQn0STim5AidatzwpM4OYqtqd4LtwFJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VnibkcL22fu3ZjWjrkgpXfl9nam5z58iQQGugxxoGuI=;
 b=MKNESR3+fGWMKptw6I8M3MhQla5dTTfLFzXWg5Cl+bM0CvftY1ABR9knYDgb8vLKNG+YzlGgzvo6iq7Yuytx6v6eIthXMDe7hXd5apElwJpmz+WPUoaZ1ywmocx6Viu4iOGV0X08WhELxqmVqbAuF2OyxHYvFpFWFjtNXNMpmkYzlhn/i1y7Fh5WEbEE1BTQalt9hX3DC0zOKBcoV06nt6zqCzWU6gAFKuJzLM7nLVTibOoYmYwZZ8hb41Vs3XKGeRJGAuGG6lpMYlz16VXiuZsmoZX1Ad5aLniA3lgeDZJo1pPaDpp9ty1pP2M1lyxMWzk4291qGKuHkbU90JFhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM5PR11MB1579.namprd11.prod.outlook.com (2603:10b6:4:f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Sun, 26 Sep 2021 10:16:50 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5%3]) with mapi id 15.20.4544.021; Sun, 26 Sep 2021
 10:16:50 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] locking/rwsem: Use rcu_read_lock_sched to simplify codes
Date:   Sun, 26 Sep 2021 18:16:24 +0800
Message-Id: <20210926101624.2460704-2-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210926101624.2460704-1-yanfei.xu@windriver.com>
References: <20210926101624.2460704-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0166.apcprd02.prod.outlook.com
 (2603:1096:201:1f::26) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0166.apcprd02.prod.outlook.com (2603:1096:201:1f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 10:16:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dde9af9d-4b68-4178-4066-08d980d6c13e
X-MS-TrafficTypeDiagnostic: DM5PR11MB1579:
X-Microsoft-Antispam-PRVS: <DM5PR11MB1579E604332A4745929A5761E4A69@DM5PR11MB1579.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84rY8lG9WhKUlcyyiFwz7yHaWnbKITUjEuVuEl5d8kQKf50sP8muMEnCP9fLKaNLhZJKdcpZAg97gxBEUXZw1/rD6m6wUHjv8d+O/yV2v4I7SWssn6WROw1Q6/7p4WNdAAzPtx6/o3jv59oUUOu0mgUzeQMQBVSFZR1JyWCIai4iNxnLWezUFtZQcWhFCdbO5pDYW2q634ZQTjRpqBns1r/3dPHcTrTo0w3b4ow3ax67Xyt8zeHO/IrQ5eWjA9cMvNPJ+VTlchhUVHUT9SW84wEYeUR2VII7lgEHnVq6/qA3XxuGn9goE1bd+FEcpkx2W6vHsWJJXd37sLzhmDiywEqidY4CSz7W1VB/TIeH6mhDBJiSZyB6HlqDfoWeF/x4NxX7NOr+nDpwIzJ2jdZItQTudrppbFQ6sNNShjb1+c7KOIdY2yy1wFGTTBuFhWWOTeq+ZfDD2CPrQ3Mcal4QyaRYh72I9Rotlq54OHWnClMrS8TnkjJzxgIqkUvi49uEZv2yk9J1e9Xq/H+FICvgbCuGpV2FlHY/PhHfKDcJGY7ZUE5Fw3ftUnEUuc3DcLAac+cvkHvP5/A7wmCLlDjRKwLtwnw1xoJ/N1pcSDhu03nVEG5vkXM8X3acaDttDY+LUKyA1NN4UUJp7y88yD1fx61oo7HkebNH3j0MUorcCd/TuOG9IwHyz3Z7Zz7XHOhAkpV0hg+KM4Km7M84rb8NhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(956004)(66556008)(66476007)(36756003)(508600001)(8676002)(66946007)(2616005)(38350700002)(1076003)(44832011)(6512007)(5660300002)(6486002)(2906002)(186003)(26005)(8936002)(6666004)(52116002)(316002)(83380400001)(38100700002)(6506007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H5bfQPsmexfTQ4s6Ezk/+H/RNjtUBJd/OWZ2HyG0p2oqrCQfnPRCbMQjifhl?=
 =?us-ascii?Q?l+k0e9O8QErv+Uoxl2Zxbq6THKKBSEp6ygE5MrW7VXf/EwpilRlVFXKC9qhj?=
 =?us-ascii?Q?Gp3Lw8upmO5CRVESbMA+r7D4Ekno8OtmAtVzNRbc3bDLVsanrj/WhHYVhM2c?=
 =?us-ascii?Q?q6kKZ2bkjai8MWYRLX4kP4TtnPJmljszWcUhCTy/GL+2WyvfxmwnasAMVzBX?=
 =?us-ascii?Q?F4g62ZSCmB8O+HikGwwGPIqv7bhJPnyTl0qq6AEqh+piUtBsRqCAnxBa8YEy?=
 =?us-ascii?Q?aYU4bJkiNJEmYywWLhVmvxMNqF3uDbuO6PeI5NeSUKpC+R5PVdnrxHe534jr?=
 =?us-ascii?Q?Xxl0ZtMJVWMYCNvFuQdty+3lZR48RiWgG579X7A5BzWtne0TOWrhnVOz5+wY?=
 =?us-ascii?Q?h0KBD27bEcXpRRfsgrcoDzl9aw4UMH/Tz7GBcK5RRd/eR/kUfPkI5tVqMPFj?=
 =?us-ascii?Q?+6Gsqm1ep2gZNXdcmSeL3ejNjUdZVPgTUOWi4rXO+UECFNTDZhKxu/p/FoBa?=
 =?us-ascii?Q?XqDEzDmbENycBNJCA1B1rt1TqziIv+OicbAIJmMFQ69/U+RkbR/jOx7MJEFu?=
 =?us-ascii?Q?RQMoUzcR8EImx9/cPLnzCJo3xlOFwEYtMVIbofdax2t/MXRxDtOOmYC+pSx4?=
 =?us-ascii?Q?sXcjavmbYTEsJgdjPG0N71GYNJJ2ZxDMRivvc6ek15mxkD1LVKqQ0h0ePp6O?=
 =?us-ascii?Q?ru5gDINNpPRd84/FiRx3WK8UT/SlY3ZEKdptU9bGXmvfIdHvfj40IgaBshmr?=
 =?us-ascii?Q?RvU3Azc9Obli+efg/DaXtmyCRPUi8HIUy9vwgqGcsQoiTDSVf3wN3VqCHjMs?=
 =?us-ascii?Q?PBFMljIXpMBU0b7dtHnI1Bn2G8Qtqr/X3uM+fHZLzK47O7beWy82qFfAlIeW?=
 =?us-ascii?Q?zoMS3fZP1fDho+dDvHNJopzpBkwkeTHjpXXw26gIfCxXVGa41XAig20uq43Q?=
 =?us-ascii?Q?LeAZ/Bbq9aH4SM8XS7+8Uv9J02IZtRxDgq7MQlXJLL6Ic6eMPIwPbmL9tKTE?=
 =?us-ascii?Q?oLkGNm9STC40IvT1K3aQjPGFKFAzKd+tU0VCdtDhCrzZUeeJJVk+p+Qv6n6O?=
 =?us-ascii?Q?kMakdgAMlkJv1KcAJevRozCShwMfnwNfmfoxIne8wQeGN5+JDDwOAjH/0h9U?=
 =?us-ascii?Q?zpDgvjTw5/+7l0P6LKZOMW1IetptmT+5BfUHyFKCia2N0BFP6nYaBCoEY9f4?=
 =?us-ascii?Q?SROEmD+immffr5EWhosJvi5zDDVnT8Oe8UjJ4W/eAetVjN8erijBCwsPv5jq?=
 =?us-ascii?Q?pf3UCBSTywmKaRJvXdEsOQ4FBtMSEd0E4e6BvDI7qshgqafnKiH7k62EUCCC?=
 =?us-ascii?Q?87rJ/nqL7euedWSBvidtRCwQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde9af9d-4b68-4178-4066-08d980d6c13e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 10:16:50.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/7zic5LbbDPQbT8n9Tv9rDufF+MzCt68vCW0rYkT72ak+6loiOSXF0RttVx1dDW+/fxr0oe/na6MApLOmLFNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1579
X-Proofpoint-GUID: pryqEZVHLHnepQtcIvle0Hv7Nl2FIV0z
X-Proofpoint-ORIG-GUID: pryqEZVHLHnepQtcIvle0Hv7Nl2FIV0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-26_03,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 mlxlogscore=725 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109260071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rcu_read_lock_sched to simplify the codes, and it also saves
some cycles of handling rcu nesting counter.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/locking/rwsem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 000e8d5a2884..7afadfe02286 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -616,8 +616,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		return false;
 	}
 
-	preempt_disable();
-	rcu_read_lock();
+	rcu_read_lock_sched();
 	owner = rwsem_owner_flags(sem, &flags);
 	/*
 	 * Don't check the read-owner as the entry may be stale.
@@ -625,8 +624,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	if ((flags & RWSEM_NONSPINNABLE) ||
 	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
-	rcu_read_unlock();
-	preempt_enable();
+	rcu_read_unlock_sched();
 
 	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
-- 
2.27.0

