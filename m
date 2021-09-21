Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE3412B01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbhIUCE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:04:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22955 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235400AbhIUBqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:46:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632188721; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+qn/+donEJg3RKiiiRMExXK8yLHpmna544uGGbrCqE4=; b=r6bJ+5/XSKx8nPoAdF1t6fUvUWZbcIuGFrFbOZJDckt07WvOgJtthJXNwlssgvvrXf7ozwdn
 OUjIYqgFdknFyfHv+Bj6W65JDlzh6FK6T6UcPwWEVjv/hMBKJ13HppsJEwIVKdhrHvcPiNe3
 VNNlj4EeFoiYux0xTodkTBvSFj8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61493930ec62f57c9ab38182 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 01:45:20
 GMT
Sender: subbaram=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B94B0C43460; Tue, 21 Sep 2021 01:45:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.47.233.232] (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: subbaram)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EED12C4338F;
        Tue, 21 Sep 2021 01:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EED12C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] spmi: pmic-arb: Add sid and address to error messages
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        satya priya <skakit@codeaurora.org>,
        David Collins <quic_collinsd@quicinc.com>
References: <20210920234849.3614036-1-swboyd@chromium.org>
From:   Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Message-ID: <f03e37bd-0639-9548-fced-a4cb1c1a202f@codeaurora.org>
Date:   Mon, 20 Sep 2021 18:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210920234849.3614036-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 4:48 PM, Stephen Boyd wrote:
> It's useful to know what particular device/component is having trouble
> accessing the bus. Add the sid and address to error messages here so
> that debugging is a little simpler.
>
> Cc: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Cc: satya priya <skakit@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>

> ---
>  drivers/spmi/spmi-pmic-arb.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index bbbd311eda03..e397c2532c8d 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -261,20 +261,21 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
>  
>  		if (status & PMIC_ARB_STATUS_DONE) {
>  			if (status & PMIC_ARB_STATUS_DENIED) {
> -				dev_err(&ctrl->dev, "%s: transaction denied (0x%x)\n",
> -					__func__, status);
> +				dev_err(&ctrl->dev, "%s: %#x %#x: transaction denied (%#x)\n",
> +					__func__, sid, addr, status);
>  				return -EPERM;
>  			}
>  
>  			if (status & PMIC_ARB_STATUS_FAILURE) {
> -				dev_err(&ctrl->dev, "%s: transaction failed (0x%x)\n",
> -					__func__, status);
> +				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
> +					__func__, sid, addr, status);
> +				WARN_ON(1);
>  				return -EIO;
>  			}
>  
>  			if (status & PMIC_ARB_STATUS_DROPPED) {
> -				dev_err(&ctrl->dev, "%s: transaction dropped (0x%x)\n",
> -					__func__, status);
> +				dev_err(&ctrl->dev, "%s: %#x %#x: transaction dropped (%#x)\n",
> +					__func__, sid, addr, status);
>  				return -EIO;
>  			}
>  
> @@ -283,8 +284,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
>  		udelay(1);
>  	}
>  
> -	dev_err(&ctrl->dev, "%s: timeout, status 0x%x\n",
> -		__func__, status);
> +	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
> +		__func__, sid, addr, status);
>  	return -ETIMEDOUT;
>  }
>  


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

