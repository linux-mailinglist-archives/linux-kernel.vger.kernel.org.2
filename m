Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8E338F72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhCLOIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhCLOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:07:41 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1829C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:07:41 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id r16so617526pfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/GgEAlBKF2uwsyk9hjE5RIXHym45HMkX/lhiSnnj6Y=;
        b=C/1wEkaq2DArnZL1/GKsWDElinzSEvByJcU1MrlhORKFvXRtJSQuIiv7rG6xlMcUWN
         wfXmkQdGX3Auf9GWbfhfa1ZYHWI3w6hj4PYQjWsZG+ScmXBQfUw0GnvIv34j3Q5QdHA7
         E932zYPWGo3Gt58BFOLDSG0hweGbfOKJOwK/Y6yt49HW8ixAVJFx9t1IuYsfQcOiyFur
         WyWDRJP+KNPZ4xRPwH9aA8E3viHPf70RseobR3GyS+Yj8NN5Xg0k2ZGNpMie5ObUXQir
         qy7Sd+J4daBpeU3gAxn1Z0roFL7Q0NxsPXenl/1evSKNeSz+GN76rkxtDmsiYRw8htqH
         tc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/GgEAlBKF2uwsyk9hjE5RIXHym45HMkX/lhiSnnj6Y=;
        b=SiSER7SNVhM1203O1p/U7p0SWyvxfFmXGJ3JgZ9bXuAVMb5HDtuCQfA7RYGxAx3MGV
         9jfrAfO01eSEnmr+ksTUVDZRMr9Z7KGzLip0teq/8JqBCgmIrthZjkcA5Bt/M+CdM6mB
         iEzFpCV/ZIt8iMk9pZy5GCyR6pM0RWsaW3USg7zjLmLU00w6Dj/s4R55YXrzn+aiZZ13
         VS7+EC0mLW5LBP0tSkAIuZly46zzk6Y3l2V/t4/8+urazr6LtlGSYNTKFn/DIntt7nNj
         x9gF7dfleVASDvCkMcL91U3GfI+gH/7U7LKxcOsSVyp0blD3+Bt51I7Ve/Wa3oiQvvRx
         vPtw==
X-Gm-Message-State: AOAM532uZZLgGTIDvdes2aUpTEnmOLN4h5YUAfYCwdWW31grcoyAbNEC
        SsPXjOiQJwUz1hBDeMd92hn8lhMxd7VQ9oOECqT5bg==
X-Google-Smtp-Source: ABdhPJya/0Lrt69QiQ3tpO89kn9Jiesh9udHaZI0RtZUpMOO6un0Cirkv8nrQhOjTOawdWox2Gz4IGTOhZ/sx3fUCOk=
X-Received: by 2002:a63:f14b:: with SMTP id o11mr11989658pgk.440.1615558061031;
 Fri, 12 Mar 2021 06:07:41 -0800 (PST)
MIME-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
 <c0f6a95b0fa59ce0ef502f4ea11522141e3c8faf.1615498565.git.andreyknvl@google.com>
 <YEtKVYVeUycUKySP@elver.google.com>
In-Reply-To: <YEtKVYVeUycUKySP@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Mar 2021 15:07:30 +0100
Message-ID: <CAAeHK+w3C+Umd9j__P=97KHQ-AEqS10gi-5DA5tc0Yav5zzWEA@mail.gmail.com>
Subject: Re: [PATCH 10/11] kasan: docs: update ignoring accesses section
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:02 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, Mar 11, 2021 at 10:37PM +0100, Andrey Konovalov wrote:
> [...]
> > +Other parts of the kernel might access metadata for allocated objects. Normally,
> > +KASAN detects and reports such accesses, but in certain cases (e.g., in memory
> > +allocators) these accesses are valid. Disabling instrumentation for memory
> > +allocators files helps with accesses that happen directly in that code for
> > +software KASAN modes. But it does not help when the accesses happen indirectly
> > +(through generic function calls) or with the hardware tag-based mode that does
> > +not use compiler instrumentation.
> > +
> > +To disable KASAN reports in a certain part of the kernel code:
> > +
> > +- For software modes, add a
> > +  ``kasan_disable_current()``/``kasan_enable_current()`` critical section.
>
> Should we mention function attribute __no_sanitize_address (and noinstr,
> which just applies to any kind of instrumentation) here? Perhaps with
> the note that called functions may still be instrumented, and in such
> cases would require combining with kasan_{disable,enable}_current().

Indeed, forgot about the attributes.. Will add, thank you!
