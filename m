Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4453D17F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhGUTh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGUTh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:37:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5357C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:18:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c12so3481397wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eaihz9yk/xIXyCpJhUj9DbEhmhohmopa6ht/rV/hojE=;
        b=bz2sjsPbm+Cmk5hqFS7XQjwhpZmvkxPv0JCBTscEr4LVqdlZumEouFJ3KjhkdUTMRd
         FY8rzzdPH38xQwmCHreRPkc3idSnSfzVVoo5lT0vLNAeh77oY3RR/wPODEuEUOdsPEal
         zGMiN+pX5Wpup2SRScWt5FK8bZXk04AgqfXdMQ4kZsykTHIVdKyOqvILk1VzWSsk4dii
         MY8coDRHS3yOqQBYVZcBZJhqbfGAuw+w5tqHzRKrAGnyit9M3/HfmQGVyj/21puUtLgJ
         cjTP/6OG76YxHqCd5iLLpw8+gcBFOgNu3NpDtPryU+LLIMxH7xK1WIBpeFFnRBVl/G+P
         F4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eaihz9yk/xIXyCpJhUj9DbEhmhohmopa6ht/rV/hojE=;
        b=s85y5ZS5TX+xs38u/dkLhqaISUjQjf7sKtpLxCMFq8xLBvZUh1kyH/gPrm/dXLNSSo
         PbyGodYfX4K2cmabnEKEd5vhJ5gnftAhGrw69IKYiQ2EopEmx2nzQ+jYdn/FvvXJxH0m
         zQHGNfEvVH7TfBHOJ7GJgltWuXbI2/2Yl2238f3jpIDkw/LBHUubT0bTkTPGL1Np/xB2
         cSAMaCD03r00v9gs4/eyTApKcy/2rvReGxtW9O66h1nmpYJddkgeBNqEYt4AnXuTVAaW
         vOUP+NhtHcTlvFqqNv6UTM+AO8qmpdbKo8ztu42A5MmflT3cp2XZIhHswmtEm97+HWjy
         /CRQ==
X-Gm-Message-State: AOAM530OesGh9cs3+KnICQZywuHKXCx1EWC90cevPSl0NNcZjjtRzG26
        PTVzvxkwsmcN4nEVCs4s0jc=
X-Google-Smtp-Source: ABdhPJyLgdF2CFy7WeSPj87r0Vtx6jKQCPotap0PKA1yvC0GYtGjUjZ/vuTwuIsj5BbrCuJFM7+NoA==
X-Received: by 2002:a5d:5589:: with SMTP id i9mr34547422wrv.8.1626898712587;
        Wed, 21 Jul 2021 13:18:32 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id n5sm21074723wrp.80.2021.07.21.13.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:18:32 -0700 (PDT)
Subject: Re: [PATCH v2] mm/mremap: Don't account pages in vma_to_resize()
To:     Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Will Deacon <will@kernel.org>
References: <20210721131320.522061-1-dima@arista.com>
 <77e28552-7a13-0981-f921-cd027cb73525@gmail.com>
 <20210721130551.bbdeae56ca3ec2d0f28b0bac@linux-foundation.org>
 <48ba72b8-3da2-e438-6148-5ec22172d475@arista.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <59c2146d-210a-bbf9-0f2f-36e1e79688e7@gmail.com>
Date:   Wed, 21 Jul 2021 21:18:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <48ba72b8-3da2-e438-6148-5ec22172d475@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 9:08 PM, Dmitry Safonov wrote:
> On 7/21/21 9:05 PM, Andrew Morton wrote:
>> On Wed, 21 Jul 2021 14:21:54 +0100 Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>>
>>>> Let's not do this.
>>>> Account memory in mremap() fast-path for growing VMAs or in move_vma()
>>>> for actually moving things. The same simpler way as it's done by
>>>> vm_stat_account(), but with a difference to call
>>>> security_vm_enough_memory_mm() before copying/adjusting VMA.
>>>>
>>>> Originally noticed by Chen Wandun:
>>>> https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com
>>>
>>> The patch by Chen Wandun still makes sense with this v2.
>>> Heh :-)
>>
>> Should
>> https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com
>> still be applied then?  Did you ack it?
>>
> 
> Yes, please keep that patch with
> Acked-by: Dmitry Safonov <dima@arista.com>
> 
> This one comes on the top to correct accounting for MREMAP_DONTUNMAP.

Please, also wait for reviews for this one.
I think it's correct and simplifies the complex code, but now I look
into the code again, I see that:
:	/*
:	 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
:	 * in the process.
:	 */
:	if (flags & MREMAP_DONTUNMAP &&
:			(!(flags & MREMAP_MAYMOVE) || old_len != new_len))
:		return ret;

So, this part can be dropped:
> Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")

But I think the patch still makes sense.

Brian, can I have your review on it?

Thanks,
          Dmitry
