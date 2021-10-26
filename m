Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9984E43AD79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhJZHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:48:03 -0400
Received: from mail-bn7nam10on2092.outbound.protection.outlook.com ([40.107.92.92]:42081
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229940AbhJZHsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQg+BkccemGtVXwkemzcgBTdRpBCjGiql/sAzQ5dcFZ1+9XvIIbh6vjF8/MYK3AHzLQ37jdZSkxcZUGzRCzJLxXrbF/qvO/p3aeUwvkxgHBbq9FTxHosAtrDwkmwfO17vxi80Ibn8fh5wdE6y5bhjkz2/fGAk2odMiFrlras6E5PMdRT2DljtGDcgpFrjIGNpEXaJPkaJDmGiriW5cfMiJ5gUWCCuXxoTA4E7SW9efcCVeQ+Q0q0wnZuYQxxgSgP3gR7mAy3t5bXXNBJRCKPR40NizDcZupqepg6p6p++N/zYcF0RKDH5yHSqxVYUuTBSG3MWFrfXT1lCOGGBQrwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he95tu/GCl1zPM+El5K0fCOl2Pz8Wu6EEHbySF+QOqU=;
 b=CLPKtXKzP99RHoP8s1GPt7XC7H3twaDJx5UJjrqbQQiT5m2LxuxjBDvONUIR9zgoKfgNjteeSIJd1RGIOFj+BVgiaRFdHPWbLyaQ4H/UnKQWspwPLJM+PZLD8oqENgt67u3YP87OE0356T2c9bhTX+4Xj0utIHea2uHImFCOswBHk6NaLoF0PLJTGceh95AZfiIhdASXjTaAvEtBNoq5SCaswlOt8QbuIJA6X6c7h4PRS2ewxD3vwWoVnaCDxnjqJD9xezfzm9um6zA+tx5OfWFcEMk86OLYD6ciyEXoWRu9DIlGm9PFWWN5ejFD8b4F1TKwrZjLx0bKwd9CUv2G3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=he95tu/GCl1zPM+El5K0fCOl2Pz8Wu6EEHbySF+QOqU=;
 b=Rf6mXU61Dl5LvciogymPAhZPsltVt1ldT1lfsIBlUOFX2aZjciSLA5+DgQ7wDbQIcz/Gd8IoXXbcY85OsCciytYpaa07JUXQff9/JOqbVX9iZqj00f2Kb733BdLVOKa0RZ0+18leJLtrCkwWm7xZLxs2e1LgAB3sZaL0nq1B+M4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
 by BYAPR11MB2535.namprd11.prod.outlook.com (2603:10b6:a02:be::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 07:45:37 +0000
Received: from BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94]) by BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94%6]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 07:45:37 +0000
From:   George Song <george.song@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com,
        George Song <george.song@maximintegrated.com>,
        Rob Herring <robh@kernel.org>
Subject: [v6 1/2] ASoC: dt-bindings: max98520: add initial bindings
Date:   Tue, 26 Oct 2021 16:45:20 +0900
Message-Id: <20211026074521.353-1-george.song@maximintegrated.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:100:2d::30) To BYAPR11MB3671.namprd11.prod.outlook.com
 (2603:10b6:a03:b3::15)
