Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03C3B924F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhGANeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhGANeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:34:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A72C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 06:31:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg14so10396682ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9xHPQXfeX85p/WzrKNX5asqql2B/nD64WETM/hhNus=;
        b=rPkrb7S1fk4T3qkJ10Ep2j4MR6kgQaC6BsJseApFIwDMzhwuu3VfF4W+PMn+D6OOsj
         leSkEpTvERGV5xLo8VbBUsUr6mDM5rt1doaDh50MTc0uzsUlN3zRbh2OYSSAHBJiN6li
         bdQWhTsymoM6+mvoXx3OTtT4O61r1hWcjpzftezV2yOqO0RfmEfAX5YUEsKJs5htq92G
         PAQJrU/eJlCnP6y154lnlyQfgEYTmc87dxS+SyvZO3Cl9jM1WBBTv2ljPQLxX5FHDlcc
         pCiiqVPZIQkb+xQuzE49/flY/F7wWvZhXhUebyqm5a0zD+rEBDd72pM6O3vUDjN392Wt
         D2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9xHPQXfeX85p/WzrKNX5asqql2B/nD64WETM/hhNus=;
        b=UE9UKUtWFPOmS006DknTH6+zxgZK3dls0yLxQT1/6cNThic4I/VwEYOV75N1OGq22v
         tk/almGqRU59WIOPT2kHbi1eXbERvyhfUsczkOJeU9r18CEhgtpi5Ex9rB9dWS5XNktb
         XR3g2Eg0T/uD8tIJKvjG9XURuEjCAKxKGp6MRh+crQ1E8etUgDwVqT4rFbbdrS8g/uws
         8G9xjt949B8KsV3HTgeSsgoxiawUbz6HnsjY1ojQ/lvzAm9pC32oxFXlyodHDAPgue5Q
         XnSotUzqeInAlw9anw4lvfxGOeRhinwApPkp2IBTV1wj6iR02zFlHjAZQiM1HoltJ9vW
         8i2g==
X-Gm-Message-State: AOAM533nSsdBSBYgftNVahUlYDIzKpczmiZeY6j+EFvK6bgUsKS1LYDK
        tuBuyhc/ComIMmoWv1Fn2oxjR35fwxDVg4/IV1U=
X-Google-Smtp-Source: ABdhPJwAB9zNDvwIwLlvuGpl2XmkQHgjogSwTqCGj4FJ6uy6ez3lXb60hBmJa9obZ737ErpszWY/M6A6HyDbpv+9BfA=
X-Received: by 2002:a17:907:9f0:: with SMTP id ce16mr42484016ejc.126.1625146312962;
 Thu, 01 Jul 2021 06:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210630134943.20781-1-yee.lee@mediatek.com> <20210630134943.20781-2-yee.lee@mediatek.com>
 <YNzCVxmMtZ1Kc6XA@elver.google.com>
In-Reply-To: <YNzCVxmMtZ1Kc6XA@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 1 Jul 2021 16:31:42 +0300
Message-ID: <CA+fCnZcPXLZxCVAk2Cmhfvov9KNGxALQuWun_yKf0O+q=rbnfQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] kasan: Add memzero init for unaligned size under
 SLUB debug
To:     Marco Elver <elver@google.com>, yee.lee@mediatek.com
Cc:     wsd_upstream@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 10:13 PM Marco Elver <elver@google.com> wrote:
>
> > +     if (IS_ENABLED(CONFIG_SLUB_DEBUG) && init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
> > +             init = false;
> > +             memzero_explicit((void *)addr, size);
> > +     }
> >       size = round_up(size, KASAN_GRANULE_SIZE);
> >
> >       hw_set_mem_tag_range((void *)addr, size, tag, init);
>
> I think this solution might be fine for now, as I don't see an easy way
> to do this without some major refactor to use kmem_cache_debug_flags().
>
> However, I think there's an intermediate solution where we only check
> the static-key 'slub_debug_enabled' though. Because I've checked, and
> various major distros _do_ enabled CONFIG_SLUB_DEBUG. But the static
> branch just makes sure there's no performance overhead.
>
> Checking the static branch requires including mm/slab.h into
> mm/kasan/kasan.h, which we currently don't do and perhaps wanted to
> avoid. Although I don't see a reason there, because there's no circular
> dependency even if we did.

Most likely this won't be a problem. We already include ../slab.h into
many mm/kasan/*.c files.

> Andrey, any opinion?

I like this approach. Easy to implement and is better than checking
only CONFIG_SLUB_DEBUG.

Thanks, Marco!
