Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAFF36E25E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 02:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhD2AJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 20:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231627AbhD2AJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619654929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7GVrafhqBt/NzEHPShnR5kpF2aomX40MHGlLdQ6KOU=;
        b=InhhHjuE7QNDE2xwEwSZW8DUThLmnPvaaSs0kU1Eyw3NEjLXn3NLWzZE8xahzwVMkTcGxi
        kDqifjMo6uBgA7ewdKGpxr4qL23ZVYUl/gX30xMHl4truBdktYXCMiXEZtjHx1HdzpYGvE
        mW4C7zWX1uEcNrI97XX9uB/fu32sTiE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-f9WpmmTaNrqsKr82kTU0xg-1; Wed, 28 Apr 2021 20:08:47 -0400
X-MC-Unique: f9WpmmTaNrqsKr82kTU0xg-1
Received: by mail-qk1-f197.google.com with SMTP id m4-20020a37a3040000b02902e6776757c3so1878131qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 17:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r7GVrafhqBt/NzEHPShnR5kpF2aomX40MHGlLdQ6KOU=;
        b=Rn5FhgqmYAFgJOIrF/zt9eh5K5AiGK6bI0htpWxRCVtONeofeF/Qx/Rk2C5+WPfWhy
         VA60S7bALrGKDVFABxuxSoik5+FqCFZE7yGxwEPUKVwrBdvRli8oqcMPOONuOmPOTxxZ
         +AN7aWSPKFFlCIUBKP/DOaQC6OpVJJoZal7bc96d6kG/sW+InFNsxnDzHPyR4a2G6wqB
         3ilRpQlbXYahZ558swPgH6VppJrd6j7ujqJMxU7cpSUwfZjexNARfHobbq/JUuwfu4tZ
         CfpLXwbqhuSh84X4c0HHAX27aSU/tbG/P6MxHVKyDal3msyh2nrIo+FNTRodtRJMcvOE
         Huyg==
X-Gm-Message-State: AOAM530jEvp3YeGHs5pJa1utBCSavR9McLaeTZm6ra0d+wg0sgBLTrO0
        Zeb4BSOewI/pBMPhq2ANgEsPfo/a2LGcVhzMB4q6OsC3Ix6cpI8JhISiU58ifnjNW2v1HIJMPgF
        9d+BZufbhJerkknDb1f/VSEo+
X-Received: by 2002:ac8:7947:: with SMTP id r7mr28544012qtt.104.1619654927363;
        Wed, 28 Apr 2021 17:08:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQLfa/KlJZWVO0hAU0gE3hKxnxPGdpA0sAAuc1Zb74f4W5OFsDvnexehY7/o3Vt2whfyC1ZQ==
X-Received: by 2002:ac8:7947:: with SMTP id r7mr28543999qtt.104.1619654927126;
        Wed, 28 Apr 2021 17:08:47 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id a22sm1020526qtp.80.2021.04.28.17.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 17:08:46 -0700 (PDT)
Date:   Wed, 28 Apr 2021 20:08:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] userfaultfd: release page in error path to avoid
 BUG_ON
Message-ID: <20210429000845.GA8339@xz-x1>
References: <20210428180109.293606-1-axelrasmussen@google.com>
 <20210428230858.348400-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210428230858.348400-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 04:08:58PM -0700, Axel Rasmussen wrote:
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

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

