Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460C831F14D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhBRUou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:44:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231387AbhBRUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613680867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKbZPfRfjBxv5rHh9BbhUmOccS2Zox4zMDSygTP6AuE=;
        b=AmmBaZz38zcCtfWgSCCl9CerbVq8IyPMvOZoxP2fiV5qQxJa0VSprQx9Aj5TAXRPk2fTWj
        WQpsprWCHppKIjOQxsR6P2V9Ln2OyazS3oPD210Tj2dUK9UDOlMYMN4s6mRLTJ6RB9akdY
        NYjEMy9+JuhbeUsQVefL6yu4SOnWTcg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-rRpgagfyOUa2Iv7r8426Qw-1; Thu, 18 Feb 2021 15:41:05 -0500
X-MC-Unique: rRpgagfyOUa2Iv7r8426Qw-1
Received: by mail-qk1-f199.google.com with SMTP id n62so2097588qkn.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKbZPfRfjBxv5rHh9BbhUmOccS2Zox4zMDSygTP6AuE=;
        b=rm4NNSeI8w/0v+br7FrBynnZ9G9R4VKeJbqOcFTQZDE4pZbizAwWpYJe2Mg5rzvspt
         HYoBa7uXQ4FRVNBsYbjqEv74c5UnLw4ITDeDDzCEgUPQUmydfNUZO6HHZ5uNSfKUM3GR
         VjCbUBXaRrXnuTp9zlfCCX5m0sqiHLd1rnS75VWHbTdqRrtEQEDC0F717hGp8OYoxjpW
         Vd57AYM819/PegVvXTWUOxZtBaGBbsapJxCKTN/QRhRObRPOEhfeuwvvgOPLAlYd2y6A
         6RJ3x9+NI0kC4UxzS3fuDQiq5SIMN/Rj0+I+FxfPqOSvqYJRNtemm1kygJYeTCQRCaTv
         +xbQ==
X-Gm-Message-State: AOAM533btCcIBenDA3rane2UBXNFRr2vBHNmnspRdsHJWQOXJPyT75jr
        2mI/2SldZ19Uf8nPJ5u5mUjhOC37YXz/Q/0vt/sD72FAcPFylmYJXClGFqGSM48rh4eQPikiCiQ
        yvNdPJTIyeqSULQLxz3nKe3ec
X-Received: by 2002:a05:6214:883:: with SMTP id cz3mr6171948qvb.43.1613680865180;
        Thu, 18 Feb 2021 12:41:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyF+f1xE9yEhDOJG4UxtT+ns0Y+9xXv8zVq92FiKmu+S7nGjG/TECSJ03cYyFkcPvUaqLTCBQ==
X-Received: by 2002:a05:6214:883:: with SMTP id cz3mr6171931qvb.43.1613680865024;
        Thu, 18 Feb 2021 12:41:05 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id i5sm4083266qtw.3.2021.02.18.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:41:04 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:41:03 -0500
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
Message-ID: <20210218204103.GF108961@xz-x1>
References: <20210217204418.54259-1-peterx@redhat.com>
 <20210217204619.54761-1-peterx@redhat.com>
 <20210217204619.54761-3-peterx@redhat.com>
 <CAJHvVchtVtDHE2iJRAmraL+kbTezgfck0Mgj7xM+7U5yaJ5aCQ@mail.gmail.com>
 <20210218203214.GD108961@xz-x1>
 <CAJHvVch79WBzudS7BU5Lg2et4_2XQM=mEdW=YpbyX1QHHp=tQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVch79WBzudS7BU5Lg2et4_2XQM=mEdW=YpbyX1QHHp=tQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:34:55PM -0800, Axel Rasmussen wrote:
> On Thu, Feb 18, 2021 at 12:32 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Feb 18, 2021 at 10:32:00AM -0800, Axel Rasmussen wrote:
> > > > @@ -1448,6 +1449,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > >                 vma->vm_flags = new_flags;
> > > >                 vma->vm_userfaultfd_ctx.ctx = ctx;
> > > >
> > > > +               if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> > > > +                       hugetlb_unshare_all_pmds(vma);
> > >
> > > This line yields the following error, if building with:
> > > # CONFIG_CMA is not set
> > >
> > > ./fs/userfaultfd.c:1459: undefined reference to `hugetlb_unshare_all_pmds'
> >
> > Ouch..  Axel, you mean CONFIG_HUGETLBFS rather than CONFIG_CMA, am I right?
> 
> Surprisingly no, there's a "#ifdef CONFIG_CMA" line ~100 lines above
> where hugetlb_unshare_all_pmds is defined in hugetlb.c which causes
> this. My guess is that putting the function inside that block was
> accidental and it can just be moved.

Right, thanks for catching that, I actually need to fix both.  Thanks,

-- 
Peter Xu

