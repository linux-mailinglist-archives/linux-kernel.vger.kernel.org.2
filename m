Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A898445D26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhKEBEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231133AbhKEBEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636074104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6G9HPQ/emv9d7E8DEdmRVOijMc6XntyMaOnJpQd0Rb4=;
        b=YDbOzcpAY/Rl3zKwN6rrsSp8zp2oPARrGMFqcm33lrJTsZdew8ZwW5llAsHWR7/WkV6JmL
        0fXsxGubcDmNbAxhfMBFS/AD3q8VlL1jc0W+F1+dMRY6PBmD0hUQnuagKWIf4r1Wzh+V3U
        Z/LXWecq8wiFtcu/K58u3yN5YXGDW9s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-m0RNkGhtPs61acfT8c4xvQ-1; Thu, 04 Nov 2021 21:01:43 -0400
X-MC-Unique: m0RNkGhtPs61acfT8c4xvQ-1
Received: by mail-wr1-f71.google.com with SMTP id w14-20020adfbace000000b001884bf6e902so950578wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6G9HPQ/emv9d7E8DEdmRVOijMc6XntyMaOnJpQd0Rb4=;
        b=sBGsiw1clnTlWky7CnkM0ZDtoX9WZfQgUR5i019F5t0tYV8BkRbxyXRBW6SOltk6ae
         beZyVXNDc6hm62ROn58qtEQ4N1QRxcO0jmITxrLQeNTZgq+/2ZBHVU/HzWNIpzxB7gar
         EGJrMpdNEXyE9/wQ+SsHUw50AcWfuXZCAydGKaWA+YD2vpIjwqGYdWVLDK+rcRYZ1epS
         FoYGTUKM/PLBGxPc/xjSJRFRYN0Rt9EUa2dtI9fvPxs1qqVGSENhGOOch4r+NxFgh2Kx
         KID0G6ozzKxOsfoKTpuKmVujEsPaMLDnTaW9+/9ULl54t93pKqPLeS+1GLx1OIOwn0fL
         cTyg==
X-Gm-Message-State: AOAM533s+8tRhHBupV5/0/awsfdDA5lbLve7bWa0iE0u3RK9PxDrXo46
        lkWroWvjQvM/4K4AFUmkgwlDX+1CJqw9ihcWBCcVdc2/7RjNhVjk9hYkAfduFP44KkktF1TDjTD
        CeZ5/4U7BFr7dSP0Pnnjs/kpn
X-Received: by 2002:adf:9bcd:: with SMTP id e13mr26466749wrc.165.1636074101849;
        Thu, 04 Nov 2021 18:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS2XA17KQfu/AZsL6oOpqh0ZJcGrolZ6YsKssmQ5RJJXoY/6fp3PHwH2dABd2spdsFUBLIEw==
X-Received: by 2002:adf:9bcd:: with SMTP id e13mr26466717wrc.165.1636074101595;
        Thu, 04 Nov 2021 18:01:41 -0700 (PDT)
Received: from xz-m1.local ([85.203.46.190])
        by smtp.gmail.com with ESMTPSA id j19sm6402891wra.5.2021.11.04.18.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:01:41 -0700 (PDT)
Date:   Fri, 5 Nov 2021 09:01:32 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 1/4] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
Message-ID: <YYSCbJ46kxaz2Ms9@xz-m1.local>
References: <20210915181456.10739-1-peterx@redhat.com>
 <20210915181456.10739-2-peterx@redhat.com>
 <49fddb9a-4a52-1df-8b7c-dde2a89330bf@google.com>
 <YVI195OZ7t3i3n6t@t490s>
 <256c72c4-ac99-94fb-d76-fab08e5cf5f4@google.com>
 <YVOLG3NIlj+16IUh@t490s>
 <20211104143440.d0056137ee07d3e96d6b56ec@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104143440.d0056137ee07d3e96d6b56ec@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:34:40PM -0700, Andrew Morton wrote:
> On Tue, 28 Sep 2021 17:37:31 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > > How about a compromise (if you really want to continue with this patch):
> > > you leave the SetPageDirty(page) in shmem_mfill_atomic_pte(), where I
> > > feel a responsibility for it; but you do whatever works for you with
> > > pte_mkdirty() at the mm/userfaultfd.c end?
> > 
> > Sure.  Duplicating dirty bit is definitely fine to me as it achieves the same
> > goal as I hoped - we're still 100% clear we won't free a uffd page without
> > being noticed, then that's enough to me for the goal of this patch.  I won't
> > initiate that NACK myself since I still think duplicating is unnecessary no
> > matter it resides in shmem or uffd code, but please go ahead doing that and
> > I'll be fine with it, just in case Andrew didn't follow the details.
> 
> I think Hugh was asking you to implement this...
> 
> I guess I'll send this patch upstream.  But it does sound like Hugh
> would prefer a followon patch for this kernel release which makes the
> above change, please.

Thanks Andrew for helping.

But as I mentioned I still think that's odd to set dirty in both places.
That's why I don't want to draft the patch because I am not very willing to
sign-off..

If Hugh agrees, I can post the patch with Hugh's sign-off, adding the PageDirty
back too.  I am during a holiday so I cannot follow up the whole thing today,
but if it's easier for you to drop that patch or even drop the whole series,
please feel free to do.  I can rework everything too, then I'll try to get
Hugh's ack again on every single patch, as long as Hugh will have time to look
at it in the future.

Thanks,

-- 
Peter Xu

