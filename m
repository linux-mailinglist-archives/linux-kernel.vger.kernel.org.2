Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236BB3064BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhA0UDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:03:51 -0500
Received: from mail-am6eur05on2126.outbound.protection.outlook.com ([40.107.22.126]:52350
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232376AbhA0UCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:02:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQGdj+M1nVLxSCdMgBzYL3Wu05TQuhIZrpbTqAymUO8ZaDkjYsXwtu+7e2HI296gEVt+xiDKe9GrynUTWOa/8sCLWpNU0dmXma/FE/6NjPdvtHvd5osyfBYWxOaWPnGX1gEtBBccmFEEsI8NSQHt0mFO05MnH5l1S03dcO1uXif8Ad5k0ufwdugFtiTeeYBHn3rlNSkuNL1h7JOomr8xrwfqwZkEiGPklmJvj9kHoGxZ7J60Qt1z40oVQ6SItAQISuQd84c94M3+/n/7iDEEoXbMpGX41ZFDu6PvQVanbT0qt+hnaBfO6OyaApvXEoYx65hfpUQ2DXiFAIkl6g7dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZBq+OYsnu+vbBAetYNqXoJc8Ft80+44oyVhvAsvyYY=;
 b=TeDXvgfBwx5ZE6iy1eS+TEpwfLVVfHCjKPdd90mcoBO1xB6rCJp9d2PLhzA7CJD/772bmpZxWlGDIFiMwsYMlonCAWY05qTCx7BMXRVTou7nvDUY7D3nLOJs95wwxYsGobkE9hyQGT2g7dkIxlsYvhtEiYVkCTCvLOKm4bAZIseS3ZmTpFYSjgb2cBCjTFi+icbia18ql8El+DFRerLxoTqoRZthh226MDKMGyg6gt3NbtPIzzp/PutRCrFaZNPL8S2DEooJem37xL4brOsRbkq4ygPFuC15swRx7EPtNth1v3c2yrFmZH6PcrSw5J0AsnNoDjekkTzhUGCI8CPbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZBq+OYsnu+vbBAetYNqXoJc8Ft80+44oyVhvAsvyYY=;
 b=Pa8wU7mgLVO6p9+jiJajN+Mn5X7ujWnjxyrZ4NNB9CjBuiQc0VF7O6QueQ6NZeowskAHClYmBQ9NkOWZmiJAjP0AOvFE5ScoBxkzk5taX33Kr17ZzGg23fR4O2o8sIlU2eHI7Kmdf5WBucnEL4/pn6De6qRzcLkl9ifYOxGCFeE=
Received: from AM5PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:203:69::25) by VI1PR07MB3470.eurprd07.prod.outlook.com
 (2603:10a6:802:24::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7; Wed, 27 Jan
 2021 20:01:25 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:69:cafe::9e) by AM5PR0202CA0015.outlook.office365.com
 (2603:10a6:203:69::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Wed, 27 Jan 2021 20:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 27 Jan 2021 20:01:25 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 10RK1NYh025069;
        Wed, 27 Jan 2021 20:01:23 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] qspinlock: Ensure writes are pushed out of core write buffer
Date:   Wed, 27 Jan 2021 21:01:08 +0100
Message-Id: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4c6351d-9918-46ec-b02d-08d8c2fe53dc
X-MS-TrafficTypeDiagnostic: VI1PR07MB3470:
X-Microsoft-Antispam-PRVS: <VI1PR07MB347039BF6DD2307AD573FAA988BB0@VI1PR07MB3470.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUF18WV7liOxhfzGTSuU6N7w0NrHROozecemVc7bigQ+SXr/BQFBFflH3rGCv07g3R26dl/HQmVB7Kwf+mK+DwMNd99u5UU6hFurlDonot4Ug33TE0jcTUHagtIuZ0MjuK/qoNypZDwED43UBYZ8e0WlG4/JHBHhxtertgd6eWHxhUn0qdTyTCD6naiwoZDTNrE6ecL34w3DwOQLjisikb6aINZPRB56w+CAKzlPV2Licd6WpQkY2GtTxT1hy3Osg0ulslLtGqx5TRRpvf3mJE/7uPa0LZ+Zc953xPaShN986WtFptNVDExBuQAP77rT2irwncOR7tfdcp1sfV+opEekbUTpnbZLfYiQVTuJweE5l4N0fqc49mylgDQ+A5/yj3VVHwYcITOD/AsuIcJrlDG/5bbyCNHc8Q56+bJkRUIWcL1wSqHDJgJaNKMANroOI7KVmbS45Sdxd9HE0WlPxTSPe0AbaNFNXGMgB7h3x91T1mJfXW1Oj9BfjN95qk+ga+USquXGQsls77YWlvRji8IA/LTM7ZXt1uN3CVDttSjzvWoYeFFt4LXzLEZqn0hDjh7uAUCvRVUGWGkIJZvTk4tMoWEa1U0UlIDPlggjRx4d9YZvcwBYagyDB2qt9YxP
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(86362001)(1076003)(81166007)(70586007)(356005)(5660300002)(4326008)(316002)(8676002)(36756003)(54906003)(82740400003)(47076005)(82310400003)(110136005)(8936002)(26005)(6666004)(2906002)(2616005)(70206006)(83380400001)(186003)(478600001)(336012)(36610700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:01:25.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c6351d-9918-46ec-b02d-08d8c2fe53dc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3470
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Ensure writes are pushed out of core write buffer to prevent waiting code
on another cores from spinning longer than necessary.

6 threads running tight spinlock loop competing for the same lock
on 6 cores on MIPS/Octeon do 1000000 iterations...

before the patch in:	4.3 sec
after the patch in:	1.2 sec

Same 6-core Octeon machine:
sysbench --test=mutex --num-threads=64 --memory-scope=local run

w/o patch:	1.53s
with patch:	1.28s

This will also allow to remove the smp_wmb() in
arch/arm/include/asm/mcs_spinlock.h (was it actually addressing the same
issue?).

Finally our internal quite diverse test suite of different IPC/network
aspects didn't detect any regressions on ARM/ARM64/x86_64.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 kernel/locking/mcs_spinlock.h | 5 +++++
 kernel/locking/qspinlock.c    | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 5e10153..10e497a 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -89,6 +89,11 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 		return;
 	}
 	WRITE_ONCE(prev->next, node);
+	/*
+	 * This is necessary to make sure that the corresponding "while" in the
+	 * mcs_spin_unlock() doesn't loop forever
+	 */
+	smp_wmb();
 
 	/* Wait until the lock holder passes the lock down. */
 	arch_mcs_spin_lock_contended(&node->locked);
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba..577fe01 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -469,6 +469,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
+		/*
+		 * This is necessary to make sure that the corresponding
+		 * smp_cond_load_relaxed() below (running on another core)
+		 * doesn't spin forever.
+		 */
+		smp_wmb();
 
 		pv_wait_node(node, prev);
 		arch_mcs_spin_lock_contended(&node->locked);
-- 
2.10.2

