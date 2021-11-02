Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E66442BD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhKBKv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:51:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B09EC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 03:48:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id o14so5726422pfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJF/dHyk/3IQlaukmeK0wLdUdqN/AGJrVLVkId2ki2M=;
        b=xHwLcaZIYZgTQBtnYpAy69BmDS6ZJvi7f1usoT6wyQxHgK0mVnzvc5qCgCu7DAbzaC
         xE0kTXGb37fSqYGVxBcDw21xo/uVjZGDMqbbn31XJfY7jytObUST+tboLp30x4xIa1Xh
         15lKWjmSHswtL5SfilbBPVoxUKUhw4TRr3gRKwpeK1dPbX6Z531pzSRqG8xPfxgg1wEE
         Vf9lHPNEzERIhxj3nxhWPUOMWShJGybMzpciCQT0xSu8L/oeX1s5ZJmLAoWyWAB9L4IH
         MaA5NnVfx4PGjzFwQLq6iRN2l7Bqe23cdNIuI4Jh8q+vvKvsIw0TZnrecvu3Q5g/qZSI
         9UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJF/dHyk/3IQlaukmeK0wLdUdqN/AGJrVLVkId2ki2M=;
        b=WS3xx7ZJ1SLUfCxM+lNvjbQV3bh5S0nM2B8WXYKCjiNxnf/lG43MZ6YLO+hVup8+I4
         gfhCogwmQfYy3FLlucKiq9ZYc3VDZsqtiodqHuvqLgzqGwbctUj9mJqvYubjnU2ybU2x
         KUNzITZK8B1sHJncX49ewQFigT8/oQQjG3Z5H0nFOrwY1UYw3NXVB2g8M43HAbw1D4J5
         5syHbjJI2jZpd+G8KEAYWmTvgfOdOkBPYcAfHA15L8CZXwTPV55B6FNpZzaYs6vb8skA
         A9gzeQS91WDfhDxmjf4ORT4AWsmZ1XNNRWdG8qkPjvrOGY+2VfIb+4U/jaM3rJ8qnjh3
         kwwg==
X-Gm-Message-State: AOAM5325Mp9wqZi+0psDw58ZxcgTTy0gUfjO7zwjzyprOwc5TeBFYuFb
        jSRyTSA9+K0opinzBHOHZ7xvSJxQe6ywo7Bt7mitvQ==
X-Google-Smtp-Source: ABdhPJxf7ODLAmRwZb/6gWx5MMwlIfSbftXWQI/+7QaNqZg+PvaL+AL65TDTHnzYCihEIh32pgIL0MF/oUcUsHDaS10=
X-Received: by 2002:a63:6c43:: with SMTP id h64mr21356842pgc.306.1635850131950;
 Tue, 02 Nov 2021 03:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210915223117.7857-1-jitao.shi@mediatek.com> <20210915223117.7857-4-jitao.shi@mediatek.com>
 <a16150b6b10dca4bf961b8e02b5e4d940b98468c.camel@mediatek.com> <20211102015631.GA2248315@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20211102015631.GA2248315@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 2 Nov 2021 11:48:40 +0100
Message-ID: <CAG3jFyvBRSDHkiVx--H84eoeDvDXYQN4YRvsLhfX7_M+15KVmA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] drm/bridge: anx7625: config hs packets end aligned
 to avoid screen shift
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ck.hu@mediatek.com,
        stonea168@163.com, huijuan.xie@mediatek.com,
        rex-bc.chen@mediatek.com, shuijing.li@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2021 at 02:56, Xin Ji <xji@analogixsemi.com> wrote:
>
> On Mon, Nov 01, 2021 at 11:16:15AM +0800, Jitao Shi wrote:
> > Hi Xin,
> >
> > Please help to review the changes in anx7625.c
> >
> > On Thu, 2021-09-16 at 06:31 +0800, Jitao Shi wrote:
> > > This device requires the packets on lanes aligned at the end to fix
> > > screen shift or scroll.
> > >
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index 14d73fb1dd15..d76fb63fa9f7 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -1327,6 +1327,7 @@ static int anx7625_attach_dsi(struct
> > > anx7625_data *ctx)
> > >             MIPI_DSI_MODE_VIDEO_SYNC_PULSE  |
> > >             MIPI_DSI_MODE_NO_EOT_PACKET     |
> > >             MIPI_DSI_MODE_VIDEO_HSE;
> > > +   dsi->hs_packet_end_aligned = true;
>
> Looks good, it's OK for me.
> Reviewed-by: Xin Ji <xji@analogixsemi.com>

Acked-by: Robert Foss <robert.foss@linaro.org>
