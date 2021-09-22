Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682C44143DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhIVIgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233349AbhIVIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632299699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svaC5frr5Y1j2ok3e6TGBYwEyUBuVy40SZeCKDrTUZw=;
        b=Wh5F9lCpm6qS6hRx9mTIEOGkCWL0SQw/xEU8/4R1XEMHDEQm1AFAxpx25JsTHsEwUb6wR3
        q5TrLBd2BjqdzX8lYzDD1gGDHXnAows7L5a+sk1y+TeqzBNc7bGVh/SV43nqS7k0BsgYD3
        4v/KVjI6JznfuYngtUuSx4XrcjQJuXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-XVatnBauOeumZLRzgj9mFw-1; Wed, 22 Sep 2021 04:34:58 -0400
X-MC-Unique: XVatnBauOeumZLRzgj9mFw-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so1422815wrp.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=svaC5frr5Y1j2ok3e6TGBYwEyUBuVy40SZeCKDrTUZw=;
        b=CvYsa9cWQHal3CJl3Cdht3tkMrdAo/fD5IeROZ80wLx01pcSS4Anj95gMwJlHZ0Rio
         BTO7DdhwLmiNfSuDlWEinNVHOrw2sqjcBqPOqcg+DH6mk4uaGQ4kQYQWHgdhRYB/KGy8
         NE5oxyV4c3qVvhj5MbGz6NcBAWA1gdLnwmiwFsqNyi2uIZYbfHfnrE719m2GwlTBfo1V
         RMiqxlgUvLkPzTjKhXPP575qw6hlqX8C5rtB9FSwvsik4igUnzerke+C7azB3MjugZDn
         2dXezYrajrv9jaZRk3Gr1wkNdhb4nqexKRQZUntaTXquLpH2c0QjGEGrTK19WJoVzjrM
         vbIw==
X-Gm-Message-State: AOAM5324Yv+dUES+gtpfSC2Bf/u2zG3TZVHHlp5vwG8BX4VlmuXfeOFB
        /DrMCu3rVuS0bDlmEyP5qLKyzMLMh95RJCpE3o5WlAtLNlGPImvsqPuG2YHJQF7P0O94jZ6VBcG
        K5I5ylb0SGcqdz70zbQrbaZNH
X-Received: by 2002:a5d:5241:: with SMTP id k1mr8792529wrc.227.1632299697388;
        Wed, 22 Sep 2021 01:34:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbVJ4dzB/vx3MdrtneE17zvVD/pt2Uv3PVLT5B48w60IgoAph1QLkJ0nxtjwF+V/kcbPNs1A==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr8792508wrc.227.1632299697175;
        Wed, 22 Sep 2021 01:34:57 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64dd.dip0.t-ipconnect.de. [91.12.100.221])
        by smtp.gmail.com with ESMTPSA id p5sm1658663wrd.25.2021.09.22.01.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 01:34:56 -0700 (PDT)
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment >
 1
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210908132727.16165-1-david@redhat.com>
 <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
 <20210916193403.GA1940@pc638.lan>
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com>
 <20210921221337.GA60191@pc638.lan>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com>
Date:   Wed, 22 Sep 2021 10:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210921221337.GA60191@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> No, that's leaking implementation details to the caller. And no, increasing
>> the range and eventually allocating something bigger (e.g., placing a huge
>> page where it might not have been possible) is not acceptable for KASAN.
>>
>> If you're terribly unhappy with this patch,
> Sorry to say but it simple does not make sense.
> 

Let's agree to disagree.

find_vmap_lowest_match() is imprecise now and that's an issue for exact 
allocations. We can either make it fully precise again (eventually 
degrading allocation performance) or just special-case exact allocations 
to fix the regression.

I decided to go the easy path and do the latter; I do agree that making 
find_vmap_lowest_match() fully precise again might be preferred -- we 
could have other allocations failing right now although there are still 
suitable holes.

I briefly thought about performing the search in 
find_vmap_lowest_match() twice. First, start the search without an 
extended range, and fallback to the extended range if that search fails. 
Unfortunately, I think that still won't make the function completely 
precise due to the way we might miss searching some suitable subtrees.

>>
>> please suggest something reasonable to fix exact allocations:
>> a) Fixes the KASAN use case.
>> b) Allows for automatic placement of huge pages for exact allocations.
>> c) Doesn't leak implementation details into the caller.
>>
> I am looking at it.

Thanks!

-- 
Thanks,

David / dhildenb

