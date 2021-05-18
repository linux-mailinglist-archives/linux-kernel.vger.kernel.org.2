Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F783870FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbhERE4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:56:40 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52109 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhERE4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:56:37 -0400
Received: by mail-wm1-f47.google.com with SMTP id u133so4652078wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Ungkuc7DNEwgVqaIs0sUmfvZfLjk8Y4sPxPXf/HMgg=;
        b=clef55snHowrx+6QVn0F14N+ooyAnlXR1NT6R5mvmspzw9wp2eIq1A53xv6UIt0DBS
         E4e8C4EeWzVj6Kt5JVNPrK/Bgssbj+76UjGJrnYFGJcsIC3Ys9027Pu55PznXKP5FiwS
         aCvUPoCjlVvqS9UjdhlKLWO6o1RaP/+10A6Pm/3/qH1QdvSLBD9xosG4mHA2NfY1O7Tz
         f4AJbrUCmy39SHK0ZlTW9VONOGi+L/k8RlFYB0wOdUxebPCjYpcF7KvwrgM5v+Cb2Ba3
         AeJI7OcTjbsEUIYAVNBCFcnWs20x+FwuExVt8xKkEJqqWmP1tDe1LTIa0NHarzY1XmtC
         6Jng==
X-Gm-Message-State: AOAM5308oVCjK+GbIH5gLzLR7rkIDEyBbTql4OGV9llyW9oaXO0k30+e
        vsUsYY3v7WckY4G9Cii7KmTPkOPMh+I=
X-Google-Smtp-Source: ABdhPJxX5P2qWBfUBkSH00o1UnxTl0deSKNbF+LL1AElWitvVBFoHWG5BsH6NsCjo/2PiKm4OxqtKw==
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr3234915wme.181.1621313719719;
        Mon, 17 May 2021 21:55:19 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s15sm279417wrt.54.2021.05.17.21.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 21:55:19 -0700 (PDT)
Subject: Re: [PATCH -next] tty: pty: correct function name pty_resize()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
References: <20210518045353.611017-1-yangyingliang@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0c9459d9-dcca-4d39-c113-7bda02158381@kernel.org>
Date:   Tue, 18 May 2021 06:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518045353.611017-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 05. 21, 6:53, Yang Yingliang wrote:
> Fix the following make W=1 kernel build warning:
> 
>    drivers/tty/pty.c:307: warning: expecting prototype for pty_do_resize(). Prototype was for pty_resize() instead
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/pty.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 9b5d4ae5d8f2..416471195e5a 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -295,7 +295,7 @@ static void pty_set_termios(struct tty_struct *tty,
>   }
>   
>   /**
> - *	pty_do_resize		-	resize event
> + *	pty_resize		-	resize event
>    *	@tty: tty being resized
>    *	@ws: window size being set.
>    *
> 

thanks,
-- 
js
suse labs
