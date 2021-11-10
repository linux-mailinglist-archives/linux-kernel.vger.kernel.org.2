Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C43B44C479
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhKJPig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhKJPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:38:35 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57823C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:35:48 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i11so2878180ilv.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jO63MgqvvS2Y6tzvamI38zwEpN79l20A/JLQ6KGTtgo=;
        b=lZHZ9Optsrfhc9hTh8U009OHE4jBEBHSNssg6xDMRXxXMkYtOvO9OIqwSFm5RO5C7l
         NhogbK8eX5WiZ6Z0dYMxpUXOE9fzbfMrRv+JPUOoYebq+MhlN9SlQcVyx4PYMwEICkeV
         LoTIxOVrgKc+IQgG5iizDcbJ58qKQk+QO8TAJ3nCqJLis0QiH8qLSPvRqZvX2/9Al5eR
         Y77P5T/vqeBxoZS2xnfZYTBKi1mN+yrmFYglvX5Jj8NyAdRIEKCeTJ3p73tMPs90Sws3
         +a7v6glyx406fjPyMfNubUevPCZ5kxVMWxcH8Z1TD75Sd/GaHqFpK/3pj99nNoyuwmUG
         ApVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jO63MgqvvS2Y6tzvamI38zwEpN79l20A/JLQ6KGTtgo=;
        b=oH+532ebWi2lCLX5ih0JHJciluuCDV+o6zwgB1NvRbPgqBoifZybP8cxGz500kTnEa
         Xqf3BAoGOzUvuPvQ06T4oFV8i9hThJfKihETBfSSN+GxaDN9fbSnfJQn+5ImaxY65ox0
         0YxBlrm7SQ0zI2wI84ChskjLt6ajhDU9XRbbgvO6bgMka1sjEAzLgwu22TiORlO0hbHV
         +nHdLt0UGvQsDWaumFfW/OEjeX0eBhqzAXVJ6kzxqGnl2fjXtansWYvPpOXDQNZBEmKW
         JLxl+h1kICNN3HQWicBDVW1m166dAvV0zWCqsOq6cYA/s0xcCMRh/4GMAVG4fowYrbaC
         ocJQ==
X-Gm-Message-State: AOAM530ZsRIYJy2bv3Q/MA2yXsHoPp2FD2G77EtIVXnY42gkXrJXusrB
        pXboipyGNjcVkgFe4XTS4hXq2/EwV42/NXCw7v0=
X-Google-Smtp-Source: ABdhPJxTDb21+xwdqgE4xozl8iy1qBpI9s2Xx1sstlMfMT+1W4dplV0CIHtshP5Am0abkcjqthoC+wqS/lnoYQYtEdU=
X-Received: by 2002:a05:6e02:2149:: with SMTP id d9mr543803ilv.221.1636558547722;
 Wed, 10 Nov 2021 07:35:47 -0800 (PST)
MIME-Version: 1.0
References: <CAJy-AmmOMGEhTLgeUepFCXxBFpEPriAFtj_qKhOxHjq7i6T5mQ@mail.gmail.com>
 <20211110143535.15809-1-sj@kernel.org>
In-Reply-To: <20211110143535.15809-1-sj@kernel.org>
From:   Alex Shi <seakeel@gmail.com>
Date:   Wed, 10 Nov 2021 23:35:11 +0800
Message-ID: <CAJy-AmndDjZNLXr_9fNwQSKSZhahTKMKhRTTskiZ-yVnpqUzsQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/damon: remove damon_lock
To:     SeongJae Park <sj@kernel.org>
Cc:     Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:35 PM SeongJae Park <sj@kernel.org> wrote:

> Yes, it would effectively avoid the problem case.  However, I'm unsure how much
> performance gain this change is providing, as apparently the lock is not being
> used in performance critical parts.
>
> I'm also unsure if this change is reducing the complexity of the code or not.
> For an example, this change allows someone to show non-zero nr_running_ctxs
> while no real kdamond is running, before __damon_start() is called, or when it
> failed.  I think this would never be a real issue, but might make my poor brain
> a little bit confused when debugging.
>
> Also, we might add some more variables and code section that should be mutually
> exclusive to concurrent DAMON users in future.
>
> atomic_t is obviously enough for protecting a variable.  But, IMHO, it might
> not necessarily be the best choice for non-performance-critical mutex sections.
>
> Please feel free to let me know if I'm missing something.
>

hi SJ,

Thanks for the quick reply!
Yes, it's fine to use mutex on a slow path, it won't cost much. but I
just feel itchy
while looking at the code, especially since it only guards an int...
Anyway, it's up to you.

Thanks
Alex
