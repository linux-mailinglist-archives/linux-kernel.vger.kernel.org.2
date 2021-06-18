Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE693AC5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhFRIUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhFRIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:20:43 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D236C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:18:33 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id r9so1764488ual.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6oejrlNG6jfpvhOJUWCMjGYQKj/nTWi9Xf/F2Ug0Lg=;
        b=rcwqlPRWfY9G/kpL5ukEs7Y0HtIBZ0eDNR/vormpioQwGoydGvE1C2vc76tG7rf1Aj
         iF8K+sbzIdEQbTPB/JFbmT8E+BDVKy7Dr/cbd3iR5DA35Gk1WqRiDLk1dLNVOOuqUDfv
         gUrOlwjyhvW8wKlYE4km1BmasrdghOh4X7nzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6oejrlNG6jfpvhOJUWCMjGYQKj/nTWi9Xf/F2Ug0Lg=;
        b=pemogtqx8sbxYVVHFQx9XP/D6oNCLo01SGWqz7pInxHE3Ksdp8YPloUdg8z3AZl3Dq
         KAb+JF78eCmqFIDglXXFXx+r4hCc5cj5BPzzSFDSuyOKmhed1H9/U5I1J33w6ie8mPGL
         BjxBO+uv8BGRxEgEmAKXgOpddIZO93PLzXGbTY8JufiyY9gpmZSQpu07eUuZ+WUSZHxx
         OXvgFDG6/4UK3hbpkdIpOUMlv4jQJLMPcHSaje2uBQHcaTnlA5EnNnZjhSv3XQjsF4r2
         HXssl6+hnDBr2zVGMiTDu3Zn3k/3O08pwWxIQiYRyih0lDbBMjtWuLTQnpKe7SaxOVpJ
         pFFA==
X-Gm-Message-State: AOAM530g86RVHRed5U3sNn/A2gt8fPBlpYWtoen8lnjJU8UXX1Z5SHBz
        41ngsR5hV33VsGWPLPPme2JLcjKHQoZC4wh3q2TakA==
X-Google-Smtp-Source: ABdhPJwMr7bKbHnJ4J222POIdgpQ6O6/jjmoMsvlx6MPZxuQgKtceEK7VsPlh5QYDSIqOGlKqJ6m2KLCMcki/QSUulo=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr10555190uap.11.1624004312143;
 Fri, 18 Jun 2021 01:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210617095309.3542373-1-stapelberg+linux@google.com>
In-Reply-To: <20210617095309.3542373-1-stapelberg+linux@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 10:18:21 +0200
Message-ID: <CAJfpegvpnQMSRU+TW4J5+F+3KiAj8J_m+OjNrnh7f2X9DZp2Ag@mail.gmail.com>
Subject: Re: [PATCH] backing_dev_info: introduce min_bw/max_bw limits
To:     Michael Stapelberg <stapelberg+linux@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Roman Gushchin <guro@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 11:53, Michael Stapelberg
<stapelberg+linux@google.com> wrote:
>
> These new knobs allow e.g. FUSE file systems to guide kernel memory
> writeback bandwidth throttling.
>
> Background:
>
> When using mmap(2) to read/write files, the page-writeback code tries to
> measure how quick file system backing devices (BDI) are able to write data,
> so that it can throttle processes accordingly.
>
> Unfortunately, certain usage patterns, such as linkers (tested with GCC,
> but also the Go linker) seem to hit an unfortunate corner case when writing
> their large executable output files: the kernel only ever measures
> the (non-representative) rising slope of the starting bulk write, but the
> whole file write is already over before the kernel could possibly measure
> the representative steady-state.
>
> As a consequence, with each program invocation hitting this corner case,
> the FUSE write bandwidth steadily sinks in a downward spiral, until it
> eventually reaches 0 (!). This results in the kernel heavily throttling
> page dirtying in programs trying to write to FUSE, which in turn manifests
> itself in slow or even entirely stalled linker processes.
>
> Change:
>
> This commit adds 2 knobs which allow avoiding this situation entirely on a
> per-file-system basis by restricting the minimum/maximum bandwidth.


This looks like  a bug in the dirty throttling heuristics, that may be
effecting multiple fuse based filesystems.

Ideally the solution should be a fix to those heuristics, not adding more knobs.

Is there a fundamental reason why that can't be done?    Maybe the
heuristics need to detect the fact that steady state has not been
reached, and not modify the bandwidth in that case, or something along
those lines.

Thanks,
Miklos
