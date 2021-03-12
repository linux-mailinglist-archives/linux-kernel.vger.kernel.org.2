Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6A339012
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhCLOby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhCLObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:31:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDB5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:31:24 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y13so2003176pfr.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87q9jccx8BT/1UJYduCnIq9RvFzXmVQYDuCBWc/EFfo=;
        b=vbw+LKbbjclyBg6+aa4R4rytJMpDYAjHpqS2eNNad9ebfKSnOKO05u+uX1AN4+MU4d
         YYX0K6uB1LiA32oNsjVpB0S15zxIv+gphscDNMgfM2JGp5JQ8usU/Pb7qdeUesJlaQ+6
         oC5DU8VdGH/omJgvldh90PGo/frhXEDUJ8L0Ek4IROU2sbVsAMj4Kxu3fn3wXXInfJou
         K/8hjTH8Mq8619s0G3cmY8+3UoGKFHex+s5/nrZpbEpdjidi5rL9QoVm05Iyav76D1zY
         yDh7lJp+ei+wCNwL7Ma0kKhBqH/yqvv1/8/A17SXELqAT7onBlhwRQedrWzMHdq30Mu2
         jrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87q9jccx8BT/1UJYduCnIq9RvFzXmVQYDuCBWc/EFfo=;
        b=DqV49hfElk6g0h13Gky9B5N4tjIA2oxxM91OdPCZf0V+ucWw9FQG1CHGKoDdq4IU1E
         8uraHECWWqFJUtemuVx+py1KOMe3i0K6WAZYLeHuLhNkXjJGj/JBsoykS3AY8miwsDeS
         3L5fvho9lJpnVrAPAMFj6NLc1M0aPCblOmyFRv7pMWlKVU16KalVBPmLzMLOYsI0s8HL
         mkiCsMNBsa+QcaxvmUwHPRvHszbuGz9UU60rAdiNI8yLjk5poF5GFnQrUluaWh5hK/DE
         2IszmTByOO/bdpg3Qj6kMbsIZMrxXOBbsXDE0IhGr2L+65fxbRPMDVJK1TW/+EzmJOJU
         f30g==
X-Gm-Message-State: AOAM533+d0KJP4rQcGrFRQjMp9mxQ0D0NOg2O/0jqG2A/rzzWMXs+RCH
        dIcz/NvAfVDgHhCw6lhC3/Yu0yQSlASTvOyj+MzMhQ==
X-Google-Smtp-Source: ABdhPJxds7YesawTpwHPzA8UcCXWE1vPkg2gDONJqSrSOurgAFvoZfgOpYL1K7Qs0JMruuuugiNipf8QqJ+AAxPLg3c=
X-Received: by 2002:aa7:91d1:0:b029:1fe:2a02:73b9 with SMTP id
 z17-20020aa791d10000b02901fe2a0273b9mr10366246pfa.2.1615559483690; Fri, 12
 Mar 2021 06:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20210226012531.29231-1-walter-zh.wu@mediatek.com>
 <1614772099.26785.3.camel@mtksdccf07> <1615426365.20483.4.camel@mtksdccf07> <20210310214552.6dcbcb224c0ba34f8e0a0a54@linux-foundation.org>
In-Reply-To: <20210310214552.6dcbcb224c0ba34f8e0a0a54@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Mar 2021 15:31:12 +0100
Message-ID: <CAAeHK+xBcFgft9yqNMEKs42tEWEDt4Za9n1_t95PAEiS7Cqibw@mail.gmail.com>
Subject: Re: [PATCH v4] kasan: remove redundant config option
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 6:45 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 11 Mar 2021 09:32:45 +0800 Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> >
> > Hi Andrew,
> >
> > I see my v4 patch is different in the next tree now. please see below
> > information.
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ebced5fb0ef969620ecdc4011f600f9e7c229a3c
> > The different is in lib/Kconfig.kasan.
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/diff/lib/Kconfig.kasan?id=ebced5fb0ef969620ecdc4011f600f9e7c229a3c
> >
>
> They look the same to me.  I did have `int' for KASAN_STACK due to a
> merging mess, but I changed that to bool quite quickly.

There's still something wrong with this patch in the mm tree. The
KASAN_STACK option is duplicated in lib/Kconfig.kasan. Badly resolved
conflict with "kasan: fix KASAN_STACK dependency for HW_TAGS"?
