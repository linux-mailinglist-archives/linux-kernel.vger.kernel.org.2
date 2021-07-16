Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2511B3CB0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhGPCuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232046AbhGPCuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626403635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RAtuj+0C2J7KjfmSEk0StvYjljoVaQeF+ao+6KxF+I=;
        b=igL9kvCQgXTmwBcfdekfRsaLtxUjzoGxXrZEvuxaVgxjjxVdlI/Lozh52Jv1QZV15c2WcV
        DfhyehUg98VeFqmKrxslUq0E5ExUzj+WLZHu++2knf8KoKQjOoEL17F/uVKg6ku4w3RCc+
        GOUhaVJWuu/+BdLkXvIUfnBWwDxr7wk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-CNDsi5rBNUGNXCe5U4-b1Q-1; Thu, 15 Jul 2021 22:47:14 -0400
X-MC-Unique: CNDsi5rBNUGNXCe5U4-b1Q-1
Received: by mail-pj1-f70.google.com with SMTP id jx12-20020a17090b46ccb029017365ced08eso1412354pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 19:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+RAtuj+0C2J7KjfmSEk0StvYjljoVaQeF+ao+6KxF+I=;
        b=fdjFMsg8zfUfRvTkrjzWrx4+CaDfdS3xDy81H5HC3N06AV1ET6HTzsFSxYm97bTE1R
         1KqdU/YhAHxfjPLeA+ASmit23dmZzvM1ChFbgWn4e405Jhii0HUJ8DTMN8A1+jbfKdRP
         +NPA8wytS5WpUfhjSW+cI8xittZGdcLi33MjgMs7j0uI1OPq3j8n361tCP/0zSTXNJfK
         cvejGx9rY5ZU3877W2YGYuO6hYvZO58Im7oONq/jEecgADtX27y34JTB42lr3iu1uUmf
         7LLUGEjxHwPDYunhKRTR28Cm84bg4Py9PF2659JuhCUfUMqkkTSsQ/2lN682O3CleyBN
         Ub9Q==
X-Gm-Message-State: AOAM533vl5DIqczHsD5lDHN0qBASeecab33e34R2Daf9ZE+YKyCg19yr
        b7j/ZLFgp+o1tiZT1eFPizLGQDxjMWWdatSgyoKVCgepWGuaziN4YoKF+sLakxUVF4jIzeC+0oi
        dsfsaYkdgq0Xzgmu6A8Q53UuN
X-Received: by 2002:a17:90b:128a:: with SMTP id fw10mr7559313pjb.116.1626403633264;
        Thu, 15 Jul 2021 19:47:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKmfMfhmkj9dt+bZtzzgukWhdut8BUpkXriOBq4CJvi3bl9iJSLSIe+9HgvOMD/AmeMt/gpQ==
X-Received: by 2002:a17:90b:128a:: with SMTP id fw10mr7559291pjb.116.1626403632990;
        Thu, 15 Jul 2021 19:47:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i1sm10373047pjs.31.2021.07.15.19.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 19:47:12 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     He Zhe <zhe.he@windriver.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xie Yongji <xieyongji@bytedance.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
 <ab85cd9e-f389-0641-8084-cdfbc5c91e0b@windriver.com>
 <b73f8986-9071-6fbb-5c6a-d7892ba2302b@redhat.com>
 <e20c3d90-db24-7722-3f89-adadb83a9bf7@windriver.com>
 <c05b358b-1e96-c002-085c-b25e416e7be5@redhat.com>
 <97704aa6-46eb-2462-a4d9-2bf93144a5ac@redhat.com>
 <ad686185-37d6-63c7-b222-49356be16d1a@windriver.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f5f08425-e396-8e39-1c23-9aeb98bfe451@redhat.com>
Date:   Fri, 16 Jul 2021 10:46:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ad686185-37d6-63c7-b222-49356be16d1a@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/16 上午10:43, He Zhe 写道:
>
> On 7/16/21 10:26 AM, Jason Wang wrote:
>> 在 2021/7/15 下午7:05, Paolo Bonzini 写道:
>>> On 15/07/21 12:10, He Zhe wrote:
>>>> The following was provided in this thread. The commit log contains the call traces that I met and fixed back to Apr. 2020.
>>>>
>>>> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
>>>> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
>>>> ---- snip ----
>>>> 001: Call Trace:
>>>> 001:  vhost_signal+0x15e/0x1b0 [vhost]
>>>> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
>>>> 001:  handle_rx+0xb9/0x900 [vhost_net]
>>>> 001:  handle_rx_net+0x15/0x20 [vhost_net]
>>>> 001:  vhost_worker+0xbe/0x120 [vhost]
>>>> 001:  kthread+0x106/0x140
>>>> 001:  ? log_used.part.0+0x20/0x20 [vhost]
>>>> 001:  ? kthread_park+0x90/0x90
>>>> 001:  ret_from_fork+0x35/0x40
>>> This call trace is not of a reentrant call; there is only one call to eventfd_signal.  It does fit the symptoms that Daniel reported for PREEMPT_RT though.
>>>
>>>> https://lore.kernel.org/lkml/beac2025-2e11-8ed0-61e2-9f6e633482e8@redhat.com/
>>> This one is about PREEMPT_RT, so it would be fixed by local_lock.
>>>
>>> There _may_ be two bugs, so let's start by fixing this one.  Once this one is fixed, we will examine the call stacks of any further reports, and diagnose whether the second bug (if it exists) is related to vDUSE, PREEMPT_RT or neeither.
>>
>> For VDUSE we may still need the patch since it tries to relay notifications (eventfds) which means the recursion of the eventfd signal.
>>
>> But looking at the comment in the eventfd_signal() which say we should check with eventfd_signal_count() and delay the signal into a safe context (e.g workqueue etc).
> The main concern when adding eventfd count at the very beginning is "Deadlock or stack overflow" in the inline comment. If we can avoid deadlock and one depth of nest is acceptable, I think it's safe to set the max count to 2.


That's my understanding as well.


>
> The author of the eventfd count kind of also agrees with this.
> https://lore.kernel.org/lkml/3b4aa4cb-0e76-89c2-c48a-cf24e1a36bc2@kernel.dk/


Ok.

Thanks


>
> Thanks,
> Zhe
>
>> Thanks
>>
>>
>>> Paolo
>>>

