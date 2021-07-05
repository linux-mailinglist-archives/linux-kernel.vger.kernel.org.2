Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA23BBA91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhGEJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhGEJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:57:49 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E25C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:55:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s18so2150788ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76UHh0xd3/47lriNsZ56K8AIpOU4AXIgwxQmOqZVOu4=;
        b=Gur909yNfRrbSLYCj5TF7f3/2EDRhQ6gnhZdbubcP/OR83toGfoysivDTuXmGBIbJd
         WtGAWjpTPrkhBF0+pFEMzzlzEZzXfQlZRS3H+4s2aQwvo8AfoFG6jF6xPKR6PP+fsjnH
         aKwgpjD/6Jww1bAokjcLrlvJ1mg2HbSAec8do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76UHh0xd3/47lriNsZ56K8AIpOU4AXIgwxQmOqZVOu4=;
        b=QHQ+4ruug9LNrANan2L1WpIUujaB0luzsjGkgeru7RqohtGPb2QU3Jlbmhe39QuRYU
         sYXhlPG0IHkfO15RAH0p0B38PHQGPCSp00Nfwr6PMEFIV7RRghaUT9egapGUx7tS6i8M
         BIzPx2M7q9Oz1ZiGjKI0dD2e8JLm3kRjsfCGq8NE42iq7pZLFgp6ZaNjJmEa7h36MHVC
         e8SqEACLt1ixmRPWuM4KS5wdm/Ta0e4dQvfiifgPB2XYBmMIlvhus9Apwa4mvgzXvzMP
         3Y6IFuebNtnbOh6coeElA+uDRTyvSfpVrNVF6J1ukPOvpRLZWDi0BoynoW5ca7IQnd7v
         z9Kw==
X-Gm-Message-State: AOAM532uj3v63VeK5gLTE3SfstDXY+EQaSVuW2YDIcgUGB1vtHf+26/3
        gZ+RGyRLYmH1NbAHcYo9PtvP4YqrdHhrD8cIn40JEQ==
X-Google-Smtp-Source: ABdhPJyd+J7AADwR6pbVkPJj0QpvAzTSciPcJRxaXQx7VKleQjJCQk7Qi8C/Mv/1z/QFK8vAe5+pv0fE9PDIbsI+P4s=
X-Received: by 2002:a2e:5c42:: with SMTP id q63mr10340582ljb.23.1625478911337;
 Mon, 05 Jul 2021 02:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210630090710.1873559-1-kansho@chromium.org> <20210630180652.1.I88a52644e47e88b15f5db9841cb084dc53c5875c@changeid>
 <716ab7a7-937d-df88-8d3c-8d35df473b4e@gmail.com> <CAP3OrSLyoKNr7fMOx5sUtWi7PVQGuN-5w7k_0D2MhDUeXXmYCg@mail.gmail.com>
In-Reply-To: <CAP3OrSLyoKNr7fMOx5sUtWi7PVQGuN-5w7k_0D2MhDUeXXmYCg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 5 Jul 2021 17:55:00 +0800
Message-ID: <CAGXv+5FVf3hu5Y+aFazqBwAcvWMGkyqXB-2VVnskmMsYKj2_yA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: add audio node
To:     Kansho Nishida <kansho@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
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

Hi,

