Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6078B405954
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350875AbhIIOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbhIIOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:42:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA5C077580
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 07:06:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oc9so1444795pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L8cDWmvCb4eOy7vGO37SrXUiP73ZTPhnnqWMVCnZKbw=;
        b=HfwNGyoSZrV4f3V7zT2kav9EMAC9qMpLvHk5yVzNXe42jf4uTRlOa7EOuFDEeypemL
         BAedshFTqgxWd0P3C7xWqTMPcxDKu7YU4b13Mqsw5niZauVRS4Hd0DBaoi/9DOy6621h
         MXeqknSlPpHh/p+mvmqmDefBPrrEFb7AIPzyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8cDWmvCb4eOy7vGO37SrXUiP73ZTPhnnqWMVCnZKbw=;
        b=Hu+PIVu9/Iz10GTYUJ4ZcsNsQ7PVLOQ/LavbLadXKwV6q1ZdJsOtOGEoFZCiHMpuoH
         nZaS9NOSxWass7sg7zy3HXhLtkUAo3xPDoDm3dNZzRbHa0a0GItsGEUKWqA3+wlB3FbB
         TePwOdMv3tP+6SAWDX0KKJBmO864awFR6rQ4lmT+4SGJlxRBx82w6+1R28wKLghdZ4jH
         kmTASGHUVhhYazhX2BI3v77bf9MTa2GaRehx/Ppd+ooH2yyAGH+oTA0jZaSrK422R9N4
         yaakYoUD4usBGabvWGY7NkwzQVZVp/Daniy9EvhbUU/w52tIjxqdx1Z/wY0Qv2OFxolE
         +zbg==
X-Gm-Message-State: AOAM533lHiZ7ZCm65j6NAxeBvONlxs01CdF6Ej0/ZZcnLT9TaXRDPyyP
        WwTOxC3AyTQOOxsDrTM+fLsjMLeXhcvXCw==
X-Google-Smtp-Source: ABdhPJziK5kHfyO9p4YECF5ExYztPTeAX5R3q/XOTyZf29rNhAiWZ7bJ7anxKxSntk4vC+pRtcDqlA==
X-Received: by 2002:a17:90b:1085:: with SMTP id gj5mr3775623pjb.66.1631196383841;
        Thu, 09 Sep 2021 07:06:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:27cc:a1d4:ed44:e1de])
        by smtp.gmail.com with UTF8SMTPSA id e5sm2372644pjv.44.2021.09.09.07.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 07:06:22 -0700 (PDT)
Date:   Thu, 9 Sep 2021 07:06:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     rajpat@codeaurora.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH V7 3/7] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
Message-ID: <YToU3RjSB9IDD3Ei@google.com>
References: <1630643340-10373-1-git-send-email-rajpat@codeaurora.org>
 <1630643340-10373-4-git-send-email-rajpat@codeaurora.org>
 <YTJOU/oVWSdxD1uz@google.com>
 <bfdccfc2e4362218fc8099dfe566bc1d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfdccfc2e4362218fc8099dfe566bc1d@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:16:04AM +0530, rajpat@codeaurora.org wrote:
> On 2021-09-03 22:03, Matthias Kaehlcke wrote:
> > On Fri, Sep 03, 2021 at 09:58:56AM +0530, Rajesh Patil wrote:
> > > From: Roja Rani Yarubandi <rojay@codeaurora.org>
> > > 
> > > Add QUPv3 wrapper_0 DT nodes for SC7280 SoC.
> > > 
> > > Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> > > Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 684
> > > ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 682 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index 7ec9871..5c6a1d7 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > 
> > > ...
> > > 
> > > +			qup_spi0_data_clk: qup-spi0-data-clk {
> > > +				pins = "gpio0", "gpio1", "gpio2";
> > > +				function = "qup00";
> > > +			};
> > > +
> > > +			qup_spi0_cs: qup-spi0-cs {
> > > +				pins = "gpio3";
> > > +				function = "qup00";
> > > +			};
> > 
> > 
> > I think we still want this for all SPI ports, which existed in previous
> > versions:
> > 
> > 			qup_spi0_cs_gpio: qup-spi0-cs-gpio {
> > 				pins = "gpio3";
> > 				function = "gpio";
> > 			};
> > 
> > It just shouldn't be selected together with 'qup_spiN_cs'.
> > 
> > Maybe a follow up patch would be good enough, so:
> > 
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
> 
> ok.shall we add qup_spiN_cs_gpio for all spi ports

Yes
