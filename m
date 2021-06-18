Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F37E3ACB23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhFRMlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:41:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62799 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbhFRMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624019967; x=1655555967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kRFIsrXRxjx8BbYZWZU/yYhgpwiiKVcT4u/SpXRbxcE=;
  b=KqvmWp0hYmGi/U7Pg1KqsXCYcswasfaUYeg5I6BIITFVL6W4hKnTRDwN
   +7M4HnnXmGxB/11qmVPI3SikQSSPbbSTzl5q2DuiqGnI4Zxc7KwekQUci
   1Yo4tOlnXZyFSUgKl9dAqrKrvbdvuzFFpRY2wiV5DD32uZs5n56nxs2hk
   DcR4E+uak7PJ5ad8Q4A91N4uRTL3bbs/9lyF5jDzM/t1mtbl5Lmcn6XkT
   i4/wKQFzNw0Z6jUi9ik2P39GhWvrArOzePkPCMDpZUib5eER0275xuxEv
   frK4Oumi4PXniHhbi7HOE2ec+/bjdf4apXAuGwSzvsEp750swO/9NViMv
   A==;
IronPort-SDR: fKfIWruDNXnbvpF+VD77kYeEF0sOs5obVoHVwfnVp+RoMI9f7enZ1B3N6rNC4VjFIcEjYO9ric
 QnEgLVdwG2i48qL953ACXJ+6qWM+qPkNYGzM3syj3brnpJuY7TUfv9chUH0X30y5j4q5gkQBaI
 qgt0IaUx/BkSn5ZGzQB75VdblDBr8qD+XIte+AXzQUdrXZbNAxl8s06JpWdypneT5g4EfFd2fA
 ECrMarcwOcTgLFIeMSJLjzDReFRs7HrNzAEbKheBso2SwkLsx+al5xZT2Dd7otfV6zrJ9+B5S1
 5tQ=
