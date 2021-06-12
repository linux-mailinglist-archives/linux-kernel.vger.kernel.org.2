Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FB3A4D82
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFLIWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 04:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFLIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 04:22:30 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 01:20:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id t6so11957166qvp.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8Ty9jamoqByHuZWkQK+ZAkMj0mCrAvr4/YXGaEPbHdY=;
        b=VAX83o2uXpqSrAe/XPT+KXdM+CEpb/6+4lyVBICHZdn6URf2MvQ890CUj6yRrCz2o4
         2BThAJAtpl5nRIrlGqiLB+0FwkoowFsYJZVroQ6MnLAmUPFKSSS5hjgSl1iQ8qODzZPW
         xdl2I+xtR80WvlbvBEnZ4HB2+KvFHahSI2NpOt5O2wGXQAdsrt5gAkRC0VbIpxUQtH4+
         qQ2koUQLord7TdV3gUCwAq/Yf7MEniy8TG5LTIYPHy5l32uTiurYZWqig8Fe5gUWnr8+
         hwYsqLsemlYQWvJOnhVq6QrUnzqoVz4tezMDVPP/T4mtjCJZwECzjZ/wFy1hiK9HDH3i
         1XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8Ty9jamoqByHuZWkQK+ZAkMj0mCrAvr4/YXGaEPbHdY=;
        b=fO0E7Id/KLULFi+jYZ8RuS6c8ce5biW77/52EYqHLGVQhprO+0xSJ8jbc5FXOR9PF+
         pZAstsD7YoQTRL4zbGp70PWwoCF4n06lTf/OVfazL/hNEC86DyLKb9LMFmJz9fu0SzS1
         GD2u/q2ToAT84fP92+rN0hRb68ql/PUM1nczI4BH4q/qKclPF7brTn6LH5AXiSVaHCF2
         garw6RD1cIdmEvhGx5GNuD+zeqs+UzgTZn5GJX7q24YUWccn8/Q8aqXRM+iXhp1/G+0F
         aVCBJEd93t4M8Ooqt6YGMwPoRsOW9IbXxFUvvtN+DRprc0dctE21lUYLg5vl4yhgBKLv
         tvJA==
X-Gm-Message-State: AOAM53360qyZC11MtJQXXrFOHaMewZgEYFnAqWkNO0QhUdjLDvbJlYyY
        7GpHGYIqdveoqrvTMm8vaBeCyA==
X-Google-Smtp-Source: ABdhPJyx7HmXzZGSNCp+6dPE7DmcqQ6LohKYAfEK1ahFCzIEj8HSnzIXWW9zNT/rDZR2ECPx+AbRuA==
X-Received: by 2002:ad4:424b:: with SMTP id l11mr8746847qvq.58.1623486029784;
        Sat, 12 Jun 2021 01:20:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 16sm5617049qtt.19.2021.06.12.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 01:20:29 -0700 (PDT)
Date:   Sat, 12 Jun 2021 01:20:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alistair Popple <apopple@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] mm/thp: fix THP splitting unmap BUGs and
 related
In-Reply-To: <14130393.9bCoogeq7g@nvdebian>
Message-ID: <d645fe4c-2f9e-19fc-c6b0-c6d785854423@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com> <1697169.ADtCEf3Xva@nvdebian> <494c929d-5253-58b0-6329-dec8395199cc@google.com> <14130393.9bCoogeq7g@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021, Alistair Popple wrote:
> On Saturday, 12 June 2021 6:56:36 AM AEST Hugh Dickins wrote:

I wonder how I arrived in Queensland - ^^^^ must I quarantine?

> > >
> > > As to sending my rebased series I suppose it would be best to wait until
> > > linux-mm has been updated with whatever other fixes are needed before resending
> > > it based on top of that. So far rebasing on this series didn't require too many
> > > drastic changes to my v10 series. The most significant was to incorporate your
> > > changes to unmap_page(). The remaining were just adding the TTU_SYNC case to
> > > try_to_migrate{_one} and a single s/migration_entry_to_page/pfn_swap_entry_to_page/
> > > in huge_memory.c
> > 
> > Yes, I think that's it.  But check your try_to_migrate_one(), it may
> > want the same range.end vma_address_end() mod I made in try_to_unmap_one().
> > 
> > And does try_to_migrate_one() still have a comment referring to
> > try_to_unmap() when it should say try_to_migrate() there?
> 
> Thanks for the pointers, I had caught both those as well.
> 
> > I've now located the diffs I missed from sending akpm before,
> > and diffed the diffs, and those are the points I see there;
> > but sending them now will just be a waste of everyones time.
> > No substitute for me checking your end result when it comes,
> > though I fear to do so since there's much more in your series
> > than I can wrap my head around without a lot more education.
> 
> The first few patches in the series (and the ones with conflicts) are
> clean-ups, so shouldn't change any behaviour. I'm reasonably confident I caught
> everything  but would certainly appreciate you checking the end result in the
> early patches when I post just to make sure I didn't miss anything. Thanks.
> 
> Also I have been getting bounce responses trying to deliver mail to linux-mm
> in case anyone is wondering why these might not be showing up on the mailing
> list. Looks to be some kind of mail loop, but not sure if it's at my end or
> somewhere else.

linux-mm@kvack.org has been having trouble recently.

See https://lore.kernel.org/linux-mm/YMJrk81oZa5ArWPw@cmpxchg.org/

There are more messages in that thread, but only one has got out.

Hugh
