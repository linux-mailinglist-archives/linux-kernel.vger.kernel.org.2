Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85FF39F9CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhFHPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233540AbhFHPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623164416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sP/HCIKPH6fku9Jm9ctce/xaqJCVC+wTHmv58Dg6yL8=;
        b=NbSOzjYTM/VQqF+OjvXZbDR4Z0RqvhMgyLM4ejh1p+9F12IwaE9G/mWtHP0icjr+/yvcnC
        rDf80vY/9tRJE2VTJi4np6kqjkWldRQ8TQ7VScfd7slzrMGLwsxO9XQAeWVGmGDlTBLQss
        eZazDUYy3MA2yy4H0flb6LKGWdlOh+0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-I2vDa_-INCSyaKiWHS33_g-1; Tue, 08 Jun 2021 11:00:12 -0400
X-MC-Unique: I2vDa_-INCSyaKiWHS33_g-1
Received: by mail-wm1-f69.google.com with SMTP id o82-20020a1ca5550000b029019ae053d508so858721wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sP/HCIKPH6fku9Jm9ctce/xaqJCVC+wTHmv58Dg6yL8=;
        b=nCNas50juqQfh6mV+fRW2qr3Wn7E117/zkwirajkv6kSpSrcSs+c9Fc49lAYMPMfIB
         zcU6UNgVYPmvMfVfqPuFTWDbt2JJga/CWpO3h+6QmWmVsSzqBuYmRQd9tH09kb3BLSMh
         Ay7Bw78V0aYKy52mh3H4CJ4hHxZRAsvghQEQ+2wy8x4c1gMKCR4z9cM6DoDkYmj79Ikm
         dTCjvTgMijywQWAH3N9ZQfO2JqAsntDDu+jrk2zIlr1g8VPHtKV/N3OY39RRWU7gAn8w
         55/o9eM84JXhbO+CsFKw++78nhzHf0EzCcU8ixzfHLxvSmIitxrb79ev6wWKo5TAvLuf
         Gc2w==
X-Gm-Message-State: AOAM532ppMY8DzEMdybs0yZqYUFJs2SJF2wsfgx+cA6Siao9KaV2hNP6
        TjQ1Ywc3yB9BCv8iSyAdkKWSCjTeIGkI92kWuU44LrnIb9UMc3Yv8sJJJIsAg/KO10jnWygc2BO
        Lxl8DQ8czPmnKwqyjP18JyLjkakpRaTMVn+PMQbr0pjPuJe98MgO/hRQRJe2qhveA3ekiivC7
X-Received: by 2002:a05:6000:1847:: with SMTP id c7mr23399206wri.368.1623164411638;
        Tue, 08 Jun 2021 08:00:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc23OfeneeiRH8dhb4635S5RMgLsmbVD2xETYBeyfabOdPjxd9mC3vyJTeeUqlPnf31WXPvA==
X-Received: by 2002:a05:6000:1847:: with SMTP id c7mr23399157wri.368.1623164411254;
        Tue, 08 Jun 2021 08:00:11 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61cf.dip0.t-ipconnect.de. [91.12.97.207])
        by smtp.gmail.com with ESMTPSA id p6sm20906832wrf.51.2021.06.08.08.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:00:10 -0700 (PDT)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
 <YLiVAAsCTR7B6Db9@localhost.localdomain> <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
 <20210604074140.GA25063@linux> <20210607075147.GA10554@linux>
 <85984701-55ae-dfa5-2a8d-f637051b612d@redhat.com>
 <20210607102318.GA12683@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
Message-ID: <0eadea9c-5af0-d7e6-071e-898b04294dd3@redhat.com>
Date:   Tue, 8 Jun 2021 17:00:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607102318.GA12683@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.21 12:23, Oscar Salvador wrote:
> On Mon, Jun 07, 2021 at 10:49:01AM +0200, David Hildenbrand wrote:
>> I'd like to point out that I think the seqlock is not in place to
>> synchronize with actual growing/shrinking but to get consistent zone ranges
>> -- like using atomics, but we have two inter-dependent values here.
> 
> I guess so, at least that's what it should do.
> But the way it is placed right now is misleading.
> 
> If we really want to get consistent zone ranges, we should start using
> zone's seqlock where it matters and that is pretty much all those
> places that use zone_spans_pfn().

Right, or even only zone_end_pfn() to get a consistent value.

> Otherwise there is no way you can be sure the pfn you're checking is
> within the limits. Moreover, as Michal pointed out early, if we really
> want to go down that road the locking should be made in the caller
> evolving the operation, otheriwse things might change once the lock
> is dropped and you're working with a wrong assumption.
> 
> I can see arguments for both riping it out and doing it right (but none for
> the way it is right now).
> For riping it out, one could say that those races might not be fatal,
> as usually the pfn you're working with (the one you want to check falls
> within a certain range) you know is valid, so the worst can happen is
> you get false positives/negatives and that might or might not be detected
> further down. How bad are false positive/negatives I guess it depends on the
> situation, but we already do that right now.
> The zone_spans_pfn() from page_outside_zone_boundaries() is the only one using
> locking right now, so well, if we survided this long without locks in other places
> using zone_spans_pfn() makes one wonder if it is that bad.
> 
> On the other hand, one could argue that for correctness sake, we should be holding
> zone's seqlock whenever checking for zone_spans_pfn() to avoid any inconsistency.
> 
> 

IMHO, as we know the race exists and we have a tool to handle it in 
place, we should maybe fix the obvious cases if possible.

Code that uses zone->zone_start_pfn directly is unlikely to be broken on 
most architectures. We will usually read/write via single instruction 
and won't get inconsistencies, for example, when shrinking or growing 
the zone. We most probably don't want to use an atomic for that right now.

Code that uses zone->spanned_pages to detect the zone end, however, is 
more likely to be broken. I don't think we have any relevant around 
anymore. Everything was converted to zone_end_pfn().

I feel like we should just make zone_end_pfn() take the seqlock in read. 
Then, we at least get a consistent value, for example, while growing a zone.

Just imagine the following case when we grow a section to the front when 
onlining memory:

	zone->zone_start_pfn -= new_pages;
	zone->spanned_pages += new_pages;

Note that compilers/CPUs might reshuffle as they like. If someone (e.g., 
zone_spans_pfn()) races with that code, it might get new 
zone->zone_start_pfn but old zone->spanned_pages. zone_end_pfn() will 
report a "too small zone" and trigger false negatives in zone_spans_pfn().

-- 
Thanks,

David / dhildenb

