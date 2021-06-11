Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B298C3A399E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 04:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhFKCXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:23:19 -0400
Received: from mail-eopbgr1320124.outbound.protection.outlook.com ([40.107.132.124]:19872
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230281AbhFKCXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:23:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNWLjdWIA9ECal/uw1H0/ReeFMiAOeGOIt9ZnM6hxJmAnbPhQ/ZpZuUcAmmmDEYS3YX/xXCylk3rYqjnnyq0QZe/H6ru98jSsMXQ5uKNTlpGRtqxaho9tYOf9KiwDXblStFVkg7XtI5+wRCkGgNLhj2n00/2iH3H2NhjQqCV79NkgR4OPt/QObs+0IClH3Qmyrkiwjwvyxu7KYWlNuYX36ULVWHAwql2Ycz00PFjY43rtmRWbboz4YHrx2a842r8hBRpIiEctu4RBZ5UABkJvXu87IAb0tsJl0c8/ITOyRgf952v+yrXdniUDSojah1aiSAaglVXv5PMwUNUBxkc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mD9OYq2AbE+wlL/n1K/UJfGvMGPLktMovGhdbTKhP0=;
 b=e5fYOJjvSCcGqoN20+b3TVLZYSUjZ2RqBICLi+cLs3SqgZD+jFzhhFPXJaeABn+RdqCGNOBabk7Yr0BtUSJMjtH7Yv8mfjmtx4mWpnl75bXdiqPKN0gbWlvGL/h42xbSDkKm2QjlWj9QohV13k8HYxxzugwFILPR7W80APNg9XdbhDuo5BfmJIOraWDi26qDo4tXtIPTWwHzJ/VSEyWjxU4W7Zh9K5WYmD7t04La4gm3ZLXAHvHID8bzAwbJrre5qYo5tYIWdxxnT9elb2edeGYpqZ2Wbh1o1hq8zgDTA8Y8/q1B9HV678E+KyC/uLvt43jpgFtmLJipIivNRd5ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mD9OYq2AbE+wlL/n1K/UJfGvMGPLktMovGhdbTKhP0=;
 b=U9a45iNmn3aRC8lSWtWceA0xnrAGasjWZwvG6P7bjdhcEXDnLGWNQyQ3Zs0pgWQnEaTBb2hKAcyiWdUNLVVlog4d3icpF+uwWKKmT+mb9UFTloC/CwOYBeA8Ojx0h7KzJzkT2SW8FpWZWAf0vgB542DP3wbhYkD1qeJsHWYPBHVFg/NIOTenaxrigSp3gRLeT3I7hVvg0Qvu+xD6vgEwC/OiU+pmBePJV+9uDRRO3KjltglMrv53QbyMUbTJG7D/jPsVAdTWCgoHv8LEmshQb6vYVJcrfdYREbD9NCSC2EO//DYBbkAKFP/ixXfnsr6LLNrk6LsfsEncIi/FAwweDw==
Authentication-Results: kloenk.de; dkim=none (message not signed)
 header.d=none;kloenk.de; dmarc=none action=none header.from=zeku.com;
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR02MB4866.apcprd02.prod.outlook.com (2603:1096:820:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 02:21:19 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::d4ea:8f6e:275c:5ef7]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::d4ea:8f6e:275c:5ef7%3]) with mapi id 15.20.4195.030; Fri, 11 Jun 2021
 02:21:18 +0000
