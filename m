Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A65D36DF09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbhD1Skg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243508AbhD1Skf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619635190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W3wbIZp6Y1eJURenlypAKMNuDhi204EdAx8I9omgFTU=;
        b=NjnVlpw8Zp4FpFYM7RFv5R3b7wO2A7bvybPwREIBBAMCpCNapjAXNYDnj10T1whDN1Qyvc
        pe8Vfs7o9PLY6UZ7zlNIrPi78ZMgLHotxsunuSff1ApbnXa8gPBbxI/5AhU0Wps2DabiJt
        KJ+fCS+ovQY/UJA9fOz3ge/xF+HyJuM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-UYu39LRtOI-wgKlECk8pHg-1; Wed, 28 Apr 2021 14:39:46 -0400
X-MC-Unique: UYu39LRtOI-wgKlECk8pHg-1
Received: by mail-qk1-f199.google.com with SMTP id y9-20020ae9f4090000b02902e4caf24229so5569997qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W3wbIZp6Y1eJURenlypAKMNuDhi204EdAx8I9omgFTU=;
        b=I3hN29qbDVZT3m2lsvwLyShy2JEUUvaY/g+3+1aQ087f0D3qIzPsEq0w/PdWZRcQI5
         jQNhO/xTZA9j1L8cUw76kPPliLnc9MFRu9tPRL25uYr1WKZ5T5LLlUdCn2nkSFXllz9F
         OANoUw0sigGCuNwjjuP3LAtICimo5q4xlSRtWmO18RiA7S7Kt4KHJtcEMrKJBYfcyuAQ
         4knfP0agoKnPT4Lb31dnVNqbhKb5tTCPNNvZV8mwc42Lpu6/rYu8sV6ttk4cNqHyh0Ju
         ahgvJ4KyhhFCT/N5UJD27Y3JeE6r3r4C59B0J4JunvFE6bmgwWO/5V85D5TWC1LIP7tj
         tKyA==
X-Gm-Message-State: AOAM532UsUTtSzKH/4BdpXI8TS0I5/TFGVFuypBkqlY+rW6KF37quzCb
        qif75fPTEzqIoVJMrcSLyfwMwp3CBcUJgs1DVizm5iUGDtYjhGo4kszt6p7bs6152agGkDTqTkq
        uUGzw9J9CbrQ+Skjcg946aLth
X-Received: by 2002:a05:6214:16c6:: with SMTP id d6mr15125099qvz.38.1619635184988;
        Wed, 28 Apr 2021 11:39:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuMFuED/Mm8JulpnIPP8sBXWY2fAghB7wF9q4paYGwuUcrWv0KzEKhVm3yQr+bGWf6x6cHjg==
X-Received: by 2002:a05:6214:16c6:: with SMTP id d6mr15125064qvz.38.1619635184705;
        Wed, 28 Apr 2021 11:39:44 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id j191sm393241qke.131.2021.04.28.11.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 11:39:44 -0700 (PDT)
Date:   Wed, 28 Apr 2021 14:39:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: release page in error path to avoid BUG_ON
Message-ID: <20210428183943.GH6584@xz-x1>
References: <20210428180109.293606-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210428180109.293606-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:01:09AM -0700, Axel Rasmussen wrote:
> Consider the following sequence of events (described from the point of
> view of the commit that introduced the bug - see "Fixes:" below):
> 
> 1. Userspace issues a UFFD ioctl, which ends up calling into
>    shmem_mcopy_atomic_pte(). We successfully account the blocks, we
>    shmem_alloc_page(), but then the copy_from_user() fails. We return
>    -EFAULT. We don't release the page we allocated.
> 2. Our caller detects this error code, tries the copy_from_user() after
>    dropping the mmap_sem, and retries, calling back into
>    shmem_mcopy_atomic_pte().
> 3. Meanwhile, let's say another process filled up the tmpfs being used.
> 4. So shmem_mcopy_atomic_pte() fails to account blocks this time, and
>    immediately returns - without releasing the page. This triggers a
>    BUG_ON in our caller, which asserts that the page should always be
>    consumed, unless -EFAULT is returned.
> 
> (Later on in the commit history, -EFAULT became -ENOENT, mmap_sem became
> mmap_lock, and shmem_inode_acct_block() was added.)

I suggest you do s/EFAULT/ENOENT/ directly in above.

> 
> A malicious user (even an unprivileged one) could trigger this
> intentionally without too much trouble.
> 
> To fix this, detect if we have a "dangling" page when accounting fails,
> and if so, release it before returning.
> 
> Fixes: cb658a453b93 ("userfaultfd: shmem: avoid leaking blocks and used blocks in UFFDIO_COPY")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/shmem.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..46766c9d7151 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2375,8 +2375,19 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
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
> +			unlock_page(*pagep);

Not necessary?

> +			put_page(*pagep);
> +			*pagep = NULL;
> +		}
>  		goto out;

All "goto out" in this functions looks weird as it returns directly... so if
you're touching this after all, I suggest we do "return -ENOMEM" directly and
drop the "ret = -ENOMEM".

Thanks,

> +	}
>  
>  	if (!*pagep) {
>  		page = shmem_alloc_page(gfp, info, pgoff);
> -- 
> 2.31.1.498.g6c1eba8ee3d-goog
> 

-- 
Peter Xu

