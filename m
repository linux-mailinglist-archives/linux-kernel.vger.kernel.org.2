Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C428A3448A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhCVPFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231546AbhCVPF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:05:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD02461983;
        Mon, 22 Mar 2021 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616425528;
        bh=c4yP7LH8IBW/QR/vQG5f43s6dXD+rwLuJrpHYufaYPg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fs29X7UnIjE+Bl8ZhIKrYh5yNaYulJZGHlE+nNA9MKMIARjndFhJZSrJOathwSV8R
         uugjpqF1mpuEJF/pZKPn/dQVsYEh1ewpWy7X3z/6fDBA6opAV4iC11ODWBZ1jQFf0r
         HAyho/s5aElYWAPrdEl6cG3qvDBIC0YvolWrvSom6nj/v+DYAyZCqkyNKcbjXYc/Q0
         nwk+k9SAPvQg1qezFKJJUXHqFVWcpyruK0W3yM+OrLYYDXbfHP9oVb2/PAskylPqbo
         vnmqZT64DQJHD40k1NfcR59h304u+irrl89Gk/ROKyANR7qmPxofwImf2iuD/96Tzo
         YRmHXbNZF4wug==
Received: by mail-ej1-f51.google.com with SMTP id u21so3872120ejo.13;
        Mon, 22 Mar 2021 08:05:27 -0700 (PDT)
X-Gm-Message-State: AOAM531B3/XAPkd5WuiAC/BAEmEXaRfq4jLUiOl+8JYRcD1100+22kul
        hdKL6W02BIpbul9JkaBwGnDbieQvXorZpAGPvg==
X-Google-Smtp-Source: ABdhPJyZsV8x+yYZywL3lcsQsXOxgCOh3eH/w6d7o0h5Iv9aWzDffRX6YSUicNu0SInCh4YA5/zW5+whL6f4MGzx6i4=
X-Received: by 2002:a17:907:7651:: with SMTP id kj17mr184000ejc.127.1616425526252;
 Mon, 22 Mar 2021 08:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com>
 <1609144630-14721-5-git-send-email-yongqiang.niu@mediatek.com> <CAAOTY_98vrwQrefD9KwvsM+9+tDpNcUwbLoVwu_mXRf17imuTA@mail.gmail.com>
In-Reply-To: <CAAOTY_98vrwQrefD9KwvsM+9+tDpNcUwbLoVwu_mXRf17imuTA@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 22 Mar 2021 23:05:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-yegJy-z4E_A0=3uxHHgre0jH2syQOY==PLe6yvx0vYA@mail.gmail.com>
Message-ID: <CAAOTY_-yegJy-z4E_A0=3uxHHgre0jH2syQOY==PLe6yvx0vYA@mail.gmail.com>
Subject: Re: [PATCH v3, 4/8] soc: mediatek: mmsys: add component OVL_2L2
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:23=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Yongqiang:
>
> Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=
=9C=8828=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:37=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >
> > This patch add component OVL_2L2
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

How do you think about this patch? One drm patch [1] depends on this patch.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2021020208123=
7.774442-2-hsinyi@chromium.org/

Regards,
Chun-Kuang.


>
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  include/linux/soc/mediatek/mtk-mmsys.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc=
/mediatek/mtk-mmsys.h
> > index 4b6c514..42476c2 100644
> > --- a/include/linux/soc/mediatek/mtk-mmsys.h
> > +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> > @@ -29,6 +29,7 @@ enum mtk_ddp_comp_id {
> >         DDP_COMPONENT_OVL0,
> >         DDP_COMPONENT_OVL_2L0,
> >         DDP_COMPONENT_OVL_2L1,
> > +       DDP_COMPONENT_OVL_2L2,
> >         DDP_COMPONENT_OVL1,
> >         DDP_COMPONENT_PWM0,
> >         DDP_COMPONENT_PWM1,
> > --
> > 1.8.1.1.dirty
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
