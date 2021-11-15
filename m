Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1D44FE0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 06:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhKOFIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 00:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhKOFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 00:07:57 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC4C061767
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 21:05:02 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso25374566otj.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHrhWAX2hQVCS39Z0qh/1XKWuVoHM9rjZxjvoaThtm4=;
        b=aILiIugcaxhFkz3Nv9I61TgKO/mhDAT2DpqhXBmzZvwpInxER6q8uCXDKhUQsBtP4s
         mHnfUBz2QjAteqw1TFsiUEqViSJusVWfCgDyC8YQCKodu82MA08vFS02wWN7DZdfNMv1
         OycmASRw1mX/idzy0l0GVziq0dpvLnuUamBKyF9dkf9Lz8PAK4bETXpEiRRULTVL/CPn
         yTniX78IJl7CvccCGYGVY1CblkzOSWT0YxB+ZMM96ZGIrq9bhiAeieefIq9cEM3kLlyw
         XuHsPMQHHGF8G+xh4fcZ03xT87bDLDruBy3d3YY2zLB9cn9VvgIkb5M/KDtSnF44rop8
         0jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHrhWAX2hQVCS39Z0qh/1XKWuVoHM9rjZxjvoaThtm4=;
        b=0B4vE8vkatdRcu5jVL7OkrHWODdEOeH96fLgSNoV0zGr0nzqKMoXZu6TaHL0aKBYtv
         mBgZWhCk0yWk2tnIigT1xNIR8TLA/sWpPfHfbHJLIwqWGgqmsFK1AgdAklQRQu3SXp18
         MKatMs0RsYXP0v874PIo0bYyiffqrQfOITEsRxFM8ki15Kn1nAoXn0Gyk2ZV3Zx93IYP
         WVGhB7fQCx6q0UczkFveakICZ4Lgsqyy2l1uLbbspqZaWubHiSPPlfHRDunh7+Z91J7t
         KGktYDmOa2MUpSVGg/H9p2LWshhQ7WoNQiyEEX3wyIixWdMGMyPqhluXt7+3UWQTGs4f
         OIKg==
X-Gm-Message-State: AOAM530dfpKyTu6iN0gtTG/e7QR3cZds6cS2edRfq73sSG94n3XjC2Sp
        +JGgEG/Cri9yF0FUt5NCsiQunEAWxora9aDroBKNKQ==
X-Google-Smtp-Source: ABdhPJyx/NXeuruSZYCP6RmBQ2IDicSOu74/i/SA2lHFYkeHg16bF7PA87Kk/p/fQVfbS0fqYA74Mtgt/o1d6X3iHv8=
X-Received: by 2002:a9d:63d2:: with SMTP id e18mr15410715otl.28.1636952701274;
 Sun, 14 Nov 2021 21:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-13-bhupesh.sharma@linaro.org> <7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org>
In-Reply-To: <7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 15 Nov 2021 10:34:50 +0530
Message-ID: <CAH=2Ntw7Npzrba7xnu--GHh1-ofVXKU8SEe9hLj8bt-gQQMBsQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/22] arm64/dts: qcom: Use new compatibles for crypto nodes
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Fri, 12 Nov 2021 at 15:56, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Hi Bhupesh,
>
> On 11/10/21 12:59 PM, Bhupesh Sharma wrote:
> > Since we are using soc specific qce crypto IP compatibles
> > in the bindings now, use the same in the device tree files
> > which include the crypto nodes.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
> >   arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > index 933b56103a46..f477d026c949 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > @@ -204,7 +204,7 @@ cryptobam: dma-controller@704000 {
> >               };
> >
> >               crypto: crypto@73a000 {
> > -                     compatible = "qcom,crypto-v5.1";
> > +                     compatible = "qcom,ipq6018-qce";
> >                       reg = <0x0 0x0073a000 0x0 0x6000>;
> >                       clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
> >                               <&gcc GCC_CRYPTO_AXI_CLK>,
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 526087586ba4..8e7cbadff25a 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -2329,7 +2329,7 @@ cryptobam: dma-controller@1dc4000 {
> >               };
> >
> >               crypto: crypto@1dfa000 {
> > -                     compatible = "qcom,crypto-v5.4";
> > +                     compatible = "qcom,sdm845-qce";
> >                       reg = <0 0x01dfa000 0 0x6000>;
> >                       clocks = <&gcc GCC_CE1_AHB_CLK>,
> >                                <&gcc GCC_CE1_AXI_CLK>,
> >
>
> and in connection to my review comment on v5 11/22 there should be done
> similar changes for ipq8074.dtsi and msm8996.dtsi.

Ok, I will fix this in v6.

Thanks,
Bhupesh
