Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA483A179F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbhFIOpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233970AbhFIOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623249822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hrjd0vAHqmk1gDJJdLOYF6cPc1MLvKQtTt47CRg14Ds=;
        b=FS7AjBO4TGxZEIJuu7vpXL7NyU4qstLTsqEAC+buKsJSnc6jPQ76roNxur33IYJ9J5nnIY
        +EfmRNtFLhPPrwFR9XNvgd89ga4v4cx++Hp2+PQLTv1pvKkDsOTIEyznynwdAsmfI5Iduj
        kN6Ru+Prig3zfVvdRofNJnOGHCIpj8g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-ifqYG2V5PJaWvZ1zumSIJQ-1; Wed, 09 Jun 2021 10:43:41 -0400
X-MC-Unique: ifqYG2V5PJaWvZ1zumSIJQ-1
Received: by mail-qk1-f200.google.com with SMTP id q207-20020a3743d80000b02903ab34f7ef76so577462qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hrjd0vAHqmk1gDJJdLOYF6cPc1MLvKQtTt47CRg14Ds=;
        b=baLnQGEGT9zhn/86JKWcMnSfR7S90g6i5C9DjqiSbfsJGG1JwvuhOOjJ6XZpzvJWgF
         rc9QqXpiskRZNoGS83seK+/zVJ2OLhQyuNiv5XhP41Iv6mn2omLAM+/xFSg/5teNeQGP
         esxwDfqtIIMCVqDty7tsZlVhvd27K2Zo7iJZzjE+00+aG/+kO9ObT+Qj9TaI+qQpC0TZ
         EoraMN8k0c5/zsWfcAqgLKHpjHsGkXkFDmtnrjVxjz6GEBgva6dfvdcHoaQ20A/dUBoV
         CHTZzCS3W7j/HltXqyXKTEzUrZymRX8gXYYWifbuf/2c/dx/IKRextxL441jU37zlA/a
         PNOg==
X-Gm-Message-State: AOAM530e9flx/xTEVPWPBgvOVvJlUeCyxi0eM5h1TzMq+PI7WJxaefhI
        GGIanHzTLbTZnnE54BUT2aVg+aoIFEGtvd4IKXPapx5ZhtAHXKSHiciT5KOlSKIgvJrPN+sQA9R
        at+MR6ptgYQ6QQjCmrm5yOFtG
X-Received: by 2002:a05:620a:1272:: with SMTP id b18mr15787591qkl.82.1623249819669;
        Wed, 09 Jun 2021 07:43:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvfpN1NcM9Fj56PO+RMrhMow2+zD6jj3I+p6YzQj0glPLbzqgroksliu2gRQR8EH4SKk/e4g==
X-Received: by 2002:a05:620a:1272:: with SMTP id b18mr15787570qkl.82.1623249819431;
        Wed, 09 Jun 2021 07:43:39 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id b123sm184851qke.87.2021.06.09.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:43:38 -0700 (PDT)
Date:   Wed, 9 Jun 2021 10:43:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/27] mm/userfaultfd: Introduce special pte for
 unmapped file-backed mem
Message-ID: <YMDTmd/XVITpJgCd@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <20210527201927.29586-5-peterx@redhat.com>
 <2227669.OCfziWJ48r@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2227669.OCfziWJ48r@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:06:32PM +1000, Alistair Popple wrote:
> On Friday, 28 May 2021 6:19:04 AM AEST Peter Xu wrote:
> 
> [...]
> 
> > diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
> > index 828966d4c281..95e9811ce9d1 100644
> > --- a/include/asm-generic/pgtable_uffd.h
> > +++ b/include/asm-generic/pgtable_uffd.h
> > @@ -2,6 +2,9 @@
> >  #define _ASM_GENERIC_PGTABLE_UFFD_H
> >  
> >  #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> > +
> > +#define  UFFD_WP_SWP_PTE_SPECIAL  __pte(0)
> > +
> >  static __always_inline int pte_uffd_wp(pte_t pte)
> >  {
> >  	return 0;
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 331d2ccf0bcc..93f932b53a71 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -145,6 +145,17 @@ extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> >  extern void userfaultfd_unmap_complete(struct mm_struct *mm,
> >  				       struct list_head *uf);
> >  
> > +static inline pte_t pte_swp_mkuffd_wp_special(struct vm_area_struct *vma)
> > +{
> > +	WARN_ON_ONCE(vma_is_anonymous(vma));
> > +	return UFFD_WP_SWP_PTE_SPECIAL;
> > +}
> > +
> > +static inline bool pte_swp_uffd_wp_special(pte_t pte)
> > +{
> > +	return pte_same(pte, UFFD_WP_SWP_PTE_SPECIAL);
> > +}
> > +
> 
> Sorry, only just noticed this but do we need to define a different version of
> this helper that returns false for CONFIG_HAVE_ARCH_USERFAULTFD_WP=n to avoid
> spurious matches with __pte(0) on architectures supporting userfaultfd but not
> userfaultfd-wp?

Good point.. Yes we definitely don't want the empty pte to be recognized as the
special pte..  I'll squash below into the same patch:

----8<----
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 489fb375e66c..23ca449240d1 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -177,7 +177,11 @@ static inline pte_t pte_swp_mkuffd_wp_special(struct vm_area_struct *vma)
 
 static inline bool pte_swp_uffd_wp_special(pte_t pte)
 {
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
        return pte_same(pte, UFFD_WP_SWP_PTE_SPECIAL);
+#else
+       return false;
+#fi
 }
 
 #else /* CONFIG_USERFAULTFD */
----8<----

I'll see whether I can give some dry run without HAVE_ARCH_USERFAULTFD_WP but
with USERFAULTFD.

Thanks for spotting that!

-- 
Peter Xu

