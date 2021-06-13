Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84D3A59E4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 19:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhFMRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 13:42:47 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:53980 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231951AbhFMRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 13:42:46 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15DHecoR016609;
        Sun, 13 Jun 2021 10:40:38 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0064b401.pphosted.com with ESMTP id 395g7t057b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Jun 2021 10:40:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG05Dv+0Jci6zOEbN71814fJQYoYyzXCvN1M/YSsrw6B1Zr8quMHshO56IZlLvJQnGYF+ZAV7G/cIRTNzpwlsJUI+9u299TiRYThKumviH+W/Vxdt6jnYUZDJUzlvDHJRKc79xQ6wnRbIfTDI502VpiK4uG6dFJfXUCnNqBtIMhiIfUL1hn5cVTr9pa5/M0qhOWsjdSmnlIi5Fp+Y+H5pAzL2hFUY6Qn5DFZfU01/V7wnWfZQTu8LsAWW/vcbQKw5mQI+WkzWXa9PNjV23YU1DHIHBXx1F5XzYVLjx/ml92qtbrapuoQBvLHdiOgXbB2Uz0uHeGHkF6UBWvm+iSVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9jx5m/5m1vlRBDHHmpgo9Wz+akRHkY2m4IwKGzw6BY=;
 b=N/cIz7fz0trRByCBEwhXTXyOFXdAzeAJ5/C4iqi7TxHsNcRXXzM6xYwQSt/blMnj2G1i0biVVHLlmVdMVvOJlZ0IqW/AlSwBqOYYmAVEOnHaRiu9NJv90cwZ2BQ10AEEmr3jWl2XsCcUEucpfaJQ0AXfMm6zgyVAGBxyaQ2B/s3OnWEC8fUHe3m+0fZb0Eui1Yr/pFi2NMxxDWzc/AnuxI/d3W1vHUMULR59y4AmNoIRzTwI3U/kwOJpxQ2MfP948a6yLCVGVSJeH2ssVyoBXwSYJqKiVAucDSHoh1lmg784+lvNhXOuGfdTsC1gK0KOBBuTJHnAkL0PcjOrxhz/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9jx5m/5m1vlRBDHHmpgo9Wz+akRHkY2m4IwKGzw6BY=;
 b=G2t40kuJWEUDa5XwFkLfE5Zl1nyuMet4vRs2oh5BP+hM5vx0y8sXOp5eNvCGKqvQCv3vtZ+G8V76ouGuxG59Ps4G0xYmCqTj46E5xZ3kwVmy3dLUvsqqWVgPd9WUJwHbIAVx/plUlmMzJRkT9NPxr8prpeu8VwUXkxhN8hxgLE8=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (52.132.255.77) by
 SJ0PR11MB5053.namprd11.prod.outlook.com (20.182.106.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Sun, 13 Jun 2021 17:40:35 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4219.025; Sun, 13 Jun 2021
 17:40:35 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/kmemleak: fix the possible wrong memory scanning period
Date:   Mon, 14 Jun 2021 01:40:22 +0800
Message-Id: <20210613174022.23044-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Sun, 13 Jun 2021 17:40:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8da94ef9-762c-4897-ae97-08d92e92593e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5053:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB505358BE50EA92D1CC9F7070E4329@SJ0PR11MB5053.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:457;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNMS8RCN0Pn60iotAbpDwbhdUSWon4P2feDyRJAmBVsIyxMzJ0l/6qVXy8FY0aJgPO9fwJLoVrlQDEct1hIT8V++TCrXlcB+Ma1ZjSg3/SbxkL07YwwDBygCOzGw0HPSsFq00VPV0swsrxByKBFhYwY0/bTQhtmk0eYxlFNtAec8Gt5AoJ84Ht4HXGTHMXX8SU2AqvjOYeT/3oykgqfaxfpl9M1aXWNRBP6pbDdt5xpez943Xq9VCo0iBD53o+vA8hbPr/RW8q2GsbNhysNVraboXnitBVoaTGKKDmKR34UP9eq2TUGjJzO8AHFBiT2IuxfNolAXKCdJ1axkdtRURKi6MZvil44aRDmFMspfGMzHYiSITrspljBZMAK/b/CTWGQ+GlGlnb0KYXPDy2rZA0h80raHZI9ODWE/dEfefiI8fKb7U+fvHhXkTdt/IgFBoMzUM7vSfneCTyybEiuaeQYBwQPRtN5tVSj2fJ5QS8if5KyKjTrSf5RX1enFqEPiInPrNFlmUCu1qOsGZ1l6i9spqcSR6hIWol78Y8sKHUSp4h/wmOPxgPORAuUbLdYs9wiOVccKM5ZjLQ1Ty2vGrVGUJGZ20H5hQg343zx6zfqNnphvT3Q6ojPP/2/6wapZfgAbe2EUEKzSVC9e6zGDtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39830400003)(396003)(346002)(956004)(2616005)(44832011)(316002)(52116002)(478600001)(2906002)(16526019)(186003)(26005)(6666004)(8936002)(86362001)(4326008)(6506007)(8676002)(1076003)(5660300002)(38100700002)(36756003)(83380400001)(6486002)(66946007)(66476007)(38350700002)(66556008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KQt5LGq5KRCzojQgCXQmhc77Ms3GEEiqj4RExLbuXrdB+2khcwQwIVfFAUB?=
 =?us-ascii?Q?IAzDh3BYLf6g4pOZONc4A4w/7wcJdC4Y//y0JZpEeQFSmPwByISnluci7s0L?=
 =?us-ascii?Q?LRL+u5DJ7DBH5Tr1Utr6xMbYB9Cb8CCPhoMHcGitQZWqV9w1HFbSH14JlC+a?=
 =?us-ascii?Q?h7NeQIlJ8yyyiJHgB2JN5eweBBrqbxvlPk+kZRRkuj8tdkyE57oezOei5ioM?=
 =?us-ascii?Q?x91TcQRFePV+PxsZaFytcCzx7ABfGdHN1tm1KPfIzX88lgNTLUj2kYMiCnaI?=
 =?us-ascii?Q?x+KVUm+cFdXmNtRyWcrbkYm9ceXfIgnk6LzY5xqRxs8VlERQU1LGVUQzyq+F?=
 =?us-ascii?Q?WM6LXpmNNRsPNwznmNP+37HoJyMWKl3gruxvNVf16yeO7/IGLASm5vgP5OTm?=
 =?us-ascii?Q?9IZiswOw5+yWcy/x7RFA3IWbwf0StnoRSHokMZsDv6t3pPFuZSKjpbX4RfZG?=
 =?us-ascii?Q?Un+oW8s0IGOH+6mETejyRjyeolFjZvST7t3Lph1LgNRStJd9kReMvYIfiA7w?=
 =?us-ascii?Q?+g/ESW7420i+SCdjAmQCblpp39QVLSEtcsncdilxITFzZKqHdECLjICY+tsM?=
 =?us-ascii?Q?09CGLu1RBVsPA+hED8o2Wkl5e9axF6dgTyqbSBKTvXgS1xGyjC3b0/f+NZI+?=
 =?us-ascii?Q?bsfgPxJpkIlMV1vQ2JT60kHXiROUbktvyw1gX7tKhRQWymzDWd2fH//svxOh?=
 =?us-ascii?Q?vuge08WY0o9ZpW5UaMNP+u5DTx40Xaj7DcrdWI3UZj/hIIMUtkvY2XHvX3J1?=
 =?us-ascii?Q?f8veQH+1Ht7Xow8MoeUM7g+kK4p/mxcFDZavgOTXloC2EVr+Y/XCtRaaNMsn?=
 =?us-ascii?Q?dEwehOKQpDFsc5a6ol6rfs0Ta9xxedmHGN3EclKZ6gyz1b/Tok6ipDvf3UDi?=
 =?us-ascii?Q?ndacMB4pAGmXaXsDcDsiKJe3wG6xRhP1EqhLh6KqQ6dA/CLXTGxmC51vCjaE?=
 =?us-ascii?Q?C+dmTsvOFr7E6/Gl7dUkEfAWJwiCjtdYfqpyqG/oCMix5jz5udgINfGGfVX0?=
 =?us-ascii?Q?W7JgPmhizXAXfNmog79E00+0lOqKJbQA/DtFdAbg2YExx4W87hPL6bSp/s3r?=
 =?us-ascii?Q?o8UPA1RdDZ9ebJVbTxt0xVoR9Or5vw3OeehXCU+t/h1Cj7J0d3kJkuof0lb7?=
 =?us-ascii?Q?ZrDSwWSBLMbPjcPBuxc9Vg6iFy6NgfurtAbSLJICBWSVGqrT4i66owpC4ylN?=
 =?us-ascii?Q?MU0Zp5r8XKzqElIZ/RNQe5iSWIlXJiDFp/Aw0nelmEZWj28gtDzgY+77lmIM?=
 =?us-ascii?Q?FvApuDE0rUO0bo550KsJmm+aIfYjNFEOEw9KJ50t4lWundQAxRMddTC6HpF2?=
 =?us-ascii?Q?vjqgwsg6d6c8rCR4v7TB9Jao?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da94ef9-762c-4897-ae97-08d92e92593e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2021 17:40:34.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjmkyG42Tclix2rDPdF2BMEvGlxLD45iLIIUq60cjDe7zUlUt2OXm48tndGNAbdfErQbeclrS9YhvYR3Lq1H6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-Proofpoint-GUID: 7kDZMWKGb86CjsStWw3cQI0cbocQQlBn
X-Proofpoint-ORIG-GUID: 7kDZMWKGb86CjsStWw3cQI0cbocQQlBn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_09:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106130127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit contains 3 modifies:

1.Convert the type of jiffies_scan_wait to "unsigned long".

2.Use READ/WRITE_ONCE() for accessing "jiffies_scan_wait".

3.Fix the possible wrong memory scanning period. If you set a large
memory scanning period like blow, then the "secs" variable will be
non-zero, however the value of "jiffies_scan_wait" will be zero.

    echo "scan=0x10000000" > /sys/kernel/debug/kmemleak

It is because the type of the msecs_to_jiffies()'s parameter is
"unsigned int", and the "secs * 1000" is larger than its max value.
This in turn leads a unexpected jiffies_scan_wait, maybe zero. We
corret it by replacing kstrtoul() with kstrtouint(), and check the
msecs to prevent it larger than UINT_MAX.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/kmemleak.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 92a2d4885808..228a2fbe0657 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -219,7 +219,7 @@ static struct task_struct *scan_thread;
 static unsigned long jiffies_min_age;
 static unsigned long jiffies_last_scan;
 /* delay between automatic memory scannings */
-static signed long jiffies_scan_wait;
+static unsigned long jiffies_scan_wait;
 /* enables or disables the task stacks scanning */
 static int kmemleak_stack_scan = 1;
 /* protects the memory scanning, parameters and debug/kmemleak file access */
@@ -1567,7 +1567,7 @@ static int kmemleak_scan_thread(void *arg)
 	}
 
 	while (!kthread_should_stop()) {
-		signed long timeout = jiffies_scan_wait;
+		signed long timeout = READ_ONCE(jiffies_scan_wait);
 
 		mutex_lock(&scan_mutex);
 		kmemleak_scan();
@@ -1807,14 +1807,20 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 	else if (strncmp(buf, "scan=off", 8) == 0)
 		stop_scan_thread();
 	else if (strncmp(buf, "scan=", 5) == 0) {
-		unsigned long secs;
+		unsigned secs;
+		unsigned long msecs;
 
-		ret = kstrtoul(buf + 5, 0, &secs);
+		ret = kstrtouint(buf + 5, 0, &secs);
 		if (ret < 0)
 			goto out;
+
+		msecs = secs * MSEC_PER_SEC;
+		if (msecs > UINT_MAX)
+			msecs = UINT_MAX;
+
 		stop_scan_thread();
-		if (secs) {
-			jiffies_scan_wait = msecs_to_jiffies(secs * 1000);
+		if (msecs) {
+			WRITE_ONCE(jiffies_scan_wait, msecs_to_jiffies(msecs));
 			start_scan_thread();
 		}
 	} else if (strncmp(buf, "scan", 4) == 0)
-- 
2.27.0

