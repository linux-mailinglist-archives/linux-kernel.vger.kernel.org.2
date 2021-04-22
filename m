Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9B3682F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbhDVPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbhDVPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:07:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28ADC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 08:06:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z5so17378086edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiWM9rp85vgyV36ASLFY/jLiQfSBITIqRxoGkPrE4Iw=;
        b=YwpW4PO5GfM7uc9mqvAfOC7AUhsP7CQug/ztxN73rTTEjyZz7CiKQbTaOsKDSWewRa
         mcwnVDJ+c9GxNh0/A8uETV8xX2JPc9nxP0JMXn9fTV0ZY69SLR69IL1rYAnCUJPthZH5
         Zf45WuZ9PFYVUuaX5L1QG3FlcXh9Mj71Wwfxp1jv9JNny21QabQy5mBqPpEUcQ2/j8eI
         PKKMaybb0D9l6OxlBxjv9b8gsdGSSVLSschuRSkt1v7LEhUt7zg8Ll8sgLMAP43Pf1xp
         huDbO2xlAqR/7hDnNdCm0gLlQNmUBG0Fw1hKvb6QhRWifWA/Y9ndl4t6sjhfXZnfP9+S
         34aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiWM9rp85vgyV36ASLFY/jLiQfSBITIqRxoGkPrE4Iw=;
        b=oNVNGhqs0fR8B8/oRsuHtDBolg1wCTq1yn3SkrPM+D757fZZmsR4pte+hHOuj5WXP7
         g5KhB5b6erckd8o/XhmHIEhFX63VngePf9vtqAFgUhErPmczpK3ceWEoUAYjx7uRYYoL
         tbKLk98G48EhkO9iCwmJMJjE/dB0buU6YIG4Tu4agkWKWSVtn8WokOr8faYktfLHjmQU
         smgHSwx1IBNmFRs44eRpjfZ1BYPAsbyH/Zs2GAnQMb4QIE99rHVO1sAO6kyLq0HH9OSE
         lpp+8vssJeecWXAM8mUOVNTc/3l78jQTWgqI+KTS4AmQSps8jPFMf0jl0xr7T5jB6X3m
         i0jg==
X-Gm-Message-State: AOAM533ZslKa45Lryvphj6mRiQ/8hS6LAOAYl1zz/XT6M6HZ8g6G07MC
        pDP24S03WwrJ8u1JN7o3CQz7zFqgabGJ0IPlC7A=
X-Google-Smtp-Source: ABdhPJxbP1TmUrQ97NwLsThwzUDAJleXRX2PcIjO0fG9L+ZmBwObZbrMH9YUojnkjgnzDsiBEU3ltMGL/JMtWgrRH2w=
X-Received: by 2002:aa7:d541:: with SMTP id u1mr4497795edr.95.1619104005534;
 Thu, 22 Apr 2021 08:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa@epcas5p2.samsung.com>
 <1619079317-1131-1-git-send-email-maninder1.s@samsung.com> <CANpmjNOT7xVbv4P1n3X24-HH8VMBs7Ny33DFYbzjO6Gqza2mZA@mail.gmail.com>
In-Reply-To: <CANpmjNOT7xVbv4P1n3X24-HH8VMBs7Ny33DFYbzjO6Gqza2mZA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 22 Apr 2021 17:06:34 +0200
Message-ID: <CA+fCnZegOsHtWJy2QmVe=y_WHwi5WHFRfHLR6P9SHjX5c-9G7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/kasan: avoid duplicate KASAN issues from reporting
To:     Marco Elver <elver@google.com>,
        Maninder Singh <maninder1.s@samsung.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 4:10 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 22 Apr 2021 at 11:17, Maninder Singh <maninder1.s@samsung.com> wrote:
> >
> > when KASAN multishot is ON and some buggy code hits same code path
> > of KASAN issue repetetively, it can flood logs on console.
> >
> > Check for allocaton, free and backtrace path at time of KASAN error,
> > if these are same then it is duplicate error and avoid these prints
> > from KASAN.
>
> On a more fundamental level, I think this sort of filtering is the
> wrong solution to your problem. One reason why it's good that
> multishot is off by default is, because _every_ KASAN report is
> critical and can destabilize the system. Therefore, any report after
> the first one might be completely bogus, because the system is in a
> potentially bad state and its behaviour might be completely random.
>
> The correct solution is to not leave the system running, fix the first
> bug found, continue; rinse and repeat. Therefore, this patch adds a
> lot of code for little benefit.

I agree with Marco here.

It doesn't make sense to have this deduplication code in the kernel
anyway. If you want unique reports, write a userspace script that
parses dmesg and groups the reports.

Thanks!
