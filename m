Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6EC3A945B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhFPHuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:50:11 -0400
Received: from mail-mw2nam12on2122.outbound.protection.outlook.com ([40.107.244.122]:13793
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232087AbhFPHuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:50:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjj4PAB+fb/KFhKLb9MNr2nqAd5iRRAIImAWncgNcs24Winq+BmURrHWfOSFrJ7tpzEAtq2tQWe+Fwg5WvpWCXifeXSxC2ba44m0cvXCQTaaqBAZB7TxKMemjM+YSy8MXBI888cO6cfk0SiLjlt7kutNlEMV1yEwyiUXGk0mERtbhIwamEeM1lkmohQi2+mI0/B3MzKftMFMh5S6Xj8bTTvpUtOwoPCxFvhibSsnbKEoNZyeEn+22liYpCjqrFgqEO0Kd0rN0zFKFy8t5tWMQNYuIJWmVTfflYBjSH7rH1elduS3VniGbATR7j8W3dazXpo8vbHK43py3w0nlmC4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vd0AfCQO7wSt+2ohDJ3pWs9z5YFLcvAqOFWU+sH8LE=;
 b=XmPaoPBnOk2lhK+LYqBHNmEfdWov+maSk8ZHy1Hvesd7yxc4LPj4ISLp8LIY8rj7yMhLx9pKJuz4zFLne9O9XYHqSkuISYo5Q+mywsFnYR9+eakKkwjZk5hr7icVpic/ki+tcx3dK6T4tqUmQOqLmJTk63y0myZBLFMNFi4ZsLkaqxat4srHWjnj8uQiyknTsF8+nHazCnWK2DJEbDoXQftY2nHlluxMQBIce87dGOyomaxLj/hDl+QT9JkFzJp/QK/dTX3syJx8qiB+DFEvmhFSzYLdGXlTt5p/hRXbTLi/dvKFrWOMnBy4GYeLh2afuBsWSuPczqZTX4VVZh2NZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vd0AfCQO7wSt+2ohDJ3pWs9z5YFLcvAqOFWU+sH8LE=;
 b=TB7W/poP1lg+jLr5NnHaGV8/P8QzEUvE5RzPYs5CUmjhsDraNNaqJ7BUkGyVapqRADZ3pApCFeqAepvfRFQMwQ04LGlIosv0GWmDmuNTfDb8e+Cw16pox5M/OLOsbFMSV+W1xX/e6p0a8Me0LAn2d7fSDj0PstwTDHeK4F0bZzo=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB4582.namprd04.prod.outlook.com (2603:10b6:a03:13::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 07:47:55 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::5c0e:fbe5:2bd6:ec6]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::5c0e:fbe5:2bd6:ec6%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 07:47:55 +0000
Date:   Wed, 16 Jun 2021 15:47:47 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sheng Pan <span@analogixsemi.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v8 0/4] Add MIPI rx DPI support
Message-ID: <cover.1623725300.git.xji@analogixsemi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [60.251.58.79]
X-ClientProxiedBy: TYAPR01CA0093.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::33) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from anxtwsw-Precision-3640-Tower (60.251.58.79) by TYAPR01CA0093.jpnprd01.prod.outlook.com (2603:1096:404:2c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 07:47:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b23771-5719-4a00-fc85-08d9309b0d41
X-MS-TrafficTypeDiagnostic: BYAPR04MB4582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR04MB4582DC8D90F664B4017E23E1C70F9@BYAPR04MB4582.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3MCfoKcQt2IPMHmnci7ESkGRMOx1ChKSVS9VEXPFgOQwua6a0V209TRyDgegDIDq3UzMlM65odxewRVejyfhkSo49xE7GHUcnpgX+vmn/+GtPy4uK2niKu08WdzXTKd00GHyMm8okXvrAk8rA1G6oKPfmBOiZb3sD7UoBCCmDitTPYnDj8Qkm8KtbEGqYrHDNhdL2u+vsKalmzCKeN27TuM+Y/jmlNqz/bMx8cKJahAhoE1RTzO/NquOKatfHTJjFCsBI/uISB7V5nKmSPIN57I0DVppiW7t5sScRSOcyzO5ntxylZyJ9RlbMZD7mb4ug5TtiXY37CPet4gzljcaYby9+HmnzN4DEl1afhGi/vv/aejzn+TOpplXSCPd1m0/XqwolPKRSFwoqu6zA55Lw6K/lpts0Q2UyABfTzCHfrPy5sUZUQP8RckVRZt9FvrLJ1Y23KZAosW/5uszz+BmiHOcVj9NjI7et71Ygr0Y5rQcyXOempS0lkmjZmPhGyVloxMBHlGMMAnURTa8rFGw1nec1hlE5VJter5KmuWTkYzQYLKAbS0/6jslaizP7gmAksRswt5a6m0CEl2WOs5+ub+RICO81xmG9ff4DXfYoRnfusyiR8/kM9Szd8MvAzMz0S/fdGEwAVFXvsDsV/9dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(376002)(366004)(396003)(136003)(52116002)(16526019)(5660300002)(316002)(478600001)(38350700002)(2616005)(4326008)(8676002)(6496006)(66946007)(55236004)(54906003)(110136005)(956004)(83380400001)(8936002)(6486002)(26005)(38100700002)(36756003)(186003)(86362001)(66556008)(6666004)(66476007)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YnX0EDOAFu1GceukktDIl6xVhXhrIj5RZFtW8hfR9V7ehMnksmb+csKBUrUi?=
 =?us-ascii?Q?NwqaTwzve1N2WD2pBwmOC/YVilsdtrMrgRNsOwLkRROAS6J7bOdm7h8ce3L3?=
 =?us-ascii?Q?1BPgCWdTukO5F+DlzuERSBRDCXz8jAg57YCoFqgfF8zwM28bxacj1bryYKDn?=
 =?us-ascii?Q?p7arGTJXcCW4trjWOBwtMOqOVJ00O/jn/Eb6rf6BTppYl07DwNWU0u6KaAq8?=
 =?us-ascii?Q?Bc/fdTWxyP2v2OOr7PYou+WQ4g+V7a/9gZbVa2PFYQ9ilJEwsv1e53u6Gp3O?=
 =?us-ascii?Q?WFUnVJ8rgOR1ghLhtEJXyvZauYKF5sHc4au7t6/DqlKqjLDvKRxs1oHBILs5?=
 =?us-ascii?Q?o3b8bTd+jUf0Wnh7xfOh8HfRAhDJSmww+SkZUHo1KBVDGFn21SVoI2IPlpMO?=
 =?us-ascii?Q?rss2nu+U7XQp8JLBVKyo8tm3SqIu9IOmxUiot60EDB5DUp0qX/O2PbLLBaRN?=
 =?us-ascii?Q?r4q9XpbrX0b2FbaZPkol3wak7CaO07rFPIV2sbFuMVkA8IL8J+kRl9xUEGvC?=
 =?us-ascii?Q?kkU2YdJZhNXxrs5jnNsngE2F1xjuabaXAIcokWtBoXKfmBMKQc5v/V1s4JhN?=
 =?us-ascii?Q?EBfTyHhbB3/KMuQ5FEVvHU6H8vBb8Lx7fe5VMuMdOGf+O9JN5eSQMMBVtpS7?=
 =?us-ascii?Q?rwo8uhef6Pd95zUwOJJJohMQrtmF5OvRwCKVqsDJyukkDpsnPjgk9sumZbTB?=
 =?us-ascii?Q?XUGBpU8OPs3EyDJ3KA86ScAtkEWpPnph6gCrv3VWXQ3MqxO5aAlzHv6aVBT7?=
 =?us-ascii?Q?91zoIZgieVeLDNU43mTRpRtGtoMv/gbwXfUiVe52eHQAz1BEGxKyZzPGB43U?=
 =?us-ascii?Q?xGkIm6HoddDOK+Xz9+Rw4Dz+chYbyiUe6DJFOno6Rsdl3sdj96VfcvrV1k0a?=
 =?us-ascii?Q?6hVf8Zpi0SdEO5637Un+w9Nkr6AaDokSAxwS3RxPQh350ZcpYsoNU9DN3ZPE?=
 =?us-ascii?Q?6Ettx/xFeXNrZLfOK5rolE4OS0Y7ULA2fpgta5xnIha1DE1wFFEDuF74OUjO?=
 =?us-ascii?Q?nAjtNj8f6UQUftSD2uGrGjaaJ0oujTxqN5yn6WZHrfOI2V+wGirX5oEMMwqU?=
 =?us-ascii?Q?kWRN2GPZzX001NL7cH+OlQTCR0AcWjbiIn91aFl9gNDDk6MegDYcRkAmMeL6?=
 =?us-ascii?Q?HpJDrR9NZQYOkA1Il/YTyVy3HBceYXbW05fyPNQDPbeQPs/WuKZuvi+zRQ+5?=
 =?us-ascii?Q?qxfwseXrMqwai+YycxPyAJ5NujlmgEdSQCgh7/hFS9AXhm72ftCtCxy3/Y9R?=
 =?us-ascii?Q?7loIl1P4BVjfie3pvSF/xaMt5+FA7SCzi2bC8YEl0vXNzeEerhJ5yoFvbAeO?=
 =?us-ascii?Q?OvY5av394j2RV1HzfQRbCOIh?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b23771-5719-4a00-fc85-08d9309b0d41
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 07:47:55.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUMY/wmIEdCuqnnkPMv26Fi/b+PW+jtBMgLpH9ks67+UtXunSFWwLCgGU2SkN8T+BjLVu8CCdbFTbu4yrXjuhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4582
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this patch series implement MIPI rx DPI feature. Please help to review.

This is the v8 version, rebase DT on the latest code,
removed HDCP patch(I'll upload HDCP feature by a new patch).
Any mistakes, please let me know, I'll fix it in the next series.

Change history:
v8: Fix Laurent Pinchart comment
 - Expand the commit message

v7:
 - Rebase DT on the latest branch 'drm-misc-next'.
 - Remove HDCP patch.

v6: Fix kernel robot compile warning

v5: Fix Rob Herring, Hsin-Yi, Robert Foss comments
 - Rebase code on the branch 'drm-misc-next', refer video-interfaces.yaml
 - Seprate HDCP function to a new patch
 - Fix driver not correctly get 'bus-type' 'data-lanes'
 - Add audio HDMI codec function support

v4: Fix Rob Herring comment
 - Rebase code on the branch 'drm-misc-next'
 - Change 'analogix,hdcp-support' type to boolean

v3: Fix Rob Herring, Dan Carpenter, Nicolas comment
 - Split the patch, fix not correct return data
 - Fix several coding format
 - Split DP tx swing register setting to two property
 - Add HDCP support vender flag
 - remove 'analogix,swing-setting' and 'analogix,mipi-dpi-in' property

v2: Fix Rob Herring comment
 - Fix yamllint warnings/errors in analogix,anx7625.yaml
 - Fix kernel robot compile warning

v1: initial MIPI rx DPI feature support

Xin Ji (4):
  dt-bindings:drm/bridge:anx7625:add vendor define flags
  drm/bridge: anx7625: fix not correct return value
  drm/bridge: anx7625: add MIPI DPI input feature
  drm/bridge: anx7625: add HDMI audio function

 .../display/bridge/analogix,anx7625.yaml      |  57 ++-
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 458 ++++++++++++++++--
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  23 +-
 3 files changed, 484 insertions(+), 54 deletions(-)

-- 
2.25.1

