Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378DE38E7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhEXNjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232536AbhEXNjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621863491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfjGBgY2FkJz/nb2klTdqTGbzOdhTohGwKQvQlvlXtQ=;
        b=XRJwFH1ia4/i1+6Zk6HoCLp4Z0rmKciATdFv99cu+4UAGbeLxG5vjOW5YB4X6kmOiKPkUg
        6lWoyKNxrmAOdECXV5GXO8eJM11Ikl+L5NLkhCzrhvGnVsaY4gunaSX5My7EseG0a4NyV9
        BZ2HjzjpryjJF6DtRrBpcpud6ccdlr4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-mK25uefGOSCpmhKG7lVBjw-1; Mon, 24 May 2021 09:38:10 -0400
X-MC-Unique: mK25uefGOSCpmhKG7lVBjw-1
Received: by mail-ed1-f69.google.com with SMTP id cy15-20020a0564021c8fb029038d26976787so14143407edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gfjGBgY2FkJz/nb2klTdqTGbzOdhTohGwKQvQlvlXtQ=;
        b=FgsaNu2o7/AX0RTbfMqFOmbATE7IdOa9x28dyWqpMmLPv6WAp68PKD/h6PAkkJW+Z/
         vyRq2AsrcYVpwJm0FBZs7kwE5IG0EKFbc4WHT9Yzaj8/nb/f1wHuo4NOWf7x50PwS7+y
         4rfB9xKmhyJ4VoB9doMcEtobyu/mrzmgh9ls22q6GT3L8jux4yt9n74/LtvuQ/zf1yfd
         E17FfKi/at4KrLAC/y1WUZ06vp1SgfQO6tgoFMxCt72MfN5vvxDWJk/YGJQgW3B8enUR
         XAYl6seE+zfu3pA3j7gyhndsnvbHvZ/J1wRnDc4IzEn4Lj2MAO+sfh5ITDitwamDyQPI
         /EgA==
X-Gm-Message-State: AOAM531ClRgEdyUzlAw7qJ6PQ+eVP0Xywca3PVBKmBFYs1UF6aoDSsUk
        BtBZ9vmiV09zOTJ/bZtPiRqZ1nDfJQ4kvbMFrY+g2DWfihgQLK32x/ES5cpeD96cHOGUptc9Ukd
        P2BIAfgEkXjWdiwYwJegt+9q2
X-Received: by 2002:a50:a446:: with SMTP id v6mr26210212edb.254.1621863487864;
        Mon, 24 May 2021 06:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaX41xtNYlI3xVyFbNhkNJUGgbn3pROEOzh8ymMppFkB7r4R9Hd70KqayS7P90z4Z0plwAfw==
X-Received: by 2002:a50:a446:: with SMTP id v6mr26210188edb.254.1621863487631;
        Mon, 24 May 2021 06:38:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f7sm9787850edd.5.2021.05.24.06.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 06:38:07 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] KVM: selftests: exercise userfaultfd minor
 faults
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20210519200339.829146-1-axelrasmussen@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8122c08a-67ab-47c0-99ab-5788c37a4166@redhat.com>
Date:   Mon, 24 May 2021 15:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/21 22:03, Axel Rasmussen wrote:
> Base
> ====
> 
> These patches are based upon Andrew Morton's v5.13-rc1-mmots-2021-05-13-17-23
> tag. This is because this series depends on:
> 
> - UFFD minor fault support for hugetlbfs (in v5.13-rc1) [1]
> - UFFD minor fault support for shmem (in Andrew's tree) [2]
> 
> [1] https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/
> [2] https://lore.kernel.org/patchwork/cover/1420967/
> 
> Changelog
> =========
> 
> v1->v2:
> - Picked up Reviewed-by's.
> - Change backing_src_is_shared() to check the flags, instead of the type. This
>    makes it robust to adding new backing source types in the future.
> - Add another commit which refactors setup_demand_paging() error handling.
> - Print UFFD ioctl type once in setup_demand_paging, instead of on every page-in
>    operation.
> - Expand comment on why we use MFD_HUGETLB instead of MAP_HUGETLB.
> - Reworded comment on addr_gpa2alias.
> - Moved demand_paging_test.c timing calls outside of the if (), deduplicating
>    them.
> - Split trivial comment / logging fixups into a separate commit.
> - Add another commit which prints a clarifying message on test skip.
> - Split the commit allowing backing src_type to be modified in two.
> - Split the commit adding the shmem backing type in two.
> - Rebased onto v5.13-rc1-mmots-2021-05-13-17-23.
> 
> Overview
> ========
> 
> Minor fault handling is a new userfaultfd feature whose goal is generally to
> improve performance. In particular, it is intended for use with demand paging.
> There are more details in the cover letters for this new feature (linked above),
> but at a high level the idea is that we think of these three phases of live
> migration of a VM:
> 
> 1. Precopy, where we copy "some" pages from the source to the target, while the
>     VM is still running on the source machine.
> 2. Blackout, where execution stops on the source, and begins on the target.
> 3. Postcopy, where the VM is running on the target, some pages are already up
>     to date, and others are not (because they weren't copied, or were modified
>     after being copied).
> 
> During postcopy, the first time the guest touches memory, we intercept a minor
> fault. Userspace checks whether or not the page is already up to date. If
> needed, we copy the final version of the page from the soure machine. This
> could be done with RDMA for example, to do it truly in place / with no copying.
> At this point, all that's left is to setup PTEs for the guest: so we issue
> UFFDIO_CONTINUE. No copying or page allocation needed.
> 
> Because of this use case, it's useful to exercise this as part of the demand
> paging test. It lets us ensure the use case works correctly end-to-end, and also
> gives us an in-tree way to profile the end-to-end flow for future performance
> improvements.
> 
> Axel Rasmussen (10):
>    KVM: selftests: trivial comment/logging fixes
>    KVM: selftests: simplify setup_demand_paging error handling
>    KVM: selftests: print a message when skipping KVM tests
>    KVM: selftests: compute correct demand paging size
>    KVM: selftests: allow different backing source types
>    KVM: selftests: refactor vm_mem_backing_src_type flags
>    KVM: selftests: add shmem backing source type
>    KVM: selftests: create alias mappings when using shared memory
>    KVM: selftests: allow using UFFD minor faults for demand paging
>    KVM: selftests: add shared hugetlbfs backing source type
> 
>   .../selftests/kvm/demand_paging_test.c        | 175 +++++++++++-------
>   .../testing/selftests/kvm/include/kvm_util.h  |   1 +
>   .../testing/selftests/kvm/include/test_util.h |  12 ++
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  84 ++++++++-
>   .../selftests/kvm/lib/kvm_util_internal.h     |   2 +
>   tools/testing/selftests/kvm/lib/test_util.c   |  51 +++--
>   6 files changed, 238 insertions(+), 87 deletions(-)
> 
> --
> 2.31.1.751.gd2f1c929bd-goog
> 

Queued, thanks (with region->fd moved to the right patch).

Paolo

