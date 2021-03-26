Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4134A4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCZJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCZJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:40:37 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FAC0613AA;
        Fri, 26 Mar 2021 02:40:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n8so5107815oie.10;
        Fri, 26 Mar 2021 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rPre9dNxcksDQbNCzjU2B0PCEu+q3AiLBITa17+tz4Y=;
        b=pq9zwZvm36HOnSVA5UTkcR8dw/bs4bKRkZQXUr9J3Nwx475aPkYg8zXodcrlMY0g2B
         DNC5w9BVYoQMY4JtH0dOYmPZJWJBvjmTaTAsj5awsK6YPMSeqwx1UKXiVeOy8OcZ1HZj
         McbibnnImDKJv3pa0rtBYv6cRYV1aCkZEOXyqJSImYd3h939joZFSBAWktDbIizH8umV
         YNLatx7U1QIZb93hqPXoScvQ/45rYGochrMdyIOw0X3erqMh0tNpPU/aEVSJ2g+fkd0t
         ZbmF0Ija9VLDxneW9mhfe1hzPEAjkIqNvZr9XkdT5CZQQdQJ1O/fperKDxtWr1shrQO4
         14QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rPre9dNxcksDQbNCzjU2B0PCEu+q3AiLBITa17+tz4Y=;
        b=YCyuaymfzG7nZS8Aw0xx/W8miSl69+fxW2gWAM3QHJsjMzCr9yTFl5TOVms8t6cxfN
         Xufbo2uu2y1B/zBkeVtIjf22dCvPvCCLBiLYZQ/+8Wa6qXnn4o/LuSn5DGG5jzFZLJxT
         bF94UuCihpXEGgj9HcP/TpVMsmbXKtocm2QOBCl+fB6/CZ5cZ5v7W/rntUxzOhU6WTeO
         1y1nzpUI2P0IbTNeETNrN/nwbGaxns+gBM9yDwqPfSE6mzbbJOkB6Io7t9xGR30KU2+1
         U6DmZK+GtUI1U0VzR5R0O1Ts0xcRWgbO4KtPaVDda4EVXchnAmDRwCQzh0g8pQN69A+5
         M8TQ==
X-Gm-Message-State: AOAM531JdFc2IPW3CU99ffFtmUi+1yIvWBS+H7/d1mJOdiBevfDegJav
        2MVN3dCuDCRfX3Xy/Lis2Z1MgdM9bPefToCOf+k=
X-Google-Smtp-Source: ABdhPJy6cRAf4W3cOAuuzfVhJo3a4+2uxif4hfPxqd+fhpuDg6D55ZbZ9I7VrcPd+trQZ1xaNNNL9mm5i8yzBgqD5O4=
X-Received: by 2002:a05:6808:14cf:: with SMTP id f15mr9146175oiw.39.1616751636428;
 Fri, 26 Mar 2021 02:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091547.12375-1-zhangqing@rock-chips.com> <20210326091547.12375-3-zhangqing@rock-chips.com>
In-Reply-To: <20210326091547.12375-3-zhangqing@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 26 Mar 2021 10:40:24 +0100
Message-ID: <CAFqH_53zjUTr8hOutPRmLL+=KsX-zENVCex-gweN-3dTpC-RiQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] arm: dts: rockchip: Fix power-controller node
 names for rk3188
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

Missatge de Elaine Zhang <zhangqing@rock-chips.com> del dia dv., 26 de
mar=C3=A7 2021 a les 10:17:
>
> Use more generic names (as recommended in the device tree specification
> or the binding documentation)
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm/boot/dts/rk3188.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dts=
i
> index 2298a8d840ba..5db32fdbe6e7 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -699,7 +699,7 @@
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
> -               pd_vio@RK3188_PD_VIO {
> +               power-domain@RK3188_PD_VIO {
>                         reg =3D <RK3188_PD_VIO>;
>                         clocks =3D <&cru ACLK_LCDC0>,
>                                  <&cru ACLK_LCDC1>,
> @@ -721,7 +721,7 @@
>                                  <&qos_rga>;
>                 };
>
> -               pd_video@RK3188_PD_VIDEO {
> +               power-domain@RK3188_PD_VIDEO {
>                         reg =3D <RK3188_PD_VIDEO>;
>                         clocks =3D <&cru ACLK_VDPU>,
>                                  <&cru ACLK_VEPU>,
> @@ -730,7 +730,7 @@
>                         pm_qos =3D <&qos_vpu>;
>                 };
>
> -               pd_gpu@RK3188_PD_GPU {
> +               power-domain@RK3188_PD_GPU {
>                         reg =3D <RK3188_PD_GPU>;
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
