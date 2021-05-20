Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2D38B9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhETWwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 18:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhETWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 18:52:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2378C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:51:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c20so27762533ejm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnulEUF+qKEePwDXKxeGeGtxQA2bAguCelUNMLELUoA=;
        b=GAEOzlTCEDBcqsbziiyhHvnbiwoI/+0tvlRfIN4UM/d1viE38G2LMCs0q8up8/q+cO
         9znHTzyhGCmW/bndJ+/nJgzFGu5jBFIFco/O0GPX0RCUVeuGHidqyc0VLPQzuR+IwMH8
         3XRCW2ZpCSvWCYawNxeY5l7bcwQO5nYXjG0atA3pnPoNlHWBMVkmp6JYxWzVj20le1zT
         TAxJdfJqUHtt0yZnCbWE/MCHd7iOS3KoOihcJbQ6ADtDrRYCA+MdB+RMRxUw+7gajRhm
         V2pjG/u5/bt/MaVnkWCbAg8ftgdSOPH0rmBvd9GtrqbFusYSjO0ZV7kLcxkXIQC5niA1
         yFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnulEUF+qKEePwDXKxeGeGtxQA2bAguCelUNMLELUoA=;
        b=GIAtwf7vly8sYoQyenHkMN+2uCno/t6SMVk4nRW6AmwaowAGZMrYYNeRtu7AE8iJUt
         m4lYSpVBI0avRrClW3Z6AZvjN6whqbHRb5O5d3bNneA2wleyBzC1uxMNwgUNVJZN27wv
         Bs8IpB2v4AkvFUcClN83lvcsPtmxoeD9zznQ1cVHObFTmSucs4WNmeub0fxmmZrwgwK8
         Rc9eYKMhSjDFZHhZbbf3CytgQJiGzxof/ZOU06Y/R+Qi4Bs4PoJy/tqicIwLhU3HCx6h
         xyfZ9EMaJKT+3AMCCKtiMZASuhnD8BK1oOb27ZVxNpVQqvGuee2JKcdfNb9vyKuXllrK
         MIaQ==
X-Gm-Message-State: AOAM530dvQcR05bxxJ2jOWmTekjZzIvW6uqxD3ydeQiDaruEDeePJZuD
        az1BMRIclbDpjjzSCHeWp7fNJXHxN7/acpZnqyc=
X-Google-Smtp-Source: ABdhPJzgnN4yFnHN23Q4Dpkk4qLOzNWWiWZYntyQKHmMNx3p9t8PwBqS0hk57D6bHXhfUC0FOO9DH0p0xp498ntZSvk=
X-Received: by 2002:a17:906:2dca:: with SMTP id h10mr6765363eji.507.1621551076357;
 Thu, 20 May 2021 15:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210520084809.8576-1-mgorman@techsingularity.net>
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 May 2021 15:51:04 -0700
Message-ID: <CAHbLzkrk=P5tXutvX+W4acB5UWpmtY2w0V6B+aaR_QXjTbMZGg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Clean W=1 build warnings for mm/
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 1:48 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> This is a janitorial only. During development of a tool to catch build
> warnings early to avoid tripping the Intel lkp-robot, I noticed that mm/
> is not clean for W=1. This is generally harmless but there is no harm in
> cleaning it up. It disrupts git blame a little but on relatively obvious
> lines that are unlikely to be git blame targets.
>
>  include/asm-generic/early_ioremap.h | 9 +++++++++
>  include/linux/mmzone.h              | 5 ++++-
>  include/linux/swap.h                | 6 +++++-
>  mm/internal.h                       | 3 +--
>  mm/mapping_dirty_helpers.c          | 2 +-
>  mm/memcontrol.c                     | 2 +-
>  mm/memory_hotplug.c                 | 6 +++---
>  mm/mmap_lock.c                      | 2 ++
>  mm/page_alloc.c                     | 2 +-
>  mm/vmalloc.c                        | 3 +++
>  mm/vmscan.c                         | 2 +-
>  mm/z3fold.c                         | 2 ++
>  mm/zbud.c                           | 2 ++
>  13 files changed, 35 insertions(+), 11 deletions(-)

The whole series looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> --
> 2.26.2
>
