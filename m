Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A29307469
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhA1LG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:06:26 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:54069 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231173AbhA1LGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:06:17 -0500
X-Halon-ID: bac96e9c-6158-11eb-b73f-0050569116f7
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id bac96e9c-6158-11eb-b73f-0050569116f7;
        Thu, 28 Jan 2021 12:05:33 +0100 (CET)
Subject: Re: sparc32: boot fails with > 256 MB memory after switch to
 NO_BOOTMEM
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Hocko <mhocko@kernel.org>
References: <5adb7c41-ad71-b904-6b73-35aef4dfcafe@gaisler.com>
 <20210128093541.GC299309@linux.ibm.com>
From:   Andreas Larsson <andreas@gaisler.com>
Message-ID: <fd127ef4-7890-8274-7642-c8affcd5b384@gaisler.com>
Date:   Thu, 28 Jan 2021 12:05:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128093541.GC299309@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 10:35, Mike Rapoport wrote:
> On Wed, Jan 27, 2021 at 04:03:00PM +0100, Andreas Larsson wrote:
>>
>>
>> Commit cca079ef8ac29a7c02192d2bad2ffe4c0c5ffdd0 makes sparc32 use
>> memblocks instead of the previous bootmem solution. Unfortunately, due
>> to this:
>>
>> #define PAGE_OFFSET  0xf0000000
>> #define __va(x)	     ((void *)((unsigned long) (x) - phys_base +
>> PAGE_OFFSET))
>> #define phys_to_virt __va
>>
>> it makes physical addresses >= 0x10000000 past phys_base wrap around the
>> 32-bit memory space when converted to virtual addresses, e.g. in
>> memblock_alloc_try_nid. Physical memory exactly 0x10000000 past
>> phys_base is returned as an unintended NULL pointer, leading to a panic
>> in my boot when percpu memory allocation fails due to it.
>>
>> Unfortunately I have had 256 MB memory or less in a lot of my testing,
>> so this old one has slipped by me.
>>
>> Does anyone has any ideas or pointers on how to resolve this?
> 
> I think the simplest way to work around this is to limit early allocations
> to 256M with addition of
> 
> 	memblock_set_current_limit(SZ_256M);
>   
> somewhere at setup_arch().
> 
> The page allocator will anyway see the entire memory, so I cannot think of
> any downside here.

That works like a charm! Thank you! I'll submit a patch.

-- 
Andreas Larsson
Cobham Gaisler


