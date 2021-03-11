Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D553379E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCKQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:47:48 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45683 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615481263; x=1647017263;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ymP1wLc3wZURaXexSu6dnKBYie5rW0jtsczLtdtpVNY=;
  b=MlUd56vIooUP2dsPmvNVJzX3uexe6trhodxOtbnjIGYWc5zjodmopMVU
   iJoQVfOI805FxsqdQgmMbCTMGKsnXiACy+YvnsRZxniviDttXAYcT/xI/
   zQ8q9GklNd9/X6f9Kt6VF8X78CzcfAYcX1ReaHb6oqU3+H7zl358A6zAf
   +7Wkp825IWNsGdOFaq9FaU+YKgHGH1mQGxEaqH0dY12unpuokck72kF3p
   mhuf16vReozhgnXrw3oeC0zDJBJIeT3nFrH1Z0fA9SSzPnKmwSn2IEf/z
   zDla67za1dTUAu3TZGRoxle5ijyzqFYVS1oTE8Ch0iIJP9Y9izEwRcy2b
   A==;
IronPort-SDR: dmZku/laQ11kXEdnm92dNiXUnY/cun7mdAbLLujJf9CbjMXu0HXrnws3HU0MxBvgND8+7qJlTm
 lFyx+LOHsmbdTZLBNjH+1nmvEqVG8OiVqYu6lIJr4tsHKX1xGYxKAlTJjDmO/QGs9xZcWPI+Gp
 rch+p9756Oxt0FZW+guFTPgP26yYxylL8St4R5tD338XUB4JVoUg4R45I4+136LD8SZVfP3tRQ
 Fu764J+xruf4snaQ6eXUalFverBWBBBT/kToLnrqIhy0XF3ahvIT8pvpKrEnQ77bn5FMJtkI/Q
 tE0=
X-IronPort-AV: E=Sophos;i="5.81,241,1610380800"; 
   d="scan'208";a="163089365"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2021 00:47:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwk36WQOfn+FYZGggzshwyQ2WK2ds3DkeUGfJXvjuyTgYIjek6WqD5PJHW9ra2ZUBDr7P7P21E7oc+TyzM3H0ljY+KQK8RPPKfh4HZmVNG2aqs7ce2uHrAK0zc1vkKMSa5x/k2RFzpYV42cLttuDb0wsWIv8Odwn0r90SGzbrpkJV6aMhSq439afcrwzXlqLMyk+Tjf0j0MCJzWYNzUoM1EJzlhn0dyuaZ3S87Aq9zCv++8PtXeUvJGZDNyUNbAy6T+oeB8jFFTBEWdPUCdV1twe7B+B3TawmQgpiw8Crx2N/MRgpX1OP9oUSEe/T4rBLJilAEIDcPJTrynmEwqADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3YS5gCIzDpzK2n2uQ/mKb9rmg/Z6RGFT0RaGUQL8v0=;
 b=J7+9xv6BfU8oBQhlgmV009Zvdb7zwn8uMiCfU8yqryNRyIgqW+M6rguJvJq7gdTVu5L3QeMREkyKLhjr8awdcTgWcsa3q5KW8itP/1V4LRKrIbrFMO3KVWy/ang0K1a+or0rKOsZRKaPldUWQJlZpYS37T4dPwNKwZ3TNtacWYwgZi6RyyyGalNKh2hEB1mnHc5IvQtkNaByr/t2xxDxvgnQSOqe9xiTai3TDtn3alYSX00LHMnkv0YCIJxa33mTKEvZUY6rDRRDwtAYSzVnRO+2z2m93v95p0NPcjc+i2XsuGdutisvmN2e96Cx42i4RnCnnCA0XUpierFdUsfxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3YS5gCIzDpzK2n2uQ/mKb9rmg/Z6RGFT0RaGUQL8v0=;
 b=h7FIEoLmazn6BzRllGrscUDDQLjFyBjq9Y9JWiO8cNOiG72BZvnctX5rn3sqlY5BG3a31ZQYfko49Lvr4Uaz+nifx5ZI6KuDtSNaLy5xnAyv9OzMQa9tABxOZWuJk8z0TD5NGsKeXaGZGhBSgcKOgh0Rr9Y0rI11eswxFtoOoMs=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0218.namprd04.prod.outlook.com (2603:10b6:3:77::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.29; Thu, 11 Mar 2021 16:47:39 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 16:47:39 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH v1 0/3] IPI and remote TBL flush improvement
