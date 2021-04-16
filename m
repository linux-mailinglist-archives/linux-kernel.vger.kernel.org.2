Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB29361985
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbhDPFxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbhDPFxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:53:00 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F34C061574;
        Thu, 15 Apr 2021 22:52:36 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t17-20020a9d77510000b0290287a5143b41so13544005otl.11;
        Thu, 15 Apr 2021 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sz5AkDEHXoTdhaWqNa4aiq2JXP5rqPnHAGXR8ZCTKAg=;
        b=hhN8uGqIBz9cbQV+JtKoeYJC9DF8KbPYfeHcv2sRSlO7JlsQh7YxfMBbjgZ7ulVU4n
         na6SYs8pHd2P8eOTE5PXPufwsGafk901JlRrzkz4JmUCYL4n0t3zlBU0knmbGTk9WR12
         8jwqVa1OV4JzgzU5Goyq3DGuWpOIv4R4hHJ68tMh/4TyG1sfNVU/ekXA23B6CDU0RQXV
         lSM7UetSayuuegUyc4iSYy8L5uU79VHyYL9C2hJJLwbmPEOP6pNVa/BqNy2NnUAEaQe8
         kYzH0kYJd01auSpFTa7CK408VdX2rdUYSyopNFU6VwFkbH6bSaFmnH7B0lSj+gMhlVX2
         XRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sz5AkDEHXoTdhaWqNa4aiq2JXP5rqPnHAGXR8ZCTKAg=;
        b=HGDGk1CtAXjAFuOt7rerowqtp08uxqJE4aIQE/YcMwPS9KZEJ56pBJw6gjKbA763aZ
         6OToRtyqeHvqjCLJ8XqOi+kf7DhJh5dQpumzpK67x+cmwSUMjIGGe+26ya3ltKBi/Df9
         AAtqXla+lfKrrhQ8+daaGUZ/xkYC3Xx2QERMbVgxxckfAzCzBf7+uf/hNjqZFN/k5TYx
         Xvve9sfgcV8UotfIuFWScb5mPEOLVIHGgOsnf1AFBT/9Me51a1pWp+hLTxgzW8rMeSaU
         dg8Dgt2hRFHXjQfMLlDOIkqCZ5Ql8McBqJU7n6wig5kujHuu8t160JCF6lZH92fPu+Lw
         vYNg==
X-Gm-Message-State: AOAM532Vf6J9btIrL3Zpmj/zsvL3UcCZvgTychXQR7HH288i6330zg8q
        Nz25XyuVv1VPhUespY19KOZ+XgcLizLe5T62e08=
X-Google-Smtp-Source: ABdhPJzai2AZUpqMlxmUdFMD8/LL884tQ/+a9LNwb5D3Cdt4KsiydVj2riIrDLj6ZLQCSuXQ/lT10T3IqFFyC1PY+/Q=
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr2479119otq.281.1618552355449;
 Thu, 15 Apr 2021 22:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210414144643.17435-1-matthias.bgg@kernel.org>
In-Reply-To: <20210414144643.17435-1-matthias.bgg@kernel.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 07:52:26 +0200
Message-ID: <CAFqH_53TOM6oyByRaMb8d7caX+u5Wn5DyrXuXHYKVUwBCfrkZg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: mt8183-pumpkin: fix dtbs_check warning
To:     matthias.bgg@kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for your patch.

Missatge de l'adre=C3=A7a <matthias.bgg@kernel.org> del dia dc., 14 d=E2=80=
=99abr.
2021 a les 16:48:
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> Fix unit names to make dtbs_check happy.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64=
/boot/dts/mediatek/mt8183-pumpkin.dts
> index eb6e595c2975..0aff5eb52e88 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> @@ -32,7 +32,7 @@ reserved-memory {
>                 #size-cells =3D <2>;
>                 ranges;
>
> -               scp_mem_reserved: scp_mem_region {
> +               scp_mem_reserved: scp_mem_region@50000000 {
>                         compatible =3D "shared-dma-pool";
>                         reg =3D <0 0x50000000 0 0x2900000>;
>                         no-map;
> @@ -55,7 +55,7 @@ led-green {
>                 };
>         };
>
> -       ntc@0 {
> +       ntc {
>                 compatible =3D "murata,ncp03wf104";
>                 pullup-uv =3D <1800000>;
>                 pullup-ohm =3D <390000>;
> --
> 2.30.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
