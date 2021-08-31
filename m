Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7123FC0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 04:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbhHaCaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 22:30:10 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:33562 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239317AbhHaCaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 22:30:09 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V2O9YP016720;
        Mon, 30 Aug 2021 19:28:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=c3wWs0UgL6KdreJUaKd0MdkYxwcYj+eXSZCGU2mtvyI=;
 b=XYieFEeH0lHtVELz6i04Nngm0AUS2s1HUBPQ07kFBztnrGPsWYlzS1chIoZc/fd6xOuV
 hhA9yIUNV2dI7k/qzsBP5lbCI3JkbYZeCZTjaJZwbqgmFnJWTp2Mg0I1ldrztC5gtIR6
 5FAoWssmDj6y0GLU/Mikztis+2boIqkF85+SP9KMTt9Ax1Li2Or+cNNAuspYIk1KTgSb
 peWEq2lngxAl7KFg7jDbhOH9yuelCDoae4eyVR19kmWupME08NtEJTmIHWXiCxvc8CU3
 jFdr4EXASaZ41HfeIGREfvzDL0hYlDLNDSiV+xixjPNauoDqLFdKU/ggcoxlQpb11Y+A uw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com with ESMTP id 3as5qr072v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 19:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7kXGbvmiBJ4l4i+Ob/kkS8rW8cjv6TEEeOb6RmI+vViIkQ3gkDed2UXyG7i8XsO/H8uz3zcvUjuDjJv8TuwRL8iT9JrIMwp5DKarjvi/ISSFR4EADY/TM/Mv/xYoZhp3988eqNCp2kF3SE/wyRk6GHtb67wy3mbuN+PkXm+1e8tza80Fr6px4YJSi5zfDPbHCxZHmF2lB2rfls0K98o3WFvK/6kLbodQyRqpkT+XRTh5XJFdxSxNte4WJgx8Kn8uJv9a8smx/5ZXVjxAtBl9u0OeKBJE6QqbgT5EcLFu98AC5eqxg5qGdYOd2Zo5za5dJDT1xtq4mvZ2ydsBVHssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3wWs0UgL6KdreJUaKd0MdkYxwcYj+eXSZCGU2mtvyI=;
 b=Prbov9NENYDZjcQ1HH4cAdz5I5yboaC/jIZ4b1x4bpuNwN6cy0UAa5xL9eofFTL8qs9ripYUeOIkcBWaf4SC7rsEkZU18aoC35JcFzv7tfpNF6SbStJen7lgZQzA0MW63get8jR/4rNF0mS52o9BM1wBwLKll334mbbq9Q6pWsJOmRaSApfAOwSBX8HKdoPef1S3v3hQdcstRrKK5alEOPUnILj+1XEv5QdvZQb2A6K16W12E8YRB3W6a1No/2eV1BaZPf6PwEBIe8AxbI1BJx8DV7LCshDb0Qy/gnpWPtUtJPz+WkXzcY96cLzFwhG2ulC1plFHuJg+1ya/EnjQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 02:28:53 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 02:28:53 +0000
