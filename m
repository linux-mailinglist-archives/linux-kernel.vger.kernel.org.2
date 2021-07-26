Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD03D659B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbhGZQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhGZQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:43:23 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC213C0619E0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:56:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t128so11686220oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ug9Slp+aolg7bj7KGTexduQ8AvEecT+aSkkQAF+jKqE=;
        b=gbdhJhRaCXa0Lic9E5X3tAblAG9tIGlEP8VOLug+LYsyOZ9R/2pCDzEDel8sCwicjZ
         YocxR3Y69pWXQaFgTxoYez9P1bAlUrl2V3Hj/vJPUF4rBg/3vjaI6d1fZ8XzxXl4GvD+
         pGv0dNhrpePgC8OVleXgNuiRdzIGW3AFXbBao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ug9Slp+aolg7bj7KGTexduQ8AvEecT+aSkkQAF+jKqE=;
        b=KfCH9FZFRZn1n4Zxa838mKtJc8AuMJhQpkoKSZ/nNH1X/AgInUNJY+5gJpR28+7fCo
         rQzJnj3U2vr6P7SHoa7ShNKox4IO9N35Jtg8agNWUzJ/1vxXVf4s3fzxEbRiq04SS0Hm
         iHRypKcXwDAnO3qDla+AMnpBpUmhMW52wrFDYIYfNBstMXuxxGJ1K1nrk9yGHyS3NopT
         DJGXRVPjKPTJGVcAMAj5a40yEfb/qVC3xGMh3Ff7tbj2EyVluSENoD+ROuQuOozh5e4J
         DsNDbU3/iL9GKLp90v6Qn+K85gUjXT0FFWslTMjTqfFokC1V4cnbND/IfCSYkIQ6NhmU
         Z6Bg==
X-Gm-Message-State: AOAM533HtmtuhKKwZh97by/ZwkBAHVp6OXNwXe3kh6nExciUAkmA/vAQ
        tx6JPusDcKfMT0ZSL5SxaDSoow==
X-Google-Smtp-Source: ABdhPJzCRRlIfJ6V/rG85JvFFYFRB0C6qZQ4VwVMB4X0WLPrxFy6OvIcOiP9Pmmvecga7/8gNwpNCA==
X-Received: by 2002:aca:1719:: with SMTP id j25mr17529366oii.36.1627318615164;
        Mon, 26 Jul 2021 09:56:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c64sm81996oif.30.2021.07.26.09.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 09:56:54 -0700 (PDT)
Subject: Re: [PATCH v7 1/2] firmware_loader: use -ETIMEDOUT instead of -EAGAIN
 in fw_load_sysfs_fallback
To:     Anirudh Rayabharam <mail@anirudhrb.com>, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210724121134.6364-1-mail@anirudhrb.com>
 <20210724121134.6364-2-mail@anirudhrb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7f325bb2-c18c-38e1-e6e3-8f6a89ea17dc@linuxfoundation.org>
Date:   Mon, 26 Jul 2021 10:56:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210724121134.6364-2-mail@anirudhrb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 6:11 AM, Anirudh Rayabharam wrote:
> The only motivation for using -EAGAIN in commit 0542ad88fbdd81bb
> ("firmware loader: Fix _request_firmware_load() return val for fw load
> abort") was to distinguish the error from -ENOMEM, and so there is no
> real reason in keeping it. -EAGAIN is typically used to tell the
> userspace to try something again and in this case re-using the sysfs
> loading interface cannot be retried when a timeout happens, so the
> return value is also bogus.
> 
> -ETIMEDOUT is received when the wait times out and returning that
> is much more telling of what the reason for the failure was. So, just
> propagate that instead of returning -EAGAIN.
> 
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>   drivers/base/firmware_loader/fallback.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 91899d185e31..1a48be0a030e 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -535,8 +535,6 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>   	if (fw_state_is_aborted(fw_priv)) {
>   		if (retval == -ERESTARTSYS)
>   			retval = -EINTR;
> -		else
> -			retval = -EAGAIN;
>   	} else if (fw_priv->is_paged_buf && !fw_priv->data)
>   		retval = -ENOMEM;
>   
> 

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
