Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE09D3562FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 07:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348650AbhDGFXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 01:23:33 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38428 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhDGFX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:23:29 -0400
Received: by mail-wr1-f41.google.com with SMTP id i18so13017315wrm.5;
        Tue, 06 Apr 2021 22:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R1Tk7awH6UTxd/lzNQnn/DZAul8Yhd6wTJKqghmNytw=;
        b=aIQ4nuGTdM5FG/ImkgZMWd/Rn8Si3t3A6h3tby5psMcmQhC9O0bEX9g02dppnzThYi
         9rwRo/cxPcVu9YHHMDCGLKem0sC+N0ehlxuroPcxTlNKup31gcgYAsLeHOF0vFVxEd4v
         uhSW7+G6SFZYMKDn7Wlbs1kIqq4fBrE3VlPkjSYJLEFAPdv6fzRYyVlFeWSs6Kzm7VXb
         WvLTfeeAZEIlw8jGtxMAcbunTuFYtEWxYSLwIIsNsFClHKJ6A+v8Xztpfj/Jv/OS9xl7
         Az03batqitfVoGQ47j90SpqBuYTtDRmZ4N2ZvEGN+PZ1KLSpcIaMnbjsCWTOgpNKptA8
         tGZw==
X-Gm-Message-State: AOAM532p6FB+iYy00bHbC4YHz2WMAKTabviEG5lHwIChhnAQvx/vbdrD
        hND6P6FclB5G0mZVJEW2sNwr6ymzGuQ=
X-Google-Smtp-Source: ABdhPJwBm/I3kfiql/BfKpIHmKDJBhsDLKUkYYp2aDe2V2ACFrVzJd0ou0rELeBQXv79bIqYHJs8SQ==
X-Received: by 2002:adf:e843:: with SMTP id d3mr2047742wrn.56.1617772997840;
        Tue, 06 Apr 2021 22:23:17 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id d20sm6261283wmd.48.2021.04.06.22.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 22:23:17 -0700 (PDT)
Subject: Re: [PATCH -next] tty: n_gsm: use DEFINE_SPINLOCK() for spinlock
To:     Huang Guobin <huangguobin4@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1617710163-48158-1-git-send-email-huangguobin4@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <d6776a2e-15da-162d-5732-364dfda0a3b6@kernel.org>
Date:   Wed, 7 Apr 2021 07:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617710163-48158-1-git-send-email-huangguobin4@huawei.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 04. 21, 13:56, Huang Guobin wrote:
> From: Guobin Huang <huangguobin4@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guobin Huang <huangguobin4@huawei.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/n_gsm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 9e12f9cb1a98..d60cffc70a0c 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -266,7 +266,7 @@ struct gsm_mux {
>   
>   #define MAX_MUX		4			/* 256 minors */
>   static struct gsm_mux *gsm_mux[MAX_MUX];	/* GSM muxes */
> -static spinlock_t gsm_mux_lock;
> +static DEFINE_SPINLOCK(gsm_mux_lock);
>   
>   static struct tty_driver *gsm_tty_driver;
>   
> @@ -3257,8 +3257,6 @@ static int __init gsm_init(void)
>   	gsm_tty_driver->init_termios.c_lflag &= ~ECHO;
>   	tty_set_operations(gsm_tty_driver, &gsmtty_ops);
>   
> -	spin_lock_init(&gsm_mux_lock);
> -
>   	if (tty_register_driver(gsm_tty_driver)) {
>   		put_tty_driver(gsm_tty_driver);
>   		tty_unregister_ldisc(N_GSM0710);
> 


-- 
js
