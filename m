Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12BA348C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCYJPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:15:06 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:30318
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229616AbhCYJOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNtV1xsR2prVCrx86CaX7+TRlU8iy/df1IhUkVlgqnOaloyr4bqrBUIHrEjbbNuLlxQ/wFBpJzDbPmBvXd2a5lT3HJVgPGAU1Pom/+l2Eb1iYfOjPdt4shk+mK6h2UcjY5/LvTL4WnD5umFTghKPZnDa1Y0EveQLchJI4XHM18WFaeDTmS6P6xQ8nzzTWuNCpifjSxjB61qtv0N/8gNawQSyHYzZTzqs9WPPo+DubldhumGVXdJiRnAfzhCV5DNvLtGXUD0FpydveysHZ/2i6IHfM1wqbBYVik43gCWvIhxYLhIN8weEsMLybjHLcnCOEu4PbHuFp9BN+ULLXma3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKUevlIS/pPr9dxRWiV7l3CwA0jZ5orOFptAqFk/LNU=;
 b=AuPr0U8VsyQ0tec+6Bv7iPI+RhqGk344eAo5Q+nYJg8/MhY/ilDmMxrxsDqiSqWkedqQw/fmG1dRomkYxSoFapZdNUOlW87beDN0B139Kz8IQm3Moz9vIyzjp4tTxw8nGvLjNqc8ku41ZNhueNelF1Y2AaMBcHCcfFHipcG3NI8Sn7h3wnh4qay0Lp4zwygSk1R7xaPao/O88iMjvAjsRyuvr5ieq39ohE3gyae6H5EpPpgvyOlOcdqG9uhZ/PbTXA5UzfUN0yn+fYZW8DMkhZbfE31K7zzxzkKwIFoO4xArhmugndWF2xWgLNxEVNh2xUU3mlR5vK1WGGQmhnmGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKUevlIS/pPr9dxRWiV7l3CwA0jZ5orOFptAqFk/LNU=;
 b=qfbDMMrVycJwPIqMC6hkSAyrRUpW6VLaZDw3cgqO8yZ9Qv8gsb5idHHb6ELm//Cx2SS/Tvddhtu9ha7Kb1QAzzirHl5Us+TSA8xGh2gCBzgKGBLlGv48UKr2IpfoQ99a/Mc6ym93KpN9dOVFO4dmO7lX7zyFd0ThIaQ0rJtT/hA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0401MB2319.eurprd04.prod.outlook.com (2603:10a6:800:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 09:14:50 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::3ce1:4759:5c33:514c]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::3ce1:4759:5c33:514c%5]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 09:14:49 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm,
        robert.foss@linaro.org
