Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9383144BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBIAPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBIAPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:15:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C010864E9A;
        Tue,  9 Feb 2021 00:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612829689;
        bh=WoOjxOk8JYT5efEA7HSlP75glTYtvejfp2tn/9Mzzhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uhvbNFS8wAXY/9NR9b9Mamz2DDgTkOxSf0m+sS3XnHkntYhctfd+Og/wgum0T3w89
         VBJ+jSBK0/8q0KCXLhXEj/nn68fTc4mCA5pUK4qmaMzgqpheVMuLuwdWZgr/JPPGM+
         ecHKZsDLK1GoK/i97a7Ln05r11oJrlIDTtMzLz9grN7/Qz2el8KugzIzV9r8qYGsMn
         B8cPY0Byq7D8EXnXdON5ZRzZPo9EdxGKaP16TZUNUA9qXGbUiKTagPJ5Wfv+rqizzg
         Wn1vYf0VDjE+HbR/n5pb/7nJjNqULTLjd2+qWyeQj/Uj8JUI8FWDTu0PGeD4xU60f8
         IET+D4ponC/uA==
Received: by mail-ed1-f51.google.com with SMTP id g10so21415076eds.2;
        Mon, 08 Feb 2021 16:14:48 -0800 (PST)
X-Gm-Message-State: AOAM530l5PF8iu0iPATT4Tt+Q6jt3pS8gpAG35O3zT2RyCAknakZcZa9
        8Pvft8dXKTxZtdY7bValz/a2PrQuvWiRKwkXpA==
X-Google-Smtp-Source: ABdhPJwZu/LT//WuvGKVPlXuTP7AnCe2WDHnPiD5yYbRvAimq56Exf9C2zmxxRxrJUSZmx3eYYMvY1jDe0iuuqPDiF4=
X-Received: by 2002:a05:6402:1711:: with SMTP id y17mr19613530edu.72.1612829687397;
 Mon, 08 Feb 2021 16:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20210208014221.196584-1-jitao.shi@mediatek.com> <20210208014221.196584-3-jitao.shi@mediatek.com>
In-Reply-To: <20210208014221.196584-3-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 9 Feb 2021 08:14:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9i0yQ5eg-X_AKXd=sj=6qxbeB8QgaziN-Sw2146iHPKA@mail.gmail.com>
Message-ID: <CAAOTY_9i0yQ5eg-X_AKXd=sj=6qxbeB8QgaziN-Sw2146iHPKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/mediatek: mtk_dpi: Add dpi config for mt8192
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        CK Hu <ck.hu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>, stonea168@163.com,
        huijuan.xie@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, shuijing.li@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=889:42=E5=AF=AB=E9=81=93=EF=BC=9A

Where is the description? Say something here.

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index ffa4a0f1989f..f6f71eb67ff1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -703,6 +703,12 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
>         .max_clock_khz =3D 100000,
>  };
>
> +static const struct mtk_dpi_conf mt8192_conf =3D {
> +       .cal_factor =3D mt8183_calculate_factor,
> +       .reg_h_fre_con =3D 0xe0,
> +       .max_clock_khz =3D 150000,
> +};
> +
>  static int mtk_dpi_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -837,6 +843,9 @@ static const struct of_device_id mtk_dpi_of_ids[] =3D=
 {
>         { .compatible =3D "mediatek,mt8183-dpi",
>           .data =3D &mt8183_conf,
>         },
> +       { .compatible =3D "mediatek,mt8192-dpi",
> +         .data =3D &mt8192_conf,
> +       },
>         { },
>  };
>
> --
> 2.25.1
