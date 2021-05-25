Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E769F390ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 22:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhEYU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 16:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhEYU5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 16:57:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F99CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:56:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so13891125pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=91aOLjLOV4EvSQjlx7WDHxBtcvj99jQ/NNVeSBz/LR8=;
        b=SD6SE/S44SruFRZLV/S/Bz9AlF/4DqqOZ6559WXOx8wJNzifYZ6vFNIT8eK5kSUyJI
         9HM6eFv0RxXbU63236c+idQuQsQU0l2JfXnrmfpvNoDvC+zaK27O8WZ2BC+E8+1fiXX5
         f6dLjJsW3VS9pkr0LZ/UIW2poRMA7f+QxDuh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91aOLjLOV4EvSQjlx7WDHxBtcvj99jQ/NNVeSBz/LR8=;
        b=g4piYUvJPRPNRFq5ZinZVsrC/86MRw3x2KUOKrgYeRigCjwgFG0mu5XxXCj4PmUjAN
         NkAHDUOOqv4rH4+X37FoHq/jGhiHvTXzZlCtzGvabZqpAxyYzof7MUkDdlYgUBobppTu
         ZKA8LTEcn8VS9vJ+s89UtNvJVEs5OBpkJ/SajtW/HuKBk9GnPlLkOX1VGgZ6yf7hCE0I
         em4QJ1vEUVmK5iQQNO3WxcilHpEeJMxLT0UgcgeydUH9YA3WNfOnZpdkSvxCFJwPhhhQ
         0WjfovXMz0trMETtHyf4cmMRR+NNL/+t4ijNY+z+7erRFbQ+ZuFAY2H3WTtk/x9ceGHY
         3yQw==
X-Gm-Message-State: AOAM530stSq2Zs44QMkxCNdCrhyVxLdCITaLZoWC4O8DGojyy66JG3r+
        /K512POMeiKfHxCaQKFtj2xIsw==
X-Google-Smtp-Source: ABdhPJxfZZ00b35rksF0AdJnfrSx7yvhNI3vqnFAhoUBVlmc6AM5IYHREtdk/eqhBudxNVGsLhduJA==
X-Received: by 2002:a17:902:edc6:b029:ef:8d62:db4e with SMTP id q6-20020a170902edc6b02900ef8d62db4emr32176561plk.7.1621976179728;
        Tue, 25 May 2021 13:56:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ab0:bbc9:a71:2916])
        by smtp.gmail.com with UTF8SMTPSA id g15sm13618771pfv.127.2021.05.25.13.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 13:56:19 -0700 (PDT)
Date:   Tue, 25 May 2021 13:56:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V5 06/11] arm64: dts: qcom: pmr735a: Correct the GPIO node
Message-ID: <YK1kcVj9iyekNnrj@google.com>
References: <1621937466-1502-1-git-send-email-skakit@codeaurora.org>
 <1621937466-1502-7-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1621937466-1502-7-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 03:41:01PM +0530, satya priya wrote:
> Add gpio ranges and correct the compatible to add
> "qcom,spmi-gpio" as this pmic is on spmi bus.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V5:
>  - This is split from patch [5/11] and added newly in V5.

actually it's a split from patch [5/8], right?

https://patchwork.kernel.org/project/linux-arm-msm/patch/1621318822-29332-6-git-send-email-skakit@codeaurora.org/

>  arch/arm64/boot/dts/qcom/pmr735a.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmr735a.dtsi b/arch/arm64/boot/dts/qcom/pmr735a.dtsi
> index b0a7cd6c0..b4b6ba24 100644
> --- a/arch/arm64/boot/dts/qcom/pmr735a.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmr735a.dtsi
> @@ -21,9 +21,10 @@
>  		};
>  
>  		pmr735a_gpios: gpio@8800 {
> -			compatible = "qcom,pmr735a-gpio";
> +			compatible = "qcom,pmr735a-gpio", "qcom,spmi-gpio";
>  			reg = <0x8800>;
>  			gpio-controller;
> +			gpio-ranges = <&pmr735a_gpios 0 0 4>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
