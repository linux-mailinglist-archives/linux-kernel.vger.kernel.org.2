Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448F5458B36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbhKVJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhKVJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637572753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6kIGMoi/UizS8RxyuA9y/8Vg2kuqpTeq7QsPmGlDpPI=;
        b=DN4FmgXDS/qJruSuEZ9V11wcQVWelHFkK6hkJFK3IOPLvpQiquKxI4rDVl8tInbcCkkxso
        V4N6EV/8hGgv8OW4tKz+rXqV1K1SeupB1vUiDQle1xl6B7eqbIJhDrL2zqMmkBFUsMIiqa
        8Z/+DrTq6vH1w71B8GSPolaeBjfvC5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-MjFAoGe4PTChWqtWANDIWA-1; Mon, 22 Nov 2021 04:19:11 -0500
X-MC-Unique: MjFAoGe4PTChWqtWANDIWA-1
Received: by mail-wm1-f69.google.com with SMTP id bg20-20020a05600c3c9400b0033a9300b44bso3356654wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=6kIGMoi/UizS8RxyuA9y/8Vg2kuqpTeq7QsPmGlDpPI=;
        b=zvx/zXmt5qAtgSlTrwqYaR0zDTFVzjNso4WNqDNdIJS73AlQi+GwYC25URztZ7TqIT
         HlAbrQHxvxQbsOBaL6pRDORx9IqvUNTOw5+pb/ZFkPgw5yHiXWV0y06v+tM2tPu7d/AX
         xAdE97W6WvtqJtj/eFJhzlZYrRgiMbY8snlan7O+NTzuqxzjUeoIzXVbt5WznqNW0Uml
         HdNc5zHxv/whIexzU3QeFqmwwbZePsc2DpY2dtKozBbLIcWlbLLI2crTKiNmJFFXqpNa
         mFHvRmirfu0DSJZbFVnV97tTk7L4tmgsev+iuCFzSCACwRiu35w/IYlPVNh2YaFJLZ6Y
         qFpg==
X-Gm-Message-State: AOAM532jmDvvMKVjfBFuq1rbkw3YhdOfwFqzoUstRSMZlLU81VJGeGch
        0k5Dzg/0HcDhFmLrZFtmgzXc5ovLTMqAczjW1uSvf5x0huziDjW/c6idsRNbXsDW2Ek3zU6zTZO
        O9kZ6wZ9AEYoXHyr+5461z0WX
X-Received: by 2002:adf:e682:: with SMTP id r2mr37379248wrm.281.1637572750427;
        Mon, 22 Nov 2021 01:19:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx52seET0Ug9wVWNIeAfQ3a0zvPtLtb9P2xYSntHccg2zBLkncoMO3OpWt9HvSfX6WUewxZYA==
X-Received: by 2002:adf:e682:: with SMTP id r2mr37379222wrm.281.1637572750237;
        Mon, 22 Nov 2021 01:19:10 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id az4sm21196566wmb.20.2021.11.22.01.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 01:19:09 -0800 (PST)
Message-ID: <861f98b5-9211-98c7-b4f7-fd71146aa64c@redhat.com>
Date:   Mon, 22 Nov 2021 10:19:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211120201230.920082-1-shakeelb@google.com>
 <YZsi+RFed3hX9T8w@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
In-Reply-To: <YZsi+RFed3hX9T8w@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.21 05:56, Matthew Wilcox wrote:
> On Sat, Nov 20, 2021 at 12:12:30PM -0800, Shakeel Butt wrote:
>> Many applications do sophisticated management of their heap memory for
>> better performance but with low cost. We have a bunch of such
>> applications running on our production and examples include caching and
>> data storage services. These applications keep their hot data on the
>> THPs for better performance and release the cold data through
>> MADV_DONTNEED to keep the memory cost low.
>>
>> The kernel defers the split and release of THPs until there is memory
>> pressure. This causes complicates the memory management of these
>> sophisticated applications which then needs to look into low level
>> kernel handling of THPs to better gauge their headroom for expansion. In
>> addition these applications are very latency sensitive and would prefer
>> to not face memory reclaim due to non-deterministic nature of reclaim.
>>
>> This patch let such applications not worry about the low level handling
>> of THPs in the kernel and splits the THPs synchronously on
>> MADV_DONTNEED.
> 
> I've been wondering about whether this is really the right strategy
> (and this goes wider than just this one, new case)
> 
> We chose to use a 2MB page here, based on whatever heuristics are
> currently in play.  Now userspace is telling us we were wrong and should
> have used smaller pages.

IIUC, not necessarily, unfortunately.

User space might be discarding the whole 2MB either via a single call
(MADV_DONTNEED a 2MB range as done by virtio-balloon with "free page
reporting" or by virtio-mem in QEMU). In that case, there is nothing to
migrate and we were not doing anything wrong.

But more extreme, user space might be discarding the whole THP in small
pieces shortly over time. This for example happens when a VM inflates
the memory balloon via virtio-balloon. All inflation requests are 4k,
resulting in a 4k MADV_DONTNEED calls. If we end up inflating a THP
range inside of the VM, mapping to a THP range inside the hypervisor,
we'll essentially free a THP in the hypervisor piece by piece using
individual MADV_DONTNEED calls -- this happens frequently. Something
similar can happen when de-fragmentation inside the VM "moves around"
inflated 4k pages piece by piece to essentially form a huge inflated
range -- this happens less frequently as of now. In both cases,
migration is counter-productive, as we're just about to free the whole
range either way.

(yes, there are ways to optimize, for example using hugepage ballooning
or merging MADV_DONTNEED calls in the hypervisor, but what I described
is what we currently implement in hypervisors like QEMU, because there
are corner cases for everything)

Long story short: it's hard to tell what will happen next based on a
single MADV_DONTNEED call. Page compaction, in comparison, doesn't care
and optimized the layout as it observes it.

-- 
Thanks,

David / dhildenb

