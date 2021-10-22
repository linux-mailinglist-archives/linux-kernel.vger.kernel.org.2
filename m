Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEFB437C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhJVRlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhJVRlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:41:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87CEC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:38:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so4347534edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPYoNgwJMJvckGbmwxEVj2HyEBD3w36KB+IYdEkY6MA=;
        b=mE2xVjVmqMBiKP6FhQOYRc8CsekC8hhuCCX2rrVntAwz6qOcMTy7O26tWxYizEvw4R
         KjHQZ+jUq+Miy9RpBhX/pWtQjr9OW8QFoS/ZWiTmkp+i/WQDqciTtSNMoYGl88/MmNB4
         /0H6RALFCt11WN+BdTb3m+vVXVE3Qkp0O2jTYCVgibwY5wSWi9HsuMJ0IHijC+6hhjex
         O6MZ15HgDh6EKX/W3oxvbnXjxPVo4b9TqdaH+ZXFnKjb2ngIdY0aP2f0UvXJMEsQctCg
         CEsF92Jo/WT4GIAnD9qS+6bJ5N9zteQlBEafCNyaeh7pZ0AGQrYkp6RF0GJkElwZmH9g
         HpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPYoNgwJMJvckGbmwxEVj2HyEBD3w36KB+IYdEkY6MA=;
        b=v+zop6SCSY+A9ieBZLrDtCfmdrJ6f16F1LWUPpH/2nZqWZjguE7ZsedBVy8JRbCsvX
         Wtl9OZyxoAA/hH3FNhlsqDxNraIeCHRDB8r6oUMjlGv+6cwa//BVdg3qwYvC+4LInUHH
         AWlNde7gUwCJmeQkk5zYkddS/2ba16Zu2xtyVCC9npBvqiSnYvtZ8clzpsbnBxKMFGrI
         xIpY0T8nxoEYKDTdievOGK3jbX2Io18ssCNq/dqu4HpN/yUXlcjofPy1LjBZyWR9/Sp4
         ZptF8ZsGTmRJwOf8VNvKppG8ZbnkFikg4X/h5rwtV27kaNvjKt9rZl7qYClJGKaut6N8
         wFhw==
X-Gm-Message-State: AOAM532XJkieB4/6tZQmixbLyCFtJvSrCZOvnXGOAgztMJ8L1YlCmLZh
        kJzZow5mI254r7GGRJUo/vNd4zU6CCIU+fnyy0lMFwnHQxA=
X-Google-Smtp-Source: ABdhPJwBJTsdQIOewen+qXgbUpm91ooQGoBqoe1jLp1ZXH6lFLQH6dEa3Dthq8fs5Sy6h3IvJfJc0pvFMPWx6shcIo0=
X-Received: by 2002:a17:906:470f:: with SMTP id y15mr1048897ejq.521.1634924333542;
 Fri, 22 Oct 2021 10:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211022074619.57355-1-andrea.righi@canonical.com> <YXKdRDKp+l6lis/R@casper.infradead.org>
In-Reply-To: <YXKdRDKp+l6lis/R@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 22 Oct 2021 10:38:41 -0700
Message-ID: <CAHbLzkqFpADQmrPq572M-y53ChJzFJ+uDOHUzzeRFUTv0acq9A@mail.gmail.com>
Subject: Re: [PATCH] mm: fix sleeping copy_huge_page called from atomic context
To:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 22, 2021 at 09:46:19AM +0200, Andrea Righi wrote:
> > copy_huge_page() can be called with mapping->private_lock held from
> > __buffer_migrate_page() -> migrate_page_copy(), so it is not safe to
> > do a cond_resched() in this context.
> >
> > Introduce migrate_page_copy_nowait() and copy_huge_page_nowait()
> > variants that can be used from an atomic context.
>
> I think this is a consequence of THPs being created when they should not
> be.  This is the wrong way to fix this problem; and I suspect it may
> already be fixed at least in -mm.  We should have taken this path:
>
>         if (!page_has_buffers(page))
>                 return migrate_page(mapping, newpage, page, mode);
>
> but since we didn't, we can infer that there's a THP which has buffers
> (this should never occur).  It's the same root cause as the invalidatepage
> problem, just with a very different signature.

Yeah, exactly. And I replied to that syzbot report a few days ago
(https://lore.kernel.org/linux-mm/CAHbLzkoFaowaG8AU6tg_WMPdjcAdyE+Wafs7TJz1Z23TRg_d8A@mail.gmail.com/)
with the same conclusion.

I'm not sure why Hugh didn't submit his patch, maybe he was waiting
for the test result from the bug reporter of that invalidatepage
issue? It should be fine, the fix is quite straightforward IMHO.

>
