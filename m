Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF33EB881
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbhHMPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbhHMPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:12:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E83AC061226;
        Fri, 13 Aug 2021 08:10:34 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z128so19370010ybc.10;
        Fri, 13 Aug 2021 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X/kqYBjQkwFbfFHGVlf4OaSWUJ8/nIBF0RPqMs8Yh0k=;
        b=HyF5AE/ys7V0sdEN1tRr+aZLXXVZ9OvxNg92VCFCvsf7jL69ukhZHyQDor+YujNGsL
         wCgqvc0BQ/hyJHB1vwC+KbWBU58nVDge0WlJ+pwykI5e8C6VkFxHOUZm2z63b8zPq0Ri
         G7BD6wC7hMTPaq1KnIViSqp0NYkvY0Ry1z4cBaXVRZOs+OXQ+xmAUJB/+1lomJRqe6jm
         d3hFNVwZaSy2i9fJGvl8BG+pR194DTT/8b8PITZcXFJyL28RjJICoPGTd+lvFK8NzPHB
         cHNREdhrCO7oJ3NnumTX3w7aabeYBO2+z3EtuLLxmkOx89LtlQM1jGyoSd1M7jBMPHZa
         wvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X/kqYBjQkwFbfFHGVlf4OaSWUJ8/nIBF0RPqMs8Yh0k=;
        b=hObRGxE8TlXYpPkbjEPlBJugqk6WPeJYTAiHJzlg5QPntQ36OR2JuUrZctlfpqIx2o
         xZj+0Oce6U77HTeXSCYTd6TXVowGaqC7zuV8RWGbjiF0qJmYwMnaJX7NxAHtG9oWC30Q
         OA3lxz0MqQExzp1yD4RMr4hQDVmtpUYtFtfqqapQI5fMVk37kjqhWkJFu7RwCpJn/9am
         93yZeXQtJ5KTZsiTJM0aPrzVzONLQDeGpyg+S32GZNpdywT8uQ5Z3GEPTi6KVpHnFe02
         khQX6kGqFuusihjLwo6ZPitUIdRg/+u2dRDPzPPMzB1v/Octg5JCA94U9hyAcF7V5aff
         AQ0A==
X-Gm-Message-State: AOAM5327O72SsyffY8fvObMnMUwkTFVG/+aFBVamOSXgSnPfplYINpM4
        JWrL51tctmn1IDC5H+IaYFQDW0Q8UQjZWEfFST0=
X-Google-Smtp-Source: ABdhPJxa0NvFb4qZ9t5F/jGaQ5OgVjYOv6GY0umZKAkxmzzehVdCoZC6LLB9QJJjiBv8G4Osj/i1r42R+7Ub3kQvS0Q=
X-Received: by 2002:a25:3108:: with SMTP id x8mr3557506ybx.386.1628867433281;
 Fri, 13 Aug 2021 08:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210730151727.729822-1-pgwipeout@gmail.com> <ad6d8025-977c-9ff2-81ff-a417df48231c@linaro.org>
 <893701da-ea17-00ab-5e31-c745051ac9b9@arm.com> <2b1050f2-0311-1871-820a-f876218894bc@linaro.org>
In-Reply-To: <2b1050f2-0311-1871-820a-f876218894bc@linaro.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 13 Aug 2021 11:10:20 -0400
Message-ID: <CAMdYzYptXpahbcdkPm1C9_aH2khNtjdZyBmckndcWLnrh259QQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: rockchip: add thermal fan control to rockpro64
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 10:54 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Robin,
>
>
> On 13/08/2021 15:51, Robin Murphy wrote:
> > On 2021-08-13 13:59, Daniel Lezcano wrote:
> >> On 30/07/2021 17:17, Peter Geis wrote:
> >>> The rockpro64 had a fan node since
> >>> commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64=
")
> >>> however it was never tied into the thermal driver for automatic contr=
ol.
> >>>
> >>> Add the links to the thermal node to permit the kernel to handle this
> >>> automatically.
> >>> Borrowed from the (rk3399-khadas-edge.dtsi).
> >>>
> >>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>
> [ ... ]
>
> >>>   +&cpu_thermal {
> >>> +    trips {
> >>> +        cpu_warm: cpu_warm {
> >>> +            temperature =3D <55000>;
> >>> +            hysteresis =3D <2000>;
> >>> +            type =3D "active";
> >>> +        };
> >>> +
> >>> +        cpu_hot: cpu_hot {
> >>> +            temperature =3D <65000>;
> >>> +            hysteresis =3D <2000>;
> >>> +            type =3D "active";
> >>> +        };
> >>> +    };
> >>> +
> >>
> >> Why two trip points ?
> >>
> >> Why not one functioning temperature and no lower / upper limits for th=
e
> >> cooling maps ?
> >
> > Certainly when I first did this for NanoPC-T4, IIRC it was to avoid the
> > fan ramping up too eagerly, since level 1 for my fan is effectively
> > silent but still cools enough to let a moderate load eventually settle
> > to a steady state below the second trip.

That's the same issue I had on the rockpro64.

>
> Thanks for your answer.
>
> What would be the governor for this setup ?
>

The default governor when using arm64_defconfig is step_wise.

>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
