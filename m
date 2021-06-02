Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC26939898C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFBMb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhFBMbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:31:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD5C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:29:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ba2so974967edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgEY4csnfMiTaVbU1WFo7uBvyH/cKykPw3Skdbt2rUs=;
        b=oR1MekKqjbPZCPJ5qjjyhhoejJ4w6URmvkSJAmYNHI5rve2EYdnP2/ZZRDqliN/os3
         84IRO5h+akRYsf9o51toZIaeLKcGDQDU+WbtbtKqglBFp/tzd0S3+sgKwCfxdD6BVJKu
         +6bf0RgQySZN9Ks5wKNy4+Go3BJI4ARnp4Tna3Pa3Z2AEDw+wjlmbmtpfpJQVVrwlTKn
         F+aYwNKRH2qlDAT7Xk0/rCEsnFvkZKP/lYVzdfwoQxPT0WRuCJSGvJ4FwHXSmlVyKtvw
         OotDXghgvK5LKimUaH/DKBFVw4e/TMybkAWQLOnQ2QuAsJUP5K9xfiEPRqqtRLXYXnwk
         PYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgEY4csnfMiTaVbU1WFo7uBvyH/cKykPw3Skdbt2rUs=;
        b=I3ictan8YxJZteIzqFN2qFB4j8Pja39cj7o+bT2elovagE1v+3SyrDMN3AnMs31h6t
         Q91vllwtCAK5T/KwfguVUcSJXUHb2kBYgSuJwiy51YceJXEcxOCuwegPULhBfVodQ1k7
         X5FJtGZujP5tjZ8nO3sdKitJjmIvvB+CY9s6K5xtwFKvpwV8NoSl6albwXpiQBlPW7Ei
         /Oc8qJKM+QlLypbOvin0cojxXx3usbjD3rySxFqyilJr7srA5qaXunF5cqRHNV8nqIkT
         XTDXJi0Uv8KbL9QX8xUzMJQ7HJYEGgAZszqolzlx8r/VLQWntemf2c2sRHhPxMrt39hB
         dQ7g==
X-Gm-Message-State: AOAM533LDxczXVQMdLOtD7cId3gFPCNefs10synDDDzEZ123mOnkbXj3
        peU4OTWeWJymUWKvt0PF+hzigyLERzyJuuVV8jc=
X-Google-Smtp-Source: ABdhPJx9DMEB/sshUJnfxFP0Z1YiUkfEObPu5nt4HKkefEkIKBXgWBHkETD01bnUxyol9nf+12ENNpev4JmeTBKyrBY=
X-Received: by 2002:aa7:d74b:: with SMTP id a11mr1480803eds.95.1622636964034;
 Wed, 02 Jun 2021 05:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210530044708.7155-1-kylee0686026@gmail.com> <20210530044708.7155-2-kylee0686026@gmail.com>
 <YLSjUOVo5c+gTbzA@elver.google.com> <20210531155912.GC622@DESKTOP-PJLD54P.localdomain>
In-Reply-To: <20210531155912.GC622@DESKTOP-PJLD54P.localdomain>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 2 Jun 2021 15:29:12 +0300
Message-ID: <CA+fCnZeXEiTi-k4_XkYTvE2mQcXvP0Ct1N5VDEFfPufFqz15+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] kasan: add memory corruption identification for
 hardware tag-based mode
To:     Kuan-Ying Lee <kylee0686026@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 6:59 PM Kuan-Ying Lee <kylee0686026@gmail.com> wrote:
>
> > >
> > > +config KASAN_HW_TAGS_IDENTIFY
> > > +   bool "Enable memory corruption identification"
> > > +   depends on KASAN_HW_TAGS
> > > +   help
> > > +     This option enables best-effort identification of bug type
> > > +     (use-after-free or out-of-bounds) at the cost of increased
> > > +     memory consumption.
> >
> > Can we rename KASAN_SW_TAGS_IDENTIFY -> KASAN_TAGS_IDENTIFY in a
> > separate patch and then use that?
> >
> > Or do we have a problem renaming this options if there are existing
> > users of it?

Using the single KASAN_TAGS_IDENTIFY config option is what I would like to see.

Since this is a purely debugging feature for a less popular KASAN
mode, I think renaming the config name is OK.

> I tend to keep KASAN_SW_TAGS_IDENTIFY and KASAN_HW_TAGS_IDENTIFY
> separately.
>
> We need these two configs to decide how many stacks we will store.

You can define KASAN_NR_FREE_STACKS to different values depending on
whether HW_TAGS or SW_TAGS is in use. I don't see a problem here.

> If we store as many stacks as SW tag-based kasan does(5 stacks), we might
> mistake out-of-bound issues for use-after-free sometime. Becuase HW
> tag-based kasan only has 16 kinds of tags. When Out-of-bound issues happened, it might
> find the same tag in the stack we just stored and mistake happened.
> There is high probability that this mistake will happen.
