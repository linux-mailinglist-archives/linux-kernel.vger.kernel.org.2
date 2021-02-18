Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB731F24E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBRW3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:29:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbhBRW32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613687281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Gh0fQKYNE13oRLVxmJHOfFd0TiAqjga28s6fBv9MLw=;
        b=L6J5hzDiAIPm2sbuy3ZUPbsISDwgkK/2+e/HCzUHI1CQcvGhHV90yEehfXjpOYjtMwqF9f
        gEf5FrAA40K8gD9k30W0s9n6hEP6vRYGwoQbasv/7lakv9oLN8C2gX1iCjH/hCksFL3dR7
        BlOlq0qMsFtMMti+zBYW0qwdEuxMwE0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-XpS7_D7rPiii0ghCMytXlw-1; Thu, 18 Feb 2021 17:27:59 -0500
X-MC-Unique: XpS7_D7rPiii0ghCMytXlw-1
Received: by mail-qk1-f197.google.com with SMTP id p27so2272694qkp.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 14:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Gh0fQKYNE13oRLVxmJHOfFd0TiAqjga28s6fBv9MLw=;
        b=OXZr3B9MAAcd7/uX1K29qIksiYv3/7Eqvc4yoTmx5c8q5uhJzUugCee/6nuT5+jxAH
         S35s/9MzbVwYyuqhjPYlb3VHiaNomUwRwobDqpHT9FZnHz3o8BnZTGyHxd9RIP2PRIJm
         gAHi6C6uJCXI23FwAN2WW5OC3xGWnRvKAflc6ofJuNFmikMySXSiuuFeFNasTAEP7Kdo
         TysUHJGrlBA0fAJuj84dRgvUs8rGL27Wex0E4xY+yVd2Atii1dsT/DlRJLPTrYyQZeam
         NpxLmFTlwg9KHmrUB3Qys06RC6krfQkSLpP/wqSwVtzF7XycAl9FPFFEIy1AxWbl9oco
         tmXg==
X-Gm-Message-State: AOAM530oFPieO7oOkEtb8O2VmbGoCg27OtPIdt6cC2lxCW3Szg596uRw
        liH23v2O63CEuu9DYsLROA4+ldB04k84lBlkA2+eql2Yc8Mq6gUAHifuogiavMqdOUvDatUsv9V
        SaRYKdegTF9tM2+G0ZqtXWuET
X-Received: by 2002:a05:620a:152f:: with SMTP id n15mr6828957qkk.268.1613687279419;
        Thu, 18 Feb 2021 14:27:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylhqnAtyNTelfvh8u//NliFjzQC869yB+0HPkzNfmFa04/pEhRfrGw0TQ+J8SQUzuX34QLLA==
X-Received: by 2002:a05:620a:152f:: with SMTP id n15mr6828940qkk.268.1613687279215;
        Thu, 18 Feb 2021 14:27:59 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id d198sm5059518qke.69.2021.02.18.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 14:27:58 -0800 (PST)
Date:   Thu, 18 Feb 2021 17:27:57 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 1/4] hugetlb: Pass vma into huge_pte_alloc() and
 huge_pmd_share()
Message-ID: <20210218222757.GA6669@xz-x1>
References: <20210218215434.10203-1-peterx@redhat.com>
 <20210218215434.10203-2-peterx@redhat.com>
 <76fee968-cfc2-787f-7e48-af781563756e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76fee968-cfc2-787f-7e48-af781563756e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 02:13:52PM -0800, Mike Kravetz wrote:
> On 2/18/21 1:54 PM, Peter Xu wrote:
> > It is a preparation work to be able to behave differently in the per
> > architecture huge_pte_alloc() according to different VMA attributes.
> 
> > diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> > index ad4b42f04988..97e0824fdbe7 100644
> > --- a/arch/sparc/mm/hugetlbpage.c
> > +++ b/arch/sparc/mm/hugetlbpage.c
> > @@ -280,6 +280,7 @@ unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift(*(pte_t *)&p
> >  unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift(pte); }
> >  
> >  pte_t *huge_pte_alloc(struct mm_struct *mm,
> > +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> >  			unsigned long addr, unsigned long sz)
> >  {
> >  	pgd_t *pgd;
> 
> Didn't kernel test robot report this build error on the first patch series?

That seems to be irrelevant of this series:

  arch/sparc/mm/hugetlbpage.c:269:22: error: 'huge_tte_to_size' defined but not used [-Werror=unused-function]

Thanks,

-- 
Peter Xu

