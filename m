Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7376C3F7578
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhHYM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:58:07 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36358 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240078AbhHYM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:58:06 -0400
Received: by mail-wm1-f50.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so4254309wme.1;
        Wed, 25 Aug 2021 05:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IG8qKdffC7gdvGfE8uAq0sKcTN9fnBfsEwkWoC4/ddk=;
        b=C6ZjJ4aBPE8EQ92uTG+NflfUFhxxSFW973calEllJL8UbczEqk2Fifv5aDdNpDoN0V
         ouvRzZTEFP544d3Fcv1Q0rfRcZ/yo2hbL1DebHBBRxZHYlqwA1PTpGZw8E9VbUKK2UT9
         JaEQPiasqj5e28QKZK+t6p1ZY2JDmgqq8cYdj+yIa3rdAalfMs8Ncpv2T+8etnszzf3v
         le2/ZoUsFFHKL7lkMyJFW75pH64pbUlAIx7M5QsMzR47bkwPLl0uplh2498Qkiq/hWh1
         20H8duLDG933CSei0RPA3XRyW+3GyBuJMKcx9Vrw58m1IrvlSsnHn0mvQOx0sFnnj3WX
         YijA==
X-Gm-Message-State: AOAM5307okU0l0Nalusx/2WeAqHGZFu1CPbUciFqZ2NAZ9XWLs+YIhvh
        UO9g2fkoP0+OMyvjDJWhNFr6b5TPQD8=
X-Google-Smtp-Source: ABdhPJydt2KoXOb8cPtUG5GcXDzc+2AOh9dS7oyCgSRxmxv2oZRFP4uz0TchHSZa3V2LqedKady1TA==
X-Received: by 2002:a7b:c048:: with SMTP id u8mr9239781wmc.113.1629896239498;
        Wed, 25 Aug 2021 05:57:19 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h6sm6086473wmq.5.2021.08.25.05.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:57:18 -0700 (PDT)
Subject: Re: [PATCH] mxser: use semi-colons instead of commas
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210825072435.GB13013@kili>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <cf2ce3bc-323d-b622-214a-62cd012f29ad@kernel.org>
Date:   Wed, 25 Aug 2021 14:57:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825072435.GB13013@kili>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 08. 21, 9:24, Dan Carpenter wrote:
> This code works, but it's cleaner to use semi-colons at the end of
> a statement instead of a comma.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/mxser.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index 335e4e50d679..1216f3985e18 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -1039,12 +1039,12 @@ static int mxser_get_serial_info(struct tty_struct *tty,
>   	if (closing_wait != ASYNC_CLOSING_WAIT_NONE)
>   		closing_wait = jiffies_to_msecs(closing_wait) / 10;
>   
> -	ss->type = info->type,
> -	ss->line = tty->index,
> -	ss->port = info->ioaddr,
> -	ss->irq = info->board->irq,
> -	ss->flags = info->port.flags,
> -	ss->baud_base = MXSER_BAUD_BASE,
> +	ss->type = info->type;
> +	ss->line = tty->index;
> +	ss->port = info->ioaddr;
> +	ss->irq = info->board->irq;
> +	ss->flags = info->port.flags;
> +	ss->baud_base = MXSER_BAUD_BASE;
>   	ss->close_delay = close_delay;
>   	ss->closing_wait = closing_wait;
>   	ss->custom_divisor = MXSER_CUSTOM_DIVISOR,
> 


-- 
js
suse labs
