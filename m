Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05BD3F757C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhHYM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:59:08 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43963 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhHYM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:59:07 -0400
Received: by mail-wr1-f54.google.com with SMTP id b6so862009wrh.10;
        Wed, 25 Aug 2021 05:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wwe/J8mBY/TaPRtsNckUmhHBlK7cRB4Yt9ENNgx5/do=;
        b=jc0aIDWF09V19rFF5D2rzZ0RCeqeekYMhlZ2H8iMiZo2RZtdOjR/H0tkrqphHKOfXB
         f3qs1xIW9cd/6LmcK5ztJoSi9/16iiCu/Iuls0mSD9qOocJbt3qdEAgGB86MA/mJjPSS
         lW/Bx7Ijpg/OGH8I3lac5Fn5GbL0BdS0vzfYneV0g+QcXdQNMF+5pUeszc3Tgq0cvGCM
         xiPyanYgTgTnlQo8YxAzqqQqWVTh++6QTiefizvbixjl0JnJA32zrr5DCc1xgV6+g/RA
         P0nIkEwk6uP2uUjoJSvW3CZJZ7a+U6hfeW7Y2kFQL7V6muaW4xSmHBubJ0Vi8Bg7aiCr
         BNuw==
X-Gm-Message-State: AOAM5318DUoErhxoHhoJns0aNM4Vbsf89BBB/BTYzPRNuEV3lTCPlsVo
        XLlAmXfJa2gGA5iP1DWdsZUvXWkK5FE=
X-Google-Smtp-Source: ABdhPJxRW9u1MKQNTmOCi0t0QdAaBYxnEq8z+07rGLF/myKh+hb5XMeuDkcnyuWw+vxihpCpwWVskA==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr25284553wrm.394.1629896300511;
        Wed, 25 Aug 2021 05:58:20 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t7sm18563460wrq.90.2021.08.25.05.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:58:20 -0700 (PDT)
Subject: Re: [PATCH] tty: moxa: use semi-colons instead of commas
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210825072405.GA13013@kili>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <67c7047a-93eb-d5fe-514d-6545b5899991@kernel.org>
Date:   Wed, 25 Aug 2021 14:58:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825072405.GA13013@kili>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 08. 21, 9:24, Dan Carpenter wrote:
> This code works but it's cleaner to use a semi-colon to end a statement
> instead of a comma.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

I just wonder why:
   tty: moxa:
vs
   mxser:
with no "tty: "
...

> ---
>   drivers/tty/moxa.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
> index 776f78de0f82..bf17e90858b8 100644
> --- a/drivers/tty/moxa.c
> +++ b/drivers/tty/moxa.c
> @@ -2034,10 +2034,10 @@ static int moxa_get_serial_info(struct tty_struct *tty,
>   	if (!info)
>   		return -ENODEV;
>   	mutex_lock(&info->port.mutex);
> -	ss->type = info->type,
> -	ss->line = info->port.tty->index,
> -	ss->flags = info->port.flags,
> -	ss->baud_base = 921600,
> +	ss->type = info->type;
> +	ss->line = info->port.tty->index;
> +	ss->flags = info->port.flags;
> +	ss->baud_base = 921600;
>   	ss->close_delay = jiffies_to_msecs(info->port.close_delay) / 10;
>   	mutex_unlock(&info->port.mutex);
>   	return 0;
> 


-- 
js
suse labs