MIME-Version: 1.0
Received: from SEL-LT-028891.maxim-ic.internal (223.62.172.41) by SL2PR04CA0018.apcprd04.prod.outlook.com (2603:1096:100:2d::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 07:45:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f36f77b-40c2-43d5-e461-08d998549996
X-MS-TrafficTypeDiagnostic: BYAPR11MB2535:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2535B0F036459E6CF3C3AC85F4849@BYAPR11MB2535.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+rdjHvk2gru61cQzb0MnfMuk4RfHpMKB4NcL0Kqmf/x1FdYkOiEABl1VhEYbEPlBhAZhTgly80UQCobAPneFNrl1RE07vRcenUwhglIqgPz2kpsKNVhtSGKli+dQKmfs//0T/ydr0AiLfTonc83/MUY0rg+RkYsc1XKn/yPYpzLuzXRdXJncncaUOFWabGuErRjXMIOZaQo9SZIY6haXbzU51p9k0iq3E3uoy2SLdvlPuIkkoCuFzra6CqJTNTx3McznnLwRvA3hgmNOsbpyctFM/umCtDqXwwKkU4EkVPbX0Fplfm2xjiIhyUUvG0LVPOUcTgUNjFPL5j9Z4J95rWNkp+dO2gwvXqLG000eN+6WLjKuZxBKC584QsK18f6AFDA/PdBGAeyryCSdd+eH9DDKcYyCtpdzlYiiLo7AKbtyDFTpjYuD7pIM72b7xu97p26Je0eqUuiwd52IAL0OemnV9ek8h8G/3jJvvNCvn6MqQqEnpzjE81RdMWJRAWQZPD5nyhEK/SQ5h3ZE1dnSyloAgFbjJYe2I/BGJpLm6abFBr+Jqra92YWIVKnSaPOm3+V3B3S/fEdXbaBYamchXJFan1VP3ve5XZs7KJpViKfPt4l5hF53dKZzL0Ebrol8ZsEytqSmumC0MNu5ysKsGdEah+U7C3J72avhVfybwL4ndOIJBvc+3vUI5JLWP+2x/XUR6iiqnm2OvvDVsI9tRMOUvK6wf0lb9jb5tu1ElJKUic9oD6H58SPuAoZ4JR8L9ZhXT6u/Pp2ZpOZYo5GPzXrB9VSaXF0x51hioOydgDxf+H4Y777DxcefbJMO47gEkh1IiMvMgZdmDfIy8MzKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(2906002)(54906003)(8936002)(956004)(86362001)(2616005)(6512007)(316002)(6506007)(6666004)(66476007)(186003)(66556008)(966005)(6486002)(5660300002)(66946007)(36756003)(4326008)(38100700002)(508600001)(38350700002)(52116002)(1076003)(26005)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJjbW2k7NoRPE24CF8iS8TpOGwLH1ehIpft0tlAUBp0aG84GnRZWGWPBCtSz?=
 =?us-ascii?Q?SPYfMgQcKe5LAj0FjH7k/jfjOuQfiuLwg83TKyzJ6GvYjH09GaAO1xfi/CQ3?=
 =?us-ascii?Q?K2FmbPkzx2cUv6aUiiAd7JUxzocMRqOwotwJeHeuXByCpao/eHMXbZpJuNCR?=
 =?us-ascii?Q?dJiAAppleXgRp2gkSzuP+C4H0Krsy2i1r9EeEIA5CT6Cn2NfthgKcRQP43IK?=
 =?us-ascii?Q?usRA9CaBA5N3ScEXLvuXDyKez7BjHjAS5smOFBupm+4yjRcK6jIjr/AJ/dke?=
 =?us-ascii?Q?4GgXF8w7pwTGwY1Y0kbOiuqTDHcULiEdNrJkgMY/Ia46fYZhsGfcz03y33+i?=
 =?us-ascii?Q?86DIc2jeopbhhhaX9+fyCyRNZqujWtafhZbfJbENpA46ZFAHPvayCMy6M5d2?=
 =?us-ascii?Q?FqTmV/my4N2GK/B6t/c8rIhcDeig7nC7m4YNyDMvcVShaAZMxTrMemfCl9zy?=
 =?us-ascii?Q?A7ZeuKRUn+Z82HX3tXbk4dd/caiOfGnPiSzWrUGrxAXhR/xu3doDFmfNrwZZ?=
 =?us-ascii?Q?ArQwkw1cKm3B17Wvf3dXfuY4+QHdzjCAuW6+davc46eDtjCimbLLZlYt6ltY?=
 =?us-ascii?Q?iFDnxnIN/YoGJLmTSV/RcBiyUCQtOh/YG/kXCTULaMDjR3TD4/OHkkzjgwFM?=
 =?us-ascii?Q?mFsk2iqttcZTFq3HLV2mzvcDiCOoS22ZBWGwaCmlpilwD5P/137+4KUlImgd?=
 =?us-ascii?Q?sD0nZtAuy0i1b46Rrr4+JVkcf7/TMpceaUj6P+rZWmXTsjNnsy1PQx+oNjNH?=
 =?us-ascii?Q?YDk1dv4B+mADbyXcnX2r0StZWLRQzfkbK7vddMTGg7v9cSpzuh/oE5WsVdq6?=
 =?us-ascii?Q?hERtwOCSiwgmZhW9WG+b51w/jgcl+aPnxmC5kCLtryXVU7nwDIs2OfFpJG+l?=
 =?us-ascii?Q?JR5SksINWi9dJlSd9HfD3nPvVehhV45JWQEtalSIhy1YINryVM08SawKZJah?=
 =?us-ascii?Q?UU3LweATly1Jxdi05D+IMMP1gVhwUsNlPYlSMey3ECzm+jpacuU3K4hjDlrm?=
 =?us-ascii?Q?B3SQ77VDbREhcpgmwK7rDqRXjJJxoRcrg949t0iVQohY3taakmMMhXRpMPFr?=
 =?us-ascii?Q?gdVq/hwoOuP9omGBl/6itrWTMSeRSIxVoLJmMr/yODpRaQTN4CSxN79KB9pV?=
 =?us-ascii?Q?z2icrn8Bn/jIt/KN0f2eLb0AHvF+24wMAfN0Olj5qS36h/vyNWssNsVHfWhH?=
 =?us-ascii?Q?1QQyjElHGm8NMl1gIGW2R5MGNZ9tqEoJZVnswJ+75CdjHIGBBZ3mteTAWDni?=
 =?us-ascii?Q?fPQJncD/XY51QA3ndyAsiz+/mC8XbuPwbG9W/Sio9mfQjE51UlVkeiKqOEPE?=
 =?us-ascii?Q?geHQB4mnptVXqrdYu+FjW1stqQZ9rwJCR8o0O+Uev9X9t4h8U/R6QbxyKPji?=
 =?us-ascii?Q?dpWNunVecPuba2a3vcUvEy9QTWuCM6WMNRkW4l7poUwFbvG0qoCeBm7GdAqo?=
 =?us-ascii?Q?D7t1fhgNsTbsKXwGevxAyY8O79M6BBYApmNJtvnKuCdUM0uINCxbTAXrazEE?=
 =?us-ascii?Q?zSrvuw72ErnsbfQVXIH9msnIsIwcsorXqzhk4Xhxz7i+40PLlWMaGUo2M/0Y?=
 =?us-ascii?Q?fj9h2tw355fhB0csvk8EHNlfwqiOFIYpuHxY+r2Z+6mCLu6rl9IgjjgBvQio?=
 =?us-ascii?Q?HCulRa0zEduD7xXyp9W0ciHE02Yzyb/VCk+iIE2XzK+X65vhyy9YJCgfW6oM?=
 =?us-ascii?Q?IkFHUQ=3D=3D?=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f36f77b-40c2-43d5-e461-08d998549996
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 07:45:37.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ8RwQ5krzW0J5hMn2ZRUyISOlX0cyyQ1HW/uMHhQ9AXYXkppND5Bc7fybQY41dAQv6EiRESzlgYYkO6TsxM7SOEjzkTJuODt5ZLvMJ/2jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2535
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add initial bindings for max98520 audio amplifier

Signed-off-by: George Song <george.song@maximintegrated.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/maxim,max98520.yaml        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98520.yaml

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98520.yaml b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
new file mode 100644
index 000000000000..b6509cb2c8e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98520.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98520 Speaker Amplifier Driver
+
+maintainers:
+  - George Song <george.song@maximintegrated.com>
+
+properties:
+  compatible:
+    const: maxim,max98520
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      max98520: amplifier@38 {
+        compatible = "maxim,max98520";
+        reg = <0x38>;
+      };
+    };
+
-- 
2.25.1

