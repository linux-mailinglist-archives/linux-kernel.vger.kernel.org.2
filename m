Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE9356306
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 07:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348682AbhDGF0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 01:26:51 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51746 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbhDGF0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:26:49 -0400
Received: by mail-wm1-f47.google.com with SMTP id p19so8372979wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 22:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MPTdDbexEV8/Ukx2uJy1w0fpqcUWtOwp48W6VAtXQZo=;
        b=GTsDsOGS04v38QTdpJiOzDluTpu/MgxMaG5kT31UWKzkNDzXRnRT49ik1vzAxZ+Ebe
         17KNS9hctNln+rOFXyoF2RfsNohXstEzR317Z5kSD9YwD6W/YV//pY01fTqlmRvl4Fd2
         zKKtyaZJOLlsLrbUhly73HY0xXnp/HBcfRdxXEwi775SGkpJzL7fBIwwMB714m/sxega
         smf2jc7sUlHaPr6yXPottvRy9lxYv4id/79WSsWktpSJ8rEd1yZN/rdrRwAKmjIVmqib
         aR36zlEAYYSs62e9vjpgCUlQfMD05YD7vsopT4N73E+fTSOnjOmFECUGlOgUgpcLgKtK
         kPDA==
X-Gm-Message-State: AOAM5312CcPVYwZnkecDCYBEol0SXqM3wB1wND2/3/hpZyQOhtFbvOuD
        AVtMXJMUnGXocc///ZUooyc=
X-Google-Smtp-Source: ABdhPJynP6VBVbMj0gqjGpnk79Sj2YaYu0e6NQJWCM+LbKuLPkGZW3NzA2fscTdh6rdVL5hIavpETw==
X-Received: by 2002:a05:600c:3590:: with SMTP id p16mr1278747wmq.140.1617773199611;
        Tue, 06 Apr 2021 22:26:39 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id g16sm39267498wrs.76.2021.04.06.22.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 22:26:39 -0700 (PDT)
Subject: Re: [PATCH v2 04/10] tty: tty_jobctrl: Fix coding style issues of
 block comments
To:     Xiaofei Tan <tanxiaofei@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@openeuler.org
References: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
 <1617708288-14847-5-git-send-email-tanxiaofei@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <87ba5be2-e8ee-b1ed-175d-1ee7d5a45498@kernel.org>
Date:   Wed, 7 Apr 2021 07:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617708288-14847-5-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 04. 21, 13:24, Xiaofei Tan wrote:
> Fix coding style issues of block comments, reported by checkpatch.pl.
> Besides, do some expression optimization for the sentenses.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>   drivers/tty/tty_jobctrl.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
> index 86070f7..7003b6b 100644
> --- a/drivers/tty/tty_jobctrl.c
> +++ b/drivers/tty/tty_jobctrl.c
> @@ -204,8 +204,10 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
>   			spin_lock_irq(&p->sighand->siglock);
>   			if (p->signal->tty == tty) {
>   				p->signal->tty = NULL;
> -				/* We defer the dereferences outside fo
> -				   the tasklist lock */
> +				/*
> +				 * We defer the dereferences outside of
> +				 * the tasklist lock period

:). No, I meant "period" as this punctuation mark: .

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
> +	 * between a new association and proc_clear_tty but possibly we need
> +	 * to protect against this period anyway

The same here.

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
suse labs
