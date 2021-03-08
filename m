Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397E23306C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 05:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhCHEGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 23:06:21 -0500
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:24274
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232464AbhCHEGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 23:06:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7Tn1OZmAPRkG7GQsiLdwfDnzY0/S0a6Ruezr/uVu3sK6jr0UxGHFHrfAlPU140wL/h+RlFtBIYW5S4wHwuYLXLGl+qTI8pq9+/sK5/7GUd+TpaEUsDmp6JnDjiwxbyFjK97IjC93T+Yvuh2S2SyeQQ+gfLy4qh07KNQq2AlFRHGPt5z6LaouxFDBIKZqKMoBJHumJqUlu7sQMNrxQr7kFnRi97DsITrqvQFp7d3SFnYpOglJWOeAF20fNUB1DhELxVlS5Vp3gYnV0PZ8lrsJpslgthqm1tcEolkVskCh8JYojn4eOwKO4cvI7tyLmWTkRK4CIqNyk50SC/2aoSOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbInIKlOtjX3/3zhPTADoSmdAO/icXL/ZHMPb5qQbSs=;
 b=kSoFYlviz4rFpX8+TZmjknzikW/50am144zLsgR1srTaDXRKUeScFr7K7s/yi6TjpH8Hy1LP3T5k/kIDQjpFrFbof7+NM1E/3DGor02RwBPF+Is4umi8+LKfwRHy3hnEzRQgS5qvat8bCJ4oKyiypvuM4UPCGj58muHoOjK+r8/qFTGC/elQ/UIMq/gjnKmfypKKyjRosAPXPc6B1cXNEHGShO1VCeHI4L4TB/p3ukEtKq0+sq762aXN+M8WCLyB3CwyJ0m8szMBRlc73+RkeNm/EdoyNh7PcJ5Ec6+1lF9BpotJwoxHBweiuZtLZZn5xSnLW8wIfNxRZMBAEweGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbInIKlOtjX3/3zhPTADoSmdAO/icXL/ZHMPb5qQbSs=;
 b=pkoCK6puUp3doWzUj712VNukFZISV92ZA2jF7SZNTbVIOyV6Vj3lnYKE16TNNxUA5SKZiw9w1UtiAioIat2RiDlZ9E3juYSRv6lYZweyiKLi5pRTkJTrxQSu2mBIEMmqfyUfLANJUzIlMZocPk8wF0Dn/k3bwEn+MwpfUi9XvoA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB3310.eurprd04.prod.outlook.com (2603:10a6:802:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Mon, 8 Mar
 2021 04:05:49 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 04:05:49 +0000
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
Subject: [PATCH v4 1/5] drm/bridge: nwl-dsi: Set PHY mode in nwl_dsi_enable()
Date:   Mon,  8 Mar 2021 11:52:17 +0800
Message-Id: <1615175541-29009-2-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615175541-29009-1-git-send-email-victor.liu@nxp.com>
References: <1615175541-29009-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0088.apcprd04.prod.outlook.com (2603:1096:202:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 04:05:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2173e023-d69e-4ab9-42dc-08d8e1e7752d
X-MS-TrafficTypeDiagnostic: VI1PR04MB3310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB33107A54B8DA9011E342B36398939@VI1PR04MB3310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nc0oFr73I43rJKLus7DfC9hDZEYU2acT/o8FLanAjubROqcICtK8tVdpDqxhFLRxdTSDkMsn1jEgpulXAXEjrjyTbWqSWyHzWYa4XDz3cLnkVPjMwskI0C7zIK86fDkNe+4EkbFWZm5/p8Vfxe8FkWr79+UqI/ia/NQQRPzcRdOKfLR0x7Bp0ge2lZ8sxyoLEtqMvKmHhDZS+aJeVzffSrlkLAoHwN9hptpCRXqjdpGgoy2vpP/t+CFTsGuyB8tCsSJpFNjCCrGlNAhjYHzKS93wbTDL2e8pT+vZDsJ+U0i07IoW1pQZOaP8miEupum0Xkl2mZHvcQQhcvrniv5GV1Wt/Ml1v1cDbCLOrKyF8UDahvxloQbDOqSQ+G1IqXv+6mRnYuwFaqp72pW46lKEoTk51vktD9P0wR/Axzgrz63AJWG9O+2h6iYCdsK/TVFxHuz8A2OiLgUmdMJ9zgZXXy3KYGieyTA5ja70HMjYIrufYK063QgJa7hXQ40/3mchq5HTgwXqTkHP008GJtVjqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(66556008)(186003)(16526019)(478600001)(66946007)(2906002)(316002)(66476007)(26005)(5660300002)(52116002)(8936002)(6666004)(6486002)(36756003)(8676002)(6512007)(7416002)(4326008)(956004)(6506007)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NFJBSmU1R2JTZ3ZoSjM4ZXpYYmxPcG8wS1U0T205OHo4Vm1wcWxFQ3VuSXMx?=
 =?utf-8?B?alpxcHpWbkVtMENzajM2OURSYTBaNGhCWkVGc2tteVB6SHlFTG8weUQ0TTR3?=
 =?utf-8?B?OFpHTUI4dlhwU21DT0Z2U2hPYkRzbzRsK1FISnM1cXR3aWZxSXhNR2ttMEkz?=
 =?utf-8?B?WE1RaHBCUUlNNzBPcEtqeGtTNUlBYjNmRUtBSndQTDA3bDczN2MvSDhPTFRl?=
 =?utf-8?B?MytoQU1Pc0tCcnZsZ2lsbjZMd1VwT3h6blAvVjhsTmluSXM1Y2taNCtYZFox?=
 =?utf-8?B?T3FPelBqU1dpTWFueml6bzRhRGNQU3J4ajdNcDhGZDVReS9XZkd5YXZ3T1hJ?=
 =?utf-8?B?UUV4elVHeHdFd3owS1hFeHNzVXB4UjJUWXd2SzR0LzY4dy8wYUt0NlVudWcv?=
 =?utf-8?B?djk0Mmw1YUdoczBOai9kOTlTa3RDVWlCeUp3ZVlJYi8wenFxZWo4SGY5aHd1?=
 =?utf-8?B?MEJzKzBUNFg1RytiTmpvYnBpdmpRckp1cGMzbU9ITkJOckJXdVBEZkE1ZmFJ?=
 =?utf-8?B?dW5vOXFQWHF0bWFESjI0Y25ramZqZmJJV1FnV3IxU2s5OWhYRjZweDNTT0ln?=
 =?utf-8?B?V0Q4MXE4a1VIdmluQlhUbFA3RFRDVTMrcGUrc2hSdnd6Q3hSK2lRbTdaN2Ri?=
 =?utf-8?B?dzA0NHlMOFc5WE1zMXVxUEZIU1RMMVNwb1ZZaUlaQUFucEsvOWhBTzdNaXRG?=
 =?utf-8?B?ZkduU0pRb2lsUUhJOWxRUWlpVDFGbkp1d254cWFsR0RITGIrVC9EZ1ZZTE5M?=
 =?utf-8?B?TWlxUlVCVHRoOWVEYnI3aThncW1zSFVwMDZ0b1V0SDZoc0JPZDRjL3JGVWd4?=
 =?utf-8?B?MEZqRFJKRGlLdVVYcW9pOUdNeUUwQTFjWEJscHo5SnROWFhvVUpocjJQZlZT?=
 =?utf-8?B?VmcrNlJhRGhUNVRKS3RGRUI4M0xnQnZpYk9VUi9MMkh1QWVMQm5PR0NFTjla?=
 =?utf-8?B?NTF4cjJad2hRUHFWMC9SUnRZdnV1aHR0R0RqSmF5S2F1UUFsc010NUdib3B0?=
 =?utf-8?B?U2xnTFAyODJvK24zcC9RcGRja3BuSzBQeXU2UWdxdHpNS1lScmU3R1J5SFlE?=
 =?utf-8?B?dEU3YVQ1YTlvT0I1U2lJVVhobnc3ZmtNVmZUOEM4UGFzbDljMlkvYXhmNDQy?=
 =?utf-8?B?ZkJiUGV6RGhOUjdScUx0dXAxZjl0WFZESXB1aEs0M255cmhSSjl0TSsvUDBw?=
 =?utf-8?B?Y0dZUzAyaFUvWWlSTGN5c0pvWHBaRUI2czNnRG9qNm9Ec1plSGxESXgxSzd5?=
 =?utf-8?B?cWlOcWR5RTVVUVlCa09UQTFBVkxOa3lPNWxLTVFsN0FpYnF1YkhTSTJvcWNl?=
 =?utf-8?B?UzFOeC8yMzBCclJtd0s2SXdnckIra3dxajV1cGwzbldaNUpzdjBCQlJ5TjMy?=
 =?utf-8?B?VmlEaW1SNEovQWpDNVF3OXRvMUtxT0cybUhsbkRTLzh3U2dJT3lmU0h0YXBN?=
 =?utf-8?B?cjVTMTN6VXR1Tm9hcUNIcVM3c2xMQ2lNcjhjRTNtRzdlU01FSWpoekE2K2c2?=
 =?utf-8?B?bzMxVy9ScTR1VUVPNk5RQVNZVHV2ejkvTVZaRU9PQXIzUmZaZDlmQXJEdW50?=
 =?utf-8?B?TWNONzZBNUxPam1VbCtHY3lRS25rZjdQMGw4SzN1MENHY296L2pvaXVHNmk1?=
 =?utf-8?B?cnJRdUJmdEpGME5XdSt5cUtuSHRyZlNIaitWcWpRTXRLOGtxV0ZwNktTaVk0?=
 =?utf-8?B?OTFZRENxQm05UXJCa05OT1JpMm9pSlpPQXJ3aEs5c2FlNitLb0tTdDRYRDBY?=
 =?utf-8?Q?jDJ9rw7BNyv15JHjf/mhMsdJ15yW+UwVhe/L0nP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2173e023-d69e-4ab9-42dc-08d8e1e7752d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 04:05:49.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+eSgLRCf9JFYpvGAG2DTNVEwSvV/TD5QPhBWSy5VJR9HCrx6ptOES9ic04sdYX3lToOyhK+Ew9OK2EC/00odg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3310
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

