Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0029D45911F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhKVPS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:18:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239771AbhKVPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637594149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=621jYNtFW+0mFTU6R2GKZf+P+Fi4Pvi8SOzQ0aE6RqI=;
        b=iwkuELpZAhqolFQcC1E6znrWv2bjBEuIT4o77IdVGM4lv+Y6VLR4FhYvje5zKJ6D3w6yjR
        ktOjG7C7d3NYSzLVrn7S3sP8zOpm9GY+qW92a6jxpkc6GZJPe51k8dgXrAD4yAEF4wC5WU
        V0+D0vruKnDpbRxgTUctKHh3LY5hRaA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-SpAiOgtuMJWCnn4uYNPjZQ-1; Mon, 22 Nov 2021 10:15:48 -0500
X-MC-Unique: SpAiOgtuMJWCnn4uYNPjZQ-1
Received: by mail-wr1-f70.google.com with SMTP id f3-20020a5d50c3000000b00183ce1379feso3179062wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=621jYNtFW+0mFTU6R2GKZf+P+Fi4Pvi8SOzQ0aE6RqI=;
        b=1hQLtOPubItdEjZk1yRIAwj4/0UgzrkcXLCI4yLg/Zd+2FGJK/IMKWctpzm4f9BMd0
         P8KNDjV5ji4/hp0zYM85j5fb3NyY3obCIT2mhZWoUXYro0czuGFpsY49Ncs64Jo+FXz7
         z/56CSuxbV/mE0+rTjVasnKB4OCEbvXqdNfMZAiGgFZWk1Bj2YA5gxjePN9GFi/+tzqG
         6FiZ7uXRaWtWsx5j2T2slK3ogfcQzXagYcburF2WmVqCsU5bXYeR0OQ8ip+QdnJw2qeY
         KTrImw8Z8+mAKr0aHjm7ZA3ir7amTTpC1fNpO4oyxobNOTjHrAEEq/i3UYRgUsmGVIxQ
         TxVA==
X-Gm-Message-State: AOAM5313hYSWVkutME13AK4S0QMwnoA0AHqsKPaRhiEe0/4DDM2M6xL/
        CHDR3R9wgq93Eh6xVd/pnc1NZezzfKRN3qDYTzFCXNqK9K937YEYKXqLb8E0CXn9ASSz9WGbpLZ
        snPXQT9Hb+v1VeNm3SePQy9b5
X-Received: by 2002:a5d:47c9:: with SMTP id o9mr23544433wrc.348.1637594147108;
        Mon, 22 Nov 2021 07:15:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuFOOEsifCDD0U8JxvjAD6WFeCs8A6VTuxwL4oNddrkpIFu/eH1rQJ0/pc+09fBfKgQ5UEOw==
X-Received: by 2002:a5d:47c9:: with SMTP id o9mr23544380wrc.348.1637594146835;
        Mon, 22 Nov 2021 07:15:46 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id d7sm8948184wrw.87.2021.11.22.07.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 07:15:46 -0800 (PST)
Message-ID: <f201406b-1448-f7c4-5484-3f4c257b6896@redhat.com>
Date:   Mon, 22 Nov 2021 16:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <20211119160023.GI876299@ziepe.ca>
 <4efdccac-245f-eb1f-5b7f-c1044ff0103d@redhat.com>
 <20211122133145.GQ876299@ziepe.ca>
 <56c0dffc-5fc4-c337-3e85-a5c9ce619140@redhat.com>
 <20211122140148.GR876299@ziepe.ca>
 <d2b46b84-8930-4304-2946-4d4a16698b24@redhat.com>
 <20211122150956.GS876299@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211122150956.GS876299@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.21 16:09, Jason Gunthorpe wrote:
> On Mon, Nov 22, 2021 at 03:57:17PM +0100, David Hildenbrand wrote:
>> On 22.11.21 15:01, Jason Gunthorpe wrote:
>>> On Mon, Nov 22, 2021 at 02:35:49PM +0100, David Hildenbrand wrote:
>>>> On 22.11.21 14:31, Jason Gunthorpe wrote:
>>>>> On Mon, Nov 22, 2021 at 10:26:12AM +0100, David Hildenbrand wrote:
>>>>>
>>>>>> I do wonder if we want to support sharing such memfds between processes
>>>>>> in all cases ... we most certainly don't want to be able to share
>>>>>> encrypted memory between VMs (I heard that the kernel has to forbid
>>>>>> that). It would make sense in the use case you describe, though.
>>>>>
>>>>> If there is a F_SEAL_XX that blocks every kind of new access, who
>>>>> cares if userspace passes the FD around or not?
>>>> I was imagining that you actually would want to do some kind of "change
>>>> ownership". But yeah, the intended semantics and all use cases we have
>>>> in mind are not fully clear to me yet. If it's really "no new access"
>>>> (side note: is "access" the right word?) then sure, we can pass the fd
>>>> around.
>>>
>>> What is "ownership" in a world with kvm and iommu are reading pages
>>> out of the same fd?
>>
>> In the world of encrypted memory / TDX, KVM somewhat "owns" that memory
>> IMHO (for example, only it can migrate or swap out these pages; it's
>> might be debatable if the TDX module or KVM actually "own" these pages ).
> 
> Sounds like it is a swap provider more than an owner?

Yes, I think we can phrase it that way, + "migrate provider"


-- 
Thanks,

David / dhildenb

