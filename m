Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787FF4397CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhJYNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhJYNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:46:35 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487DDC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:44:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so15032756ott.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MM8jdVyerQvfZyPbeUryPT3SmGVcOPU6mZrI4nILcLg=;
        b=mClFKx2dbpXWM19Ektn5260qOIqFuNK7FfIPCUKflmWQPUKuoSwooBrYa5mdCIDY9O
         RbYBt+p7CH7A/eiKgDCeuDyPNiu+O33V4DulgcaMQOGYdKNdb29Z4hSVJJ6mbKMKNZCt
         8L6O35Jqi5emYiujXtgJ6DxkkD2Mof270wwPI4I9OjP1SJ5FKkUzzR9xAh1puEA+oDNh
         6jt/6NaHAT9AULJhROpzHkij24CYDXJlc7QEn52vn/etzSA6zH7opnWOkx98hOyvx2K5
         54Z3/HA21qBXe+T+sh/0EAt28Ie2werOS98U+oxpo9NixA3X/5OwSGlDZ0lli0B2aLHw
         sjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MM8jdVyerQvfZyPbeUryPT3SmGVcOPU6mZrI4nILcLg=;
        b=E3Mmv7vaZwVndf11BBOWvVzOI5EblXaktLlxrFrwsdlhUjp8g/j6IgC9ZICzMsqsSS
         +zGf6Onh1GEmERLiWu4WlJ5MTLDswYKaFrhBZO8r4G+mwyA28MqAvkNpWJFmLffEZ+VO
         mWSwPpC1y3K4sVqtUUq8mM+Lqjd4FZMzy5kFy7f5W++5oT/JasV3CDjIwiHHsLXlhzP4
         ysnhfG1R+E8HQw+cVo50lz+TkWofLha5g/FpoQGKGeq9XbYi+ftcfc+8wVLtuTm5HR6U
         rI5nZuJI9LqWhvz8FpXDgcliWyYCUUIy0IOLThdSMaqLLAl2L1mAmcESwCvflXJgXWZ1
         HEqA==
X-Gm-Message-State: AOAM5324Jt3ktrJTxN38Q6iQM47RmhvEn3BXchbu96g3woPSgrQRgu93
        SFLyEbCaS7PiofpSr4NZXj99W8DaBkbp4Q==
X-Google-Smtp-Source: ABdhPJzk+5hzL4/xOj0RwFzVNKc+Cm32fWiHUopjysK4P7xLCnfaNGn65C8Jj1xYhWwiq/ktgYz5ng==
X-Received: by 2002:a9d:2033:: with SMTP id n48mr12897323ota.221.1635169452428;
        Mon, 25 Oct 2021 06:44:12 -0700 (PDT)
Received: from ?IPv6:2600:380:6060:12a6:721f:26e:6f8:a9aa? ([2600:380:6060:12a6:721f:26e:6f8:a9aa])
        by smtp.gmail.com with ESMTPSA id g15sm3733385oiy.8.2021.10.25.06.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 06:44:12 -0700 (PDT)
Subject: Re: [PATCH v3] block: fix incorrect references to disk objects
To:     Zqiang <qiang.zhang1211@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     hch@lst.de, sunhao.th@gmail.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211018115807.21103-1-qiang.zhang1211@gmail.com>
 <YW1n91DAaVyuISVV@casper.infradead.org>
 <9d2f7753-d7a7-f91e-077b-40b274199185@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d5b9a684-2405-7db8-02ab-8ebc93c40fd5@kernel.dk>
Date:   Mon, 25 Oct 2021 07:44:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9d2f7753-d7a7-f91e-077b-40b274199185@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 2:27 AM, Zqiang wrote:
> 
> On 2021/10/18 下午8:26, Matthew Wilcox wrote:
>> On Mon, Oct 18, 2021 at 07:58:07PM +0800, Zqiang wrote:
>>> When adding partitions to the disk, the reference count of the disk
>>> object is increased. then alloc partition device and called
>>> device_add(), if the device_add() return error, the reference
>>> count of the disk object will be reduced twice, at put_device(pdev)
>>> and put_disk(disk). this leads to the end of the object's life cycle
>>> prematurely, and trigger following calltrace.
>>>
>>>    __init_work+0x2d/0x50 kernel/workqueue.c:519
>>>    synchronize_rcu_expedited+0x3af/0x650 kernel/rcu/tree_exp.h:847
>>>    bdi_remove_from_list mm/backing-dev.c:938 [inline]
>>>    bdi_unregister+0x17f/0x5c0 mm/backing-dev.c:946
>>>    release_bdi+0xa1/0xc0 mm/backing-dev.c:968
>>>    kref_put include/linux/kref.h:65 [inline]
>>>    bdi_put+0x72/0xa0 mm/backing-dev.c:976
>>>    bdev_free_inode+0x11e/0x220 block/bdev.c:408
>>>    i_callback+0x3f/0x70 fs/inode.c:226
>>>    rcu_do_batch kernel/rcu/tree.c:2508 [inline]
>>>    rcu_core+0x76d/0x16c0 kernel/rcu/tree.c:2743
>>>    __do_softirq+0x1d7/0x93b kernel/softirq.c:558
>>>    invoke_softirq kernel/softirq.c:432 [inline]
>>>    __irq_exit_rcu kernel/softirq.c:636 [inline]
>>>    irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
>>>    sysvec_apic_timer_interrupt+0x93/0xc0
>>>
>>> Return directly after calling the put_device().
>>>
>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>> Fixes: 9d3b8813895d ("block: change the refcounting for partitions")
>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Hello Jens Axboe
> 
> The patch description information of the previous v2 version is 
> incorrect, v3 modified the description information, please applied the 
> v3 version.

This patch is already upstream, I don't have a time machine...

-- 
Jens Axboe

