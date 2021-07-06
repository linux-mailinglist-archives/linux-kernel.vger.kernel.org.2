Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A093BC895
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhGFJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhGFJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:41:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E254C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 02:38:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 37so2093964pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yF9OMxS2c/2tokATGGfLkvP79xoaq/JM2vOaNahFcrY=;
        b=K/xCtGhsSAOAnYR7nSSV1bWrTUYHM9dWS2fvDAwR0MMVeP28fB2KkgtgnqkSeywRFu
         0eU7iezOAPPwFi+uYP8fMjxZJNhhZsyFnAcqdv9pYH8CI0ryXItb/KEVCYQedmk7sOzY
         yisRJyiOamke/HQTntFEz9Y7qsj8EKwJ8DfLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yF9OMxS2c/2tokATGGfLkvP79xoaq/JM2vOaNahFcrY=;
        b=gIle/0FqMzo9TobBVHG1tiBRlezyXd2BwwxXePIVyTsWseqdr+hwydPebYq42FGYXp
         X+0CPQlFbUYziK9qqK0FkmASb1WFUIYA7Yz7+hakcJefaf6a+iakw5X5TH12OxKtoty5
         nKm4/OwhE/QmnHXQNjr4+2FuRx0iSAYD0VDhY+i2B76mvK3bxZTFE6ZAvlETLXgSrPO6
         NQuAE3dR0DU783VZdgMhATYKLQBllHtfb7nzdydfqvRmy+eysm38uZ7lXxFd0JeUC6R1
         GIlNL9hGsuZ0j32NwXGDPTMyoxy9kNj9AVyKUBToVBr3BKkqJiwmgkcXfqRRXJLjIYLK
         wfSA==
X-Gm-Message-State: AOAM531DzfuvAtQspkejd8o7NFqE6JwESLVCLceFnb8XF1IuwZ3GbxfQ
        s4TN/noBpJBqqgqcIAkgPRMvS9txwnXPXS3HrvTY3w==
X-Google-Smtp-Source: ABdhPJymcCrNGCc0r7o3SY6VsAaA9EN5U5abtpl7YUfwb0OBhex7wh98FaICBfBIrhrVRx2hWrKi9mRnsUA3QbY35k0=
X-Received: by 2002:a62:e307:0:b029:321:98d5:ae46 with SMTP id
 g7-20020a62e3070000b029032198d5ae46mr5909502pfh.66.1625564311602; Tue, 06 Jul
 2021 02:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210630090710.1873559-1-kansho@chromium.org> <20210630180652.1.I88a52644e47e88b15f5db9841cb084dc53c5875c@changeid>
 <716ab7a7-937d-df88-8d3c-8d35df473b4e@gmail.com> <CAP3OrSLyoKNr7fMOx5sUtWi7PVQGuN-5w7k_0D2MhDUeXXmYCg@mail.gmail.com>
 <CAGXv+5FVf3hu5Y+aFazqBwAcvWMGkyqXB-2VVnskmMsYKj2_yA@mail.gmail.com>
In-Reply-To: <CAGXv+5FVf3hu5Y+aFazqBwAcvWMGkyqXB-2VVnskmMsYKj2_yA@mail.gmail.com>
From:   Kansho Nishida <kansho@chromium.org>
Date:   Tue, 6 Jul 2021 18:38:20 +0900
Message-ID: <CAP3OrSK_CVJO3s3YhO5e_m_k0z8h1GrrC8WMcRw1WD41nJk=XA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: add audio node
To:     Chen-Yu Tsai <wenst@chromium.org>
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

Hi Chen,

