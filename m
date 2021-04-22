Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A7D367DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhDVJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:33:36 -0400
Received: from mail-vi1eur05on2042.outbound.protection.outlook.com ([40.107.21.42]:38881
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230341AbhDVJde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvf0JlfW+XTr49vzRX1Yf1dwmCfpnIOvZ0w5Ws3q+Hnt2358J6FE25O9DQ4LffmSVmnlc92O3cprx4bzdtuXhRXU0pC9LwFasOZls5+KAdQmLjkCbkaXXiLjT5tqS/0qlcZCkVNhpcmYx3cTD4L0fKqkusJKwsWNxVxDFPDUAD4QYJ8Dv6a2lCGMS5aAzF1G9AlNjYNZmzisLJY0JX26wK4khS0o84J9D6iszcO/KAVoLpVsf6fRjlHog581Ko5tdhjvR3z83m1vDX8iEiKYkC4L8yMhg/ibhWAIRoFo/2vTz7820T5L8mJgj9kt/lq8xDzV65aoHQNTwdMyMpRpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFkYCH5Y5IynUVRAArfxN+sc01Yvlbm3ZJSEshLXB04=;
 b=O+pEnfTXE+9lmAlbIY9i3d5SMmex996RGjCSPhEfqWYfhFD05FKMDRxPmzhQY7lcetUOuRVNv5HIq7ui1lW3E0XUJyo2hDG+GD0NCAokPnaH89PWkvFUngnMYx+YxnetWyz0su4UWR6kW/S0365Jd8ZqLJSc/GRTcwk8qNfF9Ygmk0bUDpJDVOMmKT6dk0Tny0USjksk46+9UzSQv+kgTkqXZVbxCyh2N7WvMnGHUzzCvm3RhvGDQynfpnCTEu+obppT0Wibepy0tJTkOdmPlL9MvoftPZtX34ClijbGCJxubzUycFtP3LTsy6N+aKxEGGdHNxGN2XJVQaoenjXhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFkYCH5Y5IynUVRAArfxN+sc01Yvlbm3ZJSEshLXB04=;
 b=oOJ7qNP3v2YgUBNh1jnZvhMP0IBmYdQEFodlcl1hnTU5I4kAWLDsR0OW/G0PsU7W+tUNpx4u/Bu6vOBip/4SB/a7kJMQeFqlrIjt78OoncMOTM1qcq9XeBsIVlqAGdswJ/ulRnOVfEG11hp1KEoQjIVfq2hm+eH+3u0QX+fNR4A=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5038.eurprd04.prod.outlook.com (2603:10a6:803:5f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 22 Apr
 2021 09:32:55 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28%7]) with mapi id 15.20.4065.021; Thu, 22 Apr 2021
 09:32:55 +0000
Message-ID: <460bdf3547942fdca82a19e164162187917e4d57.camel@nxp.com>
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
Date:   Thu, 22 Apr 2021 17:31:21 +0800
In-Reply-To: <36441ffb-2a79-f965-efc8-042844bc349d@baylibre.com>
References: <1619068455-1932-1-git-send-email-victor.liu@nxp.com>
         <36441ffb-2a79-f965-efc8-042844bc349d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.3 via Frontend Transport; Thu, 22 Apr 2021 09:32:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 631d88e5-6f05-4f0e-efdf-08d905719b9b
