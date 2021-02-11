Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55859318970
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhBKL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhBKK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:56:46 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0719.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9828AC061756;
        Thu, 11 Feb 2021 02:56:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORWvq3bhGsnrbYbWykMXlk7AUrp7gwdScmejEWpDXJggw5WMjB/tt6RbYULzCHra/XXUfpquZR5kN+/hQZGp7khIgm6cOteL993eA6lHLa6anm7EKvOn7WoR2OXCa2DC89RpSV+r0Pwyq6TlByCiOoDXICScxdahn3We3VVCyT+pHw/ui1FQItnUgvIq0GzuTwqVd477lNhJ+iD4SznSHEzGgiJI0czsUXfUTmSgfPns7QZAw8fdl/th1dtiSK6P36v7LTUvaEY3/Rxmak6TzkMX1o0gJCrGe0aSmHtWQWW1kb7pi44uZwY4cFMJq/iKwNpoQzE86ECEhJqb8WhZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3FLQC1GM3IvP1PCna+UY6bjB1tBF3Swd9BWIp9myHI=;
 b=aZpNZL4o0HrG3fcNd26Sz/V0K5UBg+q7TspwhP6E3QB913z5EgOHgte4yS4N5OWsDI9Ryvg8Dfi30ltzIWQcf2AnUU76pN3rR8hN8RgqGZ/2GzkJno/vo8uwhMONGkI351EZbgrdASfyFUtOZZ6EVbzBJWIwKbM1LF0RKjvVaZzHyVFi4uB2tbvDdbPxlUxTSpUc9oDPX7ujwKnRVfOIqj7MQH0e+NBC7lyJ78xFo2a033xtp7eezXUWvvVXxRwY7+/hMBQNPiac8nCA+0KouMLkU9FhSCTqFAQQufaydrWGvR/HXt4HNtNN+CVjqVtm8rrLaKwvuiRRsPnKfsGaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3FLQC1GM3IvP1PCna+UY6bjB1tBF3Swd9BWIp9myHI=;
 b=WlMrQTV388FvvRTOdhO+YUuJMMzdsjFpgko4xX1jwteJV3mHYKZ7EUw7Q2sJhwx8FOX95O2NIS+Flkt2L7EEgL4SV6p6BsmfWXxXmJ8qKQdRb4PZcROZrgHq1CyQNGdTwE0bfNL8+ygbKgfS/KKG7Vo7ibcboL6fzQ/FWdNbENc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:124::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 10:55:49 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc4f:2b48:88cd:f90f]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc4f:2b48:88cd:f90f%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:55:49 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: regulator: pca9450: Add sd-vsel GPIO
