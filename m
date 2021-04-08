Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E543F358F38
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhDHVeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhDHVeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:34:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF782C061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 14:33:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 12so6285120lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GAe8cx+DQ36uj87QfK1vmv5DX5/MYkySxpHobTWigs=;
        b=buFszRZOuSOOHiCnsBeGh/08c/C+zmSQGyphU2zQcqRoVaJuOYygfJPPpm4d/nej2M
         EW2bmaG2cKotYl40dL9/3GqcDhwL25KPO1/EngaDxBaS8cmfDt0DP45PRxuvwd2nj4bB
         zMwOM96Slk9BYpOHMC7JOSW/EuhFs1OYJsRMW8LZt+wmCt4Sh3+F6sW5imaAzQWzuZ32
         0tuahzhSw8N/D5JCkcb1+Y+jeOAv3I01EoGNc+fWoJvFNAwCR803rbIZPUIIuesXeCFd
         H/hZN+/haSEjydOcEGIjaYOm2utYx9XT8iU0BCRTaiV4QJa6ZWoFX9k303vKToG1u248
         LmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GAe8cx+DQ36uj87QfK1vmv5DX5/MYkySxpHobTWigs=;
        b=OFY5s7RNnd3nRbsMGfSt1IPgo8XQUet8ImPd4oIjduJ/CxnIdWJjMYpTYfdtYIVJGY
         GeY8FDiwevOCnum8vlKpkWs9/B3fG/B74TSdG6/USejGFwCIkSs66Cq0sdRVurlyqqt7
         fsLtWt8TQyhTC52Vlvp/DDDoDm02q20UisOIg2TVYQCdTUZnLSfwe2eR2+Ex963+Ag/E
         REqQX3Ul6iIzprsP2/vSicuiLt/YVZ4ltUMZ+W61GRXZJ+r6h9ThfY2NGj87AqM3Vi2J
         ndNkmHatfW+VTyJZW0EK1nY8D8bll0zR/vvMu5rLd52KAkp6p0OHBy417l9kPOzeQ9F5
         D7ZQ==
X-Gm-Message-State: AOAM531ztPK99s3P22amdgGkD18VvI2nz5AUD9v86tWoIqYkWN2PrqEk
        YG3U8gcbsHJTRsWhtb9qE+bvxW+6Xt50/QkFyAmywA==
X-Google-Smtp-Source: ABdhPJwINlgQ/Bd3f8BKg30apChWFa6cxVJNyiqM/fRLcKw2d6BG3B72xp75asvLGchFbFzl6IcZrDZjLeXJiadZ8ds=
X-Received: by 2002:a05:6512:c04:: with SMTP id z4mr8234032lfu.299.1617917634901;
 Thu, 08 Apr 2021 14:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617831474.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1617831474.git.dxu@dxuuu.xyz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 8 Apr 2021 14:33:43 -0700
Message-ID: <CALvZod4kefNWPAwKZdpO8z29sJ2jDh74_C5Y_FSgXFB8s5ZXGA@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/1] bpf: Add page cache iterator
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, jolsa@kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 2:47 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> There currently does not exist a way to answer the question: "What is in
> the page cache?". There are various heuristics and counters but nothing
> that can tell you anything like:
>
>   * 3M from /home/dxu/foo.txt
>   * 5K from ...
>   * etc.
>

So, you need the list of inodes for a filesystem that are in memory.
With that list, you can open, map and do mincore on them?

I don't know of a way to get that inode list.

> The answer to the question is particularly useful in the stacked
> container world. Stacked containers implies multiple containers are run
> on the same physical host. Memory is precious resource on some (if not
> most) of these systems. On these systems, it's useful to know how much
> duplicated data is in the page cache. Once you know the answer, you can
> do something about it. One possible technique would be bind mount common
> items from the root host into each container.
>

Oh you want to share page cache between different containers/jobs?
That would complicate charging.
