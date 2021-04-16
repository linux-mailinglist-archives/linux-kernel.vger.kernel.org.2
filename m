Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52A7361AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhDPHv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhDPHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:51:26 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DEEC061574;
        Fri, 16 Apr 2021 00:51:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u16so9702529oiu.7;
        Fri, 16 Apr 2021 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tkf19eO+Io33QpEZ9OrMFNNm5052NTcThj0KVfGt26E=;
        b=adlH1/Y2CVaKl1vH5IxrVfUZMgz2Dm6ie2X3uyje5e5//jKV370i8WP3AQHuW3vbUw
         ZR+LGSk9BXwPk7APtR6eguUQm/xqSCu6FWvyCoADVL/xkJa9yJ0to6Ep5QNQsQUa8OQi
         dKJ7CEAM2gi0LExzHs8e0DLKB9jJui5rWFXtjCuEbf9WdkrtbP9PkUpS+dlFuUCBV0m2
         EuCig2dFJc46pPzm4gaUo0QzEWnojq0BumD/utqFClI6ktM2LVk7cPjd52irMEQgbHmH
         0+bNxavCXzaXXZ3IstK/v5s17t7Zui2goTK8NqTOBRQII4pkj6oF9XOxN1JU2z5T0nRn
         Wdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tkf19eO+Io33QpEZ9OrMFNNm5052NTcThj0KVfGt26E=;
        b=mKShCTUmE9R6M+R+jjUML670WjRaAUYA2/A6AYOkL998FJXDwmr9JJ4XCib9LkXYa8
         AfRWYvQeQEhC330uGCjARCpZUpvscRQRC5mD3hO/CSmjfw9xB5O7NEcOcGjSEXYGa4NM
         zbxkmQ1MTnKQ0W7kYLkFvBds5azrWc2imo7aImh4l8u/OdHn9BpsFcsuaj0yGKzEygwP
         DUIe0N3MZXxqlF4fczagxzSnZOijfrpaX1nMzXZi0YWvzt1rgGg6CNsFK2nhktiEEsYC
         OZCVTMfv1+B+Oqh3m3umvajMjn8XGiOF+y7mdoSWJndLKpCzXQyDy7nJEKU4BRSmXprz
         huww==
X-Gm-Message-State: AOAM5307txoOWYJY6nb6rS8QWDT8AVo71bJDl9vNeHdALBjRNCz6keu3
        ReAsYSLrDzRrAZlcfMzwoHdtmyvtsu9z1is2ZY44mJOqckf/2Q==
X-Google-Smtp-Source: ABdhPJz8CjIrb9secSmN82+8dgT65mEJoVfALDHzcnEalMEMeagCfEVWO/3pFoH/4IMU2ZnA4XlvzlP7/zSe0eH/qzY=
X-Received: by 2002:aca:b408:: with SMTP id d8mr5584941oif.47.1618559460006;
 Fri, 16 Apr 2021 00:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <1618236288-1617-1-git-send-email-yongqiang.niu@mediatek.com> <1618236288-1617-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1618236288-1617-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 09:50:50 +0200
Message-ID: <CAFqH_50wSBVHnkzr1+Jh=1pppM7rKwZLjkVwhZnBnO=zEo46CA@mail.gmail.com>
Subject: Re: [PATCH v5, 1/4] soc: mediatek: mmsys: add component OVL_2L2
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        David Airlie <airlied@linux.ie>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongqiang,

Thank you for your patch.

Missatge de Yongqiang Niu <yongqiang.niu@mediatek.com> del dia dl., 12
d=E2=80=99abr. 2021 a les 16:04:
>
> This patch add component OVL_2L2
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  include/linux/soc/mediatek/mtk-mmsys.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 2228bf6..f6b58f9 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -29,6 +29,7 @@ enum mtk_ddp_comp_id {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_OVL_2L0,
>         DDP_COMPONENT_OVL_2L1,
> +       DDP_COMPONENT_OVL_2L2,
>         DDP_COMPONENT_OVL1,
>         DDP_COMPONENT_PWM0,
>         DDP_COMPONENT_PWM1,
> --
> 1.8.1.1.dirty
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
