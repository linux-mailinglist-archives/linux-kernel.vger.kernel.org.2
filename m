Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2609E3C63C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhGLTdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhGLTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:33:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF75C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:30:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u13so6244075lfs.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3C0MNcdPuaQMoy2DZLesW5CVXpDYfQzTqrwGXdHaRg=;
        b=MJrdQt/xj/X89L2akDuRIxLQO4djMTLLgU8eBvU6YVC8dUlC07Y6kHh4rBlkT1q7MV
         Ea7nnfbhd2stzRZFtdTC0KqSjngvfVy93JncJKAiLwNmjmfcozdphfyI2xTiy3uOptFv
         Vhn12vpbGZd8c3Bo7seoaaiJzsRoQUlb47+hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3C0MNcdPuaQMoy2DZLesW5CVXpDYfQzTqrwGXdHaRg=;
        b=MHqROs3reMyc7ki0+MKYVndS6tdJDCO815CZG2+kB2nzBqzDId0i5THIhswb8AnL/q
         riNqTkfwpJ2nP8jZY76ro6Hm19ufK++Vx1VhhJRf5gQ/XbT1ED5MrgXyLES0MqQnoVxG
         v6FM8W9vdVY/VBldqSqz2+M1mLWkgGhKqAr9ECe/hgBc0UEKDYt+Huh/1PIWJK+xEelL
         G+rJ8ySkw/wReKS8c/bmfg8I982l/8gCCnAJtNLIHDvyoyZnXJdqNxEBEfbsXLGqJBhU
         ijiWEI3qAlJCMzUbX+8cqZGTjBIfKq1z9qkZcMRnlfv1gRR2J32fOTpEp3uiQErHEAJB
         SQ8Q==
X-Gm-Message-State: AOAM531Vf6IEOT7uKMQt1rYoIBKcJBqXfsOTMpoGdZRJmIt+i3I5Q5Cb
        wye5cjNOlOKiOIzrTfdZ/RdBMwvO8/g3O/GnBWE=
X-Google-Smtp-Source: ABdhPJzK3K4yU3M7GNsFsmZJDQzHlCeQwR8zte1PzcPwoiFaWonczTSSfeFIgF69CPrCFt2uL+IB5w==
X-Received: by 2002:a19:c38b:: with SMTP id t133mr250342lff.329.1626118229457;
        Mon, 12 Jul 2021 12:30:29 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v8sm1679841ljg.137.2021.07.12.12.30.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:30:29 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a12so386520lfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:30:29 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr639513ljg.48.1626117867421;
 Mon, 12 Jul 2021 12:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060928.4161649-1-hch@lst.de>
In-Reply-To: <20210712060928.4161649-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 12:24:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whd0GaAH7gHuEiuKjOeD6JGKY1q5ydG1TCKjVBFNBUEJA@mail.gmail.com>
Message-ID: <CAHk-=whd0GaAH7gHuEiuKjOeD6JGKY1q5ydG1TCKjVBFNBUEJA@mail.gmail.com>
Subject: Re: flush_kernel_dcache_page fixes and removal
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Russell King <linux@armlinux.org.uk>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geoff Levand <geoff@infradead.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alex Shi <alexs@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 11:09 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I think we should just remove it and eat the very minor overhead in
> exec rather than confusing poor driver writers.

Ack.

I think architectures that have virtual caches might want to think
about this patch a bit more, but on the whole I can't argue against
the "it's badly documented and misused".

No sane architecture will care, since dcache will be coherent (there
are more issues on the I$ side, but that's a different issue)

              Linus
