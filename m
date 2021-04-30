Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5415336F98A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 13:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhD3LrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 07:47:17 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:48073
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229875AbhD3LrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 07:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7pnXYdVs/Puz6oUk0qUwosJgD9rGFXUAnnS0Ledx0cvdrsvBdac6n7ubPMZ7bdS9acNp9qfullUGZ7iLW8M4HqpuZNdj+B25FNXhx5NSgn+Kj64y1/NWa3iHzJASlTFxSvJAGHzl9c9HV+jY5ZOaoPaLbtECa9ImKnVNd1p+dOT0kqjl1NzLZjOt1GjLAFmBAIni9vDKEPlVeWLdTSSLV1UC2EtPL19l/bjlk5AfMAnVX29XBMf8M+jMVR6QuwNgBJOPfl5L+CTW4gFEY0y/pJGb01eBxXg6Sv7S9TQoPDmUOltSVEoowEZCylc4fUmkpru+WjJm9CpvlgVUlpRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+4sQ1wAGfHOCoQk+axzzgUK/OGnFL0GxN7zDfhzUS8=;
 b=HPflPaYH0QUI/vB+fD2z5LtxXiNFi2HRqb2M8RjL3kKDtptKw0xXzl2bh6tuivVSefKMr5SPklkKxcVx3eaZqS/sQFBnB0iAOw/tfbxO1zsCZVvu4ucVnOs6/FcTBrAimqJbjfO+GPcP2pJ9jCzpamfkEJ0hgrUSSpCw8Vtm0JLYbb9NEBMGFXnfm1GIoDSsLwCD0V7Ce5K8kpwpIMhmvkWgT3OsyDRrYHalzF20PhmLzz1ykDmM7F0oi+om3TodlFsD1WLFEiRZh4N3824jCtVjnkFxedm9jHUreabLBOsLStfV6MHc8jYpCUaj1LdiqsbPDIfQ9gIyD0Pj6/SbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+4sQ1wAGfHOCoQk+axzzgUK/OGnFL0GxN7zDfhzUS8=;
 b=Hr7BlOozeBXd65PkgF82J+FunVeuzt+VWH2zL/5xJ1UVL/KHNZ2uwSmGLdtGinA53tMhhqUvZvN8zmXRv47Q12/ZnvU6HM1Q7EwHYxB72+UPfsFuSPOV2KsIW/r7BUDU+gFErK2TrKfCP0U9QdPRuEY4ET+Q+tQT3H1/YGyh2AY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR0402MB3671.eurprd04.prod.outlook.com (2603:10a6:209:19::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Fri, 30 Apr
 2021 11:46:24 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::20f0:2b28:70c3:fb0]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::20f0:2b28:70c3:fb0%4]) with mapi id 15.20.4065.031; Fri, 30 Apr 2021
 11:46:24 +0000
Message-ID: <95db401a341b857289f2bec7c03b694eb7df8ce3.camel@nxp.com>
Subject: Re: [PATCH v3 1/3] drm/bridge: nwl-dsi: Force a full modeset when
 crtc_state->active is changed to be true
From:   Liu Ying <victor.liu@nxp.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, agx@sigxcpu.org,
        robert.chiras@nxp.com, linux-imx@nxp.com
