Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5731698E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhBJO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBJO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:57:59 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31579C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:57:18 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id y21so540577oot.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rc//zkKRClDt5zH5r+Udno2L8yLWhnHVbadMooTicEM=;
        b=nnCEMVPZTgvIA2h1f7nEDIwwK+e2vQKzOMvBfmi8fplX8TAKz17zhzQFKRj7hDgRtF
         4X7+a4GKRc80wevEOuT4zSDXzARaccynOJFmKMqsGI9V2Uie0gQAU28Eb2LjBpiPoMwX
         E5QcVGpAzsE5Ic9eM9yYTa0nXG4T6DR0bf4S5YwKqgIx0z6CEWnAmmspbBANIGOpJJLk
         NBw4H0wtG0By/EdWRzarHZCPHBf4tgWib0jBYcMdHOZJHccAOg2/cMSuTWnXGkaWo8jt
         50HdOfRml0+WZMYIhsYIHta+65IrcE0VNHIV8wSnX7jdRLXy9vOcN/PTq2b0qKPbv3VQ
         vpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rc//zkKRClDt5zH5r+Udno2L8yLWhnHVbadMooTicEM=;
        b=US1tdhLUZAlfn6i5pIqaTfFNlWQrwWsrTMZzjJRSVOE1EUUUtE/LDxA7IoAx8+5Per
         nwP3Iq95+GJZlphHWZbJsiO5KJCtR6iFPfsp1BJU/aca2j3olcL75Ppg4qKN3L1oivV0
         Kp/OsO5yMBvFM7BM6Jei46P2Oh/u3iQ4fTiQnjrlkqNFDVeMDZhTWOptCxBym13iUkf0
         e7qpCPlckYOPgbQA7CnA6AcCqPdmvQ5l0klcM2wxZjIygeAq0SEU7DuhrXPGCL7w44/H
         CryP56jIWgnfIo6J3fnCijGRgMzr7Ykg4LoVjBn3Z1WapPWA4wq8+oeelcZ5WAXTCHrA
         9YhQ==
X-Gm-Message-State: AOAM531F9u6EbOaKg8rJzbubkAjfhtz95cqLqdTQ5OQCUuhW8sCNnChH
        9/FfcLa5KseMBqrYpjDsPlI=
X-Google-Smtp-Source: ABdhPJwi2Q8iByjLrwNk8h+qjY5IsOpP0lKr+2zQSqXGeD56Kp3FpQgA9eFrI+U9U7uUTdrryJk0Gw==
X-Received: by 2002:a4a:c29a:: with SMTP id b26mr2312135ooq.53.1612969037660;
        Wed, 10 Feb 2021 06:57:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o98sm421084ota.0.2021.02.10.06.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 06:57:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 1/8] mm: Cleanup faultaround and finish_fault()
 codepaths
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
References: <20210114175934.13070-1-will@kernel.org>
 <20210114175934.13070-2-will@kernel.org>
 <20210209202449.GA104837@roeck-us.net>
 <20210210114448.GA28682@willie-the-truck>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2ed7aff4-3c07-364f-838b-7342625b12a1@roeck-us.net>
Date:   Wed, 10 Feb 2021 06:57:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210114448.GA28682@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 3:44 AM, Will Deacon wrote:
> On Tue, Feb 09, 2021 at 12:24:49PM -0800, Guenter Roeck wrote:
>> On Thu, Jan 14, 2021 at 05:59:27PM +0000, Will Deacon wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>> alloc_set_pte() has two users with different requirements: in the
>>> faultaround code, it called from an atomic context and PTE page table
>>> has to be preallocated. finish_fault() can sleep and allocate page table
>>> as needed.
>>>
>>> PTL locking rules are also strange, hard to follow and overkill for
>>> finish_fault().
>>>
>>> Let's untangle the mess. alloc_set_pte() has gone now. All locking is
>>> explicit.
>>>
>>> The price is some code duplication to handle huge pages in faultaround
>>> path, but it should be fine, having overall improvement in readability.
>>>
>>> Link: https://lore.kernel.org/r/20201229132819.najtavneutnf7ajp@box
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> [will: s/from from/from/ in comment; spotted by willy]
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> ---
>>>  fs/xfs/xfs_file.c       |   6 +-
>>>  include/linux/mm.h      |  12 ++-
>>>  include/linux/pgtable.h |  11 +++
>>>  mm/filemap.c            | 177 ++++++++++++++++++++++++++---------
>>>  mm/memory.c             | 199 ++++++++++++----------------------------
>>>  5 files changed, 213 insertions(+), 192 deletions(-)
>>>
>>
>> When building microblaze:mmu_defconfig:
>>
>> mm/filemap.c: In function 'filemap_map_pages':
>> mm/filemap.c:3153:3: error: implicit declaration of function 'update_mmu_cache'; did you mean 'update_mmu_tlb'?
>>
>> Bisect log attached.
> 
> Looks like a missing include.
> 
Indeed.

> Will
> 
> --->8
> 
>>From 076f93117c067d5b6caab4773c6d6da130859cc4 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Wed, 10 Feb 2021 11:15:11 +0000
> Subject: [PATCH] mm: filemap: Fix microblaze build failure with
>  'mmu_defconfig'
> 
> Commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault()
> codepaths") added a call to 'update_mmu_cache()' in mm/filemap.c, which
> breaks the build for microblaze:
> 
>   | mm/filemap.c: In function 'filemap_map_pages':
>   | mm/filemap.c:3153:3: error: implicit declaration of function 'update_mmu_cache'; did you mean 'update_mmu_tlb'?
> 
> Include asm/tlbflush.h in mm/filemap.c to make sure that the function
> (or indeed, macro) is available.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/r/20210209202449.GA104837@roeck-us.net
> Signed-off-by: Will Deacon <will@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  mm/filemap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index fb7a8d9b5603..2ca13227747b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -43,6 +43,7 @@
>  #include <linux/ramfs.h>
>  #include <linux/page_idle.h>
>  #include <asm/pgalloc.h>
> +#include <asm/tlbflush.h>
>  #include "internal.h"
>  
>  #define CREATE_TRACE_POINTS
> 

