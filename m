Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70344322F68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhBWROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhBWROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:14:44 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2725DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:14:02 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p21so12268895lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gExe93wosmSzhyTwQXk9LaYNy6KAG9KuAxNWYjdijs=;
        b=PmRPXaIRufMdXn11znSEzdNe2b7nW+xn8hiKWpkTwBcKRg7vqYs9aaJoAbxqGxuv7z
         EnigZQfkpGYgjbzOIrnB90HxpeLL1yaVXyCcQ1jHx4CGi8JmAp/Hgk6yWJqzhPgO3Q+l
         AIsHCrL6NAWifWmyc/g4ZZoRhfUMNkuCfI0DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gExe93wosmSzhyTwQXk9LaYNy6KAG9KuAxNWYjdijs=;
        b=cuXTmLrbx/S+Pu8xH3FVBNy1IR9lS1BrsHBwNOW/H/un+fVV3jWRNRUeZ/Krh8bG40
         K+tM84uu9ttCwIHs7/iW92y1oLDIZNRl2UVM+SdZ2miE2ceD6hZO2fG4hbwvtyNAev2D
         8nqTRs6C4pYtI8WwSWNHfy5Jm7EfVH/zYwe5esEvZdcX646QlzbS9IKY1L3hChSerKo0
         lD0AwpDhBQ2BanRHS6pbHydJtNz1A5sEOMdvNLbv3LKidDzoWS9qTw3dvuCpVOz7EpQl
         6tEmaeYFPnxghhRNa/kAmFlQhnt7NyUiU3TUHXibCVsKLjY014BAwnHtHz5mtjl7hiT9
         zhBw==
X-Gm-Message-State: AOAM530xNMnOjX6nuRrJ+Ne3Ml7QjaBiqiGyFbwRNeqKiROzbGNYrmN7
        BCsmBsgQiyIZ5VEgLfzdgavauw7BgWqFGQ==
X-Google-Smtp-Source: ABdhPJyUc/EfW0u/b308oI8ThziDRgtnbwj9sjIiMAFhhaMGjw5PnPLUdxxteeVQZc3vWvlvV2l12A==
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr17204840lfu.328.1614100440229;
        Tue, 23 Feb 2021 09:14:00 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id o19sm2739503lfu.182.2021.02.23.09.13.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 09:13:59 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id p21so12268713lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:13:59 -0800 (PST)
X-Received: by 2002:a19:8186:: with SMTP id c128mr16927725lfd.377.1614100438784;
 Tue, 23 Feb 2021 09:13:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614090658.git.dsterba@suse.com>
In-Reply-To: <cover.1614090658.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 09:13:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
Message-ID: <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
Subject: Re: [GIT PULL] Kmap conversions for 5.12
To:     David Sterba <dsterba@suse.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 7:03 AM David Sterba <dsterba@suse.com> wrote:
> Ira Weiny (8):
>       iov_iter: Remove memzero_page() in favor of zero_user()

Ugh. I absolutely _detest_ this patch.

"zero_user()" is a completely horrendous function, and not at all the
same as memzero_page().

Just look at it.

Yes, it's mis-used in a lot of places that really always wanted
"memzero_page()", but this conversion is going exactly the wrong way
around.

Existing users of that zero_user() should have been converted to
memzero_page(), rather than doing it this way.

The "user" naming should have given it away. It's a very very magical
interface for user-mapped pages that have additional odd issues (ie
look at the dcache flushing etc).

I'll think some more about this pull request, but honestly, this one
broken is pretty much enough for me to say "No way in hell", because
it shows a complete disregard for sanity.

The last commit in the series:

>       btrfs: convert to zero_user()

is also very mixed up about whether it actually wants the dcache
flushing or not (and thus zero_user() or memzero_page()).

Honestly, I suspect all the dcache flushing is totally pointless,
because any architecture with virtual caches that does kmap needs to
flush at kunmap anyway, afaik. Some of it is probably just voodoo
programming and copying a pattern.

But in any case, zero_user() is not the same thing as memzero_page(),
and even if they *were* the same thing, zero_user() is objectively the
horribly much worse name.

              Linus
