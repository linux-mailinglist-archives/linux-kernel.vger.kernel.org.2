Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339833FB06D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhH3EUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:20:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29643 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhH3ETh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297124; x=1661833124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+BkjlPEF23L6zhrbrR9PEaNEFAEa8eGcZuvBLehJCx4=;
  b=Gz5ccZhS4D+rNnKGUu2VaEmmV5b4RJuXxGzxlZKkYcEDayajoo70DeYM
   IgebbVHEcA33zp6hjdLwqnJTz2zNbc7f4UMCrfXbV/zF5cyxkLTW3RihL
   XgdKHHRir59GDYDQPAKLSbhcw6jWT/mw2vbKx8lYTcmokrb8SVwbfeXLm
   ng8mWI/DEsHJPHandTnFC/GqvoOUjdRc0xFXPqyuCAiS4Dq1oWGb0FBRw
   cMWW2QVW3FGJ02GrUjXXnWd9koW+4LKtl6DWpCz5+JwcJKN0CC69EXYOc
   hQ7ITXwYXfciMaC9wYm8Z+h9aWTrOIgqwN1R7QxX5NXZZBPJ+79hXH0z4
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="179285400"
Received: from mail-mw2nam08lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq+wnlAil8VAPGj2QSwo2TXlY4IMPSGeRLTqe4AvvHzaoCFO2cXnMcPwO18+YE/uIh5FZ+4Fu+OeB0Qv6djsZgmtSkrUr7PQD7M3MQFnln4Y5rOBBxc6rGR7560r77yvBLNq4DQIts87TC3vlG5mZEh/ENB2S0lAlDJ+a7f5Nex2WPGqxwjsZIBa0oC5L38QmOCD3rA20uzpZzdBJ8FCctMhs/TQk+IUqe6mB2JXRcmrug/3INn36CaI25gRzeEInoNkZN4E7ze3P2fYiVTTdx4szTY79YPRdm/sHQ+v/ZT7dcpCQy6nt32ib67ybwxWpoC6f1219ERPYkEAaNjC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAzsfWHCL8cCPULb9LWZ2UJgjKKBiK8hBgh0aPdcAP0=;
 b=VjKiGHzH2C42xeouf38kC1kEvioQ9OGw1YSVhd/UyiXH0kLV/J+CV57ZSGwOzLZmw95QYdGD3LCD4oDcRGaw2BpO5k59JYkrYuAzBao/Vm02XItp2fL0UhaM7YSxcuRTiZRL2I0i3zTqp2c9xSvn0rwRfx4F+UuDJpIziuIb2liqQAE87mWOABhVczodIs1pLEzpMfDhFo+Cz/QscGg6goBHcFq3gZ/GnL/Y20GowBUVyH1ZcSj5H0yLwpcAaRqUOLS0W5886auBCCwTet47qWn5zl7nR6JZz3qbiD0VGqWiqNCdja1+17N46juVMaQ6UorI8N/t+7dZ6YFHib6exQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAzsfWHCL8cCPULb9LWZ2UJgjKKBiK8hBgh0aPdcAP0=;
 b=uiDANn3renouOy8sAOffCO4sp0nW9Sc6laAHk67IPh6tMIUycwrq4ErjnuJIpXnm5UtQkYf4VETPr6IyoV9QNc3YwRzGpqMkEKmf6B5Gx56cQiy7y6+rkEXHWG1KPm+JjU6R73RSZSFWfLv24H8p34GEd+KFcyf8ey/8n7+E3yU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB8274.namprd04.prod.outlook.com (2603:10b6:a03:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Mon, 30 Aug
 2021 04:18:42 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:41 +0000
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
Subject: [RFC PATCH v3 11/11] MAINTAINERS: Add entry for RISC-V ACLINT drivers
Date:   Mon, 30 Aug 2021 09:47:29 +0530
Message-Id: <20210830041729.237252-12-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42ae32cf-fd95-4e0e-9bee-08d96b6d3fa9
X-MS-TrafficTypeDiagnostic: SJ0PR04MB8274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB82742A395A0CD4E10F4E71388DCB9@SJ0PR04MB8274.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuWjHwtEnUyWcqgIBNcPJ2nZzdX1+aaq2lX6CJJd4it4cs8fNKOBVT98PIql8Z2uMt0Fr9RjFk60SwOqEUwI68JoByAUpMTwTOUBqzqiE8xsfRGnUnOXr1gJP/Co0touQy8Ghb9sY2BEscjKhdpzCNwuDsQVhMXZ9Drim5WDVe8vzvh9c3UEQUzaG8PQQPZUtUjKqrLRUhRYAoqndCQmZ41R8/2YCOcrmrTwiJAmmoAp4t2/PEOuljIAwNfNMwC8URrYjRpc1GWQ7G5YCL6bmFQ2RyJ+u9AZ2RZ+AazWxWUx22wpreBJgPwv1hZJOLqIMcNjTE+0MV/AVq7xihfWswo3ZtO5ork5+7HE6DZ/8U5NoGl6JQTEad3LEpy6ZIRPQGnaNj4NEHYWQ2Tk1kVcwHmlQWMaDhD74iJQIkYNrisdbLkruq+JqZhVs9lQBDwyapvT+NkZGiHzob5yTXdf4LP4fJpI/gEW5Y1Rz+EW0H9PJvpabmX+r4UkRrGkZ3UsdbqgOZ6VkDdMcssuS7dPM6uAEEBfDQPfkvqOzu1sLRxtSYf14GA0vrIYpXR2nbaLwEJOQi+i1Yh3aKnMi7rdzZ9DUzhZDH3pV4aTU8h3518dEFBd2if/k/il4Y1PE2POnrBOxmviYzlBHQCVwfKRlvQXESV9I8DBe0keSftztEHeRNW9IVhj3wmNfCEinUhe01B5CzzIXUchsdyvB7CFSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(66556008)(38350700002)(2616005)(478600001)(86362001)(66476007)(38100700002)(52116002)(66946007)(7416002)(7696005)(6666004)(316002)(956004)(186003)(55016002)(4744005)(36756003)(54906003)(8886007)(110136005)(4326008)(8936002)(8676002)(26005)(1076003)(5660300002)(44832011)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LcQd+AghlLmCWHO8a1m+gDbjPQcZwvx22tFIr4vNyKZLUOctygnWrksVYei?=
 =?us-ascii?Q?5aqso7GGu3aj5zZ3sWHaWyKaNyEwR6fgGVUm1DkSHkAqw/hp9WrAojgIa2pl?=
 =?us-ascii?Q?6lj6oMMzjLTZ7rcqPC9RZFUbjVNWTc/gfuMoP8H4JihQOh89SG598kyhuIX/?=
 =?us-ascii?Q?0HEgZroot73tUh47bRwH8cMpRexGTZX2+zOOThNsb+Z+ybtzLjsXfSINprWz?=
 =?us-ascii?Q?OlmVudSEky0LDEER8llYO6k751GDKsXll0Bgl9MSn+AQUrq5UNpeD/QQgHRh?=
 =?us-ascii?Q?we1pQmpBqu7POidMr2SJRVIEYVWWWCaVpH82fOTlLJlUpq0DwkHbE6KvKZci?=
 =?us-ascii?Q?MBVqIcl4kQXmQ2hYMgnK1ufzhf9QiIUCSdhO/9ePhRzFX43G+AktzDHmY2j6?=
 =?us-ascii?Q?b3ha0T+iiBlu1mY4tcIRlf26RKy24D6muYz0lt/n89qroYMuL73TgfWhhT35?=
 =?us-ascii?Q?ptMrR6vCKRLp0jwPlqil5yaKUnDYKkAqQoRk6MQMD7r4uM65Tr27ct4P6FOz?=
 =?us-ascii?Q?nn5flAe0KvsYHAPmrIx8uo/CVrJkJfAN9cIVb56qZKmQV/qWHdmIf/C6rW+k?=
 =?us-ascii?Q?L1WDYzL3LYLIeejWBgC5uhYBhOtezBGAY1XsSG49wcMwaWDQu/kHvjMzLmZc?=
 =?us-ascii?Q?LnW6pW9nlXf5WBpgSn7dHElwSwlLIEtKevdoBTCJ/iwcPloDZSu8upfg+TOo?=
 =?us-ascii?Q?SFoKpLT1LpUrPScEWEn/Esu5fgja2WpMkhkN2R47zkr8XcB0bgIZvLh3wro7?=
 =?us-ascii?Q?RMp5vEGaXzVFrXCeY4Nt0KIFMJOQSfrZqOeX9OfycQkGwZWn5kPl2J6vKvqi?=
 =?us-ascii?Q?Kn97DTeBIbhF3Q7hnlI+nG61TniVqDgG0BWPERn2n6yBelPnHWFtbi1BO/wQ?=
 =?us-ascii?Q?yYwvo1PCpAZFDchslayauHgJotY75QbXn2qrRAHvNjNA4BRsjfkjnDC66NyF?=
 =?us-ascii?Q?3INky/6ks/6gz7nHrX8w7uY/czxOAipZFht17nTTQl55qokMwl7lJsg3zuDT?=
 =?us-ascii?Q?SwF2xjcIPuwaBmC9cSjpUAjXv6fkkiRIbt/EwMetrSSOKBO2c9dVBwnG728T?=
 =?us-ascii?Q?WQ8QD1cdt2uR8nRRjTApqnxok1MEGJXCleK0zqGMCkVJXU3xCGu6LTUV/v4j?=
 =?us-ascii?Q?qxCbLMc+n9jowvUl26wRlZvo4R9EOHME9ivzfH+GuR6lpWDeINQi+Wbx10dt?=
 =?us-ascii?Q?DabehVn4kcr0gk5U3qaR/wVUy1i0O9K1dgxJU4OpLK/YGTNnabPNbMsBk6QI?=
 =?us-ascii?Q?dSKY346xsq1CvMGEs6LrBCjNRjInXKl5r/B+bw3+f8pwSsa0QVDKXiT+T8wF?=
 =?us-ascii?Q?KnwERLxYTIMvgRkYklwTa2Ph?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ae32cf-fd95-4e0e-9bee-08d96b6d3fa9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:41.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAeiitJ663iNTYdIoHsxFD0upbIsTPfhYtSMKHH9PxDA4mIcAu2frLjwp00VcPRanzPpOJe/WBrlop146mrMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8274
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for RISC-V ACLINT drivers.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcc97d48249f..3bc36e30ef07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15936,6 +15936,15 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V ACLINT DRIVERS
+M:	Anup Patel <anup.patel@wdc.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
+F:	Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
+F:	drivers/clocksource/timer-clint.c
+F:	drivers/irqchip/irq-riscv-aclint-swi.c
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.25.1

