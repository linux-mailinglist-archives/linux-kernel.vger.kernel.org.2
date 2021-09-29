Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0041C699
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbhI2O1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344142AbhI2O1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:27:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C15613A5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632925554;
        bh=ZGb4yqh1nPtEYCv4RvHM7PlTAFacEYbqMVPw6nqFgOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V89c8WIfJQZw4M8a6cw16/bFZ/YZ1evPqVxFgYS/fnZTCpME9rugoIZiK4HtL7JBW
         fOXv1oAjUukHopVY7LbiJQRi/chkbOnN2Y9UCmQ683t6LDrKicLQBP44/YYGMMhw0l
         YHhU/183XzF/2p1QJZcMK7Jv0PUUPxvSOLeYms5FhkYAYSYjPV/42g/mn13jKEjSG7
         NXRQl79eRhpyPxCfdZmx0pEvhAPWieRg8K2SoQhB458rtn7G0xJKMa6BfdeuWtkTOf
         4evtk1tKi/eXUR5qNphwDiIAVpD5vK++bu5B6VE1BJ/hgqydvUvSdh9ZKe8ULhEftF
         tZuGBAmd6PzdA==
Received: by mail-ed1-f48.google.com with SMTP id g7so9394363edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:25:54 -0700 (PDT)
X-Gm-Message-State: AOAM530tZiWfo0Uk1NcoKYAke4dL/ypjhS0R/SC1B78UBKXPCjq3+0jH
        GDFoW71ltONvGXZ8YdncTkcT9G/qTbrs+o6xIg==
X-Google-Smtp-Source: ABdhPJztUQV6mUUhuDTI4I/p92kupxXO6TA7RUcPtotbiON+mjFs+3ZU+SbG4g7KNd8En3rvWJYLcNEx7NGZsnJNf/A=
X-Received: by 2002:a17:906:26c4:: with SMTP id u4mr13607283ejc.511.1632925517893;
 Wed, 29 Sep 2021 07:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210808234733.14782-1-chunkuang.hu@kernel.org>
 <CAAOTY_9LstZegE_Gyibov5tLo5eEqiPfoAcnyj_uoS=8xLLhnA@mail.gmail.com>
 <CAFqH_53M2OO8DpkPa3L7cwppVRYiUgEDjrLjK7JJNgKgxnQpVA@mail.gmail.com>
 <CAAOTY__4ZKf8YwJWMHkiZRjbcnDuf4tcVPO=AG1V3pv9_-4bVw@mail.gmail.com>
 <CAFqH_51Vtq=AkZaV2A69-FAVohr2DyD=1cjKkQ-hStQ4GXRnPA@mail.gmail.com> <CAAOTY__dgkSnYnEhYaFsF2G9f+iiBYeA4VhV7gBcrGY6NU_bgg@mail.gmail.com>
In-Reply-To: <CAAOTY__dgkSnYnEhYaFsF2G9f+iiBYeA4VhV7gBcrGY6NU_bgg@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 29 Sep 2021 22:25:06 +0800
X-Gmail-Original-Message-ID: <CAAOTY_82aRxan4WPG5MjZRDcOLzQ1p-xyyuXST0QwYB7KRKMMA@mail.gmail.com>
Message-ID: <CAAOTY_82aRxan4WPG5MjZRDcOLzQ1p-xyyuXST0QwYB7KRKMMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] CMDQ refinement of Mediatek DRM driver
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
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

+Jason:

Hi, Enric:

Please test Jason's series [1], [2]. Does these series fixes your problem?

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D5547=
59
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D5547=
67