X-IronPort-AV: E=Sophos;i="5.83,283,1616428800"; 
   d="scan'208";a="283779297"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 20:39:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpTd5ML2e8DmlIKQEYg34+QJj3kom3yBX3WHsVGj2kc4RpQh7cacV8ZrH7KGgmOHpSH4VMeUkp8RstrZOHceDTHy/JdPPk77mqE86FYxAUKPuCdSx8qS81wZ20lpL7ZFwdC58wdB/1TIw/pvsVrcvz9X4Sosc9vuXg1x/aZYpk6rgIozBqlKpG0Pxy7nLhH06PinQefInBg1OFi6DWljnhagYBn4Xj5icOtSoXfywU3bFnZBXenz62SMVw2EpytNVhJkDvrbl8LpBGvAKuZdEnOpoxvIKDIHXEDawtVbdrUci1Htt/DfEiGE91ME7qIlw94X7jfdpueIFUxUFbBqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOyALsSZyM5c63OvTUlUo42PR2FT1T9JpuApyyCliEY=;
 b=n69QpXxbqjDwHD+cxDwOuw+K6hsbekt0YjEGGlabzdcVqJqhPRcdLZDx1blkXM3ILkhVtsBUzaCrVTRuGx9JYm0W0NmiWVl6kYuWw80OmFzVZx0EQ6RnsvPafnnWG9L7sMK/aFvxv3PlA2g/SF6DnicqMxEWyBnpy9VA3i+DrTwVe6cAmss4+EPoEO98Vz/tNohA9fwpNQ6bj7USdLPQM62N3GRwsmp2xnOREK4fkE20kj5iUMkGcElNSDS3syZGFwPv+TletC6lgHKBNhIw+QYqvIGOIHceKOvGF2VUQVeSgBZTJwECy3+7wlFZKJ8ruvLovlGIdqoxndRegdob2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOyALsSZyM5c63OvTUlUo42PR2FT1T9JpuApyyCliEY=;
 b=z33MMpf2Wo8OyIxVATUeoigxyDSfJ7gR9dTPbK1YxhH5vn04iSlF/T4CiaHzi2w+ZKp5ex6ZMlJ//8DfVjCzT83axey1CZ3jmCj7ONXSkvBblCYfJfhkBubN/z4bp8dgh3qYKOoIwuGNDjd4eCh9ptHepgtuGijQB7JfICyYJ1w=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7857.namprd04.prod.outlook.com (2603:10b6:5:35f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 12:39:23 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:39:23 +0000
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
Subject: [RFC PATCH v2 01/11] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Fri, 18 Jun 2021 18:08:41 +0530
Message-Id: <20210618123851.1344518-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618123851.1344518-1-anup.patel@wdc.com>
References: <20210618123851.1344518-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.164.186]
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.164.186) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 12:39:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bf2af6f-5f30-42c0-2cb8-08d9325619cc
X-MS-TrafficTypeDiagnostic: CO6PR04MB7857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78572B5DC657C016295415A88D0D9@CO6PR04MB7857.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6FHTi06xrmLKF2ut0QiESx6E08DwiFEVnZbWoIeG0kXpKWXVX1r9T4CYBO3bXQHH68xnAzPur1HIWGlxujNHNa5S+GMVHGWnsZ8ESpAwnrkxbrTYdnLwluT+5s07xR6pQYwsHTER4j1zQnAQg7eGhc97vJoTx2jwD9r0Hecy5jZtMWbDUAFjgA5B4vx16W9d6dqOIkPfSTzOy/GO4PgLby1hB5Imimf5nQOUq15zD9Tto0TAt/n7NDde/bx2WAOKnS8aZxajlYbc3glwdBnGb79r7X1tkum53OmlguxEXipMauwtiuXmDVpGFx9k+WI8f1B7aM7d0dH2t7OsUXRkdJz1Qn5lQHvZPu6JMgGeirzguBcqMDAqxKsb4oP+hKzsIh26cGkuhjZbMTZHshrM+4DgBWNLAlFV9JS+TWxp3pUhuPQ7AaNh0rzus7w8DcCSadw1JxNVN5AWXgdhwAGk24xUBHvRxnUBfDlfeVvE8AII7RIW/gIcY0vlhhEC1fdk0q4advDb35zS3871upy7u1qKEgRTEQu+9wfZX3rFGonDbhOeqalZWs1RJDM7mPSkQBYCugXhimakNwlV6r7E4EJAiKL4xpzEXul5A0lc3SaFaK2FkKKxXYai3dsXy3D63w4RoJpMrNMic7Su5G0NYoxzDEqifPA744fYb+NzqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39850400004)(376002)(136003)(956004)(2906002)(478600001)(316002)(86362001)(52116002)(8936002)(44832011)(2616005)(8676002)(4326008)(186003)(36756003)(5660300002)(55016002)(83380400001)(6666004)(7416002)(7696005)(110136005)(66556008)(54906003)(66476007)(66946007)(8886007)(38100700002)(1076003)(38350700002)(26005)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nDAeVYzllXE5y7U9UwyTi61T8axKcYg4aS/w7PVhKfuq+fIBcuVy/y2ZncV6?=
 =?us-ascii?Q?V/sYtbXsxoaN3ArM4vPtF3WsGqXVjv+HluknFRfuH20S+U1yRPw/MV4mSgw4?=
 =?us-ascii?Q?YkbFTi7E+k8ixVBVBx9E3/YFvwpIIIYffalpvpwFmL0Reij5wjzj5J2pF9RL?=
 =?us-ascii?Q?wA+cMzu5Dn/aADauojtAMOPeVBnCw0jfpmSLF2kaDUR8GeNXekWDP4/q+ZBe?=
 =?us-ascii?Q?XftRrsYm7V6fq/+J+42qQx85rYNTI3iSDUVjUp+7xJSXE5nkwGZhfrGi/Ucr?=
 =?us-ascii?Q?2AgV0v6WDiDlbZrhuvVRJ/fHlkDI9ItkOrPCkBNYoK/yMGgbmRiYZiBW/DkZ?=
 =?us-ascii?Q?YOe5n4CVwIefT9W2iTgUEDXu3INrNKRq+h6ifqE7Jk66rgIZp8Ia1k25YY+7?=
 =?us-ascii?Q?I2WNtNYfdHPNiKmwlJI/BR8uvOBcR2sNZ/lMXmWoNTX5oAXMuDWhpjrrjJ8x?=
 =?us-ascii?Q?n84d0p2D1oLEtzy75/W66XeMt9GXDZ35kpAx2tHxyG+0I3YqneLW2RNJeYcE?=
 =?us-ascii?Q?9UakA8ybT1cWaa74ylOZjg0520RS2MU3bb81nWhWMNLPlQSC0AxsTDiD/yVO?=
 =?us-ascii?Q?ES9DZPJelTTrbjMgDrr4Jg6iFVim6N48I+aTR4aB12zTHibBURRyes6ckY8G?=
 =?us-ascii?Q?q5OvTtp0aPNyl8rIdrKqaLX/XwF1WslhuQlmaPdVPE2ZFeYbYhiqk4oZRehD?=
 =?us-ascii?Q?Y6idp2DNzRyZJduQnEi64r3KzZM8zW7I4g0QOjl88o2tSApJqkcZcD30QpTA?=
 =?us-ascii?Q?BzyUaY39kSetVFa+V8l9cNsqZFiXzst4owgkfuCNhCtnKh1ec0jtdWhKNC3L?=
 =?us-ascii?Q?B4eG7NaedxeHKA+iXjmeZ3qZR7B+LrzkcJnz8PUkctOh0EQlW2RIDkGw7/m3?=
 =?us-ascii?Q?riuBSV5NopB/HiWKi8W/bsDkDTfILk3YzYhU+7bDNBkeU9wDZcwc4OLRVZJT?=
 =?us-ascii?Q?ShFrvOe9iVaNeE/PU08ghn96Hy/6Og8XxKPVcfoFVBu0wpNw4RuRsZ3uOnEv?=
 =?us-ascii?Q?W0MlGnTofAAsgOJhEStJyPzLJn3m3YdY8Zlyf0TT/1anZJNEXuBnjLIzizhH?=
 =?us-ascii?Q?ZPMIE08t7ian5cf/jX9L4AXVOz8GXtBMwei7/Q4UxI2iwqevA5UOXMCmZpZD?=
 =?us-ascii?Q?nMdvz79vX9xHhBGps06rMmoksW3Nl87FFuyT3Cgm9n/xxawrnpkxD2zZNQjk?=
 =?us-ascii?Q?uRzIVsaint0Q8Ye9xHbsr7OStyV7VhDYLgkvTMFl7Fj1DtR1Fa1HenZl9Rdg?=
 =?us-ascii?Q?wSNtE/jRhCQ0MgEDyQjT8JZAzaWskGTeu5PyZbT/Q2fQUim36cFGpGlswU/r?=
 =?us-ascii?Q?WzR4iQqZRn8GXM2m33wcCh5Z?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf2af6f-5f30-42c0-2cb8-08d9325619cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 12:39:23.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5Hts8rocOxKRCwLtFVVMNGUiMTXpQS/a3Gg2K0m6EMhTJUdLCJ8PjqWo36xHeVvMLYIHyeZ+Ps58AGiunZ5eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7857
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

