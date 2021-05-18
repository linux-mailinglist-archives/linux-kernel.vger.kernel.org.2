Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCAA38834C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhERXqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230088AbhERXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621381509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NyB3nRYXEIw9i58PAbApIYiWHD6bmSqOFX83eNLmrgQ=;
        b=L23rmrEU7y+LtH+385bATlZv4vdTC+aY0qDj2XLeoC2nWIcZcUQ+d6bNyWz65/p9qUcacg
        4QCQXY0G9itvCftdHheyKFx9ddzWvhSwUEQ4qbyG7gIibHXQUElByZutKLqK+4ZFumMRAX
        YX3BfxGVfIQB8gjADYes/PDuLFvEJLU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-vZNFEjmRMb-fME-QsHCLUg-1; Tue, 18 May 2021 19:45:08 -0400
X-MC-Unique: vZNFEjmRMb-fME-QsHCLUg-1
Received: by mail-qt1-f197.google.com with SMTP id j12-20020ac8550c0000b02901dae492d1f2so8602595qtq.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyB3nRYXEIw9i58PAbApIYiWHD6bmSqOFX83eNLmrgQ=;
        b=VYXmzVGZgBGIaY1vWYyswfQqzHVLPqTc7gXwQlqcdgcyv2tpUKC0/ONlDhJvJQrOSK
         Hga0xJOPyy4/jpazo0N/0YRQ3mXBDZ6a108aqWpHSbzzLHnigTUkA3o1Dey2IvsWYFyN
         3yEpD5K6EyVHnEhu8+adq5xRrkRKp0OpbUZMOcMbEWZgRCN4aUZnyNikeZXlvSRoArIz
         6Lfkpszc7VD/s/vxKyk5BifxFtXdwIBten7CTJ1hN+VaztKawgwDH6BYl1BzYNWXaluS
         O/gdvreknetSXFTsNVdwP2A03rQbgjeoK2DJIzSyLI6bnL9Xyhl0PmUtK8DrE1DOvY9T
         S3WQ==
X-Gm-Message-State: AOAM531N4zaC1/T1SmyE4RNc8h6v7yMxnYAxA3l4TbG0MhVTiHBcUGGk
        VQEWAezXaGj1Q+fdgsPLksExfYrHqvqRv3rPWXhgcTiCdZLj75hGqlsFcv2BATkvAegTAJltoOH
        3tGm2QfUqV1383bzU3mR4KLRJ
X-Received: by 2002:a05:622a:350:: with SMTP id r16mr7491990qtw.27.1621381507345;
        Tue, 18 May 2021 16:45:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7ExMzzZXtIx7iGUTcSpCi16S7VAiLXsFhzha61Te2cv+Okvdh1uyfL/4TjC80GU7c5+ldwA==
X-Received: by 2002:a05:622a:350:: with SMTP id r16mr7491943qtw.27.1621381506771;
        Tue, 18 May 2021 16:45:06 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 7sm15927040qtu.38.2021.05.18.16.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:45:06 -0700 (PDT)
Date:   Tue, 18 May 2021 19:45:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jhubbard@nvidia.com, rcampbell@nvidia.com, jglisse@redhat.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKRRgZmRMdk1vH7A@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <20210407084238.20443-6-apopple@nvidia.com>
 <YKMhorngO2DVrxac@t490s>
 <47694715.suB6H4Uo8R@nvdebian>
 <YKP5Dj4Q/riGGc43@t490s>
 <20210518173334.GE1002214@nvidia.com>
 <YKQBACJCjsxeM3ro@t490s>
 <20210518194509.GF1002214@nvidia.com>
 <YKQjmtMo+YQGx/wZ@t490s>
 <20210518230327.GG1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518230327.GG1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 08:03:27PM -0300, Jason Gunthorpe wrote:
> Logically during fork all these device exclusive pages should be
> reverted back to their CPU pages, write protected and the CPU page PTE
> copied to the fork.
> 
> We should not copy the device exclusive page PTE to the fork. I think
> I pointed to this on an earlier rev..

Agreed.  Though please see the question I posted in the other thread: now I am
not very sure whether we'll be able to mark a page as device exclusive if that
page has mapcount>1.

> 
> We can optimize this into the various variants above, but logically
> device exclusive stop existing during fork.

Makes sense, I think that's indeed what this patch did at least for the COW
case, so I think Alistair did address that comment.  It's just that I think we
need to drop the other !COW case (imho that should correspond to the changes in
copy_nonpresent_pte()) in this patch to guarantee it.

I also hope we don't make copy_pte_range() even more complicated just to do the
lock_page() right, so we could fail the fork() if the lock is hard to take.

-- 
Peter Xu

