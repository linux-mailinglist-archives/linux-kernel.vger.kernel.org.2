Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251AF3DEADB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbhHCK1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhHCK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:27:36 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F8C061764;
        Tue,  3 Aug 2021 03:27:25 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so5076285ooa.11;
        Tue, 03 Aug 2021 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K1otTc+SEm5XXn7ceZVlyDBrzkcVv960dGJCGU4PkuU=;
        b=okizGTvBMP1jUMm/UckZAsZv749/pUYN8j84rYLfc+imXHHyzxj1fWp2o9Cie1FMug
         BlX44fS3YypsEUsA7uT/nY+siAUhUOX1IdhSjAdkTaiOGWqMZJjMAiu5nEisFa+gSHFq
         C0QX4CTopL6oo/h2xYcbVG3niMG2k1+pf9U59TaUAcJStgt3lZrHVIAUluwFkL/Nmvsl
         wRDNzOqADCjrTskVjwaPBojGB6CYTZDO/0dO4nM1zzvYt0tZKeH1Z+lH16o/sk3O83vp
         PguHkbRGwY3jg9OElRFPM68KuFAPZVKSnIksJhpIItmjKdNktEsaxwVax5p0aFcLABxG
         Triw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K1otTc+SEm5XXn7ceZVlyDBrzkcVv960dGJCGU4PkuU=;
        b=uDwdBEgb9xHzRmwzd/YF90DGMo6jmQKKU31SRg4wAvf0ToLQZCu4FUH2BAMdSC1J0G
         xn5ZNlARcTgy5uFaIJDRSmtKg7vFAHQ61FWhtAqow+rSEiDL9xqJ0jYLoE8SZTHuW3Si
         867pVBiysyu5K3Hysxqh+qB/Nd7k1HCvqy+O7qq6AG6etEwqDfw+PjpF1gvtf3RVXkI9
         ImT/OsbOruWiiF+r7891lnx4Jce7iZzAHs+au6dx+prRvmjpdknuwgezosKI7SGtp5jB
         aVrDEsjXboocKFMu0xPZTs85kmu5pvy9PAYFWrUwjS0bFJ+bvL4+LcNFOchVv6lLNS6x
         eJpg==
X-Gm-Message-State: AOAM532zMIDZ0cr+TbRkhGqLZYsVJUzj277hat/krChQZS8SoDFLF134
        GzBo47wyHF8Ejj5CPNxw0Sb6IA7iXcBicW2tpfE=
X-Google-Smtp-Source: ABdhPJyXx5CAuAUv/zjrCNEjoEph5Pt0bQf8TxH9Bjn9+0lI/P2uingwRi4nPXLqmIN1Mvn+m8UjiVOTu8GJOCR7Oyk=
X-Received: by 2002:a05:6820:444:: with SMTP id p4mr13746063oou.75.1627986444410;
 Tue, 03 Aug 2021 03:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210802121215.703023-1-eizan@chromium.org> <20210802220943.v6.8.Ib681f06d5189351b7fda0e3dcd6b15f3863a0071@changeid>
In-Reply-To: <20210802220943.v6.8.Ib681f06d5189351b7fda0e3dcd6b15f3863a0071@changeid>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 3 Aug 2021 12:27:11 +0200
Message-ID: <CAFqH_51E+93_TZ2jpdkfWxDLSaijPcj6RLs+BHkw0GpKObT75w@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] dts: mtk-mdp: remove mediatek,vpu property from
 primary MDP device
To:     Eizan Miyamoto <eizan@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eizan,

Thank you for your patch

Missatge de Eizan Miyamoto <eizan@chromium.org> del dia dl., 2 d=E2=80=99ag=
.
2021 a les 14:14:
>
> It is no longer used by the mediatek MDP driver.
>
> Signed-off-by: Eizan Miyamoto <eizan@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
>
> (no changes since v1)
>
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8173.dtsi
> index d502073b551f..872427748110 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -1010,7 +1010,6 @@ mdp_rdma0: rdma@14001000 {
>                         power-domains =3D <&spm MT8173_POWER_DOMAIN_MM>;
>                         iommus =3D <&iommu M4U_PORT_MDP_RDMA0>;
>                         mediatek,larb =3D <&larb0>;
> -                       mediatek,vpu =3D <&vpu>;
>                 };
>
>                 mdp_rdma1: rdma@14002000 {
> --
> 2.32.0.554.ge1b32706d8-goog
>
