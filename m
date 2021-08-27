Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F353F9DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbhH0RUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhH0RT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:19:59 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA62C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:19:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so8766528otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LUINJeVF8Mv+Qni9gSoxQ0tMUJKZ5DY+dY1yDHy05KU=;
        b=wXzAoFu3YPB/qKtRMuy9NS/vw+iY8qqKSMhL91DwkH3fx1VFILrLHQtvDJmfVw/vWt
         u0Gmea/jMmYkBs0l2KLAt0hNR6cljTmPyyig+3a8NslpVjwrpPlq/V5HKevdiWunMVAL
         5dYm2M2SZOdSfBVuIJwiptec/K/PECRi7UdwO+40h2rvwcR4JLB8PISkchwuwfkkmICf
         LMlN97nC/yJnI43xCuUk2ZX2f3sSe5el182ghH6U7YLnuVBQgALrCZERCZN1HTeZtCLz
         gE/n61OXCM0PdihuljqD6O/yjb8PoVAPYXmmW+ePkLzJ1THBUJhVV9Td6wGBA/sa2z1B
         Wjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LUINJeVF8Mv+Qni9gSoxQ0tMUJKZ5DY+dY1yDHy05KU=;
        b=ehRCNX9eecRhfpm3ICX351lZ6S6kSM4uZQq7kx8AeGT3DJwZBr9DAPEd4HfYF8PqSJ
         01aQp0QdwaL5fAGPwApLjAj6Hbm6LSMeUDyl+PpisU/625puRQDRamQ1J5sCcQT99noo
         NVaF7D8Kaj6Z2IrNfbQ+2YS3Pk+0MdWJLfW90h7fmgp4lvGH5ijEn87+5ued9Awsk463
         6iAUNQJS0EsPqibsweJzRKb/LA/JMxS8y0x3W4mJMMVPu5r+zwuniOqftlRL4OC24Dd3
         zodiA0NVjcWlmLoTgsSS8RtD5/410nrQQj5xYEtMsnFByPB8xcSw/aypTr65WhF8nliy
         0m0w==
X-Gm-Message-State: AOAM5314p1lfqiY7hyxXXwrqpf2SfN+A8cHixpc1c3wZUgP43wmtCFtd
        HziktlXVFdWAjhGSInzVS5B2NA==
X-Google-Smtp-Source: ABdhPJzpZGHJr2Nwej0U+Rd/3Jh75eu1bT9hRrxL9fP6KKzmFMhs9Syiz/V9cJhMDnuwNkWiUOuqsQ==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr9064499ots.169.1630084750178;
        Fri, 27 Aug 2021 10:19:10 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m20sm1461021oiw.46.2021.08.27.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:19:09 -0700 (PDT)
Date:   Fri, 27 Aug 2021 10:20:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, mkrishn@codeaurora.org,
        kalyan_t@codeaurora.org, rajeevny@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: fix display port phy base
 address offset
Message-ID: <YSke10cPLS9QlKKZ@ripper>
References: <1630083316-2028-1-git-send-email-khsieh@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630083316-2028-1-git-send-email-khsieh@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Aug 09:55 PDT 2021, Kuogee Hsieh wrote:

So the order was mixed up, 0x088eaa00 got the wrong length and you got
one hardware block too many in there?

> Fixes: 9886e8fd8438 ("arm64: dts: qcom: sc7280: Add USB related nodes")
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index c29226b..77b0b4e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2918,15 +2918,11 @@
>  			dp_phy: dp-phy@88ea200 {
>  				reg = <0 0x088ea200 0 0x200>,
>  				      <0 0x088ea400 0 0x200>,
> -				      <0 0x088eac00 0 0x400>,
> +				      <0 0x088eaa00 0 0x200>,
>  				      <0 0x088ea600 0 0x200>,
> -				      <0 0x088ea800 0 0x200>,
> -				      <0 0x088eaa00 0 0x100>;
> +				      <0 0x088ea800 0 0x200>;
>  				#phy-cells = <0>;
>  				#clock-cells = <1>;
> -				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> -				clock-names = "pipe0";
> -				clock-output-names = "usb3_phy_pipe_clk_src";

This is not "base address offset", please fix $subject.


Looking at this makes me feel that the dp-phy node was copy-pasted from
the usb3-node and that this patch corrects a copy-paste issue. Seems
like this would be an excellent thing to write in a commit message.

Thanks,
Bjorn

>  			};
>  		};
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
