Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B73F46EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhHWIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:53:42 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:35450 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhHWIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:53:42 -0400
Received: by mail-wr1-f45.google.com with SMTP id i6so1365671wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=25CM3PYigxPQza+icuqnWvevvTl5w75e2aMsDUxOTe8=;
        b=uZcupshHSeuCSwNiy+YfGsqvm1/Y0IkHiMPD0AmCtbGv4YcfQWyspKgUWirmV+0077
         +m9La3NkU3qxvueUfTih+uI8aA7HZh+Q76WGL+9Fu31tqgiBwb0b3WYPhWZNtCCDDmip
         sfjPU9PzO6anbzK3ZeXsRk4u1DVXI8jQodvpSq+jkMw41r/hhAUvTpnqX9JB0P90Sxnq
         l2yD+G7jXghmV9a+6pl6MIOlQfNsbaldll4a2hpDUWUoG2TXfAmyjG/F2u8Pm8QYzRwU
         3fZeBjQtP8dP1QQLWDN06H8YmszreeBcQ7QXIdp5i8PZpxpGmb0L0UiIoD2W4yFYZrIZ
         01vw==
X-Gm-Message-State: AOAM530xoKdMXL/pcqc4UZJo5kfEOL8HJOCLR089379H6OSikskkjLjk
        0Exl+xLvUn0sM0dPrjEagcA=
X-Google-Smtp-Source: ABdhPJz/JNxBJNFGQfNN7mlQMnByzx3tC4wIodG5rAU+eLbbPnoGrMDuZSYtPVhg+p4qZ21dgvBMVg==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr12031370wrn.303.1629708778840;
        Mon, 23 Aug 2021 01:52:58 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id d8sm15110613wrv.20.2021.08.23.01.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 01:52:58 -0700 (PDT)
Subject: Re: [PATCH v2] tty: Fix data race between tiocsti() and
 flush_to_ldisc()
To:     Nguyen Dinh Phi <phind.uet@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
References: <20210823000641.2082292-1-phind.uet@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <523450c6-488c-b24a-470e-828354ab80e5@kernel.org>
Date:   Mon, 23 Aug 2021 10:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823000641.2082292-1-phind.uet@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 08. 21, 2:06, Nguyen Dinh Phi wrote:
> The ops->receive_buf() may be accessed concurrently from these two
> functions.  If the driver flushes data to the line discipline
> receive_buf() method while tiocsti() is waiting for the
> ops->receive_buf() to finish its work, the data race will happen.
> 
> For example:
> tty_ioctl			|tty_ldisc_receive_buf
>   ->tioctsi			| ->tty_port_default_receive_buf
> 				|  ->tty_ldisc_receive_buf
>     ->hci_uart_tty_receive	|   ->hci_uart_tty_receive
>      ->h4_recv                   |    ->h4_recv
> 
> In this case, the h4 receive buffer will be overwritten by the
> latecomer, and we will lost the data.
> 
> Hence, change tioctsi() function to use the exclusive lock interface
> from tty_buffer to avoid the data race.

This makes sense. It mimics paste_selection() -- the lock order is 
preexisting. The normal path processing has the locks inverted, not sure 
why it doesn't matter :):
flush_to_ldisc
   mutex_lock(&buf->lock);    <--------- A (mutex)
   receive_buf()
     tty_port_default_receive_buf()
       disc = tty_ldisc_ref(tty); <----- B (ldsem for READ)

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Reported-by: syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
> ---
> V2:
> 	- Remove FIXME comment.
> 
>   drivers/tty/tty_io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e8532006e960..6616d4a0d41d 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2290,8 +2290,6 @@ static int tty_fasync(int fd, struct file *filp, int on)
>    *	Locking:
>    *		Called functions take tty_ldiscs_lock
>    *		current->signal->tty check is safe without locks
> - *
> - *	FIXME: may race normal receive processing
>    */
> 
>   static int tiocsti(struct tty_struct *tty, char __user *p)
> @@ -2307,8 +2305,10 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
>   	ld = tty_ldisc_ref_wait(tty);

Here (and in paste_selection()), it is lock "B (ldsem) for READ".


>   	if (!ld)
>   		return -EIO;
> +	tty_buffer_lock_exclusive(tty->port);

and "A (mutex)".

>   	if (ld->ops->receive_buf)
>   		ld->ops->receive_buf(tty, &ch, &mbz, 1);
> +	tty_buffer_unlock_exclusive(tty->port);
>   	tty_ldisc_deref(ld);
>   	return 0;
>   }

thanks,
-- 
js
suse labs
