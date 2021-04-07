Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7EB356360
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 07:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhDGFiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 01:38:05 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46693 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhDGFiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:38:04 -0400
Received: by mail-wr1-f48.google.com with SMTP id a12so6725156wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 22:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IYPzGtq9eh65x1tav/vO4Khe8W8aHk5sLbf2IU8OLpE=;
        b=O6+OzDZxzAkd/7RjnDqH2UwfEpi/dUZrFaewj2bILXPmwbf8q9v3brdIH8mHPtQf5f
         Z7QE+z1/o0hsTbcvOdrrTBo1s7DCy0OqSIUC71KhtrVn6a7G4n2Et4/ZPzLDUY6P17s3
         RVEVzgx2YQNaHhvVVBHHJc9bTUEJmtpyezMEqK0sU8f0d6JZXsjcOlmNP3Lz7Jd/KhG0
         6OQWL7Ka/3iLjLN9fyFlcbTiclp0YZUQMyW1NNBDG5d5T7lNld+Wjts219u8SIiy8pfs
         ewdh8b0FOdE2NCbhcTUNS2NmPfZGXkA6sl8GNvJhWoC3FogHRgzZxVck5Q49Fi1gfp6G
         jyyw==
X-Gm-Message-State: AOAM533PbfaDIuBMZP7OdJnDuclE6bJYxrCDUL+LkBfHX1YSaXCUXLEf
        YJf+4zYvYc2p4f5oHdSToWE=
X-Google-Smtp-Source: ABdhPJw1Omgsrm/+iheakIdIJvUdISuymhx+fsOTaqmz0IVGLj98WnjQt4osa58slifGmZf6rSge2Q==
X-Received: by 2002:a05:6000:362:: with SMTP id f2mr2096811wrf.141.1617773874620;
        Tue, 06 Apr 2021 22:37:54 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id s5sm21223318wrw.2.2021.04.06.22.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 22:37:54 -0700 (PDT)
Subject: Re: [PATCH] tty: n_gsm: check error while registering tty devices
To:     Hillf Danton <hdanton@sina.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
References: <20210407021622.1417-1-hdanton@sina.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <86499c86-d82c-aa18-5b74-053b0a55fd04@kernel.org>
Date:   Wed, 7 Apr 2021 07:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407021622.1417-1-hdanton@sina.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 04. 21, 4:16, Hillf Danton wrote:
> Add the error path for registering tty devices and roll back in case of error
> in bid to avoid the UAF like the below one reported.
> 
>   ------------[ cut here ]------------
>   refcount_t: underflow; use-after-free.
>   WARNING: CPU: 1 PID: 8923 at lib/refcount.c:28
>   refcount_warn_saturate+0x1cf/0x210 -origin/lib/refcount.c:28
>   Modules linked in:
>   CPU: 1 PID: 8923 Comm: executor Not tainted 5.12.0-rc5+ #8
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>   1.13.0-1ubuntu1.1 04/01/2014
>   RIP: 0010:refcount_warn_saturate+0x1cf/0x210 -origin/lib/refcount.c:28
>   Code: 4f ff ff ff e8 32 fa b5 fe 48 c7 c7 3d f8 f6 86 e8 d6 ab c6 fe
>   c6 05 7c 34 67 04 01 48 c7 c7 68 f8 6d 86 31 c0 e8 81 2e 9d fe <0f> 0b
>   e9 22 ff ff ff e8 05 fa b5 fe 48 c7 c7 3e f8 f6 86 e8 a9 ab
>   RSP: 0018:ffffc90001633c60 EFLAGS: 00010246
>   RAX: 15d08b2e34b77800 RBX: 0000000000000003 RCX: ffff88804c056c80
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: 0000000000000003 R08: ffffffff813767aa R09: 0001ffffffffffff
>   R10: 0001ffffffffffff R11: ffff88804c056c80 R12: ffff888040b7d000
>   R13: ffff88804c206938 R14: ffff88804c206900 R15: ffff888041b18488
>   FS:  00000000022c9940(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f9f9b122008 CR3: 0000000044b4b000 CR4: 0000000000750ee0
>   PKRU: 55555554
>   Call Trace:
>    __refcount_sub_and_test -origin/./include/linux/refcount.h:283 [inline]
>    __refcount_dec_and_test -origin/./include/linux/refcount.h:315 [inline]
>    refcount_dec_and_test -origin/./include/linux/refcount.h:333 [inline]
>    kref_put -origin/./include/linux/kref.h:64 [inline]
>    kobject_put+0x17b/0x180 -origin/lib/kobject.c:753
>    cdev_del+0x4b/0x50 -origin/fs/char_dev.c:597
>    tty_unregister_device+0x99/0xd0 -origin/drivers/tty/tty_io.c:3343
>    gsmld_detach_gsm -origin/drivers/tty/n_gsm.c:2409 [inline]
>    gsmld_close+0x6c/0x140 -origin/drivers/tty/n_gsm.c:2478
>    tty_ldisc_close -origin/drivers/tty/tty_ldisc.c:488 [inline]
>    tty_ldisc_kill -origin/drivers/tty/tty_ldisc.c:636 [inline]
>    tty_ldisc_release+0x1b6/0x400 -origin/drivers/tty/tty_ldisc.c:809
>    tty_release_struct+0x19/0xb0 -origin/drivers/tty/tty_io.c:1714
>    tty_release+0x9ad/0xa00 -origin/drivers/tty/tty_io.c:1885

Yes, the fix makes sense. But could you elaborate in the commit log when 
this happens? I only wonder how real this is. I assume you inject faults 
to allocations?

> Reported-and-tested-by: Hao Sun <sunhao.th@gmail.com>
> Cc: Jiri Slaby <jslaby@suse.cz>

Use my MAINTAINERS e-mail please.

> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2384,8 +2384,18 @@ static int gsmld_attach_gsm(struct tty_s
>   		/* Don't register device 0 - this is the control channel and not
>   		   a usable tty interface */
>   		base = mux_num_to_base(gsm); /* Base for this MUX */
> -		for (i = 1; i < NUM_DLCI; i++)
> -			tty_register_device(gsm_tty_driver, base + i, NULL);
> +		for (i = 1; i < NUM_DLCI; i++) {
> +			struct device *dev;
> +
> +			dev = tty_register_device(gsm_tty_driver,
> +							base + i, NULL);
> +			if (IS_ERR(dev)) {
> +				for (i--; i >= 1; i--)
> +					tty_unregister_device(gsm_tty_driver,
> +								base + i);
> +				return PTR_ERR(dev);
> +			}
> +		}
>   	}
>   	return ret;
>   }
> --
> 

thanks,
-- 
js
suse labs
