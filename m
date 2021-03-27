Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1AC34B742
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhC0MlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 08:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0MlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 08:41:21 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA1C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 05:41:21 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id r8so2489007ual.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhhAdU2vyDWR26PJABfghl4j1PHQiIGVcs1RWv+L0aU=;
        b=QlSGlJscqNG3+XnbGoq58V3wf0SqefEhVk5krkgarOFm+trASoVXSyR+q41GNgyyub
         S1T+4kfVz/EpnprlKEvg8plSNwBIkQ1PAxqnLLf23s3xhO2nvyTRHfD9AhHN9DX187V2
         tciKgo1hXbBBvvgPtlYtpb6AAmglNi6cT3g1gb0AQWIp7XkA90ko8bwEKczf68qX3+KO
         Zxu49s/VYWyZtxlfeUUWBRQJEB3IWjUuUdooGbLF162lGo2JQKhuqKobt+qfFSdK8Xx8
         zNoBtpz7WELvc2fTBIy7vxWRFGC1kNYvbeQQB7x7jWirpwY/0XZD4A4d5FkJG22fFXNw
         fKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhhAdU2vyDWR26PJABfghl4j1PHQiIGVcs1RWv+L0aU=;
        b=qVVjAzOjAgTvisi2c4WtbWptAETpC7pdLVuDqSHFmXPXDmPvaSlCKwqisI2l9CMTAG
         SK737AVDR5xzeuhy/4qiMd6EpKAexNayqabOTjC2KV1WIh3P+TE7PacdfL2Q+bjkKSRW
         MGDq/cVkm3gveNLL4swC1c3d//QG3LiaSfsQnKkyjYy1Q9zV6D97+IxruPyKYaB1nEk/
         is/pybZeWCQW3FI2vDdYuzzIIi8ww7bUFEFUX6/Pm9IUQy9P97z6/sfN3pyTtg5nw1/N
         4UvXAHxbaCy2NCdQv1U2FAM8nA1bBouxTRMUCM+ygO4mIEpVqrnMGb9xLiQboOOm7ASy
         9S0Q==
X-Gm-Message-State: AOAM532JYH3iLvD076D9+tAJXYiwMhadYnYQLsYCKQk5+2g4abNgLa1E
        4aqOvi/r76saADW9QBwRbS2tAM7ATTX/JL04hvg=
X-Google-Smtp-Source: ABdhPJww1VHQhW4Eu1qqEf6Q/bjaehaCbOn5zArIN5usN8LpB7lovOX/dm1BjPaaI9mwryTbRpz958MzXhCd3axbOes=
X-Received: by 2002:a9f:24c7:: with SMTP id 65mr9957841uar.119.1616848880860;
 Sat, 27 Mar 2021 05:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <CALaQ_hosk7627nTx97+xSSsGiN-qt=pTGNW4DZn4TOcAeRSC8g@mail.gmail.com>
 <20200714000347.GA19314@google.com> <CALaQ_hriyvF8yaSihvGEN1U2jufCQ5sj=aknN+1xB=4EbkBWaQ@mail.gmail.com>
 <20200714055407.GA94278@google.com> <CALaQ_hoviFQeBXODari+gzbBNkHCJk0u9Hqa3EzHksscrhKj1A@mail.gmail.com>
In-Reply-To: <CALaQ_hoviFQeBXODari+gzbBNkHCJk0u9Hqa3EzHksscrhKj1A@mail.gmail.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Sat, 27 Mar 2021 07:41:09 -0500
Message-ID: <CALaQ_hq+Cxt7BhcEAMWXFwaOGVtVs6+kOZqoYPvze7ee-USY9A@mail.gmail.com>
Subject: Re: F2FS Segmentation Fault
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know how much of it was the issue, but when I unmounted the
sd-card, and closed the cryptsetup for it, and then ran
non-destructive badblocks on it, I was getting ONLY errors.
I stopped bb, then pulled out the card, blew on it, wiped down the
contacts with rubbing alcohol, let it dry, put it back in and now bb
is running cleanly.
I then stopped bb, tried to cryptsetup-open it and it said the
partition is not a valid LUKS device.
Weird since I was using non-destructive.
Looks like I'm now forced to rebuild that partition.

I wish I had troubleshot the aspect of the sd-card being properly
seated. I know I've experienced something similar to it in the past
where files suddenly aren't able to be read. Once I reseat the
sd-card, everything was fine.
The last time I had to even remove the card was maybe 1-2 weeks ago
when I had to deal with a noisy power-supply fan.

The whole debacle (including btrfs, keyboard leds blinking) may very
well have been from the sd-card not being seated well.

On Sat, Mar 27, 2021 at 7:02 AM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> An update, not quite 1 year later. I encountered another segfault issue.
>
> It began with my email report to the linux-btrfs mailing list titled
> "BTRFS Balance Hard System Crash (Blinking LEDs)" just the other day.
...
