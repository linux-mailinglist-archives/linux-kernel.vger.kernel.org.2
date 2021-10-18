Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64D143123C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJRIic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:38:32 -0400
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com ([40.107.244.98]:57825
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbhJRIiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:38:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQVM/a2NJbtaLeBd3nUCTcoBLYZWkrn4iQWQgd9SOZkxiWN8+ia8uzH5QURZKwhhOvc0RcNmNHQe8y+EhmgL8ySpJhIUc3JXaZUKVmeSNaNu+7Wbc8+uLFhe7FxShPx1OHWoGIuyu6bNfKSIajKfJBgM22IsWKUY0Q1GMwyXANT7SbX7VmAoqwwZ35k43Vd9gZl9n6oSBSYJx1gwbHotZ00+E5fE4Tn1hdCfG86/HjF8sl1a75uT/bGPsAdw8GQ5zLY8cMdis1urVVqprdWsJsSNglgOyrTkLFzMAmmW1f/0eOuUHL1JyACJ5/WlpRzazQHUocq+yqIQ1jKIZrFOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9Bou5HF8PJcNrcYgfz9ANonmw6Iqu0si8sUnlS2HN8=;
 b=Zw6s0Db2TndZyaXBrpE1m/2UFsUvE+wHD8VrIiczXl+ZmSWFV0hd1xvXReYvtaA1dBHH7Ip+Iku75fBLgCwX+7dk1Z+jChHzO0AfHSylWl6FbZ265lt77q+ugAuBM85wFpSnuWwl40rZz8zTa68NvGpM14lJt0G+WOUiCNxNQUFFD3JirNoaTyr9+rb1XvLPrFRZl5ywW0B0rZAKRY9dTJiAcFhqQna5nbon2tsK3SG+jqvPj2yXBoYYgEK0s4438s88lMgVOuw+le1dgToxI2HKqrbeWc3+LeSPWFyrCgb9mHHY9F9L3yDiLgtanrEoZGe/bF880G3TUZ1WKMXbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9Bou5HF8PJcNrcYgfz9ANonmw6Iqu0si8sUnlS2HN8=;
 b=TSmYT3Jvtx6tD/AiKEW4ILiiOwoX25pi5GtZraOcNaLqZ+YZEYek1yA68TuTXQyBgv4bLORaEbqtBvdQdccjHKQ/M+rZKhGg7ywfiMr3fqWnkFFsfZ66xs5TGlaY9Zr33vpKPUD44EW18t02M3A7AiBNwn27HeNmpw7TLq/MtAw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
 by SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 08:36:10 +0000
Received: from BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94]) by BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 08:36:10 +0000
From:   George Song <george.song@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com,
        George Song <george.song@maximintegrated.com>
Subject: [v3 1/2] ASoC: dt-bindings: max98520: add initial bindings
Date:   Mon, 18 Oct 2021 17:35:53 +0900
Message-Id: <20211018083554.5360-1-george.song@maximintegrated.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SLXP216CA0004.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:6::14) To BYAPR11MB3671.namprd11.prod.outlook.com
 (2603:10b6:a03:b3::15)
