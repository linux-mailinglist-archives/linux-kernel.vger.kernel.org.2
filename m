Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF223A4FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhFLQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:07:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36030 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhFLQHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623513954; x=1655049954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pbbFRwtDFQz2A4PFUUOT+ne97i1HdchvLO1UiBlGfR8=;
  b=mwEwUENCcHYFAjJTUwxPZdTs9lmJbTp0VkLgoMLP8Yz9RIpWWiErSL7f
   Tpqp8LG7HhidrGl7hWHXG47V2/yRfvHor7VQbuPhMBips0JaYlRFHEnL+
   CuX+mFGU+qbUjy9XtwmwOoPccvP9NQRDQkb+rFCIp5VcEzsF9sBJOfJKG
   qdEPvpWHbQJe/vWZ6MNgaggbOVuMbK/uB5tlp1jNpH4pSNCHnxM9ZDY73
   QwMd1uvnzU35J969Z/ZvxGOnoOoHMbDkBcdbYVSqGNyNCmz3BCDkZqJsB
   ZT4TnX9qWg7t/1ccjjn+j0XJ3LEAW1tCvIFF7WsZFr3CSlPzTS9EkxZPw
   g==;
IronPort-SDR: JlfUG2x/eQmZU1dghUDKO0AzIJRp0b/RgDDFA9M8OhyRM/sqROcOUUn9llYAnpHaNHBgmCfLWC
 a4P298KdbMAB7Ktkxi2Vfz9eE3NDguFHDPVqwNKj6dAys0LAG9co1TBWKM+mcaOem3o642B57Z
 VFSEoutIRTm8ihcgafvGow4N0ejqYoWZvnO8TAM/5Dt2ZfKQ/i2KsH7uKYdbZo5gi15V21k3eH
 hCap4P0QlAnZCDzxZephOonIXMEa9EKGMboZv41s+HoVymsWXwHepyxwfqEF95QbplE+lJPaNy
 xNQ=
