Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE2F3BBA64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhGEJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhGEJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:42:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2645C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:40:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d12so16236396pfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NEgfDbLASj9u3BPxvvxZ1ejuTwiwGxydassBot+RfA=;
        b=ZTT+24SsIiUhwkeb67dSyuBKmhWy+p0YSpEeoGTVkBO3KEhZgxVzb1M0N+dmnQOuP+
         NplltYl4f/jGYlMzZsb15OP4tzy1A2OFmiFn6litXc8osD2m1f5nN4rgZ/MUBegoeZBg
         N3yb3yfrpYYpjnoMubFhC4naGQ547oMIKczz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NEgfDbLASj9u3BPxvvxZ1ejuTwiwGxydassBot+RfA=;
        b=WqOApRmPou0s+nspT8ZZaPKnFaGHqyGaU/zPWQKQbGp/J01wprvONqsN1GpJ5GSGPd
         RUVpZW94d1XS/GQbYZD6DRsdLxhCHk5cM7NJdTN4+rk+8pkfAnPYtuIEKvuAVsxLN1h1
         l3WbBbfnKBRlf+KFQ8xyNdqJnCEF4WlqJsTDPNz0yZryRwvrmkdw3Fiq/qVhPIq5c1D4
         SDYY+ODAM/STvX399x1Jhuj0JbZ0AZvb7CiFLgH2XvJv2Ux6ZhhbndREtWFmNY662et7
         QLsMuRgH5zA2YUxE+nL67DUF2qUD9h+E7hJxBW0Q6Y7ZXifMQnnNd9UZsM7xU/MrbZeL
         2KHQ==
X-Gm-Message-State: AOAM530Ig1qavsiYJSoMVVdQnRDoeMZWHEPsqjTcnH2by2j5h/artBg7
        V5CFP8pJ7rmJNt5yjkcPEpj1JyF4yzLXxxQG1keOmw==
X-Google-Smtp-Source: ABdhPJxehs17Gva3Z1PLinNDiwy6ZNwOYg8wG9gpLsrwSz4om20wFIio8AUK7w5i5rU5PDWp2naXrlLFq3lMCZFFA6U=
X-Received: by 2002:a63:e316:: with SMTP id f22mr14711550pgh.100.1625478003378;
 Mon, 05 Jul 2021 02:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210630090710.1873559-1-kansho@chromium.org> <20210630180652.1.I88a52644e47e88b15f5db9841cb084dc53c5875c@changeid>
 <716ab7a7-937d-df88-8d3c-8d35df473b4e@gmail.com>
In-Reply-To: <716ab7a7-937d-df88-8d3c-8d35df473b4e@gmail.com>
From:   Kansho Nishida <kansho@chromium.org>
Date:   Mon, 5 Jul 2021 18:39:52 +0900
Message-ID: <CAP3OrSLyoKNr7fMOx5sUtWi7PVQGuN-5w7k_0D2MhDUeXXmYCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: add audio node
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shunli Wang <shunli.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 3:20 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 30/06/2021 11:07, Kansho Nishida wrote:
> > Add afe (audio front end) device node to the MT8183 dtsi.
> >
> > Signed-off-by: Kansho Nishida <kansho@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 94 +++++++++++++++++++++++-
> >  1 file changed, 93 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index f90df6439c08..b06acb8d6527 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -1115,10 +1115,102 @@ usb_host: usb@11200000 {
> >                       };
> >               };
> >
> > -             audiosys: syscon@11220000 {
> > +             audiosys: clock-controller@11220000 {
>
> Why do you change it from sysecon to clock-controller?
>
> Regards,
> Matthias

Hi Matthias,

Thanks for the comments!
This should be "clock-controller" according to the binding description (*1).
Moreover, you suggested doing so even though it's a long time ago (*2).

*1) https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/mediatek/mediatek%2Caudsys.txt
*2) https://patchwork.kernel.org/project/linux-mediatek/patch/1559360354-22974-1-git-send-email-jiaxin.yu@mediatek.com/

Regards,
Kansho

