Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5242A715
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhJLOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJLOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:24:28 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D3CC061570;
        Tue, 12 Oct 2021 07:22:26 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso26014689otu.9;
        Tue, 12 Oct 2021 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yxWR5melUJfLkoBgYM39vpG7Cw5Q3/sNNTdQBxlMaHk=;
        b=IHHCrHeQRT8l8pCaaIOeo/ImwxTX8ElEXBcdxSXqfvESa58mqewLhEtsStx62ZLNgL
         m8ij3srDWVi3TFxQLyiWYmS6QD3Xb3mWZ1ikDDVfMty95eEB7rDWVQQ+aGkLHTEQY5w5
         nEvpRkiA/u6SI/ZS+5EjNSy+GvwWyPgukVsCBukReFtMaM/bBs7F3+ap0pjnBKObs5As
         ggEUBsNQqjQncSK1jcek3Vs9XsES1dhbvkB5pbL+6039V2R4EW1BVT7sedmFQcSgOLWt
         XjUXvGvzBTgqgW5r/I3nWMTftR7ZijksDKSivgTDdUJv+RcXJ33HHHE4kQNhDetZYDWj
         AHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yxWR5melUJfLkoBgYM39vpG7Cw5Q3/sNNTdQBxlMaHk=;
        b=QwFwYLuADvqnbu5HQUXI9qa0sLiJ8obZWdW1zPJYmBYFvz645vwurpN3ydVK1ZbAU+
         Tn/jlvXHHu04XLzpL/4/r98t/J+ChbJyuKFqWrLsytLypFf49BlS0/yidBQaCi1rTY/S
         r30ZbkxTUScvCUYGr1EPxJRtFSKkEiLD19ohCK8o3ca9+gwSWWv9x7TNU2MPoen9KuYB
         Xl9Z0lKlFOx0GjGzR2PndNOQtouAFw+XLSI2k+SCp/LOdz5AGXPTV8saSuA5yoExs6CF
         P2IZtlln/qfjzdk8iv7PWLXl4xg7sVvWwVk2UqsQhxLlJOS0mV/fn9xJymTt/VDIQNVP
         i3Ow==
X-Gm-Message-State: AOAM530n/v8stTRTRQII/yOWzZeCdzpEFsPlEsRlvOYQVdp/FjpheFUC
        dYpMCE3aD2/S4h87Z8nRpRE=
X-Google-Smtp-Source: ABdhPJwmcGg0NYsUsb2gm4qMvrhsOj8QmoUzbs0KYHkNnSQXvEoYdDLrFfdNMUqLuoN+LIZsDcPhwA==
X-Received: by 2002:a9d:72de:: with SMTP id d30mr4248553otk.18.1634048545800;
        Tue, 12 Oct 2021 07:22:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18sm896308oov.13.2021.10.12.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 07:22:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Oct 2021 07:22:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH] hwmon: Fix possible memleak in __hwmon_device_register()
Message-ID: <20211012142223.GA611203@roeck-us.net>
References: <20211012112758.2681084-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012112758.2681084-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 07:27:58PM +0800, Yang Yingliang wrote:
> I got memory leak as follows when doing fault injection test:
> 
> unreferenced object 0xffff888102740438 (size 8):
>   comm "27", pid 859, jiffies 4295031351 (age 143.992s)
>   hex dump (first 8 bytes):
>     68 77 6d 6f 6e 30 00 00                          hwmon0..
>   backtrace:
>     [<00000000544b5996>] __kmalloc_track_caller+0x1a6/0x300
>     [<00000000df0d62b9>] kvasprintf+0xad/0x140
>     [<00000000d3d2a3da>] kvasprintf_const+0x62/0x190
>     [<000000005f8f0f29>] kobject_set_name_vargs+0x56/0x140
>     [<00000000b739e4b9>] dev_set_name+0xb0/0xe0
>     [<0000000095b69c25>] __hwmon_device_register+0xf19/0x1e50 [hwmon]
>     [<00000000a7e65b52>] hwmon_device_register_with_info+0xcb/0x110 [hwmon]
>     [<000000006f181e86>] devm_hwmon_device_register_with_info+0x85/0x100 [hwmon]
>     [<0000000081bdc567>] tmp421_probe+0x2d2/0x465 [tmp421]
>     [<00000000502cc3f8>] i2c_device_probe+0x4e1/0xbb0
>     [<00000000f90bda3b>] really_probe+0x285/0xc30
>     [<000000007eac7b77>] __driver_probe_device+0x35f/0x4f0
>     [<000000004953d43d>] driver_probe_device+0x4f/0x140
>     [<000000002ada2d41>] __device_attach_driver+0x24c/0x330
>     [<00000000b3977977>] bus_for_each_drv+0x15d/0x1e0
>     [<000000005bf2a8e3>] __device_attach+0x267/0x410
> 
> When device_register() returns an error, the name allocated in
> dev_set_name() will be leaked, the put_device() should be used
> instead of calling hwmon_dev_release() to give up the device
> reference, then the name will be freed in kobject_cleanup().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: bab2243ce189 ("hwmon: Introduce hwmon_device_register_with_groups")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Good catch. Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 8d3b1dae31df..3501a3ead4ba 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -796,8 +796,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  	dev_set_drvdata(hdev, drvdata);
>  	dev_set_name(hdev, HWMON_ID_FORMAT, id);
>  	err = device_register(hdev);
> -	if (err)
> -		goto free_hwmon;
> +	if (err) {
> +		put_device(hdev);
> +		goto ida_remove;
> +	}
>  
>  	INIT_LIST_HEAD(&hwdev->tzdata);
>  
