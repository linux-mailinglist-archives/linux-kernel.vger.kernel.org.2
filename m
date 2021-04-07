Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273EC35648B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbhDGGv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbhDGGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:51:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882FFC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 23:51:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l1so8836509plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SE4iL2puaiPL/3a2nJyll42hGnUPWI+P1/xFJ/BpsA4=;
        b=yhE3gP5y3epMS2MQW2W+12K+ECPz3m85oBS09LxQdNpCsswykU+VJvp8TaNQX8m44I
         MknSYvTYK9rXxPNE0aSYr7Ci6kP3EGBzWlf+XaYDvVWfXhauxHPClDb0rqQAWmVsa5rL
         uiSlavl4Zzc2kqAztMHmQt+o6n3ItdBForV/ByQgm11cV8e321ML9BldtXGjgZyZSSOZ
         odZy/LUceD7FtsePrpOqoUfVadAHfMFwuID3IAvDTErNREk7PsAX1XeoL/2CEzxYdcwp
         iyxyd9U7uX24w/r429iJ2/MBP/TeNj5PTBJjCk0Y5ADqF/Fc037YtS3wGDRtZo2KOUGX
         0A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SE4iL2puaiPL/3a2nJyll42hGnUPWI+P1/xFJ/BpsA4=;
        b=KDWHaD5oJEpyyByTpRtgpCC+YLobf1/ryO46dcYfVdWqqTpduJ3RYV8d2bTcV9G4DQ
         Qn/X9WS05WLNztX3VJEMapsLMDP7wLe3S0RO75wREbmEWrWmmQ94I0jVr1N20zTJ0GdO
         zTDNAF+pnWAwFbmm27HpolxfMi+a+Ed28yHh3Apj+6vHT1XgeCq1e2fIy7qRXUQfjmT4
         NOXIAaw+nRwb6GYeMbMgzDbighneUNFadBm1EavKWD7kda8LaS2odvOKsTuApiTficOK
         9ulpf9dFp+dzAWVi/BzFioZwPI8IWXX7fNYwpwD69txAeLp/LKi6URS4ghqYjOLC81Fq
         kwmw==
X-Gm-Message-State: AOAM531lM1Z/tRWXGSpcZU5jl8RVbBEfVNZebbny0HmB6SNVciCR0Cc+
        qqb3vAfWtJG/G3GIgNrdsIOH
X-Google-Smtp-Source: ABdhPJwHN2vJlf+O+eDFlqBdrjaZz9fENpNP4JARM8sQhDrVJnHaxXxIUZhjSv75tNOczYu6L/ETGw==
X-Received: by 2002:a17:90a:c908:: with SMTP id v8mr1913491pjt.75.1617778275006;
        Tue, 06 Apr 2021 23:51:15 -0700 (PDT)
Received: from work ([103.77.37.180])
        by smtp.gmail.com with ESMTPSA id a22sm21552866pgw.52.2021.04.06.23.51.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Apr 2021 23:51:14 -0700 (PDT)
Date:   Wed, 7 Apr 2021 12:21:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org
Subject: Re: [PATCH] bus: mhi: pci_generic: Add SDX65 based modem support
Message-ID: <20210407065111.GL8675@work>
References: <1617399199-35172-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617399199-35172-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 02:33:19PM -0700, Bhaumik Bhatt wrote:
> Add generic info for SDX65 based modems.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Applied to mhi-next!

Thanks,
Mani

> ---
> This patch was tested on SDX65 hardware with Ubuntu X86_64 PC as host.
> 
>  drivers/bus/mhi/pci_generic.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> index 5cf44bc..92a1b18 100644
> --- a/drivers/bus/mhi/pci_generic.c
> +++ b/drivers/bus/mhi/pci_generic.c
> @@ -204,6 +204,15 @@ static struct mhi_controller_config modem_qcom_v1_mhiv_config = {
>  	.event_cfg = modem_qcom_v1_mhi_events,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
> +	.name = "qcom-sdx65m",
> +	.fw = "qcom/sdx65m/xbl.elf",
> +	.edl = "qcom/sdx65m/edl.mbn",
> +	.config = &modem_qcom_v1_mhiv_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32
> +};
> +
>  static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
>  	.name = "qcom-sdx55m",
>  	.fw = "qcom/sdx55m/sbl1.mbn",
> @@ -261,6 +270,8 @@ static const struct mhi_pci_dev_info mhi_quectel_em1xx_info = {
>  };
>  
>  static const struct pci_device_id mhi_pci_id_table[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
> +		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx55_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