>
> >                       compatible = "mediatek,mt8183-audiosys", "syscon";
> >                       reg = <0 0x11220000 0 0x1000>;
> >                       #clock-cells = <1>;
> > +                     afe: mt8183-afe-pcm {
> > +                             compatible = "mediatek,mt8183-audio";
> > +                             interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> > +                             resets = <&watchdog MT8183_TOPRGU_AUDIO_SW_RST>;
> > +                             reset-names = "audiosys";
> > +                             power-domains =
> > +                                     <&spm MT8183_POWER_DOMAIN_AUDIO>;
> > +                             clocks = <&audiosys CLK_AUDIO_AFE>,
> > +                                      <&audiosys CLK_AUDIO_DAC>,
> > +                                      <&audiosys CLK_AUDIO_DAC_PREDIS>,
> > +                                      <&audiosys CLK_AUDIO_ADC>,
> > +                                      <&audiosys CLK_AUDIO_PDN_ADDA6_ADC>,
> > +                                      <&audiosys CLK_AUDIO_22M>,
> > +                                      <&audiosys CLK_AUDIO_24M>,
> > +                                      <&audiosys CLK_AUDIO_APLL_TUNER>,
> > +                                      <&audiosys CLK_AUDIO_APLL2_TUNER>,
> > +                                      <&audiosys CLK_AUDIO_I2S1>,
> > +                                      <&audiosys CLK_AUDIO_I2S2>,
> > +                                      <&audiosys CLK_AUDIO_I2S3>,
> > +                                      <&audiosys CLK_AUDIO_I2S4>,
> > +                                      <&audiosys CLK_AUDIO_TDM>,
> > +                                      <&audiosys CLK_AUDIO_TML>,
> > +                                      <&infracfg CLK_INFRA_AUDIO>,
> > +                                      <&infracfg CLK_INFRA_AUDIO_26M_BCLK>,
> > +                                      <&topckgen CLK_TOP_MUX_AUDIO>,
> > +                                      <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
> > +                                      <&topckgen CLK_TOP_SYSPLL_D2_D4>,
> > +                                      <&topckgen CLK_TOP_MUX_AUD_1>,
> > +                                      <&topckgen CLK_TOP_APLL1_CK>,
> > +                                      <&topckgen CLK_TOP_MUX_AUD_2>,
> > +                                      <&topckgen CLK_TOP_APLL2_CK>,
> > +                                      <&topckgen CLK_TOP_MUX_AUD_ENG1>,
> > +                                      <&topckgen CLK_TOP_APLL1_D8>,
> > +                                      <&topckgen CLK_TOP_MUX_AUD_ENG2>,
> > +                                      <&topckgen CLK_TOP_APLL2_D8>,
> > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S0>,
> > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S1>,
> > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S2>,
> > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S3>,
> > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S4>,
> > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S5>,
> > +                                      <&topckgen CLK_TOP_APLL12_DIV0>,
> > +                                      <&topckgen CLK_TOP_APLL12_DIV1>,
> > +                                      <&topckgen CLK_TOP_APLL12_DIV2>,
> > +                                      <&topckgen CLK_TOP_APLL12_DIV3>,
> > +                                      <&topckgen CLK_TOP_APLL12_DIV4>,
> > +                                      <&topckgen CLK_TOP_APLL12_DIVB>,
> > +                                      /*<&topckgen CLK_TOP_APLL12_DIV5>,*/
> > +                                      <&clk26m>;
> > +                             clock-names = "aud_afe_clk",
> > +                                               "aud_dac_clk",
> > +                                               "aud_dac_predis_clk",
> > +                                               "aud_adc_clk",
> > +                                               "aud_adc_adda6_clk",
> > +                                               "aud_apll22m_clk",
> > +                                               "aud_apll24m_clk",
> > +                                               "aud_apll1_tuner_clk",
> > +                                               "aud_apll2_tuner_clk",
> > +                                               "aud_i2s1_bclk_sw",
> > +                                               "aud_i2s2_bclk_sw",
> > +                                               "aud_i2s3_bclk_sw",
> > +                                               "aud_i2s4_bclk_sw",
> > +                                               "aud_tdm_clk",
> > +                                               "aud_tml_clk",
> > +                                               "aud_infra_clk",
> > +                                               "mtkaif_26m_clk",
> > +                                               "top_mux_audio",
> > +                                               "top_mux_aud_intbus",
> > +                                               "top_syspll_d2_d4",
> > +                                               "top_mux_aud_1",
> > +                                               "top_apll1_ck",
> > +                                               "top_mux_aud_2",
> > +                                               "top_apll2_ck",
> > +                                               "top_mux_aud_eng1",
> > +                                               "top_apll1_d8",
> > +                                               "top_mux_aud_eng2",
> > +                                               "top_apll2_d8",
> > +                                               "top_i2s0_m_sel",
> > +                                               "top_i2s1_m_sel",
> > +                                               "top_i2s2_m_sel",
> > +                                               "top_i2s3_m_sel",
> > +                                               "top_i2s4_m_sel",
> > +                                               "top_i2s5_m_sel",
> > +                                               "top_apll12_div0",
> > +                                               "top_apll12_div1",
> > +                                               "top_apll12_div2",
> > +                                               "top_apll12_div3",
> > +                                               "top_apll12_div4",
> > +                                               "top_apll12_divb",
> > +                                               /*"top_apll12_div5",*/
> > +                                               "top_clk26m_clk";
> > +                     };
> >               };
> >
> >               mmc0: mmc@11230000 {
> >
