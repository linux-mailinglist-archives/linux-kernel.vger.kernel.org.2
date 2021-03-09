Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2660E332FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhCIUL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhCIULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:11:21 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0758DC061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:11:21 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a17so14102453oto.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nDU8HEaDFt+U/tR130L3pHQ5tc1We6CEmFa3LppbPl4=;
        b=f4W/TVC9lKb+TyY8+3weZrNji11zh0olJ4lUgfR04OFYGlZtOKh1mXplBhsBSfvw4h
         lEkK6iRmCSDF1g2xpeflwz+x6Tza25ks2r7D0nPwDeloAqyNnnOmDo6mqSPL5IM9Cdmd
         XNWEQV+dNjys5OGPkdtiCLUHhek459X99aY+5sFIR6TQBJQaJ6tLx09cza3bT6aoZw1N
         CCY2YkVZrPJh7usKWLq4bPvAVQRjeQ8/2oX/HqSuQW77B8Uv8ogg6phKRQxmYSoMSOhd
         1eUYMLnT2btNngVwJVS8Y47VZ3uDxztdk1IiAhvcvaAXmQU9wuM49jbKyRh1Q8bMFrRW
         TXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nDU8HEaDFt+U/tR130L3pHQ5tc1We6CEmFa3LppbPl4=;
        b=cljum1xCK/ctXI8G/pAbL8br0Q9QFcZUl3gpTFykNJrxR/cP8mzVSW3v9UHJBxKUSg
         Ns+Xl8cRPl0lXqotHkfqE8t26NaUYYq1DXWwSGj3LFcPENo+kR8tD/sQI24GpRaDJcS4
         8mEJPaL3EcJKTD8THLZjEVu6lozXsWrJNgzAxNTlQCX995HKt53now3j0guXOEH0cQuV
         6Gh+9cPk3cCpLBCDPL/rNJ3d59fkSCvxpBWyH0TOSRIXER+iXPxBuGENMUWEWjDX9ag7
         gh89zGsU6X4RX/Sll4cZFlhm6r0BOLytz8DNiC6y2yO3BEFho+hryOy+iXiXcjDqqdD3
         nqrQ==
X-Gm-Message-State: AOAM533pMYrNgng67awp840KG0vGz9zKwhquhxZidXtvWRaiqRb5qj6K
        sF1jI/qMzq8TI7pLmGXckdscNw==
X-Google-Smtp-Source: ABdhPJzoFq0F35X7H/P8NnCFd/JH+3u9SL+2b9pd3ZXLXZLantPepyGOiVNA5xWjB3aEmmIMq+Uwyg==
X-Received: by 2002:a05:6830:2050:: with SMTP id f16mr1100574otp.182.1615320680377;
        Tue, 09 Mar 2021 12:11:20 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v9sm3068283oon.11.2021.03.09.12.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 12:11:19 -0800 (PST)
Date:   Tue, 9 Mar 2021 14:11:18 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: qcom: sc7280: Fix SDC1_RCLK configurations
Message-ID: <YEfWZqZaGElvklTj@builder.lan>
References: <1614662511-26519-1-git-send-email-rnayak@codeaurora.org>
 <1614662511-26519-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614662511-26519-2-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Mar 23:21 CST 2021, Rajendra Nayak wrote:

> Fix SDC1_RCLK configurations which are in a different register so fix the
> offset from 0xb3000 to 0xb3004.
> 
> Fixes: ecb454594c43: ("pinctrl: qcom: Add sc7280 pinctrl driver")
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Reported-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-sc7280.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280.c b/drivers/pinctrl/qcom/pinctrl-sc7280.c
> index 49c4347..9d41abf 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc7280.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280.c
> @@ -1440,7 +1440,7 @@ static const struct msm_pingroup sc7280_groups[] = {
>  	[173] = PINGROUP(173, qdss, _, _, _, _, _, _, _, _),
>  	[174] = PINGROUP(174, qdss, _, _, _, _, _, _, _, _),
>  	[175] = UFS_RESET(ufs_reset, 0xbe000),
> -	[176] = SDC_QDSD_PINGROUP(sdc1_rclk, 0xb3000, 15, 0),
> +	[176] = SDC_QDSD_PINGROUP(sdc1_rclk, 0xb3004, 0, 6),
>  	[177] = SDC_QDSD_PINGROUP(sdc1_clk, 0xb3000, 13, 6),
>  	[178] = SDC_QDSD_PINGROUP(sdc1_cmd, 0xb3000, 11, 3),
>  	[179] = SDC_QDSD_PINGROUP(sdc1_data, 0xb3000, 9, 0),
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
