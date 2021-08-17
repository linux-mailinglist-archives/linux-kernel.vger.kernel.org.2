Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E323EE46C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 04:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhHQCgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 22:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhHQCgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:36:09 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFA7C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 19:35:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t35so29783600oiw.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NdyGEYcMNe8BiminkuBCItjHjvXDyAXJh8MNR3OdTVA=;
        b=bWqdF64VY/gZ0txHUPvtOyRYx/7413DAHTyvrWOEFLI8Z5zIC+H1GkaCheBYSMLNPP
         xz/TOUln9srtWWj0EQduVMM+M09U4WIyJwmXs34nLYTtJ6ZVKBKWNDQpVpWifKiVgzhA
         YJFlDtXY4D0gaQ/P5BE06IsNvRnwiu4D55/Ji7ZGTXmrEF4oz/zH6/CJg5SF8CtX6Rkh
         pqMfnbR9jNWDeBDcsr12bkxosdYXNRwZ+rAoik0IRpr6c54nL7iby0rOTBdpnAkt7eR3
         kv5rcrTqrcijFf1jxR8NUjrRPKg9fssGBEt6ZHTtr079ub4luBvQurn3sp1Pz67ACsE/
         43nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NdyGEYcMNe8BiminkuBCItjHjvXDyAXJh8MNR3OdTVA=;
        b=RimhvdI+kRvQcHVXjCTafY0E1iHC2rk7vtR9999z2pg8lxTEGmHkT0D6MKHMH9kVCR
         pjCJRbOCssBJycP/bkUK3/Zepf0tTg4fyBCUAjR8uY0WUfSL90JqWgRocZYQGlDd2tWV
         r7buP/qUBZv6KyCN27r1+walWwzW/+hzCP6K075uQ9Ybwljr19M8mrZqaZP9ckl1jdPP
         vka8CV8Exp6EeziV2/Wu84Ex6zIR4eN/hKJpC+sTYQ+Tfh9Sx59q50oL5MgQZxa3Y3SX
         nqxNlW1wpgpN+Omh6N3WUjvxq9pB6VtFtsjikrgO6C6+VEQOSdw6fAfZHtWAX4mQgxUF
         tLQA==
X-Gm-Message-State: AOAM533RBIAReL8fbgzVhXVAfBV4SJs65v/tfPS1DXj0YLIdQCce8oc/
        spOhZW2JXBY7URS2u889gkkrzQ==
X-Google-Smtp-Source: ABdhPJymyQJLqdiw2YDOsltDdciCYnn251jtZQLVfsywLgi83bxWlqaNn4EhafXoU05oQICTq1XjrA==
X-Received: by 2002:aca:1014:: with SMTP id 20mr722410oiq.70.1629167736646;
        Mon, 16 Aug 2021 19:35:36 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d1sm128671otb.61.2021.08.16.19.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 19:35:36 -0700 (PDT)
Date:   Mon, 16 Aug 2021 21:35:33 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Antonio Martorana <amartora@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: Fixed argument passed to
 platform_set_data()
Message-ID: <YRsgdXv749tznl2i@yoga>
References: <1629159879-95777-1-git-send-email-amartora@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629159879-95777-1-git-send-email-amartora@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Aug 19:24 CDT 2021, Antonio Martorana wrote:

> Set qcom_socinfo pointer as data being stored instead of pointer
> to soc_device structure. Aligns with future calls to platform_get_data()
> which expects qcom_socinfo pointer.
> 

Thanks for the patch Antonio!

This should have a fixes tag, to ensure that it's appropriately
backported.

Fixes: efb448d0a3fc ("soc: qcom: Add socinfo driver")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Antonio Martorana <amartora@codeaurora.org>
> ---
>  drivers/soc/qcom/socinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 9faf483..52e5811 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -628,7 +628,7 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
>  	/* Feed the soc specific unique data into entropy pool */
>  	add_device_randomness(info, item_size);
>  
> -	platform_set_drvdata(pdev, qs->soc_dev);
> +	platform_set_drvdata(pdev, qs);
>  
>  	return 0;
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
