Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB64373195
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhEDUn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhEDUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:43:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430CDC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:42:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i190so164051pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/TP/ojOa/Ek6gW+uOcPmzMHCY03xC5sD9r+Tt7fvvPk=;
        b=FbCaQGqadb0WL3M5ebZa60H4dgsKFNigUohUSMJpShBJbcFoY+foepgohNE63oLsuc
         e0jxmlcQgwqV71kH8tZegDwRcjNOn+yeotl3Wv0ioIOmEsp80YEDTmW/bqEvsG4N0G2F
         ZGJkKSJH+mjgHSAw7hNWxzlUTJv0B5ulKxpkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/TP/ojOa/Ek6gW+uOcPmzMHCY03xC5sD9r+Tt7fvvPk=;
        b=TGiWyTusLh7ThAeK8JVWntDAMpsk2tLMwcMQXDdN+GgfXXuzkza2RW33FZHG27qipb
         wz/0OjeoF5Og/fW6D5OAR3vDAtgfxOhnKCYdbGM0lFMvE79Z6kPzNT3NLyTrz5F24OjW
         WP8HX1p3hc3d3vRSOMhuD/oAWCS5OVGHazi1135/XKEVhXH2f6nDvkqY5NeMz04Roma5
         OW11d8xAPfIbSh3kTkHys5nyrawdARUZAR59Bm4Snpg67HF0W4mhc/80gXR34ZoeY+6r
         hTIrX0cRivR2I49Q/0xJnmMdvw2fS53D18E7wqa9LXnN58Ngyvl/lqeXipbRDqLuqHaM
         IPcg==
X-Gm-Message-State: AOAM5322NWuW1YSJBdkz1v3UH06GRr9s6gUQp8y+z7O0mnEczJmk5J8V
        84IuLMhLWpLywz+HZMU8jNqwAw==
X-Google-Smtp-Source: ABdhPJwZ8maovlt0GmGT150u/qayfs/nvy3E+9zb0XG5DoR8u7YIG1A6I3RCFzaNce9wpv5yV+66vQ==
X-Received: by 2002:a17:90a:bd89:: with SMTP id z9mr30354112pjr.4.1620160947899;
        Tue, 04 May 2021 13:42:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4c2f:1f84:af45:6245])
        by smtp.gmail.com with UTF8SMTPSA id g21sm14589874pjl.28.2021.05.04.13.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:42:27 -0700 (PDT)
Date:   Tue, 4 May 2021 13:42:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc7280: Add USB nodes for IDP
 board
Message-ID: <YJGxsqGzNDbYO++O@google.com>
References: <1620112135-1388-1-git-send-email-sanm@codeaurora.org>
 <1620112135-1388-3-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1620112135-1388-3-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 12:38:55PM +0530, Sandeep Maheswaram wrote:
> Add USB nodes for sc7280 IDP board.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts | 39 +++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 54d2cb3..ff48d21 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -242,6 +242,45 @@
>  	status = "okay";
>  };
>  
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l10c_0p8>;
> +	vdda33-supply = <&vreg_l2b_3p0>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l6b_1p2>;
> +	vdda-pll-supply = <&vreg_l1b_0p8>;
> +};
> +
> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_2_hsphy {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l10c_0p8>;
> +	vdda33-supply = <&vreg_l2b_3p0>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7280.dtsi */
>  
>  &qup_uart5_default {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
