Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9966F3058E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhA0KzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:55:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:43724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235827AbhA0KwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:52:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EA62AD87;
        Wed, 27 Jan 2021 10:51:34 +0000 (UTC)
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-4-yuzhao@google.com>
 <85b3e8f2-5982-3329-c20d-cf062b8da71e@suse.cz> <YBCK9OcUCbbgsFaj@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <725432e0-3a6e-e83b-c478-ffda028ff40e@suse.cz>
Date:   Wed, 27 Jan 2021 11:51:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBCK9OcUCbbgsFaj@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 10:34 PM, Yu Zhao wrote:
> On Tue, Jan 26, 2021 at 08:13:11PM +0100, Vlastimil Babka wrote:
>> On 1/22/21 11:05 PM, Yu Zhao wrote:
>> > The "enum lru_list" parameter to add_page_to_lru_list() and
>> > add_page_to_lru_list_tail() is redundant in the sense that it can
>> > be extracted from the "struct page" parameter by page_lru().
>> 
>> Okay, however, it means repeated extraction of a value that we already knew. The
>> result of compilation is rather sad. This is bloat-o-meter on mm/built-in.a
>> (without CONFIG_DEBUG_VM, btw) between patch 2 and 5:
> 
> Thanks for noticing this, Vlastimil. Should I drop the rest of the
> series except the first patch?

I didn't check how 6-10 look (and if they are still applicable without 3-5),
this was just between 2 and 5.

