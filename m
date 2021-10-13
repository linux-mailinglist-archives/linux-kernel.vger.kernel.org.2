Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4942B99F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbhJMHyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:54:07 -0400
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:7884
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238531AbhJMHyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaaZu5lalvCJp8AgMuoMSphTxusSCdXqT93xgXZFCnzS71qr6k1/+2n9NwJxTJ+npZcw94evmZAb31ClOgl7Nj6M8GsKH2vBqsPCDq8AzormJNtS6VhKyu4oe9xQFlBvt/pPfGyauVQQebF8GRZVH5CdJ9Nq3G6CwcGs4eIu5yky8L1IkxYyty6b3voOjwbFQQR+1/m+am9Ts+Q5ULhAXnuFwNH0CBgQPcUwW9rRO/MgfYsPfc98PqnnvDh05vfJjXzu3IwG20O0qoNbJuOE8Azs1hvz7AoI8Ql5lLN4JFlA+75Zjv2qRKM0VCs5UBOIJE6GS8LqjlPYnCmPjnMvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW2zilmT2GRFLxCp/iA6t8ky1njObI9xGPBY8OAIvJk=;
 b=bJLyJNH4eXAwXN8SCqPIPKD+TNruIDbM+iKC19B3s6iLDjNAxMPn+UTA05XOHFzz7DX2NBUcQ1myheR6O11kQs10RtEI0hlI2x73bivKZ5lDCl07G6XjZ3JBhQJ0s8L3tErJB9gHg9YfWtg7iUFnZ+MszyuSEylJ0/pUsziBVQkebRPPrsf18HgMfWkpqR47jblQT68eRWg1YCj9vYeIePaQ8L1ATJbEwcNVFhLhguSZinI74mbbFbsYwLVN1QozFK1xIPRlTdjx/GQUs+dJ9J3xk6LEDMMCq0V0W1wRqSJTOqceim7SC1vrxig6Z33kFfNBrMpUfDV+IjxdA7TAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW2zilmT2GRFLxCp/iA6t8ky1njObI9xGPBY8OAIvJk=;
 b=WPlppYF3CviTrCTG6cSeIALvsQQPHzZXyQ0dyyYMA5N4sus+xxvx6LDyRQmvBR8eNQ5dik2jq7rdAvmVgqRPndVeK+DaAdAOUuHiiJjC8wdUpg1TR7eiZ77I6427p0V0Ojd6hf19MFYzy/SXkib1RegBhpCpVBFr1Y4qrJcv2Yc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
 by BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 07:51:57 +0000
Received: from BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94]) by BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94%6]) with mapi id 15.20.4587.030; Wed, 13 Oct 2021
 07:51:57 +0000
From:   George Song <george.song@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        george.song@maximintegrated.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     George Song <george.song@analog.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: max98520: Add initial bindings
Date:   Wed, 13 Oct 2021 16:51:44 +0900
Message-Id: <20211013075144.19245-1-george.song@maximintegrated.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0076.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::9)
 To BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
