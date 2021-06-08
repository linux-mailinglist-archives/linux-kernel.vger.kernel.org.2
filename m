Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D823A0387
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFHTSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:18:06 -0400
Received: from mail-am6eur05on2115.outbound.protection.outlook.com ([40.107.22.115]:2401
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236388AbhFHTGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9uHUSERyJj8/NRuLhtOTla0TVxodqtTkNiHy730Z3QtXKBYSLUCBFMzXCEItzRRue2rAZaPkNy0Bl+IZ6BpyAms0KAZalCM1Ppv6t6QCIMRvhZYpxbaT+DvM1ridjx+/asyEwappVcloV7wsn5bddFqT2Eft8bSuinAs4sgfK3W0uNzBf/gpPzawQ7gK2pj2ug7pFqc+E/jypXsFxTxeJwGUMrgYicH46tEx25CZjIDT32e0iBxDF6YlCeHrLd/V10MTZOPL0hUumu+3dbOKDy5EPA6rzitPlqqwZVEibAfKgQtGitL5MNY5LcrhqBJXcsbpCBsZ/6VdaJN8+1/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkuH+OjUDjUTunDkFK1Plu+1tD7UR2Gty2ymoGNWtgE=;
 b=OPyYzKoXBKoLoOxntTWKTAOUkC+3v7GaXWUc3GJd1IMjt9BtcR40+CpVhYoqxTvL1D/IAcVTUC1avJTwPXAA4e6QXaI/y3KL6ZYRkxknyDU1dWYks4SpjkEub0m2HjQG36sYLnu2Z1yulsSiux8afOSVViN4VT2Re6bqR+WJtNT2UwZNzMkvMSk1kEc2tnQS8qQnRsgfJjyGf0Ex8A3jtvJjm5wUigQ4TvLRsEwzymadY0vl4u2IK+mCMl1ozIqeG3MfZtjsg7Jidqi406tvkccWnEnmgXimhI6ErtSNG2yMpJHTcjNn8IcIZul54A4QVIEazKQoaTjSeUKU4IhupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkuH+OjUDjUTunDkFK1Plu+1tD7UR2Gty2ymoGNWtgE=;
 b=c6iv1lYV8dr3kyPYartL2TErUQXtvGFqrmM3K4FZLcx8orU7byiapIt8atfuv0JBqck+pz/j0AkkfJ9FsCYXQpVkW9/Glm1QUFqcUQOo67Ytvi0sl0b9DARb4o+JzaS4grTpiM6SjaxrhkGubwidnNo5jPgNYttoqpyFpjCx88w=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0331.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:5b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.29; Tue, 8 Jun 2021 19:04:26 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::edb4:ae92:2efe:8c8a]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::edb4:ae92:2efe:8c8a%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 19:04:26 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 2/3] dt-bindings: nvmem: document nvmem-cells-parser-name property
