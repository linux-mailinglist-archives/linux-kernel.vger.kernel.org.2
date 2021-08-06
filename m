Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91B23E2E34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhHFQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhHFQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628266605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xHSpnJtP+yised83clbZYxtS0H9GH4PHvNYgDaicDE=;
        b=PTqcLR89Ab9Oh+HClyPJNThCa2xYoZQx/qnhQybHGfnZ2JB/B7VpbLaGmdSv3R/EDUZBmI
        3FHrpPvft11j8eaoFERfcVZYG00fR66V/8SrJg9TlWnpKaL94S3gxKzqx9W3hpY3Dw/YR+
        GRHZieoDeRMaizkdr0Cq2fzT/zePUug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-rcc8obocNG-gR4NrMfelMA-1; Fri, 06 Aug 2021 12:16:44 -0400
X-MC-Unique: rcc8obocNG-gR4NrMfelMA-1
Received: by mail-wm1-f69.google.com with SMTP id i6-20020a05600c3546b029025b0d825fd2so2562659wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 09:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7xHSpnJtP+yised83clbZYxtS0H9GH4PHvNYgDaicDE=;
        b=tilsEMycbciW+OX+YqXqAJyIfjxH9MoUD3tnd19KoEGcB5EWGjMCYuOV1s9RmFc57E
         t67QeoDOpc5Syh84atFHxS1ER9EFVTVxrSB7qFPvJyDvGtO+4xwUMGHdWVnOeSQnzNEq
         QaJMaQhMMSLtoos0eEIL7TmCALNSTga6IgXvAaA3AwlDya2X/5DNd0xoJEQgJncdYHvO
         0LiRwpxWv06XR/nRZn9mk6tKg8/H7K2BDeHmMv9jFYHvhfKpmlBoDMqTH+5bkLO1e5Qu
         4K7kYzoXthqGxm9sEdAVyGYDoui74gPlBvx3SGSImHQ2n65cCwIlo9iteq9RQ3KBqhSs
         tVZw==
X-Gm-Message-State: AOAM533t8AlI2Y2+Niu5gjb9uZt+bOqXSFcVKuG7FMgKDz5ewe4w7vvc
        kKvr3u80Hr+RND7PpdTxWsGQ3eQER52kHojTu38cxQlTK7oREjyfGCRgaddlVB3gWmBi+aYCWVB
        x+vYpv7Hbo37CiRENnPlMhbjF
X-Received: by 2002:a5d:6991:: with SMTP id g17mr11763538wru.253.1628266602887;
        Fri, 06 Aug 2021 09:16:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUzbz49pY0WWOS9RdZpe8ZwJnExFSL1NBYRZ86E2lQxy38Fgqx6EbXawHcNewWTxh8/qjmGg==
X-Received: by 2002:a5d:6991:: with SMTP id g17mr11763520wru.253.1628266602638;
        Fri, 06 Aug 2021 09:16:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id z3sm12634740wmf.6.2021.08.06.09.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 09:16:42 -0700 (PDT)
To:     Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <40982106-0eee-4e62-7ce0-c4787b0afac4@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time
 parameter.
Message-ID: <72b317e5-c78a-f0bc-fe69-f82261ec252e@redhat.com>
Date:   Fri, 6 Aug 2021 18:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <40982106-0eee-4e62-7ce0-c4787b0afac4@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.21 17:36, Vlastimil Babka wrote:
> On 8/5/21 9:02 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
> 
>> Patch 3 restores the pfn_valid_within() check when buddy allocator can merge
>> pages across memory sections. The check was removed when ARM64 gets rid of holes
>> in zones, but holes can appear in zones again after this patchset.
> 
> To me that's most unwelcome resurrection. I kinda missed it was going away and
> now I can't even rejoice? I assume the systems that will be bumping max_order
> have a lot of memory. Are they going to have many holes? What if we just
> sacrificed the memory that would have a hole and don't add it to buddy at all?

I think the old implementation was just horrible and the description we 
have here still suffers from that old crap: "but holes can appear in 
zones again". No, it's not related to holes in zones at all. We can have 
MAX_ORDER -1 pages that are partially a hole.

And to be precise, "hole" here means "there is no memmap" and not "there 
is a hole but it has a valid memmap".

But IIRC, we now have under SPARSEMEM always a complete memmap for a 
complete memory sections (when talking about system RAM, ZONE_DEVICE is 
different but we don't really care for now I think).

So instead of introducing what we had before, I think we should look 
into something that doesn't confuse each person that stumbles over it 
out there. What does pfn_valid_within() even mean in the new context? 
pfn_valid() is most probably no longer what we really want, as we're 
dealing with multiple sections that might be online or offline; in the 
old world, this was different, as a MAX_ORDER -1 page was completely 
contained in a memory section that was either online or offline.

I'd imagine something that expresses something different in the context 
of sparsemem:

"Some page orders, such as MAX_ORDER -1, might span multiple memory 
sections. Each memory section has a completely valid memmap if online. 
Memory sections might either be completely online or completely offline. 
pfn_to_online_page() might succeed on one part of a MAX_ORDER - 1 page, 
but not on another part. But it will certainly be consistent within one 
memory section."

Further, as we know that MAX_ORDER -1 and memory sections are a power of 
two, we can actually do a binary search to identify boundaries, instead 
of having to check each and every page in the range.

Is what I describe the actual reason why we introduce pfn_valid_within() 
? (and might better introduce something new, with a better fitting name?)

-- 
Thanks,

David / dhildenb

