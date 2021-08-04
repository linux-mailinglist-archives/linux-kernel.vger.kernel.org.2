Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE33E01A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhHDNHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:07:03 -0400
Received: from mail-am6eur05on2085.outbound.protection.outlook.com ([40.107.22.85]:53089
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238336AbhHDNHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:07:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a48/B7rOP1eQ7257DieMci48G+SXtMPJ4MY8bv+3DhdjYx0XjXMPB5hSPk/yoORVarkdc/tqN1m74WoQU2WAMQMVGDoPqKzZhY7Aj2X9BR4qcymbNMmC/9QyZGFkq2kC3JS1ZMTeibKIo4YmVdtpVS+6qpTX3cjKGGblu3PeHc13vqBz70h+7iu/AUtvjIPqMkwuh1ZsWaE0aLr2MEOQyLVORxy+S5CeVDhPJdfBPeZKFxLrzAnLNBMJ+dBdSSsPpBb15/TS7RlectKVXduHPwVj74Mz0nG3EkN/njiB6o9d7/Vp2eWscmdFZDpITSjI0Dw0EolEVlmsn2tIhhH89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JZz6VP1fa1Gh4q5q20IwXBukyrHC7fCz5zLWLuec84=;
 b=TNAWWAEDHaRmFYc9Pf15pxJhFhTU3xu7d1XMVId9RFSkBaBMdjuLNb3MutxxrMRSvVHFySrAYNleowYndCyWoMHtUGLkpjqjU4V/AB4K3vKWf77KLhogI04NANS1JFy/U5a31q51C2L0e/LvSYA4v4ndPOT8eAsQ5p+e53ePORLYnL5LwkGCbdYHYpzjLlgmvnWp7nwINNLXgRI0Wzylf8dRhQfwVSfEwYl4YGSLT/WZdgNxr28QXzb85w3wl25Rv0SRXHmqD7E0UVo00UkxkwoFso0xnSHS56GX2sA31nbFJTblM8bN4qFHOVkU+toAC7JprNqIePkWbe7ihyGgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JZz6VP1fa1Gh4q5q20IwXBukyrHC7fCz5zLWLuec84=;
 b=AtxqSmucG78fOBCiSAx4UuN2iv24R0SK3WYY5k1OZDCx8llSuLdRWYrYkMNRbXo3+Y3rH5EcYcZD8nXkhdi2kT1JpAD0K7c/Nv6YOx3Wl/erJhmXDAt/1ItMUQSHAAZHorCgkprf/IZmSucCsSkIOzYZmOOEjxaeeGoq4pHi7hA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5401.eurprd08.prod.outlook.com (2603:10a6:10:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 13:06:47 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 13:06:47 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/7] dt-bindings: power: add rk3568-pmu-io-domain support
Date:   Wed,  4 Aug 2021 15:06:20 +0200
Message-Id: <20210804130625.15449-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804130625.15449-1-michael.riesch@wolfvision.net>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:200:89::22) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM4PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:200:89::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:06:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59def6eb-1c18-4a84-55fc-08d95748b6fa
X-MS-TrafficTypeDiagnostic: DB8PR08MB5401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB54014F3191A323D9B69310F3F2F19@DB8PR08MB5401.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4W17b7aJ+A0cv/x3SZA3iQVJ+6sxdNz3MAGSITVQ+JJXOlsbq4s+0j3YbilHuoqipgZK/d5HeJwOb+qvi6H2dP7eiubvrtdc3Emz2OBO6zgsM7aneMbpmyXZ4b31chMSWh+/55bSxXZwmHoYzOtaqofc2pavqsPZRtddJs2z9y5+VyHExyxqiFTjMYbwJoqsimAPUEKSSy0w/BpBIqdOKivQSM60HmSBMH9sDUOGeGvf5mvTr2d63Ns+W1DgZJHVJaDqNcuvHUTt7ns2vLx4EGIiIig3rP0QBICOZpOFO6KQ2xJWx22QMjjUAuot+HmKi/C3i3Hqpp61t3FK5V4d5gpmBA23fz2sNxmif0eDWHdBlCGXI7qDzsRh2KIpJiaGx7YzrN61hyT7YLkOZZFH5NICBDGwLkqhnauPcJnhg0k+nHUEWwldOC1tYmp6ekrhjJv6eLLDtqhBF6kN5K9eOId+zLMsvKL6ANLFasmNlMojcrC8dRP/mujvrB2kFLGyyiVl6eYRKY1xi76Ar2/kQyKyvO1l8oN3DO5qYzuy26D2nDbBccnggE6czFGikVsu7NzobitTQ5mC1+03fTmMEOaY0oYFgbDXHGcjGDb7gjHVh8goppf8qcaVZ6Fl9Msgg/ER66PUQ9lNvYgqSsqsF+Z6ZV0nQjmrSHfETOJTsyT2AOHD2JFnky1KD0X7bRzRfrN5nUdJvNc61KIycuyrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(396003)(366004)(346002)(136003)(8676002)(186003)(956004)(1076003)(7416002)(478600001)(2616005)(2906002)(66556008)(8936002)(66476007)(66946007)(52116002)(6666004)(54906003)(36756003)(38350700002)(5660300002)(44832011)(316002)(6512007)(38100700002)(26005)(86362001)(6486002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YD3H/jayvmY9/bW+ub3wOPhJunrSdx49ox+Sb+JzcoxHHH/Dh8TA6Fx3ANzv?=
 =?us-ascii?Q?Vy1+ZDn1cHZSrn4/4LHGuuEjLVzw2h3bjkbbOLzUy+wyUsDQhUa0xJAFmlm3?=
 =?us-ascii?Q?RFkXPfrphB7iNYLKzhSnFfMyZH1FBeoKR5VrB7pkRq0vuyzXKH/ml96NruEd?=
 =?us-ascii?Q?isV5MLb3Bh8IHYjK8cXZ6TQaDBqaD0z3y7Yi/RU2YMKKQTI6MAvPIRBgquFK?=
 =?us-ascii?Q?w+nuWRxESuiLr2lKPwd7/kuc9cuFtKshLiVGUaWF7418ib6VGQrUV0SKX3yv?=
 =?us-ascii?Q?xEfIMVVkNMmlUdvO800M21let+AAaPKToUkLE8bAMeOX9gnG7n94CNQh2Wtr?=
 =?us-ascii?Q?H7PqCHwU08K6/ezdxNSzRVmLWdE+tuh7tk2J9CIqkkeL9ekDtv/Brit18MnX?=
 =?us-ascii?Q?jIv3Iy5A89X2SPVwhQGdgzD4wdEYRPvb6zQ1UZUXmUdHLqsy4i7y4OyalrMm?=
 =?us-ascii?Q?mSZbKM9Z8iMzC5zCh+RlNwT8mrG6p0HmdB24VGxOOrXxY78/ke/30S6MJMH3?=
 =?us-ascii?Q?IkcadaAISYELYZt01J4Y2869ss3HtmrXd1yDAOTT8EVb/HBOAdoWcePoHKlU?=
 =?us-ascii?Q?GrvcnupdCS97uuYVHdBctF4Qn9VvQF/+WCdBMZasgxjmc+h7s02KIidq8IfG?=
 =?us-ascii?Q?zJ/CG8HS6C6uYoWd5PqqLJH4PnQ0RCNl/XRI6iOdsvBkbCn17KM2rCfxaSs2?=
 =?us-ascii?Q?Oxu+F8rRG1cGed5dSTnQ8V/QUyIso2i851ldpdq0JJKIfIzfO9Yew18jjOBZ?=
 =?us-ascii?Q?vPMCmJ/a8hKCyEqNW+5t5LvLag4yI/0tkkPyFJoG/3zw5OLq5XnI5SeXFXft?=
 =?us-ascii?Q?3oFK/0KHR51fCBk5MplDeGItd23I1uI6r/9GqLQXSxTiRX6hEv1yQMjA1N2o?=
 =?us-ascii?Q?TMYREfNaHvLUrdwINrjWYm0avlI+V8i9Qgdh/vTNleD5iaBJRuCQvRvTT7u2?=
 =?us-ascii?Q?m4W9L/7FTp6ESSzfCZB7GmSzulqsP4n5tq3YEMebulGiI1sDbOeZDGhXy+TV?=
 =?us-ascii?Q?rES8wo5B8PSf0tCL3Gc2BsmhiA0EIc1bpoTYGs5ZrW7UvPAYXlw9+4u2MxdG?=
 =?us-ascii?Q?6SX2emXgZxwMVajteL04/NttBTGEzr9vJgJuNvn9JDsplV1RY/1iv3LXQXLA?=
 =?us-ascii?Q?97YovJ6soCDoMzEPtYDznCyU5iSmVLdBD9ijtuPoEB/Zg6WEngKtk2hu6jki?=
 =?us-ascii?Q?QmRUaVNBHABm8BvUn2jvRsi+yheHP05NpaGEuxFw/jCd5p8ztIpXeLQCNq8d?=
 =?us-ascii?Q?tw4VEJMQ2jmNl1xcUiV313QuGFLVeoVLMzckzVaxVt/aoniPf1aBMM6cn1Jh?=
 =?us-ascii?Q?PIOBqJv7h+P47asgjLkkrGI1?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 59def6eb-1c18-4a84-55fc-08d95748b6fa
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:06:46.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMIReT1LOLyd6qOCvOXJXdXUQAectJhV/hB97yOCoLOABPCnySFB2dt+LsA6siEGQvqnh0nTW56BedpY6v+MRlMwCko71jYhJgbBipbrEkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
[add soc-specific section]
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../bindings/power/rockchip-io-domain.yaml    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml b/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
index 121bec56b2b0..1727bf108979 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
@@ -55,6 +55,7 @@ properties:
       - rockchip,rk3368-pmu-io-voltage-domain
       - rockchip,rk3399-io-voltage-domain
       - rockchip,rk3399-pmu-io-voltage-domain
+      - rockchip,rk3568-pmu-io-voltage-domain
       - rockchip,rv1108-io-voltage-domain
       - rockchip,rv1108-pmu-io-voltage-domain
 
@@ -74,6 +75,7 @@ allOf:
   - $ref: "#/$defs/rk3368-pmu"
   - $ref: "#/$defs/rk3399"
   - $ref: "#/$defs/rk3399-pmu"
+  - $ref: "#/$defs/rk3568-pmu"
   - $ref: "#/$defs/rv1108"
   - $ref: "#/$defs/rv1108-pmu"
 
@@ -282,6 +284,34 @@ $defs:
         pmu1830-supply:
           description: The supply connected to PMUIO2_VDD.
 
+  rk3568-pmu:
+    if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-pmu-io-voltage-domain
+
+    then:
+      properties:
+        pmuio1-supply:
+          description: The supply connected to PMUIO1.
+        pmuio2-supply:
+          description: The supply connected to PMUIO2.
+        vccio1-supply:
+          description: The supply connected to VCCIO1.
+        vccio2-supply:
+          description: The supply connected to VCCIO2.
+        vccio3-supply:
+          description: The supply connected to VCCIO3.
+        vccio4-supply:
+          description: The supply connected to VCCIO4.
+        vccio5-supply:
+          description: The supply connected to VCCIO5.
+        vccio6-supply:
+          description: The supply connected to VCCIO6.
+        vccio7-supply:
+          description: The supply connected to VCCIO7.
+
   rv1108:
     if:
       properties:
-- 
2.20.1

