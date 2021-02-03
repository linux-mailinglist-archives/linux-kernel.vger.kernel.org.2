Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E430DF82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhBCQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:17:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234928AbhBCQOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:14:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78BDD64FA3;
        Wed,  3 Feb 2021 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612368832;
        bh=LC9OXHbkmbODTVan4GjYicX/tmgRGEDCOAypuGP002Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PQImXGeQ27g9pWi9pTRz79rlBC+Z/rOMfQfsE48RrMxum/fNN9EqDozK757TIiUOq
         fUCdSojcLSbLicSOmhLKsK06YUx/YXdglPNcFiLm6ba1mGWcWGtHfoqv+pFEuvQSTd
         daEcg2Qoj3pv9q6oee6Y6OtB85FRGo4hz07p+xgrd9LyiNW1lgFhlM7R78oFvUe8/B
         DNTlG+gNe9748OVkwA/Up8mrpmhKevTahGimfddMia6zqkISfLtkCtpgNPLXsBHDtT
         BXzAUds6JJ7KeEsCpVtZY1Dms1/COUxMgtEbmHz0kzPBo6u2xMZlNOi6WkE4mPwRjq
         akS91Qfn5h/mw==
Received: by mail-ej1-f49.google.com with SMTP id i8so20213554ejc.7;
        Wed, 03 Feb 2021 08:13:52 -0800 (PST)
X-Gm-Message-State: AOAM5320g2F9f8JhYzkgKGuOUdmDwAGcTJgxFiTJQilCTIxzN3O0+OAS
        pJiui2vDj9p9oNki3MPwRGWlnvD669v8zAnMeA==
X-Google-Smtp-Source: ABdhPJybqLj1SNuzvTeyri0ZANhZswWzGp11dtUOf1eekuNSDPoExd5Kl4ZRSB5xaVfeOFOu8R2haSrcO7uCyqI0vgA=
X-Received: by 2002:a17:906:bce2:: with SMTP id op2mr3960888ejb.127.1612368830940;
 Wed, 03 Feb 2021 08:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20210202081237.774442-1-hsinyi@chromium.org> <20210202081237.774442-6-hsinyi@chromium.org>
In-Reply-To: <20210202081237.774442-6-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 4 Feb 2021 00:13:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9YhT5hM7QUQrkk=q-aiyCvBVr2B9ErvcL2Wj-UiEOfnA@mail.gmail.com>
Message-ID: <CAAOTY_9YhT5hM7QUQrkk=q-aiyCvBVr2B9ErvcL2Wj-UiEOfnA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] drm/mediatek: Fix ccorr size config
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=882=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> Fix setting to follow hardware datasheet. The original error setting
> affects mt8192 display.
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/=
mediatek/mtk_disp_ccorr.c
> index 6ee2431e6b843..6c86673a835c3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -65,7 +65,7 @@ void mtk_ccorr_config(struct device *dev, unsigned int =
w,
>  {
>         struct mtk_disp_ccorr *ccorr =3D dev_get_drvdata(dev);
>
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, &ccorr->cmdq_reg, ccorr->reg=
s,
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, &ccorr->cmdq_reg, ccorr->reg=
s,
>                       DISP_CCORR_SIZE);
>         mtk_ddp_write(cmdq_pkt, CCORR_ENGINE_EN, &ccorr->cmdq_reg, ccorr-=
>regs,
>                       DISP_CCORR_CFG);
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
