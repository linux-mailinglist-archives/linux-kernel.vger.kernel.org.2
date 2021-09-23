Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C4415E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbhIWMaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbhIWM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:29:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523D5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:28:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u18so16720154wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=3X/0Bz3TcQZxyw6b50mGF0nqME1lbTMZ6NdXCIyuzXo=;
        b=jSZNqAHs+OjD/7w3jZCNY3F1xVfRXKrlg2nd4C82G4Afbdry99c7o8Zyo61gLwj+kM
         I9ulEN9uDswy/Ta8BGKoHv/PkcQuy/uIJBpy7kleDMCMC58z3hMPtndDViwVVe77y4JL
         Z32fp18nIFftHY8DaDBEUqQMgeofzKiFUXx+yf97nmoKGPjyZaFsMx5FIB+zRJf/hYrw
         K4Nj5CL9sgg2scb70wQ4rR/z5h1FBkxDEFtHwqGI5UejKvpPM+Ds1378MzVbil+0QFLV
         Y6bk+UojhWTiy72vBt3Rh1sHx4enwF2wphEINo7zUhT+NvLpUJ0mrhr3OqDu/uC0zlXw
         S6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=3X/0Bz3TcQZxyw6b50mGF0nqME1lbTMZ6NdXCIyuzXo=;
        b=CDbrtN9T7m+SCovhOrX7c2CFN8K6Ns+22vFq2f5TkatatfEbf3bf8lP0jiMq3XFTwX
         aum4GuN2j1tTB879AGxC/MUcs7q2HUvTAiWxrAyXc8yncO/S63rhRgr3YHcpnH8YF55C
         LaBDn4UZDD7bBbRTNVkpR1KOj1c/K3Lbhk4+XJfwtizfBQeUO0gROeNljcsTp/cKR+62
         x8S8RpIv4FmHraBd6B3Ruwq7hXEnvrqfQlVgesF9smOcm9nlbjdImdWzFWlSE90efOMm
         du5bRT25UUv9XiUqzeurrnqL8IjyWsY9PjsXMidyOXoCGv9I1OdCszgieCMjTXIMinhs
         xHuw==
X-Gm-Message-State: AOAM531K/jIOqf+dKjsTSrER/E3Imgx65quYijVnP2wHOyazSw1TmvWC
        sOx9E4fr40b1dj48tfZnO2479g==
X-Google-Smtp-Source: ABdhPJyB4cN2SQ746UTsS+Xi6Z7GvzTowSRdy7xGGerq+PyWppLS9px3PcMBGb8R1+fOpatPI35AOw==
X-Received: by 2002:adf:f3ce:: with SMTP id g14mr4678787wrp.95.1632400105910;
        Thu, 23 Sep 2021 05:28:25 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q7sm5249401wru.56.2021.09.23.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 05:28:25 -0700 (PDT)
References: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.6.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, narmstrong@baylibre.com
Subject: Re: [PATCH 0/6] clk: meson8b: video clock tree fixes and making it
 mutable
