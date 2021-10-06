Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244FC424551
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhJFR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJFR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:56:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE9C061753;
        Wed,  6 Oct 2021 10:54:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so13770356lfa.9;
        Wed, 06 Oct 2021 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a9k9Di8QRSjHw+JIJ/kleEuOF1voj2mDbtq0EAdXgvM=;
        b=Wf+pL0su6BHsKR7nlTe4gApWdcQHsp/leFukMVJRwwlCHm9bYGXCCEHfE/UzxHP35l
         ua9L9dwYoYgW8FZLFR2T/X0kkw5TTIT1EwVp+IPDNKlYnvPCdkrDdBDh2fwNErLBZcqR
         QvqMduqW1YUshbcSW/TZxK5OoTPDHA/VOtaEEzFdod25pKOFYArE5JhFU50SMfubedDF
         23N010XzSDQG4B1iWEnETkQQ5JM69wr15LkqxBFlUl+CcVwnSRo6afgR9CNVB7x54OPp
         VRE1qj++FdIwkEhenqgOnCzV8SvVqww6ZMv0eFiskF/vu8rlG38ZvUQLj4SjJxJIMPiV
         IvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9k9Di8QRSjHw+JIJ/kleEuOF1voj2mDbtq0EAdXgvM=;
        b=3+KVJuyuVSAU1mv7YX70vulsw3+Z8WXI5oH3wATaL160yjybCq6dSwl2RQyEOiJdjS
         BKBHgeysC22H01SttlICYOlQyDmAuxOXJvOLok8nMrNx2kPZeWu0sJYmYrPGpxfzoRdR
         Cgxob27pqRI9Nd7SEpLMA28IDky88pqLS3i7jIK4Oi7xBD00DCyRKSnSpyUikJ7fIFFA
         XWQsCNUmTV81tE70dNn3HzwLYXz9WgnS3i5NzuzfNrxmABwDPyE7qLO2sSJLxaIQ01SJ
         Mmkozvvq1S37DohIHLHe7vSElyF2ScjTdy5rZ8z21x1+gcVTewsN+Ec4Sp25yFY675LI
         bPTA==
X-Gm-Message-State: AOAM5320fmnZ4Lcn/uIxFbml4mcM+7EsvRaMztR5bvxEm22P73QggOfp
        8P6zx6RaGcU7LdFzDK1jGiMV+m3PhFLCbgB1ROE=
X-Google-Smtp-Source: ABdhPJxgy/mRrH43RK1J7qxx++zPO1SKNcj+z9JQU9lHV32x5j+sYEYYje0zcWG/sKu+dZyqTsbUvtQH1+hYIkENBeo=
X-Received: by 2002:ac2:5e9c:: with SMTP id b28mr11025869lfq.405.1633542856224;
 Wed, 06 Oct 2021 10:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210813145302.3933-1-kevin3.tang@gmail.com> <20210813145302.3933-7-kevin3.tang@gmail.com>
 <20210917154047.leojvqjqjj2sg34l@gilmour> <CAFPSGXZbqh0f6kEoQaq_Nt677ksVS6QPdAa5==KVVAszSAuasw@mail.gmail.com>
 <20210928092805.wbc4ev3ze7a7zgqr@gilmour>
