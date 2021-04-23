Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F659368FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhDWJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:49:23 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:45286
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229811AbhDWJtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYNVAocEsO391O3kOec1JbNbkQiLyN5kaIuIOk5TXxFC+voqTTwjZQnaHC26g5WFj6GssG4ahgH00qv5bzx9lHyp3Nw216qDt9DqlQDB0Vcrd2hUwNdat/AKxn+TD46tolZvbWh1EOYQvL0QW9uDtfSJH1yCox+83XtO8vFdsg33lfbCDXP4UK9jAwA+ybXpcOWYR8vgWH4YHEI9ShPkWcp8gtkBHpekAMfQF7qmIKFP5Dpzx0XBIG8Sy1XWdwohsVN8/avuYoeUYyJD+Bzq0SmCErpCZg8z8I6oS2aIsDI8hlBr5lLiIXPCTeF01v0MDgOrpz28953lKq2cHAVocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx9olTIqv6LIdMiRXlhwPmvSd3zMCmMxA08pDYwarHE=;
 b=SeUBjoj80q2XUKH2U/ygVx+/kB/YMMx5GK+ikQRBgaQsgV07zS4P/G1ERejBcuzm3AJFQ9zqNuZHjanlIIEcPQ+89yOwYk4itYt55FIRUqCdpLY69Em4Fz6usjzfDtMe5wBUz+6ekYcbQsCuBRTF7yKKxLHEoJQtg3bqUiE13Rp+1VMEWvMe+pc9ZgzgFwUdKuE677G2zjJgvKMQKHYtvO3iHBnYIm/9YwB7A+Abee2GZcgHsJLPTchbqeSRuCdil5TWubtd3+gsh4aw+LIjryFb2+SjHKniDniinEAPGO45pAIeJPZLhpquW65oO9QXBPNt73whvQ+s//16K6K2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx9olTIqv6LIdMiRXlhwPmvSd3zMCmMxA08pDYwarHE=;
 b=ZQX8x0vmdCyfPWbiBpLZITHBI/b5O3s4deW8eegnvREXWbG63uH+ilDmQtZ03CF8UeUuWJ86KZirNXB5j5SUjgi0Gty3d/I2MnTPAedmOYRCRnM0nHOQ33OCF4CZQFailTV8gX5rWTXYo7XEW0EKleWlOznwYAizEWWCDd4dpR8=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0401MB2319.eurprd04.prod.outlook.com (2603:10a6:800:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 23 Apr
 2021 09:48:43 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28%7]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 09:48:43 +0000
Message-ID: <dc1b3cd249c6808e58b829d812973c3ff23fc31e.camel@nxp.com>
Subject: Re: [PATCH v2] drm/bridge: nwl-dsi: Get MIPI DSI controller and PHY
 ready in ->mode_set()