Date:   Thu, 23 Sep 2021 14:28:12 +0200
In-reply-to: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
Message-ID: <1jbl4jscgn.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 14 Jul 2021 at 01:25, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The first two patches in this series are small fixes before we can
> actually make the video clock tree mutable. One patch adds
> CLK_SET_RATE_NO_REPARENT for better rate control and the other adds
> a missing clock gate.
>
> The third and fourth patch are targeting the HDMI PLL. Add the known
> working M/N combinations. Also this PLL has some special "doubling"
> setting, which is calculated like this:
>   OUTPUT = (IN * M / N + FRAC) * 2
> Since not all register bits are known we use a copy of the 2970/2975MHz
> magic register values from the vendor driver.
>
> The fifth patch makes the clocks in the video clock tree mutable. The
> final patch in this series exports the clocks needed for rate control.
>
> For reference, this is the .dts definition for the Meson8b VPU. The
> code for the VPU driver is unfortunately not ready for upstreaming yet.
> However, I have tested with all resolutions my monitor supports and the
> clock settings are all applied correctly.
>     vpu: vpu@100000 {
>       compatible = "amlogic,meson8b-vpu";
>
>       reg = <0x100000 0x10000>;
>       reg-names = "vpu";
>
>       interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
>
>       amlogic,canvas = <&canvas>;
>       amlogic,hhi-sysctrl = <&hhi>;
>
>       /*
>        * The VCLK{,2}_IN path always needs to derived from
>        * the CLKID_VID_PLL_FINAL_DIV so other clocks like
>        * MPLL1 are not used (MPLL1 is reserved for audio
>        * purposes).
>        */
>       assigned-clocks = <&clkc CLKID_VCLK_IN_SEL>,
>                         <&clkc CLKID_VCLK2_IN_SEL>;
>       assigned-clock-parents = <&clkc CLKID_VID_PLL_FINAL_DIV>,
>                                <&clkc CLKID_VID_PLL_FINAL_DIV>;
>
>       clocks = <&clkc CLKID_VPU_INTR>,
>                <&clkc CLKID_HDMI_INTR_SYNC>,
>                <&clkc CLKID_GCLK_VENCI_INT>,
>                <&clkc CLKID_HDMI_PLL_HDMI_OUT>,
>                <&clkc CLKID_HDMI_TX_PIXEL>,
>                <&clkc CLKID_CTS_ENCP>,
>                <&clkc CLKID_CTS_ENCI>,
>                <&clkc CLKID_CTS_ENCT>,
>                <&clkc CLKID_CTS_ENCL>,
>                <&clkc CLKID_CTS_VDAC0>;
>       clock-names = "vpu_intr",
>                     "hdmi_intr_sync",
>                     "venci_int",
>                     "tmds",
>                     "hdmi_tx_pixel",
>                     "cts_encp",
>                     "cts_enci",
>                     "cts_enct",
>                     "cts_encl",
>                     "cts_vdac0";
>
>       resets = <&clkc CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_PRE>,
>                <&clkc CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_POST>,
>                <&clkc CLKC_RESET_VID_DIVIDER_CNTL_SOFT_RESET_PRE>,
>                <&clkc CLKC_RESET_VID_DIVIDER_CNTL_SOFT_RESET_POST>;
>       reset-names = "vid_pll_pre",
>                     "vid_pll_post",
>                     "vid_pll_soft_pre",
>                     "vid_pll_soft_post";
>
>       power-domains = <&pwrc PWRC_MESON8_VPU_ID>;
>
>       nvmem-cells = <&cvbs_trimming>;
>       nvmem-cell-names = "cvbs_trimming";
>
>       #address-cells = <1>;
>       #size-cells = <0>;
>
>       #sound-dai-cells = <0>;
>       sound-name-prefix = "HDMITX";
>
>       /* CVBS VDAC output port */
>       cvbs_vdac_port: port@0 {
>         reg = <0>;
>       };
>
>       /* HDMI-TX output port */
>       hdmi_tx_port: port@1 {
>         reg = <1>;
>
>         hdmi_tx_out: endpoint {
>           remote-endpoint = <&hdmi_tx_in>;
>         };
>       };
>     };
>
>
> Martin Blumenstingl (6):
>   clk: meson: meson8b: Use CLK_SET_RATE_NO_REPARENT for vclk{,2}_in_sel
>   clk: meson: meson8b: Add the vid_pll_lvds_en gate clock
>   clk: meson: meson8b: Add the HDMI PLL M/N parameters
>   clk: meson: meson8b: Initialize the HDMI PLL registers
>   clk: meson: meson8b: Make the video clock trees mutable
>   clk: meson: meson8b: Export the video clocks
>
>  drivers/clk/meson/meson8b.c              | 163 +++++++++++++++++------
>  drivers/clk/meson/meson8b.h              |  26 ++--
>  include/dt-bindings/clock/meson8b-clkc.h |  10 ++
>  3 files changed, 143 insertions(+), 56 deletions(-)

Applied, Thx
