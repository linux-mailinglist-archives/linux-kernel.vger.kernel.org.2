Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF0339D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhCMKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCMKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:04:34 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43249C061574;
        Sat, 13 Mar 2021 02:04:34 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d3so49242733lfg.10;
        Sat, 13 Mar 2021 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XHzCLU2gfBw+CCZ6TwSpe4CeX5Ws75Y6YVcLoVVfgBo=;
        b=D7n4dHc8RuUzG7MZhLKIcPSVYx9/BrdCLibNb4VGweB4UHu2WIrtnZ+c7pO9hbw4wO
         y3MtjZnBBCZCt47eaKqrJ/G5477naUtbUAm8s/pTGfgOusrOxQahoMwCzl+/9UKm9sBr
         ZUtG5IjbzanDOZJFuUWvQQ3h3Up4sV3Q/YkCpjTiGy6ogz7SvbvMyZOI9XVb8rbDRJXO
         ED/0uf6RXkLRyRTZief0ikPbA1BdnovIL+ioNw0uso7jCWdpgGkMFPlMpEjkL/56Nzf9
         WuGsBOFgFO5LHyH2KJkZwN09gliuBgfXog6pi/0DXsnf5hpwdVQw+DfjYNNTd6ju3UDD
         KKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XHzCLU2gfBw+CCZ6TwSpe4CeX5Ws75Y6YVcLoVVfgBo=;
        b=t/Z3/2a7MKmMoFMGbDdRX087FL92MVCOBD5Q9zYqZczGhUweE89LSBYJcDtxj+EqQL
         OXaQ5kZH3LSgel6Bdkn6ZrFOaQ3qysZazabCwlKRFKg7l95V2e5lRvZ5RwZ1GSrYoTTE
         giW+Hthf8BPlKQjxR0IkD3hf6y4G+LtIWJteaFltg2pA4Ox1W9bAQrXzgWIGrDAhqvr2
         tw8EppzI1VfcRZ+5Wc6gXIJwBlCZk4pbRXBF6xHvHHL67Lo0Q20zxf4Fupf39UAjVb71
         6RN+MdTHsOfNT7D/zZh84wh6Ah9gQExllf3vn7UdaG2IRlHpfA/i0HAnqetA0CMsTszJ
         f9Zg==
X-Gm-Message-State: AOAM53253cSk/Lg0Y1dsjLNbUq6S12acUr3f1XWIXieBtJq0+keCDP/2
        incGX9AfX7WE4sJu9qyqP5nFlT7IZpYvwg==
X-Google-Smtp-Source: ABdhPJwHaIIeLR8/RZKG5e5kMyG/0lj0JEfcActcMeDAM9Jf+fPYjuF9ZbQUW/uW469M4gWPFFo5gw==
X-Received: by 2002:a05:6512:1109:: with SMTP id l9mr2220623lfg.559.1615629872578;
        Sat, 13 Mar 2021 02:04:32 -0800 (PST)
Received: from [192.168.1.101] ([31.173.82.251])
        by smtp.gmail.com with ESMTPSA id h62sm1969178lfd.234.2021.03.13.02.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 02:04:32 -0800 (PST)
Subject: Re: [PATCH 1/2] ata: delete redundant printing of return value
To:     Wang Qing <wangqing@vivo.com>, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1615621617-1343-1-git-send-email-wangqing@vivo.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <01c746e9-51bf-0320-eb20-06e939de39b0@gmail.com>
Date:   Sat, 13 Mar 2021 13:04:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615621617-1343-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   The patch subject should reflect the exact patch locus, e.g. "ata: libahci_platform:
delete redundant printing of return value".

On 3/13/21 10:46 AM, Wang Qing wrote:

> platform_get_irq() has already checked and printed the return value, 
> the printing here is nothing special, it is not necessary at all.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index de638da..2e7ea75
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -582,11 +582,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  	int i, irq, n_ports, rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> +	if (irq <= 0)
>  		return irq;
> -	}

   This code has more serious problem: it returns 0 on error as if it was success.
Should be changed to *if* (irq < 0) (in a separate patch).

MBR, Sergei
