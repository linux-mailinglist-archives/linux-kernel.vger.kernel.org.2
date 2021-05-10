Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667EA378080
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhEJJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:54:41 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37716 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhEJJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:52:37 -0400
Received: by mail-wm1-f54.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso10779481wmj.2;
        Mon, 10 May 2021 02:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqrzfth2vQXxqsJTeCMpMZf0Wa6kexMFJ4z/H3+4Fqg=;
        b=aWyQCW8msaJ5rOiZ2PJlpLQOVWhEY0jJvXYsllmJzAUdyg2EmyHM7Zb3ORy09uFhJJ
         9VOvi653snqbQU6PmKbA80iljCM3LHJe+Zyh4ltfdAAEyDsQpYM5qSiTKRe1XCSqI7Y+
         jYKE64qatvIkdWcf44WC9Uq0Y/FhZ0qsrHwKWPBWI/PjU7hU3cl16cqvWik5225eMf1S
         dN6U1jwWi8V2CZaiFnQHPQ+lEWBeF8d4zkINVqhwQcttD8gFX3QNluYpHCr3hAymnNIp
         5bcmiikLLRZ1WuXlLTYIvqkgpnmM5DBlVesurBRMy2JXrtnS91bQPxPwU/XcPZakTafP
         5y2g==
X-Gm-Message-State: AOAM5323pJTEO2NFBOLj8mylEpRpUxb9GOpX1t9YDUwmL9Xi4YVZiw8S
        928CTAFFACETAn+NVHpSxEziOxhulL8=
X-Google-Smtp-Source: ABdhPJwYXBi6Jv9MIRSt/zTdWKJijZ0Qgn1Hl47sz6JgSv9iQ1g8XCRLEBdb2/8ItSQzGJ/vLQIDcg==
X-Received: by 2002:a7b:c7c5:: with SMTP id z5mr34244569wmk.184.1620640277782;
        Mon, 10 May 2021 02:51:17 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j13sm21964872wrw.93.2021.05.10.02.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 02:51:16 -0700 (PDT)
Subject: Re: [PATCH] tty: nozomi: Fix a resource leak in an error handling
 function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        stefani@seibold.net
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <4f0d2b3038e82f081d370ccb0cade3ad88463fe7.1620580838.git.christophe.jaillet@wanadoo.fr>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <749cb98d-07d6-740e-1d2d-46306520089b@kernel.org>
Date:   Mon, 10 May 2021 11:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <4f0d2b3038e82f081d370ccb0cade3ad88463fe7.1620580838.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 05. 21, 19:22, Christophe JAILLET wrote:
> A 'request_irq()' call is not balanced by a corresponding 'free_irq()' in
> the error handling path, as already done in the remove function.
> 
> Add it.
> 
> Fixes: 9842c38e9176 ("kfifo: fix warn_unused_result")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> I also wonder if the loop above is correct. The 'i < MAX_PORT' looks really
> spurious to me.
> 'tty_port_destroy' can be called twice for the same entry (once before
> branching in the error handling path, and once in here) and
> 'tty_unregister_device'/'tty_port_destroy' will be called on entries
> that have not been 'tty_port_init'ed or 'tty_port_register_device'd.
> I don't know if it may be an issue.

Yes. The fail path handling is very broken there. Both the code of 
err_free_tty label, and of the err_free_kfifo label. The loops should 
have been _something_ (I didn't invest much thinking into it, so it's 
likely wrong) like:
for (i--; i--; ) {
    ...
}


> ---
>   drivers/tty/nozomi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> index 9a2d78ace49b..b270e137ef9b 100644
> --- a/drivers/tty/nozomi.c
> +++ b/drivers/tty/nozomi.c
> @@ -1420,6 +1420,7 @@ static int nozomi_card_init(struct pci_dev *pdev,
>   		tty_unregister_device(ntty_driver, dc->index_start + i);
>   		tty_port_destroy(&dc->port[i].port);
>   	}
> +	free_irq(pdev->irq, dc);
>   err_free_kfifo:
>   	for (i = 0; i < MAX_PORT; i++)
>   		kfifo_free(&dc->port[i].fifo_ul);
> 

thanks,
-- 
js
suse labs
