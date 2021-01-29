Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE5308330
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhA2BWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhA2BWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:22:39 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1CEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 17:21:59 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id z18so6903905ile.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 17:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goQE4d8A1p31u/QXZkkqm0DY13eqBaq7jRtvdi+jOgs=;
        b=fuJr2QjiN8x8elyRzGFBO4Zky7J4R4c5jWDr0WNduUlI9Q7Y3cJkbwihblRA0j30fQ
         cy4eURjiMPULO4tgjiwbeX1mDHcdLajJISBP2Tjs5kMFTyXEMpdcQkGW6fzCRXueyyNy
         Em6aOO8wr6F+QOFo9FYicBQ0aCP+tfFg/O5fBZfQvOrcsf9gYD9D5dhRu1diI6L5SM7B
         DXI1tA9RgiOhGwOZYNCCmglLS+iXgnxjGLR5FZfrW8HqUmmPdXDk7r2x8fJCgps0TKm7
         thMaDGtLnkhdx8dAnqA4XP42/6ZRJPiJ8w6YoMoTG0xGuzZiSU4txBYJxM16fTi4WdKq
         Qs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goQE4d8A1p31u/QXZkkqm0DY13eqBaq7jRtvdi+jOgs=;
        b=gGl3/9wDe3NYTw8prtp3e13eMwAC/c23Y3TE0J8RCsm7b08Iu/xevZLtfrBlMbEPHK
         evVHWO6BpEFz751/tr4+LU3bXHVe8rXRCuYuxfym0Jwaz7tg2UmuLkCpbZFiBwO+JZK3
         2OkUpZgi33zH/sI/Mzc2unZg/tn69p39JQmAEPd8nxdPgITpPkeu7eeJrvsIFrKxfITN
         B7OZszmVz4uWn9PKBDuDBnHzZZ0/ooYuooKEFSx+C+CJTsjMRTtu5Y8p61qTzZRcd7Qf
         h4/LgZJUUjbybFz+rcEijuBK30zlI/Ypn8PIP2b06M0gV8IO20kXxLvlRO+ZfxkDGx4e
         vJPA==
X-Gm-Message-State: AOAM531qXntPU29l8iuFGMG/NubDH0BouGs3tD4KB/YPHMhO6f82CoLC
        4y8v/7v4x0R0Z+zdXBEJUMJXva45QZjV+odvDfc=
X-Google-Smtp-Source: ABdhPJygBCDzjRJPs1rnpNr17iT9uubszS4K67G1h0VR/lSsPoTrZjVB7bn1n+JuBkRZRIwBemgWyrCSQ5vT00GRC3U=
X-Received: by 2002:a92:5bc2:: with SMTP id c63mr1536599ilg.142.1611883319017;
 Thu, 28 Jan 2021 17:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20210128021947.22877-1-laoar.shao@gmail.com> <20210128021947.22877-4-laoar.shao@gmail.com>
 <YBKp/NHanaN4e0im@smile.fi.intel.com> <CALOAHbA+MV9Xi5Ge--6F+e9bqouJvXfWmqP6ucvUkX8CWNuQPw@mail.gmail.com>
 <YBLPLRZ7GXILXuyM@smile.fi.intel.com>
In-Reply-To: <YBLPLRZ7GXILXuyM@smile.fi.intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 29 Jan 2021 09:21:23 +0800
Message-ID: <CALOAHbD1=eZT1DLBoRJHqG0nTSdHkB2TQ2P-aeSRr-fxJvjCrQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 28, 2021 at 09:18:24PM +0800, Yafang Shao wrote:
> > On Thu, Jan 28, 2021 at 8:11 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > Thanks for the explanation.
> > I will change it as you suggested.
>
> You are welcome!
>
> Just note, that kasprintf() should work for this as well as for the rest
> printf() cases. That's why it's very important to return proper buffer pointer.
>
> Also read `man snprintf(3)` RETURN VALUE section to understand it.
>

Thanks for the information. I will take a look at it.

-- 
Thanks
Yafang
