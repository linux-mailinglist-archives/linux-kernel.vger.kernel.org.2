Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE7640B359
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhINPoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhINPoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:44:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665E9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:42:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v5so20631061edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kRUP3124jFCDeJuxRpcOBXiHwnacoHhJ7Zfv1dwnqGk=;
        b=l1x3YMt+D40sQh5Xj/MGN8XZugv8sHGNHuk5PfiUKUU34OF4TUpxkWKaF/FDOxcygz
         zNRDHmW3HgcmmKzaP0kedYhEnfqKhAYDsQc8xFrWAgQntsD3h0IUStdgiJ5bpg5t6ALP
         rkyM/xF7XB2c5RoZX4RWobBlT4EuZ7MAZTWhTnSeQFMWNthLabFaaaxIP6Ov+GKxFBNc
         GpNa46fLPnsgQL9M7eGCFq1vhaWgJGi0NdKSgn9kXLe6P6ampgDXbIU+dBUgoi6IjqNe
         Sk85Oqaqgy5+HIkGtFzxJFUfdLDprsO1ejsekEDhAGKW2swtOaENfRi3jL4WX2V3ftg8
         dk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRUP3124jFCDeJuxRpcOBXiHwnacoHhJ7Zfv1dwnqGk=;
        b=THJWQJQSiDmdbDiw1nXmU6eur684RoCOgpvMT29aca1M2HQ2kji3OvTHCsTWh27aEz
         9PmXAXz74bNJhsyF65zlQVtbHuDo00Frd8j6cYKzbtvCqMY3CJdyJ0iVWy/1MlNoKl7O
         1IuU+Wbeo9tZ/B1Lm42P425VnVU8ZdkrRn8ZVyYgShEDl+27OXlsHAuqNwALQfBbZxf0
         JaCUGCqNuRBIm0upG/DbWtnGxcECa++RMv2+WZNxvxoT9grXcuvlbfOCKReiNuHpS1gv
         LTLG+1TcsKkeJDxq7gLGhFIeP+557LhnZ3RpFbZsBdWmW/P7DPCc2dBFbb4dD4K8Eoqy
         n2AQ==
X-Gm-Message-State: AOAM530Rly/uwi4dKA0FoXksHIwxM+h3HiiOfhqU6Hsf6S4kiok/mOo1
        pBqq3oliv7P2wMD1Bl+3+F0=
X-Google-Smtp-Source: ABdhPJwGvwpsqvOBoHYx+3TGl1oPwUPzbvzzUiAzPN3tCNVotPdIOmLvk/3Hq0xHWbjN4q7JKBr9yg==
X-Received: by 2002:aa7:c80a:: with SMTP id a10mr19943269edt.174.1631634165997;
        Tue, 14 Sep 2021 08:42:45 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id bi3sm5715920edb.91.2021.09.14.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:42:45 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     =?utf-8?B?T25kxZllag==?= Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        saravanak@google.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drm/sun4i: dw-hdmi: Fix HDMI PHY clock setup
