Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310D73F1FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhHSSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHSSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:19:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C70C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:18:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k24so6667702pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5LOdLcnvC+SRsMPPojHQsg4OR8TH3GpUEW54S9ehwTc=;
        b=Ks6q097BGB14mxGFJ+1T04aF/0zcz1ec/Pp0kvtjmwkEJdIjMR+97oDLvcuRGT8evn
         C8e8t7ekuTGf4gtD8eBzSYlsXSWOeTDRD8yyXecjUyqrRyLXLVY0sfRSQ+rs5O7PKzC+
         RuG4vglbxDgFPl4TI7pa9elvXKIL/ZR8co7+pfwin8MuL/Jmvobwa2y1eY7dJoU9wvHS
         aPfR6l5pncYgFc8PA1l1zHpK4fTEopZdc1u+fl23A7MDGRfT3P02GCX59G1WvJ/Mttxv
         Hi0XIgqNoQ1M2O6KNvLJ858wJvKVIUO9LKLz0MDE03wLdc3Fl/hODenagpZwf/fJw1Hf
         UvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5LOdLcnvC+SRsMPPojHQsg4OR8TH3GpUEW54S9ehwTc=;
        b=AuUrJzXNaRJvnuQcZg9d/wnAYUChXkuKfZbiqnqSPTvhjXnbAX9SCEkGl4Zz/Wy/Bf
         /kIAsDSuzi7hre8t5lIaiCbv4rw+jHV/84XmX0LmP08eHDt1eLD23H7w5oLeljqJIu7k
         Bw5JZpv9nUWtZDzdGEw90UBAlt5mO37pEKPcFaP6/GFLU1V5SgjiwW6Lf1LJwS1J5j0h
         7zcWfZgM6fq99umqBOMNbth08FYJhzxAnYyJ6dZ6CIXwpkzFjcPjUnqeqs1f2aKb4R1g
         kuNzB7cQf6/+zhec34gOCMAAGzXgHdvmAo9AY5Ek+cttm1zEUjCJmD96O0mud5vUmbQV
         jyQg==
X-Gm-Message-State: AOAM532UHSBwtB0I/WHZBIpmly/pKabjtx4eXD4V4Ue/IRsB6B/NPdVu
        /9lt8tXD7k4BmeOLi7RTCNgLZA==
X-Google-Smtp-Source: ABdhPJyYI9QQqhAJu7H6uM6DOnFbh1AdA7RM5hj2qc40uFgB9DMQ36HOi2eZmEptewNPr7BmI427VA==
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id c6-20020a056a000ac6b0290374a33b0a74mr16028120pfl.51.1629397114742;
        Thu, 19 Aug 2021 11:18:34 -0700 (PDT)
Received: from [10.255.196.11] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id p10sm4046174pfw.28.2021.08.19.11.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 11:18:34 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
 <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
 <585f936d-9d27-a481-f590-bd07f98f34de@bytedance.com>
 <20210730160319.6dfeaf7a@oasis.local.home>
 <89c20b62-c0ab-3200-fb33-eb2058b7ba67@bytedance.com>
Message-ID: <b0b30c3d-0fb8-7d29-2a60-0cce0309986b@bytedance.com>
Date:   Fri, 20 Aug 2021 02:18:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <89c20b62-c0ab-3200-fb33-eb2058b7ba67@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 10:44 AM, Gang Li wrote:
> On 7/31/21 4:03 AM, Steven Rostedt wrote:
>> Yes, synthetic events are just like normal events, and have triggers,
>> stack traces, and do pretty much anything that another event can do.
>>
>> I'm just finishing up a libtracfs called tracefs_sql() (hopefully
>> posting it today), that allows you to create a synthetic event via an
>> SQL statement. But I don't think this is what you are looking for.
>>
>> What about using function tracing? Because the tracepoint is called
>> from __mmap_lock* helper functions that function tracer can see, you
>> can just do the following:
>>
>>   # trace-cmd start -e mmap_lock -p function -l '__mmap_lock_*'
>>   # trace-cmd show
>> [..]
>>         trace-cmd-1840    [006] ....   194.576801: 
>> __mmap_lock_do_trace_start_locking <-do_user_addr_fault
>>         trace-cmd-1840    [006] ...1   194.576805: 
>> mmap_lock_start_locking: mm=000000006515cb1f 
>> memcg_path=/user.slice/user-0.slice/session-2.scope write=false
>>
Hi!

I find that sometimes the output data is out of order, which leads to 
inaccurate time stamps and make it hard to analyse.

             node-953     [001] ....   203.823297: 
__mmap_lock_do_trace_start_locking <-do_user_addr_fault
             node-955     [002] ....   203.823297: 
__mmap_lock_do_trace_start_locking <-do_user_addr_fault
             node-956     [003] ....   203.823297: 
__mmap_lock_do_trace_start_locking <-do_user_addr_fault
             node-953     [001] ....   203.823297: 
mmap_lock_start_locking: mm=000000004395a005 
memcg_path=/user.slice/user-0.slice/session-1.scope write=false 
ip=do_user_addr_fault+0x270/0x4d0
             node-953     [001] ....   203.823298: 
__mmap_lock_do_trace_acquire_returned <-do_user_addr_fault

Is there any other way to collect ip in each event? It seems that adding 
"ip" fields is the only way to do this accurately and effectively.
