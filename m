Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4154D420A70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhJDL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhJDL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633348534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYvmPpboOM7KrIZ0kaweRjUAITlvVV/bdELrT4OcyGE=;
        b=F2fswxyLEaJpYreR+gr2l4uYN6se6i5dfnE8Kl/yJ1FUa98OVgOr4Nom6rrNWzZPLpqEBM
        FSQg7Y3DeJhTV1vnj4f32Tpd1CzXgLpTlH34lfiUcZdvIqwv5FGiYmRpNmyXd8a/24fUO0
        B0ucQ2MIraDljX3DBn/LwW1GoPuhXTU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-7gvCRfSDP1-_P324GM8oNg-1; Mon, 04 Oct 2021 07:55:33 -0400
X-MC-Unique: 7gvCRfSDP1-_P324GM8oNg-1
Received: by mail-wm1-f71.google.com with SMTP id h24-20020a7bc938000000b0030d400be5b5so5375330wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 04:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FYvmPpboOM7KrIZ0kaweRjUAITlvVV/bdELrT4OcyGE=;
        b=MS0gqx9Dg225u01uKWbdks1yE0wlAZmgpO8oItlTjfAUg46NZHgb7paIZ7MaDxnN0U
         IyFEoJvPKGLX9+9YRRnIjlGq/pZd3y2KKtvthA+RYR7B1h3GEeufjmVH5+jyHerVgISd
         jxMX3TkaJstaoBe2V7RWQtDX50LgXim7dD7WaQBmnVwrZ3BHCXWE2kDcwtBVMVQ5LYsV
         nolJocvOa3VTFryPGI+2bLiOSZwOCokETWcGG1aNKNaT/tgj3ZVVsx/5KCgOQFRZc6hN
         +PQ0lDIsf34TWeRs/+PBDl7257j473wFeUM8JeprMsyXkBSyb71zdt0n8kBwmS4b3q/i
         KHDg==
X-Gm-Message-State: AOAM530tBzwDbVkkzCmqLHIUs0csaK6NYULjDjUsjpJ/fB2F2npjVDAC
        +ZMI5KFi+tBLZ6s/XNQGmeRTU9zCdpcmGjX5gL/J+s7YnCYrAWZnUUVT79iEEJgRCbcH1jI4nVP
        N8OTy/06GGghf5dtfDk/rlOy33HNhs0imjyUi01z5aekQLbRBVC1dvd+dqywVo4YLDlRPBn8o
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr18004224wmj.155.1633348531931;
        Mon, 04 Oct 2021 04:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfI2fCei/9E7lxXC+jT5l62/0J801YNEfv/IycvTbzfCPjD2wf6uOJ0pHuuq4EoD/1yC9YHg==
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr18004195wmj.155.1633348531590;
        Mon, 04 Oct 2021 04:55:31 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6672.dip0.t-ipconnect.de. [91.12.102.114])
        by smtp.gmail.com with ESMTPSA id o15sm14062814wmc.21.2021.10.04.04.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 04:55:31 -0700 (PDT)
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <258d0ddb-6c82-0c95-a15e-b085b59d2142@redhat.com>
Date:   Mon, 4 Oct 2021 13:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.21 13:50, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> A hwpoison entry is a non-present page table entry to report
> memory error events to userspace. If we have an easy way to know
> which processes have hwpoison entries, that might be useful for
> user processes to take proper actions. But we don't have it now.
> So make pagemap interface expose hwpoison entries to userspace.

Noting that this is only a way to inspect hwpoison set for private 
anonymous memory. You cannot really identify anything related to shared 
memory.

Do you also handle private hugetlb pages?

> 
> Hwpoison entry for hugepage is also exposed by this patch. The below
> example shows how pagemap is visible in the case where a memory error
> hit a hugepage mapped to a process.
> 
>      $ ./page-types --no-summary --pid $PID --raw --list --addr 0x700000000+0x400
>      voffset offset  len     flags
>      700000000       12fa00  1       ___U_______Ma__H_G_________________f_______1
>      700000001       12fa01  1ff     ___________Ma___TG_________________f_______1
>      700000200       12f800  1       __________B________X_______________f______w_
>      700000201       12f801  1       ___________________X_______________f______w_   // memory failure hit this page
>      700000202       12f802  1fe     __________B________X_______________f______w_
> 
> The entries with both of "X" flag (hwpoison flag) and "w" flag (swap
> flag) are considered as hwpoison entries.  So all pages in 2MB range
> are inaccessible from the process.  We can get actual error location
> by page-types in physical address mode.
> 
>      $ ./page-types --no-summary --addr 0x12f800+0x200 --raw --list
>      offset  len     flags
>      12f800  1       __________B_________________________________
>      12f801  1       ___________________X________________________
>      12f802  1fe     __________B_________________________________
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>   fs/proc/task_mmu.c      | 41 ++++++++++++++++++++++++++++++++---------
>   include/linux/swapops.h | 13 +++++++++++++
>   tools/vm/page-types.c   |  7 ++++++-
>   3 files changed, 51 insertions(+), 10 deletions(-)


Please also update the documentation located at

Documentation/admin-guide/mm/pagemap.rst


-- 
Thanks,

David / dhildenb

