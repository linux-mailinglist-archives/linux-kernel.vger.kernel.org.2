Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D884E34624C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhCWPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:05:46 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:36388 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhCWPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:05:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 8ADF93FBD2;
        Tue, 23 Mar 2021 16:05:15 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=FHZiIXFT;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bl9FkwmAFN1D; Tue, 23 Mar 2021 16:05:14 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id A80863F84E;
        Tue, 23 Mar 2021 16:05:11 +0100 (CET)
Received: from [192.168.0.209] (unknown [192.198.151.43])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E31823602AF;
        Tue, 23 Mar 2021 16:05:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616511911; bh=ERRcOLv79yXvN5bQmSpWkBFFjvHOVmKGZWh48H3jXZg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FHZiIXFTZJTov+7Y6hz8XbGGOxxnA+/UU9rC1aJzGqUPG4RYqXwljopR6NAfvmX3B
         RiGxPJdgALXFMrqDKNaoxOdiQ5zhUMmji651p/Z0wqlmVOUtjqL+8HNcZGQvtU+1WP
         Rh5WLj/6apbPakGeqElDVHyhNnfY1yMSz79lQtEY=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <20210323135217.GD2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <ea011a3d-d9f8-77b7-9624-f2ae4777f019@shipmail.org>
Date:   Tue, 23 Mar 2021 16:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323135217.GD2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/21 2:52 PM, Jason Gunthorpe wrote:
> On Sun, Mar 21, 2021 at 07:45:28PM +0100, Thomas Hellström (Intel) wrote:
>> diff --git a/mm/gup.c b/mm/gup.c
>> index e40579624f10..1b6a127f0bdd 100644
>> +++ b/mm/gup.c
>> @@ -1993,6 +1993,17 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
>>   }
>>   
>>   #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>> +/*
>> + * If we can't determine whether or not a pte is special, then fail immediately
>> + * for ptes. Note, we can still pin HugeTLB as it is guaranteed not to be
>> + * special. For THP, special huge entries are indicated by xxx_devmap()
>> + * returning true, but a corresponding call to get_dev_pagemap() will
>> + * return NULL.
>> + *
>> + * For a futex to be placed on a THP tail page, get_futex_key requires a
>> + * get_user_pages_fast_only implementation that can pin pages. Thus it's still
>> + * useful to have gup_huge_pmd even if we can't operate on ptes.
>> + */
> Why move this comment? I think it was correct where it was

Yes, you're right. I misread it to refer to the actual code in the 
gup_pte_range function rather than to the empty version. I'll move it back.

/Thomas


>
> Jason