Subject: [PATCH v5 1/5] drm/bridge: nwl-dsi: Set PHY mode in nwl_dsi_enable()
Date:   Thu, 25 Mar 2021 17:00:28 +0800
Message-Id: <1616662832-27048-2-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616662832-27048-1-git-send-email-victor.liu@nxp.com>
References: <1616662832-27048-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0164.apcprd02.prod.outlook.com (2603:1096:201:1f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 09:14:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be1694d7-b3f4-4709-39fd-08d8ef6e7123
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23191D4A3CD9749B9B931A5F98629@VI1PR0401MB2319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtazQV0CyT/lnkTszIg0RzGotApb8RAAwXOin50cqVOQTtqfemVvFfFlzOqQ42wH85tbUxE0uIvHl4LbrjHCKjev5OIWOufCfUEafzZTHjWDsSaK7K2y7xg+tR19x4gXScIbs4aBJHRP3L5Lt7GIZpATdJAaXhiPoEeGbYQGgNMgGr3bHRouQz4muM1PT7Kl6+bHb8TaxKcuy3dDvFg/a0KOCSTv4t7+48GOMD32rsauBAEahMonf5i5o/Wz2hN8z74R58nZ+p/LRvQybUILgqusHjU4cRZ0qF8nk49DFtNP157rFwqOABg05dxGSTNeyIzOM9/LA4OdeE6g6lNXjduADH5k2AO6tJlYNl9Dgxq56VUo1Iy+N3Z3hBZSuVlzaRBwc1IdC7k2tsL/67X5PtkpSoAWHJAkvtrVUSpF7613u6TU56aXVW19wSaS8uJvf2Nvv2Oo8gsyMCMUIG4Tm2JIDq+u6YgE8yLKbob5iiWf0XX1eGiKH+RacOUTcYYxk6SXgK8RMJ3Tsd8bZ9jQYsuYgIxGNcjlfqLHGclAM1ZcSUGMxGyVdgKCL+KJ6j3rrHpzDy2XBzHcJWtdGDE7VwRaFVuaHWq76eUMghzHTh1Hqhd6om/0gZfNZBchxd8FRVXwc8G1isDMx+yzFT4UyAZXPpcmhyKQE9Ak8H8Y7ic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6512007)(2906002)(7416002)(6666004)(5660300002)(6506007)(8936002)(6486002)(8676002)(66556008)(66476007)(4326008)(66946007)(2616005)(956004)(316002)(38100700001)(16526019)(186003)(52116002)(478600001)(86362001)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MUN0NG9SWG94WHVhNno4Zm1hVVp5NkNyc09INDhNQTdQYlhtREtpaVB4UDJB?=
 =?utf-8?B?NlJON1FEdVFQL3J0VnF3Tzh5TS92RzlBcnRJQlJZeTh1cmdKWkxmMCtBdEhF?=
 =?utf-8?B?SWxyMlBoME51bE10RkdpTmUzRnNqMjFhd1VsaThRenJaR3ZjM0YxbVpabEgw?=
 =?utf-8?B?d3NwRUoyV0VlOHE0SEpwMnEzWk93RU1tVm9SK1h0dTVpbk42QUY1MFJYZ0w5?=
 =?utf-8?B?MUdFbE5VT2d6dkRMV3ZTM2ljc2NpVDByemtOUkdPTWhwTGhEci9BWWJnR3k5?=
 =?utf-8?B?bXVNZXkzSmk3aXlWTXVudEw0Y25JZWJ0dlpSRXloMkJsdmUvOE1JK09pd0tL?=
 =?utf-8?B?a2NydXZtNTlRSWs5T0VydC9PQ3YrR0doTVB4eFkrbkdveThjbk04LzlHNmhU?=
 =?utf-8?B?bld3ZFdmZm5NQzg5T0hqTGcxcjJyOTdGT2VXVW05VDdldXF0bmRIcUxETGtM?=
 =?utf-8?B?cVRnSkxtaEJqQUhCNytjaDZLdFpFUHZpNDBXMVV5OFhkYTdjbXRGM1BhRTZB?=
 =?utf-8?B?bHQ2ZVlLRzBHczV4Z05KSVBrSkEyd0F1dDB2OVRtZkFTamJoOTFxbXhHQzV6?=
 =?utf-8?B?ekZodW8rOG5PSVJ5eGVTcnd1aDVvRjJCSnJ5VnZVK09MOHFkZXMzM2xscTZW?=
 =?utf-8?B?WU02ZlloaXlsSVE4SXdNMGwzNitVWGhFbDVHakkvTHFtaWpxdjV2dlJDbENN?=
 =?utf-8?B?WEc4cndWeFZ1ditnUG5ycnhhVHkyTVdraUFqaDg1L3RGWG1PcjVzZFpMRnFr?=
 =?utf-8?B?bDZ1R2hVM2g1MCtyMmxJa3g0Tm5OT0kzb2NIRjJzbk15dkRDbUcwTUMyUHEv?=
 =?utf-8?B?TVZGZEhhc29udU5yYWZ5QmpBWjJaMjF1ZUVQQitsczdUYWNSSFJiUkJTS0N4?=
 =?utf-8?B?Z25yZ29RS0dvVFk0LzZWWjdtdlZGVkRYaWJ2Zzc2RVJRdllzM3d2K3ppYnRM?=
 =?utf-8?B?K09kK2dwcmtCZGlBN1BJWWdnclJ6VXRhQlZtOExaZzJUSmYyUFVqSCs4ZEJW?=
 =?utf-8?B?SGtLaXdNdTd6V1N2dkpnYVpoTlRLY21SQzN3dVFzdGw2Z1pMa0dxREhXUDMy?=
 =?utf-8?B?b2lGQnhsbkYydXd4MzNnb3NoV1lNeHo3VFY5azVrbDFRRURjUmRRbHVSRDR4?=
 =?utf-8?B?NHFZZFQ4Wnc3dGFOSzJXTkRzbHVBcis4QW9wN0I5dUdyN0lreW9kaXA4dVhX?=
 =?utf-8?B?c0liNEFjME9PcFg5MitjZGQ4K0x1ZUg0Szk2UXdCSmtQU1hxcGx5eGZCdGZy?=
 =?utf-8?B?QTRQbTFTa1FDYWlMVjNEWUYwdEhoa3l0YUdWV0RQbUZlMlNUeUNDdW4zVHZV?=
 =?utf-8?B?ZlpERUtBWDFISDFJSWxGSDM2UVN5ZTUvQ2VldzdXQmlmdkJHSFc4YW41TzFv?=
 =?utf-8?B?bFY2OHNicCtWV0lQRElUNlFmWmhIZ0daTmVHSDdKYy9SZzVhYkthMjNjU05K?=
 =?utf-8?B?WU1zbUUvd01VUnhrTzR1TkE3eG1PWHJvM0ZpdVBFZVpnSHBMOGRkV1pLbmVr?=
 =?utf-8?B?Y2JBRFUvZTQxN1htR3VBRkk0Rml6VkRsemFLdXg1ODRVU0oxMXhjS25XQ3NQ?=
 =?utf-8?B?cUozckozNjYyVHZvcGRUc0FRS1dTZ3h2NnpUOWVxVFd0eWRVK0tMM1BFUGdj?=
 =?utf-8?B?UjVSZ1dCamFFejBiaExPVG56ejErbS9xVDAzZGhvYkIvTXJ3dWllQ2YvcnlN?=
 =?utf-8?B?dzlaSXBPQUdYLzhNVFEwUG51Rk1ZamJCU2xyVTVFNTB3UUppdUM3UHJCZHNB?=
 =?utf-8?Q?l+pPaLa3BBPjiQvhvcwmp4enx/lSzGQwDK6GQrg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1694d7-b3f4-4709-39fd-08d8ef6e7123
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 09:14:49.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //10cXfxsP1Ybl8uGwSZ9Pg+jVsgl/HXKnuYRuP4xouGhm/A5TE6TfyfURbrEM8Vj+gwYp6iTU/yTjBIZZwlvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Northwest Logic MIPI DSI host controller embedded in i.MX8qxp
works with a Mixel MIPI DPHY + LVDS PHY combo to support either
a MIPI DSI display or a LVDS display.  So, this patch calls
phy_set_mode() from nwl_dsi_enable() to set PHY mode to MIPI DPHY
explicitly.

Cc: Guido Günther <agx@sigxcpu.org>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: NXP Linux Team <linux-imx@nxp.com>
Reviewed-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4->v5:
* No change.

v3->v4:
* No change.

v2->v3:
* No change.

v1->v2:
* Add Guido's R-b tag.

 drivers/gpu/drm/bridge/nwl-dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 66b6740..be6bfc5 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -678,6 +678,12 @@ static int nwl_dsi_enable(struct nwl_dsi *dsi)
 		return ret;
 	}
 
+	ret = phy_set_mode(dsi->phy, PHY_MODE_MIPI_DPHY);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "Failed to set DSI phy mode: %d\n", ret);
+		goto uninit_phy;
+	}
+
 	ret = phy_configure(dsi->phy, phy_cfg);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev, "Failed to configure DSI phy: %d\n", ret);
-- 
2.7.4

