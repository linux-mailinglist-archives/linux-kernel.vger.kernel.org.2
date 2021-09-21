Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390A341307A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhIUIyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:54:50 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12390 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhIUIys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:54:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632214400; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dAWA8a6whWeUaB7qQIv8T53DGjn38GnpZsmeoqjScb4=;
 b=LAisVseMZnkSORxFAUsDK6jLSPqTRrNcOQkOYpnQ3VFUtnllO8mrmz/CQ2oWGvIiVkv4OZlF
 LJOdH4SGFmU4gLvnwDvyPOGqOBDt5t4R2g+3zIuy1PzMsp8jFhEsrHOcbbQJs8WX0dmI44Lx
 n/aWb4JYQtiPPm5xFWreWbCr5/A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61499d7cbd6681d8eddfb259 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 08:53:16
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5753C4360D; Tue, 21 Sep 2021 08:53:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28ECBC4338F;
        Tue, 21 Sep 2021 08:53:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Sep 2021 14:23:15 +0530
From:   skakit@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH] spmi: pmic-arb: Add sid and address to error messages
In-Reply-To: <20210920234849.3614036-1-swboyd@chromium.org>
References: <20210920234849.3614036-1-swboyd@chromium.org>
Message-ID: <70e94c9fd5a15396b89c6778879ac034@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-21 05:18, Stephen Boyd wrote:
> It's useful to know what particular device/component is having trouble
> accessing the bus. Add the sid and address to error messages here so
> that debugging is a little simpler.
> 
> Cc: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Cc: satya priya <skakit@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Reviewed-by: Satya Priya <skakit@codeaurora.org>

>  drivers/spmi/spmi-pmic-arb.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c 
> b/drivers/spmi/spmi-pmic-arb.c
> index bbbd311eda03..e397c2532c8d 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -261,20 +261,21 @@ static int pmic_arb_wait_for_done(struct
> spmi_controller *ctrl,
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
> @@ -283,8 +284,8 @@ static int pmic_arb_wait_for_done(struct
> spmi_controller *ctrl,
>  		udelay(1);
>  	}
> 
> -	dev_err(&ctrl->dev, "%s: timeout, status 0x%x\n",
> -		__func__, status);
> +	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
> +		__func__, sid, addr, status);
>  	return -ETIMEDOUT;
>  }
