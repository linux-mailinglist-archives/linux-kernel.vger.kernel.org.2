Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5656D350475
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhCaQ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbhCaQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:26:23 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:26:23 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso19516620otp.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FbposqgapdTdAS+TUQHgC3JJ2yt1So9MQA6oTHq2HyM=;
        b=ZZd/A3VhaWLf87FVg8P1ETQbMeM4bycDbJ6/1pg/jHN5ZUmh2n5Da+wqk6B7ZfXQq5
         TjZba8TFJ4YiC2U86OvgIh0n6PTxMPmEapCOoACsT7Umo4ooYYa06ngCiyuMeYt7bCj4
         QA5SmAajb8S2AAna5rS6c9UA13qFcyelWqdHL4aDt2vdAXTaRByz4GKuB6GzL+6YpEXx
         gdeXnFsuE+P+/9hyu+uqqUPTAk9NJZAvlcBlHgRFNGndjEn2CxWjjLRPIL9xbTn6D2tL
         7Ac0d0yNm0Q/a7e0J8Q9oYA7OACz9cTKwo0eAj36rkCPMS19Of5iHuAVBd0kwxyLe9YV
         GRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FbposqgapdTdAS+TUQHgC3JJ2yt1So9MQA6oTHq2HyM=;
        b=gBvsD7nH8wdur4cKTC+mK16yykG1zROj3MPeAi5KsuZeyrdLnXIyE5N6wU3mN9yMCO
         zlNqBJiS9iRBRUb/ctyzRkTw5zKXpI1RP8JX7OOYUx7hqhy4kcL0flsG2KqS/zIXFawd
         IFbE96RUK0OIFRpRARMoigPeu4wmzbay3ZKY4i8CIZ/0vJxNNPPc+t3bGdIie8pVOfWf
         XTjRIjr3uJCx9kHBLcp416gGo0Z07eFLhPK1YnXTN7PcUoEV9AQTi/Li0r1PQYaeMfhw
         p7ckiKr1GlVBYT+BOBg6MYZzUvLYF8TiGkoE0XGDqHSXyXcCMsfxRuSEPb4ICzrNz37S
         4qBQ==
X-Gm-Message-State: AOAM533BvJOMxG+Z6gWk0eHZxFtYCdW1Jw/a6J9bJRAqQSncwNZQ5I5r
        szMnNTtHjaMm3gMJ+QvbHIOoNQ==
X-Google-Smtp-Source: ABdhPJwpuw4Dcj+wqGcEfRmuYfn1e+Gs7VXG66D29ALgKuCxRO8vT4VsmB0HRn/ZbEem/ltTw2GQoQ==
X-Received: by 2002:a05:6830:1282:: with SMTP id z2mr3401766otp.30.1617207982514;
        Wed, 31 Mar 2021 09:26:22 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f29sm571110ots.22.2021.03.31.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 09:26:22 -0700 (PDT)
Date:   Wed, 31 Mar 2021 11:26:19 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] soundwire: qcom: use signed variable for error return
Message-ID: <20210331162619.GK904837@yoga>
References: <20210331155520.2987823-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331155520.2987823-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Mar 10:55 CDT 2021, Vinod Koul wrote:

> We get warning of using a unsigned variable being compared to less than
> zero. The comparison is correct as it checks for errors from previous
> call to qcom_swrm_get_alert_slave_dev_num(), so we should use a signed
> variable here.
> 
> While at it, drop the superfluous initialization as well
> 
> drivers/soundwire/qcom.c: qcom_swrm_irq_handler() warn: impossible
> condition '(devnum < 0) => (0-255 < 0)'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index b08ecb9b418c..ec86c4e53fdb 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -428,7 +428,7 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  	struct qcom_swrm_ctrl *swrm = dev_id;
>  	u32 value, intr_sts, intr_sts_masked, slave_status;
>  	u32 i;
> -	u8 devnum = 0;
> +	int devnum;
>  	int ret = IRQ_HANDLED;
>  
>  	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
> -- 
> 2.26.3
> 
