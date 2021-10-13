Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57DF42C531
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhJMPvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:51:39 -0400
Received: from mail-sn1anam02on2118.outbound.protection.outlook.com ([40.107.96.118]:55106
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230126AbhJMPvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMWo2lMpL1FDdX5xJHAHhIEDzqMUD/lPWeSSVAs+hb1S1uEru4j8lfleGkuc5fVXJjRfSxDPTkp7Ke+Wmuj2lHUXUMW5N4xbnSm818Fj4pQsKIcPqCTDqUssyLNZz/4SpALQn5HyRTmlQFzVXZE8e2WYVI+alXaAvKjNncTzgX1ogrKrNR5PamaUtHn+L5rHBALA1cHzvz2RCCLMd6w464hNWOuAbRu/mz7uKdNEhGQeUxA12jFyK0NjbwZBFyl+IXCs5Jw8y3HG3p/t8A/RMmCf2ieAlNWEQoK0f9Zny/A8leoGL0dWGPX3Hw8gj9YQgtuRmligFf8HPRVrrPRQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La34/O3WvR6kvbyW8Goi0pHAyngN589Baa/sDidzzd4=;
 b=AK52t1vzoYVRL1gpyy/J3ZeGR57pTdT/INuDdRJWBCieKi7Aut1rAgLcbwBdrlGZ6RRGtNcO6WX8R0sYbzQGChxdQEKiVkErmVFz/8NY67a98CuPidNGU3aqcOImBG8uEjroGxf0/T5yne0Ew5kUD9VG8KwtOP1tkHbyYKVTGtV9RsItBvQxZThbck2NW04UZ55UjrO/S41QZVlOIHZ0kuMREPExiUCqcoVfD3oVtcThojx7JAMUaUfnJKzHG17eVRYpBhyJ0ZUvD2PXuw6DDVwDKNSvrjobP7FuuQQtZ4H5S/FS+kDOPBX3BatPtWu7sCHD6s3THREl2XTxznNEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La34/O3WvR6kvbyW8Goi0pHAyngN589Baa/sDidzzd4=;
 b=QbepseX8VUSlP1t2WJ0WHjKW5uxbYBVCi8KWH/QJnQFR5GYAGFWdbm3ZlLAyo8LIOyzqtTibOj3ipnNRVWPkdgFzHAMchin81zF8dJSgblpXi2OWrXmFb5uroA+yg7yIWEs0mnjtkZKzwVzokznzyj0jkHfFHjRRHkjsmQzU0os=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from MN2PR11MB3678.namprd11.prod.outlook.com (2603:10b6:208:f8::11)
 by BL1PR11MB5336.namprd11.prod.outlook.com (2603:10b6:208:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 15:49:31 +0000
Received: from MN2PR11MB3678.namprd11.prod.outlook.com
 ([fe80::fc11:3689:b9ad:4bfc]) by MN2PR11MB3678.namprd11.prod.outlook.com
 ([fe80::fc11:3689:b9ad:4bfc%7]) with mapi id 15.20.4587.027; Wed, 13 Oct 2021
 15:49:31 +0000
From:   George Song <george.song@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@analog.com, steves.lee@maximintegrated.com
Subject: [PATCH 1/2] ASoC: dt-bindings: max98520: Add initial bindings
Date:   Thu, 14 Oct 2021 00:49:15 +0900
Message-Id: <20211013154916.1258-1-george.song@maximintegrated.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SLXP216CA0070.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:5::32) To MN2PR11MB3678.namprd11.prod.outlook.com
 (2603:10b6:208:f8::11)
MIME-Version: 1.0
Received: from SEL-LT-028891.maxim-ic.internal (39.117.232.232) by SLXP216CA0070.KORP216.PROD.OUTLOOK.COM (2603:1096:100:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:49:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f6ab8af-7121-4226-463b-08d98e610bb2
X-MS-TrafficTypeDiagnostic: BL1PR11MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR11MB5336234302FEB89B4A455090F4B79@BL1PR11MB5336.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dTEvWwCxDmOvgo/SbLU3FzINq0xincoN3+d8JGK5a3jmLkA3P8Ra3DCkcz3a2tXwcUnjaUZTLrX4aYYAxiJn3HT5QwOAgCjcktp5Pfdq1fmMbO6smuv5Z9116PtmuM3ulplVxMlaQFBzFXJSjC9QtMWOrDW8FeybFA4zTIH6LAWc2L+tfOIRNbm9PLXmb/uX23YehsvRBQQnRfFzLRtqEDHUp8QN/jt48q15zXBEFGV0yexJv/xCxgpUT81XBSTtwVM+RFQcbU9VOrMOonRjiRDFyJ8Uta7KvCNFToOiHfcYkbwr5OHUASNijoKkuZATCiHG5Xq939pnVXpZ+AIUQ5/rPqMpl3wxQg6ooS35ZJKoQ57edJoBX51gb2dpLbf2EriKS8oBCjmr6VW6EepUO7o+Ax4Q6eWA3nqkhfnmvlWboDCE8qGzXlbESlqb+1txZodSz4W6Bc1C5j/9Iq4YXNbyAxBsTGNpeOR30ZLfqWRvwWJfI569D2aJWLn4QI6aS000sD3igvbmqiKd4Kslyb74o7Kycc/C/Q1psYqlM0R0TjNCyLKgBvMuxiHQK5F9z7GMMA9agPNYmxkJwCaS0ynOFLdBp6f87PWl7qyi5zd4JMe4cEdteYAvBr4vjymjK6kN8mcW16r0G7w2N1ddK6nhmK2R2HgdstmwWuzb/gV3bFbq2L2Nx+WJMlTm27794+mwTgPFoieAUoWTmMnS4j5Ulnm0K/Dr9Zqu8yhKIEamgYggKvg99nZmIvWiK9YImVFqv2y3P5JfZ6lmD8kHcyj90YO+CaUwFKMsRJyPIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6666004)(6512007)(1076003)(26005)(2616005)(36756003)(8936002)(52116002)(8676002)(44832011)(38100700002)(38350700002)(4326008)(186003)(86362001)(316002)(107886003)(966005)(66476007)(66556008)(66946007)(508600001)(6506007)(6486002)(956004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8y8j2brnbJngpl5uuU/ZbCY0P+N0++/x5dVqjMBRx5N1+dRlFXc/matZuln1?=
 =?us-ascii?Q?kQE44luZV0UCzgqTBfy227X1qC7kxQZ4vgI8X3JC1adaUrapa3qd03rUjxQT?=
 =?us-ascii?Q?6dZqTUVcUGfMFJWaxoYubGknRfXFwSUktqBIKE17z0x4VUBG2SIzQALjSYHn?=
 =?us-ascii?Q?YXo0G4/sytVVGJPVxtcXT0GxVy3xBEvf7j10UDsaN0AwQROTHekxRaXvAY+g?=
 =?us-ascii?Q?i+YfkNksJ05LnyC+atqiuDN0D2xYymGxGDPUq1pMUjDYDgA7FjVClgGTOOw2?=
 =?us-ascii?Q?OiNhVpVeWQB1mCLgjhnZ8gY+MM9KqAVNEEX0n/O3CSpYIo92gJ3UqcBv4xRw?=
 =?us-ascii?Q?uyo+RzhGmaQIflb78ll9lUU4FeDG3I4yqqiHCNEe17y6cIKm28h1JEQg+epO?=
 =?us-ascii?Q?PTgqwNTe1kc8ldh9H2HTDMZU9PU2GC4xmvxPMiskn694Y7b4xUWw/VUZrwEc?=
 =?us-ascii?Q?tTIfjtxURn4DcNQspmp8a4u6D5gL2porgVKYoGdslQBzt/2LYsF/wgsuUhB/?=
 =?us-ascii?Q?v74zwwAowGTo4bmH86KqMWgD9PQuMCn5Dvfs2R4APYU9WJP3FXHdVXNbLpE8?=
 =?us-ascii?Q?SSkeynEsT7+nEawQGeq9TmeNXbmFbARglzbDn/ORu2bjWubrMqspMTUbyhCi?=
 =?us-ascii?Q?nraYwMta0EjVJUAV0fytmrL5HwScmklfI/7sLRQOcdolRy9N2i83UU1MsWfN?=
 =?us-ascii?Q?/+sZwT8F+x+OneMbjEcPomvU8X3fbzP2TfCHiPvFiDaPkUCo8FsQp8Ej7r6w?=
 =?us-ascii?Q?QVDGclrR+DOM711HJPnK/vAn082Urwwy5Ezp7aOanS1RgPUqj4FrI1dijrkz?=
 =?us-ascii?Q?uflOdKEfdEJtrkU6BeT0WG7KbM7cg8UP4Ke7AywtdqgiFa4XFRrwbiQYbfzO?=
 =?us-ascii?Q?T11GzJlP0whmqZTf7HP3DDAXggtZN9LEC4mt8dVxAhY3YyOMOlXQli2U2RDm?=
 =?us-ascii?Q?9wKTbA8vP5XNaD7HQ/JYpogdV5YKfGxYSqfEvVf2NjjXh/mAxIITJ959sOMd?=
 =?us-ascii?Q?s4I69ANZHT/RndTms5+jIB+0Ncm9AUOzjjTgxODuqfQCO9m2ZZaZ/t+rP1YE?=
 =?us-ascii?Q?qU6MSpUj7rrodiL+ALgdzLQcGzT1gcBObkHqKCMEIlKTH+pEtbG55oUGABKe?=
 =?us-ascii?Q?44eGuuuKZoSIpbw46zpWi9lXQLPj/z73hdyNKSkWayFE9BdfkTcwxdPdFB1R?=
 =?us-ascii?Q?3+3LGlgufuD/1MlNWl+lPuyUWCdvnRBWWJbmaFJpuDPH5Do/inknPPzux31T?=
 =?us-ascii?Q?GiiPJn/FNZFM3MIMQSw+0BIRBJ5IJk8umBVDV5h+pGnIkg7iuJd3R8sdf0fN?=
 =?us-ascii?Q?nu1IF+omT/IjGXDF6j4Lese6?=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6ab8af-7121-4226-463b-08d98e610bb2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:49:31.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKLZzqLzF382uHihDl3c43xt9IvadK47MFCNw0qjck0qVF9X0CSS/6kLbubANOB5Aw1DiINQQpQNsegQdctoZBpbNHeU07+WR6Awf86gHI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Song <george.song@analog.com>

Add initial bindings for max98520 audio amplifier

Signed-off-by: George Song <george.song@analog.com>
---
 .../bindings/sound/maxim,max98520.yaml        | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98520.yaml

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98520.yaml b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
new file mode 100644
index 000000000000..d1f2b5ee775a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98520.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98520 Speaker Amplifier Driver
+
+maintainers:
+  - George Song <George.song@analog.com>
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
-- 
2.25.1

