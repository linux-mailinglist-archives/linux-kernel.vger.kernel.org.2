Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36C39CC96
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 05:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFFDv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 23:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFDv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 23:51:57 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE537C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 20:49:57 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so13306234oth.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4rqhGjnDlpC1oNukvP0eTeh77UaYLbqMMQo6bxEo8l0=;
        b=DaHACcopN32+0wLXCuZjlfPuqdZ+qlJPu68BA/6gxWPWGQ1YVqHyEftSobGd3QGl8S
         JKM4Qk101Um4jiTzKiRR/IigX1KkfJ3eKQeddtRXJjOP7m+g2hrOFNQqHyZ2IgFdG6xM
         Vsf/A3C1qpIu5cSaVwY+XF4eob71fEfPu0bl/M03Hh+0k23LrsJclZVSto2bGivuFRN2
         RvCzeG4aH/nKKPtJPoJgTyJ1zSUqAql1CPSdWmnMeXtcC9G1VgB+xoe+l7w9aydKGAw9
         MdfpTuuF6F8q9Yi3xAzxYIvuZCD/UqZoKNzGr3T4eXlrZGb+VnOHD6MygVHNjSjZNKmM
         Rwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4rqhGjnDlpC1oNukvP0eTeh77UaYLbqMMQo6bxEo8l0=;
        b=fNWD8f3n6DWbshFWMo1ZP7ANxvbE/NbOVFON6N6cowXJnk0qC3j/8cMO0z+c5ALDes
         MqN0PXeY51NX+Q34n8uAJtZH878pH565Qsyt8TJydhyirz0lcgLmlFmRbbE5xIamgqzl
         UHMKxmWdOj4UC1OhdJcEtLtckikm7WUo6gIrp5lVs6ASlrEWydp3BGQgvdaKck9yqQ0x
         ivG+k8SEkTLmrqkprBQr312fEmxBKpspZjw4htAdSMe5VrRAIzDaVZlDOkkU811SdYMH
         CqfEnmRZYHvt6ipngZwVnSfNcIOGUF/9un6n8+wgoCHED+Kpe7yIr8qRHhx4FCFB68pO
         PKiw==
X-Gm-Message-State: AOAM532UrlnJwwFKK3i57vOuePWWjY9ltvp4bG4wA5ryLiNAdap5IuPd
        T2YNfa8UbzZTtpNTp7W28YBq3w==
X-Google-Smtp-Source: ABdhPJzr9Ti3c1odUbilk5W5+gzqQrUKOyFr3FdZNtNWxEB2/vX/u2LcvU2DIX9ITYtMFlm7+l6U9g==
X-Received: by 2002:a05:6830:1d64:: with SMTP id l4mr8940386oti.95.1622951397192;
        Sat, 05 Jun 2021 20:49:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a24sm1466630otr.3.2021.06.05.20.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 20:49:56 -0700 (PDT)
Date:   Sat, 5 Jun 2021 22:49:54 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V3 2/3] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
Message-ID: <YLxF4rGFDrFXQRDi@builder.lan>
References: <20210604135439.19119-1-rojay@codeaurora.org>
 <20210604135439.19119-3-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604135439.19119-3-rojay@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Jun 08:54 CDT 2021, Roja Rani Yarubandi wrote:

> Add QUPv3 wrapper_0 DT nodes for SC7280 SoC.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> ---
> Changes in V3:
>  - Broken the huge V2 patch into 3 smaller patches.
>    1. QSPI DT nodes
>    2. QUP wrapper_0 DT nodes
>    3. QUP wrapper_1 DT nodes
> 
> Changes in V2:
>  - As per Doug's comments removed pinmux/pinconf subnodes.
>  - As per Doug's comments split of SPI, UART nodes has been done.
>  - Moved QSPI node before aps_smmu as per the order.
> 
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts |  97 ++-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi    | 750 +++++++++++++++++++++++-
>  2 files changed, 835 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index d0edffc15736..f57458dbe763 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -292,6 +292,16 @@ &uart5 {
>  	status = "okay";
>  };
>  
> +&uart7 {
> +	status = "okay";
> +
> +	/delete-property/interrupts;
> +	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> +				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7280.dtsi */
>  
>  &qspi_cs0 {
> @@ -307,16 +317,87 @@ &qspi_data01 {
>  	bias-pull-up;
>  };
>  
> -&qup_uart5_default {
> -	tx {
> -		pins = "gpio46";

Commit message says "add stuff", but somehow uart5 is no longer
gpio46/47 and these gpios are no longer specified.

Can you roll this in a way where the giant patch actually _only_ adds
a whole bunch of stuff?

> -		drive-strength = <2>;
> -		bias-disable;
> +&qup_uart5_tx {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +

Regards,
Bjorn
