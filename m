Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC443A3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhJYULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbhJYULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:11:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5EC04A400
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:29:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l203so6978098pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJiasAWjpoN1bOCkWk9RL6DVjlUXQV+BQQ0HuB5WrXA=;
        b=LL/FMPprNtV88++Wudo+pFadJq0f6H5RmMxWs3l1E1iJNXWcowIokPgCgd0HLhInjF
         nCIOsVCS7hsmvGxilh+sdZhj+iir5zv5Ny8NB5sz225exGIjmwXFZ14CSBzOlxr3wKju
         94aZrdaRhKvw+RYXAl1qQbq5xE4Q0WX6sMXr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJiasAWjpoN1bOCkWk9RL6DVjlUXQV+BQQ0HuB5WrXA=;
        b=i4L+69WDpOseyYLDKIE9jRafJalkoVv7Qn3ZFFlHwUdLgGIwTnqEw4erkkGzuNllmn
         e+OCZYI2LaloJX4tE/3Xoz7e8f9vrQDq9RSW+EAVuY7PN+VseWMsinzGdUlYN+XnrBwZ
         GlxN4E+iCM2FhukthKnHcjlg7o33bhI5Tb9th41rLqmmJVTKFQDPgnhBqoFZUQmJacad
         mpgJqANE9ww/gaVjz/KfmABtisgwbWnJqv5JU0gH+o4APQqzg9MXyfI2xRXueN7vVDBX
         VL/g9xZXalKyYJNePEj7Rjbd5ugwkFEGWU0vUIznamXCKA16aqJLBi2tWToXCws6acZ7
         hQ+A==
X-Gm-Message-State: AOAM531RKV5PqIiPufrYHFfMQUypbOIYgHUL9pnonMy8aJifwQI2phxs
        dPhIJ+CqLVqQANGAr74JOeLnUA==
X-Google-Smtp-Source: ABdhPJxS79fizC3hkJ53knMOyPrU9iw8czM0SHXOfrQymGZvEAEK2sfxwqA6TPCg2w7k2s7AoLs7gQ==
X-Received: by 2002:a62:8496:0:b0:47b:d189:5ce9 with SMTP id k144-20020a628496000000b0047bd1895ce9mr18055408pfd.19.1635190187884;
        Mon, 25 Oct 2021 12:29:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm16648707pgc.1.2021.10.25.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 12:29:47 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:29:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
Message-ID: <202110251225.D01841AE67@keescook>
References: <20211025181634.3889666-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025181634.3889666-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 07:16:34PM +0100, Matthew Wilcox (Oracle) wrote:
> Commit 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")
> attempted to fix the problem of secretmem_users wrapping to zero and
> allowing suspend once again.  Prevent secretmem_users from wrapping to
> zero by forbidding new users if the number of users has wrapped from
> positive to negative.  This stops a long way short of reaching the
> necessary 4 billion users, so there's no need to be clever with special
> anti-wrap types or checking the return value from atomic_inc().

I still prefer refcount_t here because it provides deterministic
saturation, but the risk right now is so narrow ("don't hibernate"),
I'm not going to fight for it. I think it'd be fine to use it initialized
to 1, and have the removal check for == 0 as a failure state, which would
deterministically cover the underflow case too.

-Kees

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jordy Zomer <jordy@pwning.systems>
> Cc: Kees Cook <keescook@chromium.org>,
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/secretmem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 030f02ddc7c1..c2dda408bb36 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -203,6 +203,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  
>  	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
>  		return -EINVAL;
> +	if (atomic_read(&secretmem_users) < 0)
> +		return -ENFILE;
>  
>  	fd = get_unused_fd_flags(flags & O_CLOEXEC);
>  	if (fd < 0)
> -- 
> 2.33.0
> 

-- 
Kees Cook
