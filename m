Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B8E374B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhEEWPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhEEWPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:15:14 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5368C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:14:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b10so3077074iot.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+TLJ+w/sIyEYaz/pmEc+wkQOprlg/a2eYr65RlYGlI=;
        b=il6GOcf+4mlMmUP2SQ/tKzjmsVW7K9lDNXsA3VcmnAxOncRFzF/7oNVC0z5vQRPkzk
         YdGO/H8Exps8jFuj4vhjpFIunkc+a6RgdYtAWrlkEZsmjd8Yux8vHU4BA5t2a6A1JW8M
         YMW1YJMPgRTrJcUW4lI9R8nGONax1TlkZZ9HrQOpW/oLvqkyBCJbIkSFLFtxpj0GwLnD
         oYIOaryC7HPP5FfRZ8UwihfRL0Ce2S4Uhi7U36+CUnQFcf4L+XX9Z26frWQ/U64AEBP+
         tlWepwElyhIh93943l7KpfDhe5LCeXMC3n51ne/WgQ8+3m4ZXyx4aOUp2Fy4Ws74wxYq
         66iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+TLJ+w/sIyEYaz/pmEc+wkQOprlg/a2eYr65RlYGlI=;
        b=EPlB6KZPDm2iR0txEQJ4RPIj9AORJN1oRAVz6HGl7HJ3ws0Sh/d398rxpKtwRA2XqG
         ovdvLotz9n/p8Pwi2h9ADb4zbF21XEu+EjWZQtTxBUsOcMzYFIBt7NfzfEG7jAaSkQxI
         0mE4Sm4118UJDNxQ39sKFegZG82BcztPuPomSfRbliHGUsYt2b2NephtOzID+fQeziVG
         A23RXMC/uHHlabq7M7tNw7xRo2xXn25Pro6hJn8OZ4/TGpXikoL9fuRL4DUfsCjNeUJ+
         0PVXuNdtEPdi/IMYWQ4jylCSXZOPMqFXeFHm+1sCd80WKBMj9zzuPxcQU2O+1KoyrKUu
         WOUw==
X-Gm-Message-State: AOAM530hK+dq0xmrnEF6qCVujhuvJKlSdtKy26cT3k3B2vJDaIfPCEH+
        SKfuPGyoYq7JFzOOPYVQcHMoaNR/3mPGo/eDT6lhJA==
X-Google-Smtp-Source: ABdhPJyEuVNI6YVlDbBhPd83vR7SdCCZTElgol3N+ViCnFn0vVD8EU+TF7jSbmIUTL3cr3CqNc5y/4k69h8NKEtoFus=
X-Received: by 2002:a6b:cd08:: with SMTP id d8mr628898iog.86.1620252856012;
 Wed, 05 May 2021 15:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210428180109.293606-1-axelrasmussen@google.com> <20210428230858.348400-1-axelrasmussen@google.com>
In-Reply-To: <20210428230858.348400-1-axelrasmussen@google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 5 May 2021 15:13:39 -0700
Message-ID: <CAJHvVchOiSHkHOyKKnTTqj4ayUyiCyttTFQXWmg2PM_9XFS=sA@mail.gmail.com>
Subject: Re: [PATCH v2] userfaultfd: release page in error path to avoid BUG_ON
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 4:09 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
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

Apologies, I should have added this line:

Cc: stable@vger.kernel.org

I believe this fix ought to go into the 4.14 and later stable branches
(the commit referenced in Fixes: was introduced in 4.11).

I can resend with this included, if that would be easier.

> ---
>  mm/shmem.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..8def03d3f32a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2375,8 +2375,18 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>         pgoff_t offset, max_off;
>
>         ret = -ENOMEM;
> -       if (!shmem_inode_acct_block(inode, 1))
> +       if (!shmem_inode_acct_block(inode, 1)) {
> +               /*
> +                * We may have got a page, returned -ENOENT triggering a retry,
> +                * and now we find ourselves with -ENOMEM. Release the page, to
> +                * avoid a BUG_ON in our caller.
> +                */
> +               if (unlikely(*pagep)) {
> +                       put_page(*pagep);
> +                       *pagep = NULL;
> +               }
>                 goto out;
> +       }
>
>         if (!*pagep) {
>                 page = shmem_alloc_page(gfp, info, pgoff);
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
