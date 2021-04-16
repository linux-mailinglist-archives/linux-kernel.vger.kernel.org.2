Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D919361998
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbhDPF54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbhDPF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:57:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348FFC061574;
        Thu, 15 Apr 2021 22:57:30 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so24780637otb.7;
        Thu, 15 Apr 2021 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VOrqlTV3huhMCZAEQIUjiZ90jLDEUdTRF16U+SVEFXQ=;
        b=jexlo7/S3quht6cy3pccZK2RvurXcNQ44ooeJISi79+SnQlWssMxWESqTHHWbc6sQo
         PswkbUSDKQkiFGRYtpYXEoOfyQH2tx+7PuxGpp58hJaeCYEJVdRWNT1ZMzA/ZnOkmDpU
         yXE6WR64gFQHEqUZLjP878bo1QEhaPBbkQDOGCka7TbnoYoHysBSUcyrKEll5go206cD
         tMfN0Ce2EwueHeoQipNL9A2y5UWiorgU9ISqrx6pMflLSMNXAqArtVM16qiMxAjgHOdL
         +yUCBUkRw2UM7FC9HJ4t4eVcJ0p/qDuWr0WxVOEO4eO5SGPAruEeAKk925xMETooeIJt
         VRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VOrqlTV3huhMCZAEQIUjiZ90jLDEUdTRF16U+SVEFXQ=;
        b=iZg8Zr458NQUeNJcsUqBuimXJTZEH0Ts4pymLpRQJwaBsME6OfaOpdP3ypHz8Jo2sX
         BQ6cnEPmF1j9i2s0g9Y8AOEwVqs6mLyn9CfizLzgF1pW3M7HLad50qfvEbAZW1sL9pMq
         QV4pKhb/fI/00cWyyVYGeHIstPaL1wVB70Gr0TCpSn2QToosZVqTBvjPHoqvPvGVtnPx
         XHjj/fWd09yPcpuFmAs6Pq9wmuMshm/uLRq+gaEZ8Evnvk5QHaWcyYsNnwhO453T+hkz
         xlot1xq50/EQkKWoCCVDleA6tUBaryM/RPfp1sFk13wrsNusS1Z5+fMT0gFdVWxZ3Pt0
         yRBQ==
X-Gm-Message-State: AOAM530uxaOpXotuGHeq46zcHrUAVXj3+3dO5EUuI+0d10QiqR+lcVwJ
        osuxxkWRTSPD6YLB5He79zBsXb57Fw8QFwSPYDQ=
X-Google-Smtp-Source: ABdhPJybkHaFhC1kho6OSz3Hq35NUakGJLmB47r7+Qw4hTh5gx6Nq2tu2N4OETGP9bH+nc/s5N9we1lRNaE/fEZI1CU=
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr2489846otq.281.1618552649627;
 Thu, 15 Apr 2021 22:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org> <20210415093519.1920877-3-hsinyi@chromium.org>
In-Reply-To: <20210415093519.1920877-3-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 07:57:21 +0200
Message-ID: <CAFqH_50725CK30jWksqDxvKFUuGdsS4MOtFK58Kqhi7-vcGg9A@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-burnet
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 15 d=E2=80=99ab=
r.
2021 a les 11:36:
>
> Burnet is known as HP Chromebook x360 11MK G3 EE.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 96c401597bd8..0870490aa350 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -122,6 +122,10 @@ properties:
>            - enum:
>                - mediatek,mt8195-evb
>            - const: mediatek,mt8195
> +      - description: Google Burnet (HP Chromebook x360 11MK G3 EE)
> +        items:
> +          - const: google,burnet
> +          - const: mediatek,mt8183
>        - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
>          items:
>            - enum:
> --
> 2.31.1.295.g9ea45b61b8-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
