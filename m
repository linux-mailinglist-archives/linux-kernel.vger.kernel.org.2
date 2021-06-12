Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A42C3A4FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhFLQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:07:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35959 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhFLQHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623513907; x=1655049907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=v/hxLfV0cTDkNYhihcvCDnF5EPLNrw/fXLh5tepUQ14=;
  b=P2b8Nmq2z9FD5Spt+HGr4bdsXe5GWlgNE76oy2tI/zShR8op0Z91Y4S3
   4e70tNRvVPJrYxRbwMblOSUxJBi2d8ng+kEzdUnbiU/ouyoD7o40VlpS6
   KiFG03o2v9gIk6bX557Gc1djQ2A8Bv+oZhR10qWo9VW4P2DDkUdR8LeiD
   FSttr7CzOqI6psIGAAqrd7zWNmcYtYpjiGfq0VpjjL4+yXZIyJkl436C2
   9frussUef93ZwPZgSyzzOw14VUgOT6rYZt9DKGOIfVjwPGG2ZhUNABYe+
   B7IVXh7U6KU70ADBrjtH+2YHKfNesBSiWf3cn5Eb/jDndaz1o08RqR3nK
   w==;
IronPort-SDR: wTheYebw1ENM2RChqNjwic8u9yWcq5NNtHUjP4UKYw8Lr3u1LSvVRANZtYzd8HUXR5s5HoIMFx
 lvdJxIQXXBTvzaIVpgKSdJruKe4j6l2/8L0n0JcpckpyVGXN7ixwVtiJHmHjvqlLv8zI9O8TJ3
 eZTzkz5Ei1mNFifctsW/uZ7AWdsJJyc59uccJYG8tn0S70/KZv8siR834Ib9Ev2ZM3JOzikn72
 /FgPywh2NyWfv1zxGdwWdBoUoj0TbIX72eJs6HKyyLTW2q5Q/t5OSnpY9kFbxYlbolzoIyweat
 RKo=
X-IronPort-AV: E=Sophos;i="5.83,268,1616428800"; 
   d="scan'208";a="283160833"
Received: from mail-bn8nam08lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2021 00:05:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1SQCOj4rjx/Oi+v0JGf5w+zDFSGtN27JXbAHUXlyOHjtYOftV2H76ufq9d5TLinuIKJJpRdqvpcasvfvD5ICJdNgEZ6+UMztdsDBD7UxWCpT2aUNjD2ucAibVE9tYcYcj7ZI8BLXx6lxdQux6k9A21c4mYa/xPmWBX3/ywKZgBYtoOcFw+0qoTOzUIjDBjB2Jq0P3FvTcx/A1cT3ABuogT++3buT6I1X0MunFwz1Ys+r1M/8cYd0SKhIapVcR5n742VoIsUMj47n8I8rL8Ha/SumvBluIzmyMZAnXX7od2J69ONmGXKu34rMnEpLwXU53kqqf8hefLOueAhtei0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C2uVoM7fSdgFIDMz/ulKCO83XH4Vj/ka/V8CgKd+QQ=;
 b=BBzcHsQr5TjowFHVXMK+SEuZ5+qewuMKHHtVjfCuMnO4kmh+4UzZI7R6+srZ0z07uNgQ20Wz6ODscPx7A2IBtajEyOwAR6lcaS3uxwx85+JfsAhlt0aPDiO18TwMVwJ88949QugrA6FJcnL8OKY728veR1i+eGl0WBVu1P4238ZryABvmsghwNmcvDjJiblbLLpyjjZYho117PDCD8JQp0hw6hH39UZMht4yZB08b93R2ltUt42f6jBOFNqlMArsKehvfhKLNOLTxMNK32QrBe2Uqv/4TNzdYD+Cy2VThofcrn0pA6F2/Pac8GKBP9KegqVsJQM3ZImt9pdMEbE4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C2uVoM7fSdgFIDMz/ulKCO83XH4Vj/ka/V8CgKd+QQ=;
 b=kIvDXnYts05ZPBPgb85p9bHhXfj2Y/h4nyAnUjaTSn0rzygh+AbSimO8rvzK2qkImR8wWrZ5XE/TB/orUUlTSVULAv6/oa7qPBFDhiEryYvHly1tJ1lwdscbMeqfDkzdKbbtp1QOzMYVzsPuIBHBt8SmpKezbaN/h0F5V0PjLb8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (10.242.165.134) by
 CO6PR04MB7795.namprd04.prod.outlook.com (10.242.164.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.23; Sat, 12 Jun 2021 16:05:01 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.025; Sat, 12 Jun 2021
 16:05:01 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH v1 01/10] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Sat, 12 Jun 2021 21:34:13 +0530
