Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB341C78F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbhI2O7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344677AbhI2O7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:59:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A52C613A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632927446;
        bh=m2Q3ldX4i8hJz/lYMTrW/Tc7jkjEgA48T0avsrMIFb0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OS8/FZ05Bwuqc7c8Yy1ebTTrRtR/7Sh9oRAFWvlRbSE+GtdDhVhQbnVJIaynmoVWt
         m4IAX3oh1iS08p/skrS1lSt6hHe2G6wCncmmwuqGK0ZgxHf+1Ygs72Y7fi/upjuMMa
         gyZyOtJ2tbN5qyXOJBW7/Rf+T4AgEejImrVVaIrd1dmvdXSR3vxixr1yKFYsy0R2NZ
         xjzDAevLhcKK0ozr8OsK2+G3i25e3qCEMf5fBPkWeBpjmp02C+mAxVAeMADaSK1fqx
         2AzpH1jc2IwTfgbbpdXp84QfYdWhK29rTVjFi+2n6Wf24AFtCS9XdysC1gI5art90I
         kn9etznjpw1gQ==
Received: by mail-ed1-f45.google.com with SMTP id s17so9583808edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:57:26 -0700 (PDT)
X-Gm-Message-State: AOAM530mhRTPMOSURKb6SoYwMYLCH+ENln8xSJV2PzqWJonxJOr4OgBp
        wVERaZBVsEPbHonRbLQhQXpXpIbWYYTESlWUsw==
X-Google-Smtp-Source: ABdhPJy2oIyAhlML1lKHkEI+GYb7Xf5WZ4jL2sSq+xZsFvjhx2y5gie/l/Dq825/3UzuJiV9rAUHrF0xKV//SQBZD0k=
X-Received: by 2002:a17:906:7ac4:: with SMTP id k4mr178848ejo.430.1632927358007;
 Wed, 29 Sep 2021 07:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210929070235.4290-1-jason-jh.lin@mediatek.com> <20210929070235.4290-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20210929070235.4290-4-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 29 Sep 2021 22:55:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY__XmEYNbQJh0o-V-DS7F-_s1a9m54+FuOMwHGBCwx55Wg@mail.gmail.com>
Message-ID: <CAAOTY__XmEYNbQJh0o-V-DS7F-_s1a9m54+FuOMwHGBCwx55Wg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/mediatek: Fix cursor plane is not config when
 primary is updating
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, fshao@chromium.org,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:02=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> If cursor plane has updated but primary plane config task is not
> finished, mtk_drm_crtc_update_config will call mbox_flush() to clear
> all task in current GCE thread and let cursor plane re-send a new
> GCE task with cursor + primary plane config to replace the unfinished
> GCE task.
>
> So the plane config flag should not be cleared when mailbox callback
> with a error status.
>
> Fixes: 9efb16c2fdd6 ("drm/mediatek: Clear pending flag when cmdq packet i=
s done")
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 06342df2a0be..fb0d9424acec 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -281,6 +281,9 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void =
*mssg)
>         struct mtk_crtc_state *state;
>         unsigned int i;
>
> +       if (data->sta !=3D 0)

data->sta is now the standard error code, so data->sta < 0 is an error.

Regards,
Chun-Kuang.

> +               return;
> +
>         state =3D to_mtk_crtc_state(mtk_crtc->base.state);
>
>         state->pending_config =3D false;
> --
> 2.18.0
>