Regards,
Chun-Kuang.

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B49=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Enric:
>
> Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:36=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi Chun-Kuang,
> >
> > Missatge de Chun-Kuang Hu <chunkuang.hu@kernel.org> del dia dt., 21 de
> > set. 2021 a les 15:15:
> > >
> > > Hi, Enric:
> > >
> > > Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2021=E5=B9=B49=
=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > >
> > > > Hi Chun-Kuang,
> > > >
> > > > (again without html format, sorry for the noise)
> > > >
> > > > Missatge de Chun-Kuang Hu <chunkuang.hu@kernel.org> del dia dj., 12
> > > > d=E2=80=99ag. 2021 a les 2:13:
> > > > >
> > > > > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B48=
=E6=9C=889=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:47=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > >
> > > > > > These refinements include using standard mailbox callback inter=
face,
> > > > > > timeout detection, and a fixed cmdq_handle.
> > > > >
> > > > > For this series, applied to mediatek-drm-next [1].
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/=
linux.git/log/?h=3Dmediatek-drm-next
> > > > >
> > > >
> > > > These patches seem to break the display on the Acer Chromebook R 13
> > > > (MT8173) in the current mainline. After running a bisection it poin=
ted
> > > > me to the following commit
> > > >
> > > > commit f4be17cd5b14dd73545b0e014a63ebe9ab5ef837
> > > > Author: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > Date:   Sun Jul 4 15:36:48 2021 +0800
> > > >
> > > >     drm/mediatek: Remove struct cmdq_client
> > > >
> > > > Reverting this patch alone is not trivial, so I ended up reverting =
the
> > > > full series, and I can confirm that reverting the full series makes
> > > > the display work again.
> > >
> > > I think you could not just revert "drm/mediatek: Remove struct
> > > cmdq_client", you should also revert the patches after it, such as
> > >
> > > "drm/mediatek: Clear pending flag when cmdq packet is done"
> > > "drm/mediatek: Add cmdq_handle in mtk_crtc"
> > > "drm/mediatek: Detect CMDQ execution timeout"
> > >
> >
> > Yes, in fact I reverted:
> >
> > 9efb16c2fdd6 drm/mediatek: Clear pending flag when cmdq packet is done
> > bc9241be73d9 drm/mediatek: Add cmdq_handle in mtk_crtc
> > 8cdcb3653424 drm/mediatek: Detect CMDQ execution timeout
> > f4be17cd5b14 drm/mediatek: Remove struct cmdq_client
> > c1ec54b7b5af drm/mediatek: Use mailbox rx_callback instead of cmdq_task=
_cb
> >
> > Without these patches 5.15-rc2 works again on my platform.
> >
> > The commit 'c1ec54b7b5af drm/mediatek: Use mailbox rx_callback instead
> > of cmdq_task_cb' alone introduces lots of warnings in the kernel
> >
> > WARNING: CPU: 0 PID: 0 at drivers/mailbox/mtk-cmdq-mailbox.c:198
> > cmdq_task_exec_done+0xb8/0xe0
>
> I think the WARN_ON in cmdq driver should be remove because that
> warning show that cmdq_task_cb is not used but I that is what I want.
>
> >
> > I think is just a leftover or the mentioned warning, but that confused
> > me a bit doing the bisection. Then, after commit 'f4be17cd5b14
> > drm/mediatek: Remove struct cmdq_client' my system simply gets stuck.
> > For now I don't see any obvious mistake but will dig further.
> >
> > Can I ask you in which platform did you test? And if you can double
> > check if your platform is broken too in current mainline?
>
> I've no environment to test code now. I apply this series because I
> assume Yongqiang has test his patch "Clear pending flag when cmdq
> packet is done".  Before I setup the environment (this may take a long
> time), I would find others to fix this problem.
> According to your information, "c1ec54b7b5af drm/mediatek: Use mailbox
> rx_callback instead of cmdq_task_cb" would cause many warning but
> display still work, right? If so, I think we should focus on
> "f4be17cd5b14 drm/mediatek: Remove struct cmdq_client".
>
> Regards,
> Chun-Kuang.
>
> >
> > Thanks,
> >   Enric
> >
> > > If "drm/mediatek: Remove struct cmdq_client" is the patch cause
> > > display abnormal, I think you could compare code w/ and w/o this
> > > patch. Focus on the value accuracy, such as cmdq_cl and cmdq_chan. An=
d
> > > focus on the flow accuracy, such as mtk_drm_crtc_update_config() and
> > > ddp_cmdq_cb(). If this could not find the problem, I think the latest
> > > way is to break this patch into small patches, changes little in each
> > > small patches and we could finally find out the problem.
> > >
> > > Regards,
> > > Chun-Kuang.
> > >
> > > >
> > > > Unfortunately, after the merge window, different things broke for t=
his
> > > > device, and I didn't finish isolating them, and it is not clear to =
me
> > > > yet whether the logs I'm getting are useful for this specific issue=
 or
> > > > not. Basically with this series merged the kernel seems to be stuck=
,
> > > > and the display is not working. Latest message is
> > > >
> > > > [   12.329173] mtk-iommu 10205000.iommu: Partial TLB flush timed ou=
t,
> > > > falling back to full flush
> > > >
> > > > Without the series, the kernel goes far and display works, however
> > > > there are other issues affecting the cros-ec, but I think that's
> > > > another issue.
> > > >
> > > > I'll try to dig a bit more, but, meanwhile, if you have any idea
> > > > please let me know.
> > > >
> > > > Thanks,
> > > >  Enric
> > > >
> > > >
> > > > > Regards,
> > > > > Chun-Kuang.
> > > > >
> > > > > >
> > > > > > Changes in v2:
> > > > > > 1. Define mtk_drm_cmdq_pkt_create() and mtk_drm_cmdq_pkt_destro=
y()
> > > > > >    when CONFIG_MTK_CMDQ is reachable.
> > > > > >
> > > > > > Chun-Kuang Hu (4):
> > > > > >   drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb
> > > > > >   drm/mediatek: Remove struct cmdq_client
> > > > > >   drm/mediatek: Detect CMDQ execution timeout
> > > > > >   drm/mediatek: Add cmdq_handle in mtk_crtc
> > > > > >
> > > > > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 110 ++++++++++++++++=
++++----
> > > > > >  1 file changed, 91 insertions(+), 19 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
