Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0836E24F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhD1X6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhD1X57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:57:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8FC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:57:13 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id b14so6170308qvf.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vP18S1ZHWifJQd1qEJhx4BgIQRd2/f+YEsAm90MSCG0=;
        b=XRnStlcsfx70IZEuTEm5juLFCD394BPIw5/IzE7kRGzqj1lWDXgAFyMlkJKviStRsG
         cKlEEX2kEGfIqG9u8omVgjv7H1uq6VAQ3OgzfOi6VdHLLW3nPijOgdIoFXPVRc0bRM3C
         fKYpv7iYsRdHIZHeJKwnHdukaTyyRGxUXD79VO0Ki4RjcmxetP2a4GCsnxDIZ6XDF8Ej
         VPpG/gxqk/SE6t1CTSVLE8VJ7jkBzwpJENXY4klhsziiXvWdOkT463aW/ZEsi+QGF1w6
         2vQp56F/ABLIAZpOK/Mp9uCAEn+sosvzG01NWeK7sQUQL//U08Jv0HG4goLz6TQND1tg
         Kvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vP18S1ZHWifJQd1qEJhx4BgIQRd2/f+YEsAm90MSCG0=;
        b=eDP6cgjm5DIydlhMlQofbIqP5YbaHR2nwhIUr7X4eRqqUA6b3SKhWrFecXwVzQI0uH
         WpaxN+JfIJJx862kQpos0ZnJQa40E1kyWT3wcD+oTABDkq54lzgZJyeqOz2p8eV9wcz9
         YNmxNOeHCYchzOkm9QZUxGZgW8pEgjIj/oOoILTYiQ1po6I1llGhhYyEVZXBg9A7ag/j
         byIxn1ksNH5/cBe2avsD4KgfWzrHvMmY8NwLJMRzFnk+n0Ud/WlXGXO2PnZLeUo4r5TM
         BM3L4jufPDWhXkpvqpunk9YXqoE9tmmnhtfvwxQgpPK/6Szpk+JrOqawuxVAErdrFOlF
         4JPg==
X-Gm-Message-State: AOAM533jupUsSFkFc2IKakiw8cq12H9Eky2Ghuf4+aZOC0ARtIlldPq/
        AKHUpaycvhI1uTXs6drJHc0Sog==
X-Google-Smtp-Source: ABdhPJxZChcfPVDoxcjUyncFnAspzWViOI5AsBvAAIxkWSbXJqJ2hYJJ3Up7TkxTSee0UVQlnjPyvQ==
X-Received: by 2002:ad4:5be4:: with SMTP id k4mr32004748qvc.53.1619654231871;
        Wed, 28 Apr 2021 16:57:11 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q23sm1188988qtl.25.2021.04.28.16.57.10
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 28 Apr 2021 16:57:11 -0700 (PDT)
Date:   Wed, 28 Apr 2021 16:56:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] userfaultfd: release page in error path to avoid
 BUG_ON
In-Reply-To: <20210428230858.348400-1-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104281654270.9830@eggly.anvils>
References: <20210428180109.293606-1-axelrasmussen@google.com> <20210428230858.348400-1-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021, Axel Rasmussen wrote:

> Consider the following sequence of events:
> 
> 1. Userspace issues a UFFD ioctl, which ends up calling into
>    shmem_mfill_atomic_pte(). We successfully account the blocks, we
>    shmem_alloc_page(), but then the copy_from_user() fails. We return
>    -ENOENT. We don't release the page we allocated.
> 2. Our caller detects this error code, tries the copy_from_user() after
>    dropping the mmap_lock, and retries, calling back into
>    shmem_mfill_atomic_pte().
> 3. Meanwhile, let's say another process filled up the tmpfs being used.
> 4. So shmem_mfill_atomic_pte() fails to account blocks this time, and
>    immediately returns - without releasing the page.
> 
> This triggers a BUG_ON in our caller, which asserts that the page
> should always be consumed, unless -ENOENT is returned.
> 
> To fix this, detect if we have such a "dangling" page when accounting
> fails, and if so, release it before returning.
> 
> Fixes: cb658a453b93 ("userfaultfd: shmem: avoid leaking blocks and used blocks in UFFDIO_COPY")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks!

> ---
>  mm/shmem.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..8def03d3f32a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2375,8 +2375,18 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	pgoff_t offset, max_off;
>  
>  	ret = -ENOMEM;
> -	if (!shmem_inode_acct_block(inode, 1))
> +	if (!shmem_inode_acct_block(inode, 1)) {
> +		/*
> +		 * We may have got a page, returned -ENOENT triggering a retry,
> +		 * and now we find ourselves with -ENOMEM. Release the page, to
> +		 * avoid a BUG_ON in our caller.
> +		 */
> +		if (unlikely(*pagep)) {
> +			put_page(*pagep);
> +			*pagep = NULL;
> +		}
>  		goto out;
> +	}
>  
>  	if (!*pagep) {
>  		page = shmem_alloc_page(gfp, info, pgoff);
> -- 
> 2.31.1.498.g6c1eba8ee3d-goog
