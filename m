Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0C3067C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhA0XX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233559AbhA0XBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:01:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36CD664DDD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611786998;
        bh=4xDf1kIQfdD+/0DKjaNAYSWNulamOzwTvt/dOjpQOKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bVXZ62brHhthxPi4Yg3se74VZHO+RCRm4kNMsAoeEAmp3SefMgDzenGz7rUysVmkJ
         3KC5NVkkYum6joJiqhB/+z+N7faTUDnJDlwn0L4kF72NIFoKthXoaUtgy7IfZwv4bf
         RN7VxPQp25ViyG7qy5Km4OVvY9quwn85b/RIxjmxTv+gPoR8qcY1ts/yXot+bN3t9E
         LcaYiXDjIFmHZHb0TlK1PRUyZ85iPpB375JF6WOLeoRlgIY27Hnm0+62bw636h3AZ0
         LHoB/8NaWlpiC1psQmUULh+wSnLCFYcUdJpYfTvJRC+M93V0m+3z53c3dp3bKP9mBH
         AGlMuMtsxrWGQ==
Received: by mail-ot1-f47.google.com with SMTP id 36so3360918otp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:36:38 -0800 (PST)
X-Gm-Message-State: AOAM531fOeDjqHAoxe1Ct73HL1sEKRR8vDl+UGzqKHDpok2GX/aKs6Kj
        2dZLn3Oo09J9+KOrakS9l3pBVNdnG9sKTddbKdY=
X-Google-Smtp-Source: ABdhPJzDCowXa8XY6WxBMWr+0d0DA1axhb8zK38NhhukzF1pqUiVvL4QdnU/WgZ1PqhqNToIJC/IEP1HyQbX1F7OZ4A=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr9405785otq.305.1611786997504;
 Wed, 27 Jan 2021 14:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20210125112831.2156212-1-arnd@kernel.org> <CAAeHK+yOTiUWqo1fUNm56ez6dAXfu_rEpxLvB1jDCupZNgYQWw@mail.gmail.com>
In-Reply-To: <CAAeHK+yOTiUWqo1fUNm56ez6dAXfu_rEpxLvB1jDCupZNgYQWw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 27 Jan 2021 23:36:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3QV9uArBsc4PY0bM_4KGLYhNPHUFuk9s8yu=kGKe8sUg@mail.gmail.com>
Message-ID: <CAK8P3a3QV9uArBsc4PY0bM_4KGLYhNPHUFuk9s8yu=kGKe8sUg@mail.gmail.com>
Subject: Re: [PATCH] kasan: export kasan_poison
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:25 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> On Mon, Jan 25, 2021 at 12:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index de6b3f074742..32e7a5c148e6 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -94,6 +94,7 @@ void kasan_poison(const void *address, size_t size, u8 value)
> >
> >         __memset(shadow_start, value, shadow_end - shadow_start);
> >  }
> > +EXPORT_SYMBOL_GPL(kasan_poison);
>
> Should this be _GPL? All of the other EXPORT_SYMBOL() we use in KASAN
> are without the GPL suffix.

I don't care much either way, the reason I went for the _GPL  variant
was that this
seems to only be used internally in mm/kasan/ and lib/test_kasan.c,
unlike the other
symbols that are meant to be called by other modules.

         Arnd
