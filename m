Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4198843C656
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJ0JWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhJ0JWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:22:43 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD494C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:20:18 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x123so1771811qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZaeH8xfm8nuJT+C9vZxEFKjeBNQ5Q6FyX6gh6ZxM28=;
        b=V+YDR1jCCz0mBkrA+c7zBwqLgPoV7OAalEw5gcs5ieHp/pTMOyhSSGYJ61r2zfVXiV
         96IDdaO3fCKwr7BNjF25NuC1ZloQxAGwtMUMwtzO8+Ld1uWwj/Or0TgC9Bfk2Hc3rwJQ
         hL9foVdBOsG9eoSLqxRjhllZRgxEuicl4ygIW+aiHqs62mfurssYmboxGCosK8a/7h6p
         fN9h6gCfBxOAAdGUDhK74Pc4sa2IkNBFogkD+z6qCTAnzaXb6+jB4+m4g3+zVH+ZGb8P
         da3/QtzJIr5IQda1kPPBksN8Dzss8mRoMoadmLGxS8nStJcTZ1A01ylAPJqVV32OuDvp
         GecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZaeH8xfm8nuJT+C9vZxEFKjeBNQ5Q6FyX6gh6ZxM28=;
        b=RvlQXI9eMk97GZYn0ZPLX/uukxqD7/Lo+WIPFlHGlQHCt9zQ03k/uxge3FxKbaKSAN
         /iBaN6s3rXtfIXM4TCJpOxdhvLYi/FAHFmMJZyyClfJvFQQk0ng8Muwg2/vMJqSS7MZ9
         RAMQpsazAElj/wHJ1BcG/mC/MYT/IAMflZ5LasHL2ddJrKcDaKmcwc8mHDDs2//T2u4s
         IslmncyNiPl8CnGQSk5szxwmdYt9YbfojMScf8pr+TVRtB9s8EV653fusYmZPLFul2bl
         +z4h7cEXYX3IEG8AGfEoZrV154EIrICi1XL38vbQSk8+RFMgCa3DzuYPU1V71f8+IZ5R
         HlDg==
X-Gm-Message-State: AOAM531pOaAdgcoq7//rZuzaPmv6qq6y0uhNvaD7zoEl99Ar109FpVw5
        0bS92JhD8+mLwqRhBPwExFyAHbZm+H6IfWggrdQ=
X-Google-Smtp-Source: ABdhPJyquDWisQhtsVAixs3S/zN7zvLJhfe8MM1dfhnCwB6V6bSdxaB7WOAp9ZK+jgN7eFZKhXIpF4rbhnvgv3dsPhY=
X-Received: by 2002:a05:620a:9d3:: with SMTP id y19mr987133qky.412.1635326417759;
 Wed, 27 Oct 2021 02:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
 <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz> <CAGWkznHVHVBrQEiO32p2uX_5BDUMc1fE64KuV34WJfpwC_23Pw@mail.gmail.com>
 <YXkNJjD4axYlmqQ5@dhcp22.suse.cz>
In-Reply-To: <YXkNJjD4axYlmqQ5@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 27 Oct 2021 17:19:56 +0800
Message-ID: <CAGWkznHrZ=Y3kG5j5aYdTV2294QGrQbM6251zcdGphzCGUP6dw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: have kswapd only reclaiming use min protection on memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 4:26 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 27-10-21 15:46:19, Zhaoyang Huang wrote:
> > On Wed, Oct 27, 2021 at 3:20 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 27-10-21 15:01:50, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > For the kswapd only reclaiming, there is no chance to try again on
> > > > this group while direct reclaim has. fix it by judging gfp flag.
> > >
> > > There is no problem description (same as in your last submissions. Have
> > > you looked at the patch submission documentation as recommended
> > > previously?).
> > >
> > > Also this patch doesn't make any sense. Both direct reclaim and kswapd
> > > use a gfp mask which contains __GFP_DIRECT_RECLAIM (see balance_pgdat
> > > for the kswapd part)..
> > ok, but how does the reclaiming try with memcg's min protection on the
> > alloc without __GFP_DIRECT_RECLAIM?
>
> I do not follow. There is no need to protect memcg if the allocation
> request doesn't have __GFP_DIRECT_RECLAIM because that would fail the
> charge if a hard limit is reached, see try_charge_memcg and
> gfpflags_allow_blocking check.
>
> Background reclaim, on the other hand never breaches reclaim protection.
>
> What is the actual problem you want to solve?
Imagine there is an allocation with gfp_mask & ~GFP_DIRECT_RECLAIM and
all processes are under cgroups. Kswapd is the only hope here which
however has a low efficiency of get_scan_count. I would like to have
kswapd work as direct reclaim in 2nd round which will have
protection=memory.min.

>
> --
> Michal Hocko
> SUSE Labs
