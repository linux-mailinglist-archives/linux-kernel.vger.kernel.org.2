Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9C314853
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhBIFsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:48:02 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21196 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBIFrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612849675; x=1644385675;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=cX10WtJa6piCxgK7CP4WFTZHsJjMt0Sf06mq6p1lsoA=;
  b=eHVkAqNWpjrEOIQNeF59EmoxDvP8sbgR1r6Oi2X6jjjAW/grjaxp/GaM
   FohUxZH4Ha/b/wTI92Ajf+AYGWANrcF6wl0xMUwBEtZcD1fwfKVNUOsC1
   I7I4gUqkB68o8gMOrX+YLWrbLjTLVAYZKRw2+r1QZhrWpdQ/j5mVsm3Ud
   KSjFYAwqGob5ovx3EJL7JdvLPfCOYcpFzNQEeW6ZMrABocXWlfzSWk3Ss
   +h7jxnqINSrIU+WYi04XdMp9dVZr/Vtk+51srAYhnqG19G2QdIny1On3U
   enZewQHCCWPB/zpP5r5nhRMLQhop7PCgzylfLMhNrJcDHu1xXpkfv1gAy
   Q==;
IronPort-SDR: YmuaVPudeFi1zwWE3ZA4S7D94IoeqoAG6FQEiFnrftf6PqqKXpXWUFxWeioXYudKytFr4AhA8y
 djjDBlom+HkD2hmnvyVUkhWKRMjXUWFb4RegtcPBe8drEDSm91npKon8nWdVeP0d04IJZutcJV
 At+bDvQEKyRGIur7gFDlSXQfnWKl8chrR/hW19O7nOVLEYh2vJ8kS8xlfX8u3gfhes3oomCcAb
 zobcbhoasGP34CFwY85ROdsLGp8OhO0+bgOKacM/8BXsBemF07M2vwJ0BY2tj6+L/6RBvrHkBw
 6Hw=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; 
   d="scan'208";a="160678946"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 13:46:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j22byITPKyx8Jrky3olgYJg/VICgxuNSkbF5lb5/iZi+WI1vJifOHIy0v6odjFmPy77/ANPgxQVh9x8elJa+H9Wi/sKTE2UKxV4moYDvujpNMTiItCMa9NGtflY3k6xWA+CCKx3ckBY6LxLOQnQNF7bZW0uZGEKD4QtYzHj3bVfrJYkGTyaf0pcvnjx3wjgY61DKjrk7+L17F5qyRa13M4c9EkkfxqNz6e4VJuJFZ4Cwd6HUkdtY2HjYYaSK6t7I8+vXBKcOqVdg4CBLlWs7UTfJsMrdXc92noZ5BJ8veznq2E400HUuRWZR96CTdfDi9liY6eZvjInZzJohpa/Apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN6q6Csllznuav4xyjhXecTt36b89ae6myWFKVh0yKY=;
 b=fTY/Dnokj6WVwqQFfnsdY6xHMCdBP1E06miDbJl+xqGYtwrWPADwNSBDFPsvvPBkggLURh8O8cJcZOHS18nM5tw75SrJQT4bdPJjfjFwImi6XXuMsMfsu+E8su8yYQXD7MGra2XdLmwKAXCJS92KA7mQOIKxY2Vc5RQPaZ50sDva4RXQEtvcV2ilHn1CwOaOqgAhOlACD73dL92bh2Ok+q+dtIi8XGWos0o40bM67Bo4D7wMUkJKENv1qmWA+Ovf0Fd44Fxs/JULG+tQ6k0Ykd3Tl5EdTMZdXyzHVfq+Cda3vwsy1N5hv9OqbUNVM3n/5FRks7ke+WnmHy2wUOA6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN6q6Csllznuav4xyjhXecTt36b89ae6myWFKVh0yKY=;
 b=iz03jf/PaJSvWHnQV1jAYjUlnHltDyVhbCUTKVeB2ZZFrxFjPPbAPFAb3ThUkXCWZ5fTcqmoGovxw/VrvyxAPpG8u89N5Ykl29jnHY7vGxy3IU57nNs+9iowjcK3tILA/Ajendak/4UBARbsXW4NcCPbRfVVPWTpkaX/zWfvrBo=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6331.namprd04.prod.outlook.com (2603:10b6:5:1e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 05:46:46 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::2513:b200:bdc8:b97]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::2513:b200:bdc8:b97%5]) with mapi id 15.20.3805.038; Tue, 9 Feb 2021
 05:46:46 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH] RISC-V: Enable CPU Hotplug in defconfigs
