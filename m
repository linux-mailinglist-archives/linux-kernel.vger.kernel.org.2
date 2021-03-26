Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3415D34A4B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCZJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCZJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:40:28 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F2C0613AA;
        Fri, 26 Mar 2021 02:40:14 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m13so5084135oiw.13;
        Fri, 26 Mar 2021 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IfjukbAFWE1p+V33R5APqijfZfzXo6Lv0BemEcQj2cM=;
        b=cWVDouGokuJ/Zr+T9ljGEEvKkNiIGZQSlhxG5QXXbQFytg2GgjaZXxKJDKmulPug6x
         6OzhseclyQc20g9S08LXbPKFg9Y84/WypYuW3QQ7keWhcqIMa6XbaqmqtbvWL1eyHxSk
         MQH4oDdb11FFrq/YcVHVgAM9aCsFCIVc2cpbZS0YvLBsZMuwpg8R2/2juHatsRKbVLGj
         gKa2X6oMJ2yMq+nO5uApHUNRbnMdj25bGC+JjjH1LYr1ukVdb5mAltgnaDiBphGssuKi
         fBLLh/eRh7HluGEpq4QH3oQxOh6F2cCIAEZ4Wj3DKNqz+E02c9yDQOPnmU9YgM6lFq2R
         d5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IfjukbAFWE1p+V33R5APqijfZfzXo6Lv0BemEcQj2cM=;
        b=mS8YaEaByKnn5v39/ywCNuj1FivoPbSWDVM/XVary1zcFxhNOoL8MkxADvrzuCHtzM
         hupqnFNoZTZlGbrwyIVEH4W5GdN7B79o22GAg1DOC6q79TtXmCjmJ8BhG/A4Ssv31AF9
         4aOEWdXZUIAXv/i7sJ6YNGN1gNyihUxSY5WbL9qCux30f1HQHn5mUUEw02/gMBqniolG
         PdOpVRsHQfHU2we/nJ0ni3/uoGQ3sC8axeHG3zArv6oNRaGInt4Llwv9t0dHAGP4Tq+E
         Z3sJH4oSKSJ0MXYPO4iCEJLFc/MqKo7aoIA8XgZOhc5MM+RB1QcQnldlsYcfSs31veSd
         1VIg==
X-Gm-Message-State: AOAM530ATzaYg81vIPIXCxhpi8q4ei16vgaWycpsG4BcNFTzCaByntFY
        d3vILNhEx3JesxnvDlOQAnpw0cVZ9/223Q1ikIM=
X-Google-Smtp-Source: ABdhPJzLkCAiEv8O3PoSMO3z2TH6i5wP/HkVGgZ7n3cKdrzj2qhvnOOLbEazs9E/qPiiK3X9eW41ernr9TzL3NsVaTk=
X-Received: by 2002:aca:d514:: with SMTP id m20mr9143934oig.47.1616751613911;
 Fri, 26 Mar 2021 02:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091547.12375-1-zhangqing@rock-chips.com> <20210326091547.12375-2-zhangqing@rock-chips.com>
In-Reply-To: <20210326091547.12375-2-zhangqing@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 26 Mar 2021 10:40:01 +0100
Message-ID: <CAFqH_51gSiBMMKovNmLi5msz9HKaJU0JSvFidg5Q6c0eN_rgEg@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] arm: dts: rockchip: Fix power-controller node
 names for rk3066a
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cl@rock-chips.com,
        huangtao@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i

Missatge de Elaine Zhang <zhangqing@rock-chips.com> del dia dv., 26 de
mar=C3=A7 2021 a les 10:17:
>
> Use more generic names (as recommended in the device tree specification
> or the binding documentation)
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm/boot/dts/rk3066a.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.d=
tsi
> index 252750c97f97..bbc3bff50856 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -755,7 +755,7 @@
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
> -               pd_vio@RK3066_PD_VIO {
> +               power-domain@RK3066_PD_VIO {
>                         reg =3D <RK3066_PD_VIO>;
>                         clocks =3D <&cru ACLK_LCDC0>,
>                                  <&cru ACLK_LCDC1>,
> @@ -782,7 +782,7 @@
>                                  <&qos_rga>;
>                 };
>
> -               pd_video@RK3066_PD_VIDEO {
> +               power-domain@RK3066_PD_VIDEO {
>                         reg =3D <RK3066_PD_VIDEO>;
>                         clocks =3D <&cru ACLK_VDPU>,
>                                  <&cru ACLK_VEPU>,
> @@ -791,7 +791,7 @@
>                         pm_qos =3D <&qos_vpu>;
>                 };
>
> -               pd_gpu@RK3066_PD_GPU {
> +               power-domain@RK3066_PD_GPU {
>                         reg =3D <RK3066_PD_GPU>;
>                         clocks =3D <&cru ACLK_GPU>;
>                         pm_qos =3D <&qos_gpu>;
> --
> 2.17.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
