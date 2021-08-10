Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240583E58E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhHJLOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhHJLOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:14:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123CC061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:13:54 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y3so4887962ilm.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BOsKHbtULAxcDrxqJDAJDBDyZVhdaKsxydikfZ2cCY=;
        b=le5jpsllsk89jd77pk7klxKwaq6DCVXUZMp+F4J1gkrQMl7VWJ3KdHkPJKe5ZHYwn/
         CT9ld8XxqTbGwtXkgXyRl8EcBOf8HkH4MdbUSlDcVGRHVC/W7ADwJGO1PsavEugYpE/8
         /0O4b7jsrK1uPXXzZinEVKxNoXGV9ueBzh/9yQFm/Pd7smQF94uIeRQuiBlTq4JKnkuk
         lIuLDajRa+ROeCNpYcpfHqgojtrRwjJy7I969VQz1M2UVAzmzlm/fVRmiyiPhXntysyQ
         HVD8lDG1XeS17nXUBZbSSjae0wACMIcGA2k7IztCfTy90GmfayCrXq/+M22hyJxUMcdH
         jkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BOsKHbtULAxcDrxqJDAJDBDyZVhdaKsxydikfZ2cCY=;
        b=GNzXhEOEQvQ6RprenSd85eNdtdhpVvCnTq5E2mNdbvELvPBnHC1rLBDA3I/X4fgKAu
         3mlTy6k70VNY4mBryx6Ul0QCpzU6MP3rHpNta4chPW6O2R933T8zsokLQvPoZgqaSQPc
         lRsI/85LDrAwM9W7y8qY04jATrtXzNdNM0mqERQO4Rvkuzj9jFjxVjp0t5/hdsfKy1Cf
         mut0pk8IKlrZkEKMZUsIGUQOB+O7JIzYfy6absEbwxk6nchT2PPmxWyXimX4fYpFbKVO
         mGFdsggiSXwAkpYvc2oV696LNZ3+4BaXX/ufI1YWGnKO6b57ThSrBDFY7pFHfKVt3k5V
         HXsQ==
X-Gm-Message-State: AOAM533ldlwsZSrj0rsKvWcdkbrKz9yxK7Ag/+mxUinYgej1N29T4s19
        vcdkw79geno+vCvv9QlwUGy/TWI1X+1Gpa8HbJTTkQ==
X-Google-Smtp-Source: ABdhPJxwA6MFGfh+hxoslxEDaOewEk8gaU5fvpAXvmlLfB4gy5x9YiXntNg1S3GQ8DFLdtDoCFGkTnzrhz5SvoHeVsc=
X-Received: by 2002:a05:6e02:d03:: with SMTP id g3mr121789ilj.127.1628594033707;
 Tue, 10 Aug 2021 04:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210810083047.16693-1-yunfei.dong@mediatek.com> <20210810083047.16693-5-yunfei.dong@mediatek.com>
In-Reply-To: <20210810083047.16693-5-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 10 Aug 2021 19:13:42 +0800
Message-ID: <CA+Px+wUbDU8ZD_TOoWRGT2qXh1KS-jh_P6NUDdUA-GuO8CiFiw@mail.gmail.com>
Subject: Re: [PATCH v4, 04/15] media: mtk-vcodec: Use component framework to
 manage each hardware information
To:     Yunfei Dong <Yunfei.Dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        George Sun <george.sun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 04:30:36PM +0800, Yunfei Dong wrote:
>   > Looking up "mediatek,mtk-vcodec-core" to determine if it uses component framwork sounds like...
>   Add prameter in pdata, for all platform will use compoent after mt8183
>
>   >> +     if (dev->is_comp_supported) {
>   >> +             ret = mtk_vcodec_init_master(dev);
>   >> +             if (ret < 0)
>   >> +                     goto err_component_match;
>   >> +     } else {
>   >> +             platform_set_drvdata(pdev, dev);
>   >> +     }
>   > + Has asked the same question in [1].  Why it removes the
>   > +platform_set_drvdata() above?  mtk_vcodec_init_master() also calls platform_set_drvdata().
>   Must call component_master_add_with_match after platform_set_drvdata for component architecture.
I am confused.  The condition "call component_master_add_with_match
after platform_set_drvdata" is already true even if without the
change.  See below.

> +static int mtk_vcodec_init_master(struct mtk_vcodec_dev *dev)
> +{
> +     struct platform_device *pdev = dev->plat_dev;
> +     struct component_match *match;
> +     int ret;
> +
> +     match = mtk_vcodec_match_add(dev);
> +     if (IS_ERR_OR_NULL(match))
> +             return -EINVAL;
> +
> +     platform_set_drvdata(pdev, dev);
> +     ret = component_master_add_with_match(&pdev->dev, &mtk_vdec_ops, match);
Point [1].

> @@ -311,7 +413,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>               MTK_VCODEC_DEC_NAME);
>       video_set_drvdata(vfd_dec, dev);
>       dev->vfd_dec = vfd_dec;
> -     platform_set_drvdata(pdev, dev);
Point [2].

> @@ -362,8 +463,16 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>       mtk_v4l2_debug(0, "decoder registered as /dev/video%d",
>               vfd_dec->num);
>
> -     return 0;
> +     if (dev->vdec_pdata->is_comp_supported) {
> +             ret = mtk_vcodec_init_master(dev);
Point [3].


The calling sequence is: [2] -> component_master_add_with_match() -> [1] -> [3].

Don't understand why it removes the platform_set_drvdata() at point [2].
