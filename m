Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE603F2933
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhHTJcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:32:04 -0400
Received: from mail-bn1nam07on2060.outbound.protection.outlook.com ([40.107.212.60]:43684
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235278AbhHTJcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:32:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXC7O6IoUTmXYdoAIcA3H4cJsh7WsPG+AMJAbsCbV7ED9NEqQgh40QMywGn/y+D8xT51LayjbkFVHT2EoVAgI4K4J1hG5F3KPOCax3olqGcGu2Ls/X1Sz6MI+J0ut74GWY5A9ghR9t1gT2Aar9+Lve3Fg7iiIh7V/yO/ibfFROacckMhlVXBXH/GuZEhW55pFTnsd75PtbpXNpug93oWT2yLtKykw7juHAS8OWj33VZiENm9eK9vAd2kjfZ8NYhiyDKdZ2TZS+Xneix6rBLXPA71UhRJlr6G6pi+2jSUitXLhoe0qz37k0G1/FHdJ90d+s6lErKE1zcO2BOlT46RnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0ymnsqEltTWxKbr7jG+Fgc1QTRR26Ir7xi+Ft9H61Q=;
 b=mXYYLm73ywl9agkecT1a5nundOqfpnRQb+TqP3i6CZFMNES7kgXuPTCG4pH+mHX0b6AFFcKRfqc+6bCcpGqX/LdhPIb/A5DtCuasTzX2MWqyC1Lw/OMdkgga6qMOBpSH9Qngwxo9SrJfow3gLfbbS6RaIZnOgU72PMGTMe1butOlYWwkBA7y9W1G9Q121DvnXSqctChA7LH8sN3CqbZwexxFHz9ffgXRB8JikxG0ZdqDM/n8NaONs/CdCnnvs7sZEm9bmTnuE+15/+RdFGBsE4YZ5xcYHj1ObJZxsrdnGVrTXhq2MTwmEJO22AXEYEX5YHQGgheudQ/LD78uidrarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0ymnsqEltTWxKbr7jG+Fgc1QTRR26Ir7xi+Ft9H61Q=;
 b=NGRumwwXipM0LEyHLIN5Sv9Ht2tBdl8rV8oMZ1KcIJoYzH2Xxm/VL/DzgOQlgHNM5LR01qnFRL8O5mECtL6PPXXCpYLAJFfpJOK/MnvFBGUZety9JOlKkghwlUUR20g+RAVjWWiXbXFLNzaT2DaFdnGoZ89mZiuRhN6lxurEjRc=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN6PR03MB2611.namprd03.prod.outlook.com (2603:10b6:404:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Fri, 20 Aug
 2021 09:31:24 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::80c6:5858:36d0:33d4]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::80c6:5858:36d0:33d4%8]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 09:31:24 +0000
