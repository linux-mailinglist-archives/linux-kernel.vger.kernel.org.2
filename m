Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02073FB055
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhH3ESt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:18:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56351 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhH3ESs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297075; x=1661833075;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rnbMD9CLPfahBUqf7I1nJpQUplEY6+bh467medZmRJA=;
  b=FEdXIi3wze/fFkEnVgNpgFFFgneF2cfDCl8OjC5m/aBOdC4UcDcpgkvh
   gOeYfOUqT/rbQV5kgVe7Y4JcnAXrUpdpXrTT6wGABKWMdW7rGiuGZWUFs
   f/v9iqAx7Ake5KHfLN4AOZuktvCC7Enh+WhbaaQIJtQqO6hROfqb3Yw1o
   Jecz/wg23c5T6CeBZgTTI9fcAkKII5q0bKH1irCqPvB9GHxuV1sH0wKMF
   Fc285dQUV/NJBSWvHo9VjLRYrGBt59/B4zpql7OWFCwim7N6WOMvhNyJI
   n6hyAq032EQXNq//+Jt73M1tn+k95X4r8VfmOYIRNC49zuExcJA9Y/EVp
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="290332129"
Received: from mail-mw2nam08lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:17:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cusflI3oxiklEHaDKzDMpehOPzr6yY24Lvg3IgVFentobD9ZxUuBnTNW5DxersbmV65xsCt5pvPeSXbqaZk+r8U/MoII+1lZ1FvTA7uqix3SVbZHp0qUwD9ItkG7W/D82G6K1Y6mR5C31vUMSg4eW9KqlcKyJ3In7E+KhJGW8hSHW0HdKrYdu0seRkdNR/kPIZD/ikIc9DazcPLiMppMv0ZLc7Dx0ddFYZsJ2UCqBJH+naMXtx8OaFBNRqaDFCMd2PahAEZXQw+52ew8jrZamM+9Y8EzQ9VX5se0kCGyL9ItB2DIKCY690aZN0IL7jQVyvIb+sYhjAM5izxM363ySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0Mu6IBC7/mpjfLqlPuysyhHKQvovegDoci+AKpF8h4=;
 b=gfwJsJ/5wr6dQxkM49TWWwkcRaNLmTZzi5zxr6nuNo/oFxqZsHDDih6ix5N8Z+FbdgTxxKpskDQ3Peaab9UHen7R7fHTUuR5nZm9toSGl92ScRTFZo1/l0HEDiO1QfQyuMALZ/REyRSwUnQtKXVPY61XDLCjR88AlmXb6C4t69VpW06CDi9wmp2FSjptNIEuujVtvcbP9VW7m+Qo5RpRpeNhXgQYKJtLFxPqw2+TcYlEydiE2fLFtY+WwH9G4u+DOXcB1W7vP8fm+n9Hn9UwOMhfQ9DMeWM4ylaWyQgeGbC0r3Frxa0SPMiu1uO+fVAk0trwLPZPGfCEdHNlseBcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0Mu6IBC7/mpjfLqlPuysyhHKQvovegDoci+AKpF8h4=;
 b=bJS+NHIaCUIajHspb9nZalW8PoMSuHAsI5zjnqPCTCBcowJ3Bk6wrdC+ioRveK/nioGIO/3tCxNkoiM0gizgCYTeBNmxel8HYR2IKBJ1IO8gaQxoZFeySZigWbl6VVjvqY7Rt5VqIUC/nKEURdAuIaJEJz/fRxBqTAdIJYA/nWI=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB7838.namprd04.prod.outlook.com (2603:10b6:a03:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 04:17:53 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:17:53 +0000
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
Subject: [RFC PATCH v3 00/11] Linux RISC-V ACLINT Support
Date:   Mon, 30 Aug 2021 09:47:18 +0530
Message-Id: <20210830041729.237252-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::12) To SJ0PR04MB7821.namprd04.prod.outlook.com
 (2603:10b6:a03:3ac::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:17:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4dcf21b-58cd-4131-5a89-08d96b6d22e4
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB78381C4D89281D28EF9579AB8DCB9@SJ0PR04MB7838.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOaY74iX185WvLSPPYdiam9heANUL23augE1aDiG8K19Rbfuciv4hKqAfqiBnVZY3LZkZLMZ6Ym64uqFA1n6ZBaLEefYbDUMp+9ZpZCmVLbqBFDARjYiMPMSHCEHN/UXDSoGRnERyMfn03ZxqYVank/e1cVswGtCis+hY7/FziDV+JTYG2cYN++xBuxOqWLijvtg4M0e4A5zzTyy0InScxbr7rmUW22kOtqCH00CSbOzrMXL6jGpaC8J+aHtwPxpYcs5dPK/waF7rp0gqSaQDiZ5O8wZT6WpB5mxpFRjnoRr/b86LK6XbIDLXZK93UIhZepI/Mcxk05NWblpsjie+D3W7kh6M3eEiFBio+Js4MHZguZ9567rWH1fRSqh1zAqUJvgJUA6GHVXYM90XQd+4CnNGwoCevpS6vJ/QbBo2MTzHnFB3UDKOrr3hrOLTrrV4p/RBaeCsPxoCh0bIxw4DbZSzikJTJlLHsVGWddPfCBNrPkca8fX7OQnhNq+fxhij/7h3gGJlm34md6dWhYYw0RslHrSecF/DK/+dwnN/3laOYeHCIA7DHjamiN9Jjna6avnWHbpsM2ajs+D4fSgxBGtuVQgWrx6TA1W1fMAziK8+w72VjXWNr0UtdIiodYWYevJ5Wr0RR59Wf83ZpZHfYJvN4e/iLaRdi61JcV7tmTE14IWvOWIZMpD4z6MkVa8Q2tCmyr4MRvJEKpH+TYwJsswIbtqs8eMLl9dg0aaCPdoLhGMTohTHPtI61twms4M/77mjls2nlysEy164fd+q/dzGFCzQ7Zqf/rdFgdBxHk6aVthOqeQk5GMgItrSGfs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(66946007)(8936002)(83380400001)(2906002)(966005)(86362001)(110136005)(4326008)(54906003)(186003)(36756003)(66476007)(8886007)(8676002)(7696005)(52116002)(66556008)(316002)(38350700002)(38100700002)(2616005)(55016002)(44832011)(956004)(1076003)(5660300002)(7416002)(478600001)(6666004)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qP8e3anrOf7Fshwo33R4UoP1XGNEoJ1eNMdRhqad5ngJpMi46sFODulNo/tP?=
 =?us-ascii?Q?bcnYARGTUEVoot2gHC3HWHhdCIm3K4vRR3SfNEFup8cI41GDEGxtflKvVEqq?=
 =?us-ascii?Q?7Ko6MsjpIOeVX6qyxLIVKgCXQg74XeaQTPxWo7BkJC8rB7ETX8WNJKZCJyVO?=
 =?us-ascii?Q?ID/m/XETbLK5/G9Wgc4Rf8PO6ibPIg9WhkaLuiNkPillsFMBibKC83xiOnDv?=
 =?us-ascii?Q?aA98Bc59IO03PHGQlP0SSum1yT+XZEAjBpjCVyzcbjJWtitSVh0qLipZypaA?=
 =?us-ascii?Q?Tmp3vT3YYtLMcpYiTAz5DZhzYrl2Xw0/WYWzDV41gf1eJQChxc4AZ43nN84P?=
 =?us-ascii?Q?QL2rMW/iuM2i5B0KoCPgf6m4Gf52nEnv8RHVywRGSIX2y1Eg4EzqLTiumzCn?=
 =?us-ascii?Q?Qigd5ZWLP7eKEjZcnbTo1EAdyVRfTADMLpIAmHi8wWLBHEsjuqGX5N2gDaa4?=
 =?us-ascii?Q?eKjauHtlkSKQfYqNXnXSt5UMow2J0n0KI3USC7gCrRl6uCFMSoCt1B9uju+N?=
 =?us-ascii?Q?HrB5BRF/C34vSB5wnz9Ikn/mq0ExldPO/pHoeRN4PTl4Yaphz0eB/1j7JVpS?=
 =?us-ascii?Q?UKUE13U7GehdAaz8NVryr2Qgy2V55T6nKcTyzgK9mqzsCEDc8JHxbOLmc4dk?=
 =?us-ascii?Q?U7K7ewj92s1qVJrsycxosxO8LlAkJkfIsF+0LxicaXKhYXZWuyxowqIV7YXw?=
 =?us-ascii?Q?/eQ5huJZODP8jr19glRrJOYK+1JaIq2cOLI5Ka3QPxJvge17GYvOY9G95LQ3?=
 =?us-ascii?Q?SeaYT6mXK15wviySH3pDR0WpjrvP9fogixV63nN0Mxn5sv+SROV3Gks5GD0l?=
 =?us-ascii?Q?SF4L+PxBAnQkGnE92uipyJi2JtbSQkFIHhhaVCzaQBj6IFwfnwBFzr0XKOIx?=
 =?us-ascii?Q?IfdP5B7P8eokaGMwFdoCeEDDr02lrU9KMyQW3Vi93eR7p01trJC/QWMheCbv?=
 =?us-ascii?Q?WNdnQ8hsCxE/XDtxJAMharlC7Y6CSyYEWYrthkzcfSUjIFk12TiVU1x59UqQ?=
 =?us-ascii?Q?gt20ywm5R9ISThrdULDZgKbn8fgYqordtFRsWBex0X+j5XoV8zM9aSe0S1V7?=
 =?us-ascii?Q?nRkOjJ0Zl1ara6dsAgkyacFraQzd0VsRn+VIxp5jWIc8p1taWGrl3dFpUow7?=
 =?us-ascii?Q?MHqFllWLMiEarSTSfBe/yfu2cV+uJ4DZkXYS3vZg5b3ks2y5hZZiGf5UCVcX?=
 =?us-ascii?Q?yvCqtPQXjNY/vgrDuVGZfoSCh1nsOMoixIsK//vcINhZjfPkm7ruw+wz+3c9?=
 =?us-ascii?Q?23oqIsvaKmVeOHnXt/1xHvgKzBni1StjzOccKGJ4ZR0Y8fzFL1pv78lO9sPj?=
 =?us-ascii?Q?+qk4Rwv4KNaGKsrb3D4b42tA?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dcf21b-58cd-4131-5a89-08d96b6d22e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:17:53.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whMNTYkb517F/0/xxNCeFRD2bB+1tg6MNGj2Brp6bsabc2kxZPRpAR3BSxKLFY5IFlIN3dWElAJlX7gWaYD9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the existing RISC-V platforms use SiFive CLINT to provide M-level
timer and IPI support whereas S-level uses SBI calls for timer and IPI
support. Also, the SiFive CLINT device is a single device providing both
timer and IPI functionality so RISC-V platforms can't partially implement
SiFive CLINT device and provide alternate mechanism for timer and IPI.

The RISC-V Advacned Core Local Interruptor (ACLINT) tries to address the
limitations of SiFive CLINT by:
1) Taking modular approach and defining timer and IPI functionality as
   separate devices so that RISC-V platforms can include only required
   devices
