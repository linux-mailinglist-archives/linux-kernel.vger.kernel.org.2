Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877C13F38C5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 07:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhHUFFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 01:05:41 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:27175 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhHUFFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 01:05:39 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d11 with ME
        id k54z250053riaq20354ztB; Sat, 21 Aug 2021 07:04:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 07:04:59 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH linux-next] serial: drop unneeded assignment
To:     CGEL <cgel.zte@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210821021727.27170-1-luo.penghao@zte.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <dab03cf3-3fdd-8734-485b-469b57caf0e2@wanadoo.fr>
Date:   Sat, 21 Aug 2021 07:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210821021727.27170-1-luo.penghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 21/08/2021 à 04:17, CGEL a écrit :
> From: Luo penghao <luo.penghao@zte.com.cn>
> 
> The first assignment is not used. In order to keep the code style
> consistency of the whole file, the first 'offset' assignment should be
> deleted.
> 
> The clang_analyzer complains as follows:
> 
> drivers/tty/nozomi.c:520:6: warning:
> Although the value storedto 'offset' is used in the enclosing expression,
> the value is never actually read from 'offset'.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
> ---
>   drivers/tty/nozomi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> index 0454c78..210a48f 100644
> --- a/drivers/tty/nozomi.c
> +++ b/drivers/tty/nozomi.c
> @@ -517,7 +517,7 @@ static void nozomi_setup_memory(struct nozomi *dc)
>   
>   	/* Ctrl dl configuration */
>   	dc->port[PORT_CTRL].dl_addr[CH_A] =
> -				(offset += dc->config_table.dl_app2_len);
> +				(offset + dc->config_table.dl_app2_len);

I guess that it has been written that way for consistency reasons with 
previous lines.

Should it be changed, you have the same pattern at line 554 that should 
be updated the same way.

CJ

>   	dc->port[PORT_CTRL].dl_size[CH_A] =
>   				dc->config_table.dl_ctrl_len - buff_offset;
>   
> 

