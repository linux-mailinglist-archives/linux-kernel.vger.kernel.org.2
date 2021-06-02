Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963E2397DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFBBIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhFBBIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:08:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9240161027
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622596000;
        bh=jW/ATu8pEb4Sd//hBxYhELVxo4bcjLQROVsn3uX2jgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z5J4/SltIiNbmMf9YqCauwCkid2albzuuW512n5KnftVcKzsLK8m6MnNtC3xb0Zh0
         HSkhgOiuZFFmeirh1cmbI9F0nH0RgOhCdSQClwu5nZLNwuwF+tlIl27om9CqyngvEu
         XxQtCF/3PZaV8lWITh8nZvrjPLbKKUrJ1VH4ZrGK54ylR7niK2je3v2TQMtTshW2/i
         99TPXomLBFX0X6JrLJi/rc0pk4kyZ/ts1pmwuk4QlyLzBYzHL6nuxOCT4AJhL+urkX
         p0dVCP2J0Mrj8vVLu+M30f02k45YFyOqGpOz7nEIkdAJvEf62vqfxOj3abj1WOx0pz
         w86gwErmF+EnA==
Received: by mail-lj1-f182.google.com with SMTP id f12so429967ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 18:06:40 -0700 (PDT)
X-Gm-Message-State: AOAM5327PcGoG89TiZlC7aHj0rIaNxgH9WKfls+zclM35XgZ/W0Igfb9
        uqKMOh6084fgHNw5mDTeeDWXbV2gIq/1mUTpRbA=
X-Google-Smtp-Source: ABdhPJynHtrtnVj3WyNwivcsVRYyCCfB0UXfVBTTpKPFWZ4ZUz1kzzxJRC+3tIHOWzeeZOnSmGmnrhibeX8HGz+I168=
X-Received: by 2002:a2e:9dcf:: with SMTP id x15mr23261591ljj.257.1622595998923;
 Tue, 01 Jun 2021 18:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org> <CAHk-=wip5urjbGkPsoATGRbFoXSf5bq1qMwNAWEz5OpeanE+DA@mail.gmail.com>
In-Reply-To: <CAHk-=wip5urjbGkPsoATGRbFoXSf5bq1qMwNAWEz5OpeanE+DA@mail.gmail.com>
From:   Ming Lin <mlin@kernel.org>
Date:   Tue, 1 Jun 2021 18:06:26 -0700
X-Gmail-Original-Message-ID: <CAF1ivSZT_Ro2kw=VM7DfkAcNxWQwHNVc71g5JgbJeJH_XKAhVw@mail.gmail.com>
Message-ID: <CAF1ivSZT_Ro2kw=VM7DfkAcNxWQwHNVc71g5JgbJeJH_XKAhVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Simon Ser <contact@emersion.fr>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2021 5:16 PM, Linus Torvalds wrote:
> This series passes my "looks fine, is simple and straightforward" test.
>
> One nit:
>
> On Tue, Jun 1, 2021 at 1:22 PM Ming Lin <mlin@kernel.org> wrote:
>>
>> +               error = vm_insert_page(vma, (unsigned long)vmf->address,
>> +                                       ZERO_PAGE(0));
>
> On architectures where this matters - bad virtual caches - it would be
> better to use ZERO_PAGE(vmf->address).
>
> It doesn't make a difference on any sane architecture, but it's the
> RightThing(tm) to do.


grep -Rn ZERO_PAGE linux/arch/ | grep define

s390 and mips do use the "address" of ZERO_PAGE(address)

Fixed.
