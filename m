Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDA740403B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350423AbhIHUln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:41:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3022 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhIHUll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:41:41 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188HxiEf004863;
        Wed, 8 Sep 2021 20:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FYLgrTuRQ51duEd0p/HCW5zvL7dxN4eZUTntKMleSnQ=;
 b=G/qhScfNoZwa9VWBiu4ZzH+8oyO6uYAzzqEcA3CYACy0nv6q0d/f+8/vhRCHn0hqvUmd
 8B9l8fJyfHVqZb+3mzZHOlc2XqTwfFRLxGGvNdlvI9gFzIQyey2I2CEMZf60cseEuTzJ
 XfS0Yo2YgnG6cfCBfyAcZdghZ90n6+Y6CY8JQml7M+85cL11XreWMwvL3t6hL24Mpjl8
 D7sL+soGpNROUjKSJDThen/WwFzpBwoOjc/s4NV0TYexKTakbZZW3moTmy9anoVEzG2V
 A4eLE/FVwPbQTkZT+gZUFTXbrwNdR5507rDt/YrYM/8c5eeRlTcsGTwX7/F8YndWPwav Gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=FYLgrTuRQ51duEd0p/HCW5zvL7dxN4eZUTntKMleSnQ=;
 b=JoMV5q3QkmkqwNpveLLAcFunzqILp4DMyaE1r9ukwoRzGkA5owK7az0vGI5QLSI3Svfy
 4NHFppGd0zJmtDPkyDv6gzJ3Gj6SAiOeETLraGMjEBl4PFyX5KDfU1R9hjyqN+l0q4wV
 wQmboRHeTNeycYkoD6VqOuHt9kyv7gwl7LRFaOgDWBu9qcyTLP6CJbg5ityrsSSXdjhQ
 +S9uNkf0mY9fom8KnWKHLI0vU7WhoOrEspE1Z3pXecl2QbFub6xGb871k+ueiC/v77Ua
 vROQUI8r+mU+a0nyufr36DVCuHfUOT8Ft12ewKTCBnPIZMJWD90Kt/Aij4N7ZAoMUIoJ nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuqc0ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 20:40:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188KYqDO094681;
        Wed, 8 Sep 2021 20:40:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 3axcq1xkkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 20:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNGeyoVojR58TXDZZ1O9cEZDVbkP93ieZqX/sAEel7qBHv2TQzzPuVtOHupr1vxnbt4OAETaAQMxNuFuEh19BKG6gQiX/B2WgMGfLtZOl3v+PbyZ6sM59gTWKWe1J/e0QUm5qavCxA1LInY3Oc/ZWw3v+x/1GYsmIDKnQ+xR9zHnqURcU5PPnxM9tywMfg3cMfQAPNhsIqUmtCGrKTu/NBuntWmsOjGbgfrGuz4MiSFJbpDGhSFB8ni04igc2bfI/v8S3KOQL0T92ArD3NRk4gE0ZOMmc9tt0/H3ByZ9m43LqJ5ea2AuEGQDQa0uzSD+sf+ViQa9++6kGkqmMPVyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FYLgrTuRQ51duEd0p/HCW5zvL7dxN4eZUTntKMleSnQ=;
 b=XGP/vRRJ+fmJLnzVubAi5WdmlTkSpUDYGyEReS0U3k/Fg85pefNfUJ0Uh3Fc1pF9HdD7a3UG7NMQR4L+YpEnTDBSHbj2MVR7iBTkgA5XPe3jJCozPFMxNNK88drNQzUPTbDN7lnErf2vkhhCnpwxW/KLXs2XNPhD+XoTxw0ntH3dW/2CnIGS/2U6J7lk6HSsllEyZOtOqZKszVyo8S2pE3JlFWMDnBSHdjXfwMUTDcoY21rEDQM1eEbRDKSBI8LQmT001GDnhhFKnga8n9HZO44IrPL5C4kcQKx+7aqMEkQDpr4iBN88Rp5M3IyBWViMkLA9WtvchO8DWG0NUHOi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYLgrTuRQ51duEd0p/HCW5zvL7dxN4eZUTntKMleSnQ=;
 b=bclRZcpOpXc4cEPEyzky4HzcbhrkIekiuuNyAfA5KT2hiuvNdY/kJ2/5VLsSLBOSr2e/1EWDgz5FcBK1uhmRwz23EIqR61an9++3UyBLK9c8si89mTFjAXXnITFw+3p3aNUUdLSBz3y1/0tswxhBSORFhy04hBXN2vSzHsigLlw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3416.namprd10.prod.outlook.com (2603:10b6:a03:156::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 20:40:02 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::a01b:c218:566a:d810]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::a01b:c218:566a:d810%7]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 20:40:02 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH] sched/fair: Fix se_is_idle() for !FAIR_GROUP_SCHED
