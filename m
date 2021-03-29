Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14E34D9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhC2WHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:07:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhC2WHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:07:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AA84B138;
        Mon, 29 Mar 2021 22:07:06 +0000 (UTC)
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210326112650.307890-1-slyfox@gentoo.org>
 <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
 <469d6417-64a5-fe99-1214-bb0351833b74@suse.cz>
 <CA+fCnZcZvBT97y3zEatnTvi+RBW5bCrQRim9uK6wobYQOdgNhg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a32ffcd0-136f-4cc6-341b-16926e3787bd@suse.cz>
Date:   Tue, 30 Mar 2021 00:07:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+fCnZcZvBT97y3zEatnTvi+RBW5bCrQRim9uK6wobYQOdgNhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 12:00 AM, Andrey Konovalov wrote:
> On Mon, Mar 29, 2021 at 2:10 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> > commit 855a9c4018f3219db8be7e4b9a65ab22aebfde82
>> > Author: Andrey Konovalov <andreyknvl@gmail.com>
>> > Date:   Thu Mar 18 17:01:40 2021 +1100
>> >
>> >     kasan, mm: integrate page_alloc init with HW_TAGS
>>
>> But the mmotm patch/-next commit also changes post_alloc_hook()
>>
>> Before the patch it was:
>> kernel_unpoison_pages(page, 1 << order);
>> ...
>> kernel_init_free_pages(page, 1 << order);
>>
>> Now it is (for !kasan_has_integrated_init()):
>>
>> kernel_init_free_pages(page, 1 << order);
>>
>> kernel_unpoison_pages(page, 1 << order);
>>
>> That has to be wrong, because we init the page with zeroes and then call
>> kernel_unpoison_pages() which checks for the 0xaa pattern. Andrey?
> 
> It's similar to free_pages_prepare(): kernel_unpoison_pages() and
> want_init_on_alloc() are exclusive, so the order shouldn't matter. Am
> I missing something?

Yeah, when the allocation has __GFP_ZERO, want_init_on_alloc() will return true
even with the static branches disabled.
