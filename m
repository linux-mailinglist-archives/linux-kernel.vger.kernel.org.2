Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89563EDDFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhHPTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhHPTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629142810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91yx0t94d7tEDZdUyFtrhsnq9rVN5DLyd0gLh3Xecp4=;
        b=c+okuwri3ovdAPYDup6dDOU1aA1ATwsjjjXEd0QgWq1S9oyPk7H1hZnO5qwfNdrqHQEYUF
        2MwayFXJRvKFpUXWxzwL2IZMkSsPh2gchCkaY4LeZWYohYj02qa8S7lhPewmdtbQIdYU7D
        D2FTN0VqmY9YofX/wpTfW1XHleiSqFQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-jIVIuhcMP-OAaiezt1_nYQ-1; Mon, 16 Aug 2021 15:40:08 -0400
X-MC-Unique: jIVIuhcMP-OAaiezt1_nYQ-1
Received: by mail-wm1-f71.google.com with SMTP id y23-20020a7bcd97000000b002e6e4a2a332so778927wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=91yx0t94d7tEDZdUyFtrhsnq9rVN5DLyd0gLh3Xecp4=;
        b=mUEJxREM/aEfnmBlDEUmxUOmhkXpOHA7+K3644oyWpdOt9NBq1PH9U6NZneSD6zdNW
         AGMQbgxyF/fm+Z9hGrzMuYdrwvmomQb6kODmH1T6QmLDh0zD5b9Yd8jlWmib8bgpJerf
         hhob1ijaduggxieDnFvNjBgYVOAKQAcAYfb2lugxXhl4LzE6uOwB8+++jMgIK0W8Duzi
         jqUxOClzVxumDClgDrF8SO5cC1+FNWT4ndX7I9Rn2T7IgIWss9gMkBoY9QrBe4q3L1gB
         h8AtZwMrdSJt3iG0f4zhjAtcriotWN0gHT8vBCGisr6P4kbRW3L6Y6AEZzP8oHCeoBTP
         e/Dg==
X-Gm-Message-State: AOAM533+aIQNpAEXZpdtMQhXl/lkOut8m3rcXMKANXXHwl+HoBFDbv7+
        vr/ER8KuJoDeOhdMx5vP0QcVjGcItnsCpDHEjRmtQ3cQ5Ev05SWuTS3A+DWisH3RNwwq4AARiAk
        5xIkH07GDAwkNTFxMdTz+o+uNioODVWYRi99QtfDvOgJtoAn+airR1oLJ6jCAvyAYbvfrI1VG
X-Received: by 2002:a5d:6909:: with SMTP id t9mr137431wru.44.1629142807627;
        Mon, 16 Aug 2021 12:40:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAWv9dz1w7R7w0ECBb3TR/VPVl/uEUI6KrJEtALEsjtJiIswbbD/SZQNvpFIPR6rZPwB38xw==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr137410wru.44.1629142807341;
        Mon, 16 Aug 2021 12:40:07 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id l9sm112312wrt.95.2021.08.16.12.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 12:40:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
To:     Yang Shi <shy828301@gmail.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        tdmackey@twitter.com, Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210816180909.3603-1-shy828301@gmail.com>
 <08a5ad43-7922-8cf8-31ed-4f6e0c346516@redhat.com>
 <CAHbLzkoyYwvGPaoxPKU1dG_riPPqvP+L5QUz38AVvXbD1y3c8g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <87385c20-78c1-ff04-7e91-f10253853994@redhat.com>
Date:   Mon, 16 Aug 2021 21:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkoyYwvGPaoxPKU1dG_riPPqvP+L5QUz38AVvXbD1y3c8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 21:37, Yang Shi wrote:
> On Mon, Aug 16, 2021 at 12:15 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 16.08.21 20:09, Yang Shi wrote:
>>> In the current implementation of soft offline, if non-LRU page is met,
>>> all the slab caches will be dropped to free the page then offline.  But
>>> if the page is not slab page all the effort is wasted in vain.  Even
>>> though it is a slab page, it is not guaranteed the page could be freed
>>> at all.
>>
>> ... but there is a chance it could be and the current behavior is
>> actually helpful in some setups.
> 
> I don't disagree it is kind of helpful for some cases, but the
> question is how likely it is helpful and if the cost is worth it or
> not. For non-slab page (of course, non-lru too), dropping slab doesn't
> make any sense. Even though it is slab page, it must be a reclaimable
> slab. Even though it is a reclaimable slab, dropping slab can't
> guarantee all objects on the same page are dropped.
> 
> IMHO the likelihood is not worth the cost and side effect, for example
> the unsuable system.
> 
>>
>> [...]
>>
>>> The lockup made the machine is quite unusable.  And it also made the
>>> most workingset gone, the reclaimabled slab caches were reduced from 12G
>>> to 300MB, the page caches were decreased from 17G to 4G.
>>>
>>> But the most disappointing thing is all the effort doesn't make the page
>>> offline, it just returns:
>>>
>>> soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
>>>
>>
>> In your example, yes. I had a look at the introducing commit:
>> facb6011f399 ("HWPOISON: Add soft page offline support")
>>
>> "
>>       When the page is not free or LRU we try to free pages
>>       from slab and other caches. The slab freeing is currently
>>       quite dumb and does not try to focus on the specific slab
>>       cache which might own the page. This could be potentially
>>       improved later.
>> "
>>
>> I wonder, if instead of removing it altogether, we could actually
>> improve it as envisioned.
>>
>> To be precise, for alloc_contig_range() it would also make sense to be
>> able to shrink only in a specific physical memory range; this here seems
>> to be a similar thing. (actually, alloc_contig_range(), actual memory
>> offlining and hw poisoning/soft-offlining have a lot in common)
>>
>> Unfortunately, the last time I took a brief look at teaching shrinkers
>> to be range-aware, it turned out to be a lot of work ... so maybe this
>> is really a long term goal to be mitigated in the meantime by disabling
>> it, if it turns out to be more of a problem than actually help.
> 
> Do you mean physical page range? Yes, it would need a lot of work.
> TBH, I don't think it is quite feasible for the time being.
> 
> The problem is slabs for shrinker are managed by objects rather than
> pages. For example, dentry and inode objects (the most consumed
> reclaimable slabs) are linked to lru, and shrinkers traverse the lru
> to shrink the objects. The objects in a certain range can not be
> guaranteed in the same range of physical pages.

Right, essentially you would have to look at each individual object and 
test if it falls into the physical range of interest. Not that it can't 
be done I guess, but it screams to be a lot of work.

-- 
Thanks,

David / dhildenb

