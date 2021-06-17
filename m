Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FFC3AB94C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhFQQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:15:34 -0400
Received: from mail-co1nam11on2108.outbound.protection.outlook.com ([40.107.220.108]:26374
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230361AbhFQQOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo/e0zPQOZX6zvbH8MmqFETigQfKboSSfQxpLOFS5xnrlzqTi35Bz3VIOs4MiGAE7M5ErsEgblhH+YQhJdOrGSE0mczTKn+hB/j+fstPwfvypGRajF8kNFWxlIXFmxA9LChTCK9nGdryQUfsqIV06lTsXc345I+Wyw+Xw6VLvv4DChKDuRObVICF3rT2SGpdtjrTirh6ESo623gxIYeuEgKxnQmdY6MhjmvkizNJtoS42I/lUoHI7vtew4vEE3tdABLbGVZW3+wv6Qu04VeeqP2UqtQAqqLrb8e08MOiOP01DIcVPZ3ADBZMLoWWryQPV24gRYIJ4/ZQbXOuePB/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MagYXPZZwuycvXsWjTQRRp+kF2mFNcFS8labFN7g84=;
 b=aGABMA6+hFef1r9Ie05WOpNZOErU9rBtXq1xeVvLyiWvOdHBrbperCgZNDR8Jdy7pmvyS+/t30WZ5ptn41MJzZ+w2Wn+tazxd/9zWgY5Oo2KjIOyZpz8JATR7gFVP4AtrN2tP7xitRIZFuKBjK9G8FdcdfqvxFoZsDKl2sjKBKhzad1veg2C+pzL6kHsh4P1aqGtJzTpLxGTyPvis39twHlsByjwxNBNiVqeSJ+q52HCrKjThT8eC6AE1kw8hDo1PX1FfyNv8oRbM3Q4bpUkm7CVgoaCezenpWMclxejpYnkdEf9yTffDdsdzJKUj6+QF5nipqrDjglZ4sNvC5oDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MagYXPZZwuycvXsWjTQRRp+kF2mFNcFS8labFN7g84=;
 b=mG3CvnhsTNPeaU0S4DxWbUitwd2f3gwb1kkrHDR2GMxGq5l8PzL8Lr8IMjVHMQ60H7r4fClH5fJv5D62R3k6rQ+msMDgRZ61HiI1+tJUGUSO3nmaN5EaDJeae3ursJiClvr/0y4f1cbjbW/SicbHs2eQzvzDmtDSk2q/seKssO8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BY3PR01MB6642.prod.exchangelabs.com (2603:10b6:a03:36b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Thu, 17 Jun 2021 16:11:57 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::955e:5082:494c:5341]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::955e:5082:494c:5341%6]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 16:11:56 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Fix invalid pointer when access dtc object sharing the same IRQ number
