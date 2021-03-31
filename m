Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0AA3509F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhCaWGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhCaWGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:06:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:06:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f26so25665615ljp.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QLAC5kN/WTgkwkL/JFTyfACTaPGT2EBf3L5262ee+4=;
        b=ADTGFd4lk9p+Q+wx9GIWrS3fgJRyAxfL9keWhU1AajmwQ7JNHeSKUjj8seO3YINUdT
         MVoDfIP75V7pkXaEvdPSxKJD55YG+eurYiLsXz8688cGJmg4fLD08X0dLETnO+zlcIY5
         Nsib1gSnvPeBnFv1H5zoO1DGqgcoyi3muxpG9bkVDDhREZkWZnkR2mqebP5KSv0ybqNn
         1oaLNsOF+4ydbnJ5+BkIHP11tui3h03YPgBP1dwtBWNHNvx+wp4F4PzDxOHHNqtInvbZ
         tC7GGOlPEpRowAN1evP0wYWXCo1yqu7o8kQcrYibnqwX6TVcdXj7AD1+b+e8YUXnceK3
         ls3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QLAC5kN/WTgkwkL/JFTyfACTaPGT2EBf3L5262ee+4=;
        b=oTXUDr23/B5lYSRs9i7VBThIoIGRsUlD3YSu+43tAb4jJC2oL+MarR4lZIEXXoyanp
         YKSo1SVeLja4yE8qHRQe62WCaWvkpUZKSpEwwkixNkO7+G0loMhLrEP4zJ1A0wdJai4U
         Uy58OPuwuBx/hdi0RmoDuN5GEHjW8hCrMU/XEytgQ0AnydDpH60PgmDXVztTOJWgIXTQ
         1r2RPUE03nLYVJbNqvtB4D2LJeMpIvldH4e3OvFw0KhuWdNP9Xye7kQYSJTZlYUVA+Dv
         sXRsgZj8EqkZrH+vuAK4khuR4IrgfwwKtM8nz4iA18H9WpdKNGZfLaRkGbSKGHVARSFh
         gOJw==
X-Gm-Message-State: AOAM5302BQ2uOI+5oUvG+hdsEf3qfyLNEknSnbaoODWvT548+MvtV5wQ
        wigFCfuU7VAnlHpezVV6aofTv0XljM5y+7B4BIYXbQ==
X-Google-Smtp-Source: ABdhPJyoZW5ZCpawMvEh8m06nfRQeoGo8aGODeEmAJXnZJmb8H0MPRbES64y2zB7W9P4SMx0Y1mqNcOQpk8Fd/JLhH8=
X-Received: by 2002:a2e:3603:: with SMTP id d3mr3354196lja.495.1617228376110;
 Wed, 31 Mar 2021 15:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210330230249.709221-1-jiancai@google.com> <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net> <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
 <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com> <20210331215802.r4rp6wynjqutdoup@archlinux-ax161>
In-Reply-To: <20210331215802.r4rp6wynjqutdoup@archlinux-ax161>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 31 Mar 2021 15:06:05 -0700
Message-ID: <CAKwvOdmoud9=Uf2xN7q1c1gP06ZNU4K2-Q5PDD-LTynHC+qOMA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
To:     Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Jian Cai <jiancai@google.com>, Guenter Roeck <linux@roeck-us.net>,
        Christopher Di Bella <cjdb@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Mar 31, 2021 at 02:27:03PM -0700, Jian Cai wrote:
> >
> > I just realized you already proposed solutions for skipping the check
> > in https://lore.kernel.org/linux-block/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/#t.
> > Do you have any plans to send them for review?
>
> I was hoping to gather some feedback on which option would be preferred
> by Jens and the other ClangBuiltLinux folks before I sent them along. I
> can send the first just to see what kind of feedback I can gather.

Either approach is fine by me. The smaller might be easier to get
accepted into stable. The larger approach will probably become more
useful in the future (having the diag infra work properly with clang).
I think the ball is kind of in Jens' court to decide.  Would doing
both be appropriate, Jens? Have the smaller patch tagged for stable
disabling it for the whole file, then another commit on top not tagged
for stable that adds the diag infra, and a third on top replacing the
file level warning disablement with local diags to isolate this down
to one case?  It's a fair but small amount of churn IMO; but if Jens
is not opposed it seems fine?
-- 
Thanks,
~Nick Desaulniers
