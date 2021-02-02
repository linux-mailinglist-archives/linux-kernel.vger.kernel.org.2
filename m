Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918D830C75D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhBBRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbhBBRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:16:51 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A621CC0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:16:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r38so15289621pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qn4pclhdqmAAoIxBnEwAj7m8g+jtHb7YgGNlKFxvSYU=;
        b=bBR97nkEWcOKpSJZMu6azK2HcycFbY+43YuoIEN0TCDWakvbkPPZc+87f+aKzg8a6a
         wuUB8X0TBKLzHASWw0W4o22j6m+RUh1rw0Welx/Nx5KTGEOHfpBe4olU+UalhWN1VOZG
         1Dn4nGTxh1XtrvfGquD+RDfOfggjonfKM0rPTeFigeVo1icxTAUx09SXONo+mIS+9nUm
         xT8D1EfgM0QMVXpsW5+Jc7UPFkqyK5dkooEujiEZSaaTuLMMAtLBFDlAgrxRYgP7sZJu
         JCxpYQi0d2wzgNG6p0R+jOmDIbfQYbQv1xXN1yg/sCxNeeHmc2QCKEDZFvEvVEBo6MMh
         hOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qn4pclhdqmAAoIxBnEwAj7m8g+jtHb7YgGNlKFxvSYU=;
        b=KhWXn69hiNrh5bipacvhWhknDq5yFBNm5SkUI0pQkfHZF+JMLGARZ0prxsCX/+lR2j
         hCiBgZZP1nPe2CIqK+ZqyiflsqFE3EgFQCM3QscuT6YiiMrJHxBv++KVyopaWOluI9Jv
         A7JLGS+a5whIga3wGHz38aFtLlT76WpvQHou0KZ5ieFiA/MBJs1YKctVNthI15qoDTSB
         LGuMdLgWVaIKDyzRyQvBg7xc2CI9xciS2udWqVqdQaPhqLFrXIpsXYPRQYf5I5pd+Zhc
         UdqAZ8eY1ZO7HznFpwPHM2psjvXAucp3WCcxK7lkyPUh2tS9gv46w9erdkuqf9eKUxcr
         SwFA==
X-Gm-Message-State: AOAM530DdOXq5f7FiIWZN5giBCIkSgxnjBDpPTUB/RDK0bCTGj3ea7q7
        kg2ORxN2Zw/gygVI3T4kwTOUm68XwhiUMXleKWfmgg==
X-Google-Smtp-Source: ABdhPJy5EFUucX2b1IEAUHL6jONH+L7UUF/oPUeqOi4fy/MxFChGP/yerbfYF+s+IdZgnU99OMALUbkArViRFHUSmcY=
X-Received: by 2002:a62:18d6:0:b029:1bf:1c5f:bfa4 with SMTP id
 205-20020a6218d60000b02901bf1c5fbfa4mr22215803pfy.24.1612286170018; Tue, 02
 Feb 2021 09:16:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com> <b3a02f4f7cda00c87af170c1bf555996a9c6788c.1612208222.git.andreyknvl@google.com>
 <YBl9C+q84BqiFd4F@elver.google.com>
In-Reply-To: <YBl9C+q84BqiFd4F@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Feb 2021 18:15:58 +0100
Message-ID: <CAAeHK+xzBpdzO7BmdVZe3_g5Di+-AGyYAO5zBVvOpEUtXD8koA@mail.gmail.com>
Subject: Re: [PATCH 02/12] kasan, mm: optimize kmalloc poisoning
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 5:25 PM Marco Elver <elver@google.com> wrote:
>
> > +#ifdef CONFIG_KASAN_GENERIC
> > +
> > +/**
> > + * kasan_poison_last_granule - mark the last granule of the memory range as
> > + * unaccessible
> > + * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
> > + * @size - range size
> > + *
> > + * This function is only available for the generic mode, as it's the only mode
> > + * that has partially poisoned memory granules.
> > + */
> > +void kasan_poison_last_granule(const void *address, size_t size);
> > +
> > +#else /* CONFIG_KASAN_GENERIC */
> > +
> > +static inline void kasan_poison_last_granule(const void *address, size_t size) { }

^

> > +
> > +#endif /* CONFIG_KASAN_GENERIC */
> > +
> >  /*
> >   * Exported functions for interfaces called from assembly or from generated
> >   * code. Declarations here to avoid warning about missing declarations.

> > @@ -96,6 +92,16 @@ void kasan_poison(const void *address, size_t size, u8 value)
> >  }
> >  EXPORT_SYMBOL(kasan_poison);
> >
> > +#ifdef CONFIG_KASAN_GENERIC
> > +void kasan_poison_last_granule(const void *address, size_t size)
> > +{
> > +     if (size & KASAN_GRANULE_MASK) {
> > +             u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
> > +             *shadow = size & KASAN_GRANULE_MASK;
> > +     }
> > +}
> > +#endif
>
> The function declaration still needs to exist in the dead branch if
> !IS_ENABLED(CONFIG_KASAN_GENERIC). It appears in that case it's declared
> (in kasan.h), but not defined.  We shouldn't get linker errors because
> the optimizer should remove the dead branch. Nevertheless, is this code
> generally acceptable?

The function is defined as empty when !CONFIG_KASAN_GENERIC, see above.