Date:   Tue,  8 Jun 2021 22:03:26 +0300
Message-Id: <20210608190327.22071-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608190327.22071-1-vadym.kochan@plvision.eu>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-Originating-IP: [217.20.186.93]
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM0PR06CA0107.eurprd06.prod.outlook.com (2603:10a6:208:fa::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 19:04:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26f10b5b-d8f0-4bda-9ce1-08d92ab03be7
X-MS-TrafficTypeDiagnostic: HE1P190MB0331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB033178FB1B5D67DEF049BD7F95379@HE1P190MB0331.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HU6yspRzriC2nhZ0N1VmZzTY9FwFA1eSjmV2F16SO+fnUX9FSk75t+hk6Ld91c57K8FZwLkKL1fqHIqTZrU8Z0yHjS/2ypgXNLoTiR+V51b82G1U8ZOzQouimDxn84Fry2yZiqDBYyE/djAD/aoryvASMup79m5r/y0SNyDgnjcnd5XDqfniSpDUmBeVh/Z7TwP9YLrWS6RMURzq8Vs8FKHbUf2XiAEdjVmbvOrBzURPvPfE+amg7gXlyM5kXRhSR4xsSMK72tT0btci4aGs5fwyRjw1sUk02I34EZGkMrfAJNgLoTyHLXJKBQ1V7s+SSK5tuZUTTHUYQr2QffIuZanLGO1FiKVo+IL3BwW+h+3Dfl5aksGSDBV+oVmCU45IDm+6NswbKfttaQe/BJyUmaT8fVJPYKqWM3xCuQlQKrH6t4GOnjpAa13SPfRYnMZybRLbvqd1Edzx/v0b7ASf9snPhxTjj0wPpu28r2A8/AkR7kIOxHcDB/nGs+xb8rjDXNgB/9T0udAMRd308LnhJhVUb5fri6Lku/v900sdLFWzCIe1NyWCI6kcZDm+W+UcT5cmUIviS/X4Hv39+SsIYcItf38FLf9E9dlObQsFW86j86TT6QeTes1ot5GWHE9GQiUg1SRGowf0oIwAfd6UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(136003)(366004)(396003)(16526019)(52116002)(44832011)(1076003)(86362001)(26005)(38100700002)(66946007)(38350700002)(5660300002)(36756003)(8936002)(316002)(2616005)(6486002)(4744005)(2906002)(186003)(107886003)(54906003)(478600001)(6512007)(8676002)(110136005)(66556008)(66476007)(4326008)(956004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5a8XD1jzxmAxm6ARQiWgj429WyKyR0MiMyGGBic5juquc1BPRwTGHcviiICo?=
 =?us-ascii?Q?tl9xZEneAJaVyaB0QhiddlXbxicXqQShK0nwQEacdyAF39DYZZRGIefrGxbj?=
 =?us-ascii?Q?MwAUxWOxfVz6ZkKG2HYGUM/UDIGSY7ffTd+aHV5KXfZWIDKfQYoMpPZ05xDQ?=
 =?us-ascii?Q?buXUFWLliQc5TtHhrVPBOtjUcWqAn7XDbuJGF/5UD6BBJ5i1biVtpafGkxJy?=
 =?us-ascii?Q?tvJ7Rx6DMYZodDLeYmhr09UrTrmrfPjCf1gQQK918964MWMjCouihqWUB0SJ?=
 =?us-ascii?Q?8fvrgMsq0FmWW5pxvb3M0ddm7DnwUMSmZ1xrLv5RB+shfo47lJ23BrKEYZ2t?=
 =?us-ascii?Q?COHfLIfggHhrkbyzHO4tNVD3fEuGjauKo4DLz+9cJpR4elGhzH0GcAaZWZ+n?=
 =?us-ascii?Q?eGIZ02IrxXmTPHs7a0R2m8jgdZ2wVoLH4tpioScqk9K5eIWRMA3SWs02leic?=
 =?us-ascii?Q?pdpNYbJD/Gt8hCNqU7B4vIM17vGWzu6mz22KAvh4VMfHhO8h7rOjsUj9uiqB?=
 =?us-ascii?Q?OwPfSHHc5jkVSpVAzrmF+BpOd38HlP2lnTM+hs4xFZiHYVg/2zPNMS0oGGL9?=
 =?us-ascii?Q?UHqXoQ7lE5WypRKQJpNfW/trYLHc3aYIeSFI0+5Zp+ADCehjSgaA10SGQoma?=
 =?us-ascii?Q?mESWl69jRKR4aL0mQUV+O3uZ4jnvmw4/Wcrt/lixDKwYgXtDR3t7S/RKmz/I?=
 =?us-ascii?Q?OpLAWV3ALHQWaniXnF4fLGxY9z0m1gHdmaB2qDoWi0VhVRZzFC6jjyc1vwzP?=
 =?us-ascii?Q?YR5z3Fz1VsAmF58a9jQDeGRv5Rn0IGEmFBvnqN1oXizL73owvtBegl49pVeu?=
 =?us-ascii?Q?V3rD4UD6KDR73+92vnweJ8rKTYq5057LITz84VXWsM7huVZ6d1rSWAhe5NgG?=
 =?us-ascii?Q?QUyd153u5R0NAqQkxLrThq7khuTqC1ubImgRQ/dZFnz/4Q4GqXim6lBxhnVX?=
 =?us-ascii?Q?Um1zdn0XVjadpFBD7FRyjhCxqxTcMS1lhbV/wBneI6w8ZjqBbAEmXA05HwTb?=
 =?us-ascii?Q?EUAaDjY3diSaY0j1EpmSgBmL/5QMFN0X+haiznV/51ydRLE0yGyWFPwPBxU0?=
 =?us-ascii?Q?Itft9sNVLzNMTuA2A4Gr/4693jRP7uyUD9qOKIkh76OMfqNzpfdf3jdP343R?=
 =?us-ascii?Q?xDPsj4IJOysEM1pD2A/OUW8NNAPPeJNUjSZk1QT+sqiDhqZatI7D5OpD3JWc?=
 =?us-ascii?Q?K9W7KQ1q5jtqSa3e+vCsj5cTD2bThbwER4sGbURUaPPRiiYP4kscb4MFUMFJ?=
 =?us-ascii?Q?YiNMqMvMtI3iMzfve4iWgVsh9FFp2crHeA1dPFSKCgs5HxLmtEJQiD2RmBVE?=
 =?us-ascii?Q?jaJwV4Xyo+NgZp3Co2F/nxUE?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f10b5b-d8f0-4bda-9ce1-08d92ab03be7
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:04:25.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOFYTcoFR3qoYsegTocfpX6BEkotlQ3w9R9oSS1eGbhRYzMxkB++epxS7DbSbxw/x2VH+Hh18r9mTwhOA0dCd+2g4+DqrHUoWsrX738Ighw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe new "nvmem-cells-parser-name" which is used to bind registered
parser with nvmem device.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index b8dc3d2b6e92..36c6361d0605 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -39,6 +39,11 @@ properties:
       when it's driven low (logical '0') to allow writing.
     maxItems: 1
 
+  nvmem-cells-parser-name:
+    description:
+      Name of the registered parser to parse and register the cells.
+    maxItems: 1
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-- 
2.17.1

