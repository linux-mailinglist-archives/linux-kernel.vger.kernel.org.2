Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3D3ACB30
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhFRMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:42:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62817 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhFRMmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624019993; x=1655555993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4QGixAxKfNfJ45oOm9bBDY2BI90ypMJcRJGpkQd0iZw=;
  b=re9Klrx0YCQslGrUc5YQ0doENuqDTJUKd9cD5KApSnrIYwZGTNoa9rpj
   4WOr4R9CgA96ivJ9Wn39K4BfsJsXAFKAS4f6gAfnUUe2z+JesFeAKFQKs
   o7X1cAqzfGjcOsRZz3MJTfTJLSL1HB3LaRHELnFwF+e8oLCQ/3Cz9NGR+
   /tS6N5ZLbz643Tx5chWyLUpuDJ3++nA5JlRrIWssF5hAVfruVSyG5rX3D
   MfZapmbztZ3SV3nX3WhpxFnBVCBb+b/XuAncNJKRK5Jd4dIErBy1v7BOW
   PjZ7gUi/oKOexH9Y1QH3aeanoSWcvyL1IrxP/jeqQBtuoesKYmZ7Yr07L
   g==;
IronPort-SDR: wacPq2NrmilYmMla+WFyBheiHOmyCUhxi3Fyu2YLYAq+2TwW0YmFw9wyTMBmfElBzFk/9BMqU+
 bw7Z9ExDOEL/RW/I+4eKFYv1FiNxKmrwzrBVbM0NIoEwf8Sv4bLQDMb9KegvvzDZRJ7VIfi+wZ
 NnTcTJSlDfB0+BesTolLni9iPIfkjGwLliw1ugF10cwn6XJp3aKr9WO8ShpJ09QvCk+JadT+Ro
 ut4w5WLPp6WzBo1rw20WqXJX/tYv4zOGwB9oRR84jIyjeV0OXcWO9izrR4HZ7piBk9DJF0tQsw
 UbY=