On Mon, Jul 5, 2021 at 5:40 PM Kansho Nishida <kansho@chromium.org> wrote:
>
> On Fri, Jul 2, 2021 at 3:20 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >
> >
> >
> > On 30/06/2021 11:07, Kansho Nishida wrote:
> > > Add afe (audio front end) device node to the MT8183 dtsi.
> > >
> > > Signed-off-by: Kansho Nishida <kansho@chromium.org>
> > > ---
> > >
> > >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 94 +++++++++++++++++++++++-
> > >  1 file changed, 93 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > index f90df6439c08..b06acb8d6527 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > @@ -1115,10 +1115,102 @@ usb_host: usb@11200000 {
> > >                       };
> > >               };
> > >
> > > -             audiosys: syscon@11220000 {
> > > +             audiosys: clock-controller@11220000 {
> >
> > Why do you change it from sysecon to clock-controller?
> >
> > Regards,
> > Matthias
>
> Hi Matthias,
>
> Thanks for the comments!
> This should be "clock-controller" according to the binding description (*1).
> Moreover, you suggested doing so even though it's a long time ago (*2).

The address space really covers the whole audio subsystem though. The clock
controls only span a few registers. In hindsight the clock controls shouldn't
have been modelled separately, since they are only used internally within the
audio subsystem.

See https://lore.kernel.org/linux-mediatek/YOLKxrJin5kkwiIl@google.com/T/#u
for issues I raised on the MT8195.

Now we are probably not going to be able to fix this for existing bindings,
so let's just get the node name right. It should probably be audio-controller
or something close instead.


Regards
ChenYu


> *1) https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/mediatek/mediatek%2Caudsys.txt
> *2) https://patchwork.kernel.org/project/linux-mediatek/patch/1559360354-22974-1-git-send-email-jiaxin.yu@mediatek.com/
>
> Regards,
> Kansho
>
> >
> > >                       compatible = "mediatek,mt8183-audiosys", "syscon";
> > >                       reg = <0 0x11220000 0 0x1000>;
> > >                       #clock-cells = <1>;
> > > +                     afe: mt8183-afe-pcm {
> > > +                             compatible = "mediatek,mt8183-audio";
> > > +                             interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> > > +                             resets = <&watchdog MT8183_TOPRGU_AUDIO_SW_RST>;
> > > +                             reset-names = "audiosys";
> > > +                             power-domains =
> > > +                                     <&spm MT8183_POWER_DOMAIN_AUDIO>;
> > > +                             clocks = <&audiosys CLK_AUDIO_AFE>,
> > > +                                      <&audiosys CLK_AUDIO_DAC>,
> > > +                                      <&audiosys CLK_AUDIO_DAC_PREDIS>,
> > > +                                      <&audiosys CLK_AUDIO_ADC>,
> > > +                                      <&audiosys CLK_AUDIO_PDN_ADDA6_ADC>,
> > > +                                      <&audiosys CLK_AUDIO_22M>,
> > > +                                      <&audiosys CLK_AUDIO_24M>,
> > > +                                      <&audiosys CLK_AUDIO_APLL_TUNER>,
> > > +                                      <&audiosys CLK_AUDIO_APLL2_TUNER>,
> > > +                                      <&audiosys CLK_AUDIO_I2S1>,
> > > +                                      <&audiosys CLK_AUDIO_I2S2>,
> > > +                                      <&audiosys CLK_AUDIO_I2S3>,
> > > +                                      <&audiosys CLK_AUDIO_I2S4>,
> > > +                                      <&audiosys CLK_AUDIO_TDM>,
> > > +                                      <&audiosys CLK_AUDIO_TML>,
> > > +                                      <&infracfg CLK_INFRA_AUDIO>,
> > > +                                      <&infracfg CLK_INFRA_AUDIO_26M_BCLK>,
> > > +                                      <&topckgen CLK_TOP_MUX_AUDIO>,
> > > +                                      <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
> > > +                                      <&topckgen CLK_TOP_SYSPLL_D2_D4>,
> > > +                                      <&topckgen CLK_TOP_MUX_AUD_1>,
> > > +                                      <&topckgen CLK_TOP_APLL1_CK>,
> > > +                                      <&topckgen CLK_TOP_MUX_AUD_2>,
> > > +                                      <&topckgen CLK_TOP_APLL2_CK>,
> > > +                                      <&topckgen CLK_TOP_MUX_AUD_ENG1>,
> > > +                                      <&topckgen CLK_TOP_APLL1_D8>,
> > > +                                      <&topckgen CLK_TOP_MUX_AUD_ENG2>,
> > > +                                      <&topckgen CLK_TOP_APLL2_D8>,
> > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S0>,
> > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S1>,
> > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S2>,
> > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S3>,
> > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S4>,
> > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S5>,
> > > +                                      <&topckgen CLK_TOP_APLL12_DIV0>,
> > > +                                      <&topckgen CLK_TOP_APLL12_DIV1>,
> > > +                                      <&topckgen CLK_TOP_APLL12_DIV2>,
> > > +                                      <&topckgen CLK_TOP_APLL12_DIV3>,
> > > +                                      <&topckgen CLK_TOP_APLL12_DIV4>,
> > > +                                      <&topckgen CLK_TOP_APLL12_DIVB>,
> > > +                                      /*<&topckgen CLK_TOP_APLL12_DIV5>,*/
> > > +                                      <&clk26m>;
> > > +                             clock-names = "aud_afe_clk",
> > > +                                               "aud_dac_clk",
> > > +                                               "aud_dac_predis_clk",
> > > +                                               "aud_adc_clk",
> > > +                                               "aud_adc_adda6_clk",
> > > +                                               "aud_apll22m_clk",
> > > +                                               "aud_apll24m_clk",
> > > +                                               "aud_apll1_tuner_clk",
> > > +                                               "aud_apll2_tuner_clk",
> > > +                                               "aud_i2s1_bclk_sw",
> > > +                                               "aud_i2s2_bclk_sw",
> > > +                                               "aud_i2s3_bclk_sw",
> > > +                                               "aud_i2s4_bclk_sw",
> > > +                                               "aud_tdm_clk",
> > > +                                               "aud_tml_clk",
> > > +                                               "aud_infra_clk",
> > > +                                               "mtkaif_26m_clk",
> > > +                                               "top_mux_audio",
> > > +                                               "top_mux_aud_intbus",
> > > +                                               "top_syspll_d2_d4",
> > > +                                               "top_mux_aud_1",
> > > +                                               "top_apll1_ck",
> > > +                                               "top_mux_aud_2",
> > > +                                               "top_apll2_ck",
> > > +                                               "top_mux_aud_eng1",
> > > +                                               "top_apll1_d8",
> > > +                                               "top_mux_aud_eng2",
> > > +                                               "top_apll2_d8",
> > > +                                               "top_i2s0_m_sel",
> > > +                                               "top_i2s1_m_sel",
> > > +                                               "top_i2s2_m_sel",
> > > +                                               "top_i2s3_m_sel",
> > > +                                               "top_i2s4_m_sel",
> > > +                                               "top_i2s5_m_sel",
> > > +                                               "top_apll12_div0",
> > > +                                               "top_apll12_div1",
> > > +                                               "top_apll12_div2",
> > > +                                               "top_apll12_div3",
> > > +                                               "top_apll12_div4",
> > > +                                               "top_apll12_divb",
> > > +                                               /*"top_apll12_div5",*/
> > > +                                               "top_clk26m_clk";
> > > +                     };
> > >               };
> > >
> > >               mmc0: mmc@11230000 {
> > >
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
