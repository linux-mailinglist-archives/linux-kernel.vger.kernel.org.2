Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C56321CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhBVQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhBVQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:22:33 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01BFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:21:51 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id a16so11306419ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O2UdjypR4W3iDVOy5hnKP5de6BTPFEvlQ6oGQr/tzUY=;
        b=QWYr4qA6Wc1K2uzDRbRDKEFJU9VggdyiFbE9noSMExFmpSB/WSH/g2hR2wobF0KpKU
         aVmWFkaH9gj8GcMoYdDsRvYawy/kizivt/PojhfqMjCVxWyJwyMAmuZjBr0OPFcPerai
         XoppCFZUi/lHoq1JIO0Y7Bw+vx/Vb9gdiubmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O2UdjypR4W3iDVOy5hnKP5de6BTPFEvlQ6oGQr/tzUY=;
        b=PeajbLeWSOlQEAKKWHRQ5glscIppgF/kjKPoYtTFo1KoWyWEHin/jOzfEOq6zVvVM9
         OemLpSGdQmmymYcL5Ixh4vhkJM9GIhPpqruPfXZ265Y3W5FTeVUzroy4LLzLtAOfIIpg
         uBDUxtUwIaYLDRB/zj+piUaxO8C/0yDbr+Bd9Rn3h63o8ZE3d9K19GxtoIpPVlmc5VNC
         3KYe9PuRJfTo/hK7A1VwOGiV8Ey1mkzQQgXMvOVMtjoL0+0fAXQrRgqi34Ygm79asRaH
         1Gj6r3ke1bB4l72MNvWCdyRvCHUKrU1HJeQ+C7m2JTkcKLwCMCDXcarHczholRoV7AaD
         u1QQ==
X-Gm-Message-State: AOAM532iiw0oaU+laWpFXw2aoD0GamgPGLIXsqOYrrZoBxDllyVLngl7
        OkjiSH2bYCpoH3ykrYPMyGLMgg==
X-Google-Smtp-Source: ABdhPJwFg4oQJS2b8UUSE1H4Y8Chs7Kox5qlda5aF9f45HJogdaR2sWCL7VTfnIvoEcooK4vehk05A==
X-Received: by 2002:a92:1312:: with SMTP id 18mr15099286ilt.92.1614010911339;
        Mon, 22 Feb 2021 08:21:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b16sm5383378ilq.49.2021.02.22.08.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 08:21:51 -0800 (PST)
Subject: Re: [PATCH 19/20] usbip: usbip_host: Manual replacement of the
 deprecated strlcpy() with return values
To:     Romain Perier <romain.perier@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210222151231.22572-1-romain.perier@gmail.com>
 <20210222151231.22572-20-romain.perier@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0323dcb2-726c-7ea2-8e8b-dba81090b571@linuxfoundation.org>
Date:   Mon, 22 Feb 2021 09:21:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210222151231.22572-20-romain.perier@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 8:12 AM, Romain Perier wrote:
> The strlcpy() reads the entire source buffer first, it is dangerous if
> the source buffer lenght is unbounded or possibility non NULL-terminated.
> It can lead to linear read overflows, crashes, etc...
> 
> As recommended in the deprecated interfaces [1], it should be replaced
> by strscpy.
> 
> This commit replaces all calls to strlcpy that handle the return values
> by the corresponding strscpy calls with new handling of the return
> values (as it is quite different between the two functions).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>   drivers/usb/usbip/stub_main.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index 77a5b3f8736a..5bc2c09c0d10 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -167,15 +167,15 @@ static ssize_t match_busid_show(struct device_driver *drv, char *buf)
>   static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
>   				 size_t count)
>   {
> -	int len;
> +	ssize_t len;
>   	char busid[BUSID_SIZE];
>   
>   	if (count < 5)
>   		return -EINVAL;
>   
>   	/* busid needs to include \0 termination */
> -	len = strlcpy(busid, buf + 4, BUSID_SIZE);
> -	if (sizeof(busid) <= len)
> +	len = strscpy(busid, buf + 4, BUSID_SIZE);
> +	if (len == -E2BIG)
>   		return -EINVAL;
>   
>   	if (!strncmp(buf, "add ", 4)) {
> 


Looks good to me. Thank you.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
