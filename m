Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF36F42532E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbhJGMi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:38:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48998 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbhJGMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610219; x=1665146219;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=erONT+Oc4uzgv0p/S08EhAnhPQM/+KS6i4wX+lCOGFQ=;
  b=HI6+VX92YOZWE6JiDY8jUPTgFKl995IJhlgs7DCUky8E50q7AatTLpr1
   bfeds1Z4A8ZY63hMsA116xau1hCtR9eHZ/Qq+8MTNfFuTJmRk/tE9wGod
   N5xBEze0ujqqYDJHjjgK28jcG8hzPVc7/GIkRaf2hnvyEIRdONThOVyCj
   yHTPeVI4TdESNi1ZftGNO7gakUixZBt2si/EuFoRgctF6Z8fXL5Ry0eDG
   77wSr4LxNd/8fLbzStjf01ewTjGkNIqIpa0nccfMxJScVM9gUOESVhWdS
   ha8a/6CLs4EABIvRtvr+iOPNn+QlFknwBiAEnZ+hn4An0iJiOjY+fpqfx
   A==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="182150660"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:36:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbqZeW7Da1ardVHI8j1jKdbsFyFnhiUvKvgQgXoMM669b3SUFjkXwzKd3zhmNxiNh4NSojKV6e2RpBbmRqVrS3wpmTZbWmZv3bf1q73qFqQvXHdBgHlm5Sex5DwZ7ZxBuJ/r/5jnpWihhNSlJGWDAY3MHqqRxVsAtB6NsAe5PMS1vCXzr7zy5dMG2V72IBfDfmthxLAz+MZ14JqzCI6ZcBpqa7sfdYq55FI7jcE4KHHXCmMDtvAgG8x5YV/ovUzCT3UDhmXllVWv4DTkd/WnT7rncTcMAzEpYMAQ2Ab9kyIQvt4p48UX2WvuKQHvFojjYx5tT8QIASzj5nWYYawowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Tl+LhtC+iVb2GLoyel7Hjn4aWJBcnoilxH+zO2SzHw=;
 b=CbqixAeEubl5UhL7JmXvvkJeqdsf0v3aYDNpNM+iBm9VlmbsoI21kIDlADPnGVRlpBR7VneQvMQyl0Zm/dIbnl3R9qDtViqiB66OdEJbjl90ktKXNBk5yrGzwHxtQ7mDGxNO4YGGhl8CKi37sHAWuMG8l7KzuWssmqG240fpyzsfS0YjlHt54NRx2r4G8ZTPo3lq81oj+2o+16X0nwz8hJT56hovrvDJuiX5D2yVb/J01ajSu7uFr/+TsVp9dSuUeNSruF8Vf4NQcnYOUT9f0laC9BdfIUYZpQzyguzgGvxBI0bz0i6GlSKmCV9s/IwhJgQ3wJzcV0pF1y2pcix52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Tl+LhtC+iVb2GLoyel7Hjn4aWJBcnoilxH+zO2SzHw=;
 b=SyLUo5mDkqTEXiMM/rpkiszMDboaCCOqSPlq9/FlSAFemL9W+kHKELO37XF5UCdIRJ6Fw17031CtDFbdlwIHxuZgwKcz2v/CfP1b3vqyzumBslOFxFHF8qzz+hoCJeFJHRLZZm+2RvN0hqHkxin/Tz56d5TWeIzk3iGwQl445CI=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7777.namprd04.prod.outlook.com (2603:10b6:5:354::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:36:58 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:36:58 +0000
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
Subject: [RFC PATCH v4 00/10] Linux RISC-V ACLINT Support
Date:   Thu,  7 Oct 2021 18:06:22 +0530
Message-Id: <20211007123632.697666-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:36:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2057e8e7-08ab-418c-b37c-08d9898f2742
X-MS-TrafficTypeDiagnostic: CO6PR04MB7777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7777D9084B67739B70C920E68DB19@CO6PR04MB7777.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wNLQyKRMNtpMpeQe+wFwhWe/EZt/CoNXFKnYSy5n08Bf5K3jbi991sjwDPywIGcz+z4SjKTvQ55U3kIhQA3+KC0yk05P5P2X7HbNn6CfEUdsfwZdS+uy161h+gh5ZtOd6YOyOk8GEP5PkHojOw9/akXwezx+OxXO9rwEO39bDAo2k2cpUZ/Chl5Cc4P46uZFZ9EcmXbU0LHP0gTjcBwQ6ORpP4ZCcwbBj8mnp1zdnytTYuqH4I3Gil0PpyNs32bhsrVE9wT45QhzXvDtSSpVWEawjDXo0NkErd+2CiXXkAXbIlSXrzPpkC563w3QVc4InasFLG3dA/uC2NyVTFy8KTS9Bip1ZJ5s7HMGtRE+flEQFpwMJi5ffQuDX3oNetIjkpgO4HJA/gMEHngtq0lbnpqII0opX7uBmR1O+nlN5DEHROX+dWSf29oBFIQW3T+ppsQBGcGp2E+UwCkEeAuV2xT5tGAzI5kQMwcYJGb75U/zDXy12dcILZ0lEVc+TOkr66a2J3sFPiAxCc97Gf7ZY7LTp48QFFRzWkWbiVM1gWGo/f6TOgBLfCq4Z2ekbaSImhe/K7KZJmspzIj/Je63CSCRcovNZoC4ReveFiZ1tk7rjZqbHuJuPsd2PIqXfJBGq7PntjojQpbYZGo0c2khlJT9uNXwCTw80XAG/ClESLYFb9yoTr6HPgqXSB8IYUH3mhUAuiaMQinbGvuVV8D4Hk5VN8TS2oJhO05IyeoV9Pm8kkkyREnVUsrAtZFk7NNjb9JZQ+75Ctfo4WyC8MbgtGQ2QJW2eAo1Sql2MQ2HultT2HnOf8Yp1ykzwnBbY5adOLQfswPpf1aLuHvCxxvOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(52116002)(1076003)(316002)(110136005)(8936002)(7696005)(2906002)(38100700002)(38350700002)(55016002)(508600001)(7416002)(86362001)(966005)(66556008)(66476007)(36756003)(4326008)(66946007)(83380400001)(8676002)(26005)(6666004)(8886007)(186003)(2616005)(956004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rSt1noSYckIabdc/HeyPz+wMpqZt2y9lnskEeD9QyXoxH6oeUnPAVu2DJ14H?=
 =?us-ascii?Q?7gmrPzmkcfUJALfzgKnFzzt70PfQ83J1yCE2cRBOfdpG19H6r8ZDspClTgDG?=
 =?us-ascii?Q?CpBBVFbBt7hw8ls7KhpROTMHpkfhJm3N4erO7E7HBrBoFrn5Cahp9K/PA8ID?=
 =?us-ascii?Q?s97mC0tR4nyUyysKjiA5GwBA9NoIUc37ZS7flEBE+EtjHy7tf38/sJbU7u4p?=
 =?us-ascii?Q?StOSeZjAtsgW5QL7NkJ6t6xgzXWLvdoCBqZDw6D+NJKviJcD6Bqil5S2RMRL?=
 =?us-ascii?Q?wgs7L6ujKuqtF4ERRXA/jIRVIqvLn59B9SkRb9Q1FWrlkN3V5N8yTMhkZFNi?=
 =?us-ascii?Q?y2cdsNCKevq/zXjXrc1o2+BVIlr3uk8jOxwSW1iNWP0VvqEh4YX4ISG6ZRMY?=
 =?us-ascii?Q?Y5U0cuNT6j8v6jp7fmJ6AY/HKnsLU1exyr0polai+f9bkeY8O7Ab2EPHVA6H?=
 =?us-ascii?Q?Yg2dfHiEX+SMjtmfJ8vepr4PI4xdCaIfzu+9cscBkrRnojdY/P0KtKHLAJVU?=
 =?us-ascii?Q?j4FeNeFrHoZwC5USmcOG1c3LxeUPAU4HRh8FY/JHkRtBTmHU6M1AoOJ3mmyj?=
 =?us-ascii?Q?lFEYT9EIz/yseLvd8H3qKkpAZUBEDOHWre8H0vAiN5nkiDhiYXUyEcbyBkTz?=
 =?us-ascii?Q?9L9PpzX72pSVG3/ar6BsyYRJXxvPmHdz5Pfwy4QXBJlHHMXOsRbG7lv9f75a?=
 =?us-ascii?Q?W8Q0OawV5w23rKGXPi4zVsnb3WrgrAPFH5a2DrPkp8pI5TGxAhVoEV0GCfHU?=
 =?us-ascii?Q?jWQ0IuvOjhuSFHiq4MFa4vBHggl4qprf8LXtkdIJUeyIcnHEiuWFcoy4CiUM?=
 =?us-ascii?Q?K0g+ldjLEsh50ClHcuWyNh7jn7dZZGQ64+MRYym0H5DAlVGyA0n2wN2zlrIa?=
 =?us-ascii?Q?w7EO/cbLZJgPHtRlePMUeu/m6VKlqqU8/J1gDk92wDUAALehTaQR99IYxW0I?=
 =?us-ascii?Q?tqMB9HhE5sit0mEvJ898I+8S7CoeiPdjBUAV4d9c4qYeHcR1u4idjvcIlsOn?=
 =?us-ascii?Q?EuS3Jf87jhkqKbVclv1t+9VNuUdHttFeG0brD+7TI6oGcOVmC072P7/21edJ?=
 =?us-ascii?Q?JGYYGYk8hB9UZl3CI5PMlvceO83h//QruvYMQ5NSdQbbgFoAUpXpsllc2xzb?=
 =?us-ascii?Q?8Y876gUwOdis5zWrQeUHBSdAOtzROPj4RgnfZER1dtoD+YqS2MIthf3DhVQv?=
 =?us-ascii?Q?6olh2Pf537ki8ZiEMhBBuzJBhKYFPy/IrKPTSFxUHqTjFtN0gbCu434np/wf?=
 =?us-ascii?Q?6ZuoKOthOCRa4uVWFMIgL0ATZqvMK3ndE5rjE3azacq62EiIoo/6o/n2ha/1?=
 =?us-ascii?Q?/ejh53V2cpAQe+Ih5s0xB76A?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2057e8e7-08ab-418c-b37c-08d9898f2742
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:36:58.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAZWVDb1g9HVDOsA/uC5QcNS/h/FNk5VEBCkG6r3JTC78ZSpko16E6IL6thFj/9mH3GonfJ7Vcv6+c/ponasVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7777
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the existing RISC-V platforms use SiFive CLINT to provide M-level
timer and IPI support whereas S-level uses SBI calls for timer and IPI
support. Also, the SiFive CLINT device is a single device providing both
timer and IPI functionality so RISC-V platforms can't partially implement
SiFive CLINT device and provide alternate mechanism for timer and IPI.

The RISC-V Advacned Core Local Interruptor (ACLINT) tries to address the
limitations of the SiFive CLINT by:
1) Taking modular approach and defining timer and IPI functionality as
   separate devices so that RISC-V platforms can include only required
   devices
2) Providing dedicated MMIO device for S-level IPIs so that SBI calls
   can be avoided for IPIs in Linux RISC-V
