Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A43BBC0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhGELU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGELU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:20:56 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F3C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:18:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t3so20397573oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 04:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQCc966SXUWmxUzITD8j4jyP6srsgCllnc0jbweek7I=;
        b=cHNJERRyJ5VgZnacJnPR2MSdn7fGw163AVo+S8UOuAHCb3pTWYCdTRFFjXaaX8GkUb
         3VfdXnRbb2gNfY1PFm+w169rVHlgjvTg4J/NZqi+D5KtNopaQpI62sgNlwhOKwkOjn3y
         aM+SXKcxWLnYQ+r1haUMgwW3xnEhGhMTsG+YAeJZyz1+/dc1nFWsBFgA1VXoqvVk++2Q
         0kE8crVgqijSkqQPO0CHETGmpCmCd0ThqeaWg+kqtaSyiqhCH5KBYwsxiUIJ5ShGQqKO
         iurHsCrPJm3nkwLQlVSC07Vdwcb/5L/UBAoEfarVZbgjvJaIn/GOank5f2zy1cl0fsBU
         6Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQCc966SXUWmxUzITD8j4jyP6srsgCllnc0jbweek7I=;
        b=HlqXeb3D7sCdODDj6KPBlIgI6s+s9pYb37NMUUecB73eKbXe/COY+auxhkgG4AAC/+
         1uKuLHfEVJrbq57G8tNcs/J3bBFTNGyTKad8SvH8Aonm13DPuK2p77qR0qPdPRjbrCQg
         VGyeC4c/iLKLgh/g7CpjhLr8drgWkyAqOiQzSuQrnX+8BMhR5EdVYHjoZ5Wvf8Ns6bbs
         i2H0s1uNx4rSgcfKmU7SiHR7Fj2ZwtRepR6pzQczcYCEher9tm6++MrlM0CQl06kITEV
         /sS9fiJ6M5zPcU2Ca6wkL+f3i0qE0fHSi6lgCYR8PMZOn46P+L88B/N9jsZrblVG9tcI
         T4uw==
X-Gm-Message-State: AOAM532Xr9LUmCya/3lvyFl1MQ+9kwYNQfX6xKtXpDlFs9fTrc4LVflG
        ninePx4eN+T8iIZHkyKHb/0kB709BMKpPe0l3P1YRQ==
X-Google-Smtp-Source: ABdhPJwzSMEuJSuh2QrLP5wculi4/MRed4/0p4GmnpoFWoc1/Fz8hjBkQyR9qR+/z38D9zBccESL4gX1oPMqqkjt4Qo=
X-Received: by 2002:a05:6808:2d9:: with SMTP id a25mr9673299oid.70.1625483898064;
 Mon, 05 Jul 2021 04:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210705103229.8505-1-yee.lee@mediatek.com> <20210705103229.8505-3-yee.lee@mediatek.com>
 <CA+fCnZdhrjo4RMBcj94MO7Huf_BVzaF5S_E97xS1vXGHoQdu5A@mail.gmail.com>
In-Reply-To: <CA+fCnZdhrjo4RMBcj94MO7Huf_BVzaF5S_E97xS1vXGHoQdu5A@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 5 Jul 2021 13:18:06 +0200
Message-ID: <CANpmjNNXbszUL4M+-swi7k28h=zuY-KTfw+6W90hk2mgxr8hRQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] kasan: Add memzero int for unaligned size at DEBUG
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     yee.lee@mediatek.com, LKML <linux-kernel@vger.kernel.org>,
        nicholas.tang@mediatek.com,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        chinwen.chang@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 at 13:12, Andrey Konovalov <andreyknvl@gmail.com> wrote:
[...]
> > +       /*
> > +        * Explicitly initialize the memory with the precise object size to
> > +        * avoid overwriting the SLAB redzone. This disables initialization in
> > +        * the arch code and may thus lead to performance penalty. The penalty
> > +        * is accepted since SLAB redzones aren't enabled in production builds.
> > +        */
> > +       if (__slub_debug_enabled() &&
>
> What happened to slub_debug_enabled_unlikely()? Was it renamed? Why? I
> didn't receive patch #1 of v6 (nor of v5).

Somebody had the same idea with the helper:
https://lkml.kernel.org/r/YOKsC75kJfCZwySD@elver.google.com
and Matthew didn't like the _unlikely() prefix.

Which meant we should just move the existing helper introduced in the
merge window.

Patch 1/2: https://lkml.kernel.org/r/20210705103229.8505-2-yee.lee@mediatek.com

Thanks,
-- Marco
