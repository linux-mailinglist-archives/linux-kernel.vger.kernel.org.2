Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E871435D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhJUI6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:58:49 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:59440 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhJUI6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:58:48 -0400
Received: from [IPV6:2a01:e0a:255:1000:39c0:d565:94f5:807d] (unknown [IPv6:2a01:e0a:255:1000:39c0:d565:94f5:807d])
        (Authenticated sender: duncan.sands@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 05BAC19F58D;
        Thu, 21 Oct 2021 10:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1634806591;
        bh=xyWUXjyEkd3APpeg2/U2DdNYjk+PFMsLKVsqWgnY8XE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TdpnsgtehjpdPUzRRR9SbuSF8GsEJbWqyLkdodaiDUTyQnLQ52bBfLMJlL+69gqgR
         YgQParHa3o+scp23Hs9LHEYc/ARwiHar3ZBTnRdt0IPmhSvQer2auO1uC2eKC0A/lU
         phrfYsNC1vjPbpgqZHGBeYyXhk/RYOSHHxTErEIvLFCxK6hqy1EbYHtNQecpchxE3V
         Qu8tPnP5xv5zz+Wr03BKqk8/3zfmQq8lRqCHVnSsyIIoO1P/cBaG5ubM6lmWdY5ClT
         VOEA4J0gICSTFkVxyvKgA4YwVtjK7ty0G40aqFGDmFz5wI07d5ahH+LH7XXLSJmkze
         8QmESMf70SCQA==
Message-ID: <95677103-075b-62a8-8a6b-4de1f81b25e3@free.fr>
Date:   Thu, 21 Oct 2021 10:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] usb: atm: Make use of the helper macro kthread_run()
Content-Language: en-US
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211021084351.2554-1-caihuoqing@baidu.com>
From:   Duncan Sands <duncan.sands@free.fr>
In-Reply-To: <20211021084351.2554-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai Huoqing,

On 21/10/2021 10:43, Cai Huoqing wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>   drivers/usb/atm/usbatm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
> index da17be1ef64e..b1ea3c6384f9 100644
> --- a/drivers/usb/atm/usbatm.c
> +++ b/drivers/usb/atm/usbatm.c
> @@ -976,7 +976,7 @@ static int usbatm_heavy_init(struct usbatm_data *instance)
>   {
>   	struct task_struct *t;
>   
> -	t = kthread_create(usbatm_do_heavy_init, instance, "%s",
> +	t = kthread_run(usbatm_do_heavy_init, instance, "%s",
>   			instance->driver->driver_name);
>   	if (IS_ERR(t)) {
>   		usb_err(instance, "%s: failed to create kernel_thread (%ld)!\n",
> @@ -985,7 +985,6 @@ static int usbatm_heavy_init(struct usbatm_data *instance)
>   	}
>   
>   	instance->thread = t;
> -	wake_up_process(t);

doesn't this mean that the thread may now start running before instance->thread 
has been assigned?  It's not clear to me what race conditions this may open up, 
if any (I haven't looked at the code in a long time), but it does need to be 
carefully analyzed.  So I can't sign off on this as it stands.

Best wishes, Duncan.

>   	wait_for_completion(&instance->thread_started);
>   
>   	return 0;
> 

