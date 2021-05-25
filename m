Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72A390587
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhEYPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhEYPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:35:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC67C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:33:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v5so38672383ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X49KMwK/wFJ5JRpDV/cPj1TnCcaYZUMIUrxY6R7DCKg=;
        b=im7/D+yVaQx6FpQ+llblSwQdRwG0A+5z3rqPbU+VMhK3kfxsYzfm9ktDfxJAPWcbak
         mIrqCt4KVwD1I0W+yIrbN3ZQvsLLtYbH1S+h/1a1et4secGpPSIN0HiA9Aa+hTBvyLPy
         0LS6+bGEDy3CYKRIcY8G0Y2ov96/5OqC0CTNtiPWe+kPaeob9WAui/xL572OdawACfX5
         qC6GoSPieg+nFJp0QocPu/DV+14vxwwH7gCf3HTIsc6SAbb/EiSZepvtgrQ/Wj5do4Oy
         eQaAYOPBrDSqTVbf8+ZN5jj/2S88yHdsY4x0lvMx8JSTs7nKGgDe7jobMwsi9ndtZJtT
         4xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X49KMwK/wFJ5JRpDV/cPj1TnCcaYZUMIUrxY6R7DCKg=;
        b=jpr6QMnGSZIJz67Zvmph5XYcusWpDCmdOaWHoWPkQAwKWfuEEMktlbhdoqVa7avO4h
         gyPnIRr4dnw5GvAaGDUXhyUXFQuP8V5XuTcWnaE/kSJrqAlxxP677zhI1seYoOBqNFut
         9Gy9Vex8aIR0YYgs3EcLqYDe8Mo8yaINYIzUDGvuiCD2UZT7/l/mlMAwkMvxSTKf9x9e
         3BUPp2gTc8aGISuX66LUK3wL3dbDa9DUgmo/Ks5iNJNKKifMV8pwNd8Ging7AAq2LXhV
         uE1Sh+c7LC2CWHyyiMrwDksub0oMHrKlMdP4TCFpb/9Fxj0hr7U3Qw2LOQq/J4JYZ2Pz
         3sew==
X-Gm-Message-State: AOAM531lFP+Ium19Aoc3JPo2lrb4SVFPTSApvJPTtZ2Io4M4Cp1mBh4n
        vx04j8WnbopxcB1V4EjrlC4T5Eb9ji0PpH+opYcWgA==
X-Google-Smtp-Source: ABdhPJxW1F4wWTwQEstaJ2F6GBFViSsp+FTGJ5nQLzA4Hzj1FHhM7WeZcOf1WfX1bwG/4s89xV//q29rhiqnW9ZFaBw=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr22068665ljo.94.1621956830209;
 Tue, 25 May 2021 08:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210524233946.20352-1-vbabka@suse.cz> <20210524233946.20352-26-vbabka@suse.cz>
In-Reply-To: <20210524233946.20352-26-vbabka@suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 25 May 2021 17:33:23 +0200
Message-ID: <CAG48ez1mvUuXwg0YPH5ANzhQLpbphqk-ZS+jbRz+H66fvm4FcA@mail.gmail.com>
Subject: Re: [RFC 25/26] mm, slub: use migrate_disable() in put_cpu_partial()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 1:40 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> In put_cpu_partial, we need a stable cpu, but being preempted is not an issue.
> So, disable migration instead of preemption.

I wouldn't say "not an issue", more like "you're not making it worse".

From what I can tell, the following race can already theoretically happen:

task A: put_cpu_partial() calls preempt_disable()
task A: oldpage = this_cpu_read(s->cpu_slab->partial)
interrupt: kfree() reaches unfreeze_partials() and discards the page
task B (on another CPU): reallocates page as page cache
task A: reads page->pages and page->pobjects, which are actually
halves of the pointer page->lru.prev
task B (on another CPU): frees page
interrupt: allocates page as SLUB page and places it on the percpu partial list
task A: this_cpu_cmpxchg() succeeds

which would cause page->pages and page->pobjects to end up containing
halves of pointers that would then influence when put_cpu_partial()
happens and show up in root-only sysfs files. Maybe that's acceptable,
I don't know. But there should probably at least be a comment for now
to point out that we're reading union fields of a page that might be
in a completely different state.

(Someone should probably fix that code sometime and get rid of
page->pobjects entirely, given how inaccurate it is...)
