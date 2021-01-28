Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92B8306D86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhA1GRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 01:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhA1GQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:16:54 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:16:13 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e1so4233724ilu.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KzLZrIlj2KEusKb+DCyZQltguwX4cquIABSWZ+YWu8=;
        b=HqmGgkXeKHV92s/9MhA3TQIkVUpzUw0v86uHHPVMKwq0rTqQWTi/SuEW9e5RKbe+RZ
         wyr+Y5vvEj436caCaAH80No/ZuRzT1uCqHhnL2It/OvCuK2BrPQ+fgZRdObo7Z4n7wXZ
         9p/I9NGSQLTfabyk/sU+R+5u6KivXtcIsIREg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KzLZrIlj2KEusKb+DCyZQltguwX4cquIABSWZ+YWu8=;
        b=Sd9jQE0pdr+7vxOylL6z9zVnINuxJDigdkVBlQEVu0Dsx5b0cth3iIG4o2V7OytOP5
         DQLARWfmnubT3zoPhxXlrX6g7pb0i6BMldvOTnLL1vTr2m0fw+EIVxwtKSI2o5yQleeD
         LPv6yTKzuHtLDdbO8+nVQ7q6C0VxXjnlblncJwakzHGxpKaVzw95jynliy8aoCpSSmBZ
         B5HFkg1c9snX4vGuUI/zzSb/RlR9M/61U4DXsizqI4OlEmCv+5A2QJvX0tM4USSAk0qa
         fIgFo2LoAj2anSZF2bc0c1xmV6r/7nYQN6L02INOGFMwWfcZr8vxGKnEJ12YvOmwgRIP
         galg==
X-Gm-Message-State: AOAM532+luzrFsO0otMAWrD+NzoTN18M0qhsEfB6XemjTtzrm0HMtLLV
        U2HxydtMYvgFN4gJoqHE6Jz4qmCw124odJMm0M0pvg==
X-Google-Smtp-Source: ABdhPJzBqhKTHMlI5tApnzJW0pJjO1n8CMr+sbfm3OGH0z5XL/nYsEZM5Ecpax4npwyGOI9nkuewCcEWRxOv827+6J4=
X-Received: by 2002:a92:15c6:: with SMTP id 67mr11242319ilv.283.1611814573141;
 Wed, 27 Jan 2021 22:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20210127045422.2418917-1-hsinyi@chromium.org> <20210127045422.2418917-9-hsinyi@chromium.org>
 <1611814421.28312.9.camel@mtksdaap41>
In-Reply-To: <1611814421.28312.9.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 28 Jan 2021 14:15:47 +0800
Message-ID: <CAJMQK-gHjmm-BaG83EXMOkT6KeCyJJN4ZqRDdT75BcED53bREw@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] drm/mediatek: add DDP support for MT8183
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 2:13 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Hsin-Yi:
>
> Modify the title's prefix to 'soc: mediatek:'
>
> On Wed, 2021-01-27 at 12:54 +0800, Hsin-Yi Wang wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> >
> > Add DDP support for MT8183 SoC.
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/soc/mediatek/mtk-mutex.c | 50 ++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> > index f531b119da7a9..f64e9c33e85ad 100644
> > --- a/drivers/soc/mediatek/mtk-mutex.c
> > +++ b/drivers/soc/mediatek/mtk-mutex.c
> > @@ -14,6 +14,8 @@
> >
> >  #define MT2701_MUTEX0_MOD0                   0x2c
> >  #define MT2701_MUTEX0_SOF0                   0x30
> > +#define MT8183_DISP_MUTEX0_MOD0                      0x30
> > +#define MT8183_DISP_MUTEX0_SOF0                      0x2c
>
> Modify 'DISP_MUTEX' to 'MUTEX'
>
> >
> >  #define DISP_REG_MUTEX_EN(n)                 (0x20 + 0x20 * (n))
> >  #define DISP_REG_MUTEX(n)                    (0x24 + 0x20 * (n))
> > @@ -37,6 +39,18 @@
> >  #define MT8167_MUTEX_MOD_DISP_DITHER         15
> >  #define MT8167_MUTEX_MOD_DISP_UFOE           16
> >
> > +#define MT8183_MUTEX_MOD_DISP_RDMA0          0
> > +#define MT8183_MUTEX_MOD_DISP_RDMA1          1
> > +#define MT8183_MUTEX_MOD_DISP_OVL0           9
> > +#define MT8183_MUTEX_MOD_DISP_OVL0_2L                10
> > +#define MT8183_MUTEX_MOD_DISP_OVL1_2L                11
> > +#define MT8183_MUTEX_MOD_DISP_WDMA0          12
> > +#define MT8183_MUTEX_MOD_DISP_COLOR0         13
> > +#define MT8183_MUTEX_MOD_DISP_CCORR0         14
> > +#define MT8183_MUTEX_MOD_DISP_AAL0           15
> > +#define MT8183_MUTEX_MOD_DISP_GAMMA0         16
> > +#define MT8183_MUTEX_MOD_DISP_DITHER0                17
> > +
> >  #define MT8173_MUTEX_MOD_DISP_OVL0           11
> >  #define MT8173_MUTEX_MOD_DISP_OVL1           12
> >  #define MT8173_MUTEX_MOD_DISP_RDMA0          13
> > @@ -87,6 +101,12 @@
> >  #define MT2712_MUTEX_SOF_DSI3                        6
> >  #define MT8167_MUTEX_SOF_DPI0                        2
> >  #define MT8167_MUTEX_SOF_DPI1                        3
> > +#define MT8183_MUTEX_SOF_DSI0                        1
> > +#define MT8183_MUTEX_SOF_DPI0                        2
> > +
> > +/* Add EOF setting so overlay hardware can receive frame done irq */
> > +#define MT8183_MUTEX_EOF_DSI0                        (MT8183_MUTEX_SOF_DSI0 << 6)
> > +#define MT8183_MUTEX_EOF_DPI0                        (MT8183_MUTEX_SOF_DPI0 << 6)
> >

