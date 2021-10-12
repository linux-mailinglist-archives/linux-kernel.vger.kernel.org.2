Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7232642B012
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhJLXXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhJLXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634080859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YWw1Q0O2bPasj7SCnF09IYwhm+YOxcxGZBuzn6oinI=;
        b=dIcbcOUlTkWLJlbT62yHrcIR992DBbBn9FBAJmP/89WKya8iHCly12B+DQxS9bRZYIqZHb
        VzxsQSukIna4GZPij4ca5tEIOvYnJxXtzv+DeRoANp3luMn0xKILk2FX02ycV/OXNAlx7k
        TrIbywxLEdxfRhq17nI2TN4InE7bK+A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-u__ptx2BO-mKkQ98yk9xNA-1; Tue, 12 Oct 2021 19:20:58 -0400
X-MC-Unique: u__ptx2BO-mKkQ98yk9xNA-1
Received: by mail-pg1-f197.google.com with SMTP id d6-20020a63d646000000b00268d368ead8so342189pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0YWw1Q0O2bPasj7SCnF09IYwhm+YOxcxGZBuzn6oinI=;
        b=GKqoF6i42vgkh38P5Rzoasz1vHoEIhCgK82WJsJ+G64avU0vUvCrIZFtnd3JwGSOFp
         AfOKnNriatgRD4n5dLhFAvT/e2xRLvKuVGh6nTWFVRk6qVANabtOOBZwDHKgCA0l+G73
         cIKpfmklB/R0fQr8rq+6206AwglzRygzDXxl1fO4kMVI5+Bef+OgbFfG+DtYrXUPdq4v
         diF0+sziLLRP/ewL+vfbaE+Zo88MV0ElzkhDFEpl7ed9BSgN73r0jYOcat+tfrpViNvA
         oP49WuLGus0nbFb84dbLo+5vyv2LCkJkRCFdOmsPrzibdnuUTWsFl2B4/4FMf/56oDak
         vnYw==
X-Gm-Message-State: AOAM5303mtEszuYe9QeAbyIQc6QlxQXsi8XrHUDe80kbHCoe0Z4K3vUX
        yRoqHvxj0clY0NIi6PeIUM9yhYjsEs0VQiOYYRF1FGUemx58ry5mfkYBmL385S7uPpraASkCNDu
        G89EDcslswJR/2PF3ELcHftbl
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr9309056pjb.22.1634080856905;
        Tue, 12 Oct 2021 16:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmOhwcb0Oa2rArtwbCqQ7Ouy966RmprkJtGRyDEc5YCYE6ThfeIsNh32iMYC6n30dLqnoSSA==
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr9308996pjb.22.1634080856460;
        Tue, 12 Oct 2021 16:20:56 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v2sm3938258pje.15.2021.10.12.16.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:20:55 -0700 (PDT)
Date:   Wed, 13 Oct 2021 07:20:48 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
Message-ID: <YWYYUOy0W8z5SVKh@t490s>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com>
 <YWVgdmKIFnZcgjeY@t490s>
 <2CED2F72-4D1C-4DBC-AC03-4B246E1673C2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2CED2F72-4D1C-4DBC-AC03-4B246E1673C2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:31:45AM -0700, Nadav Amit wrote:
> 
> 
> > On Oct 12, 2021, at 3:16 AM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > On Sat, Sep 25, 2021 at 01:54:22PM -0700, Nadav Amit wrote:
> >> @@ -338,25 +344,25 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
> >> 	struct mm_struct *mm = vma->vm_mm;
> >> 	pgd_t *pgd;
> >> 	unsigned long next;
> >> -	unsigned long start = addr;
> >> 	unsigned long pages = 0;
> >> +	struct mmu_gather tlb;
> >> 
> >> 	BUG_ON(addr >= end);
> >> 	pgd = pgd_offset(mm, addr);
> >> 	flush_cache_range(vma, addr, end);
> >> 	inc_tlb_flush_pending(mm);
> >> +	tlb_gather_mmu(&tlb, mm);
> >> +	tlb_start_vma(&tlb, vma);
> > 
> > Pure question:
> > 
> > I actually have no idea why tlb_start_vma() is needed here, as protection range
> > can be just a single page, but anyway.. I do see that tlb_start_vma() contains
> > a whole-vma flush_cache_range() when the arch needs it, then does it mean that
> > besides the inc_tlb_flush_pending() to be dropped, so as to the other call to
> > flush_cache_range() above?
> 
> Good point.
> 
> tlb_start_vma() and tlb_end_vma() are required since some archs do not
> batch TLB flushes across VMAs (e.g., ARM).

Sorry I didn't follow here - as change_protection() is per-vma anyway, so I
don't see why it needs to consider vma crossing.

In all cases, it'll be great if you could add some explanation into commit
message on why we need tlb_{start|end}_vma(), as I think it could not be
obvious to all people.

> I am not sure whether that’s the best behavior for all archs, but I do not
> want to change it.
> 
> Anyhow, you make a valid point that the flush_cache_range() should be
> dropped as well. I will do so for next version.

Thanks,

-- 
Peter Xu

