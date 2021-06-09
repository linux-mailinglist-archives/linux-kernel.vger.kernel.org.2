Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3ED3A1951
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhFIPZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbhFIPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:25:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB0DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 08:23:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id c13so19882960oib.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZFEb5EC9h4Oz558wWnJgGSYdu9KSgRo/Ld9B/b/Md7Y=;
        b=cQcyYlxISWWBA2YLmgU2YVXdQODOaPSyusUsSWNcjb5ImIMmwXUS3y20YkzKIx8Gwr
         CRrhp7FT5vtJbuIpiXWb8rn7eIMJA9g/JuOE/BqVGxzDZeRaZKtOAJDROtF4n9WNM5Uo
         jtVVNNeGQWmjT3hALCh2dGbzv2Ll+t04aAnAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZFEb5EC9h4Oz558wWnJgGSYdu9KSgRo/Ld9B/b/Md7Y=;
        b=IMV/EN3eA89KQr5XpdDr+S+PqosDNqT75K+72brplfFOqInzntF9MqjQQi2Kpia2Qj
         Z58IhugMpIycaRnKf5YGQrtq3TU3k2kemeDytIxF6cinOJDMfoJ6+31yaVA5/AmHtcUV
         tk+YNL70bvrG64/MKNqY4nwgoBLG2CJWZlmMbw+XyG8+FZugEqZay3aFZWuqcA5xYBy1
         spzWlGImSQJpOUebXkcJbMmZXnmOtFsbqUSNd/9Qzcnb0SNdd8wx6tKVIH4c9Jv8fQ5P
         BPkvAl4VSAEUGkZ+pKi6qmjFi17Wip+TLjp/ENbo4H0gOShN61LSlRG2LUVorLp8fKGG
         Qoag==
X-Gm-Message-State: AOAM530DZUsnCELiWpG4ia//YyteA7KrSUkkwE1wPD845s52CEUzOU7i
        HuSU9buUJdens4OrkwaXsaNZKxHoAroX2g==
X-Google-Smtp-Source: ABdhPJx+h5JcfyhNXaJ/xKmlw9d6bbCaq+UZA2pK0fHEP9513o4/OhyPZEM2zRePXQMHWN4oLYQAaA==
X-Received: by 2002:aca:4fd7:: with SMTP id d206mr6722685oib.16.1623252197949;
        Wed, 09 Jun 2021 08:23:17 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t15sm30975oie.14.2021.06.09.08.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:23:17 -0700 (PDT)
Subject: Re: [PATCH] usbip: tools: usbipd: use ARRAY_SIZE for sockfdlist
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1623232316-89719-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a6b75133-e85f-903e-82e3-c04cc2a14d00@linuxfoundation.org>
Date:   Wed, 9 Jun 2021 09:23:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623232316-89719-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 3:51 AM, Jiapeng Chong wrote:
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
> element.
> 
> Clean up the following coccicheck warning:
> 
> ./tools/usb/usbip/src/usbipd.c:536:19-20: WARNING: Use ARRAY_SIZE.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   tools/usb/usbip/src/usbipd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
> index 48398a7..4826d13 100644
> --- a/tools/usb/usbip/src/usbipd.c
> +++ b/tools/usb/usbip/src/usbipd.c
> @@ -532,8 +532,7 @@ static int do_standalone_mode(int daemonize, int ipv4, int ipv6)
>   		usbip_driver_close(driver);
>   		return -1;
>   	}
> -	nsockfd = listen_all_addrinfo(ai_head, sockfdlist,
> -		sizeof(sockfdlist) / sizeof(*sockfdlist));
> +	nsockfd = listen_all_addrinfo(ai_head, sockfdlist, ARRAY_SIZE(sockfdlist));
>   	freeaddrinfo(ai_head);
>   	if (nsockfd <= 0) {
>   		err("failed to open a listening socket");
> 

The change looks good. Does this change compile for you?
Doesn't for me?

thanks,
-- Shuah

