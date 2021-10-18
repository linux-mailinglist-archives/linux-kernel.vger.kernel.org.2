Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF41430FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 07:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJRFYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhJRFYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:24:06 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C22C061745
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:21:56 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso1008123ota.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfN5TQ22U2KTDvkMiOGUKIajMf8GYobcA00Dr8Mt+CY=;
        b=tS8ToojrQ4pmJBf1PdisCQBfJHtzq32axihoCCbxboNp7zEJM50K6zHjUHNR/Wcw4y
         mfOPm0O4w6F2Pm6BG5Og2/JCfSSOfMqbtHE9O/LDvUgCUty1YoqsykWCzaGEWwFbR893
         KknzVhfDxA70cMQQ0KO5eOunhje+tM+vctrFOBcSZCM8D2rOMQ5rWly5bAkZ/JUGO/lr
         iZO+esqkbAM9UuYeCP4+kWe+1qjNx96fVlOk9a5mWGxMV4ikDRoLUBAN3dmdLtB+qpBX
         EnpXzYQKinlIRrCnqKp2dGjNTS9ptYDsGQGEbIghTnjumV/otuIAQcXANsg6/lYQDzSb
         uXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfN5TQ22U2KTDvkMiOGUKIajMf8GYobcA00Dr8Mt+CY=;
        b=VuWHMcsXUcKNkoTy/o/Mj5D6kPB3pYzVR6bwlz3r9Nl2ZNv6MOj/2nx4e6KKM8h1jy
         vi7a81euPKZHd9Mc7pTH2Y1VtBJicioBVgtdeQobZncuOAXHdHgNpNU3g5N07PFpzITW
         rGerEom7Ai7b4wwzjRXXCKcZJY6cxgdW0SU6gkqz0/7H0alh3IpeAYT9JkmhcdrpJsQR
         r3xdMyLNEfN7VuFop6J+Yi/lSzWDgYtX4faxkmMMa8eg3k05tdHR1bB4tBiQS7Q/aAmQ
         v6jbtfBmixjsv3qqgoEbHa67IM5k/7HQpmcLTrshGQqRJ99wEyfO74U1R3TtvCioN21I
         hCHw==
X-Gm-Message-State: AOAM533a+eukwslv8UX4yuLU8xPNP8scS4crIdHpvgr6tPL3shWEHn8E
        geR2HgCb+rOavy76fMnRf46O7jIlW9JL7SQ9tlwHrA==
X-Google-Smtp-Source: ABdhPJw95k5KegGUv5YGfjdWaUckEAabcBIHOIenlhum4/S/scJJlhCp/9gw6fX9QebXdznc9O34rreiCUWCzbkNOa4=
X-Received: by 2002:a05:6830:1c26:: with SMTP id f6mr19614185ote.28.1634534515216;
 Sun, 17 Oct 2021 22:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211017204036.2761122-1-bjorn.andersson@linaro.org> <CAH=2Nty2yyVa1ow_zEOv3nsjjWg9Cb0CpTyDXAenMPMiBs4NQg@mail.gmail.com>
In-Reply-To: <CAH=2Nty2yyVa1ow_zEOv3nsjjWg9Cb0CpTyDXAenMPMiBs4NQg@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 18 Oct 2021 10:51:44 +0530
Message-ID: <CAH=2NtypnKZsBva93yCQgBa-9pufkn0-vGAH04mOezfo4496AA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm LMH driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 at 10:47, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Hi,
>
> On Mon, 18 Oct 2021 at 02:08, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > With the introduction of LMH in '36c6581214c4 ("arm64: dts: qcom:
> > sdm845: Add support for LMh node")' the CPUfreq gained a reference for
> > the two interrupts from the LMh. This means that if the LMh driver isn't
> > enabled CPUfreq will not probe and there's no frequency scaling.
> >
> > Enable LMh to make CPUfreq functional again on SDM845.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 86224aa3a74b..0ae6cd2748d2 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -577,6 +577,7 @@ CONFIG_TEGRA_BPMP_THERMAL=m
> >  CONFIG_TEGRA_SOCTHERM=m
> >  CONFIG_QCOM_TSENS=y
> >  CONFIG_QCOM_SPMI_TEMP_ALARM=m
> > +CONFIG_QCOM_LMH=m
> >  CONFIG_UNIPHIER_THERMAL=y
> >  CONFIG_WATCHDOG=y
> >  CONFIG_SL28CPLD_WATCHDOG=m
> > --
>
> Tested on SA8155p-ADP board, so:

Sorry, a typo here, I meant the patch was tested on the sdm845-mtp board here :)

> Reviewed-and-Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>
> Regards.
