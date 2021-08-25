Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266693F7C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbhHYSJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhHYSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:09:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE3C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:09:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o10so708917lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvOoM/HsjOni7jc8lx3KVJCCfdVfhKFUs0BKkUfmS3E=;
        b=B1X2qLW79n6uvCp+DdrPlUbYaG77B4IZvTOIqyyfiPlLi7gaUSWnZKA5uJvtOAaqBE
         BSwA7l6E4MVgzm7nnrtfDN6ZyWZJVCrvCLPODm0TjGUW7w8kj5OSAKgwdDt4ww+0/e9b
         voZ09BF5BMRDvqXqXrqwZpd/yLgE7La2/rYlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvOoM/HsjOni7jc8lx3KVJCCfdVfhKFUs0BKkUfmS3E=;
        b=rvwbnQLP/ryoBQ9y/yhf5e/R3e/qZ3c/6Xw1R2kd2rABmnLPs1aUaTIC0ojqZZzqCg
         AB7sM0nHTHp9K6MPmcgv8094uzQcA/fjDogutvU6NPkumKmDp2vtwzlcnIABSsMkOHnx
         Z9KzvNfTvjcCOkmV3s0i0aKhiHE0B9PGBkpKalTVD4W8bEY8vsWakUhKw12CjgfK5qoF
         PBxtpkk6E0RAyrkHWPVGslXMLG5kahCvHTy3wqGmIiKV8aPY0L8/6jrQoCmMh8oYiSet
         Wh6+Q36itI7Z6DO+EYh5OUTw2Bdfxbks/0UrZti5VaSt3FsquaTP+0Rh7pK1cUbarSIk
         MaGg==
X-Gm-Message-State: AOAM532+Xa568O815XvUQBhLF8h5t8+CABxNVEkCVPjcCh3xDtfgoR4a
        I2EaF9kTRZdvWAJ5ySGJAAiJ5tV7I01T6/eO
X-Google-Smtp-Source: ABdhPJyLXhrUqswS3J7QTZF11g8yJTlkdrVSDOJfR5oGffsxCzdFI37R5d0z9hneTm3hlHEQonD6pQ==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr25474906lfc.650.1629914945793;
        Wed, 25 Aug 2021 11:09:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id n2sm68710lfi.229.2021.08.25.11.09.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 11:09:05 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s12so297391ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:09:04 -0700 (PDT)
X-Received: by 2002:a2e:8808:: with SMTP id x8mr37973457ljh.220.1629914944698;
 Wed, 25 Aug 2021 11:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210824165607.709387-1-sashal@kernel.org> <20210824165607.709387-74-sashal@kernel.org>
 <CAHk-=wiQhb689WEk__vLy-ET4rL69cjq39pGTmrKam=c_0LYGg@mail.gmail.com>
In-Reply-To: <CAHk-=wiQhb689WEk__vLy-ET4rL69cjq39pGTmrKam=c_0LYGg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Aug 2021 11:08:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjt1q++eBcxR0Q8WtJyNx5xyEXqA=z_3nXpBD6ZJmshEw@mail.gmail.com>
Message-ID: <CAHk-=wjt1q++eBcxR0Q8WtJyNx5xyEXqA=z_3nXpBD6ZJmshEw@mail.gmail.com>
Subject: Re: [PATCH 5.13 073/127] pipe: avoid unnecessary EPOLLET wakeups
 under normal loads
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 24, 2021 at 9:57 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> > [ Upstream commit 3b844826b6c6affa80755254da322b017358a2f4 ]
>
> This one has an odd performance regression report associated with it.
>
> Honestly, I don't understand the performance regression, but that's
> likely on me, not on the kernel test robot.

So my suspicion for the cause was confirmed by the kernel test robot
people, and I've applied the fix as commit fe67f4dd8daa ("pipe: do
FASYNC notifications for every pipe IO, not just state changes").

I suspect we are finally done with this saga (knock wood), and this
all could go into stable. As before, the regressions in question are
all for performance testing and likely there is no real-world impact
outside of that, so this shouldn't be in any way critical. I didn't
mark that thing for stable, but it may or may not be the right thing
to do.

I _think_ I fully understand all the problems we hit, and the fixes
are all obvious and straightforward and should be fine. But clearly a
lot of tests use pipes for doing various IO/scheduler/random latency
and throughput testing, so this all showed up in odd places.

              Linus