3) Allowing multiple instances of timer and IPI devices for a
   multi-socket (or multi-die) NUMA systems

The RISC-V ACLINT specification is backward compatible to the SiFive CLINT
so existing RISC-V platforms with SiFive CLINT are already compliant.

Latest RISC-V ACLINT specification (is stable and will be frozen soon)
can be found at:
https://github.com/riscv/riscv-aclint/releases/download/v1.0-rc2/riscv-aclint-1.0-rc2.pdf

This series adds RISC-V ACLINT support and can be found in the
riscv_aclint_v4 branch at: https://github.com/avpatel/linux

This series is tested on QEMU virt machine with both MMU and NoMMU
Linux RISC-V kernel.

Changes since v3:
 - Dropped PATCH which was updating SiFive CLINT DT bindings
 - Updated MTIMER, MSWI, and SSWI DT bindings to mandate a implmentation
   specific compatible strings
 - Added MTIMER and MSWI implementation specific compatible strings for
   existing platforms with SiFive CLINT
 - Call aclint_swi_init() from CLINT timer driver in PATCH9 when we are
   dealing with SiFive CLINT device

Changes since v2:
 - Addresed Rob's comments on [M|S]SWI DT bindings
 - Dropped PATCH2 because it was not a required change
 - Addressed Marc's comments on ACLINT SWI driver added by PATCH7
 - Added a separate PATCH6 to update SiFive CLINT DT bindings

