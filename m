Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04CE39AF53
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFDBF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhFDBFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:05:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83F046140F;
        Fri,  4 Jun 2021 01:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622768650;
        bh=l5yYOLt53DtZ7JqLyg7mT/GGJahw6tz3rKT8zzg2gQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=anSV0Ox8mgv2AQd6aPZovUXvAyDJWN7zwYddRLCE5/2nulr5oqBkdD5ZsfvlXYkmi
         VHI2U2kdwKD77tGNxO7hjvIQErCdQ6WyxZWp8tG5d6Or5nhgGOIsMAWCvx8aj/r1qF
         97a+Ur72XCvsPmyN/7zrpEvIKZA71ecXAcMlRrza/uiUOIUWQQux11fjLJdXkRKYMg
         8emu3l/sIXwayKy5NAZFwr+n8m0+9MKj53XTkLH3ZIGztK0dbDvNNWIXq5o3EN1Rp+
         YO82Mny3wu9Jvz5MSMiAIs4LzN60ADFRna9Rtv88zZtEsMRgOQ7YYCKAHCvWFeKKk5
         F2OEs5qf58P6g==
Received: by mail-ej1-f42.google.com with SMTP id jt22so11930409ejb.7;
        Thu, 03 Jun 2021 18:04:10 -0700 (PDT)
X-Gm-Message-State: AOAM533OLRXNT6kIBxmTWsGPd/H/U9VGLkRb/XYENleZHzqCQTRSgnOH
        GDUfiF1FHabkUK8umEoeEUajNPPSLKhC1LcHBA==
X-Google-Smtp-Source: ABdhPJxer8gjIEGn3TOCrAdEk57FxI38GSPQm8Wp2vKQJjgd6J8CtpXQyqAafZh7oMz3+6B59LNg4FnKxVIxXoDbH1w=
X-Received: by 2002:a17:906:3d9:: with SMTP id c25mr1792745eja.63.1622768649092;
 Thu, 03 Jun 2021 18:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210526085219.7582-1-rex-bc.chen@mediatek.com>
In-Reply-To: <20210526085219.7582-1-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 4 Jun 2021 09:03:57 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-huV+QqUsLF5PwXA_7OMfJn3X9=9kUM-aY-_thn54kSg@mail.gmail.com>
Message-ID: <CAAOTY_-huV+QqUsLF5PwXA_7OMfJn3X9=9kUM-aY-_thn54kSg@mail.gmail.com>
Subject: Re: [v5,PATCH 0/3] mt8183 dpi supports dual edge
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rex:

For this series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

Rex-BC Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:52=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> v5:
> Remove ddr_edge_sel and use output_fmts to determine
> which edge to be set.
>
> v4:
> Use output_fmts to determine whether it is dual edge.
> Rebase to v5.13-rc1
>
> v3:
> Modify clock rate for dual edge setting.
> Add more bridge function.
>
> v2:
> Modify unused code
>
> v1:
> DPI can sample on falling, rising or both edge.
> When DPI sample the data both rising and falling edge.
> It can reduce half data io pins.
>
> Rex-BC Chen (3):
>   [v5] drm/mediatek: dpi dual edge sample mode support
>   [v5] drm/mediatek: config driver data to support dual edge sample
>   [v5] drm/mediatek: dpi: add bus format negotiation
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 130 +++++++++++++++++++++++++++--
>  1 file changed, 124 insertions(+), 6 deletions(-)
>
> --
> 2.18.0
>
