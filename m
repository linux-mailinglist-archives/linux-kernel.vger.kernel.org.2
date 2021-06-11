Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C79C3A48B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFKSce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:32:34 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34395 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhFKScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:32:33 -0400
Received: by mail-qt1-f173.google.com with SMTP id u20so3321859qtx.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=R3/bZmc/2oRYUixC5sfqXgndBfX+63qIUoOn/uEOHzQ=;
        b=I2j3LT7aKYn+ANT5pbafCkF2sayfC0VCJvWXdkKlLVSXC6Dhf1d13YQEdH/ZbF1ScN
         YNPpP/ZGdnPzwLPxqEFah/IYqV3wDlEoqP+NA57tK3TeUZdaIAnrNyl0Nj800VrsU6Po
         2wrtE3PWKznkohRLLAmT6Y/HHbs6BRRf9xCSA+eRUCYmACHDIyINJ6EvDoegU9i6ldA3
         4KJW57r7WdzYAXydGEtPHZEAVm8bkYNKyvlIQmCYUvtthOGgWWnTL86irMDF8m/b8cNK
         29vVEfbB5uauOr51nfNdVeEBvLAVAYOh6yYDr0RsspqtZXtZazEgv2IDnp8GQX1rSpq4
         ksdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=R3/bZmc/2oRYUixC5sfqXgndBfX+63qIUoOn/uEOHzQ=;
        b=C5skSgUFnQsYjF9E2XBcuz5H5hg3EClFlxGpWbF6hGv0uKxAOhJPg4Nh1blfSBcZsa
         YEk5RM+nNiVd0JvbdbuVb/at8rRlyVo63szyLTsWGfiM21GaNHyT+GyK8kRNQyOkRS9O
         VO0H2WNAwPxS6ze45Fl6s64Jx09Ra+SoxqB61fSP4Cb8obHvLGszyDk695a+xRxb3fUB
         vLhPYb9bMc9I2JOMQkXbMp836vdlyt3qEuXOb1ULXg3O0oqh5rJR1DKVmXWx5By4wmEv
         GDMU8679Bqq5enaDtG9vM77GFEHepJbxW9yCh11JIZNd3oLv2lFkjdaV/vJuzsQ2dGDI
         rCDA==
X-Gm-Message-State: AOAM532HGlqACuR/TIfCGu8TSQKzH7ZsKKUYTeOOCHVPyzVqg7/hparN
        0AxiDX2OOMZ96WXapTvL80/MiQ==
X-Google-Smtp-Source: ABdhPJyP23lf64RTAXieIb9F/w8DuLfx38le4LM3kneK8MfZ/n4W5pWHCVIv8hyLF/5DbmIb9ZDaMw==
X-Received: by 2002:ac8:1113:: with SMTP id c19mr5051056qtj.348.1623436174563;
        Fri, 11 Jun 2021 11:29:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g24sm4554521qts.60.2021.06.11.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:29:34 -0700 (PDT)
Date:   Fri, 11 Jun 2021 11:29:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] mm/thp: another PVMW_SYNC fix in
 page_vma_mapped_walk()
In-Reply-To: <20210610094312.kzhhqyz4abe2yizg@box.shutemov.name>
Message-ID: <3f16d6ce-44ec-6d9e-d64-d7f750dc632@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com> <1bdf384c-8137-a149-2a1e-475a4791c3c@google.com> <20210610094312.kzhhqyz4abe2yizg@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021, Kirill A. Shutemov wrote:
> On Wed, Jun 09, 2021 at 11:54:46PM -0700, Hugh Dickins wrote:
> > Aha!  Shouldn't that quick scan over pte_none()s make sure that it holds
> > ptlock in the PVMW_SYNC case?  That too might have been responsible for
> > BUGs or WARNs in split_huge_page_to_list() or its unmap_page(), though
> > I've never seen any.
> > 
> > Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: <stable@vger.kernel.org>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks Kirill.

And Wang Yugui has now reported the good news, that this afterthought
patch finally fixes the unmap_page() BUGs they were hitting on 5.10.

Andrew, please add a link to
https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
and
Tested-by: Wang Yugui <wangyugui@e16-tech.com>

Thanks,
Hugh
