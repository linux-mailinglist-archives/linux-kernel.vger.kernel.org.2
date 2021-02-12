Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BFB31A0E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhBLOtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBLOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:48:21 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE33C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:47:41 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t29so5943256pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUAtpo+jSz3YKQ5pQn8lc88X7VgrZAH2A2Qa2TULs9o=;
        b=QmVi+zHfhseH74VbMoN/aK9hGqP8QIhk7EsshcLHOvSTcDrbevrAVYJ2mNZJj4HTaz
         LGzpAtvzJkriwZrfw2fMtgqrADNzA/Do2mXZrQjc8d4qgI+eVaCKhXCSfEIZdzZKeHxu
         WESA73f+J9lTDN0R6mQwsY4TYrhJDan/9QJnwX/iNCayx2Z6DxC4e2JBb1DU+LoJXN3/
         kRzP6J6RgH9J9A7+MOskeyDtVN/lcnusAea2IEXvttxv7+s8vYNfdlcmCbktCX37mwQF
         xGeDc5Y6vO9vHVCKBRwlvxEHp68WsRJfq7oiur5uRceygwBh7x0Yd66TR6RU8IchwUP1
         BiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUAtpo+jSz3YKQ5pQn8lc88X7VgrZAH2A2Qa2TULs9o=;
        b=TCn4iTm6B6V5kpfAjfTINym/NW15pXHz9DDe7jQIEBfy4ggtZIUVQkgcuiVAVcBbLZ
         r5wIBlBULJqDDzexQqM3knsXFPWiouUbdJPJrZJsy4O7+dbBwqQKWy0uokjq6pg7F6r4
         9fZPTG0UQY2ck0nRkUgm8ZbCScFdPoaKBPnj4+hkPjk+F6TwItv5MzY2YWl2jzW3+uYe
         W0DX+ehZ3ffRP0qDcfJggTybrQk3cNI6otmxHbsClHJT4roH1BXSWMseVOHB1Bk13MDL
         wD5yyrPQ2yF5s1iqtB6fND7Im+KCvmIABKL8+qlyRsr4c/XrLtfRz7QKfZnSKSamP1U9
         S+TA==
X-Gm-Message-State: AOAM5338RdQutwEM67ksI5dzatJXaKcWlUHP9PRuQs5LANbMM3iDWgNp
        xrLhdm+wjTRZJJqLdBiS8/58dCnxQVJ1XyYFleNVZg==
X-Google-Smtp-Source: ABdhPJz1CLw/7puZikxHmuDjA3azWBTqOe8CfBNsoC5cVjtTdtUmh9ueu3cBSIi9WZBYYITntJW/D/wAW6Sok3rG8qI=
X-Received: by 2002:a63:a0d:: with SMTP id 13mr3394365pgk.130.1613141260320;
 Fri, 12 Feb 2021 06:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20210211153353.29094-4-vincenzo.frascino@arm.com>
 <202102120313.OhKsJZ59-lkp@intel.com> <CAAeHK+yB4GLCn2Xu4z7FRLNOkVDFr0xXN3-D34BdJbRmWLpSxA@mail.gmail.com>
 <23dcb10a-7fc2-375d-2234-49f48461a612@arm.com>
In-Reply-To: <23dcb10a-7fc2-375d-2234-49f48461a612@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Feb 2021 15:47:29 +0100
Message-ID: <CAAeHK+y2kxnxD54b9gQOZ77daJGwffpk9mZs3PBf1PCTGAEO5w@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] kasan: Add report for async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:21 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 2/11/21 8:13 PM, Andrey Konovalov wrote:
> >>>> riscv64-linux-ld: report.c:(.text+0x5c4): undefined reference to `kasan_flag_async'
> > Let's do something like this (untested):
> >
> > https://github.com/xairy/linux/commit/91354d34b30ceedbc1b6417f1ff253de90618a97
>
> Could you reproduce this? I tried yesterday before posting the patches and my
> conclusion was that kbuild robot is testing on the wrong tree.
>
> I give it another go today, if you have more details based on your testing feel
> free to share.

I haven't tried reproducing, but the error makes sense. There's no
definition of kasan_flag_async for KASAN modes other than HW_TAGS.
