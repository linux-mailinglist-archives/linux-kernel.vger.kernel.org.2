Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01D232C4C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbhCDARM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388904AbhCDAMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C8FC0613D8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 16:07:26 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d13-20020a17090abf8db02900c0590648b1so3631612pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=asxjJNgiUNw6MBg0pakth/o8lvjiDAUFUUQ/6Pge5+4=;
        b=PanXJgzyeHwpKblWdhocuodYjQLVlYm2M3uMk2kp4ryZrfrAwH4WsPXGUAJpUo4Tyy
         Dp03+piJ4ksc7zysNHDbgSvTt8mc5nucEYtSdSRvIvx/AgnGhVAd05Sr7JYDss1+ET8i
         LteG+cwShMGQslPkg92g+HCoOjw9epjuUlkmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=asxjJNgiUNw6MBg0pakth/o8lvjiDAUFUUQ/6Pge5+4=;
        b=MLf1pGSyk3TFvfSlG942qrAefDANDVcTvZl8qFvCJuFQLR+kuys2Ze70ZD8WEq2ffA
         H6BLR705RCBRLporpYgOI428BT48FXj9f/UGuqfNt5gD7zRQyi7eKHpSVbE2BqOuNkWY
         t8bxurdqbORt2AQac4T3C+M2wc9y5eb9bETJzQmzBdKYBeYQ7ckPMAuB48oaZ8Kau/1D
         DNKznFyLUV+QAU++yUREN6CsYK1HtoyZfow8xL0bSDhDLqzjNe4Cq2ACMoraNnr8XTzb
         F2yJfR+rhgIJU/DMxkDOG9O7HGN2pr+MZfFhuBvrcQdQLW319lIdaKf+BbqjOqEBV09S
         KVhg==
X-Gm-Message-State: AOAM533Ns+UU//m+TNuepZMSg6EPrLe0NHIDl1CphjOVwx7F1qzkX6UT
        fECrOighxK6MWhmL2sx7xOA2iw==
X-Google-Smtp-Source: ABdhPJyNosMbuHpBvBydLjVSSE8esDc/JfjeFRizDQLAXL2Ze61VIO+s7BDsLjCZ7drglIe+1gpCog==
X-Received: by 2002:a17:90b:116:: with SMTP id p22mr1507427pjz.161.1614816445612;
        Wed, 03 Mar 2021 16:07:25 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id s10sm25538883pgl.90.2021.03.03.16.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 16:07:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1614773878-8058-4-git-send-email-rnayak@codeaurora.org>
References: <1614773878-8058-1-git-send-email-rnayak@codeaurora.org> <1614773878-8058-4-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH v2 03/14] arm64: dts: sc7280: Add basic dts/dtsi files for sc7280 soc
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Wed, 03 Mar 2021 16:07:23 -0800
Message-ID: <161481644369.1478170.2626772524314654990@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-03-03 04:17:47)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/q=
com/sc7280.dtsi
> new file mode 100644
> index 0000000..4a56d9c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * sc7280 SoC device tree source
> + *
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-sc7280.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       interrupt-parent =3D <&intc>;
> +
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +
> +       chosen { };
> +
> +       clocks {
> +               xo_board: xo-board {
> +                       compatible =3D "fixed-clock";
> +                       clock-frequency =3D <76800000>;

If this is the correct frequency I think we need to update the rpmh clk
driver to use the correct divider? Right now I think it is a 2 when it
should be 4?

> +                       #clock-cells =3D <0>;
> +               };
> +
> +               sleep_clk: sleep-clk {
> +                       compatible =3D "fixed-clock";
> +                       clock-frequency =3D <32000>;
> +                       #clock-cells =3D <0>;
> +               };
> +       };