Date:   Thu, 11 Mar 2021 22:17:09 +0530
Message-Id: <20210311164712.652608-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [171.61.72.64]
X-ClientProxiedBy: MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::31) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (171.61.72.64) by MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 16:47:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fa2a0a5-8a5e-44ba-7bb2-08d8e4ad61b2
X-MS-TrafficTypeDiagnostic: DM5PR04MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0218BD524158E8288AC5EFE18D909@DM5PR04MB0218.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nce0fGE9X5Y0fnh4X7FYFkqV4iA0xkHPgt9SL+fwLAVV5vn2wVCe7D+qupihwvzVywVCImB0B13YwFqfnGkWgJzrUhdqbcCNtdbz5hwzNpqemHmHOZ2P78sJSIXSAHy74EyWb3OBWz+8W4fFPp+3GmT/3BiQJNNjuA8v4E1PgZQS03Yk0jq9zT8oFr4t8pOmwSir1UPh8pDfvynrVK65bWXhDlkH5wJNUVchutB/Q682m4CswvjyepmJ1idL12Q6Hg8c0SUbbLxVJTaK/Il+8B84b+lgYhQPg0uZWcJ/Ml6q2+Q4twb4S4HXWJVD0i9uds5NqTt6On9sMyH5qX8D7bO2bJweHO9d6W32U/NduPD5+FOcO8HOnYDy/vQTdcr3JCGVDSToJ7impw8UUx4K4YXrvLh4f29rU/9tvAQ7Tc1m16A6uw9pj7B/HwXxzDZQGjmzI7LiI81AQraaRNR7m5TQTxpDwdVtbTndFe0mnxhjBMs64tJ1No/hEN44tN0BMj64Tmu4oyM81UvrSzIsY3pq2XspSh0/ScDDm1Vwmtk21+DkzFe5VOBNDJnC//4XETxFcMjPR846hj6xiQ94pyWLtkj3CgE2uh6bw6EdJYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(316002)(66476007)(66946007)(44832011)(36756003)(55016002)(8936002)(6666004)(110136005)(966005)(66556008)(16526019)(8886007)(2906002)(54906003)(478600001)(4744005)(5660300002)(86362001)(26005)(1076003)(52116002)(7696005)(8676002)(956004)(2616005)(83380400001)(4326008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P98qPuRxotjQIG/aNQ+rexome3AYAULmOmsyiMsOo59XgNFAxLYKnxQKRVTG?=
 =?us-ascii?Q?ZGEs92or+5tuM4Koj9QjhqgyIqMC8kvOe/NT7GyRnAauLaHnwQJKKoCwHRr8?=
 =?us-ascii?Q?m6nX9PxP0Pt08h32gWCGXvOdtCfcMma9LSl/LpYk+CyPizYOecj0wQHIBgWe?=
 =?us-ascii?Q?J5Y2C/WF8kDuEq4N/yAHHgmXPq4MSHO4tvT9YD1wDsOe+TuNCc/qKnedOUlg?=
 =?us-ascii?Q?VOMXuanm5TEcUIg/7/vlWyS+fb47XF4pIdPyOg48bvJIby0XGd7OEN/qp86O?=
 =?us-ascii?Q?dNCziF0ucZeDJ0OBRPt2f9qvkM9Ji8CDRhtg0Jr+E6vVuVBk5xWnbOWGd11U?=
 =?us-ascii?Q?5uCPQDHh6M4ZfVFOVNS/frP43ypEo+6myDEAH7c0aWLB3WZCeV70wtbwHcxk?=
 =?us-ascii?Q?SyLvFGUFx2Jz5nKFv+X2u5/j426vgRoHdszLqt2CoEDcgO0JDF60rACgPmrN?=
 =?us-ascii?Q?6s93LseWDZe+CDMG577isL/NAvXXBP1U4thzgDsbfzuqkhS9y06u1FmARxPv?=
 =?us-ascii?Q?4qp7WJT71guCX0Eo+jLYjfoLP/ep67XbIsI2mAeIVy5Q/5lN7SA484ad78uZ?=
 =?us-ascii?Q?i2CmC6IGCn6TS/qbzWBY4ZRdRo9uXi7KHLI2Q4fG0smCNSl85EFGKippRQ3n?=
 =?us-ascii?Q?GwtLZt7am5TJDjjf6xvhhEqF9lhUnhy244f+kkja+fhil1OFrW4PUYZAQkI9?=
 =?us-ascii?Q?SvqjVns9es/zZakxaZLdYjak2fgYMXTPShpN0o+XqAW6KJnA7XqtP+Xr/zS6?=
 =?us-ascii?Q?L669oLlFYyHRhPly1q/SyrCDMxPkHtIOtInGR0ZnDUtZTDgG0V7azVLGeTyl?=
 =?us-ascii?Q?3Q6l+RP9kedw7iVsUXh+Ue+1Nc6akeACyCJ2UoZhDIrktMsosE/u+8qwQdW4?=
 =?us-ascii?Q?84WA3JRulWrgafBlWWSQZr0TTVnqeAtdSF8meSwP0p4NWEEaGSS/55o55Hhv?=
 =?us-ascii?Q?6E7vhMS60GC73P2dZFJ8GcwP8Mft0dXbEBhJ4oxb93Gvz+9tqrOvmnviN36h?=
 =?us-ascii?Q?4oxlIrqLURv9LhJ0QLCtBcrJrDjYqDX6NJuuO422MMGSuVGPEnYnR3RlnGMp?=
 =?us-ascii?Q?8kM4QPc4Jjhni2FTSK/o0+z11KaCJ2NKBY8/Mjp2eOJu0hImHFo4DyJo6xEC?=
 =?us-ascii?Q?Vu8H+Xx7E20nqrJzoR7+nKv554jFYIbYebY4TXLKhduUT9sc064Yvb/LR6PW?=
 =?us-ascii?Q?JclhEKe0iTWTt3T1m2VRKxzaU2Ny0NGCNtCJERq8ja6lTdxxhRFnRQ8Z/3Kx?=
 =?us-ascii?Q?25uYi7U5rNEqTnElghaIc8W4LsC7dVWp4QMtyIqeOvPtBcLvH9IK0iSD0zEK?=
 =?us-ascii?Q?dOPE7/+fN2urQNNyb83TV6M/?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa2a0a5-8a5e-44ba-7bb2-08d8e4ad61b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 16:47:39.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6d5pnC/pU7ciRbkyrt5XpM0kXwl6ZUpyzAyK7fWu1cjWx8hcDq9K25ytLGjiLfQwQ1UVHjXFUhDa4CxVVE+aGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0218
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series primarily does two things:
1. Allows RISC-V IPI provider to specificy whether IPI operations are
   suitable for remote TLB flush (PATCH1)
2. Improve remote TLB flush to use IPIs whenever possible (PATCH2)
3. Allow irqchip drivers to handle IPIs from chained IRQ handlers (PATCH3)

This series also a preparatory series for upcoming RISC-V advanced
interrupt architecture (AIA) support.

These patches can be found in riscv_ipi_imp_v1 branch at
https://github.com/avpatel/linux

Anup Patel (3):
  RISC-V: IPI provider should specify if we can use IPI for remote FENCE
  RISC-V: Use IPIs for remote TLB flush when possible
  RISC-V: Add handle_IPI_noregs() for irqchip drivers

 arch/riscv/include/asm/smp.h      | 19 +++++++++-
 arch/riscv/kernel/sbi.c           |  2 +-
 arch/riscv/kernel/smp.c           | 30 +++++++++++----
 arch/riscv/mm/cacheflush.c        |  2 +-
 arch/riscv/mm/tlbflush.c          | 62 ++++++++++++++++++++++++-------
 drivers/clocksource/timer-clint.c |  2 +-
 6 files changed, 91 insertions(+), 26 deletions(-)

-- 
2.25.1

