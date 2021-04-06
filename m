Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8B354BC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 06:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbhDFEmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:42:50 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35343 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhDFEms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:42:48 -0400
Received: by mail-wr1-f54.google.com with SMTP id j18so12680430wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 21:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GgsiGhtO8fmGGdAGrZ7quQl59EH3QIIr7d4dMZfLs9o=;
        b=fJp/jssdbf0T2FWm9KmiB6TKDnqZNuY81tstTMNijKw2Myg471D4F2B8+/AS1cyR/k
         dA228CdAzr61+IfGFAWbLa5BfSDOqP5SWEhnBVHGaQ7ibW4zUz9MWvxnEP0ZUVBO9gkI
         YjqIb9aGm+n1LX6OoK4dOcs/5JmyO+LXhFomcJVxrS7Ew2KDM1wv0uhEsEXoFQh7DJZo
         GPXL5U5cB4IGI58q7smr2V/94AF8+MeLCjEAtm6IZfDtPOJP9xJIwgFKVj4PUOu0q3rC
         voHxn+y/LN1fSlxXK3tQ8tJpl4EjNyPmFxDu4rs0ditJ+/JQgY236fKHQHpTbjUVzVMT
         qUMw==
X-Gm-Message-State: AOAM531zJevrY8iRLOIxwklqqWLRRnFq7mx9CCvjV+ToBJNuLbzi5tin
        ynbBESIcUYtwOS6rZ34DdtPf6yZZmCg=
X-Google-Smtp-Source: ABdhPJwNMX/1SR3oyWTOdX+VbP82AxYvcLxalnyV7fl9ocBoBniCuRf+gT5SZmNq+9oQW88ay5Ckpg==
X-Received: by 2002:adf:d20b:: with SMTP id j11mr32148180wrh.397.1617684158989;
        Mon, 05 Apr 2021 21:42:38 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u17sm1405315wmq.3.2021.04.05.21.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 21:42:38 -0700 (PDT)
Subject: Re: [PATCH 04/10] tty: tty_jobctrl: Fix coding style issues of block
 comments
To:     Xiaofei Tan <tanxiaofei@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@openeuler.org
References: <1617593662-25900-1-git-send-email-tanxiaofei@huawei.com>
 <1617593662-25900-5-git-send-email-tanxiaofei@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <7af3cbf8-b19e-ab01-5cfe-3e3e187e9df9@kernel.org>
Date:   Tue, 6 Apr 2021 06:42:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617593662-25900-5-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 04. 21, 5:34, Xiaofei Tan wrote:
> Fix coding style issues of block comments, reported by checkpatch.pl.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>   drivers/tty/tty_jobctrl.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
> index 86070f7..4d78422 100644
> --- a/drivers/tty/tty_jobctrl.c
> +++ b/drivers/tty/tty_jobctrl.c
> @@ -204,8 +204,10 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
>   			spin_lock_irq(&p->sighand->siglock);
>   			if (p->signal->tty == tty) {
>   				p->signal->tty = NULL;
> -				/* We defer the dereferences outside fo
> -				   the tasklist lock */
> +				/*
> +				 * We defer the dereferences outside fo
> +				 * the tasklist lock

I don't know if it deserves its own patch, but fo -> of fix would be 
nice. And add a period at the end of the sentence.

> +				 */
>   				refs++;
>   			}
>   			if (!p->signal->leader) {
> @@ -328,9 +330,11 @@ void disassociate_ctty(int on_exit)
>    */
>   void no_tty(void)
>   {
> -	/* FIXME: Review locking here. The tty_lock never covered any race
> -	   between a new association and proc_clear_tty but possible we need
> -	   to protect against this anyway */
> +	/*
> +	 * FIXME: Review locking here. The tty_lock never covered any race
> +	 * between a new association and proc_clear_tty but possible we need

"possibly" or "it's possible", I think (as a non-native).

> +	 * to protect against this anyway

Period.

> +	 */
>   	struct task_struct *tsk = current;
>   
>   	disassociate_ctty(0);
> @@ -536,7 +540,7 @@ static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t _
>   	/*
>   	 * (tty == real_tty) is a cheap way of
>   	 * testing if the tty is NOT a master pty.
> -	*/
> +	 */
>   	if (tty == real_tty && current->signal->tty != real_tty)
>   		return -ENOTTY;
>   
> 


-- 
js
