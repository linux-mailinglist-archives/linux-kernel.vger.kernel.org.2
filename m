Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4341C6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbhI2Olr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344438AbhI2Olq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632926405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTohnJEVaRgmsE21p0PUf/a8BihysPGpVmzSuoYF6Kc=;
        b=ZNey48U3ErVudoMKDKBWkJh7JPLyksxg/VLHuGppgcKxXYdamo/KC7o7/7ma4d94EU17//
        EGbJ4Gl6Nfc1JVH6tHkxuTldt1GmYxyxXIj01lxikIkKgQiHrARC7qDgicknxDBidi9bj6
        agkOvhn1bRdoqhM+lYMY+nD2RXzi5xU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-zTAqi8taMcyjgA4f8DO2RA-1; Wed, 29 Sep 2021 10:40:03 -0400
X-MC-Unique: zTAqi8taMcyjgA4f8DO2RA-1
Received: by mail-wr1-f70.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso685203wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RTohnJEVaRgmsE21p0PUf/a8BihysPGpVmzSuoYF6Kc=;
        b=t6U1aAchXdl5liF9DBmToizRRN2kHnCcDFSpKRCCMf553la3hz+4YGpcEHZbggzsfW
         uc9O4sO/GB55C9FG6iOEgTenGt2uk6kB+6owDazzIKIt/LXm5ZdkUJvwUTXu+x3ZGwLv
         kJkkZ7EXswrQ9hqM+5PxkaHgaAMKxXlzAzoMEO/uWYcI/7vj/3a/RMHBJjj1SIktwUY/
         2Hi5KfkfydlzkJIARGw7UZ82oP8vrEalkSPiRmKokfZO4lgL4PlI5rnmL991y1BXqyWI
         /SE3w52AJnt8U6r4b4lx01M+rGOtgJxqL8IsUnsQt2V5phU7F4mOBp2TfFPtxZOoGy3x
         MHFA==
X-Gm-Message-State: AOAM5314EFfu+MHwgrHJ2O6pCKPmZH9J4H8G7hcDSpB0oSGGJ9qM53I0
        WtgiJa9pvfeu/nX4KZCl/r8ElnjOqwGk1nqaT881E6ujnGevaW/vgl2j25XXRYQ0D20MRQXZjnw
        DxFhsr56w7AmXP8EJe7E+DWUH
X-Received: by 2002:a1c:7f11:: with SMTP id a17mr10831940wmd.166.1632926402159;
        Wed, 29 Sep 2021 07:40:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL+KrZvzNDfBushKo4he0hLbt3uOFSVXpNF30x8fkTZQ/hUEAzG4H0Yap4j9KgNoD3atKEHw==
X-Received: by 2002:a1c:7f11:: with SMTP id a17mr10831921wmd.166.1632926401991;
        Wed, 29 Sep 2021 07:40:01 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id n26sm1871649wmi.43.2021.09.29.07.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 07:40:01 -0700 (PDT)
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
 <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com>
 <20210922104141.GA27011@pc638.lan>
 <e378e60a-319b-e9aa-7e30-3e280c4431da@redhat.com>
 <CA+KHdyWZ9T2GEuUENXD_OYHX1JxKfZuW5YzmDtqXUYSgkQd8fQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <953ea84a-aabb-f64b-b417-ba60928430e0@redhat.com>
Date:   Wed, 29 Sep 2021 16:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+KHdyWZ9T2GEuUENXD_OYHX1JxKfZuW5YzmDtqXUYSgkQd8fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 16:30, Uladzislau Rezki wrote:
>>
>> So the idea is that once we run into a dead end because we took a left
>> subtree, we rollback to the next possible rigth subtree and try again.
>> If we run into another dead end, we repeat ... thus, this can now happen
>> more than once.
>>
>> I assume the only implication is that this can now be slower in some
>> corner cases with larger alignment, because it might take longer to find
>> something suitable. Fair enough.
>>
> Yep, your understanding is correct regarding the tree traversal. If no
> suitable block
> is found in left sub-tree we roll-back and check right one. So it can
> be(the scanning)
> more than one time.
> 
> I did some performance analyzing using vmalloc test suite to figure
> out a performance
> loss for allocations with specific alignment. On that syntactic test i
> see approx. 30%
> of degradation:

How realistic is that test case? I assume most alignment we're dealing 
with is:
* 1/PAGE_SIZE
* huge page size (for automatic huge page placing)

> 
> 2.225 microseconds vs 1.496 microseconds. That time includes both
> vmalloc() and vfree()
> calls. I do not consider it as a big degrade, but from the other hand
> we can still adjust the
> search length for alignments > one page:
> 
> # add it on top of previous proposal and search length instead of size
> length = align > PAGE_SIZE ? size + align:size;

That will not allow to place huge pages in the case of kasan. And I 
consider that more important than optimizing a syntactic test :) My 2 cents.

-- 
Thanks,

David / dhildenb