Date:   Thu, 11 Feb 2021 11:55:29 +0100
Message-Id: <20210211105534.38972-2-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211105534.38972-1-frieder.schrempf@kontron.de>
References: <20210211105534.38972-1-frieder.schrempf@kontron.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.250.136.36]
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (109.250.136.36) by AM8P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 10:55:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3dc6c0d-0f5e-4894-40cd-08d8ce7b9646
X-MS-TrafficTypeDiagnostic: AM0PR10MB3108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB31081F57D99C4C61040A64B4E98C9@AM0PR10MB3108.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPD2na07pK2tgaujWl9CW1sy58LcVPrKnRo9HfzfPCKE/Miu5DXWTkfmlxTfCMKvIg1bO8LKCyLmSVCZuzcghxIn+tCGu3EctQuP4jC2LRELcVNY/Y7YZooQRK0318iUBOXgQydj5dZX0GJG4hi+Rki7P9Rel8nsZf4MeV10ayBX7Jfy5MZZcT2tr/GMU4CZO7i/NuZoW45LTqXwEesXLbdiyutpLgOd16qJIX9xdLsgihSVjyngBsGMEplBFXFRFX8DAnpGf08k1NWbmCDebzIe5DPrpKm8JjfCpJI9XKtg08Z0i2TZlD5VauFnL7fdt+o4MYyXWq0Xi1gH+C2dfnG8Fw71DjpaLr2ZPk2u/8GNHMmDvTpdbA+Cm6QKnAC03ecQwR+DZEBbqsph+KabW7MOHO2W66SyVxXHeqDtBtVQNobAJZIJlWRXYEf0QkS7Xc79I1uNztTs0FVpTpZ4TkPHh4gW27+KLzvPRTFDOPxETeRN1XXvj2+5LDlIv1OlBteDH7pjZEBYvOR59m6Yhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(8676002)(52116002)(8936002)(16526019)(186003)(26005)(6506007)(316002)(956004)(66476007)(66946007)(2616005)(86362001)(66556008)(36756003)(6486002)(478600001)(5660300002)(1076003)(2906002)(54906003)(4744005)(6512007)(4326008)(6666004)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/leJ0lwsUrmSwE7Rv8oxG+Fx9iEAOuKAPiE2m7gNHzfkMRyB3cvMVflJPcTW?=
 =?us-ascii?Q?ZvsliQ+9n488lJ8QdUphvIqa3MzkIbrSCYlBgFtJ1coysnyPHIWe5riHSAzC?=
 =?us-ascii?Q?csWdJxHkJRgZKzzSnl3ua2/kIY8lrnmN71Sob+R28CPQyJnQ/P8wV03EyKYG?=
 =?us-ascii?Q?4syRtiuNJapIDtoL+8XOjd8k+3O0g+mOXhzEpZn5dykQ193tMnhFNZykyqQQ?=
 =?us-ascii?Q?qfhRp1EqiQEPJJ8OGohWH1n7BPPHGdJ4XzaOvm6oksEn3oRfwrTtyD1Ko/NW?=
 =?us-ascii?Q?Pz35DSHhGBB6uRbonKoLutcsxgOAtr9+dcTkeZHyuvTK3BV/dEKX6fk1g11q?=
 =?us-ascii?Q?U8G90IjC1JVHt1uD0314PMtDi86Op2zDvpJxc3m0D14I7zSwJJJJuTXLFZbV?=
 =?us-ascii?Q?6BqQtKOHna672FkPJTDVlnPoHI6o04nWZrBSxL/uQzzlIlDL1b6fjt2fjdl3?=
 =?us-ascii?Q?a926UAFu2vXXYNx98/QSwbrmLjqeCNSvEz4foLX/SeP6qqoF3Ya7zMA++ftU?=
 =?us-ascii?Q?Gt8jBtS1Way4YAm+1wcckUPG2ZU5BZCo356/qH5TfbZAW0fjdd3PLX8+ax5l?=
 =?us-ascii?Q?SVMf6Yvij/+OVe4zIJ3j7ZvySLa1ZbkxdAPC0MbX66t5RHShtuqLtawebJsY?=
 =?us-ascii?Q?TVsRu36NV+ouKTpsp6WaVpIjuST4NdKygTAfksxEhTyxZ5X+xn7Pvhz1EKoZ?=
 =?us-ascii?Q?UWKcWEKV3WyHnK/vfQMaiqW29wSpVHGTDRlVzqpr1YDB3gmzgi4m5I+oyVbb?=
 =?us-ascii?Q?8x6rEhkYRU81tC/9qc0GqxG5BuZkHBWf7CY3BREIYtwbLOqb5w200b1N7UV6?=
 =?us-ascii?Q?tqlHJsTFfy1GOMXXkjo8+3FSnYfNNFYV/KjaEe5yBJRtEeG/sx5RY5+pvZ4J?=
 =?us-ascii?Q?16LkWRiIQFBezezEGfMLC5lKEiGGnWSzthyGydkvu+HHSvqPDVDWSQlF5hCf?=
 =?us-ascii?Q?NirXX8mGO9xBpWgI5WySmzEY3GP5hAVYmROiebTm3Yd7yZwPD8Gc/BNb11hW?=
 =?us-ascii?Q?KlffrccYRm3+5GgQyMc2yzKXIHIZcTOWYkG+i+thrtedlW0GHnAckOpzJYU1?=
 =?us-ascii?Q?U20RMkdbXNafBz2s/2V1ty6lU4NeQ2DoP9n5TyYY7rrh1ksZM++GsfCHm9VU?=
 =?us-ascii?Q?D3GmDpjHQ8H5x/70sa77+Z+MxYkQ0lXtoGCVA2V/G5/4XKhXJUjEvPQ17nX/?=
 =?us-ascii?Q?u67oW17jB3QZqwQx5gA7czdLz2Eaorikeb4bTu/eyTmh1lFk8/a1Le5Pe1JH?=
 =?us-ascii?Q?xeDR2emXawIXc00w35AUx9MVdNj4P+uGNCf2FbEWjS0iW8d8j4G3/wKJ0gqw?=
 =?us-ascii?Q?bH+CZMagpLE6xkmUhFiLtIS3?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dc6c0d-0f5e-4894-40cd-08d8ce7b9646
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:55:49.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmd26Ba17xZ1nzB5LTDaG1MDCVZshTq9ThCadJX77qLXcUpvuan/v/SLmT/9O1sr3sx6hrOcaH4xsl6P2WzGT2iqDGynC7TRfmGDCt4L5ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add the binding documentation for the optional sd-vsel GPIO.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index c2b0a8b6da1e..f70f2e758a00 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -87,6 +87,11 @@ properties:
 
     additionalProperties: false
 
+  sd-vsel-gpios:
+    description: GPIO that is used to switch LDO5 between being configured by
+      LDO5CTRL_L or LDO5CTRL_H register. Use this if the SD_VSEL signal is
+      connected to a host GPIO.
+
 required:
   - compatible
   - reg
-- 
2.25.1

