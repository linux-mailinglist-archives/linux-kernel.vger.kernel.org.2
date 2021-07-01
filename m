Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E1E3B8DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhGAGP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:15:59 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50988 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhGAGP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:15:57 -0400
Received: by mail-wm1-f42.google.com with SMTP id o22so3663161wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZwcVQEaesXNwK4ujdTlqtQPUcw8KfhtBdw+MIe13p0=;
        b=s8SJm6gX+dxGw9WoRntRPmV/UuEWx6mmhI6eBj9F7O7zVj0XhHLzO2Ef8JgwfGbK2b
         7q/uI4EHZP3+K4XsUejLcxHXdOiWwR3jGkG3IwGD3otqr43m/Jlpkpot2Oy4DO/ukwgc
         0oLvAo8hSPfOXbHO8w2WLntT8y2ARhSs0Rrl6glwiSo4CGwU9LnISaG6L8lmieJvANLK
         dwwKEMubvyuA26wSK+0R04DCiL7YlWN5OBgdYSKGQmkQojgOKYRSDaPPfgDS8Sb+/Zlc
         9+EqJSytQ/kdbbfwxksN+CZ4JB3rIOs/JVYbS+tjO7CpkVuxQEhfduhiueXtedPNSSb/
         l+0w==
X-Gm-Message-State: AOAM532fUozp/v/b+nnwJFVS/JHhKgEG5o0MajoApXJPIFpwBhpBBOnL
        HYiLXuK14a8V9wkcjqbxd+puLkF9343Xkw==
X-Google-Smtp-Source: ABdhPJwhHBzX/y3E4g4R4stEH9cAtGLSpTE0FoFjc6CwTFc+VKT1Wn0FHRqY0BhirBOfxubeNYK0ng==
X-Received: by 2002:a05:600c:3783:: with SMTP id o3mr8715912wmr.123.1625120006706;
        Wed, 30 Jun 2021 23:13:26 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t17sm15247436wrs.61.2021.06.30.23.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 23:13:26 -0700 (PDT)
Subject: Re: [PATCH] tty: n_gsm: delete SABM command frame as requester
To:     Zhenguo Zhao <zhenguo6858@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1625108078-16491-1-git-send-email-zhenguo6858@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <695b2537-28e0-90c4-d516-727dfeead12d@kernel.org>
Date:   Thu, 1 Jul 2021 08:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1625108078-16491-1-git-send-email-zhenguo6858@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 07. 21, 4:54, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> 
> as initiator,it need to send SABM conmmand ,as requester,there is
> no need to send the SABM control frame,it will cause redundant data.

Hi,

is there any document you can refer to? I am still confused so I don't 
understand why this didn't matter until now. Maybe you only need to 
explain better the whole point behind the introduced initiator/requester 
functionality.

In any way, could you use spell checker on the commit log (like "conmmand")?

> Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> ---
>   drivers/tty/n_gsm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5fea02c..e66418b 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3005,8 +3005,9 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
>   	/* We could in theory open and close before we wait - eg if we get
>   	   a DM straight back. This is ok as that will have caused a hangup */
>   	tty_port_set_initialized(port, 1);
> -	/* Start sending off SABM messages */
> -	gsm_dlci_begin_open(dlci);
> +	/* Start sending off SABM messages for initiator */
> +	if (gsm->initiator)
> +		gsm_dlci_begin_open(dlci);
>   	/* And wait for virtual carrier */
>   	return tty_port_block_til_ready(port, tty, filp);
>   }
> 

thanks,
-- 
js
suse labs
