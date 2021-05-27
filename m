Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1473927A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhE0Gbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:31:49 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:37637 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhE0Gbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:31:39 -0400
Received: by mail-ej1-f45.google.com with SMTP id l3so306931ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kB88lCXQWv/f/g9x37rq4D9T1fErrmQxI1ppZCgR6ao=;
        b=k3+TY45RnJJfaOoVHI8l8mFvcLOz/DZZBfehIsGE9gAWmbdlAZRzDXiCFsIoEWo5Bi
         neeIMlEnoQExT+iZ/xr7n0uLqhbmsQS9S3ApWYwdoJq/L9xD23447CatfMiW96UpfFzD
         Yv2qj9PbnnYZjdS7X+Z5b6xIutGqKoSBdT1+P8n24f0vJni19P/IG2Sdgyf5yyFykLFX
         4gw+A9YofTUg5RleFD0UOgzd2Skih1jW4ao+H0r62Tecb61mfPVgIPkA3Jp1S+R4XE+H
         a+MHu29Wp9Ere4H3Tr1fhAfXhNKxo/F6I0K9hsNESBVxNQNkFXYjs+skZPTbj03InfWT
         PQmg==
X-Gm-Message-State: AOAM532oLb0ymUI58WtybMYKfJpgm+E/6ymhY2b7G9QF7FTyq+mtsLIs
        njQRYNDysJYrYzoTYrSh/KA=
X-Google-Smtp-Source: ABdhPJwNXJ4Z2rG3fUQ3tu5wHKJ1hqO8aRgl+QicHRBAccdRkY5/F62flN/Wle1ZuX48WQw33GQlVg==
X-Received: by 2002:a17:906:6c8a:: with SMTP id s10mr2136525ejr.276.1622097005358;
        Wed, 26 May 2021 23:30:05 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id y23sm516832eds.60.2021.05.26.23.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 23:30:04 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] tty: n_tty: Fix some misdocumented functions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        processes-Sapan Bhatia <sapan@corewars.org>
References: <20210526083125.549626-1-lee.jones@linaro.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <3c8f2e14-f0a7-409f-e17e-ff7d94b48566@kernel.org>
Date:   Thu, 27 May 2021 08:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210526083125.549626-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 05. 21, 10:31, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/n_tty.c:623: warning: expecting prototype for process_echoes(). Prototype was for __process_echoes() instead
>   drivers/tty/n_tty.c:1109: warning: expecting prototype for isig(). Prototype was for __isig() instead
>   drivers/tty/n_tty.c:1268: warning: expecting prototype for n_tty_receive_char(). Prototype was for n_tty_receive_char_special() instead
>   drivers/tty/n_tty.c:2132: warning: Excess function parameter 'buf' description in 'n_tty_read'
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
> Cc: processes-Sapan Bhatia <sapan@corewars.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v2: Rebased
> 
>   drivers/tty/n_tty.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 0ec93f1a61f5d..56d3b43d8a3a4 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
...
> @@ -1248,7 +1248,7 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
>   }
>   
>   /**
> - *	n_tty_receive_char	-	perform processing
> + *	n_tty_receive_char_special	-	perform processing

No, please move the doc to the function in this case instead.

>    *	@tty: terminal device
>    *	@c: character
>    *
> @@ -2042,11 +2042,11 @@ static int job_control(struct tty_struct *tty, struct file *file)
>   }
>   
>   
> -/**
> +/*

Why this?

>    *	n_tty_read		-	read function for tty
>    *	@tty: tty device
>    *	@file: file object
> - *	@buf: userspace buffer pointer
> + *	@kbuf: userspace buffer pointer
>    *	@nr: size of I/O
>    *
>    *	Perform reads for the line discipline. We are guaranteed that the
> 

thanks,
-- 
js
suse labs
