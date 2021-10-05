Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91120421CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJEDAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 23:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJEDAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 23:00:03 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60CBC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 19:58:13 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c6-20020a9d2786000000b005471981d559so24110516otb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=L3EUZPK9K1Nv4X/t23Xigyl5ZGZm+PMO5vmnKob3qyk=;
        b=Zpongvaz1NjXcDn0gybFkNRbvYFnpGbnkya9dHm7ZPH1QZQ8VQzfO72CPFdDiZNxk6
         cUt5bRncLzH6F2fgLMcngOkAwm7Kf/lLnE5mjvfR2c3Z7FnMdSgs5a7jkL4qhsBAreuO
         rb4nQBJFC+2lzhYvAoyDwC1GxSHqt4MYrRKga7OUGK9c9lpuXIc9FZpEXt0P0U6jnEYM
         wSJHf804fz3oH74cyeNcLDSqW5KzfAn4HtpE/aHPCQ5WUOtKLQRBVLZKvPPXt2cAZDMu
         fDtLdbckkbHV5+kaMpqJd96uY0VPzhBgTvPubTWk25DXnjPKOCVSb2YvLGUIwfVRvtWS
         r80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=L3EUZPK9K1Nv4X/t23Xigyl5ZGZm+PMO5vmnKob3qyk=;
        b=TxRb0Y8A5uiNbC7WYzzG1U6CpMMLc7rgUq4svtjDF82PyC8SrKEOul+YEwqqb90fiX
         EAZASBS+ZSgM+jPK/CfwU+OkN45pkezABdIppxi+wSVorI71wlqH7UoHiO9XMSQ0tx/Y
         9b9zlx12f2fVHDE9/AIoyxVxN+0b+rekoodxH/fHGcXKfhjbyATw60wyI/UAv0MDl6n6
         uQBlAH90P2X1dPs3xCTWl5jwpAEKNLwxq8WCQFxtHoCAgHEZPqmfENjhWXFsiybRlsvk
         DTIEflG8ShtrLQOQAPjHhNpIL6LMdxo5AIZJ788p74rADp5nGq5McD7L5sG4NLQ8KTCw
         hPnA==
X-Gm-Message-State: AOAM5316WTkTiQ8qxfUDKXKuHFkarKL/qQeXqyjzBbJhjY33eA2ql0KY
        AvNsfC/sWnVGnUYYfCIxL7YenSreptLxhw==
X-Google-Smtp-Source: ABdhPJylDdet4eoQrG8ehs8f6OfgHk1DUVFd62qvlpu0tM77G2xgt2OIt4QsApR6Rzk6zIIBbzwaLA==
X-Received: by 2002:a9d:6a17:: with SMTP id g23mr12355910otn.36.1633402692761;
        Mon, 04 Oct 2021 19:58:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d14sm3289999otq.65.2021.10.04.19.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 19:58:11 -0700 (PDT)
Date:   Mon, 4 Oct 2021 19:58:10 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
cc:     Song Liu <song@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
In-Reply-To: <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
Message-ID: <d2776967-bb9f-985b-6d38-d1d1dc83cd7b@google.com>
References: <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com> <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org> <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com> <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com> <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com> <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com> <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org> <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com> <YVT+KWFA8hfSKU+m@casper.infradead.org> <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
 <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021, Rongwei Wang wrote:

> Hi,
> I have run our cases these two days to stress test new Patch #1. The new Patch
> #1 mainly add filemap_invalidate_{un}lock before and after
> truncate_pagecache(), basing on original Patch #1. And the crash has not
> happened.
> 
> Now, I keep the original Patch #1, then adding the code below which suggested
> by liu song (I'm not sure which one I should add in the next version,
> Suggested-by or Signed-off-by? If you know, please remind me).
> 
> -               if (filemap_nr_thps(inode->i_mapping))
> +               if (filemap_nr_thps(inode->i_mapping)) {
> +                       filemap_invalidate_lock(inode->i_mapping);
>                         truncate_pagecache(inode, 0);
> +                       filemap_invalidate_unlock(inode->i_mapping);
> +               }

I won't NAK that patch; but I still believe it's unnecessary, and don't
see how it protects against all the races (collapse_file() does not use
that lock, whereas collapse_file() does use page lock).  And if you're
hoping to fix 5.10, then you will have to backport those invalidate_lock
patches there too (they're really intended to protect hole-punching).

> 
> And the reason for keeping the original Patch #1 is mainly to fix the race
> between collapse_file and truncate_pagecache. It seems necessary. Despite the
> two-day test, I did not reproduce this race any more.
> 
> In addition, I also test the below method:
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 3f47190f98a8..33604e4ce60a 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -210,8 +210,6 @@ invalidate_complete_page(struct address_space *mapping,
> struct page *page)
> 
>  int truncate_inode_page(struct address_space *mapping, struct page *page)
>  {
> -       VM_BUG_ON_PAGE(PageTail(page), page);
> -
>         if (page->mapping != mapping)
>                 return -EIO;
> 
> I am not very sure this VM_BUG_ON_PAGE(PageTail) is what Hugh means. And
> the test results show that only removing this VM_BUG_ON_PAGE(PageTail) has no
> effect. So, I still keep the original Patch #1 to fix one race.

Yes, that's exactly what I meant, and thank you for intending to try it.

But if that patch had "no effect", then I think you were not running the
kernel with that patch applied: because it deletes the BUG on line 213
of mm/truncate.c, which is what you reported in the first mail!

Or, is line 213 of mm/truncate.c in your 5.10.46-hugetext+ kernel
something else?  I've been looking at 5.15-rc.

But I wasn't proposing to delete it merely to hide the BUG: as I hope
I explained, we could move it below the page->mapping check, but it
wouldn't really be of any value there since tails have NULL page->mapping
anyway (well, I didn't check first and second tails, maybe mapping gets
reused for some compound page field in those). I was proposing to delete
it because the page->mapping check then weeds out the racy case once
we're holding page lock, without the need for adding anything special.

Hugh
