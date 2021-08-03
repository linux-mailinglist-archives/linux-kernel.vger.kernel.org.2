Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7283DF21E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhHCQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhHCQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:08:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5421DC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 09:08:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z24so20322166qkz.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iyCXAcMeIygPfeNpqIKsbcgJBDobLnmtPrfQp9eNkL0=;
        b=hxg9+iUASxlzqzBVXrSOlNky+hxKLLQ7M7j1RMjkX9B3r6kCJZU6P6RNb8GPMepoQv
         PTQU0UTyMBuqBnUIt+3q5/jcmRFjGTJbeISJmV9hnZXI3HBRoOAlc64Cy7wFoj1EkiwA
         OJP/pELqR7hYC/3zwnziPfJu9/MFmxS8yrR2mxhZGBlegYuyE61f1/U5nD1pWs4qZc9Z
         TfJexvLl1wGqeZ/WJA6NZ+CVG6cU06ED7Gx7xyjaeNQSNEjlNmiY4jHyCSMIv2XouBd3
         gg54MCzrHYa5C5x8ifsuuIqCCnCqypiwudb6YschEJ9fw3s+6mpv4rE9kKF/Lcj6AsA2
         qFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iyCXAcMeIygPfeNpqIKsbcgJBDobLnmtPrfQp9eNkL0=;
        b=h+T1VYTxPKhYtFGFRfBLCiIUmjmOpjgegXbymxEn8xpsDQ9+Yhx4hqG75zqntPkdD+
         P+ImUXkG/z/DjTrSJnfk8yenNkal1+9NCanE0nunbHsXuLgWrqfglKbsB0OBbeN5Q4lt
         pL9PFENtS4ISWNaQuABujOhMPxH0/GM55ex6NnvBqk0JL0OVBBZ5cBgPco6MRIzuGP0W
         tzYkjI6dLVIusUyVrYZZ5oYQmGDM2ME+KtjspqRWN6sM0J1sWofrVIZ0RI2Z3dRKjD5e
         mOq9PG3PM6jfGGIeW5iTMHFAN1hJfWUwlVdgfrJR/69yDi1KEt/FQdPI9ezyYVkJtu6a
         T7nA==
X-Gm-Message-State: AOAM531nma3MBeupkNjaGsPAjlEcwvcpGIvdP2FWt7MFvATE2adDKFIf
        O5rJA1H9ZKjAe6HpnGTjUTiyUg==
X-Google-Smtp-Source: ABdhPJyemqrq0Ku/2lZ2TcmypbvrUHRvhVq/sYGHrrFwdl5cXfq31Pp+xQ2l+fzkmE1Ai2uuRdkbgg==
X-Received: by 2002:a05:620a:159a:: with SMTP id d26mr21706626qkk.495.1628006885572;
        Tue, 03 Aug 2021 09:08:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v5sm7961090qkh.39.2021.08.03.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 09:08:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mAwxX-00C7pH-T1; Tue, 03 Aug 2021 13:08:03 -0300
Date:   Tue, 3 Aug 2021 13:08:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Luigi Rizzo <lrizzo@google.com>, Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Message-ID: <20210803160803.GG543798@ziepe.ca>
References: <20210731175341.3458608-1-lrizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731175341.3458608-1-lrizzo@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 10:53:41AM -0700, Luigi Rizzo wrote:
> find_vma() and variants need protection when used.
> This patch adds mmap_assert_lock() calls in the functions.
> 
> To make sure the invariant is satisfied, we also need to add a
> mmap_read_loc() around the get_user_pages_remote() call in
> get_arg_page(). The lock is not strictly necessary because the mm
> has been newly created, but the extra cost is limited because
> the same mutex was also acquired shortly before in __bprm_mm_init(),
> so it is hot and uncontended.
> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
>  fs/exec.c | 2 ++
>  mm/mmap.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 38f63451b928..ac7603e985b4 100644
> +++ b/fs/exec.c
> @@ -217,8 +217,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
>  	 * We are doing an exec().  'current' is the process
>  	 * doing the exec and bprm->mm is the new process's mm.
>  	 */
> +	mmap_read_lock(bprm->mm);
>  	ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
>  			&page, NULL, NULL);
> +	mmap_read_unlock(bprm->mm);
>  	if (ret <= 0)
>  		return NULL;

Wasn't Jann Horn working on something like this too?

https://lore.kernel.org/linux-mm/20201016225713.1971256-1-jannh@google.com/

IIRC it was very tricky here, are you sure it is OK to obtain this lock
here?

I would much rather see Jann's complete solution be merged then
hacking at the exec problem on the side..

Jason
