Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287943A99E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhFPMJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhFPMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623845260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeoIWCMAUOT74+Wt948hW/6FdReXMVW6c15yjUPpXrQ=;
        b=hZ3pQ4AIdQgdQ20HaJ4WpKDrYoKZytUyo2NfeuXvUCLDAiCiq3DpdCGO3TSYGo2CiZMXLc
        il9Xs0+ng5ppJoMxSksc+yorvKXXsDejzMxVsoBdyzILnp7uwdFj2IafHYtYQhaTL1TQ/u
        uzq+XSWGNIBWL0PLPwsAHeRrnAvrPiQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-BZ_jlnpMNVm1whtqadCgWA-1; Wed, 16 Jun 2021 08:07:37 -0400
X-MC-Unique: BZ_jlnpMNVm1whtqadCgWA-1
Received: by mail-wm1-f71.google.com with SMTP id m33-20020a05600c3b21b02901a44b1d2d87so1136571wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SeoIWCMAUOT74+Wt948hW/6FdReXMVW6c15yjUPpXrQ=;
        b=Z/xNSa6hqcKSSa1gWBtAnPgowwIeOe0MOX7cXLuIzXYMqvpQswlyLhqFdxZtJuFKXT
         8FdPJYcGEqJQwR2oP4HuY0mgSNqaZDDZL42qy/D74t2ontRVH0LHlNeAdW186m04apcB
         g+e098u0a3v9VMR7Pb+H7tOqyFWnlgX/dewgg1gXvkES2FuSvh1YPygeE7W2fEl/0ACD
         mcUPn/P8ig+tPIWEw8xVPK7Fj561f8Xk1SRwY5vE+xy+xwWGOud+oE5bKg3s2/0exzvL
         y5N2NzvvMUxOUI1ftPAQruGxIrk872bh4Fc9tJnXmKjroi3SVYARlw8XzuwycwCYNjC2
         uT/A==
X-Gm-Message-State: AOAM5333t5MAY4SlVH5cgWrBM5DVnXcUy+UBm7ErQaaweR9kCnuTxNDW
        uGQzmRS/qXzRa9TJCy5ck2Yy5whtiMP4VZfM5p7HrG0l2yp256sMuE8TXljiF/8sx1DkaH7FaB6
        x+/gEAApa69qIm6DnDWbEFuFP
X-Received: by 2002:a7b:c042:: with SMTP id u2mr4768365wmc.127.1623845256365;
        Wed, 16 Jun 2021 05:07:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA+BIdYpi7Bpa4vjtxKjzsUDhKLoGEbhQaSCt0/4bpAjRqjrX2bfoB9uMhzFj27JRacEd4AA==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr4768344wmc.127.1623845256172;
        Wed, 16 Jun 2021 05:07:36 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6524.dip0.t-ipconnect.de. [91.12.101.36])
        by smtp.gmail.com with ESMTPSA id p16sm2003737wrs.52.2021.06.16.05.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 05:07:35 -0700 (PDT)
To:     Gavin Shan <gshan@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shan.gavin@gmail.com, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210601033319.100737-1-gshan@redhat.com>
 <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com>
 <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
 <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com>
 <63c06446-3b10-762c-3a29-464854b74e08@redhat.com>
 <0cb302f1-7fb6-e47c-e138-b7a03f2b02e2@redhat.com>
 <33b441b2-f10d-a7fb-8163-df2afbf6527d@redhat.com>
 <9e553b30-ce18-df65-bd3c-c68eaa4d0d91@redhat.com>
 <3adbcad8-1016-cf48-4574-799de0bba6e4@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
Message-ID: <249e5814-e644-3d82-9b38-232928af4dbd@redhat.com>
Date:   Wed, 16 Jun 2021 14:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3adbcad8-1016-cf48-4574-799de0bba6e4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed. 512MB pageblocks are rare, especially on systems which have been
> up and running for long time.
> 
> The free page reporting starts from guest. Taking an extreme case: guest has
> 512MB memory and it's backed by one THP on host. The free page reporting won't
> work at all.
> 
> Besides, it seems free page reporting isn't guranteed to work all the time.
> For example, on system where we have 4KB base page size. Freeing individual
> 4KB pages can't come up with a free 2MB pageblock due to fragmentation.
> In this case, the free'd page won't be reported immediately, but might be
> reported after swapping or compaction due to memory pressure. The free page
> isn't reported immediately at least.

Exactly, it's a pure optimization that won't work, especially when guest 
memory is heavily fragmented. There has to be a balance between 
reclaiming free memory in the hypervisor, degrading VM performance, and 
overhead of the feature.

Further, there are no guarantees when a VM will reuse the memory again. 
In the worst case, all VMs that reported free pages reuse memory at the 
same time. In that case, one definitely needs sufficient backend memory 
in the hypervisor (-> swap) to not run out of memory, and performance 
will be degraded.

As MST once phrased it, if the feature has a higher overhead than 
swapping in the hypervisor, it's of little use.

> 
> David, how about taking your suggestion to have different threshold size only
> for arm64 (64KB base page size). The threshold will be smaller than pageblock_order
> for sure. There are two ways to do so and please let me know which is the preferred
> way to go if you (and Alex) agree to do it.
> 
> (a) Introduce CONFIG_PAGE_REPORTING_ORDER for individual archs to choose the
>       value. The threshold falls back to pageblock_order if isn't configurated.
> (b) Rename PAGE_REPORTING_MIN_ORDER to PAGE_REPORTING_ORDER. archs can decide
>       its value. If it's not provided by arch, it falls back to pageblock_order.
> 

I wonder if we could further define it as a (module/cmdline) parameter 
and make it configurable when booting. The default could then be set 
based on CONFIG_PAGE_REPORTING_ORDER. CONFIG_PAGE_REPORTING_ORDER would 
default to pageblock_order (if easily possible) and could be 
special-cases to arm64 with 64k.

> By the way, I recently had some performance testing on different page sizes.
> We get much more performance gain from 64KB (vs 4KB) page size in guest than
> 512MB (vs 2MB) THP on host. It means the performance won't be affected too
> much even the 512MB THP is splitted on arm64 host.

Yes, if one is even able to get 512MB THP populated in the hypervisor -- 
because once again, 512MB THP are just a bad fit for many workloads.

-- 
Thanks,

David / dhildenb

