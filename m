Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5342C553
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhJMPyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:54:23 -0400
Received: from mail-dm6nam08on2108.outbound.protection.outlook.com ([40.107.102.108]:57696
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbhJMPyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:54:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Tne0s/2GPuKplhuDF+2NMocnoIscrzM+UdQarjhlEoqhqVfGssWoA+3K/glIljNq8dX1VqCbMCh0WudHxnLic4LcvevqbPfXSGuQEn7jey0zyHSFzbfJ0qvcSafxz72ckqBPglkfXlC/lV5s0Js0tL+eAvrL9TZsd6yy2suw2fQZsEpYc1TdG3x50dpUmhupdBOWTYPq6Yovb61kIeHbZWGtO8ZTMSkyY6pA6imBIKD5trhRSwhxQVJhTmWIrKntYMGYMEu8d4I8SgKuAsiOg8X6qBVUUqX2/Av6m/c0MV0N+d3EcPQmM74Z+Pxfc3YIfOmqv5RB9lOxZXDi9uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La34/O3WvR6kvbyW8Goi0pHAyngN589Baa/sDidzzd4=;
 b=GoNmJoEarvvdGHcq8Ox9ZpBso4qnUZJ1MpQowHfNG7IF0YbvZ/Xxl7N7pMRs6KALMSXYZMEC3V1k2ZXObZBcD59Iufeq0bdWCneFtkZeHFwvm19HF7kxM+9h235szzKs+5fkfjg5KX33IyXAuRFQXeLyAJ/bPK/xtMj0Y8lZf4eYtew799gmlWM5qgidMrNZZMrVd8RfvRK7X5VVsgZ0WF207S8Oo2Vk1gbTjEXunCe8U0X+PnDSHULwDR685wuRooWeNuui/UKLr+Z1cxIcmlJfdCKUwDYpRcAp2Tvsaa7saBWXtX2z3GgkNbGksltRKFbUWKvNDdMfhWajWI2SFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La34/O3WvR6kvbyW8Goi0pHAyngN589Baa/sDidzzd4=;
 b=UZIk0dWS9u3Uw6a2Dn0KKnf8ILc9dsvI2RBJEFedJFq41tWLt1ywA4POXrEo+61WtJnymdn1QK2Y4VijTzhwZ/5kGwOe09p41oz9wJ67YixYtvMR8uUBgUDchs2KtFeCb5d8fp2eRHsmZ09I84/++2FquRMplFswQ96mIMqBG/A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from MN2PR11MB3678.namprd11.prod.outlook.com (2603:10b6:208:f8::11)
 by MN2PR11MB3694.namprd11.prod.outlook.com (2603:10b6:208:f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Wed, 13 Oct
 2021 15:52:13 +0000
Received: from MN2PR11MB3678.namprd11.prod.outlook.com
 ([fe80::fc11:3689:b9ad:4bfc]) by MN2PR11MB3678.namprd11.prod.outlook.com
 ([fe80::fc11:3689:b9ad:4bfc%7]) with mapi id 15.20.4587.027; Wed, 13 Oct 2021
 15:52:13 +0000
From:   George Song <george.song@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com
Subject: [PATCH 1/2] ASoC: dt-bindings: max98520: Add initial bindings
Date:   Thu, 14 Oct 2021 00:51:57 +0900
Message-Id: <20211013155158.1311-1-george.song@maximintegrated.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0123.KORP216.PROD.OUTLOOK.COM (2603:1096:101::20)
 To MN2PR11MB3678.namprd11.prod.outlook.com (2603:10b6:208:f8::11)
MIME-Version: 1.0
Received: from SEL-LT-028891.maxim-ic.internal (39.117.232.232) by SL2P216CA0123.KORP216.PROD.OUTLOOK.COM (2603:1096:101::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:52:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05cb2f94-e9fd-4cd7-8a99-08d98e616c5c
X-MS-TrafficTypeDiagnostic: MN2PR11MB3694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR11MB3694EBF9FF66FFCD3AEDF4F8F4B79@MN2PR11MB3694.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwS4kofPZKRt5HwjlJ2toK7U5aoYhSqhfOI0xaLlFnywLuQGBCP0hq4FxumC3RNnmA1LSB7Vg/lioKlVd0eT+R5cXqIgpkeBwnHXdfygptQeWPbDXyQeTmxpfZND0p7ewCQ21ow/vdChQr5rumxFRr0X5Ujp34SiamhpC/5ihaSWKqEa0yVxYwf0cGs/hoQEUp0TnLHtlxrUHI95MpT0VcJBgqK4lGFzigDWSoDXwvoeHbtR81T78OdoCSDJJD5gNfbkGQS/3pqUBtcUA5fOznLaeisT1dEYX9JLoN54vN6F6/XolOmWpK15xjXRs6p5BfPm548hKEbTCSWJhNEUPpH6QX7Vn74XSy0pA4b1jLKqC3mbwWFjN8K8UMDTYqc6k83Fh26fHh/Gmx0tpfSfD0GcyBVI9P874MnhKYvxS8i4L9Xi0PR4nFp+w/sJaFTvQNedqOsofUXvmERq6wvVyRHyIKEJU1c3+jHp+m1B/9PgtQ3OF5ZopM3gqmFdyRrIYAeVj1tlESLwN35IHA9MkKc2qMii9CI3bBITaIHkcA0Habvo9d8wgIj0X3YF0MWDRT/1KTC9W2SnNiqokFr0GJMl72YyyZjsAvFM0x0sZvi84DuQGgxCohY3ZgK/905DUGMc4Ii/NrHLI7ALvGqyF4BAdywgrtF8RvX/yanhdps0N58oQ7IWlahcT2UljbbrzoHhma5cSxDEwwM3Ki6lYtebQ/7m6dCgRITTXQKEpt3mS694cBiBAsGewcD8BtVxSA++cf2dt2Eq302wY3coXN5zxir+b2/6YoSXJza6SF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(86362001)(38100700002)(4326008)(107886003)(508600001)(44832011)(6486002)(316002)(966005)(1076003)(2906002)(6506007)(6512007)(8936002)(66946007)(66556008)(6666004)(5660300002)(66476007)(186003)(8676002)(36756003)(52116002)(2616005)(26005)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUGHFUj8nbHPeSap1AHtYJc6V9vIctjA/FI7H47912xcStawvj5nyAezyTNm?=
 =?us-ascii?Q?kyPl4cUv61qvhK5iDU+eJ7UK724V0Ci9PW+tJPcoW9PMLwjWYg1XRpSRC9+q?=
 =?us-ascii?Q?9Zy4V21Z5MH5kBzjKg9QyekYDA00WYaS7+mxsyjTjqQNAUxm6h++XJiQHyBy?=
 =?us-ascii?Q?6qCdPRweKCE2OhhUoJHx4He0/ODf9ifCJAf8nBsD6ZxZJoEbGzCpMd66vP3/?=
 =?us-ascii?Q?Cc4uyNSezu55bBFUybl581zY6uOQwpGS5xi30raYlldDBycGwJG+W5msJGQX?=
 =?us-ascii?Q?jSoAuBZa8jmhjugrolaZJttRJvT9TMgcnnR/Ge6Nrb7uNXAoapu6KFjpyViy?=
 =?us-ascii?Q?Y6krEFy2XnguqlavGYBfu+RZvvew6N8JblVYdkpou58IG4omreX/n3/W31h0?=
 =?us-ascii?Q?Jcjx/hzhQtZUnnIURv6tyIKvlSon728+RIUkEpL8O6nqJDCzfBvXGtFTHmez?=
 =?us-ascii?Q?zXzhj8ABzeRVlMkKxmaDarMVUG41zabBFfXqgfVV4hSvYFhDBlIYhrj6DXR8?=
 =?us-ascii?Q?VOjk3weX/rYEuU/mv6VszwqRMe0qKBJ+sQd7Sj2kEg7nwkGVyvisPgSb2OTI?=
 =?us-ascii?Q?hbEg29lNcHH/5Jk6NFvqC2dlz3LZTu8k+CAdcZ2npqGjXzPUt2Hfq0t547ht?=
 =?us-ascii?Q?+5UPWdcmT02yjxNqehpa2FTtsxffwuJ7SDmYewidEAzhKr9+WbPIyJLCUZL6?=
 =?us-ascii?Q?UZDtJC5OzZegibK88eUmv97Fytif8GlqV7FfIkU8nL7Pd70KKraqy8AB5Nnb?=
 =?us-ascii?Q?y3cLcOwtOOMAOPv3X6dkaBz/qjDl3w1b+FHqpVOIPVW0DYv8UcZ3Y+088i93?=
 =?us-ascii?Q?gy8B9wH/YbFUvDNvWPbuhAsOZEdJFQFHRKms3LqV7uyaQUkeKU2TAxH5l1dR?=
 =?us-ascii?Q?8MOFY1y/AdhpdaJgbrJcvinynkwgu3TIg43VLqe/Cv4fogD3PwvpTrDi7RbO?=
 =?us-ascii?Q?HgMDuWpie+ycqDfsVIjYImzFA0fXKmAGaNEmkZfQPC/RQ6W4HLWMaddAEM4h?=
 =?us-ascii?Q?cW9rYFXVcDiZtHTtgWvMK+DR2Bp3fNrYRQozlsfp9dXcQIMTiR94n7Rx9Kfi?=
 =?us-ascii?Q?GhywxjoHzlTsMAgYJqytC25rPs1YELYCdAHpmhAD5yoMADedD/Aj7+uRcIpw?=
 =?us-ascii?Q?ww1gDe/UJ7JTGjnq6HRMxdVcr7Jy+lqaX58H+Jwldyfb4wTAKpngF7ghFyli?=
 =?us-ascii?Q?WzBLM6zBO3uyNOvJhMyn3muTxTgoC69wtLkrgxbTHHjDIj/+uBTa73ZGcgZ7?=
 =?us-ascii?Q?C5T8KfDY8Ia8f2aqJjti+MJQNHHdjYZkFK3LreWmSz3Fi+5uxET6vJYyCqFc?=
 =?us-ascii?Q?WX6eUzs4DngapmIcZUKH3YIt?=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cb2f94-e9fd-4cd7-8a99-08d98e616c5c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:52:13.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZlh/vHKfS4a6HJws3U30duPeBXWv1/oMrvut4cKXAFkQaXYc3Gro8lJH/9wEVdHnjmyyA5nA/7CYCzcPaXbKPrehkKx6R2TtjvAFzTT1w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3694
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

