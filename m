Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2010D3DB4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbhG3Hwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 03:52:53 -0400
Received: from mail-eopbgr1310107.outbound.protection.outlook.com ([40.107.131.107]:64074
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230240AbhG3Hww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:52:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKvgg1siVS2S02nzZmcqIbZxgs1qmAM0cbfQmNS5qaasoekZ+k9i5+Qy0BAJocONI81D85n+igIl8O+l61KvpeCSVKtdvxJt9mEqOLmxRlo4RgY1mUUJE9ixFweC9k+B+Q7jj7x0ovlmHCuCLHTQYTE/md39/dTzcKGxFfVXxygicSLkhOFjT7W4l7PiYvmwCIi++Qlo3wZbg5Ni534iBApWi5cex3Qk3AzxL8fPchaHRngYVkQqC9Dtk4eRz+sB8fWgKewnHGHBdM5gZeTZisXI2OmOKNQ2dLuZrYs4jZEyLmVztjFl/M6MfjT+I2cWmfDCDC1M3i+dFpZOtPnl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcPsI5NZRbPTTtLIuyd4JqtYTWHR4G7o7XpeTO3kkP0=;
 b=PzQg8nQDtH7Bz1iLiH8oScgoJyAJVKNv4XNL+CJIoqtzlvUU1XHHchAFMjhnw9+Wp37GKIdsmP9SPu6oh0ddzilVKAaF9/OGUE8zrOTt8RvKJyWzzx7DJW0NuAN88YGtB4yhGfvZwuy3d2tOSpz3w2gQFwsuw93+5ey/0eOTLBFVHOZBMz8H1ARwL2bCZAHv4lfwQ22MgYZrmdvdrtRU4xYZKTx4qhpl70Jy+7jNgIKyfev1SstUZ9TfTtkrhkOlTVWbLhvfptLPkndPQBodGJyFG/WhiAnlMgsieVCkDVLAtHpbOKM9D7Qhktm6bzUJRNQ+OntP3AcNa4vc5+Y9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcPsI5NZRbPTTtLIuyd4JqtYTWHR4G7o7XpeTO3kkP0=;
 b=fMIePsUcwKYvu2EZtL7aUrDdyaBQqshwM2YLIHFMM1hMSIQl5YNr/gwHQCfnqApmMkbJsS6skG6XaeshOjvzX2msXQ2RHk7T2H57ohALLpYWufP2HcpSVRazjXSuS7+u+QFdPQXZe1fU5kbkYV1mg8yQgub6/Bf+3g2Ln4AWNH9TOAP7cQ7kj2G0ToyZBkUj6D5rDTTL5G9pvPVr15wBfSMI1r9KlMR5tQF1XVej0+m6bzF0UCJd+JXnLsh3m38l+o5Cyxm7sj/L/Bt5xSOOzZcuhlfrDxSvyQbFWBK1vD7CDrjPXCYwYFORqQImplLrNN0pG8fPz6v8n06lxSP76g==
Authentication-Results: paul-moore.com; dkim=none (message not signed)
 header.d=none;paul-moore.com; dmarc=none action=none header.from=zeku.com;
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR02MB5233.apcprd02.prod.outlook.com (2603:1096:820:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 07:52:43 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b%4]) with mapi id 15.20.4373.024; Fri, 30 Jul 2021
 07:52:43 +0000
