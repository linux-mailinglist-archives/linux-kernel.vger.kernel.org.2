Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416913FCDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhHaTR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231938AbhHaTR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630437392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIpjFuRy4PTYvIVECj9oFD3RRPXc0bo0Rc30dxlbVWc=;
        b=Gj2QSCOC3ncv/FgT7nbbTwIVQpaZyRCj/1d6IfKd9CBk/Ac3/x2Ap8qvcnvRhBsXqulB2a
        DA2tqK5ODhoy8N+dc7EmvkMd6S0u2JBS81Sef9NNMVyGIeA3gNXGTLShDihyRsSn5E5uzD
        v1F+TtJtuznbc8fbRpQs9jJEORocR2s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-u1iVxbWGMvSRwm36LrK2bg-1; Tue, 31 Aug 2021 15:16:31 -0400
X-MC-Unique: u1iVxbWGMvSRwm36LrK2bg-1
Received: by mail-wm1-f70.google.com with SMTP id p11-20020a05600c204b00b002f05aff1663so95172wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eIpjFuRy4PTYvIVECj9oFD3RRPXc0bo0Rc30dxlbVWc=;
        b=jECrABvvDhvU6FbvbnX83PVBDb6E9VUI+geNuDYXUc3VIlvQ+h4ZUEYOlKh7Lx1R88
         M0BDMQ1IW3nJFjIESVC8FifyqPMFI16h5uV35eHCUQuucv2p+ZVQiyKm7mSlR/71YTT4
         168fH1mNrXVvq24cTiLLqqSdPKHsz/Tw+C7wSWnFsFMFahmKwXeeDnV+LGkJomZWEuFq
         5bqjV2GGrR1z4bIWLK1H/U1KZoenuY9Gw1qgS6lybHXo9cbK6pPXnBzAmjy59OyofRwl
         74yRv/QXvEU/KjlO8VdwEfWKmxD4NbA+KxuRZuvtARva79TWmozp4yZeH4FzzvVHPu2X
         T5vA==
X-Gm-Message-State: AOAM530Kjn/E7JMVxpBHlkCgDeeRT/HsHWiJD8HTRDGvcq9kr1OKxqdX
        zaVol5bc5TLivKH9thFVY+rq4NtIOeYqGhridLbD4riObaP+Kg93FOoy7HVpsSuVG7FSae4bX7r
        7Le4RI0Dghy3JIgHjpSgTOLoH
X-Received: by 2002:a05:6000:1375:: with SMTP id q21mr34067596wrz.41.1630437389970;
        Tue, 31 Aug 2021 12:16:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJnJPBsFBxtY4MXHhJBh4cqe6bA3HiFD9YpBEAUDvHk+O+cj3yajlSPCRKSNZhBtIriVBb+w==
X-Received: by 2002:a05:6000:1375:: with SMTP id q21mr34067565wrz.41.1630437389741;
        Tue, 31 Aug 2021 12:16:29 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id c9sm16986127wrf.77.2021.08.31.12.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 12:16:29 -0700 (PDT)
Subject: Re: [GIT PULL] arm64 fix for 5.14
To:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20210826131747.GE26318@willie-the-truck>
 <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com>
 <20210827074041.GA24309@lst.de>
 <CAHk-=wjd28sN9khO=1j6zmBk+2n4_e+SY1URjW9hzsHSAZU+7Q@mail.gmail.com>
 <20210827171041.GA28149@lst.de>
 <CAHk-=wg=+P1+HQXhrszxN_BgWtLc-=dWiT61KzogcJU3hnLrtQ@mail.gmail.com>
 <20210831133117.GD31712@willie-the-truck>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0a41af61-783c-e31d-abc1-73169dad9ff4@redhat.com>
Date:   Tue, 31 Aug 2021 21:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831133117.GD31712@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.21 15:31, Will Deacon wrote:
> [+David]
> 
> On Fri, Aug 27, 2021 at 10:16:27AM -0700, Linus Torvalds wrote:
>> On Fri, Aug 27, 2021 at 10:10 AM Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> They CCed me on their earlier discussion, but I did not catch up on it
>>> until you responded to the pull request  If I understood it correct it
>>> was about a platform device mapping a MMIO region (like a PCI bar),
>>> but something about section alignment cause pfn_valid to mistrigger.
>>
>> Yeah, so I can easily see the maxpfn numbers can easily end up being
>> rounded up to a whole memory section etc.
>>
>> I think my suggested solution should JustWork(tm) - exactly because if
>> the area is then in that "this pfn is valid" area, it will
>> double-check the actual underlying page.
> 
> I think the pitfall there is that the 'struct page' might well exist,
> but isn't necessarily initialised with anything meaningful. I remember
> seeing something like that in the past (I think for "no-map" memory) and
> David's reply here:
> 
> https://lore.kernel.org/r/aff3942e-b9ce-5bae-8214-0e5d89cd071c@redhat.com
> 
> hints that there are still gotchas with looking at the page flags for
> pages if the memory is offline or ZONE_DEVICE.
> 
> Don't get me wrong, I'd really like to use the generic code here as I
> think it would help to set expectations around what pfn_valid() actually
> means, I'm just less keen on the try-it-and-see-what-breaks approach
> given how sensitive it is to the layout of the physical memory map.
> 
>> That said, I think x86 avoids the problem another way - by just making
>> sure max_pfn is exact. That works too, as long as there are no holes
>> in the RAM map that might be used for PCI BAR's.
>>
>> So I think arm could fix it that way too, depending on their memory layout.
> 
> The physical memory map is the wild west, unfortunately. It's one of the
> things where everybody does something different and it's very common to see
> disjoint banks of memory placed seemingly randomly around.

The resource tree is usually the best place to really identify what's 
system RAM and what's not IIRC. memblock should work on applicable archs 
as well. Identifying ZONE_DEVICE ranges reliably is a different story ...

-- 
Thanks,

David / dhildenb

