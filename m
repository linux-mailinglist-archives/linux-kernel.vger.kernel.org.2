Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA53C35BC64
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhDLImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:42:43 -0400
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:14374
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237282AbhDLImm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:42:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFywYmsUwlittg3yM9PgPhgV3CYYw1eFETJyDWtqzKhqWtB3RVeulzaHTO2wJ1iCuMtWh4WHoWoF5cMD1OdCTVGZscIjM/27boPcyZJKKug3VbnGkATIlrhfmCe6MBL06E8jQuD5SnwJg6hxz6s4NoASZoxDw4/2c+DEiJaOZBHj3zZ8YKob6Ec3GmgLIdTdo8XKJdG7SnPxYzaj0laJ2M02zQ4L6jQM4T0+2Rwh1UHd84WytZYZl6LCQJw2kVeIlMUUTVI/nGraogTiXyyxYtspMPHbw9xzZJ+1X801Sj7CR0YBDm05yQoLqoL/DP/0DPDxNGUAm5xMEvC+ynSCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR2SW0p0oaGIfUN/tA4tw6hvkBKrLFiWSG1BsYCkM1M=;
 b=LmiDkz69Mdf/AyI3F64YGAemgAqjO0X5l8NZbbvJ3B4nf58lulwm6pMuoDh0DfaTauLVHClnOi4r5pR9AyMsHKchVGmBvlOC+Eh/aFXr5EnP7hnXT7Y/dw1AkMgc1ay69fppovfNIhqSZnUfpXfYugcf+BUIz0ZcwlM7niYK+dUyR9lcvhwX9XJrHkBTUXc4cY3WU1SRYNqmdxPXaaFV1xPxCxHZX6iQ8DmNaMEcfjXGmXGfzGgK0yb5NPcc8pTt8Uf6fTqKhfbyLSAxgA867Ju4ied/rbZZOl8D+8nkqD9anGrjkC5FS8ifFG730aMf6FyLbR5wTgC1k07pFjRV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR2SW0p0oaGIfUN/tA4tw6hvkBKrLFiWSG1BsYCkM1M=;
 b=mMjsQ81ryD0K7ktvlaFa576zIw3IDwwS8qu/m9Tn3ZWNQROtffrdjDfK/q2chDBWZhFO67n7cHMG6//WdcIutkJAl7ZaEpf+DkDAOlNoy5mm7ZZdF7SI2NEmP9Qp+TR2qKLBaIrxxpBRfUXkfYPX6JNbIiXmD9llKVhMxbiOw4g=
