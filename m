Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9403323C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhCILPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:15:04 -0500
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:27232
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229520AbhCILOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:14:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz+UPmXmK/h7JuMgZ+emZjPPXq+7yJjsy2n4Kb5M9bU0I+mgf15BCKjRwwxigZBkC3w6jeWu/bA1pkE50cE+xsPkmHiMZBZQ1YDuH3D5eXN9Xku2P4jvDfjZ3ix+1rDh3gW6GYcDTEVD7FQckCGfj7dBhfx/V0kF+x7r8nbyVOmiESca1lXFSRv4MCHeLR7lXDDXCBZDl/hKsO3Fie2NVgVuzYblg27Gebypq/jVntPDg2mCxv3QlsxeUKQ2VvTPcdlRSEh5Wiyf5fG2EcULTR4U9THhhIC3P46MJXRaPYjX20MivgVZhXCtLyh58Jda/9lYkSEp/ES3+JjkMv1+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYXojipoLoWORd5r89f2ogaQby2aVbj1xQmROhKAjSw=;
 b=nZ5ZppegYpsheEI4WUm4+UmK/wdKklpoCNZ2eBagRQWhwkUK1BwCsK1NgC75kmbnVdF5q9i0JvhrWWDG8xdPCPd6SWHvC3xItuw7t2NJ3VMkARW8YSipYecdMH/GrrhbpyWTPBAjtPso1MEgvKFUNBDhSBeS/U7BfzoiWNtMGwgZRouANVqDtqk6uSOCBOZiqiiNcoDSBCbf4Ga4NqpQ1tyCMfzLPYSZUBQdmvJCs0GkBEWsO2VlgivYhQlo+tM0ut1ey4TLRd8T+XGtVqKrMRW87Akn5mbXqe5x/CgxW4r21SGjNguTm9B0d+WmCSMMjTR9mkmHClmwrkw9sN6aAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYXojipoLoWORd5r89f2ogaQby2aVbj1xQmROhKAjSw=;
 b=ZBHviIYRzsa1Mxi5h6bY78dDZ1pdSVlan4YT618PV7MV50ilxSFdoNeJ212YZDd0BgDTiTdOZTmgNyG464+PIfaC6uTQJL8IOV1BwkJk22T8MgZhoqcX/q8ZJZkQFvMk/TxFLuryUS+dhkk8oVtutvgnT7RJsycPmKtrJvLDjZY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB6PR0401MB2375.eurprd04.prod.outlook.com (2603:10a6:4:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Tue, 9 Mar
 2021 11:14:49 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 11:14:48 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 0/2] Resolve NXP flexspi bindings compatibility warnings
