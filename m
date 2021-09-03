Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA5C3FFB3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347419AbhICHnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347152AbhICHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630654957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGNoXGQR4G1nHZ5SvtMA1M71DXUrv+gYZg+gvrpIQ0E=;
        b=NAxyZeVEUaGsGnFTxqPJj356f91EQK+Rrgf0CSs424z4l7oek/qImXfoMCn30BYV6s1y2i
        pH3Gs4nUpC2GK6qzlP6jOTu0LRTQUSLQkivbvlCuFkaKAnjNM2Z5Ikn6Z/NM4m2ueZECDb
        XIJjxi7goHYWuDV+qm34dA42b4pCYY4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-x98IejkvND2mpoGBdsQyzg-1; Fri, 03 Sep 2021 03:42:36 -0400
X-MC-Unique: x98IejkvND2mpoGBdsQyzg-1
Received: by mail-wr1-f70.google.com with SMTP id p10-20020a5d68ca000000b001552bf8b9daso1283171wrw.22
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zGNoXGQR4G1nHZ5SvtMA1M71DXUrv+gYZg+gvrpIQ0E=;
        b=GqE2Bn/YGmBByHaXy1BPliDdGd/Kyn22k3igVMXTqBtWfHA5f3i0e3ANAYlsdkTm7O
         AaL/ckadfBFkId7/IPhGGy0SEhOX8fgcunPOSpJrR7BC1xDELIJZc03kmuoI0WhsNUnB
         rJZqcTOkOWWz2WUhqnoynmsMuk8IF/UvKFz2QVXSelV17LNzbjXJkibp3v3S1Oq2AvS5
         ReBpnJ5pYlUWbfzKKIXFpJ0m97dFKPIZtNMI+5fHX/Bmk7b45e7HVjbPdnvlIsn0+8zy
         fFDgNiacv6FSBKz67qZkQTim6wZeSPD18PxPY6vTg0X4IMQH1wFhhoudy/7kk6CDLXYU
         neaQ==
X-Gm-Message-State: AOAM531vXAvWErNdGuHTCVGzypJxN3UNcKVd4ekOgoY7J9k+wPrKUgHJ
        GrIVUP8nKOMxpSsL0EBxkAseFse3s8uI2OC5TsTCi7FHGik/d3uR5GGHIQghBg0GOiKlsrlZdGA
        Hi1FBlPFhRocUjhrWznlQx3Gi
X-Received: by 2002:a5d:6352:: with SMTP id b18mr2395719wrw.116.1630654955675;
        Fri, 03 Sep 2021 00:42:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzQuMGwLZdTovtvmgDjV4dIuN1t/yCejCcf/NATI9SRiWTlVPjpzfobAR/VEFh2l/oUzEBdw==
X-Received: by 2002:a5d:6352:: with SMTP id b18mr2395690wrw.116.1630654955521;
        Fri, 03 Sep 2021 00:42:35 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e05.dip0.t-ipconnect.de. [79.242.62.5])
        by smtp.gmail.com with ESMTPSA id c9sm4040224wrf.77.2021.09.03.00.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 00:42:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>
References: <20210902201721.52796-1-peterx@redhat.com>
 <20210902201721.52796-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2f1bfe82-9bb7-957c-2b32-2ccf8a48e70a@redhat.com>
Date:   Fri, 3 Sep 2021 09:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902201721.52796-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.21 22:17, Peter Xu wrote:
> It was conditionally done previously, as there's one shmem special case that we
> use SetPageDirty() instead.  However that's not necessary and it should be
> easier and cleaner to do it unconditionally in mfill_atomic_install_pte().
> 
> The most recent discussion about this is here, where Hugh explained the history
> of SetPageDirty() and why it's possible that it's not required at all:
> 
> https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/
> 
> Currently mfill_atomic_install_pte() has three callers:
> 
>          1. shmem_mfill_atomic_pte
>          2. mcopy_atomic_pte
>          3. mcontinue_atomic_pte
> 
> After the change: case (1) should have its SetPageDirty replaced by the dirty
> bit on pte (so we unify them together, finally), case (2) should have no
> functional change at all as it has page_in_cache==false, case (3) may add a
> dirty bit to the pte.  However since case (3) is UFFDIO_CONTINUE for shmem,
> it's merely 100% sure the page is dirty after all, so should not make a real
> difference either.

Would it be worth adding VM_BUG_ON() to make sure that "100%" is really 
the case?

> 
> This should make it much easier to follow on which case will set dirty for
> uffd, as we'll simply set it all now for all uffd related ioctls.  Meanwhile,
> no special handling of SetPageDirty() if there's no need.

To me this all sounds sane, but I'm certainly not an expert on that 
code, so ...

-- 
Thanks,

David / dhildenb

