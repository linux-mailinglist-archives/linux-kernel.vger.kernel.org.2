Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D237397D9E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 02:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFBASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 20:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBASK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 20:18:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B60C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 17:16:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f11so514048lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78E6NeFKcH8MSEsBcY8Ia9gaTJw+NSrBe9gb2Q2dGXU=;
        b=KgV8JLk9OZeIr9xXubuaCOwIYB48/EcV0RA9tYYQILr3jxIqTQpsPYOs+sD4eJmsxk
         lk8YcXMZHBMNQrsqe7Bk4oH5L6NBC/0E8b5MToiLw6umt6moJbtqlrVAik3SlkR/4SLt
         bIqUM9GxeyML5v81eUzQTXLO/OWJA6oy7bzSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78E6NeFKcH8MSEsBcY8Ia9gaTJw+NSrBe9gb2Q2dGXU=;
        b=swdiHPXY6+5QEVJEZjJFpUqBZ2a2f3+5DdFN8CRRgsTqkqbqlPHeJ/0i/lj0O1uizm
         /lhjXW9Uw74rnxLehLu7/tCnqMY2hzjDkMDp5W0ZCrrkvlPzugkn38Tb+bPX8gAZ0bXL
         jytN/sMYEKlU2qrAc/MQP4nyz6pYXgVITJTAnEY56Y/ttfWvuX3hyBlRCG21YeCS/OF/
         9L5Up7QC3yIF1HelxddL2iUNzzLzcv16RtcBEZyVCMYgzDudeuYU8ZtibpQR+ygRdAm1
         fdifofCTfpEtmagOykjFpwjloVfxiEVXTTpR5ynqLsORtyYOEy8IZcSpuuYwVPCUCtqB
         Ew3Q==
X-Gm-Message-State: AOAM5334jvpET2Yw4YrRO0+Hc+wsLHDjXPOYpyfCFdiW+XfvhwCgc99+
        q6Pp+Ervnp+hM3fPGKkdQg4ky0AWZIFMsZMSp0g=
X-Google-Smtp-Source: ABdhPJxgXaD9f9GVWgpVUgf7y9aBRgwJQxMxGRe/Q7Ix7GycyAipQPhJodTnHyImoV6MaDsNrl/m4g==
X-Received: by 2002:ac2:554d:: with SMTP id l13mr16138678lfk.228.1622592985495;
        Tue, 01 Jun 2021 17:16:25 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id n15sm1821220lft.169.2021.06.01.17.16.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 17:16:24 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 131so306552ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 17:16:24 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr22578068lja.48.1622592983882;
 Tue, 01 Jun 2021 17:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org> <1622589753-9206-3-git-send-email-mlin@kernel.org>
In-Reply-To: <1622589753-9206-3-git-send-email-mlin@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Jun 2021 14:16:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wip5urjbGkPsoATGRbFoXSf5bq1qMwNAWEz5OpeanE+DA@mail.gmail.com>
Message-ID: <CAHk-=wip5urjbGkPsoATGRbFoXSf5bq1qMwNAWEz5OpeanE+DA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
To:     Ming Lin <mlin@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, Simon Ser <contact@emersion.fr>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series passes my "looks fine, is simple and straightforward" test.

One nit:

On Tue, Jun 1, 2021 at 1:22 PM Ming Lin <mlin@kernel.org> wrote:
>
> +               error = vm_insert_page(vma, (unsigned long)vmf->address,
> +                                       ZERO_PAGE(0));

On architectures where this matters - bad virtual caches - it would be
better to use ZERO_PAGE(vmf->address).

It doesn't make a difference on any sane architecture, but it's the
RightThing(tm) to do.

            Linus
