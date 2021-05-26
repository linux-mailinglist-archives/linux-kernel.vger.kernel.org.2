Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7A392165
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhEZUVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhEZUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:21:49 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F73C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 13:20:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c3so2785778oic.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=fqFRJj/H0421cmdUHy5MiAH5BPkuY5lwOXhKnmr6YX8=;
        b=bWyT5uik5LFbEbtHC/QkvEhIAEBoh4m2QVgGQCpbyBfevTfRutPAVwzFDfOJIYUweL
         h50y3P6QR9wFBoR2J4HYDOvx9PKjVjFGNK1RK+DABJ4zt8dzaXN4/1brL1FCq4LP4Z0V
         zJG8uLzlOnGRCXFjgf/F35i5k++TuVTgLTj8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=fqFRJj/H0421cmdUHy5MiAH5BPkuY5lwOXhKnmr6YX8=;
        b=lZRbS4YK0CrorstM4Drcco2FMPVEuxi6tgkly8gKhWToJGtLmc4zG7bSW+zBbJdvec
         SNFFFn1yYo+buwI64AG5WRjqw3R2OH6vxU+UrLicYsHqfmLjZDSj20Wt9CFHb1N20jmA
         ArCtsV5fz5Ottu0M8ioOvftUNHeg06LYhOlN6nHyDQ9Knd6f20giR33MvizcID7Vm8T8
         9Dd0KdgLL9MWj/LyPbzkJLh2hViX4AD3IYkkGuZmIkjbUppax0MglhkOaUIII3K/8c9/
         ExBnb+g6kpW8ydSwa3pp3ue51pILtjFMcCk9w7Yq/fG0/G8ZNP63Y65Fc7LXkJM8dZJG
         QFVw==
X-Gm-Message-State: AOAM530RoV2v03cfQRrywDw1hT6/3ckVVjbbHg11mLkFWDcnXZb3ixyO
        Va8dsxxU/37HAk25T3YpT1lEGbHdp2qdZsoPOAONpg==
X-Google-Smtp-Source: ABdhPJy99awNtyh5dTExQ4QXD1TMtQFD6lpm7mhJDcOWhrNz8PtqTy4TGH9OqBxmADLKe5YKljyWxBfvjQfYal4flHY=
X-Received: by 2002:aca:654d:: with SMTP id j13mr3221559oiw.125.1622060416706;
 Wed, 26 May 2021 13:20:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 May 2021 16:20:16 -0400
MIME-Version: 1.0
In-Reply-To: <d6a4c360-0bbc-e36f-0824-04562c92f411@suse.cz>
References: <20210526025625.601023-1-swboyd@chromium.org> <20210526025625.601023-2-swboyd@chromium.org>
 <CAMZfGtVdzwjJLuUvcmgivKZNU1TK+ePFH9wgcm6jH86FWFHbJA@mail.gmail.com> <d6a4c360-0bbc-e36f-0824-04562c92f411@suse.cz>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 26 May 2021 16:20:16 -0400
Message-ID: <CAE-0n512-XLKetgOo61reSBu=27zTttC1YK2iRjNuGrLBu+q5w@mail.gmail.com>
Subject: Re: [External] [PATCH v2 1/4] slub: Restore slub_debug=- behavior
To:     Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vlastimil Babka (2021-05-26 03:39:54)
> On 5/26/21 6:04 AM, Muchun Song wrote:
> > On Wed, May 26, 2021 at 10:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >>
> >> Passing slub_debug=- on the kernel commandline is supposed to disable
> >> slub debugging. This is especially useful with CONFIG_SLUB_DEBUG_ON
> >> where the default is to have slub debugging enabled in the build. Due to
> >> some code reorganization this behavior was dropped, but the code to make
> >> it work mostly stuck around. Restore the previous behavior by disabling
> >> the static key when we parse the commandline and see that we're trying
> >> to disable slub debugging.
> >>
> >> Cc: Vlastimil Babka <vbabka@suse.cz>
> >> Fixes: e17f1dfba37b ("mm, slub: extend slub_debug syntax for multiple blocks")
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> >
> > Is it caused by the commit ca0cab65ea2b ("mm, slub: introduce static
> > key for slub_debug()")?
>
> Yep, looks like a better Fixes: candidate.
>

Fixed it. Thanks.
