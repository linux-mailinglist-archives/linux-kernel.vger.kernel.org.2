Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C701531F564
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBSHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBSHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:37:43 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD247C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:37:02 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id y7so13120368lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hMFTSQVEQdn8VWL0ezmTYZhJ794Avz6LQ2YGElVmR+g=;
        b=J5ZjRaRYv9jAGNuog88pH01utfrJHP9eb8F+rg+agHiWogWsXTJTbBzOHIRFC/d8uD
         UANShOhkCnFg6wLMZ3m7ZZ07bII2n5QrFVzL/KK0DTMHuee2ePW9mzkcueGnamJciNCw
         7nKAlAs5ljEWGeAU/8XQQY6lCbODrn03KxYVo6UF2T1gLY836OQXIGxtZjBGTspcAXmJ
         IZ/AekqQaJkb6prwgBj9YmZnYcreUGxvStvxlpafSWHMlmB4yLPSBe1fSbtmlDaIul4P
         ukMo/KsVgwUd2Cx4FwF+ndys5Q4pvQw2asQlxzu3LS/1g4ua+3/g7EvCQLdzhbU7odi7
         9fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hMFTSQVEQdn8VWL0ezmTYZhJ794Avz6LQ2YGElVmR+g=;
        b=KPOqKDa/rwOgTzcF4i8DeFLG19txJzIeLPMHPKtkgQKqx6b78bLDV1IyPurXospv8l
         80neAy7Qo40LHri/roOVEo0llKQyCXiAn/hOxcjzB/310GCDK6uebtrc1kjPpNyoaDsS
         hOataucaTrI1MVuSz61lcucdHGLDkhLlYtF3W/uvE2KgVWXGQs0Y7kJg5yIB62cQaf6a
         TyfnvkVbMyakA0HtD+KBCYaE3mzZ0O5u8681E43OIGMXElDRfdEo/7ADOMedII/UKAwL
         kUrt7GtEhREymoX8S7E1CAadb5HaOgWbba0vYfHUHU5qfwOgUlUHXDkBV+2B/6bKwzJX
         ZO7g==
X-Gm-Message-State: AOAM533BtT7J5i3MJUZjmwLxXYUpjbzKqmfCF9soFLfFZUSt0N6hpMqf
        7EnxnhQm00tLoallMEKEb8Y=
X-Google-Smtp-Source: ABdhPJw88JAS94euyyb7uOlXgZYpRNzmJje7834JAO9tSY5FyJTv314ZupV4vwoS+s7zRSY5WelwFA==
X-Received: by 2002:a2e:878a:: with SMTP id n10mr4719780lji.418.1613720221307;
        Thu, 18 Feb 2021 23:37:01 -0800 (PST)
Received: from [192.168.0.160] (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id c18sm842938lft.258.2021.02.18.23.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 23:37:00 -0800 (PST)
Subject: Re: [PATCH] staging: wlan-ng: Fixed incorrect type warning in
 p80211netdev.c
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210217154255.112115-1-pritthijit.nath@icloud.com>
Cc:     devel@driverdev.osuosl.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pritthijit Nath <pritthijit.nath@icloud.com>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <71a79d2e-6f03-c2c6-738a-8b862f52e48f@gmail.com>
Date:   Fri, 19 Feb 2021 10:37:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210217154255.112115-1-pritthijit.nath@icloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/21 6:42 PM, pritthijit.nath at icloud.com (Pritthijit Nath) wrote:
> This change fixes a sparse warning "incorrect type in argument 1
> (different address spaces)".
> 
> Signed-off-by: Pritthijit Nath <pritthijit.nath at icloud.com>
> ---
>   drivers/staging/wlan-ng/p80211netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> index 6f9666dc0277..70570e8a5ad2 100644
> --- a/drivers/staging/wlan-ng/p80211netdev.c
> +++ b/drivers/staging/wlan-ng/p80211netdev.c
> @@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
>                  goto bail;
>          }
>   
> -       msgbuf = memdup_user(req->data, req->len);
> +       msgbuf = memdup_user((void __user *)req->data, req->len);
>          if (IS_ERR(msgbuf)) {
>                  result = PTR_ERR(msgbuf);
>                  goto bail;
> 

Reviewed-by: Ivan Safonov <insafonov@gmail.com>
