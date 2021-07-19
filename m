Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9113CEE38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 23:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378347AbhGSU12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 16:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358447AbhGSTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:30:17 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B2C0617AB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 13:03:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so19403171otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hFPa6LKCCsAi4pnEWUZRJHSePic1qLgoGWAT29y7mbQ=;
        b=B50oKeFaBToKnH3uGmW30PKmcFxUGAj84V61Ai49IRKwWCd7XZoEddu02tdDNRTaHs
         HEw8sl334Pefjg0RKRqDf/4CWMUW+lHdNJB5bM/vRHSLBlw5gQ0RCY5P38YYCV9pPID4
         naGuZCNfJXgnzfqsqWgc3j1bViXoF1ggGk8AYQYPV/oO8fNVv2okAiZI3semYtnvbfhY
         1oTA6Nu6eWfmQO63X/UH/M91UFJrsoIfM25YTxdZx1tf3PMXpAcrExD7TSFjy5Pv2sPH
         FL0mcfVIh3vPAU/fVLvMsL+pWYrHgzh6TBqAXTIDpfmhL+Yo96T6t8Yxgtm6ASkkRAt/
         N0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFPa6LKCCsAi4pnEWUZRJHSePic1qLgoGWAT29y7mbQ=;
        b=iwjBO4KebQo1V5bvCANWEHT3Vr2ANwxcDuRSLApX9ii9nOk8/8o1y8ZIMJh+L7f5yu
         Amd5EoK0P4Hai7Z8cBagaShszFn/nzTLk1vCRHbIRB8IEIjnLtXT7Rw84i2UDMWqAZs4
         m0DtNnivs3+MaaztVrYI7y1tXei1adAKQYOEypEAYsXjkOvgB8KZIlBJOjX4sd3/7hnf
         czlTmvgOs3tLKm7hL2tnALv3nifMCk8aYMsLjDtzh1vmRnr0NSYzeLChv4l44gxQsLWk
         SaTYC7U61HnFplSXmuiDdiXSYXlABC9Q0js7QaFYMdIGumTNdsrZY2gUwJa5c85IclAF
         PtXg==
X-Gm-Message-State: AOAM533D8iDt9ESBlq+kp8qI85ULyQhQ50nJu4awZRB0LL+BmktleM/q
        2p81trvPY9lD1H0LRmP87RDRdA==
X-Google-Smtp-Source: ABdhPJy4mniYgstiy7JKHYbjfck2EpL67lUFZ04xoUq4ZKKRq8KqVQ9l9zL54JDVhRSJeVH5nWkP8Q==
X-Received: by 2002:a05:6830:1e84:: with SMTP id n4mr15951300otr.210.1626725318216;
        Mon, 19 Jul 2021 13:08:38 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x29sm3534020ooj.10.2021.07.19.13.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 13:08:37 -0700 (PDT)
Date:   Mon, 19 Jul 2021 15:08:35 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     rojay@codeaurora.org
Cc:     Stephen Boyd <swboyd@chromium.org>, robh+dt@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        rajpat@codeaurora.org
Subject: Re: [PATCH V3 1/3] arm64: dts: sc7280: Add QSPI node
Message-ID: <YPXbw6a4+B5TBD0W@yoga>
References: <20210604135439.19119-1-rojay@codeaurora.org>
 <20210604135439.19119-2-rojay@codeaurora.org>
 <YLxHTDxVcSvVxsd5@builder.lan>
 <98befc79fc039496b0c12d7983319c92@codeaurora.org>
 <2ad7a00924b5065bf61c47e8b6d24339@codeaurora.org>
 <CAE-0n51NfHSwRQvG0HnTcHBkv=Huy-CXEwJCxLG03MN3dSe5kA@mail.gmail.com>
 <498a2359eec36c6a0b811337ee187df8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498a2359eec36c6a0b811337ee187df8@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Jul 02:47 CDT 2021, rojay@codeaurora.org wrote:

