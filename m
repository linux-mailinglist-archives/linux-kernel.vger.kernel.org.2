Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7025934A4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZJxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhCZJxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:53:01 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B631C0613AA;
        Fri, 26 Mar 2021 02:53:01 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id c16so5176460oib.3;
        Fri, 26 Mar 2021 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OQNUcud1zkYdzkIjaa5FtppgaPtwU3jTgTAIM5VSySU=;
        b=pm3MyKP3SbvYm32JdhQ6HJDzD10Clg4f0qoDUA8sBQ1aQX4BQz7YmfLKQdIYARfKXg
         JmftkdKPLaa8VxOv/0j2sE43VvZP0fgnwa5mhPJ3TisRdQf9XTPkZjb0ENtVppXIGlD0
         qgup1Ov1sAGaEwUUuaBYpsf3b3q30s17ZcpPV2nGmQGgu50GhRs8GT4D+yPHQ0SxTSNZ
         cXJvyoXfnNaNZ/yfgXjB9qQtBUxH0eam2kV0+wb8yOXF0sPGB4M4pHP9A2AI3TLZuCVP
         /1GJd2s+sgGdU+A/cDab/7UKtU+8OUTDm2mXy9OjQbPNcV7rbt0/5crs76FH7qVaPuH9
         Asfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OQNUcud1zkYdzkIjaa5FtppgaPtwU3jTgTAIM5VSySU=;
        b=HA/rd5TQT3eerN1o3EqdHLnCnzFa+BvTIFx0At/5x0Bny1bsbApJx+ET0xgxTi1Pk3
         TSH5pK8mxMTNVuQP44kFgVpwehq9/eI7uI1L4ZI9wkqNNNJxlxOi5pK7JJ/IBuCe21IC
         WWihsDYOa1VafjQLpLd9M+Syji53ri0YYPOnWyylB2uuYng1J7jRvWBS1J+e6z/d6JJi
         toT7LSJ5Cd6aaWRTCzGc4/Zn4WmJDQlIKmHQtql0McvXQq0QcC6KPRe67rtgvAmCBNIb
         LUTV17wdttUwH9MfSnPK4wgp3jrXgO+LMPZVdCQo3M+7gRpPchvaqD9OmqfuQ4K/Yqaa
         QO2w==
X-Gm-Message-State: AOAM531ByMIkXSks+XXf/eoowrg2TXJkOL6SWEvlb1i1LS1kiCwJgN3f
        aIlUOTjnk7l4mdW9OFmCL6uQNowvctMlYlFIHKVWDdEMGMe4JA==
X-Google-Smtp-Source: ABdhPJzdEVG0jo5Gcp8tmM5tdCotj+i2e2qmLokrLAy/Utb7KG07+qLNMUoYlzSNG3+kzUP5N4EGFupD+rN9R5RQ7CU=
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr9251981oik.129.1616752380497;
 Fri, 26 Mar 2021 02:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091547.12375-1-zhangqing@rock-chips.com> <20210326091751.12637-1-zhangqing@rock-chips.com>
In-Reply-To: <20210326091751.12637-1-zhangqing@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 26 Mar 2021 10:52:48 +0100
Message-ID: <CAFqH_53qnWdRQ01kRxVAKRWZnimW+gyNO=pv+ET4xFQB5QGOtA@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] dt-bindings: add power-domain header for RK3568 SoCs
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
mar=C3=A7 2021 a les 10:18:
>
> According to a description from TRM, add all the power domains
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  include/dt-bindings/power/rk3568-power.h | 32 ++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3568-power.h
>
> diff --git a/include/dt-bindings/power/rk3568-power.h b/include/dt-bindin=
gs/power/rk3568-power.h
> new file mode 100644
> index 000000000000..6cc1af1a9d26
> --- /dev/null
> +++ b/include/dt-bindings/power/rk3568-power.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DT_BINDINGS_POWER_RK3568_POWER_H__
> +#define __DT_BINDINGS_POWER_RK3568_POWER_H__
> +
> +/* VD_CORE */
> +#define RK3568_PD_CPU_0                0
> +#define RK3568_PD_CPU_1                1
> +#define RK3568_PD_CPU_2                2
> +#define RK3568_PD_CPU_3                3
> +#define RK3568_PD_CORE_ALIVE   4
> +
> +/* VD_PMU */
> +#define RK3568_PD_PMU          5
> +
> +/* VD_NPU */
> +#define RK3568_PD_NPU          6
> +
> +/* VD_GPU */
> +#define RK3568_PD_GPU          7
> +
> +/* VD_LOGIC */
> +#define RK3568_PD_VI           8
> +#define RK3568_PD_VO           9
> +#define RK3568_PD_RGA          10
> +#define RK3568_PD_VPU          11
> +#define RK3568_PD_CENTER       12
> +#define RK3568_PD_RKVDEC       13
> +#define RK3568_PD_RKVENC       14
> +#define RK3568_PD_PIPE         15
> +#define RK3568_PD_LOGIC_ALIVE  16
> +
> +#endif
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
