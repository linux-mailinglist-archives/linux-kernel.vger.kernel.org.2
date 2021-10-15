Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8628842EA18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhJOH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:29:46 -0400
Received: from mail-bn8nam12on2091.outbound.protection.outlook.com ([40.107.237.91]:2145
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236078AbhJOH3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:29:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn/PSwo19mL62Q0aa/E8/gaUZ2eNz4hsOJnpDMp9ci/ITyrlXreCjw7Qcwue5TEat/l2Y2jkr+mzhLdPbI0kLBy0J544ec3I6qpN9YqhbWdSCGjYUJ81hjJmqt6G/fnJwEyUoskZODs4qzSY2u//MAQyD0hhPepDbUeFVY/HE5CGYmsMyAIUo3mhKWlKe8ulPCIYQVjwlvjCjCyU+3BSKJRiR9FrSI7S3Zycx00NSmaS8DESFV3VVNVWvRhkcR3gC1XiqC+goh1lYWVdSWpqlt2ga7ebg7lbgpnB/4l+rAErvs4422/Ph15TcF1gIY115a27e74sdvNOIby1cRH3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNFI+RY5anTIaorob768jixp8wTZxUCTwlTB4pfA5m8=;
 b=VimxtWxK7bx1iR2Hw6XqxFW2TuNdSfZaJLWzA7c9qdaBdOfPzDWMdbN3LWBvh4A2HlaXlhGcgx3nSTRShpZ04H0THesSkBm8i77KkJSzom20tCnLR2SD2QGUQxMm/ypUpUQT+Wj/tnM73EdOWyINkAdsSMSeCZPCs9KQB+fzDZEpi1iZjtlXfwrZa2gEWeHreQu7/ouht/IEdUDXCMkLa7oTY0gAMYC/3P1V6jMyxC9oE7Aa8aDRKbuqIz0XOasN7CCZ73K66CpodU8bk4CybIpqpIVTLYFo2ohRbNAhlBmTAWyakUEIcTxMU5LY3fFFjvnBCtE1rj6SF6frv6yrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNFI+RY5anTIaorob768jixp8wTZxUCTwlTB4pfA5m8=;
 b=GcL30PXgw4wY8tBE5dsUmxNgQLNLoaY0PNiwErbNLLJGwaFIU0KgkjkTSiNUh6tzBM+scjkQ7HTBVySg+RrEYn8awPYmYhUFVLch80TYyipju1fMONxdllLaF/qCMVx2BWG0s+gQPeVkaeLzC4jv2Aj1pIwXc6Dw2v+bHSYPl38=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
 by BYAPR11MB2726.namprd11.prod.outlook.com (2603:10b6:a02:be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Fri, 15 Oct
 2021 07:27:29 +0000
Received: from BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94]) by BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94%6]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 07:27:29 +0000
From:   George Song <george.song@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com,
        George Song <george.song@maximintegrated.com>
Subject: [v2 1/2] ASoC: dt-bindings: max98520: changed signed-off-by email address
Date:   Fri, 15 Oct 2021 16:27:08 +0900
Message-Id: <20211015072709.3167-1-george.song@maximintegrated.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0052.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:19::14) To BYAPR11MB3671.namprd11.prod.outlook.com
 (2603:10b6:a03:b3::15)