> On 2021-07-09 06:26, Stephen Boyd wrote:
> > Quoting rojay@codeaurora.org (2021-07-06 02:19:27)
> > > On 2021-06-08 13:37, rojay@codeaurora.org wrote:
> > > > On 2021-06-06 09:25, Bjorn Andersson wrote:
> > > >> On Fri 04 Jun 08:54 CDT 2021, Roja Rani Yarubandi wrote:
> > > >>
> > > >>> Add QSPI DT node for SC7280 SoC.
> > > >>>
> > > >>> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> > > >>> ---
> > > >>> Changes in V3:
> > > >>>  - Broken the huge V2 patch into 3 smaller patches.
> > > >>>    1. QSPI DT nodes
> > > >>>    2. QUP wrapper_0 DT nodes
> > > >>>    3. QUP wrapper_1 DT nodes
> > > >>>
> > > >>> Changes in V2:
> > > >>>  - As per Doug's comments removed pinmux/pinconf subnodes.
> > > >>>  - As per Doug's comments split of SPI, UART nodes has been done.
> > > >>>  - Moved QSPI node before aps_smmu as per the order.
> > > >>>
> > > >>>  arch/arm64/boot/dts/qcom/sc7280-idp.dts | 29 ++++++++++++
> > > >>>  arch/arm64/boot/dts/qcom/sc7280.dtsi    | 61
> > > >>> +++++++++++++++++++++++++
> > > >>>  2 files changed, 90 insertions(+)
> > > >>>
> > > >>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> > > >>> b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> > > >>> index 3900cfc09562..d0edffc15736 100644
> > > >>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> > > >>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> > > >>> @@ -268,6 +268,22 @@ pmr735b_die_temp {
> > > >>>             };
> > > >>>  };
> > > >>>
> > > >>> +&qspi {
> > > >>> +   status = "okay";
> > > >>> +   pinctrl-names = "default";
> > > >>> +   pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data01>;
> > > >>> +
> > > >>> +   flash@0 {
> > > >>> +           compatible = "jedec,spi-nor";
> > > >>> +           reg = <0>;
> > > >>> +
> > > >>> +           /* TODO: Increase frequency after testing */
> > > >>> +           spi-max-frequency = <25000000>;
> > > >>> +           spi-tx-bus-width = <2>;
> > > >>> +           spi-rx-bus-width = <2>;
> > > >>> +   };
> > > >>> +};
> > > >>> +
> > > >>>  &qupv3_id_0 {
> > > >>>     status = "okay";
> > > >>>  };
> > > >>> @@ -278,6 +294,19 @@ &uart5 {
> > > >>>
> > > >>>  /* PINCTRL - additions to nodes defined in sc7280.dtsi */
> > > >>>
> > > >>> +&qspi_cs0 {
> > > >>> +   bias-disable;
> > > >>> +};
> > > >>> +
> > > >>> +&qspi_clk {
> > > >>> +   bias-disable;
> > > >>> +};
> > > >>> +
> > > >>> +&qspi_data01 {
> > > >>> +   /* High-Z when no transfers; nice to park the lines */
> > > >>> +   bias-pull-up;
> > > >>> +};
> > > >>> +
> > > >>>  &qup_uart5_default {
> > > >>>     tx {
> > > >>>             pins = "gpio46";
> > > >>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > >>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > >>> index 6c9d5eb93f93..3047ab802cd2 100644
> > > >>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > >>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > >>> @@ -1061,6 +1061,42 @@ apss_merge_funnel_in: endpoint {
> > > >>>                     };
> > > >>>             };
> > > >>>
> > > >>> +           qspi_opp_table: qspi-opp-table {
> > > >>
> > > >> This node doesn't represents anything on the mmio bus, so it shouldn't
> > > >> live in in /soc. Can't you move it into &qspi?
> > > >>
> > > >> Regards,
> > > >> Bjorn
> > > >>
> > > >
> > > > Sure, will move it into qspi node.
> > > >
> > > > Thanks,
> > > > Roja
> > > >
> > > 
> > > Hi Bjorn,
> > > 
> > > Moving "qspi_opp_table" inside &qspi node causing this warning:
> > > arch/arm64/boot/dts/qcom/sc7280.dtsi:1055.35-1072.6: Warning
> > > (spi_bus_reg): /soc@0/spi@88dc000/qspi-opp-table: missing or empty reg
> > > property
> > 
> > If DT folks are OK I think we should hard-code 'opp-table' as not a
> > device for spi to populate on the spi bus and relax the warning in the
> > devicetree compiler (see [1] for more details). Technically, nodes that
> > are bus controllers assume all child nodes are devices on that bus.  In
> > this case, we want to stick the opp table as a child of the spi node so
> > that it can be called 'opp-table' and not be a node in the root of DT.
> > 
> > > 
> > > Shall I keep the qspi-opp-table out of &qspi node?
> > > 
> > 
> > If you do, please move it to / instead of putting it under /soc as it
> > doesn't have an address or a reg property.
> > 
> 
> Hi Bjorn, Rob
> 
> Can we move this "qspi_opp_table" to / from /soc?
> 

If you have made a proper attempt to convince Rob and Mark that
a child "opp-table" in a SPI master is not a SPI device - and the
conclusion is that this is not a good idea...then yes it should live
outside /soc.

Thanks,
Bjorn
