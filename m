Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E674339A64
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 01:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCMARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 19:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCMARZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 19:17:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39715C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 16:17:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so11498620pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 16:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNw8Nj4KXoR/ziuf+ULxcnou2kfkLDqlHRj4OHo0dSM=;
        b=ErMS8H6GO5f8z+jriPNWifU7B3tvasc2pwvwNhvcfmGpFIWFmmD8naAHUtK2nh6TcL
         mTMt/31FihG0jJqlunc/BmR4Wx1BL0AQm7acdBOX6ar1uIo1xlN5rdG1k2S09QBPnlkR
         paK6cSlOHcqPsdUT14Hv/qDAVqhw0JMKAE7QueBXxs4aWFTOz/AcHHGVCoMzMBN+qs07
         lIbIzSoM+wy+MnpyFGAWhP3TdJ3sUElTmAtzlnaeCRNhTrDMKusK4qq575oHQkkpgrmK
         3nEVElcLzujixeu3/pDVxqCwY5noCV/2VlyyLc6YPxSHNz30f2yhn8U9FC1gMdyP54vB
         WYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNw8Nj4KXoR/ziuf+ULxcnou2kfkLDqlHRj4OHo0dSM=;
        b=M/CNjyzYE8a+dbwk0xHOHSnsMuB0dwiYigWCcgeXuMKxGUrmMe4ycBMo5WQH7xtzcB
         AwvnkzIiBcLlhs4rjDLkS+34H+hEJFx4pADyMmqMsf1RIDBRPHAa0K9wgVIXHwbp/m/p
         w39n0qeuOiDSQ/y3LCaIi4RtJXNVjcDQkt9tvA9nd91cS46T7Qt9gGnP+/tRuo06wQ5I
         C3ZECyla2DpTA09YKjOKaMd6E7FHiWIsBfk8XPHoRvXadzfE3JMbjqxQOtdDhVLX5X+T
         CPgFie06FEL5s9wTh0SCh7xuIX3BZt7cYqOFgEBP8JYWFpDjb2eFHzoSuyT3H285e9n7
         gebA==
X-Gm-Message-State: AOAM533NxDaELANoHoNldm0w4Rz8QshdG0GCDiCSL5L5EriHyfpKJlU2
        l3fjuaArNlvNZIMaFgdgW/16uw==
X-Google-Smtp-Source: ABdhPJw8zx2Vm18vPZwVhmoiKZBNiELL5UQWGkGDZQyzPEStGzVWqCNcQ2H+h6SC2lG2S7AL1yqttw==
X-Received: by 2002:a17:90a:9f48:: with SMTP id q8mr843558pjv.53.1615594644508;
        Fri, 12 Mar 2021 16:17:24 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1a6:2eeb:4e45:756])
        by smtp.gmail.com with ESMTPSA id jt21sm3177316pjb.51.2021.03.12.16.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 16:17:23 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:17:17 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "wangyanan (Y)" <wangyanan55@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 03/15] KVM: selftests: Align HVA for HugeTLB-backed
 memslots
Message-ID: <YEwEjQZZJXvNWYna@google.com>
References: <20210210230625.550939-1-seanjc@google.com>
 <20210210230625.550939-4-seanjc@google.com>
 <eac3f8b1-0e5b-395f-7fd7-75409554bffc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac3f8b1-0e5b-395f-7fd7-75409554bffc@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021, wangyanan (Y) wrote:
> Hi Sean,
> 
> On 2021/2/11 7:06, Sean Christopherson wrote:
> > Align the HVA for HugeTLB memslots, not just THP memslots.  Add an
> > assert so any future backing types are forced to assess whether or not
> > they need to be aligned.
> > 
> > Cc: Ben Gardon <bgardon@google.com>
> > Cc: Yanan Wang <wangyanan55@huawei.com>
> > Cc: Andrew Jones <drjones@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Aaron Lewis <aaronlewis@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   tools/testing/selftests/kvm/lib/kvm_util.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 584167c6dbc7..deaeb47b5a6d 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -731,8 +731,11 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
> >   	alignment = 1;
> >   #endif
> > -	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
> > +	if (src_type == VM_MEM_SRC_ANONYMOUS_THP ||
> > +	    src_type == VM_MEM_SRC_ANONYMOUS_HUGETLB)
> Sorry for the late reply, I just returned from vacation.

At least you had an excuse :-)

> I am not sure HVA alignment is really necessary here for hugetlb pages.
> Different from hugetlb pages, the THP pages are dynamically allocated by
> later madvise(), so the value of HVA returned from mmap() is host page size
> aligned but not THP page size aligned, so we indeed have to perform
> alignment.  But hugetlb pages are pre-allocated on systems. The following
> test results also indicate that, with MAP_HUGETLB flag, the HVA returned from
> mmap() is already aligned to the corresponding hugetlb page size. So maybe
> HVAs of each hugetlb pages are aligned during allocation of them or in mmap()?

Yep, I verified the generic and arch version of hugetlb_get_unmapped_area() that
KVM supports all align the address.  PARISC64 is the only one that looks suspect,
but it doesn't support KVM.

> If so, I think we better not do this again here, because the later
> *region->mmap_size += alignment* will cause one more hugetlb page mapped but
> will not be used.

Agreed.  I think I'll still add the assert, along with a comment calling out
that HugetlB automatically handles alignment.

Nice catch, thanks!
