Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA83B7EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhF3IGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhF3IGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:06:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B9C061768
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 01:04:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s14so1744608pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hbH/z7OhdU+iVEdzRBnCUZFHkiZm6uSMAwD77kW53EQ=;
        b=BU3Qv47LJ81s3KJ3CZ5YBfYg/zGxqG3yu7jvAU1zg+c4dyh4CHtk9+15weOuX+ekvR
         s5IR6Lc7yD9ogLG+sT0ClErracxfeatoIlo7LixKA+shMhWJ37eweKAx6IeZqmbem4E5
         y0/zaKpJ8qYYp08lmdIJ/wyT7RkHksR1W5PA2DPZul9i5EhhrAe0cJuhKfICraRe/FFl
         5eZp2XvnEy3z9zDnTZYWAFYWPMuhIANMlm7joFeZnNVruXlnxzWrS8W7hI7OiuWl6nMQ
         8+4ACl127VruEaP/flWaidFrolQ412tebQW6LDHQOJjqGmhS2FEPcqholPo/2jllLZR/
         E7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbH/z7OhdU+iVEdzRBnCUZFHkiZm6uSMAwD77kW53EQ=;
        b=cgr4yOJzE/edXQ8SXuq/IZkzYTAXg2Q/UtkbGCLaTWvgx5tD7bxwQoFY658PG6InKI
         0N3u6aQygAZK79DpPxunM9ktn6wAiQp++98lA1Pboi8RFL7a16MDoZVu55BTnuc7ZuLv
         hyViMyDilARJvb97mSDMhkiZM4P/tFseYGF95GZQ6gQAi1Th0UafwkoF/0/X/+SSqzrQ
         M0Iu/itB0L2KdrN87S1WGGGZJHRBxPpbMomMHgPqwD21XVYZTCKQbkzKcaF8KX0gCdpC
         lfHnmHlqou4f+DPj/81e06JTgLLeue5u50oJaHguBF7yfz0lAtlenomdYW3LDp6zq3NO
         OXng==
X-Gm-Message-State: AOAM5324Zpf2o9or5lBdNKEr7PRlpZ+3dv2zF+6asIyyPqCfAY4LhUY5
        PQv4qb1dmbxvMBe3FEBVC9s=
X-Google-Smtp-Source: ABdhPJwU7Js4B1W8/rGXy4VQ9j/bnj9+1GWTfaVi89y5ddU0/qI7UeO4aI37dst1hKTJofIDx5tAHg==
X-Received: by 2002:aa7:9e0d:0:b029:30f:fb8b:2584 with SMTP id y13-20020aa79e0d0000b029030ffb8b2584mr1816966pfq.24.1625040262354;
        Wed, 30 Jun 2021 01:04:22 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id z5sm20296398pfb.114.2021.06.30.01.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 01:04:21 -0700 (PDT)
Subject: Re: [PATCH v2] mtd: break circular locks in register_mtd_blktrans
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
References: <20210617160904.570111-1-desmondcheongzx@gmail.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <03e19ec8-7479-9be2-3563-a2fcf9d0ec0c@gmail.com>
Date:   Wed, 30 Jun 2021 16:04:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617160904.570111-1-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/6/21 12:09 am, Desmond Cheong Zhi Xi wrote:
> Syzbot reported a circular locking dependency:
> https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb
> 
> This happens because of the following lock dependencies:
> 
> 1. loop_ctl_mutex -> bdev->bd_mutex (when loop_control_ioctl calls
> loop_remove, which then calls del_gendisk; this also happens in
> loop_exit which eventually calls loop_remove)
> 
> 2. bdev->bd_mutex -> mtd_table_mutex (when blkdev_get_by_dev calls
> __blkdev_get, which then calls blktrans_open)
> 
> 3. mtd_table_mutex -> major_names_lock (when register_mtd_blktrans
> calls __register_blkdev)
> 
> 4. major_names_lock -> loop_ctl_mutex (when blk_request_module calls
> loop_probe)
> 
> Hence there's an overall dependency of:
> 
> loop_ctl_mutex   ----------> bdev->bd_mutex
>        ^                            |
>        |                            |
>        |                            v
> major_names_lock <---------  mtd_table_mutex
> 
> We can break this circular dependency by holding mtd_table_mutex only
> for the required critical section in register_mtd_blktrans. This
> avoids the mtd_table_mutex -> major_names_lock dependency.
> 
> Reported-and-tested-by: syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com
> Co-developed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
> 
> Changes in v1 -> v2:
> 
> Break the circular dependency in register_mtd_blktrans instead of blk_request_module, as suggested by Christoph Hellwig.
> 
>   drivers/mtd/mtd_blkdevs.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index fb8e12d590a1..7d26cfe24d05 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -528,14 +528,10 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>   	if (!blktrans_notifier.list.next)
>   		register_mtd_user(&blktrans_notifier);
>   
> -
> -	mutex_lock(&mtd_table_mutex);
> -
>   	ret = register_blkdev(tr->major, tr->name);
>   	if (ret < 0) {
>   		printk(KERN_WARNING "Unable to register %s block device on major %d: %d\n",
>   		       tr->name, tr->major, ret);
> -		mutex_unlock(&mtd_table_mutex);
>   		return ret;
>   	}
>   
> @@ -545,12 +541,12 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>   	tr->blkshift = ffs(tr->blksize) - 1;
>   
>   	INIT_LIST_HEAD(&tr->devs);
> -	list_add(&tr->list, &blktrans_majors);
>   
> +	mutex_lock(&mtd_table_mutex);
> +	list_add(&tr->list, &blktrans_majors);
>   	mtd_for_each_device(mtd)
>   		if (mtd->type != MTD_ABSENT)
>   			tr->add_mtd(tr, mtd);
> -
>   	mutex_unlock(&mtd_table_mutex);
>   	return 0;
>   }
> 

Hi maintainers,

Any chance to review this patch?

For additional reference, the mtd_table_mutex --> major_names_lock 
hierarchy that can be removed by this patch also appears in a different 
lock chain:
https://syzkaller.appspot.com/bug?id=cbf5fe846f14a90f05e10df200b08c57941dc750

Best wishes,
Desmond
