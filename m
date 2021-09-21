Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B363A4133E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhIUNRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhIUNRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47369611BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632230132;
        bh=iZqPsCMg2X8Aef7G1+KUsPh8b0qsPVUuFvS5wZqe3BM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RiHl2+YmmS2iTLX8VB3ByxLW7a5rCW/rzAKFF3JQNG2I5c+o1rlvkMdZcx8yu+NYY
         ODGdkpsj9NigjFKSquD3f1TK/6DAx9ANUla+72pXsJvnLVDkLzjtHKYIoNGK+VbAPx
         HPSkUfRo94MOglM9BUe1mrAlwq/a9PFs7JRJeyIVi9T68Jh7QT+PWDF2Tyo7hLKaRg
         e4CYVXHpzp0hhmOo0SeCJP57AlAf7kLOsCk1STARc1EIHFiX7q/bq2HV0+PZ4Yxug9
         3te0MpviijLkigJ3MASCBp8NCC9BnoujMHda+v2RCIgFcZ9opLC/HLB9/6N/AwfHKc
         URI+tHkN+Qd8Q==
Received: by mail-ed1-f54.google.com with SMTP id v5so72613395edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:15:32 -0700 (PDT)
X-Gm-Message-State: AOAM5317oHIp6ReReW9Po5DH4BdUIc3YEneHgT1pJkjtCx1IPiPQv8nW
        Wy+sGywsA/eFeE3k8dYUm4fGHe70k0orYxjBWg==
X-Google-Smtp-Source: ABdhPJzaQNMtEpU87qL4MJS8buFNHtKvHR7CLm3B8cBLx5LTsELv+5n4wF+8USFNS/0L8V+CNT/arQ73tExqtgeNbFA=
X-Received: by 2002:a17:907:995a:: with SMTP id kl26mr35090782ejc.6.1632230052399;
 Tue, 21 Sep 2021 06:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210808234733.14782-1-chunkuang.hu@kernel.org>
 <CAAOTY_9LstZegE_Gyibov5tLo5eEqiPfoAcnyj_uoS=8xLLhnA@mail.gmail.com> <CAFqH_53M2OO8DpkPa3L7cwppVRYiUgEDjrLjK7JJNgKgxnQpVA@mail.gmail.com>
In-Reply-To: <CAFqH_53M2OO8DpkPa3L7cwppVRYiUgEDjrLjK7JJNgKgxnQpVA@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 21 Sep 2021 21:14:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY__4ZKf8YwJWMHkiZRjbcnDuf4tcVPO=AG1V3pv9_-4bVw@mail.gmail.com>
Message-ID: <CAAOTY__4ZKf8YwJWMHkiZRjbcnDuf4tcVPO=AG1V3pv9_-4bVw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] CMDQ refinement of Mediatek DRM driver
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Chun-Kuang,
>
> (again without html format, sorry for the noise)
>
> Missatge de Chun-Kuang Hu <chunkuang.hu@kernel.org> del dia dj., 12
> d=E2=80=99ag. 2021 a les 2:13:
> >
> > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B48=E6=9C=
=889=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:47=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > These refinements include using standard mailbox callback interface,
> > > timeout detection, and a fixed cmdq_handle.
> >
> > For this series, applied to mediatek-drm-next [1].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next
> >
>
> These patches seem to break the display on the Acer Chromebook R 13
> (MT8173) in the current mainline. After running a bisection it pointed
> me to the following commit
>
> commit f4be17cd5b14dd73545b0e014a63ebe9ab5ef837
> Author: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Date:   Sun Jul 4 15:36:48 2021 +0800
>
>     drm/mediatek: Remove struct cmdq_client
>
> Reverting this patch alone is not trivial, so I ended up reverting the
> full series, and I can confirm that reverting the full series makes
> the display work again.

I think you could not just revert "drm/mediatek: Remove struct
cmdq_client", you should also revert the patches after it, such as

"drm/mediatek: Clear pending flag when cmdq packet is done"
"drm/mediatek: Add cmdq_handle in mtk_crtc"
"drm/mediatek: Detect CMDQ execution timeout"

If "drm/mediatek: Remove struct cmdq_client" is the patch cause
display abnormal, I think you could compare code w/ and w/o this
patch. Focus on the value accuracy, such as cmdq_cl and cmdq_chan. And
focus on the flow accuracy, such as mtk_drm_crtc_update_config() and
ddp_cmdq_cb(). If this could not find the problem, I think the latest
way is to break this patch into small patches, changes little in each
small patches and we could finally find out the problem.

Regards,
Chun-Kuang.

>
> Unfortunately, after the merge window, different things broke for this
> device, and I didn't finish isolating them, and it is not clear to me
> yet whether the logs I'm getting are useful for this specific issue or
> not. Basically with this series merged the kernel seems to be stuck,
> and the display is not working. Latest message is
>
> [   12.329173] mtk-iommu 10205000.iommu: Partial TLB flush timed out,
> falling back to full flush
>
> Without the series, the kernel goes far and display works, however
> there are other issues affecting the cros-ec, but I think that's
> another issue.
>
> I'll try to dig a bit more, but, meanwhile, if you have any idea
> please let me know.
>
> Thanks,
>  Enric
>
>
> > Regards,
> > Chun-Kuang.
> >
> > >
> > > Changes in v2:
> > > 1. Define mtk_drm_cmdq_pkt_create() and mtk_drm_cmdq_pkt_destroy()
> > >    when CONFIG_MTK_CMDQ is reachable.
> > >
> > > Chun-Kuang Hu (4):
> > >   drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb
> > >   drm/mediatek: Remove struct cmdq_client
> > >   drm/mediatek: Detect CMDQ execution timeout
> > >   drm/mediatek: Add cmdq_handle in mtk_crtc
> > >
> > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 110 ++++++++++++++++++++--=
--
> > >  1 file changed, 91 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