Date:   Fri, 30 Apr 2021 19:45:53 +0800
In-Reply-To: <CAG3jFytcPzo81t8hubAf4Gb1zrVzZVB5D6qP-Dnchef6Zus25Q@mail.gmail.com>
References: <1619170003-4817-1-git-send-email-victor.liu@nxp.com>
         <1619170003-4817-2-git-send-email-victor.liu@nxp.com>
         <CAG3jFytcPzo81t8hubAf4Gb1zrVzZVB5D6qP-Dnchef6Zus25Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [116.232.209.249]
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from vbox (116.232.209.249) by HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.10 via Frontend Transport; Fri, 30 Apr 2021 11:46:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b7e1362-30ee-4e5a-48f0-08d90bcd94e9
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3671FDBD0DBBD5EC9522D66E985E9@AM6PR0402MB3671.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cygljGn/z4afXN6aS+TvrAqAimTMBjLCWX+yJ4uLSqhwaTzFxgKcokZ+WbUqAFEpQDXRRqjQ1WmYZrgRvHPYVPmJqe2tgphqL1BJabVNrPKE9JO8jJNkNMgrbZLuTJGRUcc6s9sAiELSdLRLLQDgUdRitJlrXCIAqfp/GvOF6iTuXwt/nDSytO/4Te/NCbePRLyt9SqPG/q17MtJYbFWKNM7IBF3z0QzCM2u+tu0kBbd4t9iaj2+HeVx3o7W4qgBCs6pE0odF7iQmd1sB+UzFZUbzfomJYZiBwr3txUjCkOnjfT0oTMNFunheMLDbF90wOSNAPngU81q9UWbBAh+oyqEQACXCJLt2uWpEXRBKH+417c4AmM69DamERLhb/jvrw9S0FOPnbYG17v6exAuRC7EY/WCfDlQvr+uG4Z0xRYY67J2rC4DX0ybm7nCqK0+G3gJaZt6pPJMGmr/t8B5uOGYuKI+D5U6Pf2pue3T/qIpaXvd0MtwGn5N8iFviKUC47IwLoIsZgJkeWzXP5vGA06xVtIEcXCB9CJ7INV6N2BNCBaqQc6McEBifb8qX3TgKOMcAsi5yw+0KDk6eLDf+fje0x50ivOydPaBsyn/oHlqGzDTDfnqY+GXUIBHI9yvUqLPB+u5UHeW30NnQjovfqHHrQ371anOQu4dXXyb93HfCzUhpUgxVP8A6IA6gl3FB81Wega1CQizL6luSITQow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(54906003)(4326008)(52116002)(66946007)(83380400001)(66556008)(7416002)(16526019)(66476007)(8676002)(186003)(316002)(26005)(6486002)(38100700002)(6496006)(5660300002)(6916009)(38350700002)(966005)(8936002)(478600001)(2906002)(86362001)(36756003)(2616005)(956004)(6666004)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rno3SDJvVkpiTTB3cWJ2Z3hqeWRpZnVuU3N2TStDd0txTGtEYlVXS3dwT3A5?=
 =?utf-8?B?VVhsSHFDd2tRZTBuVWx0aDVYTm16WVFUOER5ckI0bGNVTDRvSHJHb1hVajRi?=
 =?utf-8?B?QWhya0dZa0Q1bFdoNmlRZ1lBbkxiRk9Xbml1T2h3SEdTQWxJSmduTjFFSXlP?=
 =?utf-8?B?MnM1Y0xvWktUNmlwYmdqYVk1RnVWQS94SExCbmwvWi8yKytKUXlEdlJFYm1L?=
 =?utf-8?B?VW5PbnlaQThuMHcvQzRnSG9mWFZXd0pEZUllNzgxWjhuL1A2UU9UeWQ5YWgx?=
 =?utf-8?B?U2luNnVzM2xDYnMvYklQTE9tdEZBSDcwejBzTEEwejZ3KzRKM1lSdEI5UWlu?=
 =?utf-8?B?SkxqNnpQeTZyTDNFVEs5RHJvMjBpamc2dXMySFQ4TmJCenFlVTRWQmtCNzlN?=
 =?utf-8?B?ajBES24rNDQ5V3ROSDdsOE5ab05ack4vSkhQS2cwckdDNGZFMTRKbFpUWHpN?=
 =?utf-8?B?bkpmSHRNL1JLSi95dS9WYXQzMk1LZUFkb2Q1TzBVVXZUd09qZFRYNDcvQzdX?=
 =?utf-8?B?OGU1ME1wRTdKTU1OS1VjZGFtMDlOVjMrdTN3eGlQbW5meEN1LzRCLzBZM1lk?=
 =?utf-8?B?c0QyNWxMam5PTVpXK3Vma1lCM21TVVdYellocXE3M1dnTFh2U1JlNTJORzZY?=
 =?utf-8?B?MjJBVHFNQWwwNGRPUmVpUWhleGFpODVHTkUzNDNzRXprN01MeE1ZMkEwZGZk?=
 =?utf-8?B?SHRIVUxFUE5RdDZZdnE0UGQ4WXcrRVMrZlpFdVdpeDlENkg0ZTFjV1B4ckZq?=
 =?utf-8?B?OXIvUlhiakZ3RHBQaWtONTcrR2pDeFRYYm1NSzlrMTJGWmRwb2kzRjVQR0N5?=
 =?utf-8?B?Ris0Ri9qekdrMlljNkYwVy9rMVdESHdhWkRvK0hSaGJhTllCMHUwcVowZmNY?=
 =?utf-8?B?RGlhdU8xL3RXbTAzL01jYlhVR2hjOFloMmZMajhvcTdKb2FYdUxPNWY0cTNq?=
 =?utf-8?B?WDRBTmpaOHpvUmk0SVN2SC9iVjVxRE9XRjdldVkxUHRYN2tGMFI5VytDNUxI?=
 =?utf-8?B?WkpmYkpmMlc3Y1VhcVJFY29ySDlwRnNCNjlHd0JKUURLcGtjVGxzQU9BVUJS?=
 =?utf-8?B?UFdhVGR5eVJTd3NlVkc5QmN6VERFaDBIdmtZQ21zTVBRTWZzalhUb1JMM0x6?=
 =?utf-8?B?ck1MR1BIV3JuQ094YmdjTEttdTVYcm5vMlRscnpWQXpmREhzcnhubkRrUlY5?=
 =?utf-8?B?STI3UWczUmY0SnlnYk1CenVLTFZnNEpNZlNaM0tlc3lINlBzOS93TTRhM2JH?=
 =?utf-8?B?UVNwTk5TYTNBOEFzMUhqZ0xHaENMcVJOYnhaU1FnYjF4dHU1Vlh3Vkg2bXdn?=
 =?utf-8?B?bytWTnVERDRhRHRVa0ZydjM2TDA4YjZJSitUS0tTWXhxWTF2bW54MUFXOFlY?=
 =?utf-8?B?TmV5L3dnTnI3b0VCSVpCRzV2Z3pleWM3aEd6VnZGbHV6K2d2UkZtRzhxTXhv?=
 =?utf-8?B?b2wyQzJtQTdKZTZiN1BaOGRvYUlMUVA5WUlkemFEVmdGdFRFVEEvb04vNVh6?=
 =?utf-8?B?a0R5NHpnbk9reWh5UndTODgzWTJmTUtGUG56azgwSGNqRFdJc3o0dHZXQWh2?=
 =?utf-8?B?Qmx1aUJQYmJYMlpnd3d5dldjWWlNdlg3RmNHU1RyeWllL1VGcHpLeUJzM1dO?=
 =?utf-8?B?ZXdWK0UwZlozTkZVU1BuRGxMZUo3Z2owK2hwOHRkR3IzZDA1ekZCUHJUUkp1?=
 =?utf-8?B?dXMxZzFpbFdyb2dSNEhWZUpuQUphZUlSK0R3cm1kV1N6ZlFNSm5xcmFLUzJu?=
 =?utf-8?Q?ySj8Sz/n2XotSO+wmve0/q5czoSUkGD3aqQ4YMP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7e1362-30ee-4e5a-48f0-08d90bcd94e9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 11:46:24.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4CrNh5or4yN3xNVFBrmv/HwHj0rOhmpOTDnnsPI8FDizZ7kF6wDpY10RjmMd6e5MCyMTNGiC6quUU+hEhI+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3671
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Fri, 2021-04-30 at 11:56 +0200, Robert Foss wrote:
> Hey Liu,
> 
> This patch does not apply on upstream-drm-misc/drm-misc-next. When it
> passes local testing & building, I'm ready to merge it.

