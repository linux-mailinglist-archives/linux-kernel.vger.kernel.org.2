Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70F53F23A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 01:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhHSX0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 19:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhHSX0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 19:26:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 099CF610CB;
        Thu, 19 Aug 2021 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629415537;
        bh=lDfLcMkKaHulnTMCEIwuK3Wkmz0K0OakW2zzDWc2MXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FY0wZTfrZOjvTnYhmIPdjOI29K571ATtN2aYf4k/tGQKyIwJwp+Ygjb0ZymaDAJF0
         4KfTUAUg6RRvQbQI6nhYkj88XF8OGaGzYo7hTA+l+tO6n7FOiSOYrBvRJ4gPstlQc+
         /A7as4FtfgWNv1csr6zGnv6paUBj4MEi+8Kfo+kErXzeCnPWNfKba2Be16HBcBOQyb
         nG3NFuy+HTKrRvHKm006BGLR41CPqAukZsRLH5i5NbQ6M3mX9z7l2TnmwTrhcJyQLi
         q8Dw9mgcwuCaI7Kwo5LUt3bIpNZ7CUeVKZljDag08xUJo8XToCrOApmbdEeBoFdjkz
         b1MKB8+gfkviA==
Received: by mail-ed1-f48.google.com with SMTP id r19so11185234eds.13;
        Thu, 19 Aug 2021 16:25:36 -0700 (PDT)
X-Gm-Message-State: AOAM530MAQvsaRTSIhzYreR20WxyaZbfnO1MeeR5oX18qbTpTDSUKad6
        2VhpbggfRfswhX0R3g7dnTEtciydTPt86XUe5A==
X-Google-Smtp-Source: ABdhPJyqRKlKwq4wRR1ZLhH+D2awtd0tuQOpfkaT7U6/ZK+Er3r1zuqlZaXZ1G3+33lsQ6QF7lMQ2EOc1u8R/uHA4WA=
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr18981861eds.166.1629415535694;
 Thu, 19 Aug 2021 16:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210818091847.8060-1-nancy.lin@mediatek.com> <20210818091847.8060-3-nancy.lin@mediatek.com>
In-Reply-To: <20210818091847.8060-3-nancy.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 20 Aug 2021 07:25:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-mJ0WHK0pXqASprrc7GW0R_ZTRmJ8Yo8pu9js-cQ5HAw@mail.gmail.com>
Message-ID: <CAAOTY_-mJ0WHK0pXqASprrc7GW0R_ZTRmJ8Yo8pu9js-cQ5HAw@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] dt-bindings: mediatek: add vdosys1 MERGE
 definition for mt8195
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        singo.chang@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nancy:

Nancy.Lin <nancy.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add vdosys1 MERGE definition.
>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,merge.yaml    | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,me=
rge.yaml
> index 1a27b037086b..ba1e0c837988 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> @@ -23,6 +23,8 @@ properties:
>            - const: mediatek,mt8173-disp-merge
>        - items:
>            - const: mediatek,mt8195-disp-merge
> +      - items:
> +          - const: mediatek,mt8195-vdo1-merge

I don't know why create a new merge for mt8195. Provide more
information about the difference of these two merge.

Regards,
Chun-Kuang.

>
>    reg:
>      maxItems: 1
> --
> 2.18.0
>
