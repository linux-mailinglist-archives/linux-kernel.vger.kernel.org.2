Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CC31F116
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBRUen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhBRUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613680338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4y8FXmFzZ7b7ZIO9V3YA0dBAoYUowK7ZKAVGSewkeQ4=;
        b=cq3wXRn/XPZrr7x613bGOTr5NOVRfEnR4WDoSGhh9+rMrhgP/je5rimD4JTlCc47E2wUBp
        Pe/icFcMbNcXCKyhntEBBIyQzXRkb8+KnVZV0OgCRdbF21Z3Y0TBFXNRD0+s9qZxe7rHNb
        vFIK8Y4DW03il/9MZQuXAqRty7VHgKM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-Ms3AUTsCOc2Ss6QqkSyLPA-1; Thu, 18 Feb 2021 15:32:17 -0500
X-MC-Unique: Ms3AUTsCOc2Ss6QqkSyLPA-1
Received: by mail-qt1-f197.google.com with SMTP id 22so1931742qty.14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4y8FXmFzZ7b7ZIO9V3YA0dBAoYUowK7ZKAVGSewkeQ4=;
        b=rNTpacfYrby1gxaNqmpQtohMLIvkCM8vCjUMYLnkyUXMbD4jrgi7B8FDusuHIZ4zX/
         dELFr4pQEX5cxFYrohlFGiOgBoEaGkNhX0G7TTm5sm+efBCN/NWW5/3yWyvPHuSFfqFs
         bB+78hiy0Q4BlRh3NUYbvBTAtF+y1k9KKoOJknUTvJBYim7l3CEVwSzvq5vdyV++0GCF
         hCGTF2wUE2CFmVy9laoVbWuuImkUKk5hvROdWUXrBOKOqDexYc3r0AOqR9JzTsRh39FY
         aVflVRzl2BVEnj+/4fuV9/5Obpkd9WCXVpeVVvwbn6ffprApAkVWT+0n1iWGPnkzHLgU
         3WGA==
X-Gm-Message-State: AOAM531yd0kIXRXui6pJswedRjzqUqQv4aUmdlpbUjAvfAloJD84K9kL
        3/p4b6wI9qZEKL3jK49m43F/niQbq5KWXsfu6hzGTX1khFOYQWh4RXrn/KN42c3zkCYbVWmvZf9
        22AZ3xruyB5nRBcPu1E/yNmD0
X-Received: by 2002:a05:620a:4152:: with SMTP id k18mr3813311qko.446.1613680336676;
        Thu, 18 Feb 2021 12:32:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuEAjdcbts6U/tROwOoN8WAsvUKddRotafUPo7arXZR/SHNd13h6QvZTEm/nKF+7xD9bx95Q==
X-Received: by 2002:a05:620a:4152:: with SMTP id k18mr3813291qko.446.1613680336457;
        Thu, 18 Feb 2021 12:32:16 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o3sm4578858qke.132.2021.02.18.12.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:32:15 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:32:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/4] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
Message-ID: <20210218203214.GD108961@xz-x1>
References: <20210217204418.54259-1-peterx@redhat.com>
 <20210217204619.54761-1-peterx@redhat.com>
 <20210217204619.54761-3-peterx@redhat.com>
 <CAJHvVchtVtDHE2iJRAmraL+kbTezgfck0Mgj7xM+7U5yaJ5aCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVchtVtDHE2iJRAmraL+kbTezgfck0Mgj7xM+7U5yaJ5aCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:32:00AM -0800, Axel Rasmussen wrote:
> > @@ -1448,6 +1449,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >                 vma->vm_flags = new_flags;
> >                 vma->vm_userfaultfd_ctx.ctx = ctx;
> >
> > +               if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> > +                       hugetlb_unshare_all_pmds(vma);
> 
> This line yields the following error, if building with:
> # CONFIG_CMA is not set
> 
> ./fs/userfaultfd.c:1459: undefined reference to `hugetlb_unshare_all_pmds'

Ouch..  Axel, you mean CONFIG_HUGETLBFS rather than CONFIG_CMA, am I right?

-- 
Peter Xu

