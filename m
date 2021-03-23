Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63AD346282
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhCWPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232716AbhCWPMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616512363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBrNnOv/McZM6LWQLKMPWqSfLeVDTkLLZJVsJZTyQog=;
        b=eOFTRPnDICj0n62VCvuevyiDHrthw8FpMFTpNXnv+ErlrXnDuJ6+FhdVHPuliJUOGXUuQR
        /pcuiic/hlR5Gan5t6A6N/t69L+bbbmlgTMquCho2eOzjfT5irqeS/7QXuCf8hdetK7R9l
        4FP/pYf7gf2REpmPTQjw9TC3sEm0s38=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-JOC3tFOZO32dLslpcadlXw-1; Tue, 23 Mar 2021 11:12:42 -0400
X-MC-Unique: JOC3tFOZO32dLslpcadlXw-1
Received: by mail-qv1-f70.google.com with SMTP id h12so1802771qvm.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBrNnOv/McZM6LWQLKMPWqSfLeVDTkLLZJVsJZTyQog=;
        b=G21wmANUeF/M3mmuuczLW3dUKy3weyOS64Ld55Ru81+Dp+4Hmcg9Z648fklddcUCsJ
         sNA/cAyCOdrIdFxVszGq8l6xiSUV+FqmppHvBLJlgb5djxcBnFsrjzUdMG4nXQIYjOei
         Vj5C+ZffaRLqxhzqjnpg3iXt3ZR++puqeRuKDZP0k/RxL5++1dHrK5DkIa/CrnwLuKZX
         OEOOngJ1CcekmlNcAUrKp0MHKUCqcR78POCJVgDTUbesO8sID++TMtHVna9oBLXXG6Rq
         5RMbpo7XjeyYhzCXcGvT0HWtChabxP55Dq4RfbKV6TimlwT7fZZeYh5FOfFaEQLk+SL+
         guLg==
X-Gm-Message-State: AOAM533pFuEijPsQFjmKwmRcVZbVvcRZfJGCj8RaaZoJfwjWfZ6QR8Uy
        xNerdTLqULiggQmD+F1F/QpHfjI5s+95gr+ZggeuGk85ft1NR/SxoePUkpaazVf6KotWn4rO8zw
        sZ45fE+3s16NmjYK54XxtOruc
X-Received: by 2002:ae9:f80b:: with SMTP id x11mr5818793qkh.220.1616512361490;
        Tue, 23 Mar 2021 08:12:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIxKNqPmHIOGxOtkXSkKplsktvQrDyjO7VlhcNoVyxe4fINJlGw1PBoCbrWrDxb/a6STrC0Q==
X-Received: by 2002:ae9:f80b:: with SMTP id x11mr5818753qkh.220.1616512361162;
        Tue, 23 Mar 2021 08:12:41 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id a2sm11185972qtj.76.2021.03.23.08.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:12:40 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:12:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] userfaultfd: Write protect when virtual memory range has
 no page table entry
Message-ID: <20210323151238.GD6486@xz-x1>
References: <20210319152428.52683-1-minhquangbui99@gmail.com>
 <YFhuDf6L7nkUoT7q@dhcp22.suse.cz>
 <YFiU9YWbYpLnlnde@kernel.org>
 <20210323024803.GA3365@local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323024803.GA3365@local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:48:03AM +0700, Bui Quang Minh wrote:
> On Mon, Mar 22, 2021 at 03:00:37PM +0200, Mike Rapoport wrote:
> > On Mon, Mar 22, 2021 at 11:14:37AM +0100, Michal Hocko wrote:
> > > Le'ts Andrea and Mike
> > > 
> > > On Fri 19-03-21 22:24:28, Bui Quang Minh wrote:
> > > > userfaultfd_writeprotect() use change_protection() to clear write bit in
> > > > page table entries (pte/pmd). So, later write to this virtual address
> > > > range causes a page fault, which is then handled by userspace program.
> > > > However, change_protection() has no effect when there is no page table
> > > > entries associated with that virtual memory range (a newly mapped memory
> > > > range). As a result, later access to that memory range causes allocating a
> > > > page table entry with write bit still set (due to VM_WRITE flag in
> > > > vma->vm_flags).
> > > > 
> > > > Add checks for VM_UFFD_WP in vma->vm_flags when allocating new page table
> > > > entry in missing page table entry page fault path.
> > > 
> > > From the above it is not really clear whether this is a usability
> > > problem or a bug of the interface.
> > 
> > I'd say it's usability/documentation clarity issue. 
> > Userspace can register an area with
> > 
> > 	UFFDIO_REGISTER_MODE_MISSING | UFFDIO_REGISTER_MODE_WP
> > 
> > and then it will be notified either when page table has no entry for a
> > virtual address or when there is a write to a write protected address.
> 
> Yes, you are right. I saw a patch from Peter to linux-man and saw that
> 
> 	"When there is only UFFDIO_REGISTER_MODE_WP registered, the userspace
> 	will not receive any message when a missing page is written"
> 
> It's my mistake that I didn't look at the documentation carefully when playing
> around.

If there's a mistake, it's me forgetting to write the document when the feature
landed.. :)

But still I think you raised a good point, and I was also serious when
proposing that UFFD_FEATURE_WP_UNALLOCATED idea, since indeed we had similar
issue as QEMU live snapshot e.g. when the guest enabled kernel init_on_free,
meanwhile virtio-balloon could have recycled the same zero page, then that zero
page could got replaced with some garbage page when saving the snapshot, while
we expect it to come back as strictly a zero page, since when the guest OS
reuse this page it'll skip zeroing it assuming it's a zero page.

QEMU plans to fix it using pre-faults as UFFDIO_COPY will complicate the live
snapshot framework, but UFFD_FEATURE_WP_UNALLOCATED should be more efficient.
It's just that we still needs to keep the old behavior.

I'll see whether I can prepare a patch for it shortly, with some test case too.

Thanks,

-- 
Peter Xu

