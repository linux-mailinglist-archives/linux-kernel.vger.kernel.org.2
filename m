Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6CB39CE9E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 12:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFFKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 06:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFKrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 06:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622976352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HilGFSprc7YIEedvPuaQGfj7Ylt2W0rsufgmNzneQE=;
        b=CBNHEm+Vm1+uUIa0HRqh67QREdIeCsvUV9xAllI0dIgOOI33VGRpfa1/WG9UYGJopR1x4I
        auMF6TNZyV1pLXjVDqXUCVOi4+hOrnDR+HsB2QZjmrEbGR/D8DAQLG8MF/wq4KHzJzjxj/
        KBDTxAtCFNv7B3tD8ZnwvIfkC0M9RjU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-hdsq9pOcMSOMN0NfTsKJrQ-1; Sun, 06 Jun 2021 06:45:48 -0400
X-MC-Unique: hdsq9pOcMSOMN0NfTsKJrQ-1
Received: by mail-wr1-f70.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so6650469wrc.16
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 03:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/HilGFSprc7YIEedvPuaQGfj7Ylt2W0rsufgmNzneQE=;
        b=HZcjUx6BNBIRbrtuSM+8LscPiDlNiaHIq8i57vPLpVz15qyi2He5ELapllgy7w3zcX
         P/PrDp+SaGIXQP+J92T1EPQm06dk4eYXFtA8V5AsWzVkNSCN6f3eS/0XPXkvVjkD+FvU
         n53RjwG8VXRTRbgEaJEGc0fYuZBg175BMCgeMkq+qqPKW9Xoj7+BzLvw1AuJM7NjKz7j
         hfHvO7a3jxz3WZhu6Mpdr+P2hr77U7mKb2foo1mwd7rPBajoGOnOoWie5cZAcMeSVN84
         V4QofdN9Mx1kEulOB4wesS8tJjAgnqgs5oyR/2NzlarVL8Qc1vAzZyie9MHi+TECk6Si
         ldRw==
X-Gm-Message-State: AOAM531saLzymeKpTZMUD8ZGiXrRN1rCZ2uhx0p30MPWsIusW3vjb7Bx
        /kUEK9gc9yvhgFzXA4dVig0Ta4w/rUxm94WI+X0CugkBkWrr3Hm5wa02LrlB+oXiUP2G5R8dc43
        p7LDQW/hqMiN68PWbKj/g8TY/
X-Received: by 2002:a1c:7508:: with SMTP id o8mr11795340wmc.70.1622976347800;
        Sun, 06 Jun 2021 03:45:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT0ZOIVt4u7phjM8iGhd6Z6zCDQDV96nEVWCXs8D6/rSL4dr76fRMRcXDoMNIbSkIRNIyMTQ==
X-Received: by 2002:a1c:7508:: with SMTP id o8mr11795321wmc.70.1622976347617;
        Sun, 06 Jun 2021 03:45:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65e5.dip0.t-ipconnect.de. [91.12.101.229])
        by smtp.gmail.com with ESMTPSA id g205sm7110144wme.6.2021.06.06.03.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 03:45:47 -0700 (PDT)
Subject: Re: [RFC PATCH V2] zram:calculate available memory when zram is used
To:     Greg KH <gregkh@linuxfoundation.org>, yongw.pur@gmail.com
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, linux-api@vger.kernel.org
References: <1622910240-4621-1-git-send-email-yongw.pur@gmail.com>
 <YLuvQwkZkl9UCoJw@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <aa43a75c-4699-0540-f918-5b2788b49162@redhat.com>
Date:   Sun, 6 Jun 2021 12:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YLuvQwkZkl9UCoJw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.21 19:07, Greg KH wrote:
> On Sat, Jun 05, 2021 at 09:24:00AM -0700, yongw.pur@gmail.com wrote:
>> From: wangyong <yongw.pur@gmail.com>
>>
>> When zram is used, available+Swap free memory is obviously
>> bigger than we actually can use, because zram can compress
>> memory by compression algorithm and zram compressed data
>> will occupy memory too.
>>
>> So, we can count the compression ratio of zram in the kernel.
>> The space will be saved by zram and other swap device are
>> calculated as follows:
>> zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
>> We can evaluate the available memory of the whole system as:
>> MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfree]
>>
>> Add an entry to the /proc/meminfo file, returns swap will save space.
>> Which name is more appropriate is still under consideration.
>> There are several alternative names: SwapAvailable, SwapSaved,
>> SwapCompressible
>>
>> Signed-off-by: wangyong <yongw.pur@gmail.com>
>> ---
>>   drivers/block/zram/zcomp.h    |  1 +
>>   drivers/block/zram/zram_drv.c | 19 +++++++++
>>   drivers/block/zram/zram_drv.h |  1 +
>>   fs/proc/meminfo.c             |  1 +
>>   include/linux/swap.h          | 10 +++++
>>   mm/swapfile.c                 | 95 +++++++++++++++++++++++++++++++++++++++++++
>>   mm/vmscan.c                   |  1 +
>>   7 files changed, 128 insertions(+)
> 
> You are adding a new sysfs file with no new Documentation/ABI entry.

Indeed. And in the best case, the change would be accompanied with a man 
page update patch for the "proc" man page.

> Also are you sure you are allowed to add a new proc file entry without
> breaking existing tools?

I think adding new entries is not a problem. Parsers have to deal with 
new entries popping up. For example, we introduced "ShadowCallStack:" in 
2020 via 628d06a48f57 ("scs: Add page accounting for shadow call stack 
allocations").


-- 
Thanks,

David / dhildenb

