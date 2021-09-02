Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A87D3FE98D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbhIBGzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 02:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhIBGzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 02:55:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60AC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 23:54:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e7so572373plh.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 23:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Gjsbot1Ioib4U7AgvUadDJqCoxn0LGYzazPWjhiFe6A=;
        b=E3ouvM0ynVSTIUIqv7WlfcuLv7HFqUAlSQpDXOp9Hxbpq8gdlW9eTQw9XctxC0StvE
         kVzh3iVDyHB0lHCqASPPabxBWhTOXi7Dp7Qc2O/RHUfsetZzhMXdr1gedzUqbxfHwX6j
         LLgWQF90UCcPawQ115M+8DzGAotfDwmPuQXPrpqU330j1lOxHGXCWbSefY0zZgL8gLeA
         mf7kL7nm0rU4b6pfim3HmjCiZRWAISzh0KRyySgKjU2ySFlkBphYlPeCKDPp6v/xDtDV
         gPS/L48Qnr+bFH38DKNYPDBjl63nDmXBqkyeSqm0gESKa4YIZ8ggOiJbNLJC4REoEGET
         LT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Gjsbot1Ioib4U7AgvUadDJqCoxn0LGYzazPWjhiFe6A=;
        b=gky/CnvX5z0cVBZulN+DAiw0cqqfzfZH177BLregU/5Swy6O4Xmcd04cK4Zi5FW21V
         ylFtVi+KeIAeb2Ma1VoIxXgJnMjeM/DLlgUqyReTgnWbvBjpPlU8VltlfaTYttNNO6eG
         sPi9tIUoBKaivIpjt+wXczfXHyJNsTgSxIvYLCVvOt1gnYq9O/tUe0YQ/16EMrEWGvfx
         qb5cfBobKQ09DRtpzpFyVIVYJyXNrGXb3ipmJO+BtO9f489/Fqdl2vILS0UbNdSNzhsT
         x5hHk6rfYm4Iv24o7+cGV3+3Q0LNBeSrZiAoAL3/lokN0KltyQVuZhb0Ndr8SUx75Rlq
         I7Sg==
X-Gm-Message-State: AOAM532cke31z35svakpm6a922qEmoxho2Mx559Fb1qRLSp4V5X1bKRd
        8vY6tHOtGMruy8BCcTw1ZRGf9Q==
X-Google-Smtp-Source: ABdhPJw/aXZFpocogFeOr+q7ffvqB6cKQ+CRK4Ar6aPpZ/QDffD0XV0dhsYUFP+Ciy6Ir9IubMEEEw==
X-Received: by 2002:a17:90a:3f83:: with SMTP id m3mr2106262pjc.46.1630565644875;
        Wed, 01 Sep 2021 23:54:04 -0700 (PDT)
Received: from [10.254.207.253] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id p34sm1354810pgb.14.2021.09.01.23.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 23:54:04 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
 <20210901153247.GJ1721383@nvidia.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <47c7d6fd-056b-0e40-ae30-e2f099a97a95@bytedance.com>
Date:   Thu, 2 Sep 2021 14:53:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901153247.GJ1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/1 PM11:32, Jason Gunthorpe wrote:
> 
>>> Also, I don't really understand how this scheme works with
>>> get_user_pages_fast.
>>
>> With the RCU change it in #8 it should work just fine, because RCU
>> synchronize has to wait either until all other CPUs have left the RCU read
>> section, or re-enabled interrupts.
> 
> So at this point in the series fast gup is broken, that does mean the
> series presentation really needs to be reworked. The better
> presentation is to add the API changes, with a
> no-functional-difference implementation, push the new API in well
> split patches to all the consumption sites, then change the API to
> have the new semantics.
> 
> RCU and refcount to free the page levels seems like a reasonable
> approach, but I have to say I haven't thought it through fully - are
> all the contexts that have the pte deref safe to do call_rcu?

See Documentation/RCU/rcubarrier.rst:

"Since call_rcu() never blocks, this code can safely be used from within
IRQ context."

So I think call_rcu() can be safely run in any context.

Thinks,
Qi

> 
> Jason
> 
> 