From:   Liu Ying <victor.liu@nxp.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Fri, 23 Apr 2021 17:47:11 +0800
In-Reply-To: <178556dc-a011-e1e6-4147-dbf584672d32@baylibre.com>
References: <1619068455-1932-1-git-send-email-victor.liu@nxp.com>
         <36441ffb-2a79-f965-efc8-042844bc349d@baylibre.com>
         <460bdf3547942fdca82a19e164162187917e4d57.camel@nxp.com>
         <178556dc-a011-e1e6-4147-dbf584672d32@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by HK2PR02CA0156.apcprd02.prod.outlook.com (2603:1096:201:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 09:48:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf87d5b6-d7be-49e7-35a1-08d9063cfb5a
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23193BA38FCC61015AFBD8DF98459@VI1PR0401MB2319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSjnZeRIVdGEXvlxxXN7fhb+KgpHgIDl3z+lVWIb6yZmQyx+YUfifxMcCgJWS7I6GDCM894av0Hf63NsK5NY/M2X6nySwA+0CbaV/BTvIS/22eGQq+B3db0/3fDdZ48nT4JBQPS9aePPmS0oSNsPbppjMcMssH9/D12rv64/SVjNrZliAe0ibn1rIeQ4ylVl4r+ctyyymhBr8LZILyzunbMpA3hUW0S8/mH14kyMjvW7MbazasmmM2Q/PvRNRQ4Q6eUlaKi3lNgn2OheQH1oqhViMbZohDxNoeF+zY/Ozs/EPsf2X7Cj8sgHb//DANS3GWdjd6IrDtdvBb06vXJWryls1vVPnjTWWZLC7DCAsc5kqJtgGJqzQ5FESNRnlDyC8GFZb59myO2bSI0qWry5Dllx59utw4XJtIZ9sUD1c/hjzHWSrQ0C5BGWfWUK+Bc1drmsPIwYrNPCOzQQbW782jVV2NSaiqWM6t00acxwd9LnyCctpLYtg3djSCa2Zg7OG35s9eWVY91chpV3PZCuG/6U2ch9tmId4bOJB9Axetm1+T8zQ+a4XJKV8oXxfpFw4jiZKxDXwhXexyZQpqL+ssxQWRhUON7zwPSedLgKD0cU1M4dxV7ioGB8l5E0rX0J5lXaeJSNsW43S615R/+Qwnc0AZt3TnLFxDDEJj4ceiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(316002)(2616005)(2906002)(6496006)(956004)(52116002)(53546011)(8936002)(86362001)(54906003)(7416002)(66476007)(66946007)(38350700002)(38100700002)(478600001)(83380400001)(5660300002)(6666004)(8676002)(26005)(4326008)(186003)(16526019)(6486002)(36756003)(66556008)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aDMwSVVaSjBGQlliZ0JSY3Y5YThvWWVHRUNremMzUno3RWoybit3QW14cnB1?=
 =?utf-8?B?U2lNbWl6U29Sb1pJdmZ2THpNenJid2xyaEUwNm5LWFZuRjliUnJ0QlNVb2tU?=
 =?utf-8?B?akhHTHBBRmh2c1lNN0ZkUXdkT2pFNUdNemVEQUxlOTBnRFNSa1RDd1hxVFBv?=
 =?utf-8?B?N1JJcDBibEdpQ2NBbjJqanVtb1pkQ3RYUTRnVVVPbWNub0g1ZzYwZ3lET3Bj?=
 =?utf-8?B?bTRvQXJzRkZPeXNRSGJGVGZ0SHJqUEJmaGNla2hUZmZRMVl6enBTQnpYQnBH?=
 =?utf-8?B?UGFNcjU4UGg0U2VSMWtTc0xYWGhQRTlUY0djQWJIMjdORkgxS2lGUm5ibDUr?=
 =?utf-8?B?NjVXNm56QU9zTHRmYXFnaWllYzIzRnFhY0tEUHBOY1g4NWRQSmZORjkyVWU3?=
 =?utf-8?B?MWxydHprSzBBTEl1RmkzZkVubkZhdVlwRzlSWHJmbzVjeVFWSlhudW4vRkdS?=
 =?utf-8?B?NFdrV1RRQkdYclc0bmRyUUtPdnQwUWtCd0xTZHBoa21SeVBJTm9nQ1hMZzlX?=
 =?utf-8?B?T1V1N0hGMGdCb25Bb0pzTUxSU2Q5QVR2eDlzS1FNdGgvdmk3RVF3bGN0a3Jz?=
 =?utf-8?B?RlQrcWQwNG1LaG1LZWJBTnMwRU5LKzZTMVo1aXFPaks5b2J4UU95M3VnOVkr?=
 =?utf-8?B?RkZOQUVianpGMThKdU5hcEs1NWtCUWRQQUlIMlA0UGNUUFhOYnVDdld3c1F0?=
 =?utf-8?B?N0gvZEFZYzlhLzBqYmJ5NWJoclJES3VjdjRUc3VIUEtWb0lBRVBlRkZPY0VL?=
 =?utf-8?B?dDNoQlNwNXlNdmpZQ0JOT2dyTEpzb2lhOEtRc2VscTZNa1orMXRyVGFwL09v?=
 =?utf-8?B?U0ZkWjNwaXdJRW9BcHBmSy82bVI4UWJHeG1UT0RvRkVzb3FvWFhvWERYeDRN?=
 =?utf-8?B?WU1TZmVSbGpzWGEveXhPN3hycWVlUzhDb3ljb0E5dVdQYjcvUTY0WjBCdDFH?=
 =?utf-8?B?TUhYNWE0Y3JrTUZxQUM5b0ZxK0FVdG5mYk1hSjNMWXBiOXVuOTJ0SHk3aGp2?=
 =?utf-8?B?V0d2SjU1QkMxVFMzV2pVM2lPZ2U1bDRGRkVPWkRNWmI0SnE3TWZjUXhwbkFJ?=
 =?utf-8?B?b0E4VEM4NHpEclY3Snp6V3RCRDFoTmlJcTJFemoxcGhkdGhwazNKK2dSSVlN?=
 =?utf-8?B?Y0l4NDhQNWQzM1BuMHBiaEEydkl2Z3NsNldrQml6SXNBVk5BMGlrODdEUlpH?=
 =?utf-8?B?MjBMajdoYWZQVGY2WGUzcDMrWjhoWWdNTlExWi9hd09nTFJRQkQ0SU9OWmNs?=
 =?utf-8?B?SzJ1TGVoeEJPdG1HakJteWVHN0ZieGZQSWRxR0ZQU3lQK2RkSTlUdU5sZU1N?=
 =?utf-8?B?YldrT3V0ZW1iMnRSUjdnTnp1Mml5Y0VKOGl0K2lyMFdyTTVPRHRsa1lDc05B?=
 =?utf-8?B?aHZLNFFYSVdCZWRRMVFYYXFJT2dLeDVodDNvY2JMVE15Sk1FSjRJaFNQOGcv?=
 =?utf-8?B?aGVYZ1dXK29iZ3RTOCtEeXk1VWFrNEVETmpVZWFUcEJySG1XZ25mdDBEZGU0?=
 =?utf-8?B?anBxYUU5Zzl1c1RQSzlQNWJxK1IzQXlKNzkxR1l2TGJtZWxiQmd0WjhPc2p3?=
 =?utf-8?B?ajRGWldpYUdXY3gvenBtbWI1T1hXRkdDdUZWQkVPME9DSkdWVlhLZ2VTVUJQ?=
 =?utf-8?B?SjdiTlN3dGVnS2sxN3ZEazRSWGdJV1Bhc1lOU2I2MDNlTS9hWE9SaVpmcXc0?=
 =?utf-8?B?ZHJhOTBKcEV3WUdCblA0M29VNjd0OEFTaEFjMUpyUXB6R0prOHltM1dIcDFL?=
 =?utf-8?Q?SiHBAhlQJipmN/ni+EkJMdpp4k01EZXNogT/Q8+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf87d5b6-d7be-49e7-35a1-08d9063cfb5a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 09:48:43.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/LRkXKbzTsgqZFARlxE27Mdcmi3a0IPUmezmBq/Kq5y/YoPvgxzwfwaftKTGjXQqpJnSc3VvJ1b8eDgUxsNsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, 2021-04-22 at 14:07 +0200, Neil Armstrong wrote:
> Hi,
> 
> On 22/04/2021 11:31, Liu Ying wrote:
> > Hi Neil,
> > 
> > On Thu, 2021-04-22 at 10:48 +0200, Neil Armstrong wrote:
> > > Hi,
> > > 
> > > On 22/04/2021 07:14, Liu Ying wrote:
> > > > Some MIPI DSI panel drivers like 'raydium,rm68200' send
> > > > MIPI_DCS_SET_DISPLAY_ON commands in panel_funcs->prepare(), which
> > > > requires the MIPI DSI controller and PHY to be ready beforehand.
> > > > Without this patch, the nwl-dsi driver gets the MIPI DSI controller
> > > > and PHY ready in bridge_funcs->pre_enable(), which happens after
> > > > the panel_funcs->prepare(). So, this patch shifts the bridge operation
> > > > ealier from bridge_funcs->pre_enable() to bridge_funcs->mode_set().
> > > 
> > > This makes sense, this is how we do on the synopsys dw mipi dsi driver.
> > > 
> > > > This way, more MIPI DSI panels can connect to this nwl-dsi bridge.
> > > > Care is taken to make sure bridge_funcs->mode_set()/atomic_disable()
> > > > are called in pairs, which includes removing a check on unchanged HS
> > > > clock rate and forcing a full modeset when only connector's DPMS is
> > > > brought out of "Off" status.
> > > 
> > > I would split the changes in multiple patches to clarify the changes.
> > 
> > Maybe, I can split this into the below 3 patches:
> > 1) Remove a check on unchanged HS clock rate from ->mode_set().
> > 2) Force a full modeset when only connector's DPMS is brought out of
> > "Off" status. This will be done in ->atomic_check() together with the
> > fixup for H/VSYNC polarities.
> > 3) Shift the bridge operation as the last step.
> > 
> > I'll mention that 1) & 2) are needed by 3) in their commit message.
> 
> Sure, you can also put this split explanation in the cover letter.
> 
> > Does this split-up sound reasonable?
> 
> Yes makes sense, thanks

