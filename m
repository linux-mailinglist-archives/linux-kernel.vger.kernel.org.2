Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E232515A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhBYONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:13:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:12:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l18so3604247pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GMOL6t7R90m1YjNMvzNaAx8OO1Vls01hdT/x95akk+E=;
        b=I45e4+U5quZf5PQzcnvraTrJW8AbgCPDe7OBFCYOIsBHatTNjM0MIhEoBoCwOMUoz4
         RmETgd2L8OHwu7+A+yX2ESx7xAApIIHNjvq0dcBYyKuOhvMna+dHIjgZhIAJco1SLDHK
         wEwIROMCBJzhbuyOyDMPkBn6Qlqn6pR98lpYcEKwn6VBQFaCGktFdw7BUEHYrl5oXuW5
         CoUrPZIa9HVNWzu89EE5UrOVMY3Pua1pvYM/tSA7V0baAJiv7KR5IbNzYsUcCKqxHhM8
         I+RJrS32CewUUy0QqEE1FtyTykUompfQxE8ChhIzPZ7MlL3dzq9KW0wGUU3ojfQnkYMT
         3xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GMOL6t7R90m1YjNMvzNaAx8OO1Vls01hdT/x95akk+E=;
        b=BdcITQLu8EvwBuIOSCbg3mYZfAwcX4cOL8KVvwrwW7tNF0T9lx6RksPOgFSq4FItAC
         G66gjVLjOu5oi9EiOOBbeVDbDhBhgq1C/pFSQW687zh3FKccvjO5bHXf7fooOJvG65q7
         QaR0/N5A6ydQcpyO5ryYKyRwFP9Y6jZADZs1lwfak3SK43W+JrioH6pQEtbrN/Ns4lpU
         OyQ6tmqYEL8If+WJFGSzvxmEoof/lBZEl/ueE6UjWJ+wZ/G4q1rc4ZlnrIksDlYXSWhr
         ezvNQ6tJ+Cew/daM9SnY/KnQSjKeQk+y7UIzGOc0jm6dsq0Llqm1ZTPEqRaExoRpUU0L
         IeYg==
X-Gm-Message-State: AOAM532UgRNAIhOwZ+9aIZriA8raQpAj4l5USD+DoZDGT85ZGcvXJaW/
        aKbt8v2FONVXGVcdFxyVxZon
X-Google-Smtp-Source: ABdhPJygSPJLagFdSX5cPU1rx+FVNPi9uj2jyKvPqjWV3auR3u5SBQjajbsMeMxZ7tFwKd9tbqkHgA==
X-Received: by 2002:a17:902:690a:b029:e3:9fd1:a0d8 with SMTP id j10-20020a170902690ab02900e39fd1a0d8mr3097955plk.17.1614262344310;
        Thu, 25 Feb 2021 06:12:24 -0800 (PST)
Received: from work ([103.66.79.45])
        by smtp.gmail.com with ESMTPSA id r15sm6709437pfh.97.2021.02.25.06.12.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Feb 2021 06:12:23 -0800 (PST)
Date:   Thu, 25 Feb 2021 19:42:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 5/9] arm64: dts: qcom: sc7280: Add IPCC for SC7280 SoC
Message-ID: <20210225141219.GB28614@work>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org>
 <2e51420bf293e6e82a056a743e5a95f2cc70104c.1614244789.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e51420bf293e6e82a056a743e5a95f2cc70104c.1614244789.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 03:00:21PM +0530, Sai Prakash Ranjan wrote:
> Add the IPCC DT node which is used to send and receive IPC
> signals with remoteprocs for SC7280 SoC.
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index aeeb47c70c3a..65c1e0f2fb56 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
>  / {
> @@ -315,6 +316,15 @@ gcc: clock-controller@100000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		ipcc: mailbox@408000 {
> +			compatible = "qcom,sc7280-ipcc", "qcom,ipcc";
> +			reg = <0 0x00408000 0 0x1000>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#mbox-cells = <2>;
> +		};
> +
>  		qupv3_id_0: geniqup@9c0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0 0x009c0000 0 0x2000>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
