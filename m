Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D24413AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhIUTXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhIUTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:23:30 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1CEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:22:01 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id a14so351791qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byXBBhU5G/dX1Qqhyk4gN1a19PMCtYNKaaSGr1kUrRs=;
        b=EvZDvB7LmA2IyY4MVygYFtKioK1bGvZ7061aL7ddxooaWOmRENaPeREb4wxcFr8o0L
         r8k1lvp8GelOqDb2pSAG84OdjcFCBVurNdFmj4kOQolcQqYNb7a4KGwkM4a2UjFpQvQh
         AzGEcH3A8/R5pbUoahh+Pt5hpeF+YilcZd0LRGc75lEGnCyn0zQ5v0aNTXgWCsa5nHl7
         lzOK9L8Ve/TCsty1YKz/vsk5QhMG07apoaHp+rLL7tAFy5D7azMw3nzbyOffNezRexik
         7/KDQ6TncKupQTxUqgbGpWJ7JWfJ/dDt2vZyqJ+aj265kyu3VAIHt1nE/1ydJXq6gj7C
         06Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byXBBhU5G/dX1Qqhyk4gN1a19PMCtYNKaaSGr1kUrRs=;
        b=2JK7jwTmYrE5sOA9OqnHA/IqkWKQMRoCSx/il0vwAOtZYPk7myWjyWIujKEX/3rpM3
         oMkusLaPV48Gw6iUufSbmEnKnhoO/7WQuzxsjjC5Jo5cdDn92T9mVE+2Xqw2ibDbtSl9
         lHqoYnJWEQ9CKfA8//ZwZaoXWxGXJo6djGDgKrMlnhazuAvQgK+Qf9L78nKEWCwwL3g+
         8zX4BFjdN6+2cfbmlkAhgLCIpEvaOwTYEyJakON6ijf4Qw3CE9pTAHUcSD8z1DJXx6ju
         njLyIoTar50i3PPaN7298IVMTllPpBTpIx8zpadyjHScTKEdMlkblFblcY1cvMO2qAoD
         c/NA==
X-Gm-Message-State: AOAM530NiWiaTLGUzI8owLkfHW8dwn8M+ajBZnFamcMg2D5klK/5CQzt
        BH/hoTjDAQ30K71MNoWSola+Z5/QCvZUv2yJmkzaPg==
X-Google-Smtp-Source: ABdhPJz0Ho4THpSF6Nj2Jumm1CHq2QVYwNJy96vcGeI9zidjQ36kqZjuY4DLLpqKFcUtFsKwPNotMvEe3JVnKXoyq88=
X-Received: by 2002:ad4:5591:: with SMTP id e17mr32824080qvx.50.1632252120925;
 Tue, 21 Sep 2021 12:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-5-mkoutny@suse.com>
 <CAKfTPtCAxksmsR6DJuAoSZ7XTon+gesyic36EHL-nQk0LiHWQg@mail.gmail.com>
 <20210914092207.GA23743@blackbody.suse.cz> <CAKfTPtDw6_iMxGyCK8vrwgV-zMyHtNKBksxs3OpbpK=houzp2g@mail.gmail.com>
 <CAKfTPtC5+4gf_R0bAVHe+0Fw6dQYQ_a-f529H9s4KLpm40X9Ng@mail.gmail.com> <CAFpoUr3APdFordH+1XjHPWP5FtKuQBAXSRTt4arruMkQcx2ufg@mail.gmail.com>
In-Reply-To: <CAFpoUr3APdFordH+1XjHPWP5FtKuQBAXSRTt4arruMkQcx2ufg@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Tue, 21 Sep 2021 20:21:50 +0100
Message-ID: <CAFpoUr1S4N1g_pP2d9_EMFn3zuwQejsxkBbCd5LTQ-KuwOXbLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] sched/fair: Simplify load_cfs_rq_list maintenance
To:     Odin Ugedal <odin@uged.al>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the changes in PATCH 1 of this series [0], I think this logic needs to be
updated as well (or correct me if I am wrong). Did a quick look now,
and it looks
like there are some conflicts with the linus' tree when applying the
series as well,
but didn't look that deep into what caused it (for ref I tested on v5.15-rc2).

Not sure how you want to structure this patch series as all the patches kinda
depend on each other, since you sent the updated one separately (and I
am fairly new
to kernel development, so I have no idea), while patch 1 is fixing a
"real" issue
that we probably want to get fixed as soon as possible.


[0]: https://lore.kernel.org/lkml/20210917153037.11176-1-mkoutny@suse.com/

Thanks
Odin