Date:   Wed,  8 Sep 2021 16:39:46 -0400
Message-Id: <20210908203946.1261798-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::9) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
Received: from localhost.localdomain (98.229.125.203) by BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Wed, 8 Sep 2021 20:40:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194f570f-a11a-4d2f-6b8d-08d97308d4ed
X-MS-TrafficTypeDiagnostic: BYAPR10MB3416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB34166C9DF9A12F546F283192D9D49@BYAPR10MB3416.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFGyXyXTWxal9f4hXgGxkkpButRCeNMy+RaCKeJR29bL6e8DbnFe1pN3UgaOT+H5OlxpzAXOdhBFwyde+kp9m3RKj7gCY+YaaEBySTnIi/dJFjrW9xPhP0J3PfUXMCGbKGRBefM+QXYd540sW2+Iu9yMqgdOFcLvvidkqfpNNCelajaRBiu4ssK4lZTu+/dd/X8tqF8gaJ7DcgBSrC1vjvQ7NNBbAW4Gpc+WyQt/BjtFCuUIIijkj0nQm/DEEpl9RLjKBJFMWINgtFKhXNwXeOaUJivsz4T6BKNy7aZCGQb+YuqqAbghNV48JcH5yvXVoFTWmeJlQ+ax46WaD6tthThqjS4qkBTVM2GtklwFw/nZq5Ln6uq8KhTJh3cA515nc4LPaehnhs9BhBqvLPw5dkWiniBkNgJAtJI2j77m6sK7lqDPsUKiLTGRVVoK1GF/8A3Y3rw49AhlTNhhDK2G6QtifiNY2Y9zkpu657AGDHVt+t00HXuX49GqqTFXNn1S0k1GPQlduo7rsbj37K386y3qd46UbKZOlcDSeNbtkzSACbAiIWC2H+tSb+eC6wG5EKLMHrLlVU8eIjn6cZ1GYVPbmxPqmvrNPV8AE92fidfjjFJcErzxA+8IgOnIcySJ5hnZ8NQBSAPYgnYokEfIhz/xATBrQ+6dkX+vM0KPzl+rrth1vJ2BftksnxH1rU8tfzhxXqkfU8OQ+fA9aQlpEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(86362001)(52116002)(38100700002)(956004)(83380400001)(478600001)(103116003)(5660300002)(38350700002)(6666004)(7416002)(4744005)(316002)(2906002)(110136005)(4326008)(6512007)(54906003)(6506007)(36756003)(2616005)(107886003)(66556008)(66476007)(8936002)(66946007)(186003)(26005)(6486002)(1076003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOaZnx9HenwwRj8/a++7GjH1YA52P/9iebqKcIz1mILKxot0M1RfeY32Ln/y?=
 =?us-ascii?Q?LGn3lPisKPcgneMosDmzjIP+WoxmoCR0dxHKsQM/gI+n2reIbJTuGKfjCwwf?=
 =?us-ascii?Q?VALG7cM3/mQ8EWtFptS6MACs/BSnjN9Y8brq46msO3BUft3D2yoUO+l0+2/4?=
 =?us-ascii?Q?glvHdGGx7h1vrilnvjknYwTgNo8qxgbM34ekkU/Jn7l2ogBUxw6Bb8YAO3vG?=
 =?us-ascii?Q?K5/ZJRQTZqX1m/7ZBNMAbwWameJboMRHW/UWBreiSWskQ92R7ZixA6bijyhe?=
 =?us-ascii?Q?EslcR1sVzgxiiPsJXEi5NqT2buiG8zBa1Tzf45jAsj5Vs6Y3njW8AnwRsG5p?=
 =?us-ascii?Q?nlcI6QqX0MPiJ/1Occ+PXGw9nmjaZS9wXCUGcOPytesxU06ivyak2ufpBACX?=
 =?us-ascii?Q?Yx2hdXfnOJO9EFPjz137DCQbbQR7CRw3aOk2/nv3q1yF1tSYLaKp5IcsiXnI?=
 =?us-ascii?Q?dhbnRz89Nm+myYc9tMI6qzVMeUWfti6ATcG4cwx8QjjT3EoS8HrvN4S6p86s?=
 =?us-ascii?Q?uRiija4Jgw5sbz4wEi4qLJRZ6NUOs3JNXnbaNNyBkTg9aI/dtfS5k2J80pnz?=
 =?us-ascii?Q?yuPvyv70jBvCEXW+Yt7Oy2iCkSGxDVnCYQDlmt0xB/pr+Nbo1ZH60tglFTUr?=
 =?us-ascii?Q?5sPqn97UG4JrxnxoJcds8Zr4EEqpO4JBacSlTIv46LmICPKLgAXvXhzpi8bD?=
 =?us-ascii?Q?4+AFGmRFhvwBTkuswPil6UX8HsQckMRrLf3WQaS+KpaHbiGUYphGMK6WxQpo?=
 =?us-ascii?Q?McYEKuoDyfijQNoVg2ynBYcEFjrkutUwPvkkXTQhlU4l9T5wsvGFuBaCp/Ow?=
 =?us-ascii?Q?DixQVnYfxSpdTzXKVCUDdgNy1PGCgJQwhWpsJD/viBTUzzGhcGcXP/H/nHMx?=
 =?us-ascii?Q?bQAGPxclyMDaeAAmbT06OJeszg3xlsT57DStriB3dFQh4p6l3r86wbOaQlPN?=
 =?us-ascii?Q?zhBkJBJnGw0pYapMo62K0ZnkhoP+NCUZxfYvDqvUZE+xRVO/Tsj2is3Wdqbt?=
 =?us-ascii?Q?4K2iZyxHf+dI69cql8DPmHSXUvIJcY+ceZ5Ncelk0KiwGOgjtoORiMuQKYyz?=
 =?us-ascii?Q?9SDtAwtvx7M//CZb9NjP4WT2JD27IqyBqyTiUCfdK7hKabafj/8gfS3gdbGX?=
 =?us-ascii?Q?qtJc50SnxVPvS2e7fW3QFI6p1Y9USfpvV19YzHSpHOJIReMl76YTfjRGh5oI?=
 =?us-ascii?Q?pkK/Qi9v7mcgw61ws7OReKdAD7MyU1gs0ldazsHBZwnrIk7HQsKABUsinv10?=
 =?us-ascii?Q?rPbS3s+3LgOWMZCohc46km9lu0cwnDF9kYZBOeEh+Uj84t63g+ygxYkwKltL?=
 =?us-ascii?Q?KhJ3QY9iqrO90GI1qayJ0Cju?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194f570f-a11a-4d2f-6b8d-08d97308d4ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 20:40:02.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFOOqS3/hHdTYXhFYwRmLk8s9vW6ykzG0SnJqW91c3FDx5RRSwd5ltk3ZPMJOVURyPrRejoGQaJjFKQPa6WMrA5rgIyaCmgQmOiZXDjjYMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3416
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080129
X-Proofpoint-ORIG-GUID: 5HRgZhfBa_rSZaBCi2IZIR0hBkL9DqAB
X-Proofpoint-GUID: 5HRgZhfBa_rSZaBCi2IZIR0hBkL9DqAB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

se_is_idle() unconditionally returns 0 for !FAIR_GROUP_SCHED.

Check whether the task is SCHED_IDLE instead so buddies aren't set for
such tasks, as was the behavior before 304000390f88.

Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..8b22665bc18e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -497,7 +497,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
 
 static int se_is_idle(struct sched_entity *se)
 {
-	return 0;
+	return task_has_idle_policy(task_of(se));
 }
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */

base-commit: ac08b1c68d1b1ed3cebb218fc3ea2c07484eb07d
-- 
2.32.0

