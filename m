Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66643319086
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBKRAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhBKPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613058621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFie4b8IIggJBAyOAfk90BEtab+sed/Odrk1Xr+jPYU=;
        b=ixgLfnaXOfLCKXfxLj6RvzlwNk/VtU5sGdfKxysfcbjNEww8YTw5t4XAJiy6AhkxLlJt+N
        aPDWJ3t/BYk+CY53tuCfXkb+KCuOZxOnkn6UPXSA1hUTPQ1skEC0pDuotfenf3minDK0uO
        u4IDP1XYSZY+crR9R/1uuMOt4wTJ41M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-8ZGfDgr4OiWZTkhlSKQUMQ-1; Thu, 11 Feb 2021 10:50:19 -0500
X-MC-Unique: 8ZGfDgr4OiWZTkhlSKQUMQ-1
Received: by mail-ej1-f70.google.com with SMTP id yh28so5018715ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFie4b8IIggJBAyOAfk90BEtab+sed/Odrk1Xr+jPYU=;
        b=oQHIqEXTvKwKQYsfgQDtfHUezVQKpF/RvoGzwwIqAcy5q5CUUjZvcl7HnUYMRQGxrF
         nE67XWws7S1zpuVpKNqYhtISS3jlhNsf8GbryMX6iFrY5At/e503k35adVxCpJv7FUff
         v+FNoNnqZRNJIH8mHYVI80bxOcGZrtqd+bo6+EVv+W/n9h+yHC1z+d1nr5HEx+SPS9EB
         IrcNY65fvn2rOuQ3Q/YFmnMj2vAZ2lCiOXKcV83kCXy/2EYR0BVibPH7qE+g2qhfXlAk
         78FUiNWBBQx3nT4o+Lr4ipXG3s5WaDqMVNENX4FEdheICiJmerwBUXHdo61q2DOCXSWP
         bMmg==
X-Gm-Message-State: AOAM532NsN85tLVL31jy6Wl5A7le4ix8z0J58+PJNqhF1TgI1htWhDDS
        SetgV4Tv/QgBtY+mxCt3m2tBgzGgNjrCtTRhe5h6VRHs74hCBh6kfSW7sSqYLljx9h1bdyheZJ/
        Fg8Vp1YJ3sXkk45CeMaHkaOYe
X-Received: by 2002:a17:906:2993:: with SMTP id x19mr8719281eje.409.1613058618554;
        Thu, 11 Feb 2021 07:50:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrvTuvWfiuzdxsmc2sdY/DkovUffsQYFa4iEEUwrewwyy70yZLSYdjQjhLcGIuO5NwnNns3Q==
X-Received: by 2002:a17:906:2993:: with SMTP id x19mr8719270eje.409.1613058618394;
        Thu, 11 Feb 2021 07:50:18 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i6sm4567051ejd.110.2021.02.11.07.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 07:50:17 -0800 (PST)
Subject: Re: [PATCH v2] platform/surface: aggregator: Fix access of unaligned
 value
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linx.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-test-robot <lkp@intel.com>
References: <20210211124149.2439007-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <824cb5dc-4594-fb00-a777-88189c41d62e@redhat.com>
Date:   Thu, 11 Feb 2021 16:50:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211124149.2439007-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/21 1:41 PM, Maximilian Luz wrote:
> The raw message frame length is unaligned and explicitly marked as
> little endian. It should not be accessed without the appropriate
> accessor functions. Fix this.
> 
> Note that payload.len already contains the correct length after parsing
> via sshp_parse_frame(), so we can simply use that instead.
> 
> Reported-by: kernel-test-robot <lkp@intel.com>
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
> 
> Changes in v2:
>  - Use payload.len instead of getting the frame length directly. Note
>    that payload.len equals the frame length and is already correctly set
>    in sshp_parse_frame(), so they are exactly the same thing. Makes it
>    look a bit nicer though.
> 
>    I did drop the ACKs/Reveiewd-by in case you want to check that
>    yourselves and since that's essentially the whole change.
> 
> ---
>  drivers/platform/surface/aggregator/ssh_packet_layer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 583315db8b02..15d96eac6811 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1774,7 +1774,7 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
>  		break;
>  	}
>  
> -	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(frame->len);
> +	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(payload.len);
>  }
>  
>  static int ssh_ptl_rx_threadfn(void *data)
> 

