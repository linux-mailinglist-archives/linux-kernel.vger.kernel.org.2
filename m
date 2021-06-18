Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7163AC44A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhFRGzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFRGzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:55:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989DC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 23:52:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y4so555931pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C/E72wXwfFfCRapC2zN330q2NYUTi5jcqbX7wM1lPbs=;
        b=hrIK/8sEZPKx3gXLHqvVj/8/iomNH5D2w1BCs6t6xUMSCzJmPkP1pbKoI8CoAUSvLp
         EsQyhbFub3t9nuw+w4wLpWWXSdYQ9yh/5LB+h6BSI7MKItymkFxb2tBUh7EmVaR5xSAV
         G1G0xKU/dt+E1TbsvSnfy0+tXjIB0TfCYUr200W4Ek3qvELGppatJtMnjJ9hZgwo8gLz
         DrVXOJFgBOQirqvZnqK1Gro9HK8z9qC3dWxnGrQaL9VwhqRiabLHTV911HHCr166e/81
         tKTQB95nspJqZGBcMI/vjyHjlHrADrHCoyXNrI9Aw9wFJZLeEUueW+miI0R/7sQe0WVl
         AnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C/E72wXwfFfCRapC2zN330q2NYUTi5jcqbX7wM1lPbs=;
        b=jbyGFEySTL8PPhx3YTpfP6saIebL/s95rwdzexTs3Zo/nv437rA66ccCXbSrkSvYb2
         01DTEvvr7VK6/ON2T2Hq0wjjgxMxj1kRgVRAoAhXklByoosE4DrCMWXOFi3Lg4CH3UPX
         895OmGUuXhushn5kXTTTgw54Wry29KdjImWV2xwQrNAtnWMPv44+vKjMovj8VvLQ8J+V
         9F/hfmV4JaYONhD7AlXUHLb1NvAGTzFLG5yIBcHV/Gk9w4Wtu3XZIxqmzRK4EGnpGjEq
         vZ97jMR6rgouCph4HA/C8noRhh8ykPdKPl2oRX2gyHZV7jF0DSv/X0HjTCbLlrGge0p1
         q2hg==
X-Gm-Message-State: AOAM530K9x/MkgjWzoTRif2tDV+C7nz6CwHSvwco9vcmFdW8gZP5a3Mz
        k8WTWoMi++4xJdbc5Nq4Hv+sdw1KRrqR
X-Google-Smtp-Source: ABdhPJw1yU0i0iPRw4ldFXv1xCcHN43Fn7awBcaXH2PKBfhuUGT6GMsoqYvAajmigKGQHwzX/domsQ==
X-Received: by 2002:a05:6a00:1a88:b029:2ea:548:5ed4 with SMTP id e8-20020a056a001a88b02902ea05485ed4mr3710151pfv.47.1623999174440;
        Thu, 17 Jun 2021 23:52:54 -0700 (PDT)
Received: from workstation ([120.138.13.11])
        by smtp.gmail.com with ESMTPSA id v21sm7117303pfu.77.2021.06.17.23.52.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jun 2021 23:52:53 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:22:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH] bus: mhi: pci_generic: Apply no-op for wake using inband
 wake support flag
Message-ID: <20210618065249.GN3682@workstation>
References: <1623954233-32092-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623954233-32092-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:23:53AM -0700, Bhaumik Bhatt wrote:
> Devices such as SDX24 do not have the provision for inband wake
> doorbell in the form of channel 127. Newer devices such as SDX55
> or SDX65 have it by default. Ensure the functionality is used
> based on this such that device wake stays held when a client
> driver uses mhi_device_get() API or the equivalent debugfs entry.
> 
> Fixes: e3e5e6508fc1 ("bus: mhi: pci_generic: No-Op for device_wake operations")
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/pci_generic.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> index d84b743..31360a2 100644
> --- a/drivers/bus/mhi/pci_generic.c
> +++ b/drivers/bus/mhi/pci_generic.c
> @@ -32,6 +32,7 @@
>   * @edl: emergency download mode firmware path (if any)
>   * @bar_num: PCI base address register to use for MHI MMIO register space
>   * @dma_data_width: DMA transfer word size (32 or 64 bits)
> + * @no_inband_wake: Devices without inband wake support (such as sdx24)

I'd rather like this field to be "inband_wake" and set to false/true
based on the capability of the devices. Rest looks good.

Thanks,
Mani

>   */
>  struct mhi_pci_dev_info {
>  	const struct mhi_controller_config *config;
> @@ -40,6 +41,7 @@ struct mhi_pci_dev_info {
>  	const char *edl;
>  	unsigned int bar_num;
>  	unsigned int dma_data_width;
> +	bool no_inband_wake;
>  };
>  
>  #define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
> @@ -242,7 +244,8 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
>  	.edl = "qcom/sdx65m/edl.mbn",
>  	.config = &modem_qcom_v1_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> -	.dma_data_width = 32
> +	.dma_data_width = 32,
> +	.no_inband_wake = false
>  };
>  
>  static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
> @@ -251,7 +254,8 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
>  	.edl = "qcom/sdx55m/edl.mbn",
>  	.config = &modem_qcom_v1_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> -	.dma_data_width = 32
> +	.dma_data_width = 32,
> +	.no_inband_wake = false
>  };
>  
>  static const struct mhi_pci_dev_info mhi_qcom_sdx24_info = {
> @@ -259,7 +263,8 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx24_info = {
>  	.edl = "qcom/prog_firehose_sdx24.mbn",
>  	.config = &modem_qcom_v1_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> -	.dma_data_width = 32
> +	.dma_data_width = 32,
> +	.no_inband_wake = true
>  };
>  
>  static const struct mhi_channel_config mhi_quectel_em1xx_channels[] = {
> @@ -301,7 +306,8 @@ static const struct mhi_pci_dev_info mhi_quectel_em1xx_info = {
>  	.edl = "qcom/prog_firehose_sdx24.mbn",
>  	.config = &modem_quectel_em1xx_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> -	.dma_data_width = 32
> +	.dma_data_width = 32,
> +	.no_inband_wake = true
>  };
>  
>  static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
> @@ -339,7 +345,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.edl = "qcom/sdx55m/edl.mbn",
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> -	.dma_data_width = 32
> +	.dma_data_width = 32,
> +	.no_inband_wake = false
>  };
>  
>  static const struct pci_device_id mhi_pci_id_table[] = {
> @@ -640,9 +647,12 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mhi_cntrl->status_cb = mhi_pci_status_cb;
>  	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
>  	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
> -	mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
> -	mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
> -	mhi_cntrl->wake_toggle = mhi_pci_wake_toggle_nop;
> +
> +	if (info->no_inband_wake) {
> +		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
> +		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
> +		mhi_cntrl->wake_toggle = mhi_pci_wake_toggle_nop;
> +	}
>  
>  	err = mhi_pci_claim(mhi_cntrl, info->bar_num, DMA_BIT_MASK(info->dma_data_width));
>  	if (err)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
