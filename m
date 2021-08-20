Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F593F2715
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbhHTGx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhHTGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:53:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39FDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:53:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q3so12518451edt.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZV0k7Tiq6KI/tbutIIDiQigPzOBPpHO6yPvk1gd0d5k=;
        b=M0Da5hEGnwOCOs+9ib49H1x8sY+AAW+vbbh7qhBDFsF1ysrVEJJuUE9wSZ6bR+Yx28
         rhJrV2zL4eANa8t6Vrobm/GZhA2n1SzbLMmjSC6j9OpHThk4bvEWukaqDlcxpffxelW8
         Z8s0sv0zg6LWOHPHxvb0PQMnpcSckb6snYdLB60ld/v6h4YzabwrdCXnrK5ohJznKtzQ
         O6r2Ob/s19ifKQTQOLgeob0y0sCAQvkisWdoPeLxHkRTFlzxTiwqviRYyvma5GcWxlga
         dmm+YumExxXwnl+nc5OYZT1iGuiiE2FZTDwuJp5Hq5QmMgGxSlBA5XJHZCICh6HLqtAF
         CiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZV0k7Tiq6KI/tbutIIDiQigPzOBPpHO6yPvk1gd0d5k=;
        b=frQg4cNFn4ae8Qy87eADkLIR/vm+3vtEcyrihk5eaQ0k0dPFTq5J345gfk419iCxJE
         gnUZ2OmxNeIhnHCPlN5V7bSgw/8odeFtZCToZav8MWQjEDHZRrGeNyg0whS4m1i2tKIR
         vvozuo0VveXXpzs28ggJjOrLNEL8voXfl31NgIXVPRgxcVarWOu8cNK4TSQixqW7FlaP
         EBwFLFZpasI4uk5Zr2APm1de/3ZqhDH8vNW5x74LZsgS9JBdo8hHS9k2vgJDG+Iz6vJG
         JrtuBcJIHgvkMBIh/Kzr7nDRMMlPifyMXDghm+CX841liPwjLERbr8ku0wTJ4SXF8ZAK
         KdGw==
X-Gm-Message-State: AOAM532pZv+Tg3zHcmOYdD50TeNBKy3LZN6etko/EohwOyIYVPccFNKS
        WNHopYzXruR6OqWvGwIfhU4yRD3kYHssn5u/rG0=
X-Google-Smtp-Source: ABdhPJyUhHkMl7/Q9bGcIKdKvKoDfzstUmLlaEJbEonjdh6ZM40Ovy5v9kwJV21LF2yyDkuKJXqgUrYVofqxKdGCUjA=
X-Received: by 2002:a05:6402:1606:: with SMTP id f6mr20556903edv.111.1629442396266;
 Thu, 19 Aug 2021 23:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210819163056.GA9764@haolee.github.io> <CALvZod5m3PE1vBEaW+FoiByYHGJZiDF5TR-33dGXpH7BNNcvWw@mail.gmail.com>
In-Reply-To: <CALvZod5m3PE1vBEaW+FoiByYHGJZiDF5TR-33dGXpH7BNNcvWw@mail.gmail.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Fri, 20 Aug 2021 14:53:05 +0800
Message-ID: <CA+PpKPk8ocZO1HudfJ2manCrgV+A5Q2paz0g-k6DaxYnKt0zRg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgdeactivate and pgactivate
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 4:27 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Aug 19, 2021 at 9:31 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> >
> > After the commit 912c05720f00 ("mm: vmscan: consistent update to
> > pgrefill"), pgrefill is consistent with pgscan and pgsteal. Only under
> > global reclaim, are they updated at system level. Apart from that,
> > pgdeactivate is often used together with pgrefill to measure the
> > deactivation efficiency and pgactivate is used together with
> > pgscan to measure the reclaim efficiency. It's also necessary to
> > make pgdeactivate and pgactivate consistent with this rule.
> >
> > Signed-off-by: Hao Lee <haolee@didiglobal.com>
>
> pgactivate and pgdeactivate are also updated in code paths other than
> memory reclaim like mark_page_accessed() or madvise(COLD). Wouldn't
> that impact your analysis of these metrics as well?

Thanks for pointing out this.
These paths indeed increase the pgdeactivate and pgactivate counter, but they
all can be seen as system-level. On the other hand, the deactivation and
activation in the cgroup try_charge() direct reclaim path is cgroup-level,
which is caused by artificial limits. If the system memory pressure is low, but
a cgroup is going through aggressive memory reclaim, then the two metrics will
increase continuously in both vmstat and memory.stat. I think this is not
reasonable. Suppose we exclude them from the cgroup direct reclaim path. In
that case, we can determine if the system level memory reclaim is hard to make
progress by using pgdeactivate/pgrefill and pgactivate/pgscan roughly
("roughly" means we temporarily ignore deactivation and activation in other
paths). One can still get these metrics in both system-level and cgroup-level
through memory.stat.

Regards,
Hao Lee