Changes since v1:
 - Added a new PATCH3 to treat IPIs as normal Linux IRQs for RISC-V kernel
 - New SBI IPI call based irqchip driver in PATCH3 which is only initialized
   by riscv_ipi_setup() when no Linux IRQ numbers are available for IPIs
 - Moved DT bindings patches before corresponding driver patches
 - Implemented ACLINT SWI driver as a irqchip driver in PATCH7
 - Minor nit fixes pointed by Bin Meng

Anup Patel (10):
  RISC-V: Clear SIP bit only when using SBI IPI operations
  RISC-V: Treat IPIs as normal Linux IRQs
  RISC-V: Allow marking IPIs as suitable for remote FENCEs
  RISC-V: Use IPIs for remote TLB flush when possible
  dt-bindings: interrupt-controller: Add ACLINT MSWI and SSWI bindings
  irqchip: Add ACLINT software interrupt driver
  RISC-V: Select ACLINT SWI driver for virt machine
  dt-bindings: timer: Add ACLINT MTIMER bindings
  clocksource: clint: Add support for ACLINT MTIMER device
  MAINTAINERS: Add entry for RISC-V ACLINT drivers

 .../riscv,aclint-swi.yaml                     |  97 ++++++
 .../bindings/timer/riscv,aclint-mtimer.yaml   |  67 +++++
 MAINTAINERS                                   |  10 +
 arch/riscv/Kconfig                            |   1 +
 arch/riscv/Kconfig.socs                       |   1 +
 arch/riscv/include/asm/sbi.h                  |   2 +
 arch/riscv/include/asm/smp.h                  |  49 ++-
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/cpu-hotplug.c               |   3 +-
 arch/riscv/kernel/irq.c                       |   3 +-
 arch/riscv/kernel/sbi-ipi.c                   | 218 ++++++++++++++
 arch/riscv/kernel/sbi.c                       |  15 -
 arch/riscv/kernel/smp.c                       | 167 ++++++-----
 arch/riscv/kernel/smpboot.c                   |   5 +-
 arch/riscv/mm/tlbflush.c                      |  91 ++++--
 drivers/clocksource/timer-clint.c             |  80 ++---
 drivers/irqchip/Kconfig                       |   9 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-riscv-aclint-swi.c        | 282 ++++++++++++++++++
 drivers/irqchip/irq-riscv-intc.c              |  55 ++--
 include/linux/irqchip/irq-riscv-aclint-swi.h  |  19 ++
 21 files changed, 974 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 drivers/irqchip/irq-riscv-aclint-swi.c
 create mode 100644 include/linux/irqchip/irq-riscv-aclint-swi.h

-- 
2.25.1