From:   qiang.zhang@windriver.com
To:     bristot@redhat.com, rostedt@goodmis.org, bristot@kernel.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in start_per_cpu_kthreads()
Date:   Tue, 31 Aug 2021 10:29:19 +0800
Message-Id: <20210831022919.27630-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:203:c9::21) To BL1PR11MB5478.namprd11.prod.outlook.com
 (2603:10b6:208:31d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HKAPR03CA0034.apcprd03.prod.outlook.com (2603:1096:203:c9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Tue, 31 Aug 2021 02:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff275bce-6d6b-4fae-fc95-08d96c27130f
X-MS-TrafficTypeDiagnostic: BL1PR11MB5254:
X-Microsoft-Antispam-PRVS: <BL1PR11MB525433E4EAEEFEFCC03E628FFFCC9@BL1PR11MB5254.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8xsyYWGdP0krLD5S32uy7eQuijTqaPRGTEQqY+IXajG7GpNsyWJB0FD/Q90lQbcsjxBuCcq2GPNjnpMdS/y1lvCAzacSfSNcqRP3EY6DZaQqCY/aA+0yA2V3sb3qk6dEW7CSLAoYEpTexsZ6iKvwUsELJYgjl/IeowcVxXEB/JUIBNZ7rKO/43Gvf2Mrk2i771buPEIZwHuxminOkh90wtWzcF0BQ05zqnXSsTb0r3rpQu2a1IchCFTAKdmdRfjGCf+cdSFqdx8ghCipMsOjIeljeB2Qa7sik/pOjmQDigfDCnLI/sohJxKAqh+SJFjY2vhaAFh5qJXxUxOK2tm8ajhqLGUcGV4msKm50jv1ZIMVqWwtzXeqN/YOkNxcOLbUFbDsTVU3dNod29JoMV7HAK8ngux1/9wINubqDTxaiOcGhGDn39atQltD/PBHNaubARB4R/7Ju9qzCEHwIifoCcPXopQxX0IgKuvRsa8g4v4UKjsLy6VMC8+ZDJ7M6c7eHM0N0XX2m9iHZtOQpxLTuQfbdnlqwX5Up5MppW2AAxotkfhKUxGVAbuTCghl3E5FpEsot11wNpGE5B4So3rXWlg2SfkE2qrQbkveZ5syGjmcynNqdhlxYBryXvFwfIVpzYWl/W6Q+10Yrxy9vCUD3aUEIMQJUZzs3/bff3Ci5OCtchce0G4DOIM1nS5rrVZWZ2H7KvNNxiVRbFqNDNfpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(186003)(26005)(6666004)(6506007)(66476007)(4326008)(52116002)(66556008)(66946007)(8936002)(8676002)(6486002)(508600001)(1076003)(316002)(9686003)(86362001)(36756003)(38350700002)(2616005)(6512007)(38100700002)(956004)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ZHeYvNvDqRE/BgnGNlPW2F+M8d5STWPASAzpR/ZIlUoGCuGQWXhQ+0lDyej?=
 =?us-ascii?Q?kwLTg7ktxx/GKbpX7/thyeoXsSTCAD4Aj83yIFnsNblHupcxvOB2LG/Fnp64?=
 =?us-ascii?Q?HY+Q5fCZJA42yk0+TPwkzdpRTityYvg8QJhikWNXlDXyQyHKQmXUW8dTth0f?=
 =?us-ascii?Q?e4zroZc7cYBhZulX4GNXYZl50MghTDe87Rq0sLnOHBjAZhGo2oOxMXoxKl3Y?=
 =?us-ascii?Q?oCTuB4GI1p1mVBUcIPzmbBL1LekpnsXyaBlTwlMBCYgMHAxDNfBs7OhS/CGZ?=
 =?us-ascii?Q?XVR40a/t6OrM+5g7UF6Iqg1ywzj/v6YQJxTydht2Psk4XghXyt4FQ/6kSeDi?=
 =?us-ascii?Q?32o3msyVBfpQCdVqabDYmTsPEYnLfpuhdK08HMX5Cx9bsmZXIQrmIFHtJ3ew?=
 =?us-ascii?Q?4tbYFRgYpB6ovtGzYNr661yH8Xm3LDzktJhZPHG48z7G+NA6icqumThasIQi?=
 =?us-ascii?Q?3SFRGmk+fIb8PfG7fr7dYLQ4HVtanXAjJ+yepnd3i3jemuO5zCJ1hkQo1kJg?=
 =?us-ascii?Q?UmNFs/IV9Qt67Id8Odg24bFrRMa/scrilkFoIbywy1QCS5mX5wKrfJdROETy?=
 =?us-ascii?Q?XGQ5LNRzVG+Nr3b5WzjC31BraTwwAipCGxsfIozGfZNcbanP/jW4ae5/TXyE?=
 =?us-ascii?Q?XuTdy6P+2DKMrzOnP5EIbaiakivvBDGEkOK/WUyEJPrhf+LFJC1bHGrJIsgm?=
 =?us-ascii?Q?Ptmd4tIgowyEzkBq0w+d6fVaReXJVExhHWF/oE6jsWEXzZOls0tFNMCafSu9?=
 =?us-ascii?Q?P1rbEwB4ea+ppRhuDdeXR0PCQ+9fgIgpbBzh1OCck1mmHWw8iMelWZlc7H+X?=
 =?us-ascii?Q?5DM35jp6Hu4wryLp4oJD5LQcJv2iCWUvshs+ZmN18P/24VlGS3t7z8coXxjv?=
 =?us-ascii?Q?y9kt2hdqv0Hwio0abSaT2f134obq9EQXreR88NV2mgcuujVxHSWByxKXHLa/?=
 =?us-ascii?Q?ejSE8FlduaKoYQuvqrr2pXD7MqAw2bK8lgLqxP1ugUZi9Nqno1JYdUUDR9+W?=
 =?us-ascii?Q?XCFEO9WX4z6VbOE/qOmnsVvAQMPoGEpjkumMbo9IzOqSmb4sP8vPRzB9VY3M?=
 =?us-ascii?Q?KeRPc02UP9Yhm0kq1saWa18Jf+JpD+s6q0PaZdsoc6bKT5tHJgNMlyvLp+dF?=
 =?us-ascii?Q?s3wWtTWSk6I8CEPyO1M0EtCsVVyubKdMeU6TbWWXuVnRUvKy3dvCIb+zmsOO?=
 =?us-ascii?Q?rxi2z1XBpvPDTS5oR30E/7J6Md+3y22lohSzFAJcIfFcmm6nO3aadzMJrm03?=
 =?us-ascii?Q?MiwrqHPFEyB+/UtowoP4zvw8QK5omAIeRUNwHoeQF+YYWSX2sTH4CFX/Dn48?=
 =?us-ascii?Q?MvS4cR8sy6AAdx3F604O5qNn?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff275bce-6d6b-4fae-fc95-08d96c27130f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 02:28:53.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bE0u+6muaOloAOintT1y+/QZcf4ZK2fp1VqFmvAD853Gw6mTYbplTYvKYwNqWjF9WzKx1N/SKDStcT053GlTHvI0k8kHotibYJJHzotjxI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
X-Proofpoint-GUID: m-c5IorXGTgfywLyCxkChdsTO28ltld4
X-Proofpoint-ORIG-GUID: m-c5IorXGTgfywLyCxkChdsTO28ltld4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-30_06,2021-08-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=919 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Qiang.Zhang" <qiang.zhang@windriver.com>

When start_kthread() return error, the cpus_read_unlock() need
to be called.

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Cc: <stable@vger.kernel.org> # v5.14+
Signed-off-by: Qiang.Zhang <qiang.zhang@windriver.com>
---
 v1->v2:
 Modify submission information and code style, add tags.

 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 65b08b8e5bf8..ce053619f289 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1548,7 +1548,7 @@ static int start_kthread(unsigned int cpu)
 static int start_per_cpu_kthreads(struct trace_array *tr)
 {
 	struct cpumask *current_mask = &save_cpumask;
-	int retval;
+	int retval = 0;
 	int cpu;
 
 	cpus_read_lock();
@@ -1568,13 +1568,13 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 		retval = start_kthread(cpu);
 		if (retval) {
 			stop_per_cpu_kthreads();
-			return retval;
+			break;
 		}
 	}
 
 	cpus_read_unlock();
 
-	return 0;
+	return retval;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.17.1

