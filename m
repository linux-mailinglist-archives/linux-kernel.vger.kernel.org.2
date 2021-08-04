Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1F3E0515
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhHDQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236453AbhHDQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628092851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEsjrzEf989GiFesEbeonJ3m9TGKEwxRikvJxw0JX+4=;
        b=hHBwPjVnW4zFHjE5ud/FcUb8N3ZC0avvfDnrSDcPlwCdEb5WmoRWXighMsvCY/fhK1/Dbg
        mBhEbeuZ/5Vc4qvvvQhj0T9ZHBU09zauhgcv0UEne9x7dVu7dS97PIj4wWCSniBuD8OKtY
        AAyiHDvN75aiItuBQ+Uv0Jpl4W/r6Lc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-QUmCwvq1PfKhTCq7SZ1haA-1; Wed, 04 Aug 2021 12:00:50 -0400
X-MC-Unique: QUmCwvq1PfKhTCq7SZ1haA-1
Received: by mail-qt1-f198.google.com with SMTP id k18-20020ac847520000b029028bf7425a59so1111039qtp.22
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 09:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kEsjrzEf989GiFesEbeonJ3m9TGKEwxRikvJxw0JX+4=;
        b=pcFRSeuLk/vQO/PNtKzitlH4kT1malZO9oR0pg4mWeuPybm4rX3ENfF1/HuX5daT8G
         RQLzuaf9NWQiAF6ZzLMZtQ+6KeHUH5FEH58MU2nIQa8qBhQebFywlrEpjhr7+Eezvw18
         7WOAqRllnk5us5/OsNzmDhJihQlE1VAJCs948ESYjgytJtIVKFSu0z2Hs6cbQQCEQspK
         Bp3dL9LSr6uucTbO9aTqTprP0COvkyxIQRr9WNDlyGml1tgslyWZtpfEb+WbtBhex8DG
         3jZ5xT8reWKcHTXRLkDxsKFt6ru8R6MnHXaXaS2dIMKkLrkYdY6g+L6f249bskfCkJ0q
         kFIw==
X-Gm-Message-State: AOAM5331yqFXAsjrE3e6ffDtRtLRTrgrAjlL9ulVghcS8NyP4f5/MO53
        kpx38JwMJ4WQKDTcR2hOlEY2S/lVmzTK+2GDQyIGKvP+x+ej4SiecxTdkShqOqXybkwFb5F+LuC
        5T2kz9utOmfW7UZRfr4xGKUTD
X-Received: by 2002:a05:620a:3c8:: with SMTP id r8mr115982qkm.19.1628092850005;
        Wed, 04 Aug 2021 09:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1QX2uMiY0+tjFXi1oQjufonahM1RQ6aSelVwGVf8DR+eHT/HQ7Hgz4p3Zz9FvTypcufD6pQ==
X-Received: by 2002:a05:620a:3c8:: with SMTP id r8mr115953qkm.19.1628092849770;
        Wed, 04 Aug 2021 09:00:49 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j4sm1480452qkk.78.2021.08.04.09.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:00:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcg: Disable task obj_stock for PREEMPT_RT
To:     Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210803175519.22298-1-longman@redhat.com> <87h7g62jxm.ffs@tglx>
 <8953e099-356e-ee09-a701-f4c7f4cda487@redhat.com>
Message-ID: <ce048e8b-bd2d-7517-d8e0-f74be98b8dee@redhat.com>
Date:   Wed, 4 Aug 2021 12:00:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8953e099-356e-ee09-a701-f4c7f4cda487@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 9:40 PM, Waiman Long wrote:
> On 8/3/21 7:21 PM, Thomas Gleixner wrote:
>> To complete the analysis of drain_local_stock(). AFAICT that function
>> can only be called from task context. So what is the purpose of this
>> in_task() conditional there?
>>
>>     if (in_task())
>>            drain_obj_stock(&stock->task_obj);
> I haven't done a full analysis to see if it can be called from task 
> context only. Maybe in_task() check isn't needed, but having it there 
> provides the safety that it will still work in case it can be called 
> from interrupt context. 

After looking at possible call chains that can lead to 
drain_local_stock(), one call chain comes from the allocation of slab 
objects which I had previously determined to be callable from interrupt 
context. So it is prudent to add a in_task() check here.

Cheers,
Longman