X-MS-TrafficTypeDiagnostic: VI1PR04MB5038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB503878D3A3324BB27EFCA29A98469@VI1PR04MB5038.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CARv5c9QFe/ig0/TAoJ1+NzA/XtkNtJtBYj5NRVm+IUjxBTtBEg6V48Oe4JPYq4uv0uUoEmQ/0/ALqWAHp04B8da2Dj/EISh2ukSTL/v+vFVB37leCuDpJBzjjeMZzXpDLxCR/vD40IHIxWOK6ZYVdYfvDz9rMRvE+D7M+6dsMDdhBV3dF1M37qWqTmNj/wTjz5ANJamvF8WGBMUt4EsuPM6yCt07RwIPFHCUEO0scHN0JdL3v8dEt0S+eCg7etIono43Ug6k+KsyLNMJjStoty3RoWgaiHPsEB/sDwoWIxMbcRy1+g5W0zmvWY0kOEZfuVHQ9kjqh9vTVaCqOURYqTclZXe3GUbd74FMfK/KW+saYTdzkkIoDSRGNZK6nIa9tTGUS3xLrAh3D4JF3RtTVd8ENu2sFJlPnff6eF0KN0hc9T0HRvyNOYedsDBIpZENBNNTvjO8H6ega9V9Wr7SjPhBmP9TNA2HQ+EQc/SHzVHdCoqaUjbRZ8XO4bHLJTTVo75qz7QfqZA1LEg04f0k/+nJGE3SbA/mOxhi2prB1dntKMJPJwV17hVdJ+UiSgEz9p1TpRm3R4UWWLlpwy/GOL/VphIUNPDfmqynSb+Xc43HWX7tJwbux8g4YjNf3ylQ1x61k7uuvez5JLmDGksA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(8676002)(6666004)(8936002)(86362001)(36756003)(38350700002)(316002)(7416002)(2616005)(52116002)(4326008)(5660300002)(478600001)(53546011)(956004)(186003)(16526019)(6486002)(66574015)(83380400001)(6496006)(2906002)(66946007)(26005)(66556008)(66476007)(38100700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dkVNakNLWnljTDJMVWs4RHpUOHJFSWhQaWpicXoxQ2p4MndkbHdDaUFVdHZ1?=
 =?utf-8?B?ZnJBQm1IV0pGcktoN2JnTlhwbmp5VEVXRXVmcFloZnpIUVlmdk5lc3J2cjNH?=
 =?utf-8?B?RUpSd1V6RU5xOVRIVXpUc2lJRGVCeit5dmRQZWc3UDArVlZjSE1KNkN5M0Yy?=
 =?utf-8?B?d1VZbjJzcU13djZrNHJick5OSVBVQzR1djJiUVV5RDdnU1huemt6Q3hpK1B4?=
 =?utf-8?B?cTZkekRWZk5rcHdhUW5KV0dpWEoxdENOS0docGt3V1FlQzZ2S2RIbElrdUkv?=
 =?utf-8?B?R1RiNU81R0VqM2U4M2JMaUR6ZFZySzQ5WVlaTGx6SEVCaXBiOXdxc0ZKK2xV?=
 =?utf-8?B?N2t3N0YwVkcwUy80VkFTL1NIM2lyb1JWQzRwdkV4V3dWYjV6MlY2bzV0Ryth?=
 =?utf-8?B?YmxnRzhJdkJsT1lzZUtqM3NzTkt3NUFhU3hvUWRNUXAwQnBoRXN6aGZxL2Ix?=
 =?utf-8?B?VHhHVFQxNFl1TzdkeS9RZ0N5RHg2MnRiM3FTVEorVkg1Qi84aWZCSGdEekh3?=
 =?utf-8?B?WFdnZXNtamFtYVlHdEdmallSSjl5cDVFSW9GL3c0STMxZ1crMGZTTWJkby9W?=
 =?utf-8?B?c3dzUk9iR2pKYTU0c3VTSklxMmZMRGhkWDNoeEl4SkJsY1IvakJtc1BZZnN4?=
 =?utf-8?B?TXNybkhFVlFRUjhRVlAzWExQa3pab25lNm01dEs1M0s4SXg2Z1ZsYXFhR1hr?=
 =?utf-8?B?Q2gzcldPRDVjSVhlVHBWVERRWEVjbW1oQVRBZnlDOEN5YVNDMXpJamdEb2VR?=
 =?utf-8?B?Wlo5T0pFQ2Q5Q1Q3YUZyazhpTnA5SEVGbzZBTG5GaUFQQ2drbUU1QjA1Qlg4?=
 =?utf-8?B?ZERPR1FHQTdWUUkxYktCRjZXOXI2aFViNDN4SStaczBLcmltOTlJTjk3MDFR?=
 =?utf-8?B?bFI3UWtqL1pWU1RFMGtlNkZTMWRiNytxZU56MDMxL2FhSTBsbVVoYTlmeS9v?=
 =?utf-8?B?bHMxMWM5blRjN0NrODk0bjMrRXVleC9SZzd5dVJnbGQyN2ZrdVJlQkhWNUhQ?=
 =?utf-8?B?Rnc2MGx0MERidmY3SWVmaTBLTGtyV1EwTnJBWGZrT1hYK3crODJOZDIxVlV6?=
 =?utf-8?B?TzVpQUN5SnRKNm1CSDdqU0dVazkvK0MvNzdjMmJEUi9XQmhTZHdETkFjaVNO?=
 =?utf-8?B?NzhVdkx1ajRCcnpJeVJlR1JrMklYVDBFcE1xZ3E3ZTRMcHN5c2lSZ3dOTlM0?=
 =?utf-8?B?VGIzdEpseCtiUjRaR0hPZTdQeEhtY2kydG1xVGxYVStvSitrQTlhUzJyNHVj?=
 =?utf-8?B?SGVmZzBadzdzSVd5T3JRRmRaUVUwQ0pwaXZiZ3I1WnI4VHlSL0ZuWnRzaUM3?=
 =?utf-8?B?b1hxM2JJWEhWaXRadVlqMG83WnROTFVKVjM2Z0ZJSUI2Mkc2Ynllb2FqMmRE?=
 =?utf-8?B?ck1SbithRzlMOFV2cmZCbFg1NEdsbWRTMnVyZGFzQzRzVTdTdVFkd1FnTDRn?=
 =?utf-8?B?QTFObmNvL1R0UWxScVU5T2FsQ2lHYW84VFlhaWI2L1JxeXJ4aTVnSkhHb2VL?=
 =?utf-8?B?bE9OcnFWbndrVk9EcXZwY2NwaEpIV3lBVjNWeG80YzVSWXN5SU5OQ3VHNHAz?=
 =?utf-8?B?U1V2QW05VmlmdzNmdGJ0TTdBUEhiNnZVTkprcUwxMkRhVUdxdkVsTDBaNlFB?=
 =?utf-8?B?UGdBZzhIK05oN2djRUpiWXR5bm9CeVpudjVKOE9EZkNaQWVWZkRiM1VvQUNO?=
 =?utf-8?B?a1VpUFhYQVJxeEhhV2I5ejEvYTdJSjdBV3NoejZqYndIR204VjdlbTd2UHlr?=
 =?utf-8?Q?cZDs2e3taVyltYSiq2fsNx4YIaY1foYczPck40s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631d88e5-6f05-4f0e-efdf-08d905719b9b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 09:32:55.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVLavvTTavWmUHiHjWg3qM/aP21O3bVvWzviibBVmQUxGmNHSmVsmY9JMPbQmkYwt1nyZy0AxZgf7FCQGQafmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, 2021-04-22 at 10:48 +0200, Neil Armstrong wrote:
> Hi,
> 
> On 22/04/2021 07:14, Liu Ying wrote:
> > Some MIPI DSI panel drivers like 'raydium,rm68200' send
> > MIPI_DCS_SET_DISPLAY_ON commands in panel_funcs->prepare(), which
> > requires the MIPI DSI controller and PHY to be ready beforehand.
> > Without this patch, the nwl-dsi driver gets the MIPI DSI controller
> > and PHY ready in bridge_funcs->pre_enable(), which happens after
> > the panel_funcs->prepare(). So, this patch shifts the bridge operation
> > ealier from bridge_funcs->pre_enable() to bridge_funcs->mode_set().
> 
> This makes sense, this is how we do on the synopsys dw mipi dsi driver.
> 
> > This way, more MIPI DSI panels can connect to this nwl-dsi bridge.
> > Care is taken to make sure bridge_funcs->mode_set()/atomic_disable()
> > are called in pairs, which includes removing a check on unchanged HS
> > clock rate and forcing a full modeset when only connector's DPMS is
> > brought out of "Off" status.
> 
> I would split the changes in multiple patches to clarify the changes.

Maybe, I can split this into the below 3 patches:
1) Remove a check on unchanged HS clock rate from ->mode_set().
2) Force a full modeset when only connector's DPMS is brought out of
"Off" status. This will be done in ->atomic_check() together with the
fixup for H/VSYNC polarities.
3) Shift the bridge operation as the last step.