Authentication-Results: sigxcpu.org; dkim=none (message not signed)
 header.d=none;sigxcpu.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5455.eurprd04.prod.outlook.com (2603:10a6:803:ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 08:42:22 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 08:42:21 +0000
Message-ID: <3ae6e6413901cbc9e432c7057db8fb9e81e56f39.camel@nxp.com>
Subject: Re: [PATCH v5 1/2] phy: core: Use runtime pm during configure too
From:   Liu Ying <victor.liu@nxp.com>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 12 Apr 2021 16:40:56 +0800
In-Reply-To: <2de2ee26bbf443491dfff1c802f2fa9efaf58d52.1617968250.git.agx@sigxcpu.org>
References: <cover.1617968250.git.agx@sigxcpu.org>
         <2de2ee26bbf443491dfff1c802f2fa9efaf58d52.1617968250.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1 via Frontend Transport; Mon, 12 Apr 2021 08:42:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af030a7-8555-44f1-0c52-08d8fd8ee351
X-MS-TrafficTypeDiagnostic: VI1PR04MB5455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5455C40AEED4E3A34F89F48F98709@VI1PR04MB5455.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7fjg75C0pulF5lMgXVTKeRirN88h+l1GgIwlscYCG7/wVqMC3OBz2Pk+QuIuMzLgYjBwKDMYU/UsvAaUtfkO0uytsZE0WRPdtTCDR5I1jqwWs/CiDHGFpZIl8hsVNRxRbPg2kCc+ymjLlgXqwfJBJJQAyqdAR/qm+rLCH02Ry1cE7FaC3L0IuEy+v+0EdW0IcrSL1LL3uo7wLfaQBpVBD4kvmU8SoVfc6M4yWsTgdRaWGlQGBwSj9cfI+5EtK1kpGHYBjAZ1AOylvbxzj/p6vVqbvLCRITHhgltn/cYhwF08n9kvzl+XdnbY7w9zzXyvbDuSyceoMK8qKHkjjW1dPl2mf8nBfFcxNLCAGrqKxSJTOXMCRvcs2pp4uNBVv9jUYX9F44P228yQ/SL/cYxcu9/bYdSClMP8x7cuO5NEcJVLwbvRwXWi6rSmHGVc/jbxp8dj5vP4a7eOrwDKO3h6/9BXtcE6qPn9w3RaiYrXeXG/88fYZ5/KBLZvKsVWx5aMGsiTDW7sPxwx1AqZyOrdTmT9YlLtj9ef0zktM9Dr9zgaGIb6pw7sKEBCe5abFEh4iBKS0AhJ8BwJWdG5Jcz3GfRiJ+WOZg1mTZC/xO3YIfSi0cimEdBmFAFMsQhMLBjf8+EO7G9dwWQZiRrD50YAzBNTXvXNtcJmol42CiiW4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(66574015)(86362001)(83380400001)(52116002)(66946007)(16526019)(8936002)(956004)(110136005)(186003)(66476007)(2616005)(38350700002)(26005)(316002)(6666004)(8676002)(5660300002)(6486002)(6496006)(478600001)(2906002)(66556008)(36756003)(921005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aDlOTkJvU2psbzdSNkpZaTZhZFRSdjRRN3ZOYnB3ZEdCVDFNWWJodVAxNERa?=
 =?utf-8?B?VGYvZDJsbUFiMk8xSS9OVGszTjhvN1FpNXJ3eGxzOVRvSHg3OW94cE9NcE1y?=
 =?utf-8?B?VDdhNnRsR0ZmcExIR1k5YzZSMStJeW9OVzZTcDRKZDVpVUd3d1FqWFkvTGpx?=
 =?utf-8?B?V2R2WXFkdXNMWHROZ0orUnlXTHFldU5rWlhHMGJLaWlTVHRjNHlYS2xFdWNX?=
 =?utf-8?B?YVNZUzBVcmdRTlR5R0NmNk9BcmwybVAzWU9KYmRhR1VxZEJIdS9mamNWRFQ3?=
 =?utf-8?B?YWh2RXZFNWZkdXZvN3FsWU52bVJjR3ZWTUcxTVhMYVlVb1dlMTIvcmw0QUZz?=
 =?utf-8?B?M3N1MlBPUnRmSWFpOTBXcGt5dzNUdVFicnVtSVhhOWhIR0NVVzNGLy9ybkt3?=
 =?utf-8?B?NzhiTWhVYWtqaTNTS0lkWXpxOHd1Q2tpSjE3VTZxQVNCcWlwTkhuNGdLaUFt?=
 =?utf-8?B?dzdTOE4zKzEra0d4WVVhczdobGRjNzJ4TjNKOXdJUjErUzU0WFAyMnF2RGVL?=
 =?utf-8?B?ZDJNd3hqcHRQSjJ2OGZUOVpWZWZSekZBU2tBL1ZQMnhLWE00L3FvajJrVXF0?=
 =?utf-8?B?dWpzZUdjbFhDL29YTGxqcXl5S2xhYlYwSzNMUllHQncyOEZhd2ZDZDdlR0tJ?=
 =?utf-8?B?cFBINUZ1VXkwOXdwNitjVlR6bU9WYUxyRjVKRVQyeWRqWjR4NWlCUEplcVpE?=
 =?utf-8?B?TVdCWjFKQWRjRSswNC9ld3YrNVlLNkEzNGFYcFF3TWtRSzNYOGR0M21xZHl4?=
 =?utf-8?B?cGN0M2JBa3VUUFpDVTM1TTN2bDJGZHJabXNLZUFJSmFKYTEvTTVhQTViQm8z?=
 =?utf-8?B?ZWRpQkppeUZwT01WbnRJUG8zRkZyU1d1WUVMQkcrV2xaZldFT1pDQVRRRmdR?=
 =?utf-8?B?QmJ4aWFvYlo2NzZ0K2dVRWhja2R5ZHhUNWc2bldYczFuaHhpYURiY1JwcWZD?=
 =?utf-8?B?SHllekRQM3lMNXh6RGx4bndvTmRHR2k1RTZuSytBNG53Vm9aTlBESFhXRS8z?=
 =?utf-8?B?dS9NMDZtQjdBWHRwYUNPWW5JVW5sWHdmVFFVK3dxL0xrbnNPdEVnbzBvYWl4?=
 =?utf-8?B?NUNRNDRvODIxYXNBVUtxeHZLYlgwS2ZXTk5TUVNWTEpacWxKVGtqdHNwUVBU?=
 =?utf-8?B?SXBvbXdxeHZCOTViWHpZbGl5ZGpvUzdQN3hxcDBLbWlLeU9CalUvdHZNZHpn?=
 =?utf-8?B?MDRWVFdOSi9WTXRGSWpvZC8vK29abm15dlZlNXZKZXpxUVBRUm13U29WQ3NJ?=
 =?utf-8?B?ZzlJMUx0RE0wS08rTll2MmhsNnFzSU9iMXNMZjhJNDZ0Uy9zeXZlN3RFcG9G?=
 =?utf-8?B?Mks4bU9PQVlFenVxOTFxeXZmQmFUWENqVk91WTRGck1xSmRyN3RzNXJjcEJt?=
 =?utf-8?B?VTRwaU4rdEs3UmZtVXk3dFFuRUV3Z2VjakNuWnR1dm5BWUVwS1g4SGZvN09s?=
 =?utf-8?B?WWhIbmo2MHlXaldaQUQ1dE9ja05aTzBDTWJkdzZINFgxMjYzTjYxekVSMEpC?=
 =?utf-8?B?VUFac0JiQjNTY2ZrZ0doejNGd3NZSE1YMkJGRC9hZGdaVytZeVhFNitlZlVp?=
 =?utf-8?B?bk53TWREdVZnNmNiZTBWYzBMQllOeHpleE9OeER1c294RCtsbmxRVXp5RFcr?=
 =?utf-8?B?R2xQSFJEY1Z4elpzMitnb1Q1MkdpZ0kxYXpWTWJoUUI2bHdpamM2NU56S2JZ?=
 =?utf-8?B?WWdVcTRNd3RNbEpwSFlNb0d1c0VNQURaOWQyS2Q5dHpJWU1OL0ROVml6aFNv?=
 =?utf-8?Q?cf0wqA71zjDBmZi49vIwtjPwMuGcWPUkuMPj0GJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af030a7-8555-44f1-0c52-08d8fd8ee351
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 08:42:21.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9wmdLx6t4zE5B0JAbciJSBnV2EGhfo6dTb+iaVKcV8RR3+NNg/qfEihB3lKldYKa5Y0okiQE+2qhayvvx2gbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5455
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Fri, 2021-04-09 at 13:40 +0200, Guido Günther wrote:
> The phy's configure phase usually needs register access so taking the
> device out of pm_runtime suspend looks useful.
> 
> There's currently two in tree drivers using runtime pm and .configure
> (qualcomm/phy-qcom-qmp.c, rockchip/phy-rockchip-inno-dsidphy.c) but both
> don't use the phy layers 'transparent' runtime phy_pm_runtime handling
> but manage it manually so this will for now only affect the
> phy-fsl-imx8-mipi-dphy driver.

IIUC, the qualcomm one's runtime PM is managed by the phy core when
users enable it using power/control in sysfs(see comment just before
pm_runtime_forbid() in that driver).
I'm assuming it's affected and it would be good to test it.

I'm not pretty sure if the rockchip one is affected or not, because I'm
assuming the power/control nodes of phy->dev and phy->parent.dev in
sysfs are both 'auto' after the driver probes.

> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/phy/phy-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index ccb575b13777..256a964d52d3 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -470,10 +470,16 @@ int phy_configure(struct phy *phy, union phy_configure_opts *opts)
>  	if (!phy->ops->configure)
>  		return -EOPNOTSUPP;
>  
> +	ret = phy_pm_runtime_get_sync(phy);
> +	if (ret < 0 && ret != -ENOTSUPP)
> +		return ret;
> +	ret = 0; /* Override possible ret == -ENOTSUPP */

This override is not needed, because 'ret' will be the return value of
phy->ops->configure() right below.

Regards,
Liu Ying

> +
>  	mutex_lock(&phy->mutex);
>  	ret = phy->ops->configure(phy, opts);
>  	mutex_unlock(&phy->mutex);
>  
> +	phy_pm_runtime_put(phy);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(phy_configure);

