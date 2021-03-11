Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501C3337542
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhCKOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhCKOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:16:36 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32CC061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:16:35 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id o11so22100892iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ei63gaWMLxEmNqdA5R8TWOwXizZ14K3nYqemAOmaLh0=;
        b=BM20wCWVV1daEhIL7RR4tpSwAlnVVR0qilSyirp5e9d5AeGSONNUbOezG5g0sIl8N0
         iKzmbfU7PYqFcVzmCPhyt34d/rn718kYBejBQEiEw+7Bhg4o/0zoWKFgeKs/T5SCDhz/
         Y+CA+JkDYVgEckMgjA7ipLpf7vPQfokqtnX3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ei63gaWMLxEmNqdA5R8TWOwXizZ14K3nYqemAOmaLh0=;
        b=sqlOP+PLZvVbLzibv9A7CZViuvVqD7L1FyZwG8UPU1uaktRLA4varB2842fTPSSObu
         RO68AA9vtkSSOltrLXVgQ8ZkQDWWAnPPAjcJk2uDEaKUeQOCdPRhsopBmyaJR2hUC+/b
         gnmA8JOUfoE3/9WECfxB547aPzTFORiRqWZo7FpourB3KK8YmIfdgmZZz3WXixKuTDs5
         FysHiC5fFlnduPPRVt9VYnkLCRNbltyd9CobLE8JBjmPRzBKubgvzLMMDAjpQK4wx8Gu
         prJp4PPblxBPUg16rbgHlI9uSUviuz8vqjnL/s7vwJEoJ1MKfkks1X63vFtfgY2CDOk2
         uFAw==
X-Gm-Message-State: AOAM533X+5m+1QohxyzPZMhFlnrFcVmkKFW74WipriwkXj3nfcoxzfzE
        prPxiffVyKASqB6zBmA0TmYuXA==
X-Google-Smtp-Source: ABdhPJznZ+AHNcMJKPGfmI7E72r9ApIrvzDEbLZiFeHTaRZVBzc1h30T1+1JSTqagBoZh3uacL86SA==
X-Received: by 2002:a02:cc1b:: with SMTP id n27mr3811358jap.106.1615472195170;
        Thu, 11 Mar 2021 06:16:35 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x6sm1429790ioh.19.2021.03.11.06.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:16:34 -0800 (PST)
Subject: Re: [PATCH][next] usbip: Fix incorrect double assignment to
 udc->ud.tcp_rx
To:     Colin King <colin.king@canonical.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210311104445.7811-1-colin.king@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8862cf33-dc2b-1d62-d7ef-56f34c5b358d@linuxfoundation.org>
Date:   Thu, 11 Mar 2021 07:16:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311104445.7811-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 3:44 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently udc->ud.tcp_rx is being assigned twice, the second assignment
> is incorrect, it should be to udc->ud.tcp_tx instead of rx. Fix this.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: 46613c9dfa96 ("usbip: fix vudc usbip_sockfd_store races leading to gpf")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/usb/usbip/vudc_sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
> index a3ec39fc6177..7383a543c6d1 100644
> --- a/drivers/usb/usbip/vudc_sysfs.c
> +++ b/drivers/usb/usbip/vudc_sysfs.c
> @@ -174,7 +174,7 @@ static ssize_t usbip_sockfd_store(struct device *dev,
>   
>   		udc->ud.tcp_socket = socket;
>   		udc->ud.tcp_rx = tcp_rx;
> -		udc->ud.tcp_rx = tcp_tx;
> +		udc->ud.tcp_tx = tcp_tx;
>   		udc->ud.status = SDEV_ST_USED;
>   
>   		spin_unlock_irq(&udc->ud.lock);
> 

Thank you for finding and fixing this. This is my bad.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


