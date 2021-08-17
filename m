Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CCC3EE741
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhHQHbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234402AbhHQHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629185460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAHJ81awhh7LCsucI9D8qmpLIxkM4KynK6ce9xcolyU=;
        b=E/HlX+Xoxxc9kLcEyZh92EPDD3W9d1X1d/pVw61KAEjBcZzfpnapMpN3k8PM1tcrPi8w7U
        ODs5jgZiSpLFIyhFWkXK53MQ5PfbdnfyETSKNr0x6346BW5AmzS37anvzqJQXEj38nvqo1
        SadCt7Dz19s+IKJrGQ2zOgKiykDjlGg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-Pjb7vTgPNyaoIIellZEKUg-1; Tue, 17 Aug 2021 03:30:58 -0400
X-MC-Unique: Pjb7vTgPNyaoIIellZEKUg-1
Received: by mail-wr1-f72.google.com with SMTP id q4-20020a05600000c400b00156d811312aso698256wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 00:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kAHJ81awhh7LCsucI9D8qmpLIxkM4KynK6ce9xcolyU=;
        b=XR3DYxqsKGiNLLjZS6RfiQKZCklcA2ZdoTil3Kd9paFEb37dJcIgF8eQuT0vNO875L
         j5N1yRPFUc02aJzN05gWSI1xddshY5PtPDzmEbqIc6mrrqiDxXL3z7KEnk4tejwNUseu
         S/BWSmQ8p8dcxszMS6JYLnhIe8+dFTc4pHP81s4seoYrS3QVOzQMGdDXKzysUSVQcESz
         3QhajM1/SVeJXL3duDOzz2qRvJTxmLtow3RByxgGNTMp49QPpOA6zJmNWOpKWky28R2F
         WisZqbPGGgYMf2iK2i3ZecfhUKucreNpGeQBF3bb6p9KDSdFHs9MXF9KGpJJnNh+jDxe
         O5yQ==
X-Gm-Message-State: AOAM531U97hrczcu5T2FFhJFq5r2XDCU+WBT0PuhUHbsPHzdAbJUeSsc
        aztHz3szteOF8w89CFLPuFARr1t/yu+JeFlqqZAlYOLeq97071i4c4X2jPz/Gl0ITYnt4q8u0TV
        PtXmNHVOZ+JqSAuij1cw0Oquy
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr2244500wrr.49.1629185457716;
        Tue, 17 Aug 2021 00:30:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaPlIsvK0QlsK/muXi57ibff5RTmiAMaf6agHifKdvLCC67IY4iyW+vBx7j2mloFg59RrNSw==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr2244473wrr.49.1629185457541;
        Tue, 17 Aug 2021 00:30:57 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c6.dip0.t-ipconnect.de. [91.12.101.198])
        by smtp.gmail.com with ESMTPSA id z5sm1183977wmp.26.2021.08.17.00.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 00:30:57 -0700 (PDT)
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f19bfed3-be85-114b-7a8e-72bef58cb74f@redhat.com>
Date:   Tue, 17 Aug 2021 09:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.21 03:46, Andrew Morton wrote:
> On Mon, 16 Aug 2021 17:46:58 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>>> It really is a ton of new code.  I think we're owed much more detail
>>> about the problem than the above.  To be confident that all this
>>> material is truly justified?
>>
>> The desired functionality for this specific use case is to simply
>> convert a 1G huegtlb page to 512 2MB hugetlb pages.  As mentioned
>>
>> "Converting larger to smaller hugetlb pages can be accomplished today by
>>   first freeing the larger page to the buddy allocator and then allocating
>>   the smaller pages.  However, there are two issues with this approach:
>>   1) This process can take quite some time, especially if allocation of
>>      the smaller pages is not immediate and requires migration/compaction.
>>   2) There is no guarantee that the total size of smaller pages allocated
>>      will match the size of the larger page which was freed.  This is
>>      because the area freed by the larger page could quickly be
>>      fragmented."
>>
>> These two issues have been experienced in practice.
> 
> Well the first issue is quantifiable.  What is "some time"?  If it's
> people trying to get a 5% speedup on a rare operation because hey,
> bugging the kernel developers doesn't cost me anything then perhaps we
> have better things to be doing.
> 
> And the second problem would benefit from some words to help us
> understand how much real-world hurt this causes, and how frequently.
> And let's understand what the userspace workarounds look like, etc.
> 
>> A big chunk of the code changes (aprox 50%) is for the vmemmap
>> optimizations.  This is also the most complex part of the changes.
>> I added the code as interaction with vmemmap reduction was discussed
>> during the RFC.  It is only a performance enhancement and honestly
>> may not be worth the cost/risk.  I will get some numbers to measure
>> the actual benefit.

If it really makes that much of a difference code/complexity wise, would 
it make sense to just limit denote functionality to the !vmemmap case 
for now?

-- 
Thanks,

David / dhildenb

