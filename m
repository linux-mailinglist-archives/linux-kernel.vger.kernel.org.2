Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF23F9BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbhH0PX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbhH0PX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:23:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C0C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:22:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l18so12006340lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12EwHYLs5eOm6quA+sm5cigmgg54YxcYAcpzFTkzTao=;
        b=jEpVum+lZp9b+V7si+VhVikOieyqbKysSBBXz1GeJAcrqjxbumhj6CG8FX6yRs56wo
         L+OZYerWMsGR6sJ3brzUy0IN39xDSptABdOkE3A6MSjbaKbmDbYqiQonD8NQQXozTemh
         vaSQQhHvMvfIr/RKr6j7hJVXR1ZXYwzuynk0dAptC0ikewkSAfXS4EdUBCYpUaqQZ6oE
         DTXQf87AGv4BliNaG8mvaq8VmMVI7IIiuU1TJ8fncxif4Kq+RVg77F9E9A0lTxxzCvCD
         yu5KJs3zrJ/ez/baVFiKRtkHpkr+gLxv2yqmYCjITAnC2qWJJQEDRdAbWsUwDT9UFy7P
         bETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12EwHYLs5eOm6quA+sm5cigmgg54YxcYAcpzFTkzTao=;
        b=Bg+uYh0xP8s5ySnmdmjLclxWEwgpOaLDp/xd8/93/lFUWpj+qxopgNoSxA6wLc2/Z5
         0gjWK18dAMoOlBRw6lA2JLdE5wCH095EN2aJgqgDGWXOOa4bY2mNh9S2dQf9M2WU4H6G
         4YTSYvbMzuCv5TOnXL+aYVtnP7N8/MVrArNv+OAzDmWPgNn7ny0ZEl+STF3/Jtg16zXH
         gIymhTdVMwbTyBsrTgUZgwEAlr2mIK1htVc6s1XFkWrdFE6kTTOR9ynFioQKmjJKgZ3M
         vw1o+bb+ILT0OpLwf5urbQwTwTXDGj/8Q4Qso3iLuRnfWUXDzrst+BXm3OoJ95BUaldg
         +jYw==
X-Gm-Message-State: AOAM530Zns6Hu2E1TG/tBMcTh7IgPp3f27xt6ePTdEIXp7NGLsIgVC2b
        3ixCsEz1J9T3o+Md1EhXp4NrMRaHhIM69eBm3UU=
X-Google-Smtp-Source: ABdhPJxWbKzBq4Syh4W699pjantVPGtpyDFbhimXMVsIQwhZumoSStC3iUlQZcQW1Mr/Lno5EIfKvAemGvjTGt1M7IQ=
X-Received: by 2002:a2e:2d01:: with SMTP id t1mr8022273ljt.400.1630077756278;
 Fri, 27 Aug 2021 08:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210825185747.1627497-1-daeho43@gmail.com> <1f1e6d38-6bd1-17ea-b8ca-a45d1244728f@kernel.org>
In-Reply-To: <1f1e6d38-6bd1-17ea-b8ca-a45d1244728f@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 27 Aug 2021 08:22:25 -0700
Message-ID: <CACOAw_yhgo1_wrejKskSm=Rsw27ogx=TS_A=z=-NGLcecA-gYA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce fragment allocation mode
 mount option
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to add a fixed chunk/hole fragmentation mode in addition, then
> userspace can control the fragmented chunk/hole with fixed size.
>
> How do you think of renaming "fragment:block" to "fragment:rand_block", and
> then I can add "fragment:fixed_block" option and its logic in addition?
>

The reason I added the randomness on these values is the segment
selection in SSR mode.
If all the segments have the same free block counts, f2fs will
allocate a new segment sequentially in SSR.
This was what I didn't want. Plus, in the real world, the size of hole
and chunk will be different in different segments.

But, if you think we need this "fragment:fixed_block" mode, I am happy
to have it. :)

> Do we need to consider multiple thread scenario? in such case,
> .fragment_remained_chunk may update randomly.
>
> In addition, multiple log headers share one .fragment_remained_chunk,
> it may cause unexpected result, it means there may be continuous holes
> or chunks in locality due to swithing between different log headers.
>
> Thanks,
>

Oh, I overlooked that point. I am going to add the variable for each
segment as you said before.

Thanks,
