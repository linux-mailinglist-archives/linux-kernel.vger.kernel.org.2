Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADA03924FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhE0Cpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE0Cpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:45:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5859C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:44:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e17so2511681pfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OWnhIRtH41VW4/lCOTjupHX4TklN7EnBtE+milzxdg=;
        b=yob++nCZ0jBPDz2/M6DUDb2d8Mvwd6Ed95UY9DwG4PoRNTQzWrjv4CXanUrje/xzkf
         UxQNr2uSSbo8OhSCditOvGbwiWqcbB9qN9m6466EwmfkUQCT9HoakI5Ck/85h+GApPEe
         uxFZ71gKN41HhskGj4Rohl9fklmpF3EUCOmR0XNv5Cy2AhBjuu0Wlet0h3L0DAoKHtvQ
         5DBThvCeEeMKqXSRE75bZdbrVaDj6dleKXCxbNSCl/FdF5Q6Z5M4mlQsdhF5+YGZpHYY
         R213dFkzbRR+RPOO+WU0WmZBoltgQrlZIfomRpywSEh8j1sXBUuifSA6IWR3aU9CH2zN
         NvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OWnhIRtH41VW4/lCOTjupHX4TklN7EnBtE+milzxdg=;
        b=hX2vcyUAy0EmmP/sDSQSLTIqDBhoHhPTflzIDQzWjZ5PfwjXHkNboYkb/F6t219+oV
         IDTmxTAoEL7pCWwfAQWsk5SwVWuPpiFvG0wCFTpzse0nnLe6fW0JK+9keI5rLgimpfuU
         IBd5ylPgZPu+qZ6BUVtb3JVvJ4d8+x/gcaRBwfAZ5ALbW4ystFwrecxtP5PDjAvwI7dc
         6x8iowERl/p6lbUfroOUTL+ZeciuBvN6J5vT5elSj/mWVUF53TNnk1WALr690w1tuMZb
         o/gMfFkc9oSrUrsI/iRlGtwlnpZvNe/CrMlJMuVk2N6fdpBOlU+L1f4N0GizlYFWkSYc
         8Ihg==
X-Gm-Message-State: AOAM533pSS0NST64fbAkh4bz4NoQtN9exZ1XTlyuHvZjfA3QLbSTAdiJ
        Uvm7qTTNQyFGRD8Il65x0CHONLM1YpMtMtAKevUrvQ==
X-Google-Smtp-Source: ABdhPJxwDUrGAubiCAOTx3bDKiXKskkBV2syNptAff9s59quefpdRyl+YKE1S1ZKVM0ylFbmM4m5YgcXjcb+W+2YUjw=
X-Received: by 2002:a62:7b07:0:b029:2e3:b540:707f with SMTP id
 w7-20020a627b070000b02902e3b540707fmr1505473pfc.59.1622083461024; Wed, 26 May
 2021 19:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
In-Reply-To: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 27 May 2021 10:43:44 +0800
Message-ID: <CAMZfGtXgZ1R9BSE5=sgxKwHLUdo1zCmr4QBHhncpUxJVpzfi-Q@mail.gmail.com>
Subject: Re: [External] [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 7:53 AM Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> When memory_failure() or soft_offline_page() is called on a tail page of
> some hugetlb page, "BUG: unable to handle page fault" error can be
> triggered.
>
> remove_hugetlb_page() dereferences page->lru, so it's assumed that the
> page points to a head page, but one of the caller,
> dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
> which could be a tail page.  So pass 'head' to it, instead.
>
> Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks Naoya!

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
