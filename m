Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92947339788
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhCLTiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhCLTh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:37:58 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FAC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:37:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a8so5890940plp.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UKnQtmeXbQDZXjnjWvJSY4JzHsmQQhonDO/sZOZcxPY=;
        b=pDsyezdeM3eFbIF44exdHxWFRcm+eDZQEYAV264Xv8PZA+yz3/NN25r3/N0gGtd+r/
         Eh37V3gS05TLf+ypbRJrB0YAa1Hv/KTo14u4qFi0ElCzb80JK9TDQNIgHWe6XBPd6LV/
         tnubN9AD8Nny89lFVuS4sBLxMuyxAQssYEOELEUmiKP4yG75COJFTXOZEIa39q8aIaFn
         pxZ6juQt09pGz27bpg0P2HYIYL9O40UReaUnHeheriehBLXOMwJeci9oViq54BwNW4uu
         mIJJut1IWtot4LBFwxKUbLO9s906nvs3gtcf8wFSmvFJqpwxcfHC/WUndJ8NuaV20q58
         0J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UKnQtmeXbQDZXjnjWvJSY4JzHsmQQhonDO/sZOZcxPY=;
        b=LnIDZYYJY8PGzndTBIkf6XKbvxjV59ibcqmFN/evllx99QBVbc3p7dXda3bpzAK20r
         9LlMrL3stWZAQGgDwIbH16x9pP59JatV2vCzHVXlrMMXVmB6ZS0quvzIXhjW9Jc5N5Vo
         SrTYQZ2B04+nceo3wj3lyK7Vjub12IQiLN2Oxo3zg2qbduHUZZudgKriOjtEAFVO5o+j
         VS0Y/Tgg3Wum/+aWty5TvovesSrPfrPnaohWGxOypRCYUQaJDvEEzI8bDEarghJgFNvF
         03edh1f4bYOg/RHi9H8+mSuC2pRqMxFOEEFBko7ZyljY99HWVOwfAsG1wdRhNq3//3ip
         Pflw==
X-Gm-Message-State: AOAM532qemKU0/wQwGdxa6ELTqPWZu1Q3/ueGvtfb+Ko+6IJCIjiHhPN
        Km22o29uW8/cjZZdUkM5gt+ByP5dg+DH7w==
X-Google-Smtp-Source: ABdhPJwo0c8hwWPk+/IKe8vf9mW6vq/ncD9KLoYSgmKJfuL1YN1CxWOWk0TXdobNLqWEFICqtyf0EQ==
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr3882787pjv.229.1615577870168;
        Fri, 12 Mar 2021 11:37:50 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c128sm5410311pfc.76.2021.03.12.11.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 11:37:49 -0800 (PST)
Subject: Re: [PATCH] block: fix possible bd_size_lock deadlock
To:     yanfei.xu@windriver.com, damien.lemoal@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210311121139.205222-1-yanfei.xu@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af8f7d00-d612-c0d2-e254-ff3c967fb94c@kernel.dk>
Date:   Fri, 12 Mar 2021 12:37:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311121139.205222-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 5:11 AM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> bd_size_lock spinlock could be taken in block softirq, thus we should
> disable the softirq before taking the lock.
> 
> WARNING: inconsistent lock state
> 5.12.0-rc2-syzkaller #0 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-R} usage.
> kworker/u4:0/7 [HC0[0]:SC1[1]:HE0:SE0] takes:
> 8f87826c (&inode->i_size_seqcount){+.+-}-{0:0}, at:
> end_bio_bh_io_sync+0x38/0x54 fs/buffer.c:3006
> {SOFTIRQ-ON-W} state was registered at:
>   lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
>   lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
>   do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
>   do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
>   i_size_write include/linux/fs.h:863 [inline]
>   set_capacity+0x13c/0x1f8 block/genhd.c:50
>   brd_alloc+0x130/0x180 drivers/block/brd.c:401
>   brd_init+0xcc/0x1e0 drivers/block/brd.c:500
>   do_one_initcall+0x8c/0x59c init/main.c:1226
>   do_initcall_level init/main.c:1299 [inline]
>   do_initcalls init/main.c:1315 [inline]
>   do_basic_setup init/main.c:1335 [inline]
>   kernel_init_freeable+0x2cc/0x330 init/main.c:1537
>   kernel_init+0x10/0x120 init/main.c:1424
>   ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158
>   0x0
> irq event stamp: 2783413
> hardirqs last  enabled at (2783412): [<802011ec>]
> __do_softirq+0xf4/0x7ac kernel/softirq.c:329
> hardirqs last disabled at (2783413): [<8277d260>]
> __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:157 [inline]
> hardirqs last disabled at (2783413): [<8277d260>]
> _raw_read_lock_irqsave+0x84/0x88 kernel/locking/spinlock.c:231
> softirqs last  enabled at (2783410): [<826b5050>] spin_unlock_bh
> include/linux/spinlock.h:399 [inline]
> softirqs last  enabled at (2783410): [<826b5050>]
> batadv_nc_purge_paths+0x10c/0x148 net/batman-adv/network-coding.c:467
> softirqs last disabled at (2783411): [<8024ddfc>] do_softirq_own_stack
> include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (2783411): [<8024ddfc>] do_softirq
> kernel/softirq.c:248 [inline]
> softirqs last disabled at (2783411): [<8024ddfc>] do_softirq+0xd8/0xe4
> kernel/softirq.c:235
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&inode->i_size_seqcount);
>   <Interrupt>
>     lock(&inode->i_size_seqcount);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by kworker/u4:0/7:
>  #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_data
> kernel/workqueue.c:615 [inline]
>  #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
>  #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at:
> process_one_work+0x214/0x998 kernel/workqueue.c:2246
>  #1: 85147ef8
> ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:
> set_work_data kernel/workqueue.c:615 [inline]
>  #1: 85147ef8
> ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
>  #1: 85147ef8
> ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:
> process_one_work+0x214/0x998 kernel/workqueue.c:2246
>  #2: 8f878010 (&ni->size_lock){...-}-{2:2}, at:
> ntfs_end_buffer_async_read+0x6c/0x558 fs/ntfs/aops.c:66

Damien? We have that revert queued up for this for 5.12, but looking
at that, the state before that was kind of messy too.


-- 
Jens Axboe