I see Neil has already pushed this entire patch series to
drm-misc-next.


https://cgit.freedesktop.org/drm/drm-misc/commit/?id=885811372fe101c4299c53eecc9fee72cf927a0c

I also see Guido's R-b and T-b tags on this series, though they comes
after Neil's push perhaps.

Thanks,
Liu Ying

> 
> On Fri, 23 Apr 2021 at 11:42, Liu Ying <victor.liu@nxp.com> wrote:
> > This patch replaces ->mode_fixup() with ->atomic_check() so that
> > a full modeset can be requested from there when crtc_state->active
> > is changed to be true(which implies only connector's DPMS is
> > brought
> > out of "Off" status, though not necessarily).  Bridge functions are
> > added or changed to accommodate the ->atomic_check() callback. 
> > That
> > full modeset is needed by the up-coming patch which gets MIPI DSI
> > controller and PHY ready in ->mode_set(), because it makes sure
> > ->mode_set() and ->atomic_disable() are called in pairs.
> > 
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
> > v2->v3:
> > * Split from the single patch in v2 to clarify changes. (Neil)
> > 
> >  drivers/gpu/drm/bridge/nwl-dsi.c | 61 ++++++++++++++++++++------
> > ------
> >  1 file changed, 39 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c
> > b/drivers/gpu/drm/bridge/nwl-dsi.c
> > index 66b67402f1acd..c65ca860712d2 100644
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
> > @@ -742,7 +743,9 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
> >         return 0;
> >  }
> > 
> > -static void nwl_dsi_bridge_disable(struct drm_bridge *bridge)
> > +static void
> > +nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> > +                             struct drm_bridge_state
> > *old_bridge_state)
> >  {
> >         struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> >         int ret;
> > @@ -803,17 +806,6 @@ static int nwl_dsi_get_dphy_params(struct
> > nwl_dsi *dsi,
> >         return 0;
> >  }
> > 
> > -static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
> > -                                     const struct drm_display_mode
> > *mode,
> > -                                     struct drm_display_mode
> > *adjusted_mode)
> > -{
> > -       /* At least LCDIF + NWL needs active high sync */
> > -       adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC |
> > DRM_MODE_FLAG_PVSYNC);
> > -       adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC |
> > DRM_MODE_FLAG_NVSYNC);
> > -
> > -       return true;
> > -}
> > -
> >  static enum drm_mode_status
> >  nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
> >                           const struct drm_display_info *info,
> > @@ -831,6 +823,24 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge
> > *bridge,
> >         return MODE_OK;
> >  }
> > 
> > +static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
> > +                                      struct drm_bridge_state
> > *bridge_state,
> > +                                      struct drm_crtc_state
> > *crtc_state,
> > +                                      struct drm_connector_state
> > *conn_state)
> > +{
> > +       struct drm_display_mode *adjusted_mode = &crtc_state-
> > >adjusted_mode;
> > +
> > +       /* At least LCDIF + NWL needs active high sync */
> > +       adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC |
> > DRM_MODE_FLAG_PVSYNC);
> > +       adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC |
> > DRM_MODE_FLAG_NVSYNC);
> > +
> > +       /* Do a full modeset if crtc_state->active is changed to be
> > true. */
> > +       if (crtc_state->active_changed && crtc_state->active)
> > +               crtc_state->mode_changed = true;
> > +
> > +       return 0;
> > +}
> > +
> >  static void
> >  nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> >                         const struct drm_display_mode *mode,
> > @@ -862,7 +872,9 @@ nwl_dsi_bridge_mode_set(struct drm_bridge
> > *bridge,
> >         drm_mode_debug_printmodeline(adjusted_mode);
> >  }
> > 
> > -static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> > +static void
> > +nwl_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> > +                                struct drm_bridge_state
> > *old_bridge_state)
> >  {
> >         struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> >         int ret;
> > @@ -897,7 +909,9 @@ static void nwl_dsi_bridge_pre_enable(struct
> > drm_bridge *bridge)
> >         }
> >  }
> > 
> > -static void nwl_dsi_bridge_enable(struct drm_bridge *bridge)
> > +static void
> > +nwl_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> > +                            struct drm_bridge_state
> > *old_bridge_state)
> >  {
> >         struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> >         int ret;
> > @@ -942,14 +956,17 @@ static void nwl_dsi_bridge_detach(struct
> > drm_bridge *bridge)
> >  }
> > 
> >  static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
> > -       .pre_enable = nwl_dsi_bridge_pre_enable,
> > -       .enable     = nwl_dsi_bridge_enable,
> > -       .disable    = nwl_dsi_bridge_disable,
> > -       .mode_fixup = nwl_dsi_bridge_mode_fixup,
> > -       .mode_set   = nwl_dsi_bridge_mode_set,
> > -       .mode_valid = nwl_dsi_bridge_mode_valid,
> > -       .attach     = nwl_dsi_bridge_attach,
> > -       .detach     = nwl_dsi_bridge_detach,
> > +       .atomic_duplicate_state =
> > drm_atomic_helper_bridge_duplicate_state,
> > +       .atomic_destroy_state   =
> > drm_atomic_helper_bridge_destroy_state,
> > +       .atomic_reset           = drm_atomic_helper_bridge_reset,
> > +       .atomic_check           = nwl_dsi_bridge_atomic_check,
> > +       .atomic_pre_enable      = nwl_dsi_bridge_atomic_pre_enable,
> > +       .atomic_enable          = nwl_dsi_bridge_atomic_enable,
> > +       .atomic_disable         = nwl_dsi_bridge_atomic_disable,
> > +       .mode_set               = nwl_dsi_bridge_mode_set,
> > +       .mode_valid             = nwl_dsi_bridge_mode_valid,
> > +       .attach                 = nwl_dsi_bridge_attach,
> > +       .detach                 = nwl_dsi_bridge_detach,
> >  };
> > 
> >  static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)