I've sent v3 to do the split-up.
I actually swap 1) and 2), which is trivial I assume.

Regards,
Liu Ying

> 
> Neil
> 
> > Thanks,
> > Liu Ying
> > 
> > > Neil
> > > 
> > > > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > > > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > > > Cc: Robert Foss <robert.foss@linaro.org>
> > > > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > > > Cc: Jonas Karlman <jonas@kwiboo.se>
> > > > Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: Guido Günther <agx@sigxcpu.org>
> > > > Cc: Robert Chiras <robert.chiras@nxp.com>
> > > > Cc: NXP Linux Team <linux-imx@nxp.com>
> > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > ---
> > > > v1->v2:
> > > > * Fix commit message typo - s/unchange/unchanged/
> > > > 
> > > >  drivers/gpu/drm/bridge/nwl-dsi.c | 86 +++++++++++++++++++++-------------------
> > > >  1 file changed, 46 insertions(+), 40 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> > > > index be6bfc5..229f0b1 100644
> > > > --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> > > > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > > > @@ -21,6 +21,7 @@
> > > >  #include <linux/sys_soc.h>
> > > >  #include <linux/time64.h>
> > > >  
> > > > +#include <drm/drm_atomic_state_helper.h>
> > > >  #include <drm/drm_bridge.h>
> > > >  #include <drm/drm_mipi_dsi.h>
> > > >  #include <drm/drm_of.h>
> > > > @@ -661,7 +662,7 @@ static irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
> > > >  	return IRQ_HANDLED;
> > > >  }
> > > >  
> > > > -static int nwl_dsi_enable(struct nwl_dsi *dsi)
> > > > +static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
> > > >  {
> > > >  	struct device *dev = dsi->dev;
> > > >  	union phy_configure_opts *phy_cfg = &dsi->phy_cfg;
> > > > @@ -748,7 +749,9 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static void nwl_dsi_bridge_disable(struct drm_bridge *bridge)
> > > > +static void
> > > > +nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> > > > +			      struct drm_bridge_state *old_bridge_state)
> > > >  {
> > > >  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > > >  	int ret;
> > > > @@ -809,17 +812,6 @@ static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
> > > > -				      const struct drm_display_mode *mode,
> > > > -				      struct drm_display_mode *adjusted_mode)
> > > > -{
> > > > -	/* At least LCDIF + NWL needs active high sync */
> > > > -	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> > > > -	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> > > > -
> > > > -	return true;
> > > > -}
> > > > -
> > > >  static enum drm_mode_status
> > > >  nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
> > > >  			  const struct drm_display_info *info,
> > > > @@ -837,6 +829,29 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
> > > >  	return MODE_OK;
> > > >  }
> > > >  
> > > > +static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
> > > > +				       struct drm_bridge_state *bridge_state,
> > > > +				       struct drm_crtc_state *crtc_state,
> > > > +				       struct drm_connector_state *conn_state)
> > > > +{
> > > > +	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
> > > > +
> > > > +	/* At least LCDIF + NWL needs active high sync */
> > > > +	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> > > > +	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> > > > +
> > > > +	/*
> > > > +	 * Do a full modeset if crtc_state->active is changed to be true.
> > > > +	 * This ensures our ->mode_set() is called to get the DSI controller
> > > > +	 * and the PHY ready to send DCS commands, when only the connector's
> > > > +	 * DPMS is brought out of "Off" status.
> > > > +	 */
> > > > +	if (crtc_state->active_changed && crtc_state->active)
> > > > +		crtc_state->mode_changed = true;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static void
> > > >  nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> > > >  			const struct drm_display_mode *mode,
> > > > @@ -852,13 +867,6 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> > > >  	if (ret < 0)
> > > >  		return;
> > > >  
> > > > -	/*
> > > > -	 * If hs clock is unchanged, we're all good - all parameters are
> > > > -	 * derived from it atm.
> > > > -	 */
> > > > -	if (new_cfg.mipi_dphy.hs_clk_rate == dsi->phy_cfg.mipi_dphy.hs_clk_rate)
> > > > -		return;
> > > > -
> > > >  	phy_ref_rate = clk_get_rate(dsi->phy_ref_clk);
> > > >  	DRM_DEV_DEBUG_DRIVER(dev, "PHY at ref rate: %lu\n", phy_ref_rate);
> > > >  	/* Save the new desired phy config */
> > > > @@ -866,14 +874,8 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> > > >  
> > > >  	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
> > > >  	drm_mode_debug_printmodeline(adjusted_mode);
> > > > -}
> > > >  
> > > > -static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> > > > -{
> > > > -	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > > > -	int ret;
> > > > -
> > > > -	pm_runtime_get_sync(dsi->dev);
> > > > +	pm_runtime_get_sync(dev);
> > > >  
> > > >  	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
> > > >  		return;
> > > > @@ -883,27 +885,29 @@ static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> > > >  	/* Step 1 from DSI reset-out instructions */
> > > >  	ret = reset_control_deassert(dsi->rst_pclk);
> > > >  	if (ret < 0) {
> > > > -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert PCLK: %d\n", ret);
> > > > +		DRM_DEV_ERROR(dev, "Failed to deassert PCLK: %d\n", ret);
> > > >  		return;
> > > >  	}
> > > >  
> > > >  	/* Step 2 from DSI reset-out instructions */
> > > > -	nwl_dsi_enable(dsi);
> > > > +	nwl_dsi_mode_set(dsi);
> > > >  
> > > >  	/* Step 3 from DSI reset-out instructions */
> > > >  	ret = reset_control_deassert(dsi->rst_esc);
> > > >  	if (ret < 0) {
> > > > -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert ESC: %d\n", ret);
> > > > +		DRM_DEV_ERROR(dev, "Failed to deassert ESC: %d\n", ret);
> > > >  		return;
> > > >  	}
> > > >  	ret = reset_control_deassert(dsi->rst_byte);
> > > >  	if (ret < 0) {
> > > > -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert BYTE: %d\n", ret);
> > > > +		DRM_DEV_ERROR(dev, "Failed to deassert BYTE: %d\n", ret);
> > > >  		return;
> > > >  	}
> > > >  }
> > > >  
> > > > -static void nwl_dsi_bridge_enable(struct drm_bridge *bridge)
> > > > +static void
> > > > +nwl_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> > > > +			     struct drm_bridge_state *old_bridge_state)
> > > >  {
> > > >  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > > >  	int ret;
> > > > @@ -948,14 +952,16 @@ static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
> > > >  }
> > > >  
> > > >  static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
> > > > -	.pre_enable = nwl_dsi_bridge_pre_enable,
> > > > -	.enable     = nwl_dsi_bridge_enable,
> > > > -	.disable    = nwl_dsi_bridge_disable,
> > > > -	.mode_fixup = nwl_dsi_bridge_mode_fixup,
> > > > -	.mode_set   = nwl_dsi_bridge_mode_set,
> > > > -	.mode_valid = nwl_dsi_bridge_mode_valid,
> > > > -	.attach	    = nwl_dsi_bridge_attach,
> > > > -	.detach	    = nwl_dsi_bridge_detach,
> > > > +	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
> > > > +	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> > > > +	.atomic_reset		= drm_atomic_helper_bridge_reset,
> > > > +	.atomic_check		= nwl_dsi_bridge_atomic_check,
> > > > +	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
> > > > +	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
> > > > +	.mode_set		= nwl_dsi_bridge_mode_set,
> > > > +	.mode_valid		= nwl_dsi_bridge_mode_valid,
> > > > +	.attach			= nwl_dsi_bridge_attach,
> > > > +	.detach			= nwl_dsi_bridge_detach,
> > > >  };
> > > >  
> > > >  static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
> > > > 

