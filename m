Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA1F33C8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCOWDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhCOWDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:03:01 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F293C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:03:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 16so14864656pgo.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pM/cP6/Lz3nYNB1A2BCPvDYZL5Nv+dU7p0YG5FmdOHs=;
        b=i+Pu5UNw/TgHu/fQEXmZOHFShdZNm0HYjuktOVvh43UQqWK9OXoxwTL0KfkLH1Lh3o
         Mkcv0D3zl4D39+93TZwtmfQnzTN3Fg40p8XufRexRcM6m8VQsn9YV4Kt6YovAUS/J0Qh
         oZNwlAoLttJ/w9GIdPY7BRwFC7DF52oYAgWR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pM/cP6/Lz3nYNB1A2BCPvDYZL5Nv+dU7p0YG5FmdOHs=;
        b=JHrzAb8+mLmquwCZXdQHKMOCPYyttw5ZDQGaTB9OXntIF/vSZAEjJRfHiLfNEuD3OJ
         aFtogurvTAPKqXlsl0HrCVEOM05AveFd+aNReXCH5pIzCODKKpinC/9/YoefvjIRkRLu
         UiRgmpOx1+WJedHoMe9Y9FzkBFjkOVTLh2GgbbfDbpbGpvpwFLRtuVCvXWEXEx+E7OMB
         zoiiH4zXE/yjRQ9rkW1QpNdtlEsJwjX1riQM+UVlKJ0b6PzJkgPrOejXj00HbIhoQDdc
         iISRv22PSuOVh9Yj22x+dkRHQxGucC43V0Pi6bCdEDOPLqKiBsrNm9FAvzlLIXw6Jity
         DHmg==
X-Gm-Message-State: AOAM533JJEjpNG1jgqFSnw3fKZtKP5AzgAml/x1taa6yCbjwUQw2T9SK
        hqQkJU+LopEdeS2WT8ZgVcX0jg==
X-Google-Smtp-Source: ABdhPJy8q9F/S8HF2FiROpt7pJm13akaXdXmtXbP3bYKMQOOiCIYaDmmj4n4Edotx3q4QzWSMo2peA==
X-Received: by 2002:a63:f808:: with SMTP id n8mr995720pgh.115.1615845780563;
        Mon, 15 Mar 2021 15:03:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15sm14597755pfo.20.2021.03.15.15.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 15:02:59 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:02:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org, Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v8 3/8] Use atomic_t for ucounts reference counting
Message-ID: <202103151426.ED27141@keescook>
References: <cover.1615372955.git.gladkov.alexey@gmail.com>
 <59ee3289194cd97d70085cce701bc494bfcb4fd2.1615372955.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ee3289194cd97d70085cce701bc494bfcb4fd2.1615372955.git.gladkov.alexey@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 01:01:28PM +0100, Alexey Gladkov wrote:
> The current implementation of the ucounts reference counter requires the
> use of spin_lock. We're going to use get_ucounts() in more performance
> critical areas like a handling of RLIMIT_SIGPENDING.

This really looks like it should be refcount_t. I read the earlier
thread[1] on this, and it's not clear to me that this is a "normal"
condition. I think there was a bug in that version (This appeared
to *instantly* crash at boot with mnt_init() calling alloc_mnt_ns()
calling inc_ucount()). The current code looks like just a "regular"
reference counter of the allocated struct ucounts. Overflow should be
very unexpected, yes? And operating on a "0" ucounts should be a bug
too, right?

> [...]
> +/* 127: arbitrary random number, small enough to assemble well */
> +#define refcount_zero_or_close_to_overflow(ucounts) \
> +	((unsigned int) atomic_read(&ucounts->count) + 127u <= 127u)

Regardless, this should absolutely not have "refcount" as a prefix. I
realize it's only used here, but that's needlessly confusing with regard
to it being atomic_t not refcount_t.

> +struct ucounts *get_ucounts(struct ucounts *ucounts)
> +{
> +	if (ucounts) {
> +		if (refcount_zero_or_close_to_overflow(ucounts)) {
> +			WARN_ONCE(1, "ucounts: counter has reached its maximum value");
> +			return NULL;
> +		}
> +		atomic_inc(&ucounts->count);
> +	}
> +	return ucounts;
> +}

I feel like this should just be:

	refcount_inc_not_zero(&ucounts->count);

Or, to address Linus's comment in the v3 series, change get_ucounts to
not return NULL first -- I can't see why that can ever happen in v8.

-Kees

[1] https://lore.kernel.org/lkml/116c7669744404364651e3b380db2d82bb23f983.1610722473.git.gladkov.alexey@gmail.com/

-- 
Kees Cook
