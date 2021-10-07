Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08CB425335
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbhJGMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:39:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29311 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbhJGMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610227; x=1665146227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kRFIsrXRxjx8BbYZWZU/yYhgpwiiKVcT4u/SpXRbxcE=;
  b=ZEyZvZeg0qsSy0ed/hQAR+0xgXXNITzMgLbDDWxJIsxeOGo0bLmRtK3v
   6ENkN+vgY9BI0Pbq3XrSNCC06l6ETvab4/rrXxQobsVqC1ziHk2UB8+NA
   FOklIMN6Mz0tkmA50DfCmpj2TP3AbOCoA41tH6uxya1WH91Jaaxwp8wNg
   wL/D3nMYq0stJvTsV/pXs9H9sZ5fRmzZUD5pQ2y89HaXfkKh7Gh+jpmQn
   dMldLn2aZ51Uo3AnYf+6JuxtKgiZhoGaIWHRNktybkmwDAbF+R9C91B5j
   TgTBjBqJqkIu0tKCsQFNJUSkwsDPSU/442EqzIDQTk2f9kZuiXbYHohen
   w==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="285991598"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov3A0wCnp2lkmjVw9DVxE7479LGOm1++4MKbIzJgT4f0lxqkqIoxtz5g2b9NyZSxjyWN6aqowRXJzGe0N+y3xOVpA36bl9RcA/wDERsujiJbUlkmMeMF1JAPL9kVRp3CPhNTZnY9R/HYVNd0WmPuuQUOPV+dClTVL13toYtmUp7IpN24TCmRDCKd19C3ITgOIhw3tXZUXlcRrTt+LEZQ+kG5hp05pB54ym8nKhE4JDn3FtxnFJwQahnZe3D5P/G2jRCni9tVFcgw2DoI3TZGxhHFXCkUuEk5VXLs1lZ5Olcc0T+bZ4f4FO3QWO6GBN6ipykkPKJ4LjYG54b40k+QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOyALsSZyM5c63OvTUlUo42PR2FT1T9JpuApyyCliEY=;
 b=BlYJ+uva2LH3r5QrpGujx5UVeRWy37XXDxCV6pcApBS+7yl0SLn7Qk5g5pQV4pekj8HHj0h8Cc6rOzss4o2w61QhMtaGZ8+FQwItAFNWEEEufilW9gsw+/ZGcZlv9sHPpGH0VNlYMCStHczAOY+CFq3mIK6eNjRK5k9YHWQsUqVVpReH3PXDwYOjYIZ3TJkMMLxkUQm30G7FCTTCMd95Uu0kLrlLzffjfLn5vpI6N7E+Vv9IWqzQM/4+vXLogwNQo5N24F/ursh0sYaSrn+hiiJ7jPNPHneB4HZsBrre+SUnxnM/E9vgEa1Eq63w8zNu2Yt/JpncPsQGeNlDVHtokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOyALsSZyM5c63OvTUlUo42PR2FT1T9JpuApyyCliEY=;
 b=Gi5UT4R2YBQBDir7Hetk38jeFhmpOvsDQoNv8+ROK8yfZ8WHqhG+AiL1QWCrMCJLIkM0tYOjl6/ahqyBnl0L9iDHcbIhOBUch9ozzf/oOwVq55mQE4ILnlEPDDh8QmzHbzIzADfoxijaOip/vHEa6AaKUJEgRczWPfixcXaTkT4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7777.namprd04.prod.outlook.com (2603:10b6:5:354::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:02 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:02 +0000
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
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: [RFC PATCH v4 01/10] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Thu,  7 Oct 2021 18:06:23 +0530
Message-Id: <20211007123632.697666-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:36:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91c8631b-0f8b-4d89-dbeb-08d9898f29b8
X-MS-TrafficTypeDiagnostic: CO6PR04MB7777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7777DB8F91AD855ACCB019228DB19@CO6PR04MB7777.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSMnTcXkZakR8EWd+Ph0LzIZDpKopZAexQveOhPdGv9TDh6XkxadkJzMyz5BASfqz0O1jn1Cdu+NE8mz2J1sFYLWx/5Yt9ins6UZq2M1SI1EQ7qQqVhrdrK56cdsQM0Skw/iZeKIoInuw4hjJgufF1tZu9argm8RlEyTTH0g/lzjx4qxL57TIxNVF78VTd+qNiXXS0II+B7s7Dgkm2O4buicxMKajODLZI1LKAQWwGLpk44WgLZNZAYvSSIRzHYg9V+vL2/q+FHAZjVf3YTFSo9j2UeZB3a9KrG9XpjmJ9yOhfYJIKVXPXJSN+LdQbmksNxd2S/uMT30opvwrdMfi54zZPYbtfRiE9zvcyx3uDirlgRLJvlZCE3IwniwwofuudzqxmqbPb9TgEJLuBKR7/BpbWj36BlmsATRDhxNaoQpw9XQwr+QrNPXPrCPgtmT3ZFlhzk5DJVg+OoBRSIU/DjWgbDBciVIist/gVXQEeS9IZ1W7hffQizc1a4ZO8WpPjOb8/J08tUFESsq4e0ei/QvDXJJdE2CKDnmmoSwxAyPo/cxpmnCsBj04BBBiGemxjOU1kuvaMZHMGY6xBL/lcJ82iI8v+QnrGLoLKcuK0qMWp02ZxRZJX6+/hJ43nru2UZbpghYGOIbsmFnQEP0aZm3Mk4Ud+aJtYaPqViN6ANXquZpOVhsywscF+sufN7vvmz6YlvQC2lk/HOMlOdoOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(52116002)(1076003)(316002)(110136005)(8936002)(7696005)(2906002)(38100700002)(38350700002)(55016002)(508600001)(7416002)(86362001)(66556008)(66476007)(36756003)(4326008)(66946007)(83380400001)(8676002)(26005)(6666004)(8886007)(186003)(2616005)(956004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4vEs1vHAdsqbDbNmIE10FfodvmN6wnQfUY/5vWH6/gvZE6XeKq/xhrtWUhd?=
 =?us-ascii?Q?tNy8xDAPCHHhu0Uw2eDU4j2dKisB9E0aFUET8TdSPw/qnpql/fBH0yjoZFGr?=
 =?us-ascii?Q?+aBdDpUgS8LsLzp5v+7V7bXjqqXkHOiH6IFODG8l7DKLdOZiNwZqD2NoG8h2?=
 =?us-ascii?Q?F2/q4UchvYbNKkUMokkVJqHqXap+FyA6lJX+vhqlWhc73+7FeDToJlOZegyA?=
 =?us-ascii?Q?qofT3ilc3oPupoRRDhxBb5Vpyp0ItBkwqgblW88zRtvScyFmUGEuTQjsWiqK?=
 =?us-ascii?Q?UId3QH5C2zHlkvBJPYmoPa+jnhuPpkbXNpTTmdsZEsPHq99U7GL7bRtXyVFy?=
 =?us-ascii?Q?bRRZd0UjuyK+nLde9Ymh0LL2KODPmK7QZvXYqo8FcdIossISDQxgacxWMBJD?=
 =?us-ascii?Q?bLyIhqTS8eNCVVd7hO9rDJA+QMQF1Q4QSOpXHPHgYk3SWLx2rLuQ84ZvPBEs?=
 =?us-ascii?Q?0HGMd8s8bHI4Chxqokg0IlQWVV8P/X6cLHwv2huPkEwJxjXXAgvjrWTOI5pB?=
 =?us-ascii?Q?KS7ZITfSqfbwOKU+J7Sp2VSVOTpcOY+/O6QmNiQub55d80oGbrSh/pCKh9wB?=
 =?us-ascii?Q?IdwCeYmXPHKD0gW+i+zJVlrYetvlhRnkkREAJygEC5ue0Hi88uZVG7Ls6i/g?=
 =?us-ascii?Q?DAaGr5lTDzlXUIAz21O/5l84aUN+3Y/LiIsDzyUYemvrEQ3qG1BUqpr9K8rF?=
 =?us-ascii?Q?TCpvRPPen88LYJC1JDTvnBnHsXEhP03HVPHn1PAh3M9Zn8EP7byTOvUU8Mix?=
 =?us-ascii?Q?RJGX6MgSXoXnWGg7dov39k7/yDIQN0NJBl0F0RlBnf5Bhzz/w2W6s5jwj9R8?=
 =?us-ascii?Q?iYyT6seawpbunwjMybaT9f7stix+58ax8qn4uVcXd0iM4tZ0rV0brL5+4hbZ?=
 =?us-ascii?Q?AK6ptAtzOVyEBghPucAimrTtIXJh27PUskvkSlMtUF/FEAerBzdEe+zLYdES?=
 =?us-ascii?Q?yE3EBFD9Grxzmqi8XczaQLHOOP5MWfqILt7ALYImXbgOw1ZqHmtFd05rP7LU?=
 =?us-ascii?Q?GIJmD4eEFyI7m/rXih6nkEkWzuR/YamhZ61QEn+1HWnO0NBim8nogg/iznIR?=
 =?us-ascii?Q?9vKvewmUpM2Y3/HdMb4fXQNuxeQYTc6GsOXLf8XYlVQqWYfMcMi6P8lYbXj3?=
 =?us-ascii?Q?twsq3osz/O2PpjMbrD8j78c68sv5nhUoUehIVW+s5z9JeKAH48gFZP3W6MsA?=
 =?us-ascii?Q?lL8MeLb+o8Pp8iU5aLw5nnh1w7W0HKTuLVPBKXcrD69FKVjVF3wZjhj9Hl5k?=
 =?us-ascii?Q?RydWQZg93X/k6YEoIHq9iEzgalZcwRAdAJwoC3BYifF5MDrCmTCA3uPhKEV2?=
 =?us-ascii?Q?Xfrg4hKz89jtmUNkLQayB/rY?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c8631b-0f8b-4d89-dbeb-08d9898f29b8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:02.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jo2ww4Jii8fnv9opaSckht2FYeApsTJYQK+fxyk21Ig8XABGgVZiLpEWWjwMmO6STcxyIoA3TUzuU/UbJW+trg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7777
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
S-mode but read-only for M-mode so we clear this bit only when using
SBI IPI operations.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
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