Hi CK, comment is added here. I can move to mt8183_mutex_sof if preferred.

> >  struct mtk_mutex {
> >       int id;
> > @@ -181,6 +201,20 @@ static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> >       [DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
> >  };
> >
> > +static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> > +     [DDP_COMPONENT_AAL0] = MT8183_MUTEX_MOD_DISP_AAL0,
> > +     [DDP_COMPONENT_CCORR] = MT8183_MUTEX_MOD_DISP_CCORR0,
> > +     [DDP_COMPONENT_COLOR0] = MT8183_MUTEX_MOD_DISP_COLOR0,
> > +     [DDP_COMPONENT_DITHER] = MT8183_MUTEX_MOD_DISP_DITHER0,
> > +     [DDP_COMPONENT_GAMMA] = MT8183_MUTEX_MOD_DISP_GAMMA0,
> > +     [DDP_COMPONENT_OVL0] = MT8183_MUTEX_MOD_DISP_OVL0,
> > +     [DDP_COMPONENT_OVL_2L0] = MT8183_MUTEX_MOD_DISP_OVL0_2L,
> > +     [DDP_COMPONENT_OVL_2L1] = MT8183_MUTEX_MOD_DISP_OVL1_2L,
> > +     [DDP_COMPONENT_RDMA0] = MT8183_MUTEX_MOD_DISP_RDMA0,
> > +     [DDP_COMPONENT_RDMA1] = MT8183_MUTEX_MOD_DISP_RDMA1,
> > +     [DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
> > +};
> > +
> >  static const unsigned int mt2712_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
> >       [MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
> >       [MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
> > @@ -198,6 +232,12 @@ static const unsigned int mt8167_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
> >       [MUTEX_SOF_DPI1] = MT8167_MUTEX_SOF_DPI1,
> >  };
> >
> > +static const unsigned int mt8183_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
> > +     [MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
> > +     [MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0 | MT8183_MUTEX_EOF_DSI0,
> > +     [MUTEX_SOF_DPI0] = MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF_DPI0,
>
> According to discussion in [1], add comment for the odd EOF setting.
>
> [1]
> https://patchwork.kernel.org/project/linux-mediatek/patch/1595469798-3824-8-git-send-email-yongqiang.niu@mediatek.com/
>
> Regards,
> CK.
>
>
> > +};
> > +
> >  static const struct mtk_mutex_data mt2701_mutex_driver_data = {
> >       .mutex_mod = mt2701_mutex_mod,
> >       .mutex_sof = mt2712_mutex_sof,
> > @@ -227,6 +267,14 @@ static const struct mtk_mutex_data mt8173_mutex_driver_data = {
> >       .mutex_sof_reg = MT2701_MUTEX0_SOF0,
> >  };
> >
> > +static const struct mtk_mutex_data mt8183_mutex_driver_data = {
> > +     .mutex_mod = mt8183_mutex_mod,
> > +     .mutex_sof = mt8183_mutex_sof,
> > +     .mutex_mod_reg = MT8183_DISP_MUTEX0_MOD0,
> > +     .mutex_sof_reg = MT8183_DISP_MUTEX0_SOF0,
> > +     .no_clk = true,
> > +};
> > +
> >  struct mtk_mutex *mtk_mutex_get(struct device *dev)
> >  {
> >       struct mtk_mutex_ctx *mtx = dev_get_drvdata(dev);
> > @@ -457,6 +505,8 @@ static const struct of_device_id mutex_driver_dt_match[] = {
> >         .data = &mt8167_mutex_driver_data},
> >       { .compatible = "mediatek,mt8173-disp-mutex",
> >         .data = &mt8173_mutex_driver_data},
> > +     { .compatible = "mediatek,mt8183-disp-mutex",
> > +       .data = &mt8183_mutex_driver_data},
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
>