X-IronPort-AV: E=Sophos;i="5.83,283,1616428800"; 
   d="scan'208";a="283779327"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 20:39:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUo1OV7LdlGAMJyeKTpCfIqOOq3njnY3etNkmetTcepMl4Yo+tHDCFKf8xep0FZWv3yfkyjL3D8C44JHcIfYwWnGlOvIYWDsDurf6IUltXoOyXb0WWVgC14pQ9wjT7srhiiBH35oB7Tq9KHnrh+b7isATYj6OK5M5KH3eWQ6evEPHhfOL7ViWKBZ0sl7KcpTjBt2hDGUSTt6ikHkutrcBh/GVaSoFZUyPTm3QTQuRZNGpVtG5ckgIHY/hWREQPZ26CnMp1FqNB12e76sFfIRyHUo+cuQFGDL9qGjZZoiJsH8ZSEvx0dgCbpAMtnMS8nTKwd8mwj29wde81cIlOJLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5sZWcSj5FMDDPI6oxiWpnILTTE5i3vqneR1JZHSCf0=;
 b=hiIQd6MRWU96hWmDIwEYC3WcLuyiIpChtiqiQEWh+CdJNY6HZUGE/KrvNvplCtMhQEK1rpAcsgU0Ai3vvE+9DBnEInFPa8Qt4y14OYBILu3bZG/anh8Gi31yBAE1Ci/0a0ocjeJY6HNkr3H2t4PqHpRzb9OSXJedLbs+wFsLHZWcy5ghz78FCQUg4EJcsQxMs1CKQzTKwOIR7oI9TRrvG7hJ4pKXISvsBv5S5Ox5iTLkonrSTF2AS+kOtNQFCKuAsMJNZk8oMCEgWcEZwJdljOGywcq+mLa1t0MOj+7GL597r09zrOK5qvwb2G6430qY4xS0FlMrEZquGWaU/hS+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5sZWcSj5FMDDPI6oxiWpnILTTE5i3vqneR1JZHSCf0=;
 b=WApAtmEh8lnmf6D+W1BpnKAEofaL2E00R8qRFgae1AAsIBDFXTGPz1ukaIcuMKxgNmhsd8JnQYysZIZFnH8jsF90rekej321Ywsw0Ui5dExdP2iuRKHFc/d1OfHwWZtqQjzPsV5un3Yv+jQRBrWzLiJaNtEF7VOivh4AwhgcLbA=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 12:39:52 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:39:52 +0000
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
Subject: [RFC PATCH v2 08/11] RISC-V: Select ACLINT SWI driver for virt machine
Date:   Fri, 18 Jun 2021 18:08:48 +0530
Message-Id: <20210618123851.1344518-9-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.164.186) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 12:39:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da6f73b4-b84f-47cf-1b35-08d932562b36
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78438480F900182B4DC528428D0D9@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHZhdiTymeYXcNScs7MOWxLmFEdswu81nLg/Iwqk/+gNuL8fv05AuvtWFQoc/hk26rtD2x9ieoLDzTThQzom6c+nd9xhTi5CGzrY2IcWbvi8R630aFhGAmUranyymLgWjqTvyO1DogJVUgf0wp6x/B3g95wLFYeAEy3SUT6fHpW1aaFZ3H7FVZUUqf++WEZ2JCtm5RF9C6cVWJ0pOz3JSupt86aYhQIpgqXczKQcGEq4+h8oyvr2mpyXEEFGw/pDPo/+wElD8ACP+UvGg+EUStJoeN8hR2gW4YJss6CYx5cDkXA6TFYVnNJzQf9qE3U+zLMFL4Jq6cK6QFHJ2vkqYG1rWCLaDCa35HC3xpVtJZGa41lnRd7t6zxJnprjhUm4r4UFVWHf676o6UVOwM80EC8PQkjpYyJvXxjzJ+5F+iBarg/EhOwd9PK9ZwYkCuIfLhXuOj7OR+McjUOxLZ78AGhsROWfNiactoWqRW1yWfcRw8VcrR33e32/fGCpbgS0EhVwtipG69nZ6VXyGtOGmUzFtqV9xup0zCVHyfPbdY9fcIpT1WwVfgTQLFb8N6DAoLwOORitsN1KXMT3i3MmvdBWWaqPJRqTQHv3c9UWrMtVAWG4F+bxVkqflpRPTjmZbnrJR+cVEH1lv4uw1R/Wsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(316002)(4326008)(16526019)(186003)(110136005)(54906003)(52116002)(26005)(55016002)(2616005)(956004)(2906002)(5660300002)(4744005)(7416002)(478600001)(38100700002)(38350700002)(8676002)(66556008)(8886007)(44832011)(86362001)(8936002)(36756003)(1076003)(66476007)(66946007)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpEtKf6qgOoSlbVisfQyRT1WX53uRhBco/AI99X2+HqU3IacU6/WkC+fr1cR?=
 =?us-ascii?Q?wQVZYshz8jX0MfBtGYtnVH+VtSA1hmNJMd8B+bfkUHRXtIKYTnQKDeNnCUhm?=
 =?us-ascii?Q?731uat1TMlOsqij60nReMj3+anF1+WXj7etngpqg9qhdv8DC369bToBkbS7S?=
 =?us-ascii?Q?r9cIaGQMppNYdaWHrXD9znSs+C3R8R3XpOfQRAoTc2YJFAiqHGFSbJgLJvYR?=
 =?us-ascii?Q?O/Huk1TfAMNbcO2OWuqNsY4gDZLx//BdelVUqucyuufDQFBY2YyIrA7a1pbw?=
 =?us-ascii?Q?onBBuT89JMCOVlb01BlE9MinQkdoZssDYA6fx5HsKbNu73feYPFeLFJYiEiu?=
 =?us-ascii?Q?fY2zCujyxAxUX53IS+S2+eXa7T35VTgxCZYBrGH56KxbKgsCKSnC2vs7l7Ok?=
 =?us-ascii?Q?jJnEUlEVZt+CI8KD8aYUbRlWmhRQY41uyrBLkqp1yrmLKmWddckGc7FtoN7H?=
 =?us-ascii?Q?HPVfWRXf2SdTHx7ByPIivL9Dp95pyrCSBV8Vnx4yVtmVn+HFYtX5CneTqtm4?=
 =?us-ascii?Q?JWmEsM8JopbYLhk6cJlBC4nHoOW3tWJBQ5aNx2vpNPJuKWOqlZvvgzLIJfSx?=
 =?us-ascii?Q?rF788KYPkkEbXCdk6mKOj1K3shCdaI5Y9SpL1vPJNaRNlcanIUCVpPz7jc1X?=
 =?us-ascii?Q?MeQIZcHk/O1lkHnrR2srwuSRSexIzmS5Hk/EbQdT0UHIsfzkvhBMb/6HfUXP?=
 =?us-ascii?Q?aWMJ9OG7pf+Uk96hJghJKWS96gERRedrKOKLlYkYm/0d/lYdcr5Ajl0rbZX+?=
 =?us-ascii?Q?bemOuSpYETlFlnaANBhxnVBn7mKsv/P+tKlm851gq+s0PgXyL71kPvC3lGp3?=
 =?us-ascii?Q?ML7K1vlyirsfxAGpvsx1YhS2B9ERMsCR2ovWvR9dtQ67PSUOmIL5HSd7yzIG?=
 =?us-ascii?Q?eOAc3TNMN60b0c7irMMmSiDoNleX0XYJU6iwwBWRrqjELAAbkseEuRQjHnbZ?=
 =?us-ascii?Q?09KcS7uHCTo5yAtiY0wmI7lM5OyKgkBdplVXZU0EwybiSbQmpRwmz0xIB4mu?=
 =?us-ascii?Q?LRaCDlevcVIs9XZ5s+i4GBRx3oXSOkGkPP/EhXC2RSKLelpG/u4hJU26n3rh?=
 =?us-ascii?Q?aXR2zaVi0Qblie7/wmf0nBKzxHrX4jQYWQoaHfeefuoiSysqSr1Be6vordxS?=
 =?us-ascii?Q?AMp0me7ZJ1qX2E5HX8/Hb3RaLiaClnrXDTix4C5tFStuWhjbqGPtworul+mJ?=
 =?us-ascii?Q?Mdox4e7iiw0o2s0wB0sgNg4Ja2grzPHI4htDxLt/694nB/sqttC7jczCD632?=
 =?us-ascii?Q?V+rKdtHnPdx/ZOsI/LMV57k1dFmT9wAhcqgQkK+BnUTANHpbH4IZJPyBjwUo?=
 =?us-ascii?Q?/vB8bkEO+TjbOokt5FXPtmAK?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6f73b4-b84f-47cf-1b35-08d932562b36
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 12:39:52.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/zigNe4xzbwdgT1jrR1dinUG4yjXmpnQzNflKK2i58t6aB66ZQWm0SkkbCqe42YTtRBqxPR0X1Wk3h/athp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
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
index ed963761fbd2..2687a0902ec4 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -27,6 +27,7 @@ config SOC_VIRT
 	select GOLDFISH
 	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
+	select RISCV_ACLINT_SWI
 	help
 	  This enables support for QEMU Virt Machine.
 
-- 
2.25.1