MIME-Version: 1.0
Received: from SEL-LT-028891.maxim-ic.internal (223.62.163.157) by SL2P216CA0052.KORP216.PROD.OUTLOOK.COM (2603:1096:100:19::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 07:27:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e00bee-b5c9-42e7-9ffe-08d98fad3e77
X-MS-TrafficTypeDiagnostic: BYAPR11MB2726:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB2726F47F902F25239EBD9E4EF4B99@BYAPR11MB2726.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoeUo73M/4JMwnRlquYkhqzWe1unucpa+zTQE3MkQftCVTUBLJBNkA6qNRqGbuidsXALHKz4ojcldcbAIEnsl1kNFKO8Dp8KGJMJTTjkvY5Q+XOJBrtB9aAlMEbghrCsxhOC1VY/b/oANqdBeELvDVlBah1KuN9yi/dyypYegbVpAE28Q1kSOSaaB+muMrAR1twwxQX1L6/JgM8QCDVDhhWa6OaeBL+p/anZNBuEbHaUT6UXyi5wriF20L0HpR4MeYoKDDLkdHepmbrqdROeevKF9dva29uk8PzOaI+UGUGogAJRIrYGT7+hS+8PHPV3ez6I1K9P21vQn7DhIiLp6XAT5ica/ZkiBYqpviKswekWHeyk4Y7IKc/LvKA3IKUE7mTtfj7MX4UOANr3NwuHl3gyBBfHV9Q2CrHN0bY+P0o3vUN2Vc0RwcozDy15lJs/X37Sq01YMmWeMK6ZVKB/PgShhjdLZ/fgBxawEFByFpGUsIFvDjzKMlnP7w6tE057Brt25VLoh118dO+PpufhH9v92aL2N3sXQpuDFpHC9jrpSwEdr/XG8HRC5w+K7uk3XpPrD/svsrfXcXKENwnlScv3f/6DlzTT2SHW1jZRh5uGb5UIgyyNbxYO3fyH1wdnI0CZIHN0Vguh/bIwLQ0V9ynkiiSjAl9NocSAYMUu8G86S6OPocn78B7XrrB0OC5n8Y+2NsaA8iscd2nJbFZfWhOtWzuupnD9dWDrhoxuuPfOaKOPZUmANhbLHqDt7if65MULXbxUqQQUXBuxS4siJb+73MCKloHTaFEWiESquLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(1076003)(8676002)(186003)(4744005)(6666004)(6486002)(26005)(956004)(8936002)(6512007)(2616005)(508600001)(86362001)(966005)(5660300002)(38100700002)(107886003)(4326008)(6506007)(44832011)(316002)(66556008)(66476007)(83380400001)(66946007)(2906002)(38350700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yM+l4INa9lOpU6HEUZaDNsTo01YyqE+cPsDpafTvTWMtO5jBA1oYPM1R3i99?=
 =?us-ascii?Q?Vm1SFlrkU2K8LB6thcp6au77KioYHKwh9z1wbiJrdpd+MBjW1ZdGufRjNMLo?=
 =?us-ascii?Q?y78ZJQOnUbxg/ds9gZNsUG/xZCy8b/yuR5OIt+3l1IPj1iThPOIGsCicE34q?=
 =?us-ascii?Q?vYfaBgVBaWdV0qek8vtshsUBk4NMEjPaevOK944RIQDcsGdiyrBzq4Mkd0as?=
 =?us-ascii?Q?IeMS8OWFJdbymsHH39keJpYJSUQ8KnGV31qLaxzClq209lsy44RDftijxNZ2?=
 =?us-ascii?Q?ez2Pqw9MGSHGmmg1kYtTue8f5xoN51h4IGMygDx+nUYlU0fXi2NVFB/N9Vu5?=
 =?us-ascii?Q?GG+6QPyt2iU3WOD6x9bYDvxidMRSsapnsWL1qT2GKK1yBt+d2EPNkrGPjbl8?=
 =?us-ascii?Q?EbGpq1ImcMBANm4xPW1TiKOw+9sJJ1ty0XDlFeTNnrJ7CfBadPTjHEb3WG9b?=
 =?us-ascii?Q?lseW/aPpvFBYnVoXTvFfzeq5pF1pZNfDhXf5ztDu8VwsnWbekX5wzdEo4PtO?=
 =?us-ascii?Q?6eOw8bwK1ZXn959xJT3a7IBQWrXUZjCCKu7B3v3RczAFnCFm5r9hokarermR?=
 =?us-ascii?Q?+G+r4bqEeC09rCB/NGzZCkMvCfS6oedm+L/sgC+SkTaSG6FvNLdWKMJMlBj4?=
 =?us-ascii?Q?ODy8UuKFbKYpbHwT4XzsRIa40Ky9C/FQ/bxIPQWiJ23oIrTtmW8KKLaoV6Or?=
 =?us-ascii?Q?03HYMpqdFptlD3/ARKVktKiJRqWqqLz03v7Auwm5KQ40dMB/YuX27Oi5pV/G?=
 =?us-ascii?Q?O6nKBwO1IZYVMdooOGFKZE7fK4nqGtyzO5WUrStDrarolamnIycYTciTonT+?=
 =?us-ascii?Q?fay5P1yLfq5Mp8KFSLp33XnHWssMiDdEQOyLnvqk+cp2DLKPz0yXUliMDNDN?=
 =?us-ascii?Q?+VIy/22BXFvos4cauGRBK6FJbg/pcmGd8lfmTAfxl9sRjEW7h458q5xxkwQp?=
 =?us-ascii?Q?6y7LTR1HffcJIRb91iJQIOrhoEh+QjRpy+smy+BKT7ri/E8YhnCrc8PkjaJX?=
 =?us-ascii?Q?7P6GCmWTP/GqZfzH63ezC7ghvlTYa2GwHwFGRtrZzyAJ6LLsh1qtqTc3Wg4F?=
 =?us-ascii?Q?94hBHYzOz3lrrxKQ0EXcrtV3X9g648eUh4yKOKjiibbNSBJy5KGYmk/xT7+8?=
 =?us-ascii?Q?OYXY8S5eRH3CxEJ1NZhtmOI9RWR9MYvdMLGgNXOw63M40/hBAt0eP3GDIQAt?=
 =?us-ascii?Q?SqtK3c3nkYvCCPLV6doL3ycwMXm1XTfkvsPXAPZeTGHkJjJgfQk3ZVYdlVow?=
 =?us-ascii?Q?CzXWL9KdW5jkUGMS7E4nI8sdOr6dyeomTnWQhu5FSR5CBEO5M5I518BbQe+t?=
 =?us-ascii?Q?+BRkVEgdW9bdLP3Z2ktEA3nP?=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e00bee-b5c9-42e7-9ffe-08d98fad3e77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 07:27:29.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqWpso8LXcNUxc80bWj2hY5sg8RKQyni+EEKX5886UkIB2G9/XAMCvDcecnmyOcWiI+JtZ3OphF9IW2L5DeNuOyz+bkm8GcyjQqjc93Fg9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2726
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changed signed-off-by email address to maximintegrated group.

Signed-off-by: George Song <george.song@maximintegrated.com>
---
 Documentation/devicetree/bindings/sound/maxim,max98520.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98520.yaml b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
index d1f2b5ee775a..ad38f56e1c49 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Maxim Integrated MAX98520 Speaker Amplifier Driver
 
 maintainers:
-  - George Song <George.song@analog.com>
+  - George Song <George.song@maximintegrated.com>
 
 properties:
   compatible:
-- 
2.25.1

