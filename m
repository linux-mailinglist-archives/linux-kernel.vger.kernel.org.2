Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4F425346
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbhJGMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:40:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40713 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbhJGMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610265; x=1665146265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6DzTuGvIRn0budUalVk5nAqQizOTjbIh2WNEEdJNnfo=;
  b=ofOmGNOjHjoxXxT3nlDoxLlxm9qmAnwjVfsIUwjBQwjJhhnlVXuUQYua
   Qkf7XkxuSAZQ9uWG7YARwiypl/EmdHmVJeBx/H5zbaEiJU3+IOVGfnpfu
   ojJqscKpnpObiucDpDuFuGt3GU2IBvIMZ1lu2EgSwsCVIuMHOLPWPuOmS
   3gF+JfrBiVZ3GqXuz7lQ1NYp+uKIembbtraWD2KBHzl1NSiuVZxbjTY2k
   kF9tVa2nUsnTq9uC5DGq96IUbuXwEsS/8B6Dv2EHeHTlgNtTbAOu9dgjN
   VZPRjFCOyE7GUsS45rYZgZM5e8cA4t1NVyihhFNo8kZ4jhf2cjeqs/P2n
   g==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="182884286"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8Go6byU/9HqTHb3szwgdwfL6KhmTf1Ozfw1aCkyxZEJDeWB7jVh3ma7ZT+1I/DbweSiROGwpsq/GkQqEYIBI2CBfH03yM8fTgOKfICmsOw3Grv0wmDFLPwQSI5Pftpb2ohYn5vnT5IUoUl1cELjjqdPGYlEG2UqaL3US8F3W0U28Cw9pvAh6uInmmd5BcXu1fdBxNwN1zGKVwcRjufCUV0GeoxOU08NO5sIJTQcY+cJ0hw31q9iBlOlW0pfx+UJNDy6T61KVMla8lv0RvuZwhjBB1WXSckw4SN2/5ie+3Pgi1xnQocJN0Fu0f5nHXQ5J/RN4U0RixPAwf4xPlfx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXItFDz10z+rWSW7ur9NFTvJEPCMsb8+01BHZEdhG+Q=;
 b=ko+4SosA1ioxDrL3Jyq2MgOmrtZ7JOz+K+S8kyEdJvbw1siTOEKtoIJfuox2/OtDj76E59YG0Q+B2UKASaBzimB/UZMTnvO12yZnkUBpKx+9ZKaX1ZlqNgLzb5mmvI/zn0IuABtlCwiNg02co4EBUVXojSyMn2Zgd2I3xybSsR4NxJ5pDAD40MbV5uZW17juC9s/SrAld1z5Warah9Lo26OcsPDFfKuO7s0aw1CAbMdEIOI/zz4DAQ09OT0lpxHa4EusxW6xDeQeQbNWR0u0fb8L8mbHUzgGmAdUlTfLYZ71vLyOwjPAje+/L5FZYPo86MvfC5wlodYlKoHGimKhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXItFDz10z+rWSW7ur9NFTvJEPCMsb8+01BHZEdhG+Q=;
 b=ZhbQXf6HvEaK8xyrfvM5kln/6r5U9bqOB21JL3X2gAPBR8HYoBFoYi+hE2AgzdntdWMZbsWaD7e7QCucO1x431gViub439VUrMKwj7VzVRiWyWBFzJkIBHd6TKBc+PskUSB9gfe5nHAdptuBCYscySdif/uJmWswXl5dfYH+FVo=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7892.namprd04.prod.outlook.com (2603:10b6:303:13a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:39 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:39 +0000
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
Subject: [RFC PATCH v4 10/10] MAINTAINERS: Add entry for RISC-V ACLINT drivers
Date:   Thu,  7 Oct 2021 18:06:32 +0530
Message-Id: <20211007123632.697666-11-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:37:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f85b5e-460d-4a67-a7dc-08d9898f3f67
X-MS-TrafficTypeDiagnostic: CO6PR04MB7892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7892F111FC05752DBEFAF68E8DB19@CO6PR04MB7892.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e70VdNZbHjI4XwV6lnrxnT9jGN3tnMGEMjAlu19zusQ9yDC/LAzfGydw7pTZ1eU4EIkltHdC0ksFhVrbxGbD0Yo+RYm7gIp1dae79kcSis8fd/iyFuD3wzlvMdOT3wzcMmRz8B1lvvLO/BBYZfYEXMZtOew+fsr9agMsaI1QYZXNDNgkxXMPycDTi65pnJZ8YSjwVY4PK2SJhK/ejc7gC7v6S7u4oqzERjKVzP16DcR42B9+lDJTQSefwNJOkY/iXxbKQDR5+7q/vLGcs7+67Pyn9i4sS933ePXC5/dPhJBARIbQ+rQVf6DWdOhUyRf0WTKTjv4U5NV6UVbiPKwXoBJVje0Xiz7BpcmZrbCPVz93Iiwbk3ufa8pRBiOVpzHLUR2Ya1A02yewkgP01DmhMo4apQFZN/vcOJT8t31MnuTnvTdIMiPK8EMOKiMe2hbgt8Ms9RXOXWpwyX43aobQsDTj9EXDhKP8QuIGZieLtU/W/hXduhfLx/Xf7Lyr2VpVafLwsjhLF9Q0h4As5b5nomHBRr5yZOnmHJ+c92WfofJn9S38iNB9sAksrwvILvSI4UAAES4CHlcECvXV8Z9fkupSLRCOEgO3GG5EAXq3nwO+K7FG0LcJ+S9uLxLM55fmZlXoBFB3Qus+ihz/v/S2QpkUYHouUviZMkSayTU1D5tMJRANLoQx4wN42SVpa0vNZs8NvvOYax7ETh18QqdklA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(8676002)(110136005)(316002)(8936002)(508600001)(8886007)(4326008)(36756003)(4744005)(186003)(26005)(2906002)(38100700002)(66946007)(44832011)(1076003)(55016002)(956004)(2616005)(52116002)(66476007)(66556008)(7696005)(83380400001)(7416002)(6666004)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p3en8UqJNHt5DKDhaaCzQZ/xlkfR123wEl7JTTRDvTqJ9yU64qKV8vEPthoM?=
 =?us-ascii?Q?nu+JessvUycZSSOJ4xsI6oSxaZeg3ixo4BKNiOTy/adbXWw6f7kaFcgzC4id?=
 =?us-ascii?Q?jFdnm+MrXz7zFeBxvWSRX/LTAdypgeRLQ5+GjpfB8lhp00/B7wgZd5UyivJk?=
 =?us-ascii?Q?u0Eoym8afP+JLXo4NLD39kIXUWKVlNZBLuTKmWU8xu+fCzRZPdKBwDbBWYDw?=
 =?us-ascii?Q?dEAhl4a7uITSndgCneFaBkbiuKmeBjZIE8Dlk/xYHD5JI+NHM4Xxc1/VM+I+?=
 =?us-ascii?Q?fQvVTZ0AnkP14Vv+6FNH7nltV8NNaaykoyMQNFPMMqlnxV6HZCB3u+/vw3yj?=
 =?us-ascii?Q?avlxNOWXCG5w5bAe7qiIcOQLDq9gFT2xF78qjUxdBC7CYzGGZ2xfLqdKCvkm?=
 =?us-ascii?Q?tmXXmeti99GiSLBeV6RbO/xvyzfwvlw75s6o16dtSKKAGRCXqNnmjia/wRIR?=
 =?us-ascii?Q?v9GA+iG7vo5QZVOlzW+5A5DjwOGKo0S0XRJmehWsb2DH+a9+bZTSCnlciBYv?=
 =?us-ascii?Q?6O9m1vVxIZtFCGTtTi5+CD9ZQ0XikUTb4uva2EkBzAVoVo05mgYQ7+hYm0yn?=
 =?us-ascii?Q?8a0xVDmF4R5ZKwZFtxO6fUS4CL8QztYjQz37o7P8qWQo7/gk8LEfndz1fQTH?=
 =?us-ascii?Q?1gEajQeEx5CiP/5PMI7IEXjkV64YXJcAE8Vy/yXhskNORciqnI+dov5tZ0gH?=
 =?us-ascii?Q?uS0qbFVSmZeceMrmzV1HQaTELunMMSiDtTKMfiuo2kAZAG3fjQHrnT/jmg6U?=
 =?us-ascii?Q?FF6Lf/fNNXIZdzLf2KyTbrlXyZL8084Cyo4bmgVI2uVAsa6wG4eYVIw8TJ9K?=
 =?us-ascii?Q?5cm+sm8aTb2iUUK+4fqufbvZgM89AK/AlNPKbsSzclWxYAzhsokTvDqgsXdk?=
 =?us-ascii?Q?Ysh3O+UnUAIbIOZUxKUegv/qEnJyxYaL2fapfgomHYJwT/vv8D6urCWelYn+?=
 =?us-ascii?Q?OZE5Rzi0WWpKmZE66ZSoJwOxsKIy6ci2SwfqkF5Dcqml1QPK23zQ+Tp5MGMp?=
 =?us-ascii?Q?VnegAuwmTwUbru+w/GPncigHpN4htN1NMy9KNDvo0HIuolf/Iz6LRNbj4dp9?=
 =?us-ascii?Q?Rs0J/I8EupM2QF+scR6aagoNRVXgvhD5MsyBWEgIFGa7B29Os/zMz8fFLAuk?=
 =?us-ascii?Q?2p75nzbATSyJP93VDMq9TJ3dbqUI8uLnnZY/06KFmJAFp4t500fpvQekdORb?=
 =?us-ascii?Q?zyMo7MNF75sOuyla+NtlSCxJVreTAreXaAWtVzRitp3eYW4vuBFzw0ilr1Bd?=
 =?us-ascii?Q?N0XcFymOo1bjT9chRv50il7KzKRKtx50gpTFYakqNVF3xoVpmg4037IXEcu6?=
 =?us-ascii?Q?4xbM009JfL4zTNejk2KOrA6/?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f85b5e-460d-4a67-a7dc-08d9898f3f67
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:39.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCPqvIt4hrpYMvRboS/x3ONoLiimaeo8FjCQaxwpZM97r06d9BcFT2tqbeVpiOem9ZowYEhkBanhzVvYYyleFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for RISC-V ACLINT drivers.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65afc028f4d3..4ccf3bce5c23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16074,6 +16074,16 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V ACLINT DRIVERS
+M:	Anup Patel <anup.patel@wdc.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
+F:	Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
+F:	drivers/clocksource/timer-clint.c
+F:	drivers/irqchip/irq-riscv-aclint-swi.c
+F:	include/linux/irqchip/irq-riscv-aclint-swi.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.25.1

