Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB4D42E4C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhJNXfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231143AbhJNXfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634254377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZP8SCmWhinsseT0tp+2aieN8jcGMf8lc14k0qLDaWm8=;
        b=VLEy+883w62zVI8COG6UMcNnA4KlYQ1Enyri+oWM/iJdK2wOE2FP12O/8HRHu/+M8c08db
        iiJMw5D7luZNLp1gw3iwhPPxYvii9KSWJGeOdlM3e8k87UeCBSiyMMxOltni7qsPWQMTm0
        8RanvvIfHQ4R+FXfh9szo14XMtod31I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-B5PHZ0ihMIyL7Vj6r2t-1Q-1; Thu, 14 Oct 2021 19:32:54 -0400
X-MC-Unique: B5PHZ0ihMIyL7Vj6r2t-1Q-1
Received: by mail-pj1-f71.google.com with SMTP id c10-20020a17090ab28a00b0019ce70ee349so3995508pjr.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZP8SCmWhinsseT0tp+2aieN8jcGMf8lc14k0qLDaWm8=;
        b=QHOI6nyvqTLGVD35bVMlR3DnYDn7AWkwrT7K+3zchrmxNOJILuZE40THNEKnwLmfHA
         7P6yjK68FOKxONnL4XTVG3zeBL/l0QdWfhm1GZss9gSnhwerIMfOik+QTaJd0gj+ysLE
         domdKKdcJS/Ns01BowSj2PqrW+on38mtsagmfp/MyQ5drPwPhGvERMQrKik9iZGHelk7
         FSlDvTm1s5VgXtGJ6mIXKrvugBAEJjNEWmatR9ESjv8l5dS2RD1yIaRsITZMwwm9oh0X
         IMt8ww6JhCSMbz3LDnLyRCqFpf4KiCNlGJyNQjCYiaMb0voj83s7rxVirsjtDkDefusq
         qCrQ==
X-Gm-Message-State: AOAM532lOu5F0Acwuql6IOlfplKFnzOVbhjJKP2r7AqoP0F3Wc6/7o6i
        2gBk8+gLpOp5gVBlpxC0HyNBaSMuRukJLkq6J7jp+JSpeuOrSiIciYh6udSh/ptgdUY3XVyHFkR
        T0qZ4HLBBklAggHiJnVggtFn8
X-Received: by 2002:a17:903:2304:b0:13f:2457:11dd with SMTP id d4-20020a170903230400b0013f245711ddmr7769793plh.57.1634254372923;
        Thu, 14 Oct 2021 16:32:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY0hpZ6BiVdnXclPKsGbq+0iJv6Y0KHCT1YVugxwer2zWJ6N9SUgmF8imhcDscSZzJwvWK4Q==
X-Received: by 2002:a17:903:2304:b0:13f:2457:11dd with SMTP id d4-20020a170903230400b0013f245711ddmr7769756plh.57.1634254372606;
        Thu, 14 Oct 2021 16:32:52 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d67sm3273534pfd.151.2021.10.14.16.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 16:32:51 -0700 (PDT)
Date:   Fri, 15 Oct 2021 07:32:45 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
Message-ID: <YWi+HRiXju7NEkbX@t490s>
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
 <YWZJIKsn6Sry5P6k@t490s>
 <20211014133644.GA2023135@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014133644.GA2023135@u2004>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:36:44PM +0900, Naoya Horiguchi wrote:
> Thanks for the good question, this could trigger WARN for unpoisoned pages.
> The impact is limited because the caller of unpoison should know that that
> happens in testing workload, but maybe there's no good reason to prevent
> from it. So I'll drop this WARN_ON().

Sounds good, thanks.

> > I had a feeling that when handling the page fault in do_swap_page before we
> > SIGBUS the program, we should double-check the PageHWPoison on the pfn page,
> > but I could be missing something..
> 
> The double-checking seems to allow processes to detect that the hwpoison page
> is unpoisoned, some test programs could benefit from it. But maybe it could
> be done independent of this patch.
> 
> Personally, I only use unpoison in cleanup phase of each test case,
> and each test case newly starts test processes, so reusing error pages
> with unpoison can be avoided.

I see.  We don't have anything like soft-online a page, do we?

I also don't know whether hwpoison can be used in any other form besides
testing the hwpoison code path.  E.g. logically it can be used to forbid
accessing a physical page for any reason then recover using unhwpoison?

Uffd has the SIGBUS mode that can do similar thing to the virtual address
space, so any access to some page will generate a SIGBUS. While hwpoison is
phsical address space based from that pov, and just like uffd it doesn't need
to change vma layout which should be a good property unlike mprotect().  But I
totally have no clue on all these... so it's just wild idea.

Anyway, agreed on above, even if it's applicable it should be a separate patch.

Thanks,

-- 
Peter Xu

