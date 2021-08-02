Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A283DD11A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhHBHZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:25:26 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:41856 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhHBHZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:25:25 -0400
Received: by mail-ej1-f51.google.com with SMTP id x11so28410026ejj.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 00:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcetUWPb8culgJfYwcXyd4enV0COOIi+oGgXXHCJxs8=;
        b=kTt84qINj5N5gTXBGk9fMhNsqnP+XO5ahzaHBM/BHhvdufKyM810SIVRSNAk6h6CmI
         Zj+4UZ4b2JTdSHVlegPyXXfbVasbDqhA4SSmDsX3Gm1c7D4+I4usHLMoFcGprbzwswGU
         SreMiL8EgR/17sO3oM5V5vIMHYyODpXyd51ODUVE6CsP5s5mQK+/kNZ0BMoGoHe1YHMh
         pZhrYp0OLM07LSvQ2gXJRp85y5tlwiU8lUpfmzMLn0RdLZxkHBt0n0J5Z02V3xZDatpO
         9DyMBgECgCsgqba7k5s8ck8rovsb4TXWHm+PQ1tyTypmPLN4locXqdq4NH3XKzsB3V+o
         W/6w==
X-Gm-Message-State: AOAM5334cCPBenRM1G9DTQRmObf2dUSdQJgsPR5NJEE6DjrwFG2x4vWa
        dJL0Fp+jm2hHHq0qGNMl3sQ=
X-Google-Smtp-Source: ABdhPJxWTIdE9MBJiFVNAsUjUXU9AE4QP/vAPTBU9gQDwWpXVj1nFXiA6JbVTS8aEqGldEf1vZCzFQ==
X-Received: by 2002:a17:906:394:: with SMTP id b20mr14197279eja.462.1627889114838;
        Mon, 02 Aug 2021 00:25:14 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i11sm5384121eds.72.2021.08.02.00.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 00:25:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] virtio-console: remove unnecessary kmemdup()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, osandov@fb.com
References: <20210801051655.79048-1-xianting.tian@linux.alibaba.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <b5554967-a683-96ae-deb9-2d4980d33b41@kernel.org>
Date:   Mon, 2 Aug 2021 09:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210801051655.79048-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

why is this 2/2? I seem (Lore neither) to find 1/2.

On 01. 08. 21, 7:16, Xianting Tian wrote:
> hvc framework will never pass stack memory to the put_chars() function,

Am I blind or missing something?

hvc_console_print(...)
{
   char c[N_OUTBUF]
...
   cons_ops[index]->put_chars(vtermnos[index], c, i);

The same here:

hvc_poll_put_char(..., char ch)
{
...
    n = hp->ops->put_chars(hp->vtermno, &ch, 1);

AFAICS both of them *pass* a pointer to stack variable.

> So the calling of kmemdup() is unnecessary, remove it.
> 
> Fixes: c4baad5029 ("virtio-console: avoid DMA from stack")

This patch doesn't "Fix" -- it reverts the commit. You should've CCed 
the author too.

> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>   drivers/char/virtio_console.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7eaf303a7..4ed3ffb1d 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1117,8 +1117,6 @@ static int put_chars(u32 vtermno, const char *buf, int count)
>   {
>   	struct port *port;
>   	struct scatterlist sg[1];
> -	void *data;
> -	int ret;
>   
>   	if (unlikely(early_put_chars))
>   		return early_put_chars(vtermno, buf, count);
> @@ -1127,14 +1125,8 @@ static int put_chars(u32 vtermno, const char *buf, int count)
>   	if (!port)
>   		return -EPIPE;
>   
> -	data = kmemdup(buf, count, GFP_ATOMIC);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	sg_init_one(sg, data, count);
> -	ret = __send_to_port(port, sg, 1, count, data, false);
> -	kfree(data);
> -	return ret;
> +	sg_init_one(sg, buf, count);
> +	return __send_to_port(port, sg, 1, count, (void *)buf, false);
>   }
>   
>   /*
> 


-- 
js
suse labs
