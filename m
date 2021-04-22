Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF85367D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhDVJPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:15:19 -0400
Received: from mail-eopbgr1320101.outbound.protection.outlook.com ([40.107.132.101]:40063
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235491AbhDVJPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:15:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdSvIy55Jra4Pq8ep5jBCn8mDlOgQU/AGowTgQQ/aU/MJDQjPKzN2VeCVYq2titkKsoOBSeMxZv5Q7R2MUAczbINQvNtdBwUf0/rByEknNU4xdCEbdfnC7emP10+LxvYiG37GCKjCZfODvkirZU72hXUMU+sV1FIrIcoyeCWC+g2QhasWvrgpYxC59e0g+ebSmEzw3TF4KlGVdqIoZLRtqahahfts6hIe/gSpMPE2ixcXQV3pwd94gRfHb0WLJAREjjUgAlB5yfTLKJTOBoRu3VKBpnfJWHoQfU2jvhmApyW478fczy+uiY3sRxzHNtYGn3QNnuvmdz8YwyORNkhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IbJCpvuRYGhL/DFhxU3ujfWHgtNFLdbuYDvd31oDP4=;
 b=S7SSizdbyewrbA1dxYZqj9fJp8NjzNm8YVnPDk2O5t7TvW22K+/vBWWrd4h1AxmMKkBxQwSHOOsoJRVNRry1U62XzWo7LDGy0vtEAIdXyLVVZ3vdI6UIqi46mRasj/n1xTilct9Jvz3IwXUPFeG2Fxe2nQxA6yx9AACSUbxlCL6Ny4Lu4zykvbhwgEh/PdPxHfVe0xgljFIsOHi2re3LDRaCt43zi6V9KlzHBJKrHoGKtXJXKZWZb3lHe4uI0rCE9V9m0mZ618wrz6tHwCkXFTsuttasZAZOBm5p3qGlR8L3ZrKN5RGZIaKgWIFUc2XJSW8hYGBZ4p7XVfDif4pGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IbJCpvuRYGhL/DFhxU3ujfWHgtNFLdbuYDvd31oDP4=;
 b=hGQ1mIYFWnCGxY3hw7k194Q3a90XimKyuUcI76RRLMr6zAeenrEBC38gRTAFGlnOgTdVDOGF57gnO7sCnAIr8HEbq6o0soI1jaBDy2NovZ6qKCTXZcNTBdlIvIhmi2nYZhEAOJ/7mjA5T2RPToER2p6JdPLRn/L0b/ZlhXRxnuICiCFixamdl+NSnJsrnI0ElMMd15uEq4vwNFU1PnesIawSSlyutrKQGrVpVDUnujwWkZVBZAgAuWMyk4W29Zh4uNYRAbrLOxWJiaSwKPnpyd7HRaKDhvDGlCrpCqH4/FedUCJbmIwSm9pLCzsuV7/L1RRPVkseCvJr3kbvNCPbhQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=zeku.com;
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR02MB4610.apcprd02.prod.outlook.com (2603:1096:820:47::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 09:14:31 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::d4ea:8f6e:275c:5ef7]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::d4ea:8f6e:275c:5ef7%3]) with mapi id 15.20.4065.021; Thu, 22 Apr 2021
 09:14:31 +0000