Date:   Tue,  9 Feb 2021 11:16:20 +0530
Message-Id: <20210209054620.25005-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.190.34]
X-ClientProxiedBy: MA1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::21) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.190.34) by MA1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Tue, 9 Feb 2021 05:46:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9dc5ca7e-0a6e-4283-684c-08d8ccbe1627
X-MS-TrafficTypeDiagnostic: DM6PR04MB6331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB63316D488BD7F19424812F2F8D8E9@DM6PR04MB6331.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbhrbyOaHv9ZQunoehmexVNmt9bV1h8zp8vM46OErNoJMEITX6dZyKFtGl1VqTq07h2SoQgDdG7KirGbaS6KYmIFLSyQ5DZWqnNwASKgE+VZRgaXhoEGJSpV3Rh2oSBb2PQ2EoPxuk3gs3ee9Nux2s5dAoWm7KmyUvv+Cxoua51ZH/9+VrvNTzwPrLCLru4Lbs8qnrL4RR+MxvIN8i1qetQdKcfb6nQWDfnZX58rlOYeqU6Gk2jPDJ8USeazbMCTeVeoI4wbmUiJFGwsz9Ck6mHJrBDi6b9TP1LEX8LhIFJLE0NTHOt8ci3kfnBY38EJv6J9DKUcWqY3igf434WA8PPU9C9K96iUj3IktPkUS8pj735Yk7G/ajSYw68/GKYVNi1mdOga0/OLJH4+mpHNtHoAaRMn9Ax56EVlS6xU87/RyehdCQohPv8sygW5JoYbbLltU0Ae6Vkm8OjdNKAyDdZsOF1L++oFchIiBqf/SeCErVeom0thEvOtZqwnUlQyd1wx86GPtwNEq8XhPdDXug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(478600001)(186003)(55016002)(2616005)(4326008)(956004)(26005)(66556008)(2906002)(44832011)(6666004)(66476007)(86362001)(8676002)(52116002)(110136005)(54906003)(36756003)(8886007)(1076003)(8936002)(5660300002)(316002)(16526019)(66946007)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ndv3cDHoMzrz9dBFueEtgCwD/ZNIoGU4wAzEE0exnUphmrWraYney7UADnz8?=
 =?us-ascii?Q?M7+YfIlP6UcqlvhprKoMpBZCe+Cz8Fxql1MJlBFM9MYthRGZR+nbBrPE4ZR5?=
 =?us-ascii?Q?Ek7ZK8JsGgP2RZTPdQ4lfkXj7b6GZbtmczhqIvPfhjGsHYkmOs/odiH5TfGT?=
 =?us-ascii?Q?lHcvX/uTqeWCkVbG+37l5cSfeQQxHBk3DZUfZrnfte2EhJyPHaY63D8SulAe?=
 =?us-ascii?Q?Ly+2wLt63obv83hfRM3PGAcEds/q4O7M08EVw8A/gS/dyTYMAhW+NESxSSSu?=
 =?us-ascii?Q?R1SftyBhE9tFN2ETcF0Iet1vPUlgI24yFXWvjiPHKev5F1/fBTBnRuNZKquM?=
 =?us-ascii?Q?FzKjJlX0KdZLud1RqB/+ICihx3g4PzWBpEqkU45GTIf28wGPAIdnUlIbObwI?=
 =?us-ascii?Q?FnFeuiIANijEmwVIqmZSzzSZWATJdutxO5mGfIDGQnR2G/B5e517LpCYIeWL?=
 =?us-ascii?Q?MXamvF6XbWe+CMQMsw+n5/w15CH181CY+YkvURkTrRF8vGMC5cVfSJrvXFiL?=
 =?us-ascii?Q?PzC0dofoaepDST0T7Skr0vrIMOa/SN7Fcybl0TRpIYVfGLIdsFSXaHRkll4K?=
 =?us-ascii?Q?w5/l+Uk8XpdLIin+xvDTtuROcOgt/AxNMvjlOHD56JAD2iLb6/NfbQvpgza1?=
 =?us-ascii?Q?oo/Q5aYKYqhlUmOIpCs1/UYGnpcxKEAHYq0zNgmuDvwdSCfa5ealukiq9eso?=
 =?us-ascii?Q?cD81uKsFcS8YqccAur8lGOfh5h3+Bn1YRXhUolSLM2zQTVW4orMZyk8e2/PG?=
 =?us-ascii?Q?nIOVwwhAFz6IjIQB+rJl1yeJdb9XRIZPzHDY+qeNPichfNfYb5PCRN63LUDV?=
 =?us-ascii?Q?tu6iT2QM4JkLxW9HukvX+FZYTuE1+4kLy753KRn8JbpJBH+xfVtq6Hf0qnm+?=
 =?us-ascii?Q?jzp8n67nCLEVsT/rABGgq+Oh/3TVJMnNMWFq//JA9DGKyXzTfv1LkYwynVMb?=
 =?us-ascii?Q?mQQOsGAF5JPGOw/3oAGdq87HvuE3RisJc/Hl4x4tmBF8InZX8Mpi7drUZXdu?=
 =?us-ascii?Q?1+J1ARNJ7SIwdet8EenqV+j6cYx7ww4y/SX/aYZFvV4s3AMZUWvP4NWDK/9+?=
 =?us-ascii?Q?DHsuUeP4gMUOySPAOAvxpRVEZVmHlvfEomsMP8uQ/NZETZpq8wQ7eSBfbH1e?=
 =?us-ascii?Q?ejHf0KycF4shXauJ9jIUwA6LXLIFR0H7Eq4AHImvNJlLa7wNXvO7VhoB4f7P?=
 =?us-ascii?Q?/iOr8lVqkWWIBjug6uvywgLoTvu7NxKLtyFwYAtgv8oHMXgoY8gYvfj4f0H7?=
 =?us-ascii?Q?bwzWNXOWfC332MvwV6gEKwqOpjaJEvKpWiOlaeKhNGiaPsm8/8FU4QwXKjdq?=
 =?us-ascii?Q?DL5/tgrX0jAHKWn0DN3szgf9?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc5ca7e-0a6e-4283-684c-08d8ccbe1627
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 05:46:46.6585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ChVAQSA5//2Zw3ukvYMXcjerFMFT2WWH/UAXI47R8xjDq0RVOPwLKfp7wKCt6bshm8odPLLzZ89BMKvHgRAvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU hotplug support has been tested on QEMU, Spike, and SiFive
Unleashed so let's enable it by default in RV32 and RV64 defconfigs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 8c3d1e451703..6c0625aa96c7 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -17,6 +17,7 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
+CONFIG_HOTPLUG_CPU=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 2c2cda6cc1c5..8dd02b842fef 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -18,6 +18,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
+CONFIG_HOTPLUG_CPU=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.25.1

