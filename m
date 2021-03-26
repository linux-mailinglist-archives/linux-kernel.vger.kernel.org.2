Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E282B34A4F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZJw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCZJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:51:53 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9C1C0613AA;
        Fri, 26 Mar 2021 02:51:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i81so5158523oif.6;
        Fri, 26 Mar 2021 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1v5R9RAiHiTdWal/LBKTgEZMw8L9OAh1BF/rlyRDwNk=;
        b=gf3vVVSZPxZRFCtP8xFDLkSkw+TQNsYgWPyG5L11PKJfbDmirLVeUMWKoYW+EOWivl
         35QrzNwXuFB8S9bICN4iGb1HHsHXtkR6p8SYed0isehs20u6SNDDb1uslWnB9eWP40JB
         zxU5LJ/dHWdMRGp2hP66nzbSniYzXewINmLwEV4GDXGBx1b83zcgOZzeNk1F5KWfAihw
         5SgdVyxX8f/s3CievaUdOfVptZGSbR8K+03eZ2sRCJ7RFLmYrnsX5TUXFHoLp3IRr8BS
         Cr2Fp6AX2ml2hVWpgYfmIqFkfAopKhvQTCZZdhdeqkJ0VHCJu2eFyR5D5lYgOONgFpK9
         HIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1v5R9RAiHiTdWal/LBKTgEZMw8L9OAh1BF/rlyRDwNk=;
        b=WiRCUluCXpj71zUVvEo4IDzyZJK4rsOAI/ztPWt+2uYxZuMGVfhkbWJm9NXJxnU+c5
         VbOMsITqjRzznebLQlOU7KhddhCVisrLoGvO+NJt0IjRPpQV5BwWdblLqcYDtFCdXQXM
         qUgSLQ+yJWbu0lt3BGD7Z+gd0D8F0zWiReF/Q0p5BWF0++Ykk0FLRIvLlzrKopDSPmsk
         ASPnweiufrO0/k5R3DvocTpEM1YMzOzVkfEM+/nxDpO8E50dKK8zpbDUISGWizYZcl85
         yAlRMMKvZklPp9XDTGjUC6G0UwOK0k1GtgT1ulZpR1szQ6h0kJmnKdE1dmqDIhhsiOkQ
         yL2A==
X-Gm-Message-State: AOAM530Ae0cTYrKZ1D0JkNKp8XSiJ3KwmVXXez/E2nCdznjRereT+T87
        PR6DDp4SFwR3/CFn6yCFUeQqwK/JhG+XsVNnCaU=
X-Google-Smtp-Source: ABdhPJyCffQw2ioiNr6x/UYgQkAQ+gD/2y9i4rR619mcguc3az+DELJzrc4Wq7IX/V8krOaDRfQ0+pCK8PFiQP2stBw=
X-Received: by 2002:aca:d514:: with SMTP id m20mr9174851oig.47.1616752312675;
 Fri, 26 Mar 2021 02:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091547.12375-1-zhangqing@rock-chips.com> <20210326091815.12754-1-zhangqing@rock-chips.com>
In-Reply-To: <20210326091815.12754-1-zhangqing@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 26 Mar 2021 10:51:41 +0100
Message-ID: <CAFqH_512tPbC0mv=JGQ5T8KNZ1Y2xhDrJLpsCA1jcaqpJziA8w@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] dt-bindings: power: rockchip: Add bindings for
 RK3568 Soc
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
mar=C3=A7 2021 a les 10:19:
>
> Add the compatible string for RK3568 SoC.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  .../devicetree/bindings/power/rockchip,power-controller.yaml    | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-contr=
oller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-control=
ler.yaml
> index 9fec9e227432..a4d223255c3b 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> @@ -37,6 +37,7 @@ properties:
>        - rockchip,rk3366-power-controller
>        - rockchip,rk3368-power-controller
>        - rockchip,rk3399-power-controller
> +      - rockchip,rk3568-power-controller
>
>    "#power-domain-cells":
>      const: 1
> @@ -90,6 +91,7 @@ patternProperties:
>            "include/dt-bindings/power/rk3366-power.h"
>            "include/dt-bindings/power/rk3368-power.h"
>            "include/dt-bindings/power/rk3399-power.h"
> +          "include/dt-bindings/power/rk3568-power.h"
>
>        clocks:
>          description: |
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