I'll mention that 1) & 2) are needed by 3) in their commit message.

Does this split-up sound reasonable?

Thanks,
Liu Ying

> 
> Neil
> 
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Robert Foss <robert.foss@linaro.org>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Jonas Karlman <jonas@kwiboo.se>
> > Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Guido Günther <agx@sigxcpu.org>
> > Cc: Robert Chiras <robert.chiras@nxp.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v1->v2:
> > * Fix commit message typo - s/unchange/unchanged/
> > 
> >  drivers/gpu/drm/bridge/nwl-dsi.c | 86 +++++++++++++++++++++-------------------
> >  1 file changed, 46 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> > index be6bfc5..229f0b1 100644
> > --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/sys_soc.h>
> >  #include <linux/time64.h>
> >  
> > +#include <drm/drm_atomic_state_helper.h>
> >  #include <drm/drm_bridge.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> > @@ -661,7 +662,7 @@ static irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -static int nwl_dsi_enable(struct nwl_dsi *dsi)
> > +static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
> >  {
> >  	struct device *dev = dsi->dev;
> >  	union phy_configure_opts *phy_cfg = &dsi->phy_cfg;
> > @@ -748,7 +749,9 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
> >  	return 0;
> >  }
> >  
> > -static void nwl_dsi_bridge_disable(struct drm_bridge *bridge)
> > +static void
> > +nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> > +			      struct drm_bridge_state *old_bridge_state)
> >  {
> >  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> >  	int ret;
> > @@ -809,17 +812,6 @@ static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
> >  	return 0;
> >  }
> >  
> > -static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
> > -				      const struct drm_display_mode *mode,
> > -				      struct drm_display_mode *adjusted_mode)
> > -{
> > -	/* At least LCDIF + NWL needs active high sync */
> > -	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> > -	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> > -
> > -	return true;
> > -}
> > -
> >  static enum drm_mode_status
> >  nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
> >  			  const struct drm_display_info *info,
> > @@ -837,6 +829,29 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
> >  	return MODE_OK;
> >  }
> >  
> > +static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
> > +				       struct drm_bridge_state *bridge_state,
> > +				       struct drm_crtc_state *crtc_state,
> > +				       struct drm_connector_state *conn_state)
> > +{
> > +	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
> > +
> > +	/* At least LCDIF + NWL needs active high sync */
> > +	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> > +	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> > +
> > +	/*
> > +	 * Do a full modeset if crtc_state->active is changed to be true.
> > +	 * This ensures our ->mode_set() is called to get the DSI controller
> > +	 * and the PHY ready to send DCS commands, when only the connector's
> > +	 * DPMS is brought out of "Off" status.
> > +	 */
> > +	if (crtc_state->active_changed && crtc_state->active)
> > +		crtc_state->mode_changed = true;
> > +
> > +	return 0;
> > +}
> > +
> >  static void
> >  nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> >  			const struct drm_display_mode *mode,
> > @@ -852,13 +867,6 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> >  	if (ret < 0)
> >  		return;
> >  
> > -	/*
> > -	 * If hs clock is unchanged, we're all good - all parameters are
> > -	 * derived from it atm.
> > -	 */
> > -	if (new_cfg.mipi_dphy.hs_clk_rate == dsi->phy_cfg.mipi_dphy.hs_clk_rate)
> > -		return;
> > -
> >  	phy_ref_rate = clk_get_rate(dsi->phy_ref_clk);
> >  	DRM_DEV_DEBUG_DRIVER(dev, "PHY at ref rate: %lu\n", phy_ref_rate);
> >  	/* Save the new desired phy config */
> > @@ -866,14 +874,8 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> >  
> >  	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
> >  	drm_mode_debug_printmodeline(adjusted_mode);
> > -}
> >  
> > -static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> > -{
> > -	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > -	int ret;
> > -
> > -	pm_runtime_get_sync(dsi->dev);
> > +	pm_runtime_get_sync(dev);
> >  
> >  	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
> >  		return;
> > @@ -883,27 +885,29 @@ static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> >  	/* Step 1 from DSI reset-out instructions */
> >  	ret = reset_control_deassert(dsi->rst_pclk);
> >  	if (ret < 0) {
> > -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert PCLK: %d\n", ret);
> > +		DRM_DEV_ERROR(dev, "Failed to deassert PCLK: %d\n", ret);
> >  		return;
> >  	}
> >  
> >  	/* Step 2 from DSI reset-out instructions */
> > -	nwl_dsi_enable(dsi);
> > +	nwl_dsi_mode_set(dsi);
> >  
> >  	/* Step 3 from DSI reset-out instructions */
> >  	ret = reset_control_deassert(dsi->rst_esc);
> >  	if (ret < 0) {
> > -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert ESC: %d\n", ret);
> > +		DRM_DEV_ERROR(dev, "Failed to deassert ESC: %d\n", ret);
> >  		return;
> >  	}
> >  	ret = reset_control_deassert(dsi->rst_byte);
> >  	if (ret < 0) {
> > -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert BYTE: %d\n", ret);
> > +		DRM_DEV_ERROR(dev, "Failed to deassert BYTE: %d\n", ret);
> >  		return;
> >  	}
> >  }
> >  
> > -static void nwl_dsi_bridge_enable(struct drm_bridge *bridge)
> > +static void
> > +nwl_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> > +			     struct drm_bridge_state *old_bridge_state)
> >  {
> >  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> >  	int ret;
> > @@ -948,14 +952,16 @@ static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
> >  }
> >  
> >  static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
> > -	.pre_enable = nwl_dsi_bridge_pre_enable,
> > -	.enable     = nwl_dsi_bridge_enable,
> > -	.disable    = nwl_dsi_bridge_disable,
> > -	.mode_fixup = nwl_dsi_bridge_mode_fixup,
> > -	.mode_set   = nwl_dsi_bridge_mode_set,
> > -	.mode_valid = nwl_dsi_bridge_mode_valid,
> > -	.attach	    = nwl_dsi_bridge_attach,
> > -	.detach	    = nwl_dsi_bridge_detach,
> > +	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
> > +	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> > +	.atomic_reset		= drm_atomic_helper_bridge_reset,
> > +	.atomic_check		= nwl_dsi_bridge_atomic_check,
> > +	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
> > +	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
> > +	.mode_set		= nwl_dsi_bridge_mode_set,
> > +	.mode_valid		= nwl_dsi_bridge_mode_valid,
> > +	.attach			= nwl_dsi_bridge_attach,
> > +	.detach			= nwl_dsi_bridge_detach,
> >  };
> >  
> >  static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
> > 

