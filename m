Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373993D5451
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhGZGy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:54:29 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:35695 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhGZGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:54:28 -0400
Received: by mail-vs1-f53.google.com with SMTP id p13so4742183vsg.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvM7HjIDAYdvcqBKdK4pW118x+lT4xSLF2Y4SSYHsTM=;
        b=lrpms40vOMAi2Ew9FCoh4D5gHJ7dkSghoTuNpY7XO0yCeLabBvzuOuJsA8sGkZNtwL
         6ee5Mp7PUIOFUrcjBlZz4QzKUUOxNVQfRC7rbR0qdyXaPVTJ97Tz7JlYICmesepjtD7v
         k/OLvF46aCAz+aBoXzkcqH6ULvtVxKM0zmIc980PrXp0kqF/o1xgdPUe1UrHw8XLZGQQ
         ZjN7e9Kyw9zJjfhciFHnIBUvrxUIB8nu3nyn35dxXSEKP/QpaBqYjhxl+/+Q6cATvGvP
         hgQiUOcAoPwMRo15SOMq00YapSkgDNzvkQajWhqL41wlDg95XP9YNQQseBT5RwGcClAD
         1q6g==
X-Gm-Message-State: AOAM533RiD7sYWGa426dkzhfKNVk5/y0ttacsCyoHm5mvUG9oDk/+sH5
        kOe1V4j2EqDMHTZudGDRacmuOz8Q73+ZoekYBts=
X-Google-Smtp-Source: ABdhPJx8y2O7mgeJAugSzCWIY61iUi7ZxClLxCsa1DNFsUBFPW2qrbU8WUBynTZ/eTGTlqN+R98llDtD2uuWvrBGo2s=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr11201079vsb.18.1627284896108;
 Mon, 26 Jul 2021 00:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210725104618.365790-1-geert@linux-m68k.org> <db2de193-a10-598-a21e-3a305b91d191@linux-m68k.org>
In-Reply-To: <db2de193-a10-598-a21e-3a305b91d191@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Jul 2021 09:34:45 +0200
Message-ID: <CAMuHMdWrg7zUC+iMjXS=RS=Fa7ZVS-0iycjQ2UP6W0pHzdGxKQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix asm register constraints for atomic ops
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Mon, Jul 26, 2021 at 1:45 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Sun, 25 Jul 2021, Geert Uytterhoeven wrote:
> > Fixes: d839bae4269aea46 ("locking,arch,m68k: Fold atomic_ops")
> > ...
> > Technically, the issue was present before, but I doubt adding pre-v3.18
> > Fixes tags would make any difference for stable...
>
> There is a better way to constrain backporting, that is Cc:
> stable@vger.kernel.org # 3.12+

I don't want to constrain backporting.

> The reason I mention it is that Fixes tags could be seen as a way to
> identify commits that introduce bugs, e.g. for the purposes of training

OK, had a look through the full log....
There are no other commits introducing the bug (renaming and
merging files without changing functions doesn't count), except for the
initial import into git. So I'll add that one, too.

> AIs, or attributing blame, or measuring quality etc. I think it would be
> unfair to point the finger at Peter's commit.

The first Fixes commit definitely introduced a new buggy user.
The second Fixes commit is debatable, as it copied the bug for a new
function from two functions that were removed in the process.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
