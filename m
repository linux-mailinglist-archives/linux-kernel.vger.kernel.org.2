Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD5133FC32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCRAYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhCRAYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:24:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFC5364E42
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616027051;
        bh=p6PEaph2u8ios6gltNUavvYhOGS187eCou4MgdO3Fbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lo3/9xI377wnkqkFHWz4/aGIG0YwtWvM9RVVl1u8oi86jJjYcy6MnQy7Z5QIo8EGW
         2byJtLdwK9affsW4A+KPNJjQTc7gwfeAwJ5UJ/tRN/Pp4oXjM6ZPFRzDpmG1eIoLyV
         qxlooaxDB6pGXpnb+iCUJd3P76QJqlMWJ7Bea5RqaMYPHun7MDLH3D8oPQ54bd2Qzz
         FLHV03rKqdjg1rGTey1O8SoiTZKodPmd1pOYM7PlX6pWMg5trats2QuFIQkxEpzPBn
         V8c5pefw8BUi+KyJKQvE++yeRgqMaOljr1oUo88A/ARQ5i24MaQcrVF1QD8sneA9+7
         VPPWDkEzp48vg==
Received: by mail-ej1-f47.google.com with SMTP id l4so1168978ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 17:24:10 -0700 (PDT)
X-Gm-Message-State: AOAM5307uK6tikASSmn75bLPmT9WyeCus6CJWICKmYxZxtwhLDPOUlsi
        qNk4ArHB/RgBRn4ZqYQ0TxyCYRUT6ZC2PKxUCA==
X-Google-Smtp-Source: ABdhPJwl0sxRTizbicTK0xRvRINhzU0QimeYmr7XbstUaY16PHVXUP4gL+Bk4D2R+s0MFSs2qYLvjNQoeYEac9DwLXg=
X-Received: by 2002:a17:906:3750:: with SMTP id e16mr37952648ejc.75.1616027049177;
 Wed, 17 Mar 2021 17:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210210075656.1096251-1-weiyongjun1@huawei.com>
In-Reply-To: <20210210075656.1096251-1-weiyongjun1@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 18 Mar 2021 08:23:58 +0800
X-Gmail-Original-Message-ID: <CAAOTY__hAcEHoeebdVCNaaay7OmbgrfBx5r7EfhuU9mNEy0ELw@mail.gmail.com>
Message-ID: <CAAOTY__hAcEHoeebdVCNaaay7OmbgrfBx5r7EfhuU9mNEy0ELw@mail.gmail.com>
Subject: Re: [PATCH -next] soc: mediatek: Make symbol 'mtk_mutex_driver' static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongjun:

Wei Yongjun <weiyongjun1@huawei.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The sparse tool complains as follows:
>
> drivers/soc/mediatek/mtk-mutex.c:464:24: warning:
>  symbol 'mtk_mutex_driver' was not declared. Should it be static?
>
> This symbol is not used outside of mtk-mutex.c, so this
> commit marks it static.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-=
mutex.c
> index f531b119da7a..3a315a62e783 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -461,7 +461,7 @@ static const struct of_device_id mutex_driver_dt_matc=
h[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
>
> -struct platform_driver mtk_mutex_driver =3D {
> +static struct platform_driver mtk_mutex_driver =3D {
>         .probe          =3D mtk_mutex_probe,
>         .remove         =3D mtk_mutex_remove,
>         .driver         =3D {
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