2) Providing dedicated MMIO device for S-level IPIs so that SBI calls
   can be avoided for IPIs in Linux RISC-V
3) Allowing multiple instances of timer and IPI devices for a
   multi-socket (or multi-die) NUMA systems
4) Being backward compatible to SiFive CLINT so that existing RISC-V
   platforms stay compliant with RISC-V ACLINT specification

Latest RISC-V ACLINT specification (to be frozen soon) can be found at:
https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

This series adds RISC-V ACLINT support and can be found in the
riscv_aclint_v3 branch at:
https://github.com/avpatel/linux

To test this series, the RISC-V ACLINT support for QEMU can be found
in the riscv_aclint_v3 branch at:
https://github.com/avpatel/qemu

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

Anup Patel (11):
  RISC-V: Clear SIP bit only when using SBI IPI operations
  RISC-V: Treat IPIs as normal Linux IRQs
  RISC-V: Allow marking IPIs as suitable for remote FENCEs
  RISC-V: Use IPIs for remote TLB flush when possible
  dt-bindings: interrupt-controller: Add ACLINT MSWI and SSWI bindings
  dt-bindings: timer: Update SiFive CLINT bindings for IPI support
  irqchip: Add ACLINT software interrupt driver
  RISC-V: Select ACLINT SWI driver for virt machine
  dt-bindings: timer: Add ACLINT MTIMER bindings
  clocksource: clint: Add support for ACLINT MTIMER device
  MAINTAINERS: Add entry for RISC-V ACLINT drivers

 .../riscv,aclint-swi.yaml                     |  95 +++++++
 .../bindings/timer/riscv,aclint-mtimer.yaml   |  70 +++++
 .../bindings/timer/sifive,clint.yaml          |  20 +-
 MAINTAINERS                                   |   9 +
 arch/riscv/Kconfig                            |   1 +
 arch/riscv/Kconfig.socs                       |   1 +
 arch/riscv/boot/dts/canaan/k210.dtsi          |   2 +
 .../boot/dts/microchip/microchip-mpfs.dtsi    |   2 +
 arch/riscv/include/asm/sbi.h                  |   2 +
 arch/riscv/include/asm/smp.h                  |  48 +++-
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/cpu-hotplug.c               |   2 +
 arch/riscv/kernel/irq.c                       |   1 +
 arch/riscv/kernel/sbi-ipi.c                   | 215 ++++++++++++++
 arch/riscv/kernel/sbi.c                       |  15 -
 arch/riscv/kernel/smp.c                       | 172 ++++++------
 arch/riscv/kernel/smpboot.c                   |   4 +-
 arch/riscv/mm/tlbflush.c                      |  91 ++++--
 drivers/clocksource/timer-clint.c             |  69 +++--
 drivers/irqchip/Kconfig                       |   9 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-riscv-aclint-swi.c        | 265 ++++++++++++++++++
 drivers/irqchip/irq-riscv-intc.c              |  55 ++--
 23 files changed, 946 insertions(+), 204 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 drivers/irqchip/irq-riscv-aclint-swi.c

-- 
2.25.1