X-IronPort-AV: E=Sophos;i="5.83,268,1616428800"; 
   d="scan'208";a="283161078"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2021 00:05:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyJ5nuq0Dh+UmWxD0YXNr53QbJ85CoDlhRt9dNjOgfJbtSaoGR4sOdwyZu0dVZB00vJobVbA3M0PyR1h+U7wAbzTQ+wNHuHgzc3aYvGtoRnPnWpg6MEkIzCxvMCEJGwmdz3l6ehHdnCofcHQTZ3NL8LZ60PgENapbl54dqhZ++z9PsFd1jDoe6m9X5QMIcgSeeYAYeDtxkfnNOrFTMc+5BM8AcB3yKgSh7qtWkP3DBMPT45yM688reR4eIIwViX4i2JDJBwVypPmNmNcHGLxyIKLejrnfGTt+HExpvHkgc+l4X2lty1NmcUx9KkzZJJ22s+rHFvZv2fm22cFXdJXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rss2kCoL22OZ8USgpg1dwXRKRvkNLxXgio7rkJFd0rk=;
 b=HjCqmF5XOqGyj/NhqTSEKFd6YtWgaJxpbwCn0XQ7p/gkLcp9Qpn5pzFsuJR5jedaGTFmaxvWl0ZhUvYg7scZ1+VN/NyW7XQ+/9KFOoK2DGj4Mm7uCN/NJy3q51qvJsrfrHxxi1a1ZL/CkKur0UwZmpyeVFH/5foKcM6wWS5313cQ6rh1P/U1CFwo/r1ptqkMSu4/aGhzyvomUVza+S25XbdwprS3/oxmKoij2ccbwhJLo6iiIh9RaSxpDewqnpP0P9fZEW47jr+EVUxe/yt2lsmHKM2o/UWhGWCU9QgG/MtFVBbMYYqHH/wiqNNEMpOOKz5gDszjKK+YRwY5TsQ10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rss2kCoL22OZ8USgpg1dwXRKRvkNLxXgio7rkJFd0rk=;
 b=Xt9r+vW91nuhpRgODGDpwAXd4luLXGbw9Rago1HZyQeDz4jcSUw8evhtHlrZHqYeu/JfXBzAlPJ9r2m+cbNVzrGPkA4+p0nOjoohSkoCF2nyYVEI/c222mIYIhsfBlnsVRrcoS00+RfAt2R896Os1YOCPYwlfqKkhsFtm+ungNA=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7747.namprd04.prod.outlook.com (2603:10b6:5:35b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Sat, 12 Jun
 2021 16:05:51 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.025; Sat, 12 Jun 2021
 16:05:51 +0000
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
Subject: [RFC PATCH v1 10/10] MAINTAINERS: Add entry for RISC-V ACLINT drivers
Date:   Sat, 12 Jun 2021 21:34:22 +0530
Message-Id: <20210612160422.330705-11-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.171.205) by MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 16:05:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d6eedfa-44d5-4d10-9158-08d92dbbf346
X-MS-TrafficTypeDiagnostic: CO6PR04MB7747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB77477E165B0C5DE48A6B30AA8D339@CO6PR04MB7747.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgSvymeV0SDynozuIGVQSPl2/yNA42vYMC1Pmjtb40C63en4lXDcZUiA93xaF9vaCqNDHKXbtak+aZkWMwUEolbdmYUwSnLI8sZ/uvihXjZ+NZ8GAJlHcDqu01TlNHJV7V0muVbpnZnAFO/Y2wi8B4i7wE6AMCHkXvsdm47MobkrPsg+A68IW7yiC1wjDpGQXHEGhEp2Ym/JUd4iRgSnZpzdg0eJ0NgeUUd8SgjXaIZWbekoisMkqCDNZkoEB6LXH3PVyCoJuMiFZBQ0ghGiyM3M//29a8OXT8OhUDNB8SB9aghWPHhjU4W1UOTkFGLTHATuWrduzjLsu1TMlDd22Mf1Pztz4Xl+bYLhl1N9XyKGG6vKpHEtYB4AF5g4HvHabZ1zJapw5HFOTtrY2AIo1fvNEWL5t3CjY5B1EGlBfLvT0KiposogGIbnnMV1OlIBcdpevsh9gv8t+N6kGeU6ngHdi1t0EARNoebYhqRwoA7/++FbypgTDVl7gvdDZNCkuuy/Tzyp+39x6jTND7X/eYX+mLtR9X6MqIXfpPJ9EA/eAP/nKb4kqWxaq30nXYmO1G6KDj9L3wu9zZZttNuWEXx7MMIBOkpSRmury6jrZNKKtdQj4+AZZ4CB132qlGMK/S5cft/dBHDPsEi6gJ2Igw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(54906003)(8936002)(8676002)(110136005)(4326008)(2616005)(44832011)(16526019)(186003)(66476007)(66556008)(66946007)(2906002)(956004)(316002)(38350700002)(86362001)(38100700002)(55016002)(4744005)(26005)(7696005)(7416002)(8886007)(36756003)(52116002)(6666004)(83380400001)(1076003)(478600001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pdkmhTtnW66x7TSb4MxHL23Ps60X8iH0FgtFVbpMhWpLkAzZNfKnsqjERHXV?=
 =?us-ascii?Q?SvzOcd0nRCRSfNj0HeF1+AhYxYvKEcs+o8XzDd5wjzfBXendQdAZ6xY1wrAz?=
 =?us-ascii?Q?FUBlo04DdhL/HXD6+EJQOHEnwVwbmVNWOOH/QElkB65GNCL2O8SUPeCrxcEo?=
 =?us-ascii?Q?bOImMQk/hFqF07MDqajAEkTct12lzJynCF4mA8Ga41wzdytnJIVdftPGrmM/?=
 =?us-ascii?Q?i2gFF6kk/4XtHFjb17ax6Wg/QdcJ9b8AxyYE34mIzFaCEkFu+Oh1fQjlj5P4?=
 =?us-ascii?Q?4L73F+YWpNMY3k8YF/qB99nt0eLSBHzXmKYFU0mP532fQKkI3DLjZwUIbcIF?=
 =?us-ascii?Q?hh13xkm+rkVf5Cp4m2gkXVxeozoQ6KS03+pteNPzTTr89p/EbRNrVaJt+xVi?=
 =?us-ascii?Q?Ba7q8PX1rQ6ASGLqYjGs7y7qNCggl8z90oGuk2v2IKKO1n6+UnsELLJlR4OU?=
 =?us-ascii?Q?16Dq3/9zpNrjE+27dKReCErUtR029bdCLFgIe+chP/w4H3y6wd5uqC+MBccV?=
 =?us-ascii?Q?HYBj4Nw9SplSJQgicvbds0M45KFKPhUKSwT4VTSBEUEE2OlHcnIu6esOJ+hX?=
 =?us-ascii?Q?eLuUfJUnE96Z5mj/zMyI5YpfS4DJ6E/wY+k0BySkkTOX4G7EOjqSr5FYMBAk?=
 =?us-ascii?Q?mxDz0ifpOrlD544b23VqUrgtBDkrXqL6v+xV8jxlEHJXzyLEQ3YZlvM/Wd6l?=
 =?us-ascii?Q?/PS0ao3MQxrQHBQi2sXCeWW89gNmFLwkcx5Q/IGIAODH3QwMhbD43TNSNvgG?=
 =?us-ascii?Q?lslYGHyCWLRzYFPy31fz0a0cy6KjbqP0HmF5MiZT1j857ZFerf5Yz3wkmwyZ?=
 =?us-ascii?Q?wbE75WwIOkmMcVXAgXqig5BPfLR7u2MalForQ+Km/JLBPt09Aid0mVaRZDyo?=
 =?us-ascii?Q?7BDqw7AdOmdW4l79b/Hmm+aavak88D0HwnyDEOVhuNYPYw04MrDsxd0quW3h?=
 =?us-ascii?Q?SIrWA1PUd61Qcuv1g6gE51enDCh5h60Q1e+JdUnjwMN7cOAWmYoQhA7CCwgf?=
 =?us-ascii?Q?OsycX5owD6V08dJI7OUkzUYaHkj7HyOOikRvHU8MNqeWAeCPwsQg1uA36Oe7?=
 =?us-ascii?Q?pR7Z8ba4g/qnql8qwU8l4neukT5/SSrg3T9BzfMfKiq8TgoxYaZxTMJ1Fcrt?=
 =?us-ascii?Q?U3IomBW7CxWEOucEcZ5INOSkSCC4Cre8+petK7nfIXxnsi4SWe4/fLINyQMX?=
 =?us-ascii?Q?356i/R80kmnroJo14/9qhQxsP+t3LEx1zZdEo4bAO2yEGdLtFWsOhzxHVkdz?=
 =?us-ascii?Q?ZPq/DjzTPs9w/qrZg8KPYhVZ5aoZU1u4h+z7fE4nyFRRG2dx3/LaFe5DzykE?=
 =?us-ascii?Q?HgTmL13/94k5oBjGw9dBGFSH?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6eedfa-44d5-4d10-9158-08d92dbbf346
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 16:05:51.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/7G5E9DhP++GRu3POfk16gNl6vBRc35Uc1QyaL7DKQy+kBpb97p4lj6IP+wcPB7p2wUHqcHhJDXuthCow5ouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for RISC-V ACLINT drivers.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b706dd20ff2b..aee0123438f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15693,6 +15693,15 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V ACLINT DRIVERS
+M:	Anup Patel <anup.patel@wdc.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
+F:	Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
+F:	drivers/clocksource/timer-clint.c
+F:	drivers/irqchip/irq-aclint-swi.c
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.25.1

