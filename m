Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E9402CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbhIGQPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhIGQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:15:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E400C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:14:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a22so5464123iok.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ocAbRfkRSVpNHeDLSlcbbOznxT7qGzgjfFfLF+3x3Hw=;
        b=UHUjSG6V2zAED0y56RYnJWnVU4MGEVDqOXr1KZX/NgYahZ0Duj8Q4aRxF0BE8erBGT
         cnsbKJ2GfIKKrIM0e0XvY+clw2YQwSxvb7yKRqS8B/Tm2BKKBGX7Zs52l3MB9pi1Axm7
         3n3KCpODuIjXU4iqwr5mLyXPG5YWtL4O1KTEVBKMX3H1c2HilsAKA1KOKmtzpeD+Lvzt
         enJNjSYgxz8XIRsLTRblDyEKXozNpYoInjwXWfCZwQ5Rj3AQB45R+eF9wXo7KqueR7eB
         l5X7o4mJyeUPXq2Uwg21TBJCe4N/5QJ0J/Ue8+2IbgwzSMYM/DCFkHD1ea8X35P802VR
         lT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ocAbRfkRSVpNHeDLSlcbbOznxT7qGzgjfFfLF+3x3Hw=;
        b=uGs6m5uEKj5aXvWXkY92XiPalLVyy+hrTgJTdSHl49oaPBp5EFPhjI1l2M/kWrw4Y2
         ovU/1lPBlAQxG5PwRLQPDa6JAEeVTd/KpV86+A6TbZ2FIFw5wpl829DlNsNTRivnCNKH
         pR4QaGk3qWHEgdwXVVmYvAhh6xyA7hdkWgyA3aCBmC0YAnprBlQxlnblv8vAX8i55Cn/
         Y4je2fy6mzdnU567zQbvTPM/gicHOVUzIUSxLauBzk895aTsesJZt/R9VO/WiNkFZsN5
         XMRuL85xN6yG0TB3n9oPWH/6mOcFgYDGORozcRIVVHVeJ4bWfWfDsaG4SFwXiy2df2nV
         HV4g==
X-Gm-Message-State: AOAM531O95i/DeSNN6dnT/4codJHSsVdftjF88zZngIWLJbCX031bN78
        +9asN/iO/MwyefxIK1KxkKCpHA==
X-Google-Smtp-Source: ABdhPJw6pWIkN5gPkz6k/wxAFs5+njd0ac/36v7H1Ca+PZZaHi5X4HGrE0gvgsGBRNFNBbXeVUPEAg==
X-Received: by 2002:a6b:710f:: with SMTP id q15mr14740308iog.77.1631031264510;
        Tue, 07 Sep 2021 09:14:24 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m10sm6495441ilg.20.2021.09.07.09.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:14:23 -0700 (PDT)
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6%
 regression
To:     Shakeel Butt <shakeelb@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Roman Gushchin <guro@fb.com>,
        Serge Hallyn <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20210907150757.GE17617@xsang-OptiPlex-9020>
 <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CALvZod6S+NmG8+-ftS-w3t3zJg_kbr3-F9h-n4jwSnqh0jTUGQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <27face50-0e55-ad2b-ebb7-2fe48aee8374@kernel.dk>
Date:   Tue, 7 Sep 2021 10:14:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6S+NmG8+-ftS-w3t3zJg_kbr3-F9h-n4jwSnqh0jTUGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 9:57 AM, Shakeel Butt wrote:
> On Tue, Sep 7, 2021 at 8:46 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/7/21 9:07 AM, kernel test robot wrote:
>>>
>>>
>>> Greeting,
>>>
>>> FYI, we noticed a -33.6% regression of will-it-scale.per_process_ops due to commit:
>>>
>>>
>>> commit: 0f12156dff2862ac54235fc72703f18770769042 ("memcg: enable accounting for file lock caches")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> Are we at all worried about these? There's been a number of them
>> reported, basically for all the accounting enablements that have been
>> done in this merge window.
>>
>> When io_uring was switched to use accounted memory, we did a bunch of
>> work to ameliorate the inevitable slowdowns that happen if you do
>> repeated allocs and/or frees and have memcg accounting enabled.
>>
> 
> I think these are important and we should aim to continuously improve
> performance with memcg accounting. I would like to know more about the
> io_uring work done to improve memcg accounting. Maybe we can
> generalize it to others as well.

It's pretty basic and may not be applicable to all cases, we simply hang
on to our allocations for longer periods and reuse them. Hence instead
of always going through alloc+free to each "unit", they are recycled and
reused until no longer needed.

Now this is more efficient in general for us, as we can have a very high
rate of requests (and hence allocs+frees). I suspect most use cases
would benefit from simply having a cache in front of memcg slabs, but
that seems like solving the issue at the wrong layer. IMHO it'd be
better to have the memcg accounting be done in batches, eg have some
notion of deferred frees. If someone allocates before the deferred frees
are accounted, then that would have saved two pieces of accounting.

It is of course possible that a lot of these regressions are simply
accounting the alloc, in which case it seems like accounting in batches
might help there. All depends on the slack that is acceptable for memcg.

-- 
Jens Axboe

