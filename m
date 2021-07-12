Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DED3C59A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350650AbhGLJHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359261AbhGLI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:26:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC1DC04FB17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:20:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 11so18776735ljv.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jiw5cL5EfxnhrPe9bNG359WYG9lcXsKRuTKlfua2dE=;
        b=meFVtSyiW2AWPZBqOtdfVFHLwrhpAOxU/rwLZEdnH0EQYpFMYK1I2olti/az549KEV
         R2z0O56zqPW5yedvMaABQJkfybUJCX39+q22IV5/gUdmumoNjStNizeB7MEyfK/V+qZO
         laycdanmitH3Iauwpl60D1Xtq70TBYNQniL4HgUM3h/eNr4EB2fuH5EMJYKOmsgbo8kT
         bm5qeSXZkiqvt6k9LLxgPxaBCyVDnZquBx+35bVkotZ1kfA4/rxLzeaNa3VA3No3gVgy
         tBKQDPrQu0yqJqOwjE+b9Q8HcxEC+foslS0Ydv9m24fgqcrUwQBt/LUIo/pWERiX/bmQ
         OhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jiw5cL5EfxnhrPe9bNG359WYG9lcXsKRuTKlfua2dE=;
        b=QMtAXFxla7oTyLxXKhrJ0iM/Uwa0V3YGVIpc1XPbcJGAf9fR9+KD4zZFjWOcY/kpJl
         bwDiQvNx0vWA2f17WJJ1nBsQeFG77ChOM9jtXgRYI0131M4qtSXo9hBaJYbCm77E7A+Q
         fWs22qHo/lQGoWQOlBbphFNjRUdMrZNgfMuDWyHQnRYEmyovqFMfNdu2ODlyCCBjjuF0
         VCsfeg8rN/RnQwdMfyWBsAGv9FmFDx0eTQdgCNHanw5bj4TUiWVlmTor3Ou32Ea+6X7s
         v+CjzSMSj97NCNR2pi3iU6T9kXrwjKB8lo3ATJGB6cE+OJHvVqrnR6tgMtZ/0ej7fPIQ
         8GNA==
X-Gm-Message-State: AOAM533mfs7HvZdQwlRe7W6DSqgG8u1+5z/xcEQKGx3BZ0KPSS2kMNZP
        o2SlcHSiOD/VyPh3bPsokPp2RIGYNbjKv3KkTCE=
X-Google-Smtp-Source: ABdhPJx+IhMrRG7L8Tj5eHnJv2KShx75n3prxkK6CP5VuW7qW4rJSmVBWSHqjmedOdtOfcWbayKjLU0RTblRtlqwVy8=
X-Received: by 2002:a05:651c:1684:: with SMTP id bd4mr25138675ljb.287.1626077997583;
 Mon, 12 Jul 2021 01:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210618145534.438816-1-sxwjean@me.com>
In-Reply-To: <20210618145534.438816-1-sxwjean@me.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 12 Jul 2021 16:19:31 +0800
Message-ID: <CAEVVKH9W=O7aCfmkx=hwqHJ+-4wM_zSB0uG8n3PaXXbPptTPuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] some improvements for lockdep
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Will  you pick up this series?

Regards,
Xiongwei

On Fri, Jun 18, 2021 at 10:55 PM Xiongwei Song <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <sxwjean@gmail.com>
>
> Unlikely the checks of return values of graph walk will improve the
> performance to some degree, patch 1 and patch 2 are for this.
>
> The patch 3 will print a warning after counting lock deps when hitting
> bfs errors.
>
> v2:
> * For patch 3, avoid to call lockdep_unlock() twice after counting deps.
>   Please see https://lkml.org/lkml/2021/6/17/741.
>
> Xiongwei Song (3):
>   locking/lockdep: Unlikely bfs_error() inside
>   locking/lockdep: Unlikely conditons about BFS_RMATCH
>   locking/lockdep: Print possible warning after counting deps
>
>  kernel/locking/lockdep.c | 55 +++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
>
> --
> 2.30.2
>