Date:   Fri, 20 Aug 2021 17:31:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Rob Herring <robh@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: synaptics: add DT for AS370-RDK
Message-ID: <20210820173108.01d5c6de@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY3PR10CA0027.namprd10.prod.outlook.com (2603:10b6:a03:255::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 09:31:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4c8672-f10f-45d9-999c-08d963bd46fd
X-MS-TrafficTypeDiagnostic: BN6PR03MB2611:
X-Microsoft-Antispam-PRVS: <BN6PR03MB26113DDBFDBAC8656DE27931EDC19@BN6PR03MB2611.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPErIwlyU1WV42v2pMy29cKbYoXzcaw60ZJkvFQJBSqWg9RSU/8zeDnU2Kd3RBTa+MYlx4FOFso5hu6tp2rOgNKD+WK+oopnrvNiKz98rZitOKZvYMmud1poNdstFKD7yW546O4A+ULRq09Rg6FwE05a1IKQ5FLPKZrF3YCCrtqa+BrL1ZIu2DbsRfdArsQKvXxb6YrkQau805xUkbxo/XGS2dME4VMSlf/V+L+or4mfeyLmJ+DiJIj5e8j+y9eZqFC9EjS73KEG8B8t1eyKsl3T09Vw5ms35B353BkZ88NQ2tajf+PUgab5QxzzA53z8eq1Vm2od/g3fKFywkwVFzNTxYxr88JAHGiU1Fgf/spUjAE2CEXhRTvSj8eE7Abhvf43YSxpEj0IKN1M8uvzjbhuyvzoaGkwr4gcxWxYG2qdAMjF5bFo48tnrqoQLf35xJ8XpSU8PqhVLqVZKsHYiL6IOOmOEE+APp9lPlwvQnqleA/Sqv6UlGDO+jYLy53ru3fs3wKG8qwS4AEn4H5yusTs7wEwjvaFnyLnR/+DfOdpzmMeiEqOx0dHa/Id05t+lm2tLLGnxCmiWWa+IGhVf0Xm0+vVPOXSqTvtsU5nh3omYlGw6pywjArYTOLp5HH+ImPqFu/v2CeVGgEUfUaAWKp9IxWCim3tQ3gOzDoHC4NSpQOaazg49rIwXEnVf93t5sm9R744sQfjpjTvEie9bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39850400004)(396003)(66556008)(66946007)(6506007)(66476007)(1076003)(38100700002)(38350700002)(8676002)(55016002)(9686003)(956004)(7696005)(4326008)(186003)(52116002)(5660300002)(2906002)(110136005)(86362001)(316002)(26005)(478600001)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u52s9kJ/f/KrKy5/kb1UvKB5NS/u/h1i3gPnhnXwX0rNd5rH+BaK9OZHjs8z?=
 =?us-ascii?Q?rr+Di8PozwxFuLqiKY7E2i/SB5rWzTCyqQBFyLZK+a+qBlEGrW/lzyCpxu9i?=
 =?us-ascii?Q?54RXZVO9eb7J+8iS0tnR3gmvf7n8e0Es4cTW0mfpgDjbjqiMD47P3SV0Y0cp?=
 =?us-ascii?Q?GexHHS07jhU6FwCc81qMCZZdwOVN2LSarLZskKpL3zRNcL8imYWnxMzg2A4P?=
 =?us-ascii?Q?ZQwRf0hV2Q5jDSzvGBhs3JpBDEMAfSxGQdoItJuotJSX7yfqL1HX5bPTt85P?=
 =?us-ascii?Q?psOPPfDXKV4bmZuU+sDAa3gORpBUdJkC/Hvk3xE5FZ55YuzakApz09NQf5LZ?=
 =?us-ascii?Q?GdZDkH2AppjqTTjAqY3+zgszfhHP+YA8Vnxz6IBtKzfcG6J4erRSBiiF0l9w?=
 =?us-ascii?Q?Y3TrONU2Y98U+gzdmm6d9C4zdxQYjsgpMm82vEfm0MleNW5wpBgXQ8zeP7qt?=
 =?us-ascii?Q?jgC/W+6SZVawD2W5dQp3YjrvqJbeeRaP+LoP9zGkVwZRU76xLPfDzOyPWCSL?=
 =?us-ascii?Q?8DBj9ok8bdsEHjOiw0PNyYEtFsTLpxjthjf7ebcSDY4t3DCbSS1v+H4GIG93?=
 =?us-ascii?Q?AIK+kSjE6kE7mjMlH3cg8sNs9HefFx4hTPHsngmjCupvXudJRlUpup+e7uza?=
 =?us-ascii?Q?cl7EAgLeya3oH6F4/kyBpMx+nQBljQSYKHfS1d3iXirHch1QRRto7TpKpBv7?=
 =?us-ascii?Q?i8e6lz/4b6aqElZUqca0CZP+847+jALsuGqVXzg/WCWxyVK07j45ukEl92hD?=
 =?us-ascii?Q?cTej0FUPDamckSV546oULYs7hL/h0ummXgTPR3/cNLzCdx5quKKtpJRSjDAX?=
 =?us-ascii?Q?1Y/F8IFbMCz/zVLBs0ZKuVYmkA+GmfwrPIi9+4pNPXGPvDTFjjKQP+eVeSuU?=
 =?us-ascii?Q?1jhLboirkqW6vRLZD/Hc71VaRPSOnQTxgFzCC22OmtGuhShOLq++IT9vLVaC?=
 =?us-ascii?Q?Cc4LebZk8IfYrqIkY6GELH09k5GbfGqWvzKDBMijdRh/TWcxjHNBoQLXkNQB?=
 =?us-ascii?Q?DJ+Th7TdYzO35CvV8PBBAsg7F2tIQ7OxzVTi0kUrzl7I4h68qDFx0sxEclGV?=
 =?us-ascii?Q?HaApOp2poyCeTFzIIGQi8ZGf/eDk0rE/zNlQzDP+3f61q5dY5WvBkWUYl1hF?=
 =?us-ascii?Q?HCIva/4GPafEqlTIvNnLeDFj1dzaT1YItmTP0x72p0NsoC6dT0BUPJkiEzPB?=
 =?us-ascii?Q?ZXwacU/QVGr1M+gvpE+MB14uZN4+N0pHX1sWe/lOahK/fiVSaMVYGq26GrBy?=
 =?us-ascii?Q?ZGYHdOMS3bQ9ga16keWse9/Bjk3brPtSafhXhTVS0iVe0qpFoNZIyY/NFOHu?=
 =?us-ascii?Q?RgHnOpF8xJIOBVxU8fD8Gcyx?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4c8672-f10f-45d9-999c-08d963bd46fd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 09:31:24.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cewd6rK0niw1EkwjzPJripGM0c3fJFmES7pmTKF4P5WtCOTZh5qLvLxLKihGKrA5w8DQMVS7YamV0LFrEdckUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2611
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic support for AS370-RDK board based on the AS370 SoC. We can
get a basic shell on the uart console now.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Hi Arnd,

If it's too late, I will add it in a PR for 5.16 in next development window.

Thanks

 arch/arm64/boot/dts/synaptics/Makefile      |  1 +
 arch/arm64/boot/dts/synaptics/as370-rdk.dts | 29 +++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/boot/dts/synaptics/as370-rdk.dts

diff --git a/arch/arm64/boot/dts/synaptics/Makefile b/arch/arm64/boot/dts/synaptics/Makefile
index de71ddda6835..c1c4f6c040b3 100644
--- a/arch/arm64/boot/dts/synaptics/Makefile
+++ b/arch/arm64/boot/dts/synaptics/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 # Berlin SoC Family
+dtb-$(CONFIG_ARCH_BERLIN) += as370-rdk.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-dmp.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
diff --git a/arch/arm64/boot/dts/synaptics/as370-rdk.dts b/arch/arm64/boot/dts/synaptics/as370-rdk.dts
new file mode 100644
index 000000000000..6f5c37c98be6
--- /dev/null
+++ b/arch/arm64/boot/dts/synaptics/as370-rdk.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2018-2021 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "as370.dtsi"
+
+/ {
+	model = "Synaptics AS370 RDK";
+	compatible = "syna,as370-rdk", "syna,as370";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@1000000 {
+		device_type = "memory";
+		/* the first 16MB is for firmwares' usage */
+		reg = <0 0x01000000 0 0x1f000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.33.0

