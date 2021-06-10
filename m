Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CA3A2493
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJGil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:38:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39741 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhFJGik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:38:40 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrEJ1-0004aL-JE
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 06:36:43 +0000
Received: by mail-wr1-f72.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so414693wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WtLXS+0tm1k1bpg9yjdyBFk1R42VryqZ5m7j5SsaTlI=;
        b=XpN4LSOsYC0G9kDKSNqJlh7N8RKS7Qjg3r2aOdh1a3tu4Lt8ZeSHN/6Yg2r8ERy+ZL
         sLby4KIf8TK+Ts9CAQMYM+ZoNnO40SNlHw5qLToznrNqyJVj4I524rkIn35BD5adcdwP
         YKktSpi1Hq+3U4hmduXibVertCv+mS8ikRWzJDypJCxPXXLOSBpG5IQrt0dA4mjRxLUn
         z08EF5k7bnflFDR5ZujaRr1kO4zBDVCIuD5Iep/4yESkU0o4CQl11+5B68aPq702ox/l
         IB5nZc7IDFraAA/GlVPm0qUZcbkJiC60cRAwiIi38doyaAMxsiZXQiA/PoYhkWKVbQpl
         EN/w==
X-Gm-Message-State: AOAM531+BbC5H1HfHtQePriF+XXkRpQZekAY2lqYxeXD0ASU31IRru1P
        W0MO8jctfKtzeBasxaeRhkfJSVM3b++ondGmrBRwIfaa7X0DYeEiDAstPxqTFB91PuNVBrTbaqX
        ftTMgjmmAKRcSElWnwLjuH+JRnWOfheBsVF+MeI6yiA==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr12784106wmi.154.1623307003334;
        Wed, 09 Jun 2021 23:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrKbTB2dPyTcgsNWbqMxfPi2n18eMS3fGLXwsHyavospcUWmdxoXbYyMBB4fiIvgtYPSOVfQ==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr12784093wmi.154.1623307003211;
        Wed, 09 Jun 2021 23:36:43 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id a10sm459607wrr.48.2021.06.09.23.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 23:36:42 -0700 (PDT)
Subject: Re: [PATCH] nfc: fdp: remove unnecessary labels
To:     samirweng1979 <samirweng1979@163.com>, davem@davemloft.net,
        kuba@kernel.org, unixbhaskar@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210610024616.1804-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a4dd4569-2f81-7aac-e8f7-405866bb1b7d@canonical.com>
Date:   Thu, 10 Jun 2021 08:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610024616.1804-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 04:46, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> Some labels are meaningless, so we delete them and use the
> return statement instead of the goto statement.
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> ---
>  drivers/nfc/fdp/fdp.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

> diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
> index 7863b25..5287458 100644
> --- a/drivers/nfc/fdp/fdp.c
> +++ b/drivers/nfc/fdp/fdp.c
> @@ -266,7 +266,7 @@ static int fdp_nci_request_firmware(struct nci_dev *ndev)
>  	r = request_firmware(&info->ram_patch, FDP_RAM_PATCH_NAME, dev);
>  	if (r < 0) {
>  		nfc_err(dev, "RAM patch request error\n");
> -		goto error;
> +		return r;
>  	}
>  
>  	data = (u8 *) info->ram_patch->data;
> @@ -283,7 +283,7 @@ static int fdp_nci_request_firmware(struct nci_dev *ndev)
>  	r = request_firmware(&info->otp_patch, FDP_OTP_PATCH_NAME, dev);
>  	if (r < 0) {
>  		nfc_err(dev, "OTP patch request error\n");
> -		goto out;
> +		return 0;
>  	}
>  
>  	data = (u8 *) info->otp_patch->data;
> @@ -295,10 +295,7 @@ static int fdp_nci_request_firmware(struct nci_dev *ndev)
>  
>  	dev_dbg(dev, "OTP patch version: %d, size: %d\n",
>  		 info->otp_patch_version, (int) info->otp_patch->size);
> -out:
>  	return 0;
> -error:
> -	return r;
>  }
>  
>  static void fdp_nci_release_firmware(struct nci_dev *ndev)
> 
