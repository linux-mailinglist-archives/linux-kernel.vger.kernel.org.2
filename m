Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57C32FE3F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 01:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCGAnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 19:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhCGAm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 19:42:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C56B650B1;
        Sun,  7 Mar 2021 00:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615077776;
        bh=KZD3vOv3vH2mC1Q0ZplTlNxWU5cUbcMTjSyFa0US+0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MzO4xfRz/R75vm/uSgcq+ZU75rGZekKhPNHoAZ2UHiBjgiKU4O+Nn/bxwktFoLVFu
         iTN9mENxTxEN7a6blOtoqs1OdTro3umc94005wwWt4g1o89NEZBO7xc2VAhCYb/4pd
         ivy2UieMfb+QewR7D2UrUSjbHSMQXRIi0JYXpuzvzC5gTfeVbtby+k3pvu+Tj3tyit
         WmUV4GJDijKzl9/3KkI7CzfoC7xSXgCUVWEKqP4WBWve/n44tfyDMohOMQfwpza0ai
         QPubm5uVRC9tVQz6+nLXNYN8jYQVrfN+gOVZ88lT8wkAXWYjlMzb4t7zny5MvGYj+G
         0pbjIisuLwCiw==
Received: by mail-ed1-f54.google.com with SMTP id v13so9031636edw.9;
        Sat, 06 Mar 2021 16:42:55 -0800 (PST)
X-Gm-Message-State: AOAM5332tyIryXKrLaPYAVJzrJChb1FTn8LGDRQcI4uhfNjLUWuheeH/
        TTe284CqG9hTs6+h4ixWIrzTQ2p5SBPz6CXHbA==
X-Google-Smtp-Source: ABdhPJx7jtQ0W73hZycPPbjKIcZbMY0MyE9EPc5BZE00JeOhpRPAnSbt16/1gZRtb+fIlfnNDBOeoa0ac6GIa4Mpr3E=
X-Received: by 2002:a50:ec07:: with SMTP id g7mr15611220edr.72.1615077774729;
 Sat, 06 Mar 2021 16:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20210208014221.196584-1-jitao.shi@mediatek.com>
 <20210208014221.196584-4-jitao.shi@mediatek.com> <20210210201856.GA2690160@robh.at.kernel.org>
In-Reply-To: <20210210201856.GA2690160@robh.at.kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 7 Mar 2021 08:42:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9gQe1SvzyzeNSA+i5tQNGjuW-57vpuA=GusmtWX0+_1g@mail.gmail.com>
Message-ID: <CAAOTY_9gQe1SvzyzeNSA+i5tQNGjuW-57vpuA=GusmtWX0+_1g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mediatek,dpi: add mt8192 to mediatek,dpi
To:     Rob Herring <robh@kernel.org>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        DTML <devicetree@vger.kernel.org>, yingjoe.chen@mediatek.com,
        stonea168@163.com, huijuan.xie@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        shuijing.li@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=8811=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 08 Feb 2021 09:42:21 +0800, Jitao Shi wrote:
> > Add compatible "mediatek,mt8192-dpi" for the mt8192 dpi.
> >
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>


Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.