Date:   Tue, 14 Sep 2021 17:42:43 +0200
Message-ID: <1850995.CcfoNp1lXK@kista>
In-Reply-To: <20210914085922.qxhmr6puvy5d2ceo@core>
References: <20210913172154.2686-1-jernej.skrabec@gmail.com> <20210914085922.qxhmr6puvy5d2ceo@core>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 14. september 2021 ob 10:59:22 CEST je Ond=C5=99ej Jirman napisa=
l(a):
> Hello Jernej,
>=20
> On Mon, Sep 13, 2021 at 07:21:54PM +0200, Jernej Skrabec wrote:
> > Recent rework, which made HDMI PHY driver a platform device, inadvertely
> > reversed clock setup order. HW is very touchy about it. Proper way is to
> > handle controllers resets and clocks first and HDMI PHYs second.
> >=20
> > Currently, without this fix, first mode set completely fails (nothing on
> > HDMI monitor) on H3 era PHYs. On H6, it still somehow work.
> >=20
> > Move HDMI PHY reset & clocks handling to sun8i_hdmi_phy_init() which
> > will assure that code is executed after controllers reset & clocks are
> > handled. Additionally, add sun8i_hdmi_phy_deinit() which will deinit
> > them at controllers driver unload.
> >=20
> > Tested on A64, H3, H6 and R40.
> >=20
> > Fixes: 9bf3797796f5 ("drm/sun4i: dw-hdmi: Make HDMI PHY into a platform=
=20
device")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  |  7 +-
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  4 +-
> >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 97 ++++++++++++++------------
> >  3 files changed, 61 insertions(+), 47 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/su=
n4i/
sun8i_dw_hdmi.c
> > index f75fb157f2ff..5fa5407ac583 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > @@ -216,11 +216,13 @@ static int sun8i_dw_hdmi_bind(struct device *dev,=
=20
struct device *master,
> >  		goto err_disable_clk_tmds;
> >  	}
>=20
> ^^^ This looks like...
>=20
> > +	ret =3D sun8i_hdmi_phy_init(hdmi->phy);
> > +	if (ret)
> > +		return ret;
>=20
> ... you need 'goto err_disable_clk_tmds;' here, instead.

Ah, right. Will fix in v2.

>=20
> > +
> >  	drm_encoder_helper_add(encoder,=20
&sun8i_dw_hdmi_encoder_helper_funcs);
> >  	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> > =20
> > -	sun8i_hdmi_phy_init(hdmi->phy);
> > -
> >  	plat_data->mode_valid =3D hdmi->quirks->mode_valid;
> >  	plat_data->use_drm_infoframe =3D hdmi->quirks->use_drm_infoframe;
> >  	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
> > @@ -262,6 +264,7 @@ static void sun8i_dw_hdmi_unbind(struct device *dev=
,=20
struct device *master,
> >  	struct sun8i_dw_hdmi *hdmi =3D dev_get_drvdata(dev);
> > =20
> >  	dw_hdmi_unbind(hdmi->hdmi);
> > +	sun8i_hdmi_phy_deinit(hdmi->phy);
> >  	clk_disable_unprepare(hdmi->clk_tmds);
> >  	reset_control_assert(hdmi->rst_ctrl);
> >  	gpiod_set_value(hdmi->ddc_en, 0);
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/su=
n4i/
sun8i_dw_hdmi.h
> > index 74f6ed0e2570..bffe1b9cd3dc 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > @@ -169,6 +169,7 @@ struct sun8i_hdmi_phy {
> >  	struct clk			*clk_phy;
> >  	struct clk			*clk_pll0;
> >  	struct clk			*clk_pll1;
> > +	struct device			*dev;
> >  	unsigned int			rcal;
> >  	struct regmap			*regs;
> >  	struct reset_control		*rst_phy;
> > @@ -205,7 +206,8 @@ encoder_to_sun8i_dw_hdmi(struct drm_encoder *encode=
r)
> > =20
> >  int sun8i_hdmi_phy_get(struct sun8i_dw_hdmi *hdmi, struct device_node=
=20
*node);
> > =20
> > -void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
> > +int sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
> > +void sun8i_hdmi_phy_deinit(struct sun8i_hdmi_phy *phy);
> >  void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
> >  			    struct dw_hdmi_plat_data *plat_data);
> > =20
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/
sun4i/sun8i_hdmi_phy.c
> > index c9239708d398..78b152973957 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > @@ -506,9 +506,60 @@ static void sun8i_hdmi_phy_init_h3(struct=20
sun8i_hdmi_phy *phy)
> >  	phy->rcal =3D (val & SUN8I_HDMI_PHY_ANA_STS_RCAL_MASK) >> 2;
> >  }
> > =20
> > -void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy)
> > +int sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy)
> >  {
> > +	int ret;
> > +
> > +	ret =3D reset_control_deassert(phy->rst_phy);
> > +	if (ret) {
> > +		dev_err(phy->dev, "Cannot deassert phy reset control:=20
%d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(phy->clk_bus);
> > +	if (ret) {
> > +		dev_err(phy->dev, "Cannot enable bus clock: %d\n",=20
ret);
> > +		goto err_deassert_rst_phy;
>=20
> I know it was there before, but please:
>=20
> s/deassert/assert/

Ok.

Best regards,
Jernej

>=20
> kind regards,
> 	o.
>=20
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(phy->clk_mod);
> > +	if (ret) {
> > +		dev_err(phy->dev, "Cannot enable mod clock: %d\n",=20
ret);
> > +		goto err_disable_clk_bus;
> > +	}
> > +
> > +	if (phy->variant->has_phy_clk) {
> > +		ret =3D sun8i_phy_clk_create(phy, phy->dev,
> > +					   phy->variant-
>has_second_pll);
> > +		if (ret) {
> > +			dev_err(phy->dev, "Couldn't create the PHY=20
clock\n");
> > +			goto err_disable_clk_mod;
> > +		}
> > +
> > +		clk_prepare_enable(phy->clk_phy);
> > +	}
> > +
> >  	phy->variant->phy_init(phy);
> > +
> > +	return 0;
> > +
> > +err_disable_clk_mod:
> > +	clk_disable_unprepare(phy->clk_mod);
> > +err_disable_clk_bus:
> > +	clk_disable_unprepare(phy->clk_bus);
> > +err_deassert_rst_phy:
> > +	reset_control_assert(phy->rst_phy);
> > +
> > +	return ret;
> > +}
> > +
> >
> > [......]
>=20


