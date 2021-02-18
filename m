Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C131F2DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBRXRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBRXRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:17:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35C0F64EBD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613690210;
        bh=aW+nfXzGr6YQmTzI2tfVJF8MdeeL5uIdMHjY7lwwVVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z2G4ExpesHWzEjiNcF9bro3mq6wOnWPLirDm4/mu5x5n4MK8vfXxX+jlm+iXfhayh
         YumLXHmWoToUP/i4HfwDutjzEonGb3vy1TARRUDK3bTWaXvYM0EGQMx8sWbZiQ9lBy
         Fbc7MDAf1B3jaLnAFsF+NgfniO+n7AgP7WarX7X995O3vr38ILU1VTTpsVHKUpRxWL
         AQL53DIzEmoz2132nFNgSJ+RPwR9paez/rLBX/SbyEXRSldhuBhYpj1Tiqr2AgUfg3
         GtToAxJPwRrGvghk2chzPpdaEe/L12vRcgNkuUGd5k/xAHvLp9jzmmL+wrf+HaNRao
         qz+yieTM7sXJQ==
Received: by mail-ed1-f41.google.com with SMTP id j9so6472823edp.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:16:50 -0800 (PST)
X-Gm-Message-State: AOAM530+iS2DiR8lIJVHoLumEEyAYTDPGAIRyhDvwDsWb3Iz2dRGcIuT
        qDqVtm9CMqvFf0mCbSaFh0aBLc/Gor8TKIU2jA==
X-Google-Smtp-Source: ABdhPJzi8DSty2zCOLtG9xQlyj8HJl1SyN7gvBBx+ROaxLsI2m1FeXFzb1bvqlyTy48OCFAPnepjZlyhBkumEy3crTo=
X-Received: by 2002:a05:6402:c91:: with SMTP id cm17mr6470189edb.219.1613690208700;
 Thu, 18 Feb 2021 15:16:48 -0800 (PST)
MIME-Version: 1.0
References: <1613633299-88332-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1613633299-88332-1-git-send-email-zou_wei@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 19 Feb 2021 07:16:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8gBi4r1YLyXwYwMt8wAW4zrzdt0ooRgZKU-UrbV2uOTA@mail.gmail.com>
Message-ID: <CAAOTY_8gBi4r1YLyXwYwMt8wAW4zrzdt0ooRgZKU-UrbV2uOTA@mail.gmail.com>
Subject: Re: [PATCH -next] soc / drm: mediatek: Mark mtk_mutex_driver with
 static keyword
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
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

Hi, Zou:

Zou Wei <zou_wei@huawei.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=8818=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Fix the following sparse warning:
>
> drivers/soc/mediatek/mtk-mutex.c:464:24: warning: symbol 'mtk_mutex_drive=
r' was not declared. Should it be static?
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-=
mutex.c
> index f531b11..3a315a6 100644
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
> --
> 2.6.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