From:   Hui Su <suhui@zeku.com>
To:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Hui Su <suhui@zeku.com>
Subject: [PATCH] kernel/auditsc: remove unused header file
Date:   Fri, 30 Jul 2021 15:52:34 +0800
Message-Id: <20210730075234.338-1-suhui@zeku.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To KL1PR02MB4788.apcprd02.prod.outlook.com
 (2603:1096:820:5a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from N50001309.adc.com (58.252.5.74) by HK2PR0401CA0006.apcprd04.prod.outlook.com (2603:1096:202:2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 07:52:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a43778-03d8-46b6-b83d-08d9532f0321
X-MS-TrafficTypeDiagnostic: KL1PR02MB5233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <KL1PR02MB5233673F20219E1A6D273546C6EC9@KL1PR02MB5233.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibyAMGZylR1bhJJ4j6cGLaL4WChtkK41MeIuXMybN8SKXfeYAs1I4Ykzqn8T9eioydo5h3exllHymia45oyv68iMyjePVXXR2ou/VHe+RC/OgC+iCDtxXlequYmNlrHp9/SsgzDFEYbZX58QGqdC+653ExjsWspfObW8f1Sk10CPEL1JkH2ynimgS/OkGm08TTjsjAqFwLdgvN3mDVRjGmZfU1n3opw6bBjFAmdWp527loPvDFTdEf/+08WQUKFgpT6cd11o2rPtXyrq9Yo+HlefstV+hHHrveZQLMsWFKNAjMIbai2sqgTnqcBkl0ToKmeOh/K//Lf/mPnw5JNLTclVzYBdYazTPAjUVcLH2zVTvyeMu4I1SGWkKf5XQ4uFPu7DncVwamI2ylaqtwCPq4HocnZMnvU0YpDcJ6YqwcM2E6avTqZym9U1BXLXkrhHgyqIjorpLJCw2vkN9aFcJdqYpzzS9YyuJUw7o1gfKyyckeryob4hMXhCpS6Wj1rsmKT77T62+rsTTYASTY8SDIOxA33OwurNbZgM5Qipr/zH86qkQLQFDX9PsA03cVUn1G0eAe5sXoSBhDKmlPysSopmKQoaR98bIONSBqTI8MxguX4fkkFNPlKwo00mPN+IbK8SAcmJFHNBBLIE7tRPOiefNbgMcKZgQOG+jH4V6hLd4rsX/XSetoF09alR+ov2dAOo4TBC08Ctg3j43yTTA7P+OhBL7eq76dmQZ9ww56M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(376002)(396003)(346002)(136003)(2906002)(52116002)(36756003)(4744005)(956004)(1076003)(5660300002)(86362001)(66556008)(38350700002)(38100700002)(66476007)(186003)(66946007)(107886003)(6486002)(4326008)(6512007)(2616005)(8676002)(8936002)(83380400001)(6666004)(6506007)(26005)(478600001)(316002)(11606007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ukj5PMFVZBGmBFL3QGeqOWT8h+GGPQ2v+g2ZnICVxpjSx4DyRBWYybFQEI+t?=
 =?us-ascii?Q?d5j9NHmN16F53MsnU1lht6q4GlA69gwrVyQdYXlvB/9V9dLpV/UCZpzeCKRO?=
 =?us-ascii?Q?mu9zaYdIUU4em1h6C/CkFSV5ewKStNgqFXPweH+vfp8A8ydY6Q5Arwidx9lh?=
 =?us-ascii?Q?jGBq/DDe/P0+oVCV9eYH+PMaSgYJbvdRhuGKGzXVr2HTog+A65P+qvorJRoK?=
 =?us-ascii?Q?+n95YJ4FA9bU04T7H2ykVC3j4rPfrhvFqS0q++WlXgxNKg4OefLLup8I0Des?=
 =?us-ascii?Q?MDAhA7HBVmAB87LsJmoRQfwyPe/zypggdwQH5JDIf8qJFYYX0lmkarXpZqQL?=
 =?us-ascii?Q?8+AlRPG/Bgb0jv4uaW/C555WbEKmRcC8kticd15kCF/A+22jddoJ3Cush9KN?=
 =?us-ascii?Q?/egzqOAndiFuNOegsItb6TyvcSmdsBc8De0PfW6HuXQIQXFLk/W7j4mYHl3s?=
 =?us-ascii?Q?/PUBst3TKCcbe/XcYqsWIahlbqKKHT1y4sqENRem1Z8QgZN9p6oYH0NMkDWY?=
 =?us-ascii?Q?DC5rwNdis87AIjZWzYgSry8RC5D7+1rCivZ8rAiFE0X4N58tOp1UmhMOjcka?=
 =?us-ascii?Q?0xb9nNA85n8K6lj6zWIw1QALsemyXWwgwYxxu084vst6aaYqX4EJ0gqGYKua?=
 =?us-ascii?Q?dO1/Pz629vUKeXowFu0SJwJRQLNAM3yTbNW9yxsGDPE7DatfQGU48tLz802v?=
 =?us-ascii?Q?M0KxqdOEB8Aa8eSBaYnbn8Q+KNeHj9hPw26/45drRO7tKfSEhApm3ESkrDmn?=
 =?us-ascii?Q?SBHEJig5nRxN/hu4TSqFfjlMl0vE6C5oqaB0tbxVv7Mrc647vXhOnkXY8Soe?=
 =?us-ascii?Q?/iN+HhWzwTuTkzMga5Dp2Y4xb2cTuyI/HtaRaR5Twjk9GckEZIEDlvAsZNXs?=
 =?us-ascii?Q?79cRB4whA43lmm4Jhjpxg9MZY4yLKQEMVwShDi3XRf7Xf6icMWzp3mOMfQNF?=
 =?us-ascii?Q?283ByEVec2mU/eALpUFVCpuHbKjwSTmth3CeCPdCTi4VBNvFQM0JZhRS0xXp?=
 =?us-ascii?Q?0EUwHLuSVk4ZrDnbSt0n+f9DEiri1DL8GObq7ZSr4rvhXkA4moGmqSRwm0VT?=
 =?us-ascii?Q?MeH4tqMgA2+pfrzcUm61I1iL+WW9bwzPSZ4Cp2n/3NKYOQs6ba8hm7BYjYn7?=
 =?us-ascii?Q?FxGPDJXvqQjLEBgB9Sjz/0+Kt3eBAsZ5Bqe7L7jVXjJ4NbZoTDV/+xjep1X6?=
 =?us-ascii?Q?WFErI2l41Wj4kNDfxFUmTA6Q815PhF8QFMXJ/39Ci3wKvMJVFq2uYVLQuOIX?=
 =?us-ascii?Q?zabxZg+dUIbCRvCIcoB1gjtAVvifrEVfO6T02Ljjv1P0sM53eugVl4l9wZYv?=
 =?us-ascii?Q?kWQxocqmccErLxkwRqnzjCwe?=
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a43778-03d8-46b6-b83d-08d9532f0321
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 07:52:43.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyHU2FOCJzXk+tiAw92jdKiO7ro0ZDx3+JWLwbGCfIPkILMgXuUNc6QNTDVCk6Xs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB5233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c72051d5778a ("audit: use ktime_get_coarse_ts64()
for time access"), the linux/time.h is unused.

Signed-off-by: Hui Su <suhui@zeku.com>
---
 kernel/auditsc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dd73a64f921..33bb6a83baf1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -57,7 +57,6 @@
 #include <linux/mqueue.h>
 #include <linux/audit.h>
 #include <linux/personality.h>
-#include <linux/time.h>
 #include <linux/netlink.h>
 #include <linux/compiler.h>
 #include <asm/unistd.h>
-- 
2.30.2