Date:   Thu, 17 Jun 2021 09:08:49 -0700
Message-Id: <1623946129-3290-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by SJ0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:a03:333::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:11:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f62365-9d5a-42c2-2695-08d931aaa0f2
X-MS-TrafficTypeDiagnostic: BY3PR01MB6642:
X-Microsoft-Antispam-PRVS: <BY3PR01MB664296897F6D939541B737DCE00E9@BY3PR01MB6642.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+vwXSZ30zb92DZfVTXiY2vZJ1vhkkJx+7jAlUxhthPUKvojDdiN8dPFKUJ1Gs63vqMHjyXgG52CYK/clXJcUN5O/jdoS9ix8uzUTR2b87IpJpLxR/BRLaDEp8TjRe1QQ1KZbXxv7X9erZlh9NVWmqJHB9zQ7/WWlhC5OuCvF7Wc8sibk8Pg8RRZh+6WDltuk2lLca8BLMmVjb6qBXbvFMJCQw86UHPNxtxwZOjMP/WbYWPSnLv2HjcnjNII9zCkqZ1D91Ut14Ghv+X3+8VFuPsWgT0GRcAvH+RvFEf9kcWwmMXYCSa3/9Luy2JE3Y4ahQT9D5oMF7eATFpwHl59MU65h0nkbKDVK+BDt/yGKPXzPfAME70tKLAcxCXO0iC+AJA+iC2uWaA/e8S6ClyH4lnH1y+0oGXDoKIj8rnoR/FGbXfkW8qu6cG6D93a5m9ZT2DhxqBFK17XmHpaL7qnY/5mXyv1EOve8ygHUzFnejnmOOYur6/rdQjY9y44u9M7H9Rmc1cV4f9JRgOVxCkobuoBhplvAvF7K/x2jeOb5a0LplenbFLFFIN5e+dYdaH7jYa/kqbdfEVoJWyTyFf8HbF/G0e/a9SGIGv15auUS7oyEQ0OqsfZMM9ewSjP0DwwULtrXJCFxwX1GuuveOo6yhHCnWgO63ppivId0/0dsw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39840400004)(376002)(366004)(316002)(4326008)(54906003)(6512007)(6486002)(109986005)(38100700002)(186003)(956004)(2616005)(83380400001)(16526019)(26005)(38350700002)(6506007)(8936002)(4744005)(66946007)(478600001)(2906002)(86362001)(52116002)(6666004)(66556008)(8676002)(5660300002)(66476007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fP7Kjho0jaCoIjaEUDBBqUZVCI+LW5REp0g3bUUOdNkBQCUXCGtgyyaMX44W?=
 =?us-ascii?Q?5FVm5eJod5Ysfmt3oPpvVZohj6LVP2flGm2OtA29pP7Qn7r/T0WpEYDG069J?=
 =?us-ascii?Q?IG1sseYk+IHtGWB06FNDhi1ic+CfGD4oElUPexdMwYmF4IvAGbMFN0g5mEM0?=
 =?us-ascii?Q?mFrlOAg5bAUF8k0hpBvc7LHSNfZDGmXmEyHZXBtGh99penG03M1Ml7NwAm40?=
 =?us-ascii?Q?Kn5iAM3nfINQIrmaSo4CMW1CvZCB8OZajnorNPQfAi8fIY6kOqIWi4KlR5DS?=
 =?us-ascii?Q?0bj0dVkKk9tmyQabRdrFAGOSwXqJScV3AI9VQ9Hs5ZQnuOYio/bHykNXnBVG?=
 =?us-ascii?Q?IykY2ZG6WmZDZ1jQCM5yiIMtsNKCRG7UGMlBoQmhOQj+AXnf0GzPo9wwHsPG?=
 =?us-ascii?Q?0yKakd5jlGZkesXX5gBkUKeWPFNbTxQbIO7AL/jPhn3aWtOihAMBXL8Dlckv?=
 =?us-ascii?Q?rmrmwiNM8XTkUDqmLIYvArOqFWc3x+nvBzCk3Gic/dQITJrbUJyJparJHe/i?=
 =?us-ascii?Q?mbKIsPsW9weQPF7RmwGafDc7iwlVVcpSjbt+O2SSjRj56PwaGcE6pQlnO8gr?=
 =?us-ascii?Q?o6+wALPRKyBM9oDWJ4I4Sl15ewB7Tpn2CadbiKzp90OykZJGCp8S4lkI/3/T?=
 =?us-ascii?Q?uPZmOJKpccLeyr6ANKO1qf1J95kT82kUV1DRemUReUEuUMceRUOUc+7YtZ23?=
 =?us-ascii?Q?hkDK33g0jD7jAX2vu8F+OAXV5laxGzEyYFdXCkT0qKEeOpB98GUYsXOC8s/p?=
 =?us-ascii?Q?IMff4jhGZUVbiG7kyM/luQlkb0pKzdR25L2m8zSGU5dHD0SIVxEF0QIdijFH?=
 =?us-ascii?Q?9P9gp7M+BHhucoxCJIUhbSzxHNpwAHXyRlKRDyE5wKLQj9sgd9z6BsL2Cp8W?=
 =?us-ascii?Q?QagxejCt4Kmn6NCGnvtLgJgiHXn08aN3hwkeblkuWa+55j9ZflrldGj8oi+l?=
 =?us-ascii?Q?xuw3jCCFepnmt2FpriIBIn2NTym6uQ7R02FQXZMW8zSlSKGXcBWDNQJcjK4I?=
 =?us-ascii?Q?k5gxlg1HKEOGlNPl/C9qccu+sbsd1z7MdRyElnNDMgOEl46wBwDPU7s3Y+EN?=
 =?us-ascii?Q?POg3gwvCneAktfB8uZoFkhNJEjZcV5da3goVFTFsj0OdF5sqlmsoVMbBHYm2?=
 =?us-ascii?Q?VIBbIGu84bx7TNumw78rhzhUgzzHkQR8FYprrdDO09wz7zIz2ekoo0qEShz2?=
 =?us-ascii?Q?NkgEtMreeQBJxTFyLCoDWKMnILZRsKrdT6RpxaCgK6MlNL/f7F8akH4CwqBp?=
 =?us-ascii?Q?oE7QQQ/9hvvb913AzVXnSpjOUdXsuzHhGbZ9dv32ce6SuYDdDNiDStjEtIkw?=
 =?us-ascii?Q?TGmPYOsAm+/4Jwa5rl4XPna9?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f62365-9d5a-42c2-2695-08d931aaa0f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:11:56.6280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPpo4qaawTcs6uGJ4RTShrKvttOIIxl5i7/XGVk6ggZPSSUPqamWO3R93GYN5kB2RTSHAhs0OLHplD3qp5iXQER+wUfIX8sADI1WWEnpngteN3OaHq+Nzlr/Xn1DVT06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6642
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple dtcs share the same IRQ number, the irq_friend which
used to refer to dtc object gets calculated incorrect which leads
to invalid pointer.

Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 56a5c35..49016f2 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1212,7 +1212,7 @@ static int arm_cmn_init_irqs(struct arm_cmn *cmn)
 		irq = cmn->dtc[i].irq;
 		for (j = i; j--; ) {
 			if (cmn->dtc[j].irq == irq) {
-				cmn->dtc[j].irq_friend = j - i;
+				cmn->dtc[j].irq_friend = i - j;
 				goto next;
 			}
 		}
-- 
2.7.4

