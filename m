Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BAE350470
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhCaQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCaQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:24:19 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E662CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:24:16 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m13so20519589oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ojW2lv70Zjf6csQxfrD5M3Jt02GT2Ern8AWuYsfFGY=;
        b=WA7CspsaOUGzoSg93E6Kb+UCLYKW6UuEO+xHKotKr9HCmlukDg+vvgAdY2B0jdhjYv
         IqSIk9iLxcUOOSvMS+iF5vv70kIQH3+CiyySeQSJSE4tPXi+Vtco06RfKmro6Eu5kqGC
         /HgP47QXoiyaJO7bFi3zjH/XieBfuRG0WirKPKCzUWCzVWFWOADTCYbpBxm8bYqLen+0
         KtnVv5bHTXeML1murK1rx0r7Cu0zFEk/vQU9NJXFcDc7JmOHfO+2CeHFL7xXo4zWa6JB
         h9QYn60ZCT9ILTfCPfgav5ytklkuL4UJH6/9gLQgHmcTF22SdFyInpFCnsaVKTKskowD
         rPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ojW2lv70Zjf6csQxfrD5M3Jt02GT2Ern8AWuYsfFGY=;
        b=c+6eAvdx7o1FAB0kPCTZEDJyWqry0tLnSUujKsX4A4/nTLG74BlmJv5u4pK/YieMRp
         +kFcUewNU1Mw0Mci9hvr/Dy7QjqFBUDUS8+a8uBCO7KfdedsfwjCTVA7Gz1PfJH+7FS+
         aIvrVjKsQiLwpSVc8IN1RFxMtUIUHW2KSVTI+utA8wAQk2RwrrRvMa8+jJVWKj9YHt5k
         lk7VFMzTkO6AMdvPWFx5B2X3C4hM2EYjHDD731admNryNZxy5nT3EJW9oMkmyH9PKhCc
         i0vfJxxTIMdxuIBCmDkkG6T+VqaX5z9UDyZow45z6Pz+TR6hznsAdrURRauPKLZms36L
         hTyQ==
X-Gm-Message-State: AOAM530DqPreaCLJSzXkwTuUWM6FnngHxZeGtCgUwbU+YF4I9l13dr31
        rE6QqNp7IP/Rfy7z6SlLjrEO2g==
X-Google-Smtp-Source: ABdhPJwfdWI6nnYFm5Aq9dILT7eMDQoeMTKFzGdX2gtf7uIYU9+M/Q8rUSa0gR4MiAxlPEOfqFm5xA==
X-Received: by 2002:aca:3389:: with SMTP id z131mr2873290oiz.11.1617207856188;
        Wed, 31 Mar 2021 09:24:16 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m129sm506802oif.34.2021.03.31.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 09:24:15 -0700 (PDT)
Date:   Wed, 31 Mar 2021 11:24:13 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] soundwire: qcom: use signed variable for error return
Message-ID: <20210331162413.GJ904837@yoga>
References: <20210331072111.2945945-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331072111.2945945-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Mar 02:21 CDT 2021, Vinod Koul wrote:

> We get warning for using a unsigned variable being compared to less than
> zero. The comparison is correct as it checks for errors from previous
> call to qcom_swrm_get_alert_slave_dev_num(), so we should use a signed
> variable instead.
> 
> drivers/soundwire/qcom.c: qcom_swrm_irq_handler() warn: impossible
> condition '(devnum < 0) => (0-255 < 0)'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index b08ecb9b418c..55ed133c6704 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -428,7 +428,7 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  	struct qcom_swrm_ctrl *swrm = dev_id;
>  	u32 value, intr_sts, intr_sts_masked, slave_status;
>  	u32 i;
> -	u8 devnum = 0;
> +	s8 devnum = 0;

At least in today's linux-next qcom_swrm_get_alert_slave_dev_num()
returns an int and the code only checks to see if this is negative.  So
it seems like making this a full int ensures there's no truncation etc.

And at least as written today there's no need to initialize the
variable.

Regards,
Bjorn

>  	int ret = IRQ_HANDLED;
>  
>  	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
> -- 
> 2.26.3
> 
