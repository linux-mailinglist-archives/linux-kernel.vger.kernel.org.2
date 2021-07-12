Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29B93C5A81
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhGLKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbhGLKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:06:08 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7289DC061788
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 03:03:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so17515543otf.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QvgAnoI2kPhaZ/+n+bQkw4ACvsVb9pav6Lb/tlx3m8=;
        b=nS5X1ma78tZUkAIXCfDp3a8xVJt/VvHEYep44ptY71kKl0YEHx+oBUtr6Zz1azRAr/
         CcLqtFi3wFbu+j+TpshqXoh8MvviI8LJOus0njsV6RBuLthgADwE6tJ00hnZoc6rvkS4
         nPT/pYipkn8urjIdRVIJcTp1fH65fctXLbFymE/KcAYXffQgdC4f2K9HHkeaFx5cAGHM
         CV9eVUdu+7ksEtwSsf6/Z12oH3ktaNVFK+08Et10h9vLBZU6OECiIHOsWZgKc2jH9ZUY
         sHvL34U9IZQ0xFndB3dSItRjerjJJxdRYEpys9yjeyYH8l5A5skJXsVC9ceR3cFfJbx3
         nVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QvgAnoI2kPhaZ/+n+bQkw4ACvsVb9pav6Lb/tlx3m8=;
        b=H6a1QG2PkLjhdf31UFJ7fZ/zqqTM/CsXk6zZSYogYa2e4N/Oll8Nfp5/1S+foiqXDW
         ocbS1hCzb54gwsx3DszctmzNk8AqRZfuqfvYgZngmJocnH4yb7oIvnnkaq0mKe1kAltV
         xM+SWAIDTdaWLbsw5yknNzrwA7epNA6rJc4wHApRsjvu6cXqfRncxNI8vzv0aCuer/FT
         JS9RH9Uv7E4f38SwuHR0cjln8aPcyYhER1YYiqw8LjdfqXjLU7stMzImC7DaIBWilxIW
         UuSkui1veiM4FLRyjCkxuSHuN8NWrjjn7PVNBc84pMWSpQ1t0lvUXnahNT1Jm1+gG/Xm
         uNHw==
X-Gm-Message-State: AOAM531a6HUQxTjVLxGk+u/VtRH8RNemFqIBNNKWNDDRCfayrWqMqHjk
        YGhsmr4RtgEYuGN9ipRHICuLh05AlBdi20y72JuQeg==
X-Google-Smtp-Source: ABdhPJx9cVqiaLWwM84FC2PwZhfKEQn3biHZZj0dyJ4upo16KWyhBj1bd552alA2pVIa7/nYudoBocwhHa0lsFY9w60=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr41889857oti.251.1626084199532;
 Mon, 12 Jul 2021 03:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210708144411.25467-1-mark.rutland@arm.com> <CA+fCnZdHADek_3bFcLdkk7=XiRL25F0n6VaGGOrw-uUpDLxYYw@mail.gmail.com>
 <20210712095832.GA27643@willie-the-truck>
In-Reply-To: <20210712095832.GA27643@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Jul 2021 12:03:06 +0200
Message-ID: <CANpmjNObTgULimfcVvwCnCEUknTpD+Q8DyoMfiROejYjB2EL5g@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix build for CONFIG_KASAN_HW_TAGS
To:     Will Deacon <will@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sam Tebbs <sam.tebbs@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 at 11:58, Will Deacon <will@kernel.org> wrote:
> On Sat, Jul 10, 2021 at 09:16:14PM +0200, Andrey Konovalov wrote:
> > On Thu, Jul 8, 2021 at 4:44 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > When CONFIG_KASAN_HW_TAGS is selected, <linux/kasan.h> uses _RET_IP_,
> > > but doesn't explicitly include <linux/kernel.h> where this is defined.
> > >
> > > We used to get this via a transitive include, but since commit:
> > >
> > >   f39650de687e3576 ("kernel.h: split out panic and oops helpers")
> > >
> > > ... this is no longer the case, and so we get a build failure:
> > >
> > > |   CC      arch/arm64/mm/kasan_init.o
> > > | In file included from arch/arm64/mm/kasan_init.c:10:
> > > | ./include/linux/kasan.h: In function 'kasan_slab_free':
> > > | ./include/linux/kasan.h:211:39: error: '_RET_IP_' undeclared (first use in this function)
> > > |   211 |   return __kasan_slab_free(s, object, _RET_IP_, init);
> > > |       |                                       ^~~~~~~~
> > > | ./include/linux/kasan.h:211:39: note: each undeclared identifier is reported only once for each function it appears in
> > > | ./include/linux/kasan.h: In function 'kasan_kfree_large':
> > > | ./include/linux/kasan.h:219:28: error: '_RET_IP_' undeclared (first use in this function)
> > > |   219 |   __kasan_kfree_large(ptr, _RET_IP_);
> > > |       |                            ^~~~~~~~
> > > | ./include/linux/kasan.h: In function 'kasan_slab_free_mempool':
> > > | ./include/linux/kasan.h:226:34: error: '_RET_IP_' undeclared (first use in this function)
> > > |   226 |   __kasan_slab_free_mempool(ptr, _RET_IP_);
> > > |       |                                  ^~~~~~~~
> > > | ./include/linux/kasan.h: In function 'kasan_check_byte':
> > > | ./include/linux/kasan.h:277:35: error: '_RET_IP_' undeclared (first use in this function)
> > > |   277 |   return __kasan_check_byte(addr, _RET_IP_);
> > > |       |                                   ^~~~~~~~
> > >
> > > Fix this by including <linux/kernel.h> explicitly.
> >
> > Hi Mark,
> >
> > Marco already sent a fix for this. It should be in the mm tree.
> > (Although the link to it in the Andrew's notification email doesn't
> > work. But they rarely do :)
>
> Do you have a link to the patch? I couldn't spot it in linux-next.

https://lkml.kernel.org/r/20210705072716.2125074-1-elver@google.com
( https://lore.kernel.org/mm-commits/20210706204723.O1wZ2%25akpm@linux-foundation.org/
)

Looks like latest -mm is not yet reflected in -next.