Date:   Tue,  9 Mar 2021 16:44:23 +0530
Message-Id: <20210309111425.3539755-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR03CA0044.apcprd03.prod.outlook.com (2603:1096:202:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend Transport; Tue, 9 Mar 2021 11:14:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f73879d8-73c1-49cd-5db8-08d8e2ec8d5b
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2375265D842C94F7215C9C71E0929@DB6PR0401MB2375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QURSnT9RUpYWF3dcQwAhqvMJAM20Yr8mOXZh7dA05APP/qMzIBiyTem5jbcIILVqvjeF3jv6K5rRJIudSyu5dMSq1TtXsulReOU0yKdVpWVceq1Ph+OLD4z0GQMRq31NqZyqeOVbvA9TDeb+LkG7m65JI6gIR6OeBmDCkHLm495sX5dKpod39T/RWeicmfrQa7NIZjvMjiLekwXAdQ8WtYdpXTjzvkfY7hCmrdHF33CNaxtyJ11bowGWMEpzSMVV1X7jA5tIMAmES7q9DIxWsBFobtmYkKw+McDBsUE9olXi2wik59S/FPTeAKIQKD0ZjClGdrCgyE10YAJmJBjF/6x+twb3OZT36vuXmxj9OfmZnxz3ofRWSYcIKdaUiXOWpYpJoYDRPCiT1t2IwfbPGQb7QJCiuHxIJ0E3KLZo6KWv76B1PbbxUryyFYTm5UZ10NFftq4Nnr1C11pyYWpXtLhIYnFtvPq6hG29vUsj+vmvY2vMB5Sk7iZWnCgJ8FRK6YTif4s7sVwWOeex7Uj9M+ZS3QrUPo9wAT7+1fDjIjqM/Tm0/oCPDNOZUFqQB44GUusOwDoEf2LQJJckqiSjLn84atgTFx76Xli4itkcNYh9so8VkrONIrSEzNkSU2OoKkhFy+94w77QiRLUuE52w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(54906003)(26005)(1076003)(7696005)(2906002)(5660300002)(4326008)(966005)(478600001)(44832011)(52116002)(36756003)(186003)(8676002)(2616005)(16526019)(6666004)(6486002)(956004)(66556008)(66476007)(83380400001)(66946007)(316002)(55236004)(1006002)(86362001)(8936002)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PTiBJLsZ5AJBanQsx53p4aSIOyvaS8CrG6kK7PbLOT+rHhZMz4npGa4jy52m?=
 =?us-ascii?Q?y+coJkJ/7WizpxD4ZnKYZU/5AaMV5ETwL5yXPPQAH2UZtJkTywTHvKZHeP+b?=
 =?us-ascii?Q?GHeir4K7Yn5NavRVC94rMJYkeMKH2hagvhPkGr8kFwH+sXF+iyV166zIOywW?=
 =?us-ascii?Q?jfh9gyd5l9EPXdYIHDYvM1K8qS9VZQpS1XM1MUt4APphp8prA4HnuY3ELBTo?=
 =?us-ascii?Q?xjqiO4RnlGXjXXgwcl5R/LaF0PfCgWdzf7IHyh2YIgpAmUFllgwkbmBLEJUl?=
 =?us-ascii?Q?yS44W9eD7TlWOnoZ7pSJLWrd+eLLcTKQDIDplCw6p1TfxeeDLqccHxsndXkI?=
 =?us-ascii?Q?JnH2nV6qzsNKT8TNnKUu5wqrh4QII/gRnIQr83M4IQc8m2B9ppe0i7u/RJpk?=
 =?us-ascii?Q?HUYv5fyhM43Atu49HGQpclbTZcr+FhKGrYq/GJtWUes0mH6KFGznrUUApV+z?=
 =?us-ascii?Q?e513AiQ7tQJ9C2oYtmfGIVpjYvFt35UMt2W1hQA9xdbHRqV2pcCKLJ1lwrgE?=
 =?us-ascii?Q?oV/IcAAv7FV9lK4bEiRm8nMTy4TuxDAm4AZLJP+n7k4yZx3uEZYEx5RMakEl?=
 =?us-ascii?Q?+lM/3BEqKk5E4b5VtVrN8Ym/dxmptUttbV2QgRwMFYSORM/DgFC6bSJkO8MT?=
 =?us-ascii?Q?lhzhqXo0P2Mxs3caeo4vjm+ijIfQ70bTO/5E1h5cug/V8NjK1sQv0Ok2dSVp?=
 =?us-ascii?Q?qtL1V4EkKrEzubrRNWqXQOSZqeB1yWpcMx0xD/lBN9r2SjmSGNO00l29Kj01?=
 =?us-ascii?Q?8YUOQbDUTJgx7SEZOcZ3lwcCR6hUQpWfYciehWOPBLSF3ygv269N2fqtz7KS?=
 =?us-ascii?Q?rNlW2MKwiO0h+XzQQDuulgecpOfhef0b7HOF5cmQpTFyj8kPfT+/C/q/LWmI?=
 =?us-ascii?Q?OlJr/w1mYCwW+6gPJVPw9TY/66+5WFpuupYOrLpHoEkFAUuO/HhLlhOUQiIK?=
 =?us-ascii?Q?VXwz3U5RHRdGnku2plTNcDvW+92nZnaoRl3F/2BKcUIoVmyPFC8T/PuZZq/j?=
 =?us-ascii?Q?sZOYagDvGLOLTjQCjblz2kE+ySK7n41C2P62WJrx5vDBfeouO1EQwZ50CroN?=
 =?us-ascii?Q?5PVQTe/pXqhcJ7TyLfsuqKo+Rqlxo/ZF1rHiKAJhcegCectjvoUU+MA4AQXz?=
 =?us-ascii?Q?4g705plOvJm9rxb58azqhu8o+tU6SoLrvtNhFG3KxRfV5Ey7gXbPjO47LG77?=
 =?us-ascii?Q?TqoYcqjssZy7kRELy5EMAgc3XArGlF1RdbdhWwH+ySlbrGm7SChVmtAOPqjk?=
 =?us-ascii?Q?+K0WFVXNo8m9Ix0aHZ6iQ2u9E7903ts/4L7L/0lGSUYhaI7xckjy1CFZ+oqK?=
 =?us-ascii?Q?++/J+jYSl9OR4aQlpV12H0Um?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73879d8-73c1-49cd-5db8-08d8e2ec8d5b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 11:14:48.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RPtiGrgek6uXerVMIWZCdYeoTK83+gv/tCqB7Tw2oOJl758VAG14wNOceFe5f7SRbJtJqRaIDWxLV1bqCXsCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches series aim is to resolve NXP flexspi bindings compatibility
warnings which were observed after running 'make dtbs_check' with
https://lore.kernel.org/linux-devicetree/20210309103528.3538910-1-kuldeep.singh@nxp.com/
patch applied.

Below error was observed:
/opt/samba/nxf51654/spi/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: spi@30bb0000: clock-names:0: 'fspi_en' was expected
	From schema: /opt/samba/nxf51654/spi/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
/opt/samba/nxf51654/spi/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: spi@30bb0000: clock-names:1: 'fspi' was expected
	From schema: /opt/samba/nxf51654/spi/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml

Resolving above error may require reordering of flexspi clock-names entry.

Kuldeep Singh (2):
  arm64: dts: imx8mm: Reorder flexspi clock-names entry
  arm64: dts: imx8mn: Reorder flexspi clock-names entry

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

