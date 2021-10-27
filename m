Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2414D43C385
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbhJ0HKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236153AbhJ0HKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635318489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LpE+Ob5AjjJOTxjUmx4/xC9nQg/xV3VH4DZnf1t0as8=;
        b=L096aJS0/C+Mde8pbpomGB5reJHkTcWu1BI+Tv0FNK82RkQiTxsrexsOljdynhpls6w65X
        A8nQyv6/jxpYdjP8S78KGlOZ8tWjcEGL8r/ls8po81+akZs8MrKyyh9qvZAEagXlrnq+tZ
        xkO4OHlyakBLtLD0KUQ2JYaOsBna4TQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-LmS3f__aPbekKi-rx5yYkA-1; Wed, 27 Oct 2021 03:08:07 -0400
X-MC-Unique: LmS3f__aPbekKi-rx5yYkA-1
Received: by mail-wr1-f70.google.com with SMTP id a15-20020a056000188f00b00161068d8461so304587wri.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LpE+Ob5AjjJOTxjUmx4/xC9nQg/xV3VH4DZnf1t0as8=;
        b=E7CPzdu4utH0PWueHQweHFMTwV/2GpvkvjTGJB6CnZZhSIQPoD1jXueoV46ZILeZaS
         RYe7zwqKe5mglpagHABed11hBPlsVOj+e4QQ7BnbQjkB6LDF+8WlmGxsL1uPdLHLRYcT
         SfSfBbMdEeYsM58tBuUm5qVL/02BE7faSyutojj+cBN7KgL0Yvvd7RuAZ5m8DOzzHFD2
         VayHn9PjPV08iVyKrJYAXI2PKaZaGOCCTw4ASMqfAJ9Pc2KBlML8oglfo4QTnunm1EJX
         asKrtftNCXJ2psP4pWh2Oq+vLGTZa3Y1FPG5REJ4ubz4ah1Yr+HAzSgd3AXgHcQG+pi/
         yg3Q==
X-Gm-Message-State: AOAM530azGsd/oGfB3HdlzN4abedG8XqZPJAGEBwbd5/Y1Y1tXmHSCGm
        aIMTUJGs77lUm6LxEXUQMopvDGWRml0CdnlnkILsR0e/zGksCYrJ/KvX9tlFw9xoegNGHD6O9z3
        0FfVemvJnf2rkqkc1P6hjlXLB
X-Received: by 2002:a5d:494d:: with SMTP id r13mr38285143wrs.222.1635318486486;
        Wed, 27 Oct 2021 00:08:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf37l5gdvKcKdjqCrZo/kpOfCDswUMNaEnj2mAOufEC32VQVVHsjAg4MKPQSIlTnjZWd1EGQ==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr38285112wrs.222.1635318486297;
        Wed, 27 Oct 2021 00:08:06 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.14.190])
        by smtp.gmail.com with ESMTPSA id e17sm7721173wrx.18.2021.10.27.00.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 00:08:05 -0700 (PDT)
Message-ID: <6c7e48b9-5204-352f-18e7-26b13d70f966@redhat.com>
Date:   Wed, 27 Oct 2021 09:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in copy_data
Content-Language: en-US
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+b86736b5935e0d25b446@syzkaller.appspotmail.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au, jiri@nvidia.com,
        kuba@kernel.org, leonro@nvidia.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpm@selenic.com, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a4cd2105cf441e76@google.com>
 <b6d96f08-78df-cf34-5e58-572b3fd4b566@gmail.com>
From:   Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <b6d96f08-78df-cf34-5e58-572b3fd4b566@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2021 00:34, Eric Dumazet wrote:
> 
> 
> On 10/26/21 9:39 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    9ae1fbdeabd3 Add linux-next specific files for 20211025
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1331363cb00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=aeb17e42bc109064
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b86736b5935e0d25b446
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116ce954b00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132fcf62b00000
>>
>> The issue was bisected to:
>>
>> commit 22849b5ea5952d853547cc5e0651f34a246b2a4f
>> Author: Leon Romanovsky <leonro@nvidia.com>
>> Date:   Thu Oct 21 14:16:14 2021 +0000
>>
>>      devlink: Remove not-executed trap policer notifications
> 
> More likely this came with
> 
> caaf2874ba27b92bca6f0298bf88bad94067ec37 hwrng: virtio - don't waste entropy
> 

I'm going to have a look.

Thanks,
Laurent


