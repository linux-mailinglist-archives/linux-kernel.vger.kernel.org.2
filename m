Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5310B31D186
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhBPUXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:23:55 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:60174 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhBPUXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:23:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613507001; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AyqM1PnVjT5CoC9vJ/A6wEyIQ2zpS7UZjSRc7C5kgNA=;
 b=MpYk8OcAuZCfv0hb9aaDn1dQMf1N3CoGmxtSQE4OoyxTLlMTCvJvOyNnXBaFnKyYpkhirTfc
 XkmtEHnoGM3T8yMEhmPzz2odFTQKbvwV3tdB8f9kHysz569i309zkkqDfOMfinRWLNOppowt
 zLnCpikW/aOyeuUFAwFJE63niuk=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 602c299c59e278015920a17f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 20:22:52
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BBFBCC433CA; Tue, 16 Feb 2021 20:22:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20A4EC433C6;
        Tue, 16 Feb 2021 20:22:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Feb 2021 12:22:51 -0800
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fan Wu <wufan@codeaurora.org>,
        jhugo=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] mhi_bus: core: Return EBUSY if MHI ring is full
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <1613501314-2392-1-git-send-email-jhugo@codeaurora.org>
References: <1613501314-2392-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <e3b0dd23ea461ac76a61266b4c657d83@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16 10:48 AM, Jeffrey Hugo wrote:
> From: Fan Wu <wufan@codeaurora.org>
> 
> Currently ENOMEM is returned when MHI ring is full. This error code is
> very misleading. Change to EBUSY instead.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/bus/mhi/core/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index f182736..21eb5fc 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -996,7 +996,7 @@ static int mhi_queue(struct mhi_device *mhi_dev,
> struct mhi_buf_info *buf_info,
> 
>  	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
>  	if (unlikely(ret)) {
> -		ret = -ENOMEM;
> +		ret = -EBUSY;
>  		goto exit_unlock;
>  	}

ENOMEM is descriptive of the state of the ring since you basically 
cannot queue any
more packets as no memory is currently available.

But I agree, it can be misleading for this API. How about EAGAIN in 
place of EBUSY,
which tells the user to try the queue attempt again implying memory 
should become
available as more elements are consumed by the device/client?

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
