Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7075F34A4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhCZJmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhCZJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:41:50 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D5BC0613AA;
        Fri, 26 Mar 2021 02:41:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso4715734otp.0;
        Fri, 26 Mar 2021 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Aqjc4e4P+BYL3ptPbOMRtOfrYGx7wKOgBenNti1wSGk=;
        b=HRYgMfgZrN2RHxZvf3CIN/Auu/ev7Vlxga78g+PvATDM3d3gfec2gnyuyS1L8FzFfk
         7JrEZDpiaFc1ENVCYPTfObyOeBlhawYOd2S/NEwekSZJKp+IvC3CsOw/IEYeyRHeOoUT
         O0ax5A3pw/07lzm/aegmiaa2Ojl5jm7b8QimRnGSh/gnnLOfCxN8wJlPkFGqBEJKoQAG
         x2TpyyAVRuI0j46ygm0/6kskpPkpVDiySl84Q7+yy25Gbczk/zL7w9SFQkMGFjXc631J
         wcHskpkOqSU/VIrV5XweOG8h4fmqPckIInLNT8x05dZxc1O2xv67VWKpeACM4+73GEWt
         7dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Aqjc4e4P+BYL3ptPbOMRtOfrYGx7wKOgBenNti1wSGk=;
        b=AljuRjWt6eWvFNBA2hW1VzuWkavoYeLiwFnfdbk7hUuY98eNaMeEy1IHbt6rKJiSBp
         yzBh5M6222iwQklGL23jUQDD29lJxKNHgZ6IER5FSp+C59dRqH3s7U15BDIX5mopnt1a
         V9v6QvahW2R5GLR4QU+N3WGJm5HBBN1lwWagBEQ07Ql2I0+ZzNLXlxKW5pEwwOBBo9p4
         r+R5Ose94eJ+2YfG1oxJB2WIycu2wDypwUBEZV5j52rPTmn8BMKv14zZYX9cr/+9G86E
         sCsIZrqMGG1xodDLfJSpfoLEn8bHrdPXII3CnCGkrNHwsEpyIR5IMQkconTtfnd7xLvw
         o0RQ==
X-Gm-Message-State: AOAM530HI+zVrVhJxVOSIvea80kSH+Wb1vfvGHF6DAl94c/5Y44cjPu9
        Q/4us5/g8X7buka6Ts3dOPkIPcIJv0vbV8ywTIs=
X-Google-Smtp-Source: ABdhPJw+hcU2eD3grVXPcFvEeWAOWTPAIj3y/l9tcWkeR4X29gZwIsJ16uGYOC8Akvhep9knlWfKLmxCAgq9pJe+46A=
X-Received: by 2002:a05:6830:10d3:: with SMTP id z19mr11157103oto.362.1616751709324;
 Fri, 26 Mar 2021 02:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091547.12375-1-zhangqing@rock-chips.com> <20210326091712.12478-1-zhangqing@rock-chips.com>
In-Reply-To: <20210326091712.12478-1-zhangqing@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 26 Mar 2021 10:41:37 +0100
Message-ID: <CAFqH_51868Omo6bC5MCgbsTjAXqhYTbgn86MwZjN3_gX6SfhgA@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] arm64: dts: rockchip: Fix power-controller node
 names for rk3328
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
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3328.dtsi
> index 063ed0adbec4..084acfd597af 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -303,13 +303,13 @@
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>
> -                       pd_hevc@RK3328_PD_HEVC {
> +                       power-domain@RK3328_PD_HEVC {
>                                 reg =3D <RK3328_PD_HEVC>;
>                         };
> -                       pd_video@RK3328_PD_VIDEO {
> +                       power-domain@RK3328_PD_VIDEO {
>                                 reg =3D <RK3328_PD_VIDEO>;
>                         };
> -                       pd_vpu@RK3328_PD_VPU {
> +                       power-domain@RK3328_PD_VPU {
>                                 reg =3D <RK3328_PD_VPU>;
>                                 clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VP=
U>;
>                         };
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
