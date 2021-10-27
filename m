Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF26843CF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbhJ0RGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238216AbhJ0RGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635354244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTAZF8r+TFqRNwTv8HewNHfpavSVFjmpiDqPZBBTd9c=;
        b=GjGZ7aqRfdAhqWfcxRnEThM+XpLRB7nll24I77I5R0qyf0mXkw13NT8ATdwCQQIdZRbJNV
        zpVmpZfc1sT6jl4KKSJC44Hge7oCqS8FIupZPTzl6chSCSEjrPpxnFD5C+sxcJIeulmPXs
        5eC1XHbr56RRTBxfZpoeqH/xEjMe6Eg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-n2gyQKKwPpK8nWhVZwru9g-1; Wed, 27 Oct 2021 13:04:02 -0400
X-MC-Unique: n2gyQKKwPpK8nWhVZwru9g-1
Received: by mail-wr1-f70.google.com with SMTP id f2-20020a5d50c2000000b00167f5c0a206so904912wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=rTAZF8r+TFqRNwTv8HewNHfpavSVFjmpiDqPZBBTd9c=;
        b=bfS//Frtb3VeQ+88Lli7zaD8cqu+e+pAlJoRf3BDzNWmGHiR19vrmNCEfUb+C6UNwg
         rHdVk6yAE5IVssNAnjJ6g4TCzXPcxYTlZQwgrUznSKK+E1my/xaDD46xvV90GRJCktYe
         KLERjAo6I4HL5n9t7agMwsqvCrpTsusftqqXlzvkmP1KUJCGa1klrX4xEI7kyYcZdOb8
         m05ddP6fdfrY2ZghrQAE/MmX7gYN4E3kEhu5bOQ1wqB9sCZARg0RnB2W8EesffvaXo+V
         OkKONQpjNCIe3akocD/2FxJNYJkkPp5exsmyyL6Ib5xEy4kipFEVvdfHboWN8hHmlY76
         ZsWw==
X-Gm-Message-State: AOAM533X8uUTvwWZfSwKHiA05wDoHqINMnqs8Wm011UkKxYwsFHKMWXz
        p0jZVNSJr/9+6q4VBNX39pLcjKZpPBNQ6WHOZtnKTxjg2VZqQllbmPadOjKchuwLYVi5IeGld2v
        I8JRB/DaS3b49IGBlalNKwCwj
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr6931387wmg.35.1635354241250;
        Wed, 27 Oct 2021 10:04:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/UPN0VVE4tAb3UN0yDI+71apndaQMXqM5UDEuJD4h6Pvaa/WHZ+M444Zi2IZzGUjPpILneA==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr6931361wmg.35.1635354241008;
        Wed, 27 Oct 2021 10:04:01 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.14.190])
        by smtp.gmail.com with ESMTPSA id j9sm384612wrt.96.2021.10.27.10.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 10:04:00 -0700 (PDT)
Message-ID: <8b5fb6ae-ab66-607f-b7c8-993c483846ca@redhat.com>
Date:   Wed, 27 Oct 2021 19:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in copy_data
Content-Language: en-US
From:   Laurent Vivier <lvivier@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+b86736b5935e0d25b446@syzkaller.appspotmail.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au, jiri@nvidia.com,
        kuba@kernel.org, leonro@nvidia.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpm@selenic.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a4cd2105cf441e76@google.com>
 <eab57f0e-d3c6-7619-97cc-9bc3a7a07219@redhat.com>
 <CACT4Y+amyT9dk-6iVqru-wQnotmwW=bt4VwaysgzjH9=PkxGww@mail.gmail.com>
 <20211027111300-mutt-send-email-mst@kernel.org>
 <589f86e0-af0e-c172-7ec6-72148ba7b3b0@redhat.com>
In-Reply-To: <589f86e0-af0e-c172-7ec6-72148ba7b3b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2021 18:25, Laurent Vivier wrote:
> On 27/10/2021 17:28, Michael S. Tsirkin wrote:
>> On Wed, Oct 27, 2021 at 03:36:19PM +0200, Dmitry Vyukov wrote:
>>> On Wed, 27 Oct 2021 at 15:11, Laurent Vivier <lvivier@redhat.com> wrote:
>>>>
>>>> On 26/10/2021 18:39, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    9ae1fbdeabd3 Add linux-next specific files for 20211025
>>>>> git tree:       linux-next
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1331363cb00000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=aeb17e42bc109064
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=b86736b5935e0d25b446
>>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for 
>>>>> Debian) 2.35.2
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116ce954b00000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132fcf62b00000
>>>>>
>>>>> The issue was bisected to:
>>>>>
>>>>> commit 22849b5ea5952d853547cc5e0651f34a246b2a4f
>>>>> Author: Leon Romanovsky <leonro@nvidia.com>
>>>>> Date:   Thu Oct 21 14:16:14 2021 +0000
>>>>>
>>>>>       devlink: Remove not-executed trap policer notifications
>>>>>
>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137d8bfcb00000
>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10fd8bfcb00000
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=177d8bfcb00000
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>> Reported-by: syzbot+b86736b5935e0d25b446@syzkaller.appspotmail.com
>>>>> Fixes: 22849b5ea595 ("devlink: Remove not-executed trap policer notifications")
>>>>>
>>>>> ==================================================================
>>>>> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/fortify-string.h:225 [inline]
>>>>> BUG: KASAN: slab-out-of-bounds in copy_data+0xf3/0x2e0 
>>>>> drivers/char/hw_random/virtio-rng.c:68
>>>>> Read of size 64 at addr ffff88801a7a1580 by task syz-executor989/6542
>>>>>
>>>>
>>>> I'm not able to reproduce the problem with next-20211026 and the C reproducer.
>>>>
>>>> And reviewing the code in copy_data() I don't see any issue.
>>>>
>>>> Is it possible to know what it the VM configuration used to test it?
>>>
>>> Hi Laurent,
>>>
>>> syzbot used e2-standard-2 GCE VM when that happened.
>>> You can see some info about these VMs under the "VM info" link on the dashboard.
>>
>> Could you pls confirm whether reverting
>> caaf2874ba27b92bca6f0298bf88bad94067ec37 addresses this?
>>
> 
> I've restarted the syzbot on top of "hwrng: virtio - don't wait on cleanup" [1] and the 
> problem has not been triggered.
> 
> See https://syzkaller.appspot.com/bug?extid=b86736b5935e0d25b446

The problem seems to be introduced by the last patch:

"hwrng: virtio - always add a pending request"

not

"hwrng: virtio - don't waste entropy"

Thanks,
Laurent

> 
> Thanks,
> Laurent
> 
> [1]
> d721abbeb145 hwrng: virtio - don't wait on cleanup
> bb768beb0a5f hwrng: virtio - add an internal buffer
> d25f27432f80 (origin/master, origin/HEAD, master) Merge tag 'arm-soc-fixes-5.15-3' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> 

