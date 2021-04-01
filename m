Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6526435128A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhDAJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:40:19 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:38616 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhDAJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:40:08 -0400
Received: by mail-vs1-f50.google.com with SMTP id r12so917581vsj.5;
        Thu, 01 Apr 2021 02:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlZPhLbLjyArTWcGf9vQn5+R2JQ3oOIwh7hu7M8eTGE=;
        b=o/EQ8JoJvJ2iTmll3q11Ti/3+APHvYlQoDNyuqJ0VGCFWUTEsWVq/PgJvBCT4Vjk97
         5p1O07TEdTWThV5urFcFO+NzwsxqA+c9dqezsFys2CHoY0tTfE5sz0xokiOmSqJ3Viui
         cWFx1SxNm27bTkIkh062lSv8/nj9dMkjIK3LbBeCdgT9ZtdhHS7eqtGIqZUJCLOzjztY
         CGpsPOHqqIhA5aR3TUBGCg/e51q6ghyEhLmkgYjsc6rx7//qHTjrIQZf0bK2fJUTuY9s
         Fsr0gZVSKJAytgyoVAtQA9py/xOCAUzva4tdWgGvLugQnUYB1NX4nLZbK6JStNob/Kd/
         53fg==
X-Gm-Message-State: AOAM531UCdTqLyuqMAcrJD2ZKHB9v9FLlaGzNygPiX478imC3aLPbYpx
        WCHKQJkhCN/sYNkju4bYz+sS3qBLLEhhADFroM0=
X-Google-Smtp-Source: ABdhPJwtjhpCL5W/EAZ6ZkPr/6GjXlFv2xr2ixEs/0hAzf8mGhOjkLhWBwxFQthEFvBZl9MIhgLDiGsTQqnyLl4S9Nc=
X-Received: by 2002:a67:1ac7:: with SMTP id a190mr4490994vsa.18.1617270001553;
 Thu, 01 Apr 2021 02:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210331093104.383705-1-geert+renesas@glider.be>
 <20210331093104.383705-3-geert+renesas@glider.be> <20210331094007.77aa5194@gandalf.local.home>
In-Reply-To: <20210331094007.77aa5194@gandalf.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Apr 2021 11:39:50 +0200
Message-ID: <CAMuHMdUvgRiYfsVOJdocB3peLhnDWe=Kn1MLW64sh8zpd2XoLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] tracing: Use pr_crit() instead of long fancy messages
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Gary R Hook <gary.hook@amd.com>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Embedded <linux-embedded@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Wed, Mar 31, 2021 at 3:40 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 31 Mar 2021 11:31:03 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > This reduces kernel size by ca. 0.5 KiB.
>
> If you are worried about size, disable tracing and it will go away
> entirely. 0.5KiB is a drop in the bucket compared to what tracing adds in
> size overhead.

Fair enough for this particular case, as tracing can be disabled.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
