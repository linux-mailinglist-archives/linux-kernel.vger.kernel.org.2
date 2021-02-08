Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDBC3143D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBHXeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBHXem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:34:42 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88DCC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 15:33:56 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e24so1090471ioc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1RkSumXgFbifK19xnhA0y1wci8RIXXXC9d0wD+ipx2w=;
        b=FUXmQ0qqVlsaaPulIH4efsX6a3pBJHY43UofmlXJqk+zN/AJ65fw5J74k5PeQBThtn
         mJ+mLylL5do4fotCZjq39arwX6unhjNoaX8WQhWBUxs1CeK1mFmHgCO+v2WMIdvJqlzm
         wZArCWF+/9NzU1KcEPqdDykoGdzpIK7rPBxSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1RkSumXgFbifK19xnhA0y1wci8RIXXXC9d0wD+ipx2w=;
        b=IrRWjdc6sUywNu+V3UTOFTW8UmKm9uUJADKoqg/JOFwdrl8aOQZR9WOSow+g1FzTw7
         W1bcE3XaL9BOOD4+g//RiEO3LRFxY5a2aaRxcD7i5faHhSsisOQmtMmDUO64Q9VGoHgM
         dpKuUK53qBkTJ2bb8NT/B5AZVLSnBi4aFwrWUneoYUUA/grRCIAhRpfzK0QggbzyWIeG
         MELbfoecvoKx8GDXwC2hnfUfKtwllWp/jTJuFxbv0gxYGnCsSB0RWWrG2+285w/HT7rf
         sPVrPlVaiygLC5aiAzIS0PRaGw+Vlt0Aeq30cskAltDMf2RY32Ywx9aziZL2KCVZkq9V
         Ttjw==
X-Gm-Message-State: AOAM5329lzVNzCfFfi6ohnrEVSSQfMCvc0C1G8mT3drBoxYsIyWfqqeB
        DDVONpOLkagYcGIYwGUe5veUQg==
X-Google-Smtp-Source: ABdhPJxYsZIxSz+PeWuzU/mVsPeSqy6iv+ztT3NWWkfx3daXYsL544wTQNJTwgP0skkBQHewIEdLiQ==
X-Received: by 2002:a02:cd37:: with SMTP id h23mr19658663jaq.29.1612827235572;
        Mon, 08 Feb 2021 15:33:55 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f15sm9510502ilj.23.2021.02.08.15.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 15:33:54 -0800 (PST)
Subject: Re: [PATCH] selftests/ipc: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>, shuah@kernel.org
Cc:     tyhicks@linux.microsoft.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1612779840-77555-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <75573614-2915-54fd-9da1-9d979feaae96@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 16:33:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612779840-77555-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 3:24 AM, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./tools/testing/selftests/ipc/msgque.c:72:3-4: Unneeded semicolon
> ./tools/testing/selftests/ipc/msgque.c:183:2-3: Unneeded semicolon
> ./tools/testing/selftests/ipc/msgque.c:191:2-3: Unneeded semicolon
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   tools/testing/selftests/ipc/msgque.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
> index 5ec4d9e..656c43c 100644
> --- a/tools/testing/selftests/ipc/msgque.c
> +++ b/tools/testing/selftests/ipc/msgque.c
> @@ -69,7 +69,7 @@ int restore_queue(struct msgque_data *msgque)
>   			printf("msgsnd failed (%m)\n");
>   			ret = -errno;
>   			goto destroy;
> -		};
> +		}
>   	}
>   	return 0;
>   
> @@ -180,7 +180,7 @@ int fill_msgque(struct msgque_data *msgque)
>   				IPC_NOWAIT) != 0) {
>   		printf("First message send failed (%m)\n");
>   		return -errno;
> -	};
> +	}
>   
>   	msgbuf.mtype = ANOTHER_MSG_TYPE;
>   	memcpy(msgbuf.mtext, ANOTHER_TEST_STRING, sizeof(ANOTHER_TEST_STRING));
> @@ -188,7 +188,7 @@ int fill_msgque(struct msgque_data *msgque)
>   				IPC_NOWAIT) != 0) {
>   		printf("Second message send failed (%m)\n");
>   		return -errno;
> -	};
> +	}
>   	return 0;
>   }
>   
> 

Thank you. Now applied to linux-kselftest next for 5.12-rc1

thanks,
-- Shuah
