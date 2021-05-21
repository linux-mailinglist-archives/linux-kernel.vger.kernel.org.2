Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6129C38C153
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhEUIII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhEUIIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:08:07 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B32C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:06:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id t11so19240915iol.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6v2xJJNz+8HWwlmw70n+P9Pe4twee3C0WXLKPwPDcwQ=;
        b=toHvOupgQlvnzTBQKiq/TXqrmEEJULGhFpWLVs2IjH/4pc+gBTPWSyg2tgw0Cc9UgP
         5+xi9qDR2o9BROfVhs3/pUtTnk25OV3Ss34DTIGPFY/is9wTapmxNHYdq8Ih4iNeeo96
         w0Uh6QQrhxyfLaMO/MRMHiEpxwbjN9/x+/eAUC0vArQTdWwu/NXuQpzTSfQCE86C93Zf
         mpI0a//FVwGKmR7jxyU80AEm7Mcx0hXwz2Z5G/Sg/8Gtla2HiE+rJNFabZhICOAjPdJ9
         wmbSkxFpk5Ygw+ybK21UleGsHjKBUTHsM4wnczGkHTYJ6oK0xls1bbblKJXAtU2rKu36
         t1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6v2xJJNz+8HWwlmw70n+P9Pe4twee3C0WXLKPwPDcwQ=;
        b=WmlotomkDq89mTCVH0wjGvCyS1sRr9/mDQKIIeJmx/51s2oesYe7myszvHEz2UroHz
         kpBQ5MwEZRpenuTDzJG67ECXcEHPjYOgT6WAmqy0UxwsZTYAO3mt61qfwtTwsPSgBOcs
         xqNqghA+SxRzkIYR+MFR/dMB0JcNpp2SrpzWRWrssqznotzr00F3zbfPpHP0rewiBs3V
         C2QXTZOi/Wqpdztu3c63o1Xq5fUjgErZvFSsCS8K2OauvILK4KVXINQjO90E8Vd20HNn
         ka3O2A7antizGCgbFFYwCilKrGAP0WtTmGzN97MdvOo7oUNn/WNv+YxdiTConQLpiW/f
         FFzA==
X-Gm-Message-State: AOAM533hQqSSe2/mAgfn9cKw2YPbWAsEHOukfGYDCn6d4In2oMy93Cnd
        jjp8Ss0HS7lvaJ2PzAeRjy9ha6O4o2xBteIRotz2Zg==
X-Google-Smtp-Source: ABdhPJzWY2Pt+BD2l8jM9elECsKBOWmC/DwlAg5MCJ39ci2ZGyWFsesNN6ULPRe8pZX7cOH6JaRW0bkog+XrNt6P3XU=
X-Received: by 2002:a5d:9744:: with SMTP id c4mr10567537ioo.76.1621584403538;
 Fri, 21 May 2021 01:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210521070139.20644-1-irui.wang@mediatek.com> <20210521070139.20644-7-irui.wang@mediatek.com>
In-Reply-To: <20210521070139.20644-7-irui.wang@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 16:06:32 +0800
Message-ID: <CA+Px+wU+6AtcFLxAHrEXOK=E+LhwM2iX0R0JOgBvv-xzGO=Bcw@mail.gmail.com>
Subject: Re: [PATCH v4,6/6] media: mtk-vcodec: Support MT8192 H264 4K encoding
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-media@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 3:02 PM Irui Wang <irui.wang@mediatek.com> wrote:
>         fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
> -       fsize->stepwise = mtk_venc_framesizes;
> +       fsize->stepwise =
> +               (ctx->dev->enc_capability & MTK_VENC_4K_CAPABILITY_ENABLE) ?
> +               mtk_venc_4k_framesizes : mtk_venc_hd_framesizes;

Use a normal if .. else .. is more readable.

> @@ -1210,6 +1231,9 @@ int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
>  {
>         const struct v4l2_ctrl_ops *ops = &mtk_vcodec_enc_ctrl_ops;
>         struct v4l2_ctrl_handler *handler = &ctx->ctrl_hdl;
> +       const u8 h264_max_level =
> +               (ctx->dev->enc_capability & MTK_VENC_4K_CAPABILITY_ENABLE) ?
> +               V4L2_MPEG_VIDEO_H264_LEVEL_5_1 : V4L2_MPEG_VIDEO_H264_LEVEL_4_2;

Again, I would like it to be a normal if .. else ..
