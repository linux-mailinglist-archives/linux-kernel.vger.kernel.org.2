Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD63F0AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhHRSO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhHRSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629310432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDmlm5XVVLxGFrZ0SHbAErAGGO55744SvkIuzRpj4cY=;
        b=KS4KF4uL2VpsPq7QLCjbMq4PSnBr/nd/cVcFxkS/fAaBulPbMVEfNi7Intf64vmTY7uIjm
        C8e99FdDW2YXjCNHHhSWptEUyfWbiMQh7fzhBfXgfizc33m/TP1gjW4ihtCVw94luOVP1x
        s5lmf13kLXzHnGX3hKa1WWsDYaHr1ek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-BrICb0OFMAuLW9aNcXKg3Q-1; Wed, 18 Aug 2021 14:13:51 -0400
X-MC-Unique: BrICb0OFMAuLW9aNcXKg3Q-1
Received: by mail-wr1-f72.google.com with SMTP id a13-20020adfed0d000000b00156fd70137aso726404wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hDmlm5XVVLxGFrZ0SHbAErAGGO55744SvkIuzRpj4cY=;
        b=Edwyef/UHiODwstR/dfJVXsWm97IRZ0/Qr0frnspsZr8pgwzJ1h6z7AbbBuPhHpJmq
         kxEblZuEADUPVb/nWAnaHaI0mUlSB7VPVsRY+s4lO+8vSCqiaB+cwIbUXZrCebd3ILWP
         YWCh/5O4zTInQH4NDGJVrmrGuOqOTpLWZdh5WSS+f6zJOYUtSegXDBcWrrcGJkTWaoCD
         5sqpmMQKXqgqS+6sguquJd/mVdCnq7mhFWU+RIUL2G61nF26eVj0ala4wGl0rvSYBhiL
         pZzZJjBjRwqjtHzUhpYCvgD2SjtT1spYtWkl05qxqqHeXQBL2Emm+7o3DEeLnAYdPeE2
         m5rg==
X-Gm-Message-State: AOAM533zxAtBPhF7OvM/0CPXooV6PCdn0DXhQzrnCjadyMWnXN1+eW6d
        0e1EasfMZ2rQu/IqcldIeCQ0W7DjweuKxv9G8ekQwkB+Tck4fJyGIHzebiJ6kz957vums1sYRJw
        ZSAL12w89qurCQZdM0GSe6UbS
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr12275073wrs.77.1629310429922;
        Wed, 18 Aug 2021 11:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKdo/0UHPZLbnD5FqI3dueNBGosCAGASSIRZZhsa7DQXAJHhT1AtQiS6uzeLDF30v3JtuWTA==
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr12275046wrs.77.1629310429743;
        Wed, 18 Aug 2021 11:13:49 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id l7sm486862wmj.9.2021.08.18.11.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 11:13:49 -0700 (PDT)
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     Peter Xu <peterx@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com> <YRvtPrPmAorX+KY5@t490s>
 <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com> <YRwa6+jx5PukCn53@t490s>
 <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
 <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Message-ID: <6ab58270-c487-2a56-b522-ea5100edb13c@redhat.com>
Date:   Wed, 18 Aug 2021 20:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>> I'm now wondering whether for Tiberiu's case mincore() can also be used.  It
>>> should just still be a bit slow because it'll look up the cache too, but it
>>> should work similarly like the original proposal.
> 
> I am afraid that the information returned by mincore is a little too vague to be of better help, compared to what the pagemap should provide in theory. I will have a look to see whether lseek on
> proc/map_files works as a "PM_SWAP" equivalent. However, the swap offset would still be missing.

Well, with mincore() you could at least decide "page is present" vs. 
"page is swapped or not existent". At least for making pageout decisions 
it shouldn't really matter, no? madvise(MADV_PAGEOUT) on a hole is a nop.

But I'm not 100% sure what exactly your use case is here and what you 
would really need, so you know best :)

>>
>> Very right, maybe we can just avoid tampering with pagemap on shmem completely (which sounds like an excellent idea to me) and document it as "On shared memory, we will never indicate SWAPPED if the pages have been swapped out. Further, PRESENT might be under-indicated: if a shared page is currently not mapped into the page table of a process.". I saw there was a related, proposed doc update, maybe we can finetune that.
>>
> We could take into consideration an alternative approach to retrieving the shared page info in user
> space, like storing it in sys/fs instead of per process. However, just leaving the pagemap functionality
> incomplete, and not providing an alternative to retrieve the missing information, does not seem right. Updating the docs with a "can't do" should be temporary, until an alternative or fix.
> 

As I stated before, making pagemap less broken is not a good idea IMHO. 
Either make it really correct or just leave it all broken -- and 
document that e.g., other interfaces (lseek) shall be used. It sounds 
like they exist and are good enough for CRUI.

And TBH, if other interfaces already exist and get the job done, I'm 
more than happy that we can avoid mixing more shmem stuff into pagemap 
and trying to compensate performance problems by introducing inconsistency.

If it has an fd and we can punch that into syscalls, we should much 
rather use that fd to lookup stuff then going via process page tables -- 
if possible of course (to be evaluated, because I haven't looked into 
the CRIU details and how they use lseek with anonymous shared memory).

> Also, I think you are talking about my own doc update patch[3]. If not, please share a link with your
> next reply.
> 
> [3] https://marc.info/?m=162878395426774

No, that's it.


-- 
Thanks,

David / dhildenb

