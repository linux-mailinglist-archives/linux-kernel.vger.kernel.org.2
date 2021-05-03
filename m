Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9503722F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 00:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhECWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhECWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620080682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfXlABNT0XMdR0g/quQP485ZWtoQvq/HkgRK7ZDKv9o=;
        b=czIxfw0FhF4Y/HKL/cP0b4qgVn4zf2dHRJ12+VdyAe0gKbaGhVYIHpE1x47uyUbNBKxqhS
        chxnVw8/z1hRkzhcMMD+X6cZKAtqlY0QWxpJgzePykT2VUwEjsl9mKm1YHQXZK5BpI25gW
        bX+sbubaEBKCbhiWzPs7KJ3gWg6nQHw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-PTJbCAJ9OC--WYm2Tts3qw-1; Mon, 03 May 2021 18:24:40 -0400
X-MC-Unique: PTJbCAJ9OC--WYm2Tts3qw-1
Received: by mail-qk1-f197.google.com with SMTP id v7-20020a05620a0a87b02902e02f31812fso6232779qkg.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 15:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfXlABNT0XMdR0g/quQP485ZWtoQvq/HkgRK7ZDKv9o=;
        b=qYLwRXfNjuwDPNz77WvLafVQ+zsPNwwwNPPpclXJKEB7kRN4MnCpGHnh31y72l/uBj
         1RiaX62eNGx8UJTQt9r22wFES1pfOfU+o7HH0BAQVP0jLy79RiEHmBbZZObs/LPvPqIw
         l9q+ZjLZNTz4zSs8O/edBCn1XroUQKMzdHvJuCIQNH5YW2fcWuRToO0FiuQR+JY3cDyT
         UbawLgCj5FGOCK0qqEPBZVMAJMgGTVU+N5SuN57lSwcBAD+I9bdACN8/dJ+ADxPHOMOS
         CF/KnFf09yOL5K8CuCDseMgVqG2PiYIYAbxtCP/bEM5MuHmyw/F+hgQlVEpI4HmrB3Wp
         Eb1Q==
X-Gm-Message-State: AOAM533kv+zH4kCp5xe0+gHT9CbIwmYePfy7CRrcSWr577Y4fAlu81Ew
        oZ8raheZfVbCb/nVpdI8zSe19WYH50QMNPZAhi81i3QLK95deaznEIf6MLOUlMJCcGSP7FkGWjA
        mMuieGS2UBIEw+1Fl/5UnaNIz
X-Received: by 2002:ac8:794a:: with SMTP id r10mr6978088qtt.269.1620080680258;
        Mon, 03 May 2021 15:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVZ4Mb52E5DKFssQjCxbqFKR7FfysyNzYLDwdTFRUFL6hA2eyD9w5BXrKbwWLIcLnyESj7qA==
X-Received: by 2002:ac8:794a:: with SMTP id r10mr6978064qtt.269.1620080679984;
        Mon, 03 May 2021 15:24:39 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 189sm6971846qkh.99.2021.05.03.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 15:24:39 -0700 (PDT)
Date:   Mon, 3 May 2021 18:24:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: Fix cow where page writtable in child
Message-ID: <YJB4JsfITjmddVuJ@t490s>
References: <20210501144110.8784-1-peterx@redhat.com>
 <20210501144110.8784-3-peterx@redhat.com>
 <c69c12d6-1615-e528-37a7-4776abfc7200@oracle.com>
 <YJBt+61zIh9wOCaq@t490s>
 <ba559981-326c-3c96-3885-fe2826f8d34e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba559981-326c-3c96-3885-fe2826f8d34e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 03:10:04PM -0700, Mike Kravetz wrote:
> On 5/3/21 2:41 PM, Peter Xu wrote:
> > On Mon, May 03, 2021 at 01:53:03PM -0700, Mike Kravetz wrote:
> >> On 5/1/21 7:41 AM, Peter Xu wrote:
> >>> When fork() and copy hugetlb page range, we'll remember to wrprotect src pte if
> >>> needed, however we forget about the child!  Without it, the child will be able
> >>> to write to parent's pages when mapped as PROT_READ|PROT_WRITE and MAP_PRIVATE,
> >>> which will cause data corruption in the parent process.
> >>>
> >>> This issue can also be exposed by "memfd_test hugetlbfs" kselftest (if it can
> >>> pass the F_SEAL_FUTURE_WRITE test first, though).
> >>>
> >>> Signed-off-by: Peter Xu <peterx@redhat.com>
> >>> ---
> >>>  mm/hugetlb.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>
> >> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > Thanks!
> > 
> >>
> >> I think we need to add, "Fixes: 4eae4efa2c29" as this is now in v5.12
> > 
> > I could be mistaken, but my understanding is it's broken from the most initial
> > cow support of hugetlbfs in 2006...  So if we want a fixes tag, maybe this?
> > 
> > Fixes: 1e8f889b10d8d ("[PATCH] Hugetlb: Copy on Write support")
> > 
> 
> Here is why I think it was broken in 4eae4efa2c29.  Prior to that commit
> the code looked like this:
> 
> 			if (cow) {
> 				/*
> 				 * No need to notify as we are downgrading page
> 				 * table protection not changing it to point
> 				 * to a new page.
> 				 *
> 				 * See Documentation/vm/mmu_notifier.rst
> 				 */
> 				huge_ptep_set_wrprotect(src, addr, src_pte);
> 			}
> 			entry = huge_ptep_get(src_pte);
> 			ptepage = pte_page(entry);
> 			get_page(ptepage);
> 			page_dup_rmap(ptepage, true);
> 			set_huge_pte_at(dst, addr, dst_pte, entry);
> 			hugetlb_count_add(pages_per_huge_page(h), dst);
> 
> After setting the wrprotect in the source pte, we 'huge_ptep_get' the
> source to create the destination.  Hence, wrprotect will be set in the
> destination as well.  It is perhaps not the most efficient, but
> I think it 'works'.
> 
> It is subtle, or am I missing something?

You're right, thanks Mike.  I'll repost and add correct fixes tag.

-- 
Peter Xu

