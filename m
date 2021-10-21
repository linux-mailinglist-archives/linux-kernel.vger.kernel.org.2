Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CB435BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJUHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJUHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:39:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE5C061753
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 00:36:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t7so10361777pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nMefmvewH1bH95bhvHE2Njo8TjUqxRvrxWxFSi0K4aQ=;
        b=tnynrcs1C3rrt5B3tGjtk2O0V2SZ8JttjctkOD2WOlr9+JuBf0r3U8/WWxMoePzRtZ
         zaSwLSo95yB81cYRZIENRFqi+SIx7xHJxeTP4t4+0KVBNI2qLUfdt91wLZbEADHWNjPq
         oo++L2+wXvnbWwHRY7ZXdhJf3CDiyYyhs5vPHEfOA79dJW6YcgaS8wIBEC3nxJkFy8P1
         xHuqKe5h8UwahrQ+uWzFiyUVAlzzEIIZ8xiWKHJrQ5qBkdp9BQIpEaJx8TFgy07pyRsF
         OIxAtfKlVOf92khB6wX/8wRMjYVRxrbGN5eTDRLFLHveHHhNi9KHqAHdqPRZeYnRNsIZ
         BN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nMefmvewH1bH95bhvHE2Njo8TjUqxRvrxWxFSi0K4aQ=;
        b=5H0kc7dKQUBEJCypShGtH5AiI9z20TL/NvMMY7Z/hMltTpN1HijOz4UaWKoo9PsLZC
         R5o1MyTWaHjzEolV81hbvhdrYAlkw54Ox92J612ZjTdlq0wbkEvAJSqbwft5/uYReCfX
         f21sL3/p/vZLQ4iXJ3A+nOT3Y+uB0IIHcY0oaSk0LgiEu4HvrhqPVK2jPy52Z881GR9V
         s5zd7wIFCIjMj1TGiRhRs92j7/X6LzdPCBhI6VWZ7QNCkxsubk8tAhQuK1jTHnXqPEAF
         UZh9AjhWYbSDFLUsvAW9ECu38TwAdUJx63lRokztIJ4fZMQFwDBa7qUpKcKD/90UqvIL
         gyVQ==
X-Gm-Message-State: AOAM531e+uh6tG5mHvl27vLq5Fo4AjygK7a0YnQWFheCPU9YHleQ5zWe
        xcv3alzWeVWBnmk0KVDFn00Z
X-Google-Smtp-Source: ABdhPJxWH+Ux9aLgpp+A6wyKXL3yggOtAl+kwvYgqfoYXoaVAofNqEn2lz8VRoFexW77upLfB3zdjA==
X-Received: by 2002:a63:f145:: with SMTP id o5mr3228923pgk.273.1634801812729;
        Thu, 21 Oct 2021 00:36:52 -0700 (PDT)
Received: from workstation ([202.21.43.20])
        by smtp.gmail.com with ESMTPSA id x31sm4832983pfu.40.2021.10.21.00.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Oct 2021 00:36:51 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:06:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, vbadigan@codeaurora.org,
        kw@linux.com, bhelgaas@google.com
Subject: Re: [PATCH v1] PCI: qcom: Fix incorrect register offset in pcie init
Message-ID: <20211021073647.GA7580@workstation>
References: <1634237929-25459-1-git-send-email-pmaliset@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634237929-25459-1-git-send-email-pmaliset@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:28:49AM +0530, Prasad Malisetty wrote:
> In pcie_init_2_7_0 one of the register writes using incorrect offset
> as per the platform register definitions (PCIE_PARF_AXI_MSTR_WR_ADDR_HALT
> offset value should be 0x1A8 instead 0x178).
> Update the correct offset value for SDM845 platform.
> 
> fixes: ed8cc3b1 ("PCI: qcom: Add support for SDM845 PCIe controller")
> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>

After incorporating the reviews from Bjorn H,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300..5bce152 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1230,9 +1230,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  		val |= BIT(31);
> -		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  	}
>  
>  	return 0;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
