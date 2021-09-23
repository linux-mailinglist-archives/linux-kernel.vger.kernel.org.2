Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D173A416829
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhIWWrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbhIWWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:47:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4DBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 15:45:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 138so25548085qko.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKp1hHRL8F+OQfFGWFADWVrKMY57aRNj7ogOQ5bGn2Y=;
        b=PGiSvpZ3mujpWebBaRFE1biL4E5ZSs320mbTYJm+7fNzUWjvYsqL7g6ZPS4AQTwwFR
         2U5/M34k72YDoRewpiMvB5YvGXEekqhvcK4+KNsN5YHpR8+UoQlIOJs9AzWz+mI7ln/D
         oE80oyL4i2nXrwXC1nFBZliv0b4mcmtrcBowc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKp1hHRL8F+OQfFGWFADWVrKMY57aRNj7ogOQ5bGn2Y=;
        b=pI33zDQoUA7f1Fs5vwZMuSCD1UITBuBKxKTtAlHap3cbdPnVrv2kgxubqN6IXDGtaH
         uSu/OKDuJ8FT914dzG1BrwPV4pZPWivtbGdtNB7wIFQQeyZ2N+g6eWnQmuMUMet6oUpC
         zYjFmbHLrafxrBus2eZKjmMmIJtsFFfYG5und1Yv6khY558JfvVfF0jy5ZBB2aG18rmO
         ZARuztFUdwq8u/TA9n4Hf6E4KiaVnPtYwBUpRYw3PPGfrdwxLta3IMHYM0azgAlGPsUX
         Ny7h3IL46LoGhNlOCKewAH2CjBA3F9WPHEotNY21gFZhz4+5YZJ6G/q+GHsH89CQghVO
         5smQ==
X-Gm-Message-State: AOAM531M7E30xApVNByNFAw7P2DxSBsRqjUBsmD1pyg9wo9k7eglZRUE
        twpbXvO96rfTZKZVRJqEFLZLBPkQ9Z1drw==
X-Google-Smtp-Source: ABdhPJx7kluuYQY2sKMvsUKWinenyGJCK1MbgeRg3AP9JlZsele+Nf6LUIjGO+VEb61KP9rOxMhquQ==
X-Received: by 2002:a05:620a:4cb:: with SMTP id 11mr7306044qks.296.1632437130298;
        Thu, 23 Sep 2021 15:45:30 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id w11sm5182319qkp.49.2021.09.23.15.45.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 15:45:29 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 202so23667ybe.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 15:45:29 -0700 (PDT)
X-Received: by 2002:a25:ae97:: with SMTP id b23mr9195708ybj.50.1632437128929;
 Thu, 23 Sep 2021 15:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <1632399378-12229-1-git-send-email-rajpat@codeaurora.org>
 <1632399378-12229-2-git-send-email-rajpat@codeaurora.org> <1632436663.381520.3653405.nullmailer@robh.at.kernel.org>
In-Reply-To: <1632436663.381520.3653405.nullmailer@robh.at.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Sep 2021 15:45:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WOJiKUjGTYW0GmqOMqd_8+Y_tRmynuhZpaenwbTiG_9g@mail.gmail.com>
Message-ID: <CAD=FV=WOJiKUjGTYW0GmqOMqd_8+Y_tRmynuhZpaenwbTiG_9g@mail.gmail.com>
Subject: Re: [PATCH V10 1/8] dt-bindings: spi: Add sc7280 support
To:     Rob Herring <robh@kernel.org>
Cc:     Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, msavaliy@qti.qualcomm.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        satya priya <skakit@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 23, 2021 at 3:37 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 23 Sep 2021 17:46:11 +0530, Rajesh Patil wrote:
> > Add compatible for sc7280 SoC.
> >
> > Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> > Reviewed-by: Doug Anderson <dianders@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> > Change in V10:
> >  - As per Stephen's comments,
> >    sorted compatible names in alphabet order
> >
> > Changes in V9:
> >  - No changes
> >
> > Changes in V8:
> >  - As per Doug's comments, added "qcom,sc7280-qspi" compatible
> >
> >  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>
> Full log is available here: https://patchwork.ozlabs.org/patch/1531702
>
>
> spi@88dc000: compatible:0: 'qcom,qspi-v1' is not one of ['qcom,sc7280-qspi', 'qcom,sdm845-qspi']
>         arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
>
> spi@88dc000: compatible: ['qcom,qspi-v1'] is too short
>         arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml

Right. I mentioned this in earlier review feedback and Rajesh said
he'd do a follow-up patch to add sc7180 to the list here and also add
the proper compatible in the sc7180.dtsi file. That's not a new error
and (IMO) shouldn't block this patch from moving forward, though it
should be nearly trivial to do.

-Doug
