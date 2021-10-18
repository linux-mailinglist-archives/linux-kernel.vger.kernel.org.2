Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16AD431158
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhJRHXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhJRHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:23:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46503C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:21:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i76so11877776pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Waoh7FE62gxhLg87Tgkd+4LHcbVYAyUliQvnhrotbxk=;
        b=h4Tbs5GvBbuRfGr031ZMbAh5DaUTySUYg1xnPJHqeG/ba3Il2EMzR1KHM/VEvPIJBF
         ExTWoneFMhPcjf4ivjM4DUOlzBefb2SDn33Dm8oA0mQ3178xoHSIDJvPry2EZZBtVL5v
         R8nSsQx+OLYn33P/yjqTgiAvYkN7uBZ9vvmb0HANUrQzTEiA568sD8aswZrWndnZe4hT
         1qlxBN3B/z/gTOrH89uP93yM+Aw4dgNMe9H7VV7YIogeV2GFIIIL51nHEE3RQItOD+vN
         6BHYqPegdAOh7eJVA8RrwTjao4YO678CKjWEntvMb1LzTPRVTUb8SqLtYcwGGoaD5UeR
         NlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Waoh7FE62gxhLg87Tgkd+4LHcbVYAyUliQvnhrotbxk=;
        b=K8H4IGI+kSjaAD6s/nKMdD3/xCEC0eJGnvFxf9M70fkyA5gB+/aaZGNLV0YlncVrbe
         wWKM1Kqr9lRo8EC4Tke/y+u+CHnDwX5uHoMFonhG+nujoaQxTHNg+M2Q6A6JVoisYYkC
         p3nHPQW8d0hmWa8El5r2xBrfVRe447/D5MvshNQivjY+srdBLeO8rgCnvepi6DFD8C73
         RvrLANnm7WwZdsX5DjJZuwQXWPzE66a8e+2Zr0hEQCm5yxda8gkJiCtXC2Vug343j9RL
         c27fJClAz8/KVohBwwk2zSMmFepIW/8N7pWfnvzZRS4+DIPVcVWkzIwy4M1NeZaGhTGv
         SU3A==
X-Gm-Message-State: AOAM532cdLy2CwfMNw7Uq2Zmk8tSpoGnO1aSasd82geXchAoNwZ5PVyq
        N1tQe9bCubAHmFVyWvT+CXo=
X-Google-Smtp-Source: ABdhPJw3nU8/N+oGHEw8P2MVDpVsZS7A/mRkIbKeU6e5yjmfYYJ/kOxxZLj371LVxAAnOvb/+rPL7w==
X-Received: by 2002:aa7:83d1:0:b0:44c:654a:be1d with SMTP id j17-20020aa783d1000000b0044c654abe1dmr26871180pfn.68.1634541681824;
        Mon, 18 Oct 2021 00:21:21 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id 17sm12101171pgr.10.2021.10.18.00.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 00:21:21 -0700 (PDT)
Subject: Re: WARNING in __init_work
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hao Sun <sunhao.th@gmail.com>, Hillf Danton <hdanton@sina.com>,
        hch@infradead.org, willy@infradead.org,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <CACkBjsZfAZpOFeYC8mQ03r_JB_eF-dNMEkXf3LNji7_CgOCF2Q@mail.gmail.com>
 <20210907074432.3711-1-hdanton@sina.com>
 <CACkBjsYsxNqkup1FQkP4eMzxZ_xNgifPx+gFxEo0gnBUYPp1PQ@mail.gmail.com>
 <d242861c-5c41-0d1b-3f71-43f50e5a3b68@gmail.com>
 <20211018044745.GA23657@lst.de>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <a46dfeb8-8217-c0cc-bdce-08a7605a5a25@gmail.com>
Date:   Mon, 18 Oct 2021 15:21:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211018044745.GA23657@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/10/18 下午12:47, Christoph Hellwig wrote:
>
> On Mon, Oct 18, 2021 at 12:43:38PM +0800, Zqiang wrote:
>> This is the details of the test, Hope it helps you
> Call me stupid, but I can only find the trace and linked to unreadable
> google sites that wan't me to log in somehow and no actual details.
>
> If you have a direct link to the reproducer (an attachment would do
> it as well) I'd love to try it myself.
>
> Otherwise this commit in the block-5.15 tree should help to catch what
> I suspect is the root cause (final ref drop before unregister) earlier
> and with a better backtrace:
>
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.15&id=a20417611b98e12a724e5c828c472ea16990b71f

I found the following calltrace

Call Trace:
[  326.460593][T27634]  dump_stack_lvl+0x8d/0xcf
[  326.461773][T27634]  should_fail+0x13c/0x160
[  326.462921][T27634]  should_failslab+0x5/0x10
[  326.464038][T27634] slab_pre_alloc_hook.constprop.100+0x4e/0xc0
[  326.466040][T27634]  kmem_cache_alloc+0x44/0x2a0
[  326.466921][T27634]  __kernfs_new_node+0x68/0x350
[  326.469602][T27634]  kernfs_new_node+0x5a/0x90
[  326.470441][T27634]  __kernfs_create_file+0x56/0x150
[  326.471386][T27634]  sysfs_add_file_mode_ns+0xe6/0x290
[  326.472358][T27634]  internal_create_group+0x186/0x4e0
[  326.473331][T27634]  internal_create_groups.part.4+0x4d/0xb0
[  326.474288][T27634]  sysfs_create_groups+0x28/0x40
[  326.474918][T27634]  device_add+0x4c3/0xc60
[  326.476286][T27634]  add_partition+0x262/0x450
[  326.476919][T27634]  bdev_disk_changed+0x3ec/0x800
[  326.477615][T27634]  loop_reread_partitions+0x2d/0x70
[  326.478515][T27634]  loop_set_status+0x274/0x320
[  326.479373][T27634]  lo_ioctl+0x392/0x920
[  326.481271][T27634]  blkdev_ioctl+0x2ff/0x370
[  326.482438][T27634]  block_ioctl+0x55/0x70
[  326.483605][T27634]  __x64_sys_ioctl+0xb6/0x100
[  326.484241][T27634]  do_syscall_64+0x34/0xb0
[  326.484843][T27634]  entry_SYSCALL_64_after_hwframe+0x44/0xae

I find in add_partition(),  if the device_add() return error, we will 
drop disk object reference count,

but i find put_device(pdev) (will call part_release())and 
put_disk(disk), both will reduce the reference of the disk object , 
however we call get_device(disk_to_dev(disk)) only once

or Did I miss something and didn't analyze it？

Thanks

Zqiang




