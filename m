Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1A361F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhDPLya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhDPLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618574044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRi3iLx/d1dCutzOrV2diewuBUaVQYIWtJjdL4DqXrA=;
        b=DK1TEerStVBGE5+gk48kDFVk0WW6WDqKeEa2wh+sn+mkXJ9lFXo4K18Lj4H8uHL2SkqEVs
        cIl3u6pNYjP3xLNKGa4DTH3lLufJtvg/K4lSo4+bCfp/4rphHulY5vzfa3+fNwCi0+5qMl
        jRlUElM0Nb3TQLnWQmSzzRsyNz15zT8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-SZiIfyt5NbW2ZxTgjIt3Wg-1; Fri, 16 Apr 2021 07:54:03 -0400
X-MC-Unique: SZiIfyt5NbW2ZxTgjIt3Wg-1
Received: by mail-wr1-f71.google.com with SMTP id m16-20020a0560000250b02900ffde35c102so4351436wrz.20
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xRi3iLx/d1dCutzOrV2diewuBUaVQYIWtJjdL4DqXrA=;
        b=d30CWcb80S+K7RKIBhiRdANPXzKMT+SkLYkgAXQV1lNuNPq2cms70JC60eu6PKPgFR
         eCBGYK3XG+OeleVt+r5E/v4fgyARVvGgYk6Lcr8aQqq9usYKyEl4HaKxClwsxpQJVVJy
         8rO+ETP3vHjxjBhiqIesmGDG/N+0nNfWRn5Yj/HYcYcccYZpLjjTs+8SQXPO1JlzDo2l
         QfTP0bYoZxOEWyqUCFJ97xa4HjoTKwCPe5KKbKMv5S/7Aixn9SjuQGL+gMfO+Pg+930G
         zgV88gKnPTLG9N5Yiy1dt9FpQz4OAQJNWbfpMioWX7ijmrDDB4a048Kv/cZcMG0mRfIC
         GlMQ==
X-Gm-Message-State: AOAM530WYbCyxWiaSRcMANOLlHe+S0H8LIk/bGF2cT3OC3UU2SlGxboS
        17RX7yh8McVn/8DKONyNc3O4vgkphsYTS0V5aB/tPgb6eKE+t5uPhi8Hvz5r8D/QADBE9liBEx3
        xbInXbhFKT1kKkwcjQW8ejATA
X-Received: by 2002:adf:bc49:: with SMTP id a9mr8859056wrh.109.1618574042105;
        Fri, 16 Apr 2021 04:54:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz45TPUrdRBbQjp6UKDSX/x4TG0TTzsbY/zQUnfTmbSPTX9s6AXQGbir4RRmOHT+616Hu9Ffw==
X-Received: by 2002:adf:bc49:: with SMTP id a9mr8859040wrh.109.1618574041925;
        Fri, 16 Apr 2021 04:54:01 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fb.dip0.t-ipconnect.de. [91.12.100.251])
        by smtp.gmail.com with ESMTPSA id b1sm10150075wru.90.2021.04.16.04.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 04:54:01 -0700 (PDT)
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
 <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
 <3811547a-9057-3c80-3805-2e658488ac99@redhat.com>
 <YHdPmtpzFxHE9mAt@kernel.org>
 <f5503130-c0e7-329f-86c4-727ece1c860f@redhat.com>
 <YHl4mqgh5CtNk1l7@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <1065c0ac-f9e3-2d3a-1ec4-a5c28f98c6ae@redhat.com>
Date:   Fri, 16 Apr 2021 13:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHl4mqgh5CtNk1l7@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.21 13:44, Mike Rapoport wrote:
> On Thu, Apr 15, 2021 at 11:30:12AM +0200, David Hildenbrand wrote:
>>> Not sure we really need a new pagetype here, PG_Reserved seems to be quite
>>> enough to say "don't touch this".  I generally agree that we could make
>>> PG_Reserved a PageType and then have several sub-types for reserved memory.
>>> This definitely will add clarity but I'm not sure that this justifies
>>> amount of churn and effort required to audit uses of PageResrved().
>>>> Then, we could mostly avoid having to query memblock at runtime to figure
>>>> out that this is special memory. This would obviously be an extension to
>>>> this series. Just a thought.
>>>
>>> Stop pushing memblock out of kernel! ;-)
>>
>> Can't stop. Won't stop. :D
>>
>> It's lovely for booting up a kernel until we have other data-structures in
>> place ;)
> 
> A bit more seriously, we don't have any data structure that reliably
> represents physical memory layout and arch-independent fashion.
> memblock is probably the best starting point for eventually having one.

We have the (slowish) kernel resource tree after boot and the (faster) 
memmap. I really don't see why we really need another slowish variant.

We might be better off to just extend and speed up the kernel resource tree.

Memblock as is is not a reasonable datastructure to keep around after 
boot: for example, how we handle boottime allocations and reserve 
regions both as reserved.

-- 
Thanks,

David / dhildenb

