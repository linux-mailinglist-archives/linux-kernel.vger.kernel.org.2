Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5F3D10EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhGUNcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhGUNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:32:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC061C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:13:07 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id g5so3434395ybu.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxJG9dhJg971EM1jTPDx1+rVCA7QuZrtXkki4ARdNb8=;
        b=gZAsc/0UAAHZxhjucvY5bco5lvrJ234R6bxUbpmbGrSrKWsLFdJz9u7HmdS+twGVjv
         CGt6f+7RyrcyijIYHxvjW6uuPyYQAPeOGRcdAWDswEMd4+rX1vXjy6W27zBkx5Qk+7Y/
         VPiWVXBF8ujEeur8XUkJNDJ191QnpBiwR0NkLUNHr/tIcO/wp6yasvZhqhSYMT2jIDam
         C1as+EeklfSoAwrABny4giJLfzrnBTBwMOsC13xnwf2NMgGZA+OT0xYgnKKF5gR7rAEg
         bUTJVA1Ltg0DVZgGI8PoR+E6fQ8+pHpyD4tAQ4r7VPs3q28irXIgTjqTvMWutoYO5YhV
         eVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxJG9dhJg971EM1jTPDx1+rVCA7QuZrtXkki4ARdNb8=;
        b=XNkbJO0ihjURvvpyZs44uPuuM+zDcgZmgbSlDSUZEaCbk3cZdyDvaY3d+7PRrza2Tg
         /ToStq0JrOr+uagPGv1f4VRqRgT02xtpSwj3+GCaYCHgKhU0gF0vDweM9k8iUxIxDb6a
         Wz/XBe5UAWyzOHy+ytyQLGKGt9tsu0TKiyfPgN+bTNLeF6BDzePKYCwbJ5oW7peYHrth
         HoUMKicTbke2h5aWoW+wYzfPm4ybgnc0KX12pnQVZ/NlKC44vBaBZvc/8ERYJS8eCwPt
         K57NG+OSBbHq4iB5RHg0rHf833CYm8+xifXs5E9IEGCq2XuYOyAbAtlfMlqLdthZ9WAh
         YTaQ==
X-Gm-Message-State: AOAM531Z/7MA28K30U05mg9TA0+NssYwcBhjVqSzL1akgDBxfPVSRXhN
        r2BYq587Bk6Wx90Z9T1+T+5GltKOSsauz2kn0zI=
X-Google-Smtp-Source: ABdhPJyb9EnIJ1cSuH2LGGqh5iBWZSsCltT9+kvwIltvVqLIela9b8rmEnBATlbpKqxJqJ5ktIGP3U9Jux9/NHl5uOE=
X-Received: by 2002:a25:7cc6:: with SMTP id x189mr48172992ybc.371.1626876787088;
 Wed, 21 Jul 2021 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210721075937.696811-1-alex@ghiti.fr>
In-Reply-To: <20210721075937.696811-1-alex@ghiti.fr>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Wed, 21 Jul 2021 16:12:56 +0200
Message-ID: <CANBLGcyqOKgoQr3EWvgTKewj9PtbzZ4STOz5KXHm78JQYc0G4w@mail.gmail.com>
Subject: Re: [PATCH -fixes 0/3] Fixes regarding CONFIG_PHYS_RAM_BASE
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 at 10:00, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> The following commits:
>
> 7094e6acaf7a ("riscv: Simplify xip and !xip kernel address conversion macros")
> 9b79878ced8f ("riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED")
>
> expose CONFIG_PHYS_RAM_BASE for all kernel types whereas this value is
> implementation-specific, so that breaks the kernel genericity.
>
> The first patch in this patchset removes the usage of CONFIG_PHYS_RAM_BASE
> by introducing a new global variable that holds this value.
>
> The second patch reverts 9b79878ced8f ("riscv: Remove
> CONFIG_PHYS_RAM_BASE_FIXED").
>
> The last patch is an optimization 'symmetrical' to the one introduced in
> the first patch: this is not a fix, then it is not necessary to pull
> this into -fixes.

Hi Alex,

Thank you, this works  fine on my BeagleV Beta board.

If I'm not mistaken after this series all uses of CONFIG_PHYS_RAM if
protected by #ifdef CONFIG_XIP_KERNEL, so maybe we can remove the
middleman, CONFIG_PHYS_RAM_BASE_FIXED, and just let CONFIG_PHYS_RAM
directly depend on CONFIG_XIP_KERNEL.

Don't let that delay this series though. I'd still rather have this
fixed in 5.14 as is.

If it makes any difference you can add this for the series:
Tested-by: Emil Renner Berthing <kernel@esmil.dk>

/Emil