MIME-Version: 1.0
Received: from SEL-LT-028891.maxim-ic.internal (223.62.219.217) by SLXP216CA0004.KORP216.PROD.OUTLOOK.COM (2603:1096:100:6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 08:36:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 334123b8-97d9-4185-ffbf-08d99212561c
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB513445FF803319F0C41B5DA8F4BC9@SJ0PR11MB5134.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gjZ2F+/MU0Zzal+wDJjcf0NEb1huAWfRUOmOnG4/HJJB9M84+1ZoPoqjud7a/46OF2T7aXd4LTXn8RBlzcm3hLqDD3ucOGxCxDSaphDKajNWzYAcJTMJOA6bP7E8lXA3i8toGcCW+tFQaYo4fD9+JLiUU4y0tPZXBdCLEof+dUH3SVnxQ9pY/M6aI7akQgkQnw8glFYK1ZO3PFfN8qnRN0wYLbt3LFIiB59Ypcw8MkCvAUonspx6dXU1F9hXkMaJuPPtC+ATqLXCuBggVyzYxmAUawBClSoSM5TANItptAnKRLw7k+Kae5v8BkbxXP2grNdC2iUYsirlQPMqztfEOkJqB/2LfeH/hUMmBwka7AEBIlLs6rR0vPgJ7XgnIdDwQaohOOGy8YZOJLsljb6U6kwlt56TeiswOGh4jGUuKPHNu4i4os/Nvr+8FuPfaQq2etk3sRsq3s3r6d/WyI+UjcmD5RHjRcggisAgRO5VeNAFjMlE6lKTmj0cwp72igItQO7MaBYZdhzENMBjkl5X2zeaxmhK9gAMRuITPsGGdIQWlJC3i3GyIJMYFqwx4MGJ9r7miP8mU88tAk/abSuGb4slO6+Wh8Xq4D1ecwQcv7Zy6GgjfIi3jrjS9SlM8kRAtG10ytg5jG6Uxm172af2kAu7XeUW6rmnanh420ENB6H0pmw2InO9h1+8HrJ4yzFIn0cgU4Y9/mwMgVi9+MaWZTAsx7jivCcDiC6SXEqJDALzFq/+XKzgFsvA8BnsM1lwbPDEttbHUSiUuaa7ZAGmYc2iBjtCA7nv5/2QFR21vBygF1SCUWMJaL9NkWjyrxT89+j6NPQ/l3EeMLLksPeWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(26005)(6506007)(38100700002)(6512007)(66556008)(2616005)(66476007)(44832011)(38350700002)(52116002)(966005)(36756003)(6486002)(956004)(1076003)(4326008)(86362001)(186003)(107886003)(5660300002)(508600001)(316002)(2906002)(6666004)(66946007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XK1ZrYRmHJgZPq4+zXOS9RCtO0EA3zLjhnc9AMnC8nypEWxGfxP8+suvdsY?=
 =?us-ascii?Q?NI4VcJtIgoWrqDNcIt6cabd7SiI+QC1MqnX5RfFP8DwLrTV6m6HqY3o2VzOM?=
 =?us-ascii?Q?CdnTApA5y0XkN9r4haL4o1yXWKe0PeYBYHL8M3n/DUWtyLsR4ovrXiPn3F4Y?=
 =?us-ascii?Q?7pHzPJk7gqRYi6vZ9ddjhDwWIITD46XnIIZ40QKO2lGuyNqRru6fgC2PJfHb?=
 =?us-ascii?Q?lqxCJdoTYIppf2OQTljZOHcCaFsohPHh2zUIEevPVl/+tEhSF3M3EOcUy6kM?=
 =?us-ascii?Q?GSPOJ2SOQ77q5C1qtSm5x1UOYHWl+MCzY0HTlRpvGWIjW/5FJx2PV4Lo0wN2?=
 =?us-ascii?Q?8lQJW2OQ+sEa2ukbztTHM0RuuoryZYmAjyhin7QPlwES/QfEb4Q5CXNcjP9S?=
 =?us-ascii?Q?OCfOG4Bham8G6Ag/DRrSkV17MyusnB5EgBHr9ACIzRVRUa6vp+/uafi9umK8?=
 =?us-ascii?Q?rsR/tT1J4FZOIuqypmE/i4ZMny13fysJua897uDaRiCTgfVd5Hp3JBwLl67Z?=
 =?us-ascii?Q?ytKFBmOUtsFctcuvOAfNWM/vRdyw3VbPhIdaKMddqXPmyiPlSsLCyt75Vrbt?=
 =?us-ascii?Q?LH3SoDNKRF+vwZhOTOeAl1rSkmSJgNZU0gj0E6Tvl1GzCtuj24NgpwFzwOCJ?=
 =?us-ascii?Q?M5Bvis51eg4fN2r1fT+ywbhXvY5WOAP2Ts2A0x1gO/N7VcKPkhoixC3LH8yG?=
 =?us-ascii?Q?m2DGkDRkPp2FCYceSYOsXU0picYtYM6tKM4KlUXKG8E/haAa9hlmvf0D/ISD?=
 =?us-ascii?Q?ep8/M5/5RjmecJCaeVPk2cV+WIWljQ5oPJp6C8pL5qi23Qyku0AymxCOjrb5?=
 =?us-ascii?Q?Bhadi8aOKW4gcgrHYRscBOOxmToVzNWelIQ9Uppgp8xEEHLKq5LhDoWMq0aU?=
 =?us-ascii?Q?Qmv4GgrcHyAC0pShF8x9F66WULx8CPEVr9U15FdacfFMM0H+t9Xj4AuXwzzO?=
 =?us-ascii?Q?140U1d9rndUPVnh1CDWfnNDNeOtjRqNtZy+4WemJhrwTXpTAGgvu/sPyyEsv?=
 =?us-ascii?Q?7U1C0nBf6Iy4oEBBQK37OLUFmmWk+egjcHUryeq8AY11cIah+6siC0A2b9/P?=
 =?us-ascii?Q?2S15K1sjEjGMiXZMQMc22OG9VVkvK0LlVZhq0osQRPWIcGjWLvlWkcpAIpDe?=
 =?us-ascii?Q?VsyJhWv+vFOBJom46n1z8khtfusewpSH/t1SPPVHYTPmeC+yd0ooO5gPOVFM?=
 =?us-ascii?Q?xxeG7dduT06dhiXhGeCBfXpySk+QxmdvZqVsjbRXIc0gyICE2h3PfMFBfKE8?=
 =?us-ascii?Q?ZD2tmydzxvKPqk3KbRFw/wuokyQ7iVBuCOzaNRZr6wjYhSG5zVtwD9GmPqXx?=
 =?us-ascii?Q?Q1HOwxi6Bn+t+47K0ZKDtEbK?=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334123b8-97d9-4185-ffbf-08d99212561c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 08:36:10.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG75M5Ex4pz22UaUcXUvaCXlqQ6MemITtspKgl5WYIfgp3dC5kFA5PdWCEHMguAIlS/sW7VDDvEOc1qppOc3TJ9aL5uQ5YBRvoip/7iVNlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add initial bindings for max98520 audio amplifier

Signed-off-by: George Song <george.song@maximintegrated.com>
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