MIME-Version: 1.0
Received: from SEL-LT-028891.maxim-ic.internal (223.38.27.165) by SL2P216CA0076.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 07:51:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f39c126-6932-48ef-0fe8-08d98e1e54c8
X-MS-TrafficTypeDiagnostic: BYAPR11MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB2808B3C08AE2FF747051E558F4B79@BYAPR11MB2808.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+xWj9dGBgwgMQ6SNF44Pxp1Zvft1exKyYCQ+1qZqg98M7ZBumQMWlWE5z33M3DC+yA2lMeLMc/tIruaM4qS4QIRL7JovSuYVNOPLQl/3vv8TEn1BvAT65Ae9HpQMEkVnA8uJveoZK8M/L4kxM0Bh7TESABfTUPM6lho/x2dd/tCQDcbrCjDewub6al3FWIhr4tJDFsdkoQZwSZhSy2VaJiIqJxwFxyQmgvj58xbwqw7IUKEE08+9phK/Y/h+iCa1qSpyRC+vgbpQndUP1STAN9jnonRHatgRaeCku//VOkysrpSAxnN8fAqQzXdi9K47hoJ9oK9Kc5ltn0w0vxXUgYG+flPy8CTwK65FXGG9F35JDsQ8w5Uujb5lvywDEqf6BFp6S+2zC+n0jUgmjzdCRNQ0JCh6DozkVEM6vJ7jYiMtekKYIJevFW4ZHg4+0lmZAsVXsMPyzkBkp0Hzmmrw1EaFruWKGxYm8hdGNtswNzsCuP4utfAPumNZO56Asm2og59G7jKSeamHY/fjrbYIpgUn7F4LhZE8jplfAmZ/UB2px/xtWnlsAVMylSDNhN4397qM09TaD5lIaf9+p/WjxGN3m1/YjPL0BRqOMy2pjWuwqGRaF9bLn78M8JWkHk41Sy8odfIk9I7JJB6r53B/t0iLVT1o8QLq63F+U4haqlqbwXyn4rYoDBQGP1bkR5aVBFvkQHwWu4fS6W6hGIjw/Ft0bb03l1ukhiTCcQ3JF/sPw9RKegsv5KbZcFX6GAv65tFpA1hotNNMFOVWZA3lmEYA/djpWnYUG4GnxS0OjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6512007)(66946007)(66476007)(38350700002)(38100700002)(508600001)(1076003)(66556008)(316002)(44832011)(2616005)(26005)(86362001)(6666004)(8676002)(4326008)(52116002)(5660300002)(6486002)(186003)(956004)(8936002)(36756003)(966005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83Ch9C6Kxv663QChWn98bFv7STSB0dVC0c8KtozdIVif11uGpxrSSkVDDu1m?=
 =?us-ascii?Q?YOEMIFMmDgOd3NHMiO/FG7BcoXVERdaYglRNriW8Daz5oiORGEOZG5y4YlgH?=
 =?us-ascii?Q?8SEU8DyAQbuAPdVWtzzrkMeIl1IEUgHyAZNCRf8wkmdJGMH3/vfFTK0o/1g2?=
 =?us-ascii?Q?kK0DRlBmYjXmdI9UjuRcA+yXhdAmXQVksQB6mSN6tivjvPgjqA7O1xKWBCP4?=
 =?us-ascii?Q?a665GLPs7wKN7zXK9CRhsn0qnDkFzIQ/G/ca5nDOkOiQMw71Q1b8YyDO2ur6?=
 =?us-ascii?Q?ipSH3WsB9JoCQgdtWjvwSeAcylfKkmziYGhp+XACsZBBl/PVtYTtIcQtosMz?=
 =?us-ascii?Q?rb+NxD6q1TyYUqwNFtGwUvRzEP/oDGW0qT3sqwiRKzVUuFnZusA6Fr8DcB89?=
 =?us-ascii?Q?loPm21/yUfQ4OAaQZJzItf8HaPm7gfYO7GXergI/TO3v7ydULif1hPtaVts/?=
 =?us-ascii?Q?CG0+/p5Xiwu/pVPiv+ir+Itc++uecVqf7ay3DJYr+rgXrxaCYpBt0WmtfAqC?=
 =?us-ascii?Q?eqzjGDtch32INuo+N92K7QsGQeFti0fMYhIkmogOeAEfydUYa0BZskkJunjY?=
 =?us-ascii?Q?xBH0BLw9WFwoY+H+jLe6O43D5aL+NirNn0JbJY6aC9FduXpkCqHkRBf7bMV6?=
 =?us-ascii?Q?eyO3IRbk06Hd1AHjz243AFLUj6HC+d52YgHNNkK7uJex0B8YaD8f9MlTvw15?=
 =?us-ascii?Q?xvc6/9VJ4M9PLujwdQLdY9sbWHf7IMPKauLg2te7Apn64BPYDgUxfspDpMb9?=
 =?us-ascii?Q?i4jL88fMjnn2eU8A2R+wsqHacw+jSSTcXiK/1BTYp7bJpOzHF7MA2RQ/PVLu?=
 =?us-ascii?Q?t1Asu3EXECmXy+FfOMXdVnCBoTdqhnkG9MKYn/hHFiKKOUG+sYHSpOnmlosw?=
 =?us-ascii?Q?fE0RQ0aLAxbUdNYLe+j5QdoES7Ghfs5gb9NmxE5DDHLFrnLpCad3Fao6kstU?=
 =?us-ascii?Q?/8PiGYbX1GwTRx5AP3XS8kVtYmTuziFrTg4sud+Tznd34bAwQgSV0BRxStZ5?=
 =?us-ascii?Q?Nw5wgpcKpCIOi6vpRLDMglRvgEYMntAoc0ieqrdz+Kq7YbaZyG8rtrSzMQSJ?=
 =?us-ascii?Q?+k5thJsxnRtQ/IpVDHLfcq00msFf2sUZ/MWrP6f6XqSsNQCSDTJ/XToF4sy8?=
 =?us-ascii?Q?myjzemPyj2ZUhixoQnE0YE+f78aTqu0rle6tTeY+YTF6rThb39vCl+Mpgjbd?=
 =?us-ascii?Q?kHiForJmVDk8hxemtXpg0c1pUctb5FrOwxIwe//Zf2e8vmPYvFuPJTcRh6vi?=
 =?us-ascii?Q?JXOqWdd0WxtdGD+oV7eoFMoeoZBCMrPUbxRCgrbW8T27DVW4AeUT8AuxfBfO?=
 =?us-ascii?Q?w5h9Q/3d1PHnzRpXqwW/gSuW?=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f39c126-6932-48ef-0fe8-08d98e1e54c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:51:57.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eH4hTRG2fH5L3E+GbZA+puYnOZsW+0qvX6AGhqunDFo9ZPlElEeGFqFrzSCQtFMfQufUf+KhLuLy9oTxjY1d5jjlJwCnlWKxFetHBwsfATE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2808
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

