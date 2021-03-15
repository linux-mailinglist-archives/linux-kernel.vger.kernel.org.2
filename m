Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A933C8E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhCOVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCOVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:54:23 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:54:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so3653277oof.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFeSJS/MRHlKtItdRjinPI+VLJU1JVPOY38JbLtHXag=;
        b=oEtzhfheH12wp/ca7p21OEaxExfRoiHNdT6o/p3p23Ws/jJ3D1GK7+kCr/hbGBXR50
         Dy1yFg8C/fDxgdwaA+veTFn++A32/JJ+rfknledpTJxlE7LaSQpzot0JTIkn5p0ovbfO
         1bNq3gCpOr+5/q+VZuq/wp3Yzs9uHRYCvzFog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFeSJS/MRHlKtItdRjinPI+VLJU1JVPOY38JbLtHXag=;
        b=YESrE+ieYigamsSCzTc9AoJOFTscDc6HOOk2gyDGmXK7yS1HonK4VZUH9DbHjNzTAZ
         UJI1FXieN7RQ19d9h0U5VUiSuMb7fiKUDAnxcjBC1nm233Ljx5v5wEO4HTuOtrnJgbQm
         g4Fx0rLTg+2AnjIyqFv2ZLHUvD3AUU7n/0icp+E7HrwiY4ei5SF6sk2QeLnb7P6kWfc/
         Jea5Bdn7LPwDYoQw258xHgCmf1+uK2DjljD2+iZpZP6cO0b4xQZ/pcYU9AnE8gYqwlZJ
         zLOMcpwGnF5YBrnbpTAjViIAaimkl5SAmVOYqsKmqlW+JZwaYkg7Qd2pTP2VCK+rHLMT
         AVkA==
X-Gm-Message-State: AOAM532ZMBKy40z+SzzR3TMdLzW19dH6pBEeflIVPyoq1Mg1K2uVpDiE
        wPM9Atf71r2FEQ8hpXzfEkQQ42dV2IYAUA==
X-Google-Smtp-Source: ABdhPJzdNrZlIdSiXbpMfEQ3dDr4iEb0ThuPKY2cRpUHufeElourh7rTUjDCcfQmzPc18Ic+3YpSkg==
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr896904oop.1.1615845262276;
        Mon, 15 Mar 2021 14:54:22 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id y194sm7369434ooa.19.2021.03.15.14.54.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 14:54:22 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so5882864otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:54:21 -0700 (PDT)
X-Received: by 2002:a25:cf88:: with SMTP id f130mr2592963ybg.476.1615844956124;
 Mon, 15 Mar 2021 14:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210312183228.550779-1-mka@chromium.org> <20210312103211.v2.3.I95b8a63103b77cab6a7cf9c150f0541db57fda98@changeid>
In-Reply-To: <20210312103211.v2.3.I95b8a63103b77cab6a7cf9c150f0541db57fda98@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Mar 2021 14:49:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xq4bd8j3_to_9rJmyqWTi-78OWVCd0meaJ9e_pmOH+Rg@mail.gmail.com>
Message-ID: <CAD=FV=Xq4bd8j3_to_9rJmyqWTi-78OWVCd0meaJ9e_pmOH+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7180: Add CoachZ rev3
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 12, 2021 at 10:32 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> CoachZ rev3 uses a 100k NTC thermistor for the charger temperatures,
> instead of the 47k NTC that is stuffed in earlier revisions. Add .dts
> files for rev3.
>
> The 47k NTC currently isn't supported by the PM6150 ADC driver.
> Disable the charger thermal zone for rev1 and rev2 to avoid the use
> of bogus temperature values.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - added CoachZ rev3
> - updated subject and commit message
>
>  arch/arm64/boot/dts/qcom/Makefile              |  2 ++
>  .../boot/dts/qcom/sc7180-trogdor-coachz-r1.dts |  9 +++++++++
>  .../dts/qcom/sc7180-trogdor-coachz-r2-lte.dts  |  4 ++--
>  .../boot/dts/qcom/sc7180-trogdor-coachz-r2.dts | 13 +++++++++++--
>  .../dts/qcom/sc7180-trogdor-coachz-r3-lte.dts  | 18 ++++++++++++++++++
>  .../boot/dts/qcom/sc7180-trogdor-coachz-r3.dts | 15 +++++++++++++++
>  6 files changed, 57 insertions(+), 4 deletions(-)

So what you have here is good and we could land it. Feel free to add
my Reviewed-by tag if you want.

...but I want to propose an alternative. It turns out that these days
coachz-r1 and coachz-r2 are actually the same. The only reason both
exist is because <https://crrev.com/c/2733863> ("CHROMIUM: arm64: dts:
qcom: sc7180: add dmic_clk_en back") wasn't the proper inverse of
<https://crrev.com/c/2596726> ("CHROMIUM: arm64: dts: qcom: sc7180:
remove dmic_clk_en").

It sorta squashes two changes into one, but if you combined your
change with one that folded "-r1" into "-r2" it would actually make a
smaller / easier to understand change, essentially, it would be:
- just a rename of the "-r2" file to be "-r3"
- add "-rev2" into the list of compatibles in "-r1" file.
- add the "disable" into the "-r1" file.

Anyway, I'll leave it up to you.


-Doug