From:   Hui Su <suhui@zeku.com>
To:     me@kloenk.de, masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org
Cc:     Hui Su <suhui@zeku.com>
Subject: [PATCH] scripts/tracing: fix the bug that can't parse raw_trace_func
Date:   Fri, 11 Jun 2021 10:21:07 +0800
Message-Id: <20210611022107.608787-1-suhui@zeku.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.71]
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To KL1PR02MB4788.apcprd02.prod.outlook.com
 (2603:1096:820:5a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.71) by HKAPR04CA0004.apcprd04.prod.outlook.com (2603:1096:203:d0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 02:21:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57780a1-427b-4b43-5561-08d92c7f98d5
X-MS-TrafficTypeDiagnostic: KL1PR02MB4866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <KL1PR02MB48661D72D7B4CE34A08C86BEC6349@KL1PR02MB4866.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ipoKnL3fV5LjUwfTjAWgP+Esb0fXMGS/V5erjY9D9uhB51lXcZ959+/7MjRHWXpinSGvUAPChWHQX/poM4eCmj4ceHdk78lAV6RUgkqB6693keUL3wy8w7kuHbrWhKLHt524bF7VNr+h5Py0m0x/zCx+T3/dBXa7CiVljVsXM82Yw8mRPZjRBXxuOLqn6DhCdTluAyQtD7LltfRb4kNVTShaVuN1uaZkRr4gPhorkwUSl5VsWCa27ZsaTPD85LuemC9iUXR2EQDqf0oC/5t6wjOxgw3II/E9m5eWg6EKAPIAdZ93sQd9hHcxSePspz5RlHnyRCpD+PdTBb68JW0Xua1xynn/D4lhDC7+kYWGMMGzl0r3ih/SkUnPqXSMOFnu5MjcjtKlgYfGykL6O9mirlI/9kYbPzromR1F8UHHnKEDntISG8aMhow6N8q3gZlmL7VJYyr1mdOKEDVmxrtqtXcffpd4oMeJN64mPC0jyOA7IHa9EuXtvfPdCO0f9Tuol2q8Bk61La78rjPmjHZwVDj0ArUZh8NiBJti7BWpMI3QzxFaaE1xtl6m/FYdUyOp2Mu1u8da7iRVX/fuZQSkCzpbBXLPz+p+gUDM+VjU0N0SRXlLpqE9arwUHKQj5T+8cDEh46DxDEdbOtsP26qqeHY8ZX7k2ve9zCB02lzrziKcSKjmq7eNYCjFAAYPWPf/9tnpZbNQjV0ClsO25lyBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(6506007)(8936002)(6486002)(2906002)(8676002)(66946007)(38100700002)(66556008)(66476007)(36756003)(38350700002)(478600001)(6666004)(107886003)(4326008)(26005)(1076003)(5660300002)(2616005)(956004)(316002)(186003)(6512007)(16526019)(52116002)(86362001)(83380400001)(69590400013)(11606007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4sqyGH8T+UTjTUGHGlARSfdz8mPUTef3Tf9SZOyhlTsmAXXHGamWJJvJpD1X?=
 =?us-ascii?Q?v40odzwwCUM0h65i2rrZdtO+StW2UbG3LSTASt0P/qIyaZ+rrbg0AcTrgjI1?=
 =?us-ascii?Q?WtFPVPSz/qIldBaH3tFMIhqvGylLhNimyG4IOwr8bMKHBFISoC1h7mr4yy6q?=
 =?us-ascii?Q?PtjEmgxxyJ3BR/apmXrUn7MbQM10tp2ynqt7hyk+XVmEgdDWetQVRmuxYG5y?=
 =?us-ascii?Q?r3rdn6lTF7JSPjhzU9JXwjEHaNmP47UnpNyTQpfaFnrvNGW4BCjJwx2T9+iL?=
 =?us-ascii?Q?EyATPeoLXckPBqPkSk9sPQleurmOxysqgoxS1rP/WzHFRqW4LuMcOartoTzA?=
 =?us-ascii?Q?mFH1Hfo7245/Vs4Ted60wkwCZG1xZM6xwX1+pxfzuuoaEVt1wLmK82Gawe9U?=
 =?us-ascii?Q?ZLX0Nb0MCSqIU1QheXMQMb0piz45ovfa8WHOsw0vf5PTN/qHM/d9madrBSts?=
 =?us-ascii?Q?/6OE6UqdozQIcgK8boL0fO+qHJEfuwb7JZI4Yr7u6baVNVSonC7Pylm2wXGz?=
 =?us-ascii?Q?tSkfIcB5wc1ztCQ10vCHSc6ZDzIeEzEXmngplH168iTzwIpCPLKFWx8ogD92?=
 =?us-ascii?Q?VcLuAnQRTtUjoJaxUiIJ2idOIEy9sjxYOHyg0AjnGIJHdkCgdkkr5q71xH41?=
 =?us-ascii?Q?nIpo1rce/XWs7n2/kQ+xJ9udfsx+KzMt/Mg09pGVRMQGIH8YSfJTdqPB+LtR?=
 =?us-ascii?Q?msZKzy3Ghc2iElvUOR5vSQu+MC/PwbAuOoVlmxR/++tibMJmcBIjSviKj7SG?=
 =?us-ascii?Q?PMPFxOktC4j9sT1nBV/xS1nBjDuFm/5fHLY+CKgWwma/XhR9z6/PSVV66sKG?=
 =?us-ascii?Q?jCDbLpNNaP/6e6WQifg3dDsX2z46DOvj+BkxAncCbd4vaIG/4lm129nxMhhS?=
 =?us-ascii?Q?7bUPAhkT+sV1nZwilFJMV7EY/KkqxgwHmw0qurnL7nmWsaXsUSneDVzwez8U?=
 =?us-ascii?Q?3XkvgshBDVU/REJla1XiPEt7PMTtGkVSo8opRwWirFwdZF2c3NEEPNjLfYIO?=
 =?us-ascii?Q?tnxQsuiXYRNkCAuymP29poeVis3ciNDCwyoWjPYHdlBqkXUmcyiKWsDz7k8O?=
 =?us-ascii?Q?5679azZrdNAanClzK8wJJ1yOyNsxD4EiQKHHgXe4KCJzSvvQOIJlVE/Z46Fd?=
 =?us-ascii?Q?fmIeZooSGpXVmG+GUsWmrEc+53BU7ps8et+Aq7AqEdFvvCKu8P0fAZk3sw7D?=
 =?us-ascii?Q?EIgVIsvovrx4e1XEtYeT1NCX05Egr3ZweyFQJtEQEtid6L7ushhGjw6sTYuw?=
 =?us-ascii?Q?TeUTDOG2DP49CfRf4s3DfXZgHFfZl4kZ5tGMQFeE4cKsJLW51hAcQJg5SLM9?=
 =?us-ascii?Q?GzqC/SZq4rHqcWvuwtqNl+y8?=
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57780a1-427b-4b43-5561-08d92c7f98d5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 02:21:18.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BHxJzkszrGZ0xB2OYxWs3YBEfLl80v3Sns0Eib9h3GRvEN03VeM85w6jvuzXD4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4866
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 77271ce4b2c0 ("tracing: Add irq, preempt-count and need resched info
to default trace output"), the default trace output format has been changed to:
          <idle>-0       [009] d.h. 22420.068695: _raw_spin_lock_irqsave <-hrtimer_interrupt
          <idle>-0       [000] ..s. 22420.068695: _nohz_idle_balance <-run_rebalance_domains
          <idle>-0       [011] d.h. 22420.068695: account_process_tick <-update_process_times

origin trace output format:(before v3.2.0)
     # tracer: nop
     #
     #           TASK-PID    CPU#    TIMESTAMP  FUNCTION
     #              | |       |          |         |
          migration/0-6     [000]    50.025810: rcu_note_context_switch <-__schedule
          migration/0-6     [000]    50.025812: trace_rcu_utilization <-rcu_note_context_switch
          migration/0-6     [000]    50.025813: rcu_sched_qs <-rcu_note_context_switch
          migration/0-6     [000]    50.025815: rcu_preempt_qs <-rcu_note_context_switch
          migration/0-6     [000]    50.025817: trace_rcu_utilization <-rcu_note_context_switch
          migration/0-6     [000]    50.025818: debug_lockdep_rcu_enabled <-__schedule
          migration/0-6     [000]    50.025820: debug_lockdep_rcu_enabled <-__schedule

The draw_functrace.py(introduced in v2.6.28) can't parse the new version format trace_func,
So we need modify draw_functrace.py to adapt the new version trace output format.

Signed-off-by: Hui Su <suhui@zeku.com>
---
 scripts/tracing/draw_functrace.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
index 74f8aadfd4cb..7011fbe003ff 100755
--- a/scripts/tracing/draw_functrace.py
+++ b/scripts/tracing/draw_functrace.py
@@ -17,7 +17,7 @@ Usage:
 	$ cat /sys/kernel/debug/tracing/trace_pipe > ~/raw_trace_func
 	Wait some times but not too much, the script is a bit slow.
 	Break the pipe (Ctrl + Z)
-	$ scripts/draw_functrace.py < raw_trace_func > draw_functrace
+	$ scripts/tracing/draw_functrace.py < ~/raw_trace_func > draw_functrace
 	Then you have your drawn trace in draw_functrace
 """
 
@@ -103,10 +103,10 @@ def parseLine(line):
 	line = line.strip()
 	if line.startswith("#"):
 		raise CommentLineException
-	m = re.match("[^]]+?\\] +([0-9.]+): (\\w+) <-(\\w+)", line)
+	m = re.match("[^]]+?\\] +([a-z.]+) +([0-9.]+): (\\w+) <-(\\w+)", line)
 	if m is None:
 		raise BrokenLineException
-	return (m.group(1), m.group(2), m.group(3))
+	return (m.group(2), m.group(3), m.group(4))
 
 
 def main():
-- 
2.25.1

