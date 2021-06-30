Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155A63B7FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhF3JYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhF3JX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:23:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C723BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:21:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g21so1822694pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ss+braA99PMlefO6rn0rJTWwO6dSTN7YOlvZhUkt/NI=;
        b=Azd3pboa8NSOfcWpp1zQo5TVVrsWk+aOGO/yRc1OD1FC5mdVinM1ZCZgEHsGG+qWVv
         fQHlkqS257cFTe0Iag27H104iLT5OIp44TBYB51VUHAojcfh2tn60mOilVOrlQ2KC1OV
         JFwuWsOYI9/lcSKXgvEaIoGmk21mWDgXxPGwqz8s4US8zzvVRFgjHpMAuQPGOj7vOdEl
         GUAk5EzaiC6VtRprnNzKE8/cDkMvSw9UNplqLPxd1EadjrNialYxFtKuvTi0A8xYLvn0
         GKLirL2zo4/BlgLzie+3KAPKjUMC6in6PuZ3xLgrTo9uXg/jnamlL8QDe275WbG+4Pzr
         FA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ss+braA99PMlefO6rn0rJTWwO6dSTN7YOlvZhUkt/NI=;
        b=ju0N3My4A9CGN9oPkdYWB39V33exXY3/542CsKHvgek7THAJ+FnK4ULoNXd0eTnJjC
         D4wr451JfJhtE0/U9WgvahovSw4sLRRt29Wazw8Uu6aAPVfufIz4jfTSFX9315phSgKX
         2CiXHhkVFwd+ynFRbwB17Vjf0docdI+PP84vcdVwIXo2cg+m356LQm1k0uspssbmfTuP
         qOQh8A7LOQR/zlcO1oMEHMJPNnlTpB2MiJQ1eUyAY38bdVasZCgpLNQHGd1kTO/LKxc5
         CK0CtyuBK3B59ltpcRgzA5n0ICTaWAtQFLG9wtIyWoPM5xiiC6Up0NbokSN3mfKWCSk+
         z5Xw==
X-Gm-Message-State: AOAM532HmusySunOtHYIxtmQepilTdZXg/uiGB8kuEdrDybW2qfOGzI0
        BowM/3mi/jxFN+mHBp3zf4g=
X-Google-Smtp-Source: ABdhPJzQKipMf04Vme5US7L4gH173r21LIVHZ0nJ0BzgMVVVwUkkXpSE1R4lND3iNpXHEu8kBKiWaA==
X-Received: by 2002:a63:d305:: with SMTP id b5mr33758691pgg.67.1625044888154;
        Wed, 30 Jun 2021 02:21:28 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id z3sm21629542pgl.77.2021.06.30.02.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 02:21:27 -0700 (PDT)
Subject: Re: [PATCH v2] mtd: break circular locks in register_mtd_blktrans
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
References: <20210617160904.570111-1-desmondcheongzx@gmail.com>
 <03e19ec8-7479-9be2-3563-a2fcf9d0ec0c@gmail.com>
 <20210630104353.7575e920@xps13>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <99b6573c-8c6d-8bcc-af8d-ce63cdfb74e4@gmail.com>
Date:   Wed, 30 Jun 2021 17:21:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630104353.7575e920@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/6/21 4:43 pm, Miquel Raynal wrote:
> Hello,
> 
> Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com> wrote on Wed, 30 Jun
> 2021 16:04:17 +0800:
> 
>> On 18/6/21 12:09 am, Desmond Cheong Zhi Xi wrote:
>>> Syzbot reported a circular locking dependency:
>>> https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb
>>>
>>> This happens because of the following lock dependencies:
>>>
>>> 1. loop_ctl_mutex -> bdev->bd_mutex (when loop_control_ioctl calls
>>> loop_remove, which then calls del_gendisk; this also happens in
>>> loop_exit which eventually calls loop_remove)
>>>
>>> 2. bdev->bd_mutex -> mtd_table_mutex (when blkdev_get_by_dev calls
>>> __blkdev_get, which then calls blktrans_open)
>>>
>>> 3. mtd_table_mutex -> major_names_lock (when register_mtd_blktrans
>>> calls __register_blkdev)
>>>
>>> 4. major_names_lock -> loop_ctl_mutex (when blk_request_module calls
>>> loop_probe)
>>>
>>> Hence there's an overall dependency of:
>>>
>>> loop_ctl_mutex   ----------> bdev->bd_mutex
>>>         ^                            |
>>>         |                            |
>>>         |                            v
>>> major_names_lock <---------  mtd_table_mutex
>>>
>>> We can break this circular dependency by holding mtd_table_mutex only
>>> for the required critical section in register_mtd_blktrans. This
>>> avoids the mtd_table_mutex -> major_names_lock dependency.
>>>
>>> Reported-and-tested-by: syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com
>>> Co-developed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>>> ---
>>>
>>> Changes in v1 -> v2:
>>>
>>> Break the circular dependency in register_mtd_blktrans instead of blk_request_module, as suggested by Christoph Hellwig.
>>>
>>>    drivers/mtd/mtd_blkdevs.c | 8 ++------
>>>    1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
>>> index fb8e12d590a1..7d26cfe24d05 100644
>>> --- a/drivers/mtd/mtd_blkdevs.c
>>> +++ b/drivers/mtd/mtd_blkdevs.c
>>> @@ -528,14 +528,10 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>>>    	if (!blktrans_notifier.list.next)
>>>    		register_mtd_user(&blktrans_notifier);
>>>    > -
>>> -	mutex_lock(&mtd_table_mutex);
>>> -
>>>    	ret = register_blkdev(tr->major, tr->name);
>>>    	if (ret < 0) {
>>>    		printk(KERN_WARNING "Unable to register %s block device on major %d: %d\n",
>>>    		       tr->name, tr->major, ret);
>>> -		mutex_unlock(&mtd_table_mutex);
>>>    		return ret;
>>>    	}
>>>    > @@ -545,12 +541,12 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>>>    	tr->blkshift = ffs(tr->blksize) - 1;
>>>    >   	INIT_LIST_HEAD(&tr->devs);
>>> -	list_add(&tr->list, &blktrans_majors);
>>>    > +	mutex_lock(&mtd_table_mutex);
>>> +	list_add(&tr->list, &blktrans_majors);
>>>    	mtd_for_each_device(mtd)
>>>    		if (mtd->type != MTD_ABSENT)
>>>    			tr->add_mtd(tr, mtd);
>>> -
>>>    	mutex_unlock(&mtd_table_mutex);
>>>    	return 0;
>>>    }
>>>
>>
>> Hi maintainers,
>>
>> Any chance to review this patch?
>>
>> For additional reference, the mtd_table_mutex --> major_names_lock hierarchy that can be removed by this patch also appears in a different lock chain:
>> https://syzkaller.appspot.com/bug?id=cbf5fe846f14a90f05e10df200b08c57941dc750
> 
> I'm fine with the patch, but it came too late in the release cycle so
> now I'm waiting -rc1 to apply it.
> 
> Thanks,
> Miquèl
> 

Got it. Thanks for the review, Miquèl.
