Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192B63D5AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhGZNHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhGZNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:07:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C96C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:48:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a7so11344149ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivg9o7rg5ISps4s8xPiG/wJJnOVUYqQKPCeKI3UTaIM=;
        b=wDfbtJKa8rkewnwwlv1vOunBRLNNIZ0IAovVCNkT8dYkmoebPukHdYjqoBpQQCkIPA
         BSt7fdmqa99u+m2zWNqQXPIC1VyfNkdhpQOt/dZe5Qh9mr62G7pLWe8ZCGTuungQ1xzl
         IXolVFnrUHy9hm4a4ZtiCHE96Lwb9Wo+lPA++LrNbqUvHEi77vClI/M3LdrANuaNqJy9
         8v7id8U/2+MLo/Kt9EM/YRgkO9MPXW/E5uW9KkqLdXpt9ojmw6qiGWwGmimZ9Bw2NJoY
         kLz9pzTwHjsCTamE5VXBJc5y6ICqsWUmNjz05PYzPX3FCWkc4HYvNnmpELZmljm1jO5t
         nrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivg9o7rg5ISps4s8xPiG/wJJnOVUYqQKPCeKI3UTaIM=;
        b=tKabzzbPZjrMt5BrYrOROO85rOlkm9xJjlzyOveksDs7t2XYL4IW9ShRTynKdRDG1U
         rRTt7qaI/u4sIwLxJxj5PldzXUlw5SmdI6p+g1muWg/K2ZjNMXnog2miruq4gyEQTAOn
         VEAe6SZs0DqTqa+lALxsF9aWW40glu9i2xCy7kBk5/kA900BttCCyMWbqfEX2B2FeOjn
         JLjeVX9NSArY/71AbJDUtlUc8WEU3W9Ldye8oO1f3YIKmONECStCSmWIpbC4TzbB5kkw
         y1DQu+0N6jSXhoHobEHN2xSRVGKQS+ss+fSRRQv0y/xqhgUugnztRCyZbaPVQHL2/L3I
         Myqw==
X-Gm-Message-State: AOAM532xlWYug3vTu0zu5YAwAIwTA/C5ibjdyls7iB5E1XJYTF3qUqd8
        uoWPcdou7He5QlKJB03Vm40YsmDkqSmV569/r6WLCw==
X-Google-Smtp-Source: ABdhPJxHXb9YaS4LzM7Q/bLNJhDwrbwHc+yaqpazQVVWNbe7nnL7ulo3RPPZbSQsR8iDmz8lMczetqJdTfausWL/L+g=
X-Received: by 2002:a05:651c:1211:: with SMTP id i17mr12499330lja.122.1627307293966;
 Mon, 26 Jul 2021 06:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
 <cover.1626688654.git.vvs@virtuozzo.com> <9123bca3-23bb-1361-c48f-e468c81ad4f6@virtuozzo.com>
 <CALvZod4HCRHpPJtGE=8tU1Yj=WsWHpocP0q0JU3r4F2fMmAw5w@mail.gmail.com> <08151b5b-f84a-aa32-82a6-0b6e94e63338@virtuozzo.com>
In-Reply-To: <08151b5b-f84a-aa32-82a6-0b6e94e63338@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Jul 2021 06:48:02 -0700
Message-ID: <CALvZod5-XtaeawPtEgnp9xwouy0KfuDbpykB6Z3b+8YJyCrLVA@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] memcg: enable accounting for IP address and
 routing-related objects
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 3:23 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
[...]
> >
> > Can you please also change in_interrupt() in active_memcg() as well?
> > There are other unrelated in_interrupt() in that file but the one in
> > active_memcg() should be coupled with this change.
>
> Could you please elaborate?
> From my point of view active_memcg is paired with set_active_memcg() and is not related to this case.
> active_memcg uses memcg that was set by set_active_memcg(), either from int_active_memcg per-cpu pointer
> or from current->active_memcg pointer.
> I'm agree, it in case of disabled BH it is incorrect to use int_active_memcg,
> we still can use current->active_memcg. However it isn't a problem,
> memcg will be properly provided in both cases.
>
> I think it's better to fix set_active_memcg/active_memcg by separate patch.
>
> Am I missed something perhaps?
>

No you are right. That should be a separate patch.
