Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A134CFD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhC2MKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:10:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:48174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231867AbhC2MKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:10:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC097B46E;
        Mon, 29 Mar 2021 12:10:02 +0000 (UTC)
To:     David Hildenbrand <david@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>
References: <20210326112650.307890-1-slyfox@gentoo.org>
 <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
Message-ID: <469d6417-64a5-fe99-1214-bb0351833b74@suse.cz>
Date:   Mon, 29 Mar 2021 14:10:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 2:48 PM, David Hildenbrand wrote:
> On 26.03.21 12:26, Sergei Trofimovich wrote:
>> init_on_free=1 does not guarantee that free pages contain only zero bytes.
>>
>> Some examples:
>> 1. page_poison=on takes presedence over init_on_alloc=1 / ini_on_free=1
> 
> s/ini_on_free/init_on_free/
> 
>> 2. free_pages_prepare() always poisons pages:
>>
>>         if (want_init_on_free())
>>             kernel_init_free_pages(page, 1 << order);
>>         kernel_poison_pages(page, 1 << order
> 
> In next/master, it's the other way around already.

And that should be OK as the order should not matter, as long as they are indeed
exclusive. They should be after Sergei's v2 fix.
As long as kasan_free_nondeferred_pages() which follows doesn't do anything
unexpected to poisoned pages (I haven't check).


> commit 855a9c4018f3219db8be7e4b9a65ab22aebfde82
> Author: Andrey Konovalov <andreyknvl@gmail.com>
> Date:   Thu Mar 18 17:01:40 2021 +1100
> 
>     kasan, mm: integrate page_alloc init with HW_TAGS

But the mmotm patch/-next commit also changes post_alloc_hook()

Before the patch it was:
kernel_unpoison_pages(page, 1 << order);
...
kernel_init_free_pages(page, 1 << order);

Now it is (for !kasan_has_integrated_init()):

kernel_init_free_pages(page, 1 << order);

kernel_unpoison_pages(page, 1 << order);

That has to be wrong, because we init the page with zeroes and then call
kernel_unpoison_pages() which checks for the 0xaa pattern. Andrey?

>>
>> I observed use of poisoned pages as the crash on ia64 booted with
>> init_on_free=1 init_on_alloc=1 (CONFIG_PAGE_POISONING=y config).
>> There pmd page contained 0xaaaaaaaa poison pages and led to early crash.
>>
>> The change drops the assumption that init_on_free=1 guarantees free
>> pages to contain zeros.
>>
>> Alternative would be to make interaction between runtime poisoning and
>> sanitizing options and build-time debug flags like CONFIG_PAGE_POISONING
>> more coherent. I took the simpler path.
>>
> 
> I thought latest work be Vlastimil tried to tackle that. To me, it feels like
> page_poison=on  and init_on_free=1 should bail out and disable one of both
> things. Having both at the same time doesn't sound helpful.
> 
>> Tested the fix on rx3600.
> 
> Fixes: ?
> 
> 

