Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0611C348E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCYKwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhCYKv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:51:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B67C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:51:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w8so863830pjf.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WDOizguRq8drFQk38ZzODxVZB2x4EMxsWev3Revxw0Y=;
        b=zYoH9SeD75+2AEee+MIyjm+CGETXAGt5ool7XVwt5VHXTCeLsNfwfxPW8ES+c3w+nX
         fW9GlSqKq13/anpmrmCSJW/kZZhthS1o+wjnS3Tn4jDA1nuT78dfI3e+MD3fHlM1cP0V
         XzMGwmppRoygu40/SU1OZoMqka7aeCURyD6ONSlWLVZpcRc/U/uTbOoKea4Ohj9maMaD
         x8I/7XkC7tgTemyUHgg36Afo5H4okssw7PzL3Y/94+5UlBRLS45739+9MRjVisZQ4Tpu
         aozx8K8B9sso8mDfZy9GB/BKvsYKIpBm3XUnnOQQ8ddLDuk1eb05haiWBFc43OrLOucg
         sTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WDOizguRq8drFQk38ZzODxVZB2x4EMxsWev3Revxw0Y=;
        b=fUABasP3D1iSidSOdqRYL79U1YL8+58u7ZaYuTdDQR4Hc2mJMCsiQS/NKa7DLal4C8
         BkQixKO54OarUJQbeRmDTzUzGfnRRFnV0l8DSD7mnIgHveM2jWGFdLTps6ZqvWZLSaDr
         nkkvglFUD6JpIxc0ZQACI8z5hKCLDpNko9KR3OLOqQ0hkyXFRWgQ3zx+8omIJRbstnyl
         QK8yCedbfYum4t1a2UrRb4l6LUlThKWv9HXJDcY3K9CNHRquInoov/1Q/LQ0VpTgcU2y
         9zTxcRhMAxTkcEiomrRatHl59FBOwdopIor79sVgpJzxzyKuk3MR+3hOVdHRXp2cLt29
         T8Yw==
X-Gm-Message-State: AOAM533SX7q6NZFv8yAjuSmhf7o+NE+aZNSp3McRkb4ZWTPgYtAZqtTI
        kJelvU54vcHwpKbTM/onE1z3gw==
X-Google-Smtp-Source: ABdhPJzJ88HGwhjdHY9GCeoUb+nzbyyDI7PQS65b0tAaHdH75UzKxuxTPXW/sj/RZBXVjkKpy4Cz2A==
X-Received: by 2002:a17:90a:a96:: with SMTP id 22mr8391016pjw.200.1616669517416;
        Thu, 25 Mar 2021 03:51:57 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id p1sm5409324pfn.22.2021.03.25.03.51.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Mar 2021 03:51:57 -0700 (PDT)
Date:   Thu, 25 Mar 2021 16:21:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jian Dong <dj0227@163.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH]  staging: greybus: fix fw is NULL but dereferenced
Message-ID: <20210325105155.c52zc7mswoh33yjz@vireshk-i7>
References: <1616667566-58997-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616667566-58997-1-git-send-email-dj0227@163.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-21, 18:19, Jian Dong wrote:
> From: Jian Dong <dongjian@yulong.com>
> 
>  fixes coccicheck Error:
> 
>  drivers/staging/greybus/bootrom.c:301:41-45: ERROR:
>  fw is NULL but dereferenced.
> 
>  if procedure goto label directly, ret will be nefative, so the fw is NULL
>  and the if(condition) end with dereferenced fw. let's fix it.

No, fw is accessed only for !ret case.

> Signed-off-by: Jian Dong <dongjian@yulong.com>
> ---
>  drivers/staging/greybus/bootrom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
> index a8efb86..0439efa 100644
> --- a/drivers/staging/greybus/bootrom.c
> +++ b/drivers/staging/greybus/bootrom.c
> @@ -246,7 +246,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>  	struct gb_bootrom_get_firmware_response *firmware_response;
>  	struct device *dev = &op->connection->bundle->dev;
>  	unsigned int offset, size;
> -	enum next_request_type next_request;
> +	enum next_request_type next_request = NEXT_REQ_GET_FIRMWARE;
>  	int ret = 0;
>  
>  	/* Disable timeouts */
> @@ -298,10 +298,10 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>  
>  queue_work:
>  	/* Refresh timeout */
> -	if (!ret && (offset + size == fw->size))
> -		next_request = NEXT_REQ_READY_TO_BOOT;
> -	else
> +	if (!!ret)
>  		next_request = NEXT_REQ_GET_FIRMWARE;
> +	else if (offset + size == fw->size)
> +		next_request = NEXT_REQ_READY_TO_BOOT;
>  
>  	gb_bootrom_set_timeout(bootrom, next_request, NEXT_REQ_TIMEOUT_MS);

The code is fine AFAICT, the coccicheck is buggy as it is detecting a
bug here.

-- 
viresh