Message-Id: <20210612160422.330705-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210612160422.330705-1-anup.patel@wdc.com>
References: <20210612160422.330705-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.171.205]
X-ClientProxiedBy: MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::14) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.171.205) by MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 16:04:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05bd624c-5f6b-40be-2bda-08d92dbbd55f
X-MS-TrafficTypeDiagnostic: CO6PR04MB7795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7795D71B9F07F48B35DD50028D339@CO6PR04MB7795.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lr7AJ5m7HYgSBGj8+H2qODrSSOzm34eRkUIB+0J7tMZqpMfZNdU/ggnaBpbmt9HhviATBNhWbViNQlY8NkX6YuGB8AZ8u6ZCXCPC67BmJ63DwjfvAH/WSTgd8ObnVhbL1/UHIODzTa+zoYdWRmnZogEERsjbtTFPdV2n0mqRrg2KfUz8z39d2bqYZENxwCmOlPoGMo/jOiZbtzsoDv1yJJr+qOUFXj3S97jTXEPR6JONTKNCHnErqpCHkng8vIB40E3capw8jcKNizAWUZxtis3O9Eow3kwQUIa8w1adxwzAK3nRYeyrB6d/jHhg6C2hq74RB8TMHqHp+xWC+1ciBxXFoReqymegkUPd170u4nwJkcDft6/4W3mLLwEor7BASySEwESImhBRSoS9GLMK0R9WmHmz/04MNO01eC3LwRv9YLyCaWp/l74AEzXBL09+TlLCR8hJ/J8q2VrQ9mU8U3DOLsIESMiYKgKns2aPq1ovFCdefbeATpKmLuNuKqXdPF6wMaEGkeAT7MWkizGd2ptl8ZIfWNmffQ9mrp1p2rh1j42dRRTBv9HP77+Q0QWuQMgzL/MaT/L7f5xoM5Xe27KMZY4GBOjrBYPx2tjCfgnslxovt7YnGjOQnDJkSWI/YMwilfeRthcTaHylPr9zwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(36756003)(66946007)(316002)(4326008)(38350700002)(86362001)(8936002)(55016002)(1076003)(66476007)(54906003)(66556008)(38100700002)(5660300002)(2906002)(7416002)(8676002)(8886007)(6666004)(44832011)(26005)(956004)(16526019)(83380400001)(478600001)(186003)(2616005)(110136005)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/2QlodSBOAwBhRuoYH+H0NDOU10lTWTbXcmIeojJEbOY1rSwlHPGUyN4BvI?=
 =?us-ascii?Q?8orSS1pngMI3fM1wJdHjntCr/ogdrt1kE76OnlW4XazHsKgSbEjTFFaXwSBJ?=
 =?us-ascii?Q?GtUvOXO+iwk7Nxd9hCVQeDl/t6T/IlCrNndJoMzyluE1xY0zzBvzxrOXlCnb?=
 =?us-ascii?Q?Rp0SJcvtgndlcJdIKpidjgAwA3euBciTRQXKYGWktmLKcPZjRFFybm/vqn0c?=
 =?us-ascii?Q?2H9tEI3PaFcn79deTDQ744ca0TRa0LfnKhlgX4z4o3IABQWIlJYl0WeYdHbc?=
 =?us-ascii?Q?lqhZD6ciIN4ln6HaOojxFdyqKvyRKtoDuxia86nIMF4jcmDfd/G65K/I7uDu?=
 =?us-ascii?Q?8t6NzgPxSxjb1IfjcZrj7OXe8jrZmkQVklRX/COif562WUJGHpnR9DzbSX+/?=
 =?us-ascii?Q?ZYtRXBO/G+UHOZHgL/6kBLhIF2KxWxy3GjPj3TW6OhyTGm4gCiZkVKKL/S0M?=
 =?us-ascii?Q?aaepnoI7JdVFqjaRvEmMEWJCBXnprioQRycPqh4K2cUzuRJi3xpC/x+12RMC?=
 =?us-ascii?Q?J8Iugc9Lj+jwYi5JcA0zhctI2k7kk7pwnZgY1hnmKC0ATNS0SCluZ0yC0c1s?=
 =?us-ascii?Q?5MZhKcxIhlavO1f8iMfBBzdfTOXZ1K4BL62uaTAPfxc+s+hBHxfJjGcoym26?=
 =?us-ascii?Q?nTi4lP+QTPH1gt/+YPZlTeofSZdJ4FBCD8mWK0Kf8JJUGKntIg1YbZlLHCgC?=
 =?us-ascii?Q?z2f0JJfBXrERN7tzrkpWEcF4pxZdeuEssxNOkrr9er/7d36iIIvRsuIxGSfj?=
 =?us-ascii?Q?Ybyydpr0++PWk3hw5AIubyKoHqSETIzWQSFfQ2clqm8LCxN33xSsFF45tx4a?=
 =?us-ascii?Q?9NQYVRzU8gSjPTZxJ4dRU9tBQ01IH3gSsTsdnO9yBh3L7QHXTJACNQ56nMHo?=
 =?us-ascii?Q?jc2Oub2lWmkKYkmwErgJnCNnQZ+8gO1o83/QEhtPJE/vqyuBg5SloPOfhwHn?=
 =?us-ascii?Q?n73lNoflIJU9rrTzOEzb7tyIAEzH30enjUZsXiyTTlitJtmAF/V6vhkZLm7Z?=
 =?us-ascii?Q?mXTSCt5v5crZsxgD0g8q8Bf1VNi5wiTXAlb7GvIq2APsfkwjFJ1KsFkWUKMF?=
 =?us-ascii?Q?cTRThX4JNphSB6ns03RGCWO9Br39sBOtatMDZsrThvTzeQc7zpPUEYQR4Tnm?=
 =?us-ascii?Q?eKxihspLSsFTv/kjSruWAdohyLw427zZEiwpOVDOAoKqOyafHmq/SM7svEad?=
 =?us-ascii?Q?O8gHOqMUaZoLI/JzJZyNr6X7SY/evGaqYOnjdTBTbkHh5RwEwtLdFWBGy0j8?=
 =?us-ascii?Q?8pckWRGP/OjR6xilUt4HKGZe5lTwHlIG2jJ41mK+lfmDhVdOsCtbf/rYsljY?=
 =?us-ascii?Q?PXSZHupqZncpJ+8FIxLIylQS?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bd624c-5f6b-40be-2bda-08d92dbbd55f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 16:05:01.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipfRW4zjJbggODENtRUrHx988hSg9eRLX0JxlI2vCvaJ7FwAn+VdbWYGs2O1DB1Rr9DVuGew41bsJhGlNgmVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
S-mode but readonly for M-mode so we clear this bit only when using
SBI IPI operations.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/sbi.c | 8 +++++++-
 arch/riscv/kernel/smp.c | 2 --
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 9a84f0cb5175..8aeca26198f2 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -598,8 +598,14 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
 	sbi_send_ipi(cpumask_bits(&hartid_mask));
 }
 
+static void sbi_ipi_clear(void)
+{
+	csr_clear(CSR_IP, IE_SIE);
+}
+
 static const struct riscv_ipi_ops sbi_ipi_ops = {
-	.ipi_inject = sbi_send_cpumask_ipi
+	.ipi_inject = sbi_send_cpumask_ipi,
+	.ipi_clear = sbi_ipi_clear
 };
 
 void __init sbi_init(void)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 921d9d7df400..547dc508f7d1 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -99,8 +99,6 @@ void riscv_clear_ipi(void)
 {
 	if (ipi_ops && ipi_ops->ipi_clear)
 		ipi_ops->ipi_clear();
-
-	csr_clear(CSR_IP, IE_SIE);
 }
 EXPORT_SYMBOL_GPL(riscv_clear_ipi);
 
-- 
2.25.1

