Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EA3B9A72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhGBBRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhGBBRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:17:14 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6B5C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 18:14:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id g3so8286175ilj.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 18:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6q+d+OSdqVyGZpPkY0K+9RZhaSmWq15QL3d6lDBiig=;
        b=b4KSksceqlL1Ymhgf0eJbzBnqOuotNfgFAu60oXn/fwfIxcnppIFg8t3yrMUtgEqFh
         OMfan0zuHGaK9PJ1iXGxdrD3nLRQMnUe2eX4l+KIMUzoZvvfHq7rSr61P0lEHo9cQl3f
         EvvU8LsGd17/dhrDgNFu+3fLVyZw6DYKYSLtT1tqh2w1M520AHNAvRTVxwjkdsaOoYha
         E8LAD31fv4mi+6696D5JpuiDUU3uQe7XNutds3Z6jzbS0ovXSVTEl2qW4U/mCnS+/gJF
         BDCeTucAoD57zGJkiLMXX3W+IpDE++EqD96ZdVst/RTCkFZnQ38bSBioNE+iS2pURPl9
         Pf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6q+d+OSdqVyGZpPkY0K+9RZhaSmWq15QL3d6lDBiig=;
        b=LGwuQ998vZA2yYt8uFipCpHAiznlzAPHraPG6mGOUukKY1d6wvGyrTkM+xX2JbPD5q
         ya3D4WutKyB52UlNoe44Cap5mpNcezu2qmm9ssSADSgnlmqpOjFXwVyMVJTTHOb3RIJx
         /RE9zba9e7aRHWPVk5My7sloO6m3YXCqMiyd15IJQ06CSwwLI0uvwjNG6bWQsbc9CTzv
         dy/mJvPk5UofOkSfIAI1d/g+RvZwJkATjcQYTzDMeAZg0QiWUnza2I8la1HvrpMXrRcc
         4Ol1IVNX1kmYK+fe/5tZO3Dut0J4VSJhstrx9wZ44vIrbW93YrOF3HtBy8TSyEIJoTbq
         xQkA==
X-Gm-Message-State: AOAM531azUPSReuy6FZTxkS1pUM15yAvEYTPPt4qkK6m003LtkATo6kK
        9Yl2AM/aXHDfBM2RL8Vs/GqqZOwGWXczGgwIeww=
X-Google-Smtp-Source: ABdhPJzQhUbJyF6fb4MyLJXFciJ/bK6uVcSFO+VlanZegVoqHJwCr06KFd8Eyk7mp511eLN2XQw5mT5d+oflu8gtN/c=
X-Received: by 2002:a05:6e02:114e:: with SMTP id o14mr1543607ill.201.1625188481988;
 Thu, 01 Jul 2021 18:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210701204246.2037142-1-agruenba@redhat.com> <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
 <CAHc6FU5XMfTOBW1a0OnMaPSmgWECvO-KYAo8HeVNsCyd-HyV3g@mail.gmail.com>
 <CAHk-=whaRsSuUeVBn_rLECWyG6h9RGuF9idsT_S+==vnsT8org@mail.gmail.com> <CAHk-=whnHfghvfLAteVeOTyDbypZ=Y7WBHfYByoVZa9SMxKe1w@mail.gmail.com>
In-Reply-To: <CAHk-=whnHfghvfLAteVeOTyDbypZ=Y7WBHfYByoVZa9SMxKe1w@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 2 Jul 2021 03:14:30 +0200
Message-ID: <CAHpGcMJg5b+GYjgTtLPO2xdFCP_-efx-rh807nTud5Tdb9cmsA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix mmap + page fault deadlocks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 2. Juli 2021 um 02:48 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
> On Thu, Jul 1, 2021 at 5:30 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Of course, if you ask for more data than the file has, that's another
> > thing, but who really does that with direct-IO? And if they do, why
> > should we care about their silly behavior?
>
> Now, if the issue is that people do IO for bigger areas than you have
> memory for, then I think that's a chunking issue. I don't think the
> ITER_IOVEC necessarily needs to be converted to an ITER_BVEC in one
> single go. That would indeed be painful if somebody tries to do some
> huge direct-IO when they just don't have the memory for it.
>
> But the fact is, direct-IO has been an incredible pain-point for
> decades, because it's (a) unusual, (b) buggy and (c) has very little
> overall design and common code.
>
> The three issues are likely intimately tied together.
>
> The iomap code at least has tried to make for much more common code,
> but I really think some direct-IO people should seriously reconsider
> how they are doing things when there are fundamental deadlocks in the
> design.
>
> And I do think that a ITER_IOVEC -> ITER_BVEC conversion function
> might be a really really good idea to solve this problem.

I've tried to explain above how keeping the user-space pages
referenced will just lead to different kinds of deadlocks. That is the
problem with this approach.

> There's even
> a very natural chunking algorithm: try to do as much as possible with
> get_user_pages_fast() - so that if you already *have* the memory, you
> can do the full IO (or at least a big part of it).
>
> And if get_user_pages_fast() only gives you a small area - or nothing
> at all - you chunk it down aggressively, and realize that "oh, doing
> direct-IO when user space is paged out might not be the most optimal
> case".
>
>               Linus

Thanks,
Andreas
