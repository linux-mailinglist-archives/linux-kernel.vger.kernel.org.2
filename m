Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807E03FB057
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhH3ESz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:18:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56351 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhH3ESw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297079; x=1661833079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kRFIsrXRxjx8BbYZWZU/yYhgpwiiKVcT4u/SpXRbxcE=;
  b=pn2B7m+ID0E9oiG0BDWcZpvD/h2K36BncBlCVVo0TeV7NrCLbl/DvnYZ
   b42raodDALLeKTBeJC4S4HbEKAMGt/l9ZfDfUMJL8+GiAcyn0GYVycAsl
   VNUvhLeiwi4ZIwCt0T00Vr7vJuvaom7jVK6ZYusNq/T5LdXoFSPjBqUW1
   wiq5cpSTbzzJd8EQI/HLnTHY+D03/ZMgbgk6dFZWOQ3qFt6qgTMMGGqsL
   HsSfMSOeXA+YkeyXEvtObTc0YYPcogUZUFDz8vnlPa0hNnPQVHypcIaSv
   ypQaStrfwiWDwk6KDbOyk3YFP77dSuZVnjKCnDksrG4nkCx0o6JH6hZXY
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="290332138"
Received: from mail-mw2nam08lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:17:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfQngrDvBi5ZQGYkERaBuLCxiOEdKtiLvE7gbifb7zkFRw6ZlmKkVuYX4o8fTZm8C4DKJHt1eO8ZEueNuu33M6G/LVqr/GoqsblItmkKzkDapCVz/rRpOmUIyEdeFq7uppi0JAkKYhxZebV4iwh54S1FaNaCnIOXst1J08xN7oWwPEB6yLtpzqAYKJPrbJzZnWRgujh3mSsd7vvIy8PVC0Id0GhRvRRuB8qvrRVlJIe86glVsa0scvhoNxkYZ0DrnBnSHbvzah1lc6oZABzp98mLD0XnayZgsLhJ+6EMtFUNxtG7ia4rKGovdqaF2Ai0UNhOiuefuI9oynD2y8QP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOyALsSZyM5c63OvTUlUo42PR2FT1T9JpuApyyCliEY=;
 b=Ax4bUn5DvsycuDOiROqTglEcm6ShYZXA/tItOccDoUbv90SmZ9VgeLMo7d9cvwwpUn+38f7xU60f2vgBfxIhrynXNUBRHoOTlywKUTDp8czoYbdaovNQHkQ3ExY6a7qMVXBNctDbV5YJyoKy7V+Eim2QGtsGfvHNC62p7IPoNL3+HAxeCWIXupNXZB35C+fjHqvQRhML1+OYgmvCgvy2uIJWYfhzVekK7y/ZSrWnVJ3yJOVK+7ydJrt7J2QE5paalJtjCLAX33mapKXeV+u3Obzd/3FzLUhUjRK4s83Bt0eg0jjaoibp7L/QxMKLlW1Z4Yo+XY9Y/oRP5bkiBXiwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOyALsSZyM5c63OvTUlUo42PR2FT1T9JpuApyyCliEY=;
 b=FmnTkMcdwWpymqKtIAqVh+Nq24MKuFy1Yw6z6WRliL3pZQdD1CIgeSWDgh1vfchTG02xRi/qA7+k/pOh9rw7n4pMtgP0znrtdH747Ge7PTIzUEe8rH736PzqOV267FgajIFYNcXxpC/iFx2SCEkMd/ggo1XrbfiCu0svlmR99kU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB7838.namprd04.prod.outlook.com (2603:10b6:a03:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 04:17:58 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:17:58 +0000
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
Subject: [RFC PATCH v3 01/11] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Mon, 30 Aug 2021 09:47:19 +0530
Message-Id: <20210830041729.237252-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830041729.237252-1-anup.patel@wdc.com>
References: <20210830041729.237252-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::12) To SJ0PR04MB7821.namprd04.prod.outlook.com
 (2603:10b6:a03:3ac::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:17:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f9beab-9c82-445d-13df-08d96b6d25ba
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB7838C0F85AB72138C7D0A71C8DCB9@SJ0PR04MB7838.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fI+ifOaghA2vXGua1TBMHZfQELWxR3D3PnDv/A6Nm7PWm4RQjfiUeH69YQ3OrmTFCwGcpL1X80uM6ALio7jUeT+t0I9vZNKjdi/YsYT0nox7hiNyws+sLvacKMoyHNvVTKbjVl24SN8o5SH77J33impvRo9qOVtWa1jc046oK8c9VcpAtFUiMQjZqGsRo/884CzzwtdEaxwY69ojv8k/fjQamnAnW/yw63MThYue87qUX/7GqLPVYSUD4aUGmm/t1Ka6q8YxDgRzhV4oQ5HrI0bzMTEDYpiCbmRR/YAcxs+AW10cz5nbUwaYXEK1JPBzQMRQmH1oXN3aR/9V63mUm4ZLxinjjQXiaN/HYPbMrDJ23vGkNJXsgSz9fkdbk4vrSPIk6+4Iv2NqKOY273cLfnSwBYQgqvGD96J1IyMeztoErawKOeG/KXdjk1p9rNlZ7LEgimvaYmZuk/uhzQlrorRd+hC3MRwNyjG6CIen/gF14q0//HMB1fsSKM18eKJOr1PJC0Nx4YQ5G8pfYHAQoD683BEurnUl5g7ibHr0GvOAddj8MVQaQoW9+P2J9b1tMahg91dU3g0o51TG06xe5CfYSmknx4O3AgofOBwzXexWkXS/7F4rug8S4qNpRfV8twwNPD7D/kk+RegT6DiuU5mvofdy3SM43oXjwOyrc8eTZEnS+i0+iWfElFKG0fdUEs42hIc2cmW+iDW9eJfZIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(66946007)(8936002)(83380400001)(2906002)(86362001)(110136005)(4326008)(54906003)(186003)(36756003)(66476007)(8886007)(8676002)(7696005)(52116002)(66556008)(316002)(38350700002)(38100700002)(2616005)(55016002)(44832011)(956004)(1076003)(5660300002)(7416002)(478600001)(6666004)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1V36bfYsobGKMz87kw70NsUCPboWr+6ESWElaL2x+jsS9/e22q/KujZRVkzx?=
 =?us-ascii?Q?DM3Ivhw175xz9Hqx3WXiPF7N3cQs+I2KZK/JbgfVEVixOuvV6pbQLFIU7+NB?=
 =?us-ascii?Q?rYjhzJKVIjoChmP9NVl0QSXeFWb9TelGoODYHtS9Fgp8J++7FWFq6r9H0SX8?=
 =?us-ascii?Q?UsAYD6cSWfgRSOss6KewtOH3RwyjrqMvNjVRGvbOYobY1FjJs/CJhPbn/Loq?=
 =?us-ascii?Q?jkdq9TU4wp96rHMnuZdMLa5MWnPXMQj9F+KapMpoxv8uWkpxoeinbkJUtW8X?=
 =?us-ascii?Q?XT4AlLck6XXKassRu1A6K7ZXFGlERp6nuk/QyTDDOP5Ox9BBb83tTX49YKi8?=
 =?us-ascii?Q?E+LdLtIdVCfo5DrVqCKOZgkwZ3nbzrD1HRzx65x5G2bvNTVx/N0usRFc86LR?=
 =?us-ascii?Q?+yhZjndddVXLPOW/j83Fv0hEZpME+exqNa7r/rwWMtI1dlvDJDHzvOYZpZoS?=
 =?us-ascii?Q?1Xk6QEuRICFMz2bIyal1vWILR6lCsRnwkuJXl+tCPJtLMCZCzLPp1E/r7/1C?=
 =?us-ascii?Q?ITTkAEqaYYcw7ik6K5Z/czUN8A11jVGGO5SqSFlo4ARjGAAxgKZSEMRZI0TY?=
 =?us-ascii?Q?emp9wL4Awu5UyzDMpM1AfdD22jMuHdkwTMhSlPhR0RD7PrUlWEs5obBH+XSQ?=
 =?us-ascii?Q?wHEzjXGAHXx3z3EV6auqTTTuJ9z56e2ub+UbaLR0TcjrAUP9oQIX6yyJ15Z+?=
 =?us-ascii?Q?+0IXaGuYYpEydrriZiRCU7lfjQj4eq/FqGuocoh10gL+AcWKBnahrd7VY0pp?=
 =?us-ascii?Q?UI3Hv4iRxOcNHyno+f0axDhiSM6NYTurdkBtf13PsgkMK8mOM7AwQs5WoNC6?=
 =?us-ascii?Q?5M1+Zyb3fu5jd6n6ZSSUauAx6zZMAOYjRuv2aPobzi9L686L/yEwoV9CxEw0?=
 =?us-ascii?Q?U3Ohs7OwT56POaMEbKJW/Uy9G/za/SjL57Lxm7oQytNpmUHofTdfQhlWZgzB?=
 =?us-ascii?Q?hO8E9paNQbaXD1v/8m7uhzo8+Cjm2zBcG5bMMVR/dyo1C60DEuV/uxi/tvaa?=
 =?us-ascii?Q?kA+01mvjiJyDCPudtF0k5w3u0DG9eo9K/utTK3sNxWk05NapoU3c/N7EVEQ6?=
 =?us-ascii?Q?cwObsQuGteHwyGa5ctEFqkFEgyB4QbhQ8uURwBucK5ZWN19SwaBL1pTsKYAt?=
 =?us-ascii?Q?Rr6Snn+CXv+xKRihBr+Bp6RtFkQcTvW7u4HcXWKGwukZtkBRJ/JyEmw4+d2F?=
 =?us-ascii?Q?39YBL14FNZFU2sgT0bxeG8srK+YoipZqEDKPvi5HaPXFf6iwM59JxOLfcF1a?=
 =?us-ascii?Q?E8fb5UiuMkReaWxogBcsxu/oh4PCTQBc3vuiIuZW7asRIP7YwUQ0lRgp7pZH?=
 =?us-ascii?Q?EUbAk59JwB8IM70OOTAEONO+?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f9beab-9c82-445d-13df-08d96b6d25ba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:17:58.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/QQ3OTV3d8b9eoPUiYFBb2/LRt0wmct4odilOcv9K5/CVFtqkdzgpxjQcFyU3tcuLq39SDx2++DGYk8oYGf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7838
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

