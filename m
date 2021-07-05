Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5B3BBD2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGEM5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 08:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhGEM5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 08:57:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33DD0613E0;
        Mon,  5 Jul 2021 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625489718;
        bh=DL/qfcwl7Mep35KybLuFTSiya/Gs+1I2TD7zA77f8q8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MnWkYcT2jqvq7PjDgs2KzxLL6OQfPVobZRxWv1r3FgKMdG93QhxM4UQC9niDaUduc
         zZST0SESd6LjNo7Cigo4Txqmwrcg1XDOfAsh/OFIWTfF4/6HwFs4XycSgDLLurqMPm
         Dewv4LzkogHsJdo5gQyddmXn68J0CGkAXOSWXt91ylcXdZjkQbwjXizpehYz2V3G4F
         wFNtOdKd9T47eeI9+4/tuLBp5iV/qd+S7mnEDtuXrtrAuGRxl9MpPzlLyLFBXt447G
         GASPDQ5sVteJG886R2PiAVXYv8+pYk/kFaMiJJrbVY7Jcpa9rnosG39q0TP/XzOTl6
         Arz+9US8SfwTQ==
Received: by mail-ej1-f54.google.com with SMTP id bg14so28905247ejb.9;
        Mon, 05 Jul 2021 05:55:18 -0700 (PDT)
X-Gm-Message-State: AOAM530kdGPgD8xUKjSQjwIHzA62yvGffzgmgfDdOM4T9ldD1Df+oDLx
        eYlEKCc6zQsvHHXoFnv2gVWZZxz0CBn3GySb2w==
X-Google-Smtp-Source: ABdhPJz9geTByoPzNQSQooTOiO202kzh3UBmiiWSZZQvrpQFu4TaOlsLcSVYB+yGdIfA6X9oPf8eOjKGIf6mgQo89KE=
X-Received: by 2002:a17:907:728e:: with SMTP id dt14mr13157240ejc.75.1625489716804;
 Mon, 05 Jul 2021 05:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210705033824.1934-1-chun-jie.chen@mediatek.com> <20210705033824.1934-3-chun-jie.chen@mediatek.com>
In-Reply-To: <20210705033824.1934-3-chun-jie.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 5 Jul 2021 20:55:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-wLsBwWaaBX0tzt2e5z+3vLO2yMmX2VrCCtO5cs=_PqQ@mail.gmail.com>
Message-ID: <CAAOTY_-wLsBwWaaBX0tzt2e5z+3vLO2yMmX2VrCCtO5cs=_PqQ@mail.gmail.com>
Subject: Re: [v12 02/20] dt-bindings: ARM: Mediatek: Add mmsys document
 binding for MT8192
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Jie Chen <chun-jie.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=885=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch adds the mmsys document binding for MT8192 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsy=
s.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> index 78c50733985c..9712a6831fab 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> @@ -16,6 +16,7 @@ Required Properties:
>         - "mediatek,mt8167-mmsys", "syscon"
>         - "mediatek,mt8173-mmsys", "syscon"
>         - "mediatek,mt8183-mmsys", "syscon"
> +       - "mediatek,mt8192-mmsys", "syscon"
>  - #clock-cells: Must be 1
>
>  For the clock control, the mmsys controller uses the common clk binding =
from
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
