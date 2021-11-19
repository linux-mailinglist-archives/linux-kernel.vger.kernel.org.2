Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6B45689D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhKSDbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhKSDbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:31:47 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7287C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 19:28:46 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 7so18998508oip.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 19:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p1xy63IUl/Zv0PIf7COklDb5zOeRlbnYu9be+9CWGNk=;
        b=NhmhbluVJs6Q/MrYeRAGnfV+aZfk5hz5blLNcJjb+u83bIjcKfqAk9EbgGWKI/FaQi
         Ctra+xHwl6/iw18TobZFuDcGWHNUBLdvWY77LNw7Ty8wh6keFf7t4gJianKTEsQO8+AG
         BPT1/SDAi6r+3uoG2AgWQmBBbIx13w4Mz1jWMBj1UcmmrbpwLVgR3YYjfsmC8ROvUN2s
         Ih7l9rz9W//T7Gjg5oLoc++Ci2zcHUuCROFCEXem+6Cu+h/EEuqGpTYjYht+thM5GsSg
         oKnQP9TejCubjrrKzgPl/CxccMmEwfrssSlk+PA/AOSWn+ovyCDM40oDPp8rR80tMjLU
         LVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1xy63IUl/Zv0PIf7COklDb5zOeRlbnYu9be+9CWGNk=;
        b=Glqjg83w0PShFFfg+9YkjqgkTbT2TJfumyfp/Ls7fMtAT0nugpgtvMagduomcUacOl
         J6BOvfNGw9khtt/yvT9ZVANJOTGeRnh2S01OLQaV2m4pMu5jWKmpIlob3JTEBrOKP9qh
         3m2SSENzhkfCRXbJeLn8IEot7Jl43eK8/QCM0ZHRqvH+WBBcI+fTzZPyWjafGt1oVXBe
         Wvlv3B5M9j+ynJzc7VG8wRlabvkjBGzdMCMQbyeCWzGbA0DV+sDa4XIfOY4OhJq8+1yd
         a6cTEUXSywwnAf6y7S2teN3hmoMykaM74ZbbyFme2WLok/31Y6VvPjHV9HMM/9UM9KuO
         xqpQ==
X-Gm-Message-State: AOAM531GI/fNwPrv5fONU3v8NlKQEPkv/mNn86Wzk82/gB1vu/i3ixfI
        qzD3fGvFLCuIyP/nf6Eba7N57w==
X-Google-Smtp-Source: ABdhPJwtN2UQEZzwjWTNFXV41e43OT3M+FUOxZ10yafWkd4x+SkxkOM2f1tFpQzAQ9LoiwOIYsZmOw==
X-Received: by 2002:a05:6808:2392:: with SMTP id bp18mr2054511oib.89.1637292526174;
        Thu, 18 Nov 2021 19:28:46 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r23sm341825ooj.37.2021.11.18.19.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 19:28:45 -0800 (PST)
Date:   Thu, 18 Nov 2021 21:28:40 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     swboyd@chromium.org, agross@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org,
        mka@chromium.org, lorenzo.pieralisi@arm.com, svarbanov@mm-sol.com,
        bhelgaas@google.com
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sc7280: Fix incorrect clock name
Message-ID: <YZcZ6O4DxUUNothC@builder.lan>
References: <1637060508-30375-1-git-send-email-pmaliset@codeaurora.org>
 <1637060508-30375-2-git-send-email-pmaliset@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637060508-30375-2-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16 Nov 05:01 CST 2021, Prasad Malisetty wrote:

> Replace pcie_1_pipe-clk clock name with pcie_1_pipe_clk
> To match with dt binding.
> 
> Fixes: ab7772de8612 ("arm64: dts: qcom: SC7280: Add rpmhcc clock controller node")
> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> Reported-by: kernel test robot <lkp@intel.com>

This says "lkp reported an issue and this patch fixes that issue", but
looking back I think you picked up this tag because lkp had problems
building v1 of this patch.

I will drop it while applying the patch and I will remove the empty line
between Fixes and your S-o-b.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 365a2e0..cb94b87 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -576,7 +576,7 @@
>  				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
>  				 <0>, <0>, <0>, <0>, <0>, <0>;
>  			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
> -				      "pcie_0_pipe_clk", "pcie_1_pipe-clk",
> +				      "pcie_0_pipe_clk", "pcie_1_pipe_clk",
>  				      "ufs_phy_rx_symbol_0_clk", "ufs_phy_rx_symbol_1_clk",
>  				      "ufs_phy_tx_symbol_0_clk",
>  				      "usb3_phy_wrapper_gcc_usb30_pipe_clk";
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
