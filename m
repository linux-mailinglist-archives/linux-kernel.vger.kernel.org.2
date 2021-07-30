Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C933F3DB2D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhG3FcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhG3FcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:32:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B21C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 22:32:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e21so9741133pla.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 22:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tc/E0qrtXkKG5TqRhI2Z9x1vlmmiIqFXZ6WxPD+IjN0=;
        b=ajAyDT4MLNPRQ3vOGK024+ZLMZe0q08hEQ/v2442VjDZjJB0GkXFWTNhtuA0WlnQn6
         0J5PzKV5vZmT1Vo0AEK+1MqBwSwDd+4WFbb6u9Scl+/xCpWRbtj+rPlVQH3y4z6l8NUI
         DNKn5+R4w1qMoiKKC2VdewVm54jEEq6co9ha5KDuxG2XDjQhqstBRzbAGJFFxEFitTWQ
         VI5QGbjuiBCNH4wOOST7J6aVibyFeCuGjlE46fcHf1gGEu0PMMPC+/fB3MyL0D/AsoH/
         oUuzAZBEoRUZUep34XZvsPFZhrymYdppo7+Ei8acXH24ifE0T+PknoENv6T5mZWJe7Ho
         Yqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tc/E0qrtXkKG5TqRhI2Z9x1vlmmiIqFXZ6WxPD+IjN0=;
        b=dB5cdufL5JVUjzpHWuhRZ4Lmsnz469AykcgDMWTKqNVmIx3hAvJH+s6oT/EvAURNUG
         NT7UvvviIfZn/kD42W+gQH/loHVED4553VJOzR1aJq/f4skDJ+z4VNfLRg32yAWzN+Nr
         gAPOe6ZbAQcvoiZdRpsm/EY6GlKrNqh4gNeqIr4WY3Ipo8+BNBQNAeVxRfIkxeFA8VqO
         uJ4xIWsaXQp//sO4r21ThgdRwK1scXWPiu85Z4NQcNAj+34UceI4x+UQXRFG9SOQJpvX
         EZoOyxAbdVMRNZ3GgdW/E64qyGUYgGEsRyWgg8MizArx2auYOPGoe8ZvcnjdADCtwidQ
         iELA==
X-Gm-Message-State: AOAM531fL2ZfrlTu2hER9E6V+xgTGX65wh4olscux7A7Ex7ceRi8Mx3N
        UhsBlYfJBvJV4yaWIwcSzmcq4A==
X-Google-Smtp-Source: ABdhPJyNuONqblrBqBkC6RaWPNkLKL/Yze00pMoniSvyjSfV8VO6bjonJnl0e4xqrrbztDp5x1ZRsA==
X-Received: by 2002:a17:90a:e7c7:: with SMTP id kb7mr1190320pjb.43.1627623137771;
        Thu, 29 Jul 2021 22:32:17 -0700 (PDT)
Received: from [10.76.46.68] ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id 81sm364046pfv.185.2021.07.29.22.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 22:32:17 -0700 (PDT)
Subject: Re: Re: [PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
 <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
Message-ID: <585f936d-9d27-a481-f590-bd07f98f34de@bytedance.com>
Date:   Fri, 30 Jul 2021 13:32:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! I have tried your suggestion. They are great, especially 
synthetic-events.

If don't print ip per event, we can only guess which one cause the 
contention by "hitcount".

 > 
(https://www.kernel.org/doc/html/latest/trace/histogram.html#synthetic-events)

But it seems that they only support histogram, can I print the
synthetic-events args per event in /sys/kernel/debug/tracing/trace
like other events? I haven't found that in kernel doc.

On 7/30/21 1:33 AM, Axel Rasmussen wrote:
> Not a strong objection, but I think this can be achieved already using either:
> 
> - The "stacktrace" feature which histogram triggers support
> (https://www.kernel.org/doc/html/latest/trace/histogram.html)
> - bpftrace's kstack/ustack feature
> (https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md#lesson-9-profile-on-cpu-kernel-stacks)
> 
> I haven't tried it out myself, but I suspect you could construct a
> synthetic event
> (https://www.kernel.org/doc/html/latest/trace/histogram.html#synthetic-events)
> which adds in the stack trace, then it ought to function a lot like it
> would with this patch.
> 
> Then again, it's not like this change is huge by any means. So, if you
> find this more convenient than those alternatives, you can take:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> It's possible Steven or Tom have a more strong opinion on this though. ;)
> 
> On Thu, Jul 29, 2021 at 2:29 AM Gang Li <ligang.bdlg@bytedance.com> wrote:
>>
>> The mmap_lock is acquired on most (all?) mmap / munmap / page fault
>> operations, so a multi-threaded process which does a lot of these
>> can experience significant contention. Sometimes we want to know
>> where the lock is hold. And it's hard to locate without collecting ip.
>>
>> Here's an example: TP_printk("ip=%pS",ip)
>> Log looks like this: "ip=do_user_addr_fault+0x274/0x640"
>>
>> We can find out who cause the contention amd make some improvements
>> for it.
>>
>> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