From:   Hui Su <suhui@zeku.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Hui Su <suhui@zeku.com>
Subject: [PATCH] sched/fair.c: add helper func for util_avg and runnable_avg calc
Date:   Thu, 22 Apr 2021 17:14:16 +0800
Message-Id: <20210422091416.19432-1-suhui@zeku.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.102]
X-ClientProxiedBy: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To KL1PR02MB4788.apcprd02.prod.outlook.com
 (2603:1096:820:5a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from N50001309.adc.com (58.255.79.102) by HK2PR0401CA0021.apcprd04.prod.outlook.com (2603:1096:202:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 09:14:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78fe39b-3ca2-4c70-7e3f-08d9056f09ea
X-MS-TrafficTypeDiagnostic: KL1PR02MB4610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <KL1PR02MB461086677D2DA8A9BAFD1F9CC6469@KL1PR02MB4610.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4Wb4aQkIkZe96luoRCMBJpE26dFMGaz5zq6+cKoq4me6VRNRa47CRrcjsblJK6RaqDabbAgOfynpDFFK4QVCOy/4Pk2Yhvgq/JLlHLCk34txC2i+v/NIiUXWudugLTAKy18gbJxmHBtCaFNKKu+0+IGpgiPw1X6cazZyEsJYAgYzQnvQ+nmIo6RiFXGNpN9NofVlV90re66Al5p6ybN+RFrAMrYQMxeVU9FyjwnBAKuIBPiUB7i6It5y+p7+KTf3qVeOij9GlsWdDhFsqA2mGmUf3GXm+/juT/Zey/R1Kn/t29au/Y/9o+yl3cmU3+OTWLiODi7Cd7yCJmBpI5ZvOXFRBM6VUfcEzjQ8RRPH38oooAvuKocIKtvWGlpc4p5+DcbjebfUbOwaS51Je9L6jis2nytz9VNIv03rhlNz59yyAWEfGfBmkZK+vHSs7nhLrBrLBAVE10TmqyXt5+vMFRLzObmr0RfQJxA0+eWzymCJ/WCEJCQHbLgtQCtXK9cw9niY1uHTuszZ3bAzS8HCwpmLSMJRLXU2ZOl+9XKUeB8BHPS/z/HB+e9VmQejPIRppjgySfrmwNl/OwjpxslyTkVf3aEq46siDrF7Q8BpxJ05DYoZ2MpNQOWhUNZLfHdG2i2P/77FYBooqJAgTeY/BHwnttGcLdo2s/gcrQckELoul0dH5AS6PSij1ab/mbz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(136003)(39850400004)(36756003)(2906002)(956004)(52116002)(8676002)(186003)(5660300002)(6512007)(66476007)(66946007)(1076003)(66556008)(7416002)(6666004)(16526019)(478600001)(38350700002)(316002)(2616005)(4326008)(6486002)(8936002)(921005)(26005)(38100700002)(107886003)(6506007)(83380400001)(86362001)(11606007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MHonK+gt5rKLqkJGrYEjbYJK7rh+efKfQSlGWk69nyOaSFsGFOkstk035tIT?=
 =?us-ascii?Q?FZd5waShu8YrSeQgqTdNpxnmOGYPcJW3Gzp/OzUggTN9IBevjxJZkmMAl0Bp?=
 =?us-ascii?Q?YT8rQFzwxWN3qplf1znAL7gn+3jjhhcBXPCYqcQ2WCC0VCQAJCnx/AtheHEg?=
 =?us-ascii?Q?yhGawLl7m0i7o0gCWvJRZQtipUv6cGXoHel/j+wmMimOmieNB4y6jFPrTtMr?=
 =?us-ascii?Q?Qomy0BdqfJ2Uxil2IdtItpuoxYaqxXRY9XiAsYGMoERvp8U25OhVwwyvZF8d?=
 =?us-ascii?Q?5QS4OB/46YKEJfIBy5l25FTQFEfbIRe9W72E6684DWL6AMeJnVtLOWwJfPpT?=
 =?us-ascii?Q?MUnUjXGyHPQiXMwrzQNvj/e1dSbj+RFfyPeQLXRD4pmb5Usqqq23X2lh6gCK?=
 =?us-ascii?Q?fxTdcCYrOAbgIZsJKrQitd/XKxEgnJC558Y+t4UAudrSbaIMocO7YS2gMrhK?=
 =?us-ascii?Q?qTdntIEwfLMsX+PHczOTjEKrUQk4ME+C3kVWoWv4/RZZ0BRQ6ZA6RYlSQotm?=
 =?us-ascii?Q?gNBx1aoe1Xk+yU5y/pzRKTlbrV+29EjPCikqfzuUT5vqqX8zjYyoRVZPEKgw?=
 =?us-ascii?Q?w/kF/BhoJUhZx5cicK9aK4WT7WvYzvij1o3A/z8e0KVPx/GdfdeDEnCZvJdB?=
 =?us-ascii?Q?v4JwG/UNiOQXiOWNmIKwOCz2UtZyaEHHnWs1NsxrqKbwwDKn+4TthzEkpaDw?=
 =?us-ascii?Q?1mnjyJ2CJDQzG8TmSiy1cxBM5+lfRDaHTqLVr2V2ofhFolk6H7jas63ugHKP?=
 =?us-ascii?Q?06vlF40Ox+Sc9ELv84Z/3wK8xaFaQzCPs2u7+7EpUNDpovcQxo0K+L48ekOU?=
 =?us-ascii?Q?x8WwFHRLDbMqeeLwr6yCVDoOviisuBj7jVVLAs/4Y2PiZ8is2MlDFCQsNe2v?=
 =?us-ascii?Q?T6eNVdKdC0ptCm0b0GSfJj+FCY2bNk47IQE7AgrD1kdmtHixVaItZAR2Oygk?=
 =?us-ascii?Q?wmDtQpo0sXW8a6Z0q2uTfdZilVG7Ls6jzuU6xqVbpCa2lMY22mNTNzASMEdO?=
 =?us-ascii?Q?ISRxkjHAvhMW3FnPCoR4jl0Shh2gZVNvyaj6CeII2IRPrDH1zqFND2F2iTEB?=
 =?us-ascii?Q?E9xVPKaKJFaJnlz4G6zuyJWkga48+anpatDEdrbUW811LOGRuPsiwchjK4Js?=
 =?us-ascii?Q?huzT9eolU28FcSqWIvPLqNqNzyJ635WHNVELt6IFGJd+/dV+eK24Pcx1LDnb?=
 =?us-ascii?Q?kAgI4LmgagcDO/KxGTl/vAFjZzhXkdiKf4GMucn4kvu/7YmL8b0HezwMtMEs?=
 =?us-ascii?Q?nsvwaj2OMoFqbv7XPT37YMhI3gOIEpXJR/a/+Wo8Pky3CzL7gZBpaGDyMev7?=
 =?us-ascii?Q?+h5xWRDoeEP2U7Cu6njOhbSe?=
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78fe39b-3ca2-4c70-7e3f-08d9056f09ea
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 09:14:31.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8vloJG8dWikF2Tr7BpXHDdyuk62rXHYf2Tqxi3as/jx5VO/85Vp3idJsZHN0HCL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4610
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add helper func for util_avg and runnable_avg calc when entity
enqueue and dequeue. No functional change.

without this change:
size vmlinux
   text	   data	    bss	    dec	    hex	filename
19889268	6632812	2429160	28951240	1b9c2c8	vmlinux
size kernel/sched/fair.o
   text	   data	    bss	    dec	    hex	filename
  40044	   1569	     96	  41709	   a2ed	kernel/sched/fair.o
ubuntu@zeku_server:~/workspace/linux-stable $

with this change:
size vmlinux
   text	   data	    bss	    dec	    hex	filename
19889268	6632812	2429160	28951240	1b9c2c8	vmlinux
size kernel/sched/fair.o
   text	   data	    bss	    dec	    hex	filename
  40044	   1569	     96	  41709	   a2ed	kernel/sched/fair.o

Signed-off-by: Hui Su <suhui@zeku.com>
---
 kernel/sched/fair.c | 48 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..bb8777d98ad9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3068,11 +3068,47 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
 	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
 }
+
+static inline void
+enqueue_util_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	cfs_rq->avg.util_avg += se->avg.util_avg;
+	cfs_rq->avg.util_sum += se->avg.util_sum;
+}
+
+static inline void
+dequeue_util_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
+	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+}
+
+static inline void
+enqueue_runnable_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	cfs_rq->avg.runnable_avg += se->avg.runnable_avg;
+	cfs_rq->avg.runnable_sum += se->avg.runnable_sum;
+}
+
+static inline void
+dequeue_runnable_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
+	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
+}
 #else
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
+static inline void
+enqueue_util_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
+static inline void
+dequeue_util_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
+static inline void
+enqueue_runnable_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
+static inline void
+dequeue_runnable_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
@@ -3729,10 +3765,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	}
 
 	enqueue_load_avg(cfs_rq, se);
-	cfs_rq->avg.util_avg += se->avg.util_avg;
-	cfs_rq->avg.util_sum += se->avg.util_sum;
-	cfs_rq->avg.runnable_avg += se->avg.runnable_avg;
-	cfs_rq->avg.runnable_sum += se->avg.runnable_sum;
+	enqueue_util_avg(cfs_rq, se);
+	enqueue_runnable_avg(cfs_rq, se);
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
@@ -3752,10 +3786,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	dequeue_load_avg(cfs_rq, se);
-	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
-	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
+	dequeue_util_avg(cfs_rq, se);
+	dequeue_runnable_avg(cfs_rq, se);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-- 
2.25.1

