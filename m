Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1FF3FB069
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhH3ETh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:19:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45399 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhH3ETZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297112; x=1661833112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=A0RiadUwWBnN6qLQ6baUXXxCN+i01fbrXSIW3KEH9u4=;
  b=ARt83u9x1L1HCcS/jWn8dW+8L1obpBJn/nWS9AWtXxbNLVyX+0IJh5R2
   f6b/xJcQbjiZCnrsgK++1l2kUvgHL/O2VFDZPHrnfcIEYVfeDmPyrbaX8
   Ri9qIjBLUTUX9SCoV0wSx0f83iAXN+KklUqVPPuR7JMdoE/SZab25kD36
   QMHn5h5iwn5HLcJUl96YQUy/73ahnsP88GnbdHd+TqAgtrtsBfXFO6kqY
   vFmOSDmmMempiMyLGFDejtRYdj/LpEAECuDVkRTx3iTpgq1ukHki6mpq4
   2gzvTsTiiacyGzlIIDUencyxCbqg4mC8S0oMFf882cSJGlQjW7S9pH0dh
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="177841344"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUGI1i10X1BMUjREGThwhm9qm/r8d1W2XkhYEKLawk8HWwAmnXnm+dV9u+xr3nQlwzy///qyC1GwWcI305NmAC5bfhkT/JLMMeMaj5J14+HcqR9Jb5ksh9ChcVoc2hsgnkUBPH6tKuohbTv906HuaPJl34W177ULiJIt1TyRhT7nTrljE2tMZQFkyMWv/PeTyAChzw9m/o2cU3XfUL+uVzlj2tSfdixFRdEZ/NmsySAI9fkvJhRFkiWl1CeA3meBJdadi5qZZTAa/myrA1GPqhd1W9zsKgbUPnM79MX/MBVO7aK0OHEgiDL0Up7k2NZVtf+plApawEkAh1gT504cOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIiEX1BGg/RPcL4NTR0Io5dK6z9osq7SQaNwyA2Tmeg=;
 b=eVjnioVrMfDya6SwM4EiJS1uF0Dg/V11qZfd2c9iL1sx0WTtH3Hbdht+KGADQ3vcKRVHsfxpmfIDrH+igJcWq+5xQfUQJWC/unBxJJ6pooUcGqL3aFKHSQ/2RX4lVLsOnxuqHRrI7WAdoZeTqG88XEQmXuW/Y6TS2oW2Zp/V+bFdCZWa/xRjTKPQJTZ9rHsAwJeAqC16XEnMkzIm1ApXRkOIJh6GSeXDyAbSNO8Px1hsRu6PD7sxSjBXvtzuU9gumslz5Jk/BQvMUL0okdQ9oJ96nNzr1YLv+syZN76PIKv7bd+5DpiN2sSVfFSsGslb2eTLm7HlR68qn9rJIxihvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIiEX1BGg/RPcL4NTR0Io5dK6z9osq7SQaNwyA2Tmeg=;
 b=yj4/q9VyAnhjRR1V32RDHpWFzggHXNnjzIlkm0ube5S6hhWnkBdlkYQvt6JbTtmT19K55aaRzy9zMcosOc1R2Bzqb1Ydd3b8rtgk6DpwO2sCaIDKuIo3lZ1TO6sCpMm6zLzhAOvGZIeRXEwg7lv02mu2nAYLlbOGKqf0IrX7+qM=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB7870.namprd04.prod.outlook.com (2603:10b6:a03:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Mon, 30 Aug
 2021 04:18:28 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:28 +0000
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
Subject: [RFC PATCH v3 08/11] RISC-V: Select ACLINT SWI driver for virt machine
Date:   Mon, 30 Aug 2021 09:47:26 +0530
Message-Id: <20210830041729.237252-9-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b176fd73-5e3e-4077-5d29-08d96b6d3795
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7870:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB7870F82A5CD058D8862CD2408DCB9@SJ0PR04MB7870.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJd2jrA6oCdps8mZdbeychFGo1XbVGs0eiqX1i8brr6rdMYxich3zxPtn+aVu0z41vQ23sZCDiBWC98y/Yn4PBU1tAJ9izz5mSv4H/K+xsbz5xy509ziBTOvm//EdtkjhC0+SH6f84cz/lRaZ1smw6VcfeSGDLHSc5Qfwi5eRlUKkPAdYKfToCuO/EOQKpFEwpnLEV5Be3HgxXIIm0yWlsjis2JgQ8IvB8YI86TPllDHwblWXIVk1/9VxBjm2rHgMSRA2gyHf8vl3s4PBXoHrVx9KORmq43UaVXeQxHn4feyLAWlQmjvwPjFyDP+pn1C3i5Jvzx6HZ6ulqewMqDsAAcOGQ8iEH7fvScpjSQY8u/5z8HL90DAznVBVgIf8ZYKqnFccAknLe0N0W5z3h9nTB1Er8bfNDLVEYq1+0VqkJoctW9Xerf3iAvzHO5cbN4pDjF+N/Ludkxa//Dct1O9GF/zQDtfkjZ5YgJ6Xzj6F8y5r0CEXLjg/37gBImLbEWj4HdRLhZedFPVBLmexF80FHi/G1y/8CkQInrTsmt/oBAMC4QCEeeN0RgUIewHKaE3fZezJCuDdCMib1/lkCCpdMw1LP37E1+6Em9yes++IBZeXGOLNCLWr84vqc46/FNLnLKZ9XkU6BtQhKUr2Tz0Lnu5yFwfqU9rBbqBqvRs1z7bw0ijC829NR8URzzRznUe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(55016002)(110136005)(66556008)(66476007)(54906003)(8936002)(7696005)(52116002)(956004)(316002)(66946007)(2616005)(44832011)(8676002)(2906002)(8886007)(5660300002)(186003)(86362001)(478600001)(7416002)(4326008)(38350700002)(38100700002)(26005)(4744005)(36756003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vnvf2BJqoTbMNCQWhPIlxU60WQCriDqDvc38cI+DDDua9oAGUkkEsHRENH4X?=
 =?us-ascii?Q?AKjTeqkaFaNEr8+9U4fB22/PJc/3pPo3nUb4D6rx3khkwJyAq5JoXx2PW//5?=
 =?us-ascii?Q?f7v2184ObnpYtg0EQBc/W//ROSoER6GtrI07v/XMK2X4pI37S+3FyWgrGaXg?=
 =?us-ascii?Q?6GJPUevK+19hk8rGKAnpavrHZCfxEW9OVuMPIBDqmNIy62oLnG4c5HgKv5V2?=
 =?us-ascii?Q?0b6kTC6f2bKe9TLDZoh/hVN0THPPY/IdMSO7HM+eLa/WxxFIBl3XUeE4MaDK?=
 =?us-ascii?Q?T6De3JPLeZloRMG+t0Ggt4iUAtGj0FCMKbnr3PQ0WKScj+i+WXduDnKqkZzY?=
 =?us-ascii?Q?ZIsiJRrS+57/EMSkz0iYhFKZXkncuEepBQPhH0JWmyuoej0JabKATNBYmkks?=
 =?us-ascii?Q?EuO27vdmw7tWzuJ4VsfaYPtkzTXT1fWSXelmLAiUox1JPscvP3cFbUxbSSJi?=
 =?us-ascii?Q?FOiuRGODawr/zOpfUHKqrZT2DqDySGACrw/SevY+LD4YtuuaRJD00YWQjdxn?=
 =?us-ascii?Q?6XvOfHSOre9shg16kzBLA+dct6cb0VNdz+k7iO2wf95YauPygQs+/FcFXucv?=
 =?us-ascii?Q?xNrgdWdtkSG+h3EL1X6rjnLg/Nj2Jx+nASNfvLegm5XvBd1wicjwKSPDgkqD?=
 =?us-ascii?Q?5BtdrsfhoeKwfyEaVg6wOUe/wQ1prl+56UK0kPN9DUYqVYNJw+L58Fp/6McK?=
 =?us-ascii?Q?vvjS+h5mi0+W1rbJSfeDRTX9XVy87MtgEMU+vdiuHJlFQmGnPhAWLweK34HU?=
 =?us-ascii?Q?owcYHruXUmbtLc9nugehV0ZZQuj74afoMZK2T6rwQT2us/fKsILF6qzUlA7j?=
 =?us-ascii?Q?WW6DgW2+7Z6MYC2Ku8dBDSQmWZhqwSWP+rFjf+8qH8g0Y5Giqb2o95/j+XlE?=
 =?us-ascii?Q?oBl2tIFJMLo4Bk7gMEL2b8m5yr5B8Ut4EjdTAjgfqfzHiuLVt4zOQRncXVye?=
 =?us-ascii?Q?D2L87RCfnKQRpKtHHZyzLwqepMlWa3jx+nx3028ur3kIglnYSuCPHy230Q3q?=
 =?us-ascii?Q?HHAQqFDZgDwx7Vn0GnpdAqLxtogp6ASgkIohbkoTGhXutS8CWE9H3BxVCpHM?=
 =?us-ascii?Q?apuB1ZUXc4H7IuUoRZgniY7DHcSHZj84yv+dQx5daar8Js0eVV3m3uMgajUf?=
 =?us-ascii?Q?lOoPXE7B11fF/Yx7YYl054hTr6KvoS8whFD5o+Pr01dLDvkKajOKdx9H3Jib?=
 =?us-ascii?Q?DuVYJNEVSZGoWofk74YKwGUqlTsxkJCXSWioSGBLnbXB/Eqqqxr+QGO4ShKk?=
 =?us-ascii?Q?R3viTR/LHEkNM4TjFnHhzm5DBE3T7VapqFTBjJbaVyptbCzbK9UJELSnlR47?=
 =?us-ascii?Q?wzDb3RW4ZFnm+54+a2Btzj7T?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b176fd73-5e3e-4077-5d29-08d96b6d3795
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:28.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PJ6JJ9blRM8DFM0r62QRPx/DyTnVB3x79aQ6zaTbBedBkwoZTZEzYKpTYZn3IaiiuGTCN6WLLEffExXILlZow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QEMU virt machine has provision to emulate ACLINT SWI device
for supervisor-mode so let's select corresponding driver from
SOC_VIRT kconfig option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 30676ebb16eb..651da2ed93bc 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -28,6 +28,7 @@ config SOC_VIRT
 	select GOLDFISH
 	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
+	select RISCV_ACLINT_SWI
 	help
 	  This enables support for QEMU Virt Machine.
 
-- 
2.25.1