In-Reply-To: <20210928092805.wbc4ev3ze7a7zgqr@gilmour>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Thu, 7 Oct 2021 01:54:04 +0800
Message-ID: <CAFPSGXbiRQ22gnqDB13LBFt-RSPneS751JsoN8y6gTpTh7M1fw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] drm/sprd: add Unisoc's drm mipi dsi&dphy driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, pony1.wu@gmail.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B49=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Sep 26, 2021 at 10:31:53PM +0800, Kevin Tang wrote:
> > Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B49=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:40=E5=86=99=E9=81=93=EF=BC=9A
> > > > +static void sprd_dsi_encoder_mode_set(struct drm_encoder *encoder,
> > > > +                              struct drm_display_mode *mode,
> > > > +                              struct drm_display_mode *adj_mode)
> > > > +{
> > > > +     struct sprd_dsi *dsi =3D encoder_to_dsi(encoder);
> > > > +
> > > > +     drm_dbg(dsi->drm, "%s() set mode: %s\n", __func__, dsi->mode-=
>name);
> > > > +}
> > >
> > > You don't need that function?
> > No need for now. need to delete it?
>
> Yes
>
> > > > +static int sprd_dsi_encoder_atomic_check(struct drm_encoder *encod=
er,
> > > > +                                 struct drm_crtc_state *crtc_state=
,
> > > > +                                 struct drm_connector_state *conn_=
state)
> > > > +{
> > > > +     return 0;
> > > > +}
> > >
> > > Ditto
> >
> > No need for now. need to delete it?
>
> Yep
>
> > > > +static int sprd_dsi_find_panel(struct sprd_dsi *dsi)
> > > > +{
> > > > +     struct device *dev =3D dsi->host.dev;
> > > > +     struct device_node *child, *lcds_node;
> > > > +     struct drm_panel *panel;
> > > > +
> > > > +     /* search /lcds child node first */
> > > > +     lcds_node =3D of_find_node_by_path("/lcds");
> > > > +     for_each_child_of_node(lcds_node, child) {
> > > > +             panel =3D of_drm_find_panel(child);
> > > > +             if (!IS_ERR(panel)) {
> > > > +                     dsi->panel =3D panel;
> > > > +                     return 0;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * If /lcds child node search failed, we search
> > > > +      * the child of dsi host node.
> > > > +      */
> > > > +     for_each_child_of_node(dev->of_node, child) {
> > > > +             panel =3D of_drm_find_panel(child);
> > > > +             if (!IS_ERR(panel)) {
> > > > +                     dsi->panel =3D panel;
> > > > +                     return 0;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     drm_err(dsi->drm, "of_drm_find_panel() failed\n");
> > > > +     return -ENODEV;
> > > > +}
> > >
> > > Just use devm_drm_of_get_bridge there
> >
> > We use drm_panel_init and drm_panel_add API to add panel, so here is a
> > panel device, not a bridge.
>
> Like Sam said, the panel API is on its way out and is being superseded
> by bridge_panels.
Ok, i will try it.
>
> > > > +static int sprd_dsi_host_init(struct sprd_dsi *dsi, struct device =
*dev)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     dsi->host.dev =3D dev;
> > > > +     dsi->host.ops =3D &sprd_dsi_host_ops;
> > > > +
> > > > +     ret =3D mipi_dsi_host_register(&dsi->host);
> > > > +     if (ret)
> > > > +             drm_err(dsi->drm, "failed to register dsi host\n");
> > > > +
> > > > +     return ret;
> > > > +}
> > > >
> > > > [...]
> > > >
> > > > +static int sprd_dsi_connector_init(struct drm_device *drm, struct =
sprd_dsi *dsi)
> > > > +{
> > > > +     struct drm_encoder *encoder =3D &dsi->encoder;
> > > > +     struct drm_connector *connector =3D &dsi->connector;
> > > > +     int ret;
> > > > +
> > > > +     connector->polled =3D DRM_CONNECTOR_POLL_HPD;
> > > > +
> > > > +     ret =3D drm_connector_init(drm, connector,
> > > > +                              &sprd_dsi_atomic_connector_funcs,
> > > > +                              DRM_MODE_CONNECTOR_DSI);
> > > > +     if (ret) {
> > > > +             drm_err(drm, "drm_connector_init() failed\n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     drm_connector_helper_add(connector,
> > > > +                              &sprd_dsi_connector_helper_funcs);
> > > > +
> > > > +     drm_connector_attach_encoder(connector, encoder);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int sprd_dsi_context_init(struct sprd_dsi *dsi,
> > > > +                     struct device *dev)
> > > > +{
> > > > +     struct platform_device *pdev =3D to_platform_device(dev);
> > > > +     struct dsi_context *ctx =3D &dsi->ctx;
> > > > +     struct resource *res;
> > > > +
> > > > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +     ctx->base =3D devm_ioremap(dev, res->start, resource_size(res=
));
> > > > +     if (!ctx->base) {
> > > > +             drm_err(dsi->drm, "failed to map dsi host registers\n=
");
> > > > +             return -ENXIO;
> > > > +     }
> > > > +
> > > > +     ctx->pll =3D devm_kzalloc(dev, sizeof(*ctx->pll), GFP_KERNEL)=
;
> > > > +     if (!ctx->pll)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     ctx->regmap =3D devm_regmap_init(dev, &regmap_tst_io, dsi, &b=
yte_config);
> > > > +     if (IS_ERR(ctx->regmap)) {
> > > > +             drm_err(dsi->drm, "dphy regmap init failed\n");
> > > > +             return PTR_ERR(ctx->regmap);
> > > > +     }
> > > > +
> > > > +     ctx->data_hs2lp =3D 120;
> > > > +     ctx->data_lp2hs =3D 500;
> > > > +     ctx->clk_hs2lp =3D 4;
> > > > +     ctx->clk_lp2hs =3D 15;
> > > > +     ctx->max_rd_time =3D 6000;
> > > > +     ctx->int0_mask =3D 0xffffffff;
> > > > +     ctx->int1_mask =3D 0xffffffff;
> > > > +     ctx->enabled =3D true;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int sprd_dsi_bind(struct device *dev, struct device *master=
, void *data)
> > > > +{
> > > > +     struct drm_device *drm =3D data;
> > > > +     struct sprd_dsi *dsi;
> > > > +     int ret;
> > > > +
> > > > +     dsi =3D sprd_dsi_encoder_init(drm, dev);
> > > > +     if (IS_ERR(dsi))
> > > > +             return PTR_ERR(dsi);
> > > > +
> > > > +     dsi->drm =3D drm;
> > > > +     dev_set_drvdata(dev, dsi);
> > > > +
> > > > +     ret =3D sprd_dsi_connector_init(drm, dsi);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D sprd_dsi_context_init(dsi, dev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D sprd_dsi_host_init(dsi, dev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void sprd_dsi_unbind(struct device *dev,
> > > > +                     struct device *master, void *data)
> > > > +{
> > > > +     struct sprd_dsi *dsi =3D dev_get_drvdata(dev);
> > > > +
> > > > +     mipi_dsi_host_unregister(&dsi->host);
> > > > +}
> > > > +
> > > > +static const struct component_ops dsi_component_ops =3D {
> > > > +     .bind   =3D sprd_dsi_bind,
> > > > +     .unbind =3D sprd_dsi_unbind,
> > > > +};
> > > > +
> > > > +static const struct of_device_id dsi_match_table[] =3D {
> > > > +     { .compatible =3D "sprd,sharkl3-dsi-host" },
> > > > +     { /* sentinel */ },
> > > > +};
> > > > +
> > > > +static int sprd_dsi_probe(struct platform_device *pdev)
> > > > +{
> > > > +     return component_add(&pdev->dev, &dsi_component_ops);
> > >
> > > In order to prevent probe issues, you need to register you mipi_dsi_h=
ost
> > > here, see:
> > > https://lore.kernel.org/dri-devel/20210910101218.1632297-3-maxime@cer=
no.tech/
> >
> > We register mipi_dsi_hot on our panel driver, like this:
> >
> > 1092   ret =3D mipi_dsi_attach(slave);
> > 1093   if (ret) {
> > 1094   DRM_ERROR("failed to attach dsi panel to host\n");
> > 1095   drm_panel_remove(&panel->base);
> > 1096   return ret;
> > 1097   }
>
> It's not about when you attach, but when you call
> mipi_dsi_host_register. You're doing it in sprd_dsi_host_init that you
> call in bind(), which is against the best practices and will create
> probing issues in the future.
If we call mipi_dsi_host_register on probe phase, it looks like can't
call drmm_encoder_alloc to create dsi device on bind.
It may be necessary to go back to the devm_kzalloc method used before

static int sprd_dsi_probe(struct platform_device *pdev)
{
struct device *dev =3D &pdev->dev;
struct sprd_dsi *dsi;

dsi =3D devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
if (!dsi)
    return -ENOMEM;

dsi->host.dev =3D dev;
dsi->host.ops =3D &sprd_dsi_host_ops;
ret =3D mipi_dsi_host_register(&dsi->host);
if (ret)
    dev_err(dev, "failed to register dsi host\n");

......
return 0;
}

>
> Maxime
