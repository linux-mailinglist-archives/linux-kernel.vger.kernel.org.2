Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9C351BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbhDASKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236646AbhDARzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC6636128E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617286553;
        bh=pmDesK41LONSTi91JrhFXtlnAIl5KT6c5rqTOesiqVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VGrY4kmH8EHHTWyxrg3HcsoR66tE4YXh6S9mePCOdTaFF339+KqpEgYXhf0wXOpps
         B4QzWM3g3xkRxjzJDVEe96uUqAjIBLZ5tTCEC2Q48OBh0o6zIDveZmFHWJp5aL6AdY
         tUQHpe7f1aO216OG5hDM+3xRg28LePKijAGaX/xD+0Nb3ARQigDVOIpmIvQMcJfcLE
         53HIvikF41lx2C0zoGUeeACL2ZFDEUcAWjOAyVXJ9IAr33ErCZzD4lubqfuXVbpblN
         ZirOsM4TCo0f35jW90aTokhU1P4OvSL6BUdYzpmKbM/MzzfZCpqirryqP2nVSEYJTz
         YLcjoQtXBg0Sw==
Received: by mail-ed1-f50.google.com with SMTP id w18so2186031edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 07:15:52 -0700 (PDT)
X-Gm-Message-State: AOAM530L1vQoagbxB7k2JyLYge+x3ViKx1MeugrPZosTDymaiLfsz0eI
        2L/+AEdSczNIbDdnOjEJyTbRNWJdAE4QfNwPpA==
X-Google-Smtp-Source: ABdhPJx/x1Pvir9uz6tNOKEPJelZRcuER41Ie69i0uJGB6GBrIi38rDSfnM6IWWeLRt5oSU65aB9EXkOeJfnHtfghlI=
X-Received: by 2002:a05:6402:b48:: with SMTP id bx8mr10450006edb.162.1617286551463;
 Thu, 01 Apr 2021 07:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210330110902.14178-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20210330110902.14178-1-dafna.hirschfeld@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 1 Apr 2021 22:15:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9n-VVPPEfLag7uVuPG+iM_NWccWgbyC3Eo9+DGYyz=Gw@mail.gmail.com>
Message-ID: <CAAOTY_9n-VVPPEfLag7uVuPG+iM_NWccWgbyC3Eo9+DGYyz=Gw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] drm/mediatek: Don't support hdmi connector creation
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dafna:

Dafna Hirschfeld <dafna.hirschfeld@collabora.com> =E6=96=BC 2021=E5=B9=B43=
=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:09=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> commit f01195148967 ("drm/mediatek: mtk_dpi: Create connector for bridges=
")
> broke the display support for elm device since mtk_dpi calls
> drm_bridge_attach with the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR
> while mtk_hdmi does not yet support this flag.

For this series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> These three patches fix that by adding support for DRM_BRIDGE_ATTACH_NO_C=
ONNECTOR
> in mtk_hdmi bridge attachment.
>
> changes since v2:
> 1. squash patch 3 with patch 2 to not break bisection
> 2. remove the funtion mtk_hdmi_get_edid and inline its code in mtk_hdmi_b=
ridge_get_edid
> 3. small aligment
>
> changes since v1:
> 1. split the first patch - now the first patch only moves the bridge ops =
to the atomic API
> while the replacement of the field 'conn' with the field '*curr_conn' is =
done in a new third patch.
> 2. in the function 'get_eld' use the current conn only if 'enabled =3D tr=
ue'.
>
> Dafna Hirschfeld (2):
>   drm/mediatek: Switch the hdmi bridge ops to the atomic versions
>   drm/mediatek: Don't support hdmi connector creation
>
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 174 ++++++++++++----------------
>  1 file changed, 71 insertions(+), 103 deletions(-)
>
> --
> 2.17.1
>