On Mon, Jul 5, 2021 at 6:55 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 5, 2021 at 5:40 PM Kansho Nishida <kansho@chromium.org> wrote:
> >
> > On Fri, Jul 2, 2021 at 3:20 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > >
> > >
> > >
> > > On 30/06/2021 11:07, Kansho Nishida wrote:
> > > > Add afe (audio front end) device node to the MT8183 dtsi.
> > > >
> > > > Signed-off-by: Kansho Nishida <kansho@chromium.org>
> > > > ---
> > > >
> > > >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 94 +++++++++++++++++++++++-
> > > >  1 file changed, 93 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > > index f90df6439c08..b06acb8d6527 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > > @@ -1115,10 +1115,102 @@ usb_host: usb@11200000 {
> > > >                       };
> > > >               };
> > > >
> > > > -             audiosys: syscon@11220000 {
> > > > +             audiosys: clock-controller@11220000 {
> > >
> > > Why do you change it from sysecon to clock-controller?
> > >
> > > Regards,
> > > Matthias
> >
> > Hi Matthias,
> >
> > Thanks for the comments!
> > This should be "clock-controller" according to the binding description (*1).
> > Moreover, you suggested doing so even though it's a long time ago (*2).
>
> The address space really covers the whole audio subsystem though. The clock
> controls only span a few registers. In hindsight the clock controls shouldn't
> have been modelled separately, since they are only used internally within the
> audio subsystem.
>
> See https://lore.kernel.org/linux-mediatek/YOLKxrJin5kkwiIl@google.com/T/#u
> for issues I raised on the MT8195.
>
> Now we are probably not going to be able to fix this for existing bindings,
> so let's just get the node name right. It should probably be audio-controller
> or something close instead.

OK, let's use audio-controller instead. I'll submit the v3 patch.

Regards,
Kansho

>
>
> Regards
> ChenYu
>
>
> > *1) https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/mediatek/mediatek%2Caudsys.txt
> > *2) https://patchwork.kernel.org/project/linux-mediatek/patch/1559360354-22974-1-git-send-email-jiaxin.yu@mediatek.com/
> >
> > Regards,
> > Kansho
> >
> > >
> > > >                       compatible = "mediatek,mt8183-audiosys", "syscon";
> > > >                       reg = <0 0x11220000 0 0x1000>;
> > > >                       #clock-cells = <1>;
> > > > +                     afe: mt8183-afe-pcm {
> > > > +                             compatible = "mediatek,mt8183-audio";
> > > > +                             interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> > > > +                             resets = <&watchdog MT8183_TOPRGU_AUDIO_SW_RST>;
> > > > +                             reset-names = "audiosys";
> > > > +                             power-domains =
> > > > +                                     <&spm MT8183_POWER_DOMAIN_AUDIO>;
> > > > +                             clocks = <&audiosys CLK_AUDIO_AFE>,
> > > > +                                      <&audiosys CLK_AUDIO_DAC>,
> > > > +                                      <&audiosys CLK_AUDIO_DAC_PREDIS>,
> > > > +                                      <&audiosys CLK_AUDIO_ADC>,
> > > > +                                      <&audiosys CLK_AUDIO_PDN_ADDA6_ADC>,
> > > > +                                      <&audiosys CLK_AUDIO_22M>,
> > > > +                                      <&audiosys CLK_AUDIO_24M>,
> > > > +                                      <&audiosys CLK_AUDIO_APLL_TUNER>,
> > > > +                                      <&audiosys CLK_AUDIO_APLL2_TUNER>,
> > > > +                                      <&audiosys CLK_AUDIO_I2S1>,
> > > > +                                      <&audiosys CLK_AUDIO_I2S2>,
> > > > +                                      <&audiosys CLK_AUDIO_I2S3>,
> > > > +                                      <&audiosys CLK_AUDIO_I2S4>,
> > > > +                                      <&audiosys CLK_AUDIO_TDM>,
> > > > +                                      <&audiosys CLK_AUDIO_TML>,
> > > > +                                      <&infracfg CLK_INFRA_AUDIO>,
> > > > +                                      <&infracfg CLK_INFRA_AUDIO_26M_BCLK>,
> > > > +                                      <&topckgen CLK_TOP_MUX_AUDIO>,
> > > > +                                      <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
> > > > +                                      <&topckgen CLK_TOP_SYSPLL_D2_D4>,
> > > > +                                      <&topckgen CLK_TOP_MUX_AUD_1>,
> > > > +                                      <&topckgen CLK_TOP_APLL1_CK>,
> > > > +                                      <&topckgen CLK_TOP_MUX_AUD_2>,
> > > > +                                      <&topckgen CLK_TOP_APLL2_CK>,
> > > > +                                      <&topckgen CLK_TOP_MUX_AUD_ENG1>,
> > > > +                                      <&topckgen CLK_TOP_APLL1_D8>,
> > > > +                                      <&topckgen CLK_TOP_MUX_AUD_ENG2>,
> > > > +                                      <&topckgen CLK_TOP_APLL2_D8>,
> > > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S0>,
> > > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S1>,
> > > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S2>,
> > > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S3>,
> > > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S4>,
> > > > +                                      <&topckgen CLK_TOP_MUX_APLL_I2S5>,
> > > > +                                      <&topckgen CLK_TOP_APLL12_DIV0>,
> > > > +                                      <&topckgen CLK_TOP_APLL12_DIV1>,
> > > > +                                      <&topckgen CLK_TOP_APLL12_DIV2>,
> > > > +                                      <&topckgen CLK_TOP_APLL12_DIV3>,
> > > > +                                      <&topckgen CLK_TOP_APLL12_DIV4>,
> > > > +                                      <&topckgen CLK_TOP_APLL12_DIVB>,
> > > > +                                      /*<&topckgen CLK_TOP_APLL12_DIV5>,*/
> > > > +                                      <&clk26m>;
> > > > +                             clock-names = "aud_afe_clk",
> > > > +                                               "aud_dac_clk",
> > > > +                                               "aud_dac_predis_clk",
> > > > +                                               "aud_adc_clk",
> > > > +                                               "aud_adc_adda6_clk",
> > > > +                                               "aud_apll22m_clk",
> > > > +                                               "aud_apll24m_clk",
> > > > +                                               "aud_apll1_tuner_clk",
> > > > +                                               "aud_apll2_tuner_clk",
> > > > +                                               "aud_i2s1_bclk_sw",
> > > > +                                               "aud_i2s2_bclk_sw",
> > > > +                                               "aud_i2s3_bclk_sw",
> > > > +                                               "aud_i2s4_bclk_sw",
> > > > +                                               "aud_tdm_clk",
> > > > +                                               "aud_tml_clk",
> > > > +                                               "aud_infra_clk",
> > > > +                                               "mtkaif_26m_clk",
> > > > +                                               "top_mux_audio",
> > > > +                                               "top_mux_aud_intbus",
> > > > +                                               "top_syspll_d2_d4",
> > > > +                                               "top_mux_aud_1",
> > > > +                                               "top_apll1_ck",
> > > > +                                               "top_mux_aud_2",
> > > > +                                               "top_apll2_ck",
> > > > +                                               "top_mux_aud_eng1",
> > > > +                                               "top_apll1_d8",
> > > > +                                               "top_mux_aud_eng2",
> > > > +                                               "top_apll2_d8",
> > > > +                                               "top_i2s0_m_sel",
> > > > +                                               "top_i2s1_m_sel",
> > > > +                                               "top_i2s2_m_sel",
> > > > +                                               "top_i2s3_m_sel",
> > > > +                                               "top_i2s4_m_sel",
> > > > +                                               "top_i2s5_m_sel",
> > > > +                                               "top_apll12_div0",
> > > > +                                               "top_apll12_div1",
> > > > +                                               "top_apll12_div2",
> > > > +                                               "top_apll12_div3",
> > > > +                                               "top_apll12_div4",
> > > > +                                               "top_apll12_divb",
> > > > +                                               /*"top_apll12_div5",*/
> > > > +                                               "top_clk26m_clk";
> > > > +                     };
> > > >               };
> > > >
> > > >               mmc0: mmc@11230000 {
> > > >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
