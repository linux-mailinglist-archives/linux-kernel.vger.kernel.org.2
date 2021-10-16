Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644EE43037A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbhJPPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhJPPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:46:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB3C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:44:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w14so50562291edv.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=64dWe06VAqs+AnAQ50Xh+TBOE1vcFdAoG61oJRkkXbM=;
        b=RnxF1T2M6ilM3R2JA2+nw4F8eMXWSJq88+lq+C57fBSJlkoBaVykAtd+xZQRhKVj3C
         8zVmMDpjfZyfqO1hr7DkE5rJgpmlhTGrwZk2+B83v8+tLn+TbEdt1+bRicvrqYkk1KfA
         eMh+z83CfJM0Bt9L2YBxST7aWnk1h0IbIIUg7UQGgWSE4YuolM6mzVseuvGhHFU0HmXi
         9MF1dI7sytu6P7RczJRHOXnSttkTJHZ/HnmyxhDuqaC2SpGOb/waB+7s1k7IL2aGwS4D
         yXuo0j90SvG2DLrvp69ejsjuH7eV1CMZhzSzjbm2A0LJiwVYjmgaB+YPsFQP/tFiKAaX
         acVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=64dWe06VAqs+AnAQ50Xh+TBOE1vcFdAoG61oJRkkXbM=;
        b=Z0cO2Z4U4BUnhjqNRO4B23SLzy1Tcu/g1x1yhGQiQkxfJ27YL6lEbkoEF3Ei7tmVu/
         l/I4xr8pqfVvRKyACzE/IocIsmNj3IQiDeg0Dyiq1cy42CdS68VGmV6RydwPN/tAT/Ib
         sBeV6VHYw7QVLwZcDVxq+YQbPrPkeXc02B6FRvrALskDZtbji9fJ/DRdW/nDwO7SgQl4
         XB7M0BUpDujsL8vDOg6f21GCLP/QyimrgkZac96okJ8p4/XOnd76+EujBFN31mCtAACT
         F85/Yn+CTe3a/Yr7AoSJGqDjAVaqGmAhXLMmtLzgZECZIC571v0JJcurTZXN6nWvObkO
         fNxg==
X-Gm-Message-State: AOAM533WwHPsdpXsWb0/MBBLtivIeZo9pz0bp03AAPWXQNordUqSVxOr
        uawe39ylu8qAobSjgh1mf9o=
X-Google-Smtp-Source: ABdhPJyxOuJDrV/1RkcYwTpVbvNP7nVMNiT3q2uXqbFpJk56yWB9bZTtz9UhipsnYVBbUXwqg7U1Vg==
X-Received: by 2002:a05:6402:35d1:: with SMTP id z17mr27977981edc.174.1634399041759;
        Sat, 16 Oct 2021 08:44:01 -0700 (PDT)
Received: from [109.186.97.74] (109-186-97-74.bb.netvision.net.il. [109.186.97.74])
        by smtp.gmail.com with ESMTPSA id n6sm6982504eds.10.2021.10.16.08.44.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 16 Oct 2021 08:44:01 -0700 (PDT)
Message-ID: <616AF32F.1070403@gmail.com>
Date:   Sat, 16 Oct 2021 18:43:43 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
CC:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: fix msg_ep UAF in xillyusb_probe()
References: <20211016052047.1611983-1-william.xuanziyang@huawei.com>
In-Reply-To: <20211016052047.1611983-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct. Thanks a lot.

Acked-by: Eli Billauer <eli.billauer@gmail.com>

On 16/10/21 08:20, Ziyang Xuan wrote:
> When endpoint_alloc() return failed in xillyusb_setup_base_eps(),
> 'xdev->msg_ep' will be freed but not set to NULL. That lets program
> enter fail handling to cleanup_dev() in xillyusb_probe(). Check for
> 'xdev->msg_ep' is invalid in cleanup_dev() because 'xdev->msg_ep' did
> not set to NULL when was freed. So the UAF problem for 'xdev->msg_ep'
> is triggered.
>
> ==================================================================
> BUG: KASAN: use-after-free in fifo_mem_release+0x1f4/0x210
> CPU: 0 PID: 166 Comm: kworker/0:2 Not tainted 5.15.0-rc5+ #19
> Call Trace:
>   dump_stack_lvl+0xe2/0x152
>   print_address_description.constprop.0+0x21/0x140
>   ? fifo_mem_release+0x1f4/0x210
>   kasan_report.cold+0x7f/0x11b
>   ? xillyusb_probe+0x530/0x700
>   ? fifo_mem_release+0x1f4/0x210
>   fifo_mem_release+0x1f4/0x210
>   ? __sanitizer_cov_trace_pc+0x1d/0x50
>   endpoint_dealloc+0x35/0x2b0
>   cleanup_dev+0x90/0x120
>   xillyusb_probe+0x59a/0x700
> ...
>
> Freed by task 166:
>   kasan_save_stack+0x1b/0x40
>   kasan_set_track+0x1c/0x30
>   kasan_set_free_info+0x20/0x30
>   __kasan_slab_free+0x109/0x140
>   kfree+0x117/0x4c0
>   xillyusb_probe+0x606/0x700
>
> Set 'xdev->msg_ep' to NULL after being freed in xillyusb_setup_base_eps()
> to fix the UAF problem.
>
> Fixes: a53d1202aef1 ("char: xillybus: Add driver for XillyUSB (Xillybus variant for USB)")
> Signed-off-by: Ziyang Xuan<william.xuanziyang@huawei.com>
> ---
>   drivers/char/xillybus/xillyusb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> index e7f88f35c702..dc3551796e5e 100644
> --- a/drivers/char/xillybus/xillyusb.c
> +++ b/drivers/char/xillybus/xillyusb.c
> @@ -1912,6 +1912,7 @@ static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
>
>   dealloc:
>   	endpoint_dealloc(xdev->msg_ep); /* Also frees FIFO mem if allocated */
> +	xdev->msg_ep = NULL;
>   	return -ENOMEM;
>   }
>
>    

