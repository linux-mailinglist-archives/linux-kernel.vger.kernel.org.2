Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DFA3150D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBINvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhBINth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:49:37 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4543DC061794
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:48:57 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id s18so22375027ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6hyX38mFJ+6yDNoRa0BGXqLisY4Yt/Qs5tS4tQuLTM=;
        b=Lnr4Vpipr9eoHCBAXs0vIMZqnnLOPt5XJJY6hZEYAEXJLxFHjgBAEVv1hMRDeE70Zu
         SPfvjE9sH0FPF2chVvLMxOf68LUhxTq+qZ/JYFtOm/zKjaGbRZSyxuO/WEzk1e+/jPcf
         wa8p46aN3DkPxs0WMp+llHSAdjEt6ZVLeBHVZF0ydb4SyhCi7gM/XYPNq96BaVzTlZPO
         tnE+xKkoiZsZq8OWZR65+m4MG9uSN8HUF+c61TlJdXXZGZWuw9/X3h5jvYTJ/Ahv+vt5
         2d00sw6ydU3gfg7oAsyhyneHfaFA/Tr92JOoGVJj5XskNx8aAQJ7euKvLBShn+SZXz9j
         VhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6hyX38mFJ+6yDNoRa0BGXqLisY4Yt/Qs5tS4tQuLTM=;
        b=ArcsAB4leTSfMf/cRLZzoU5UtSztEZLwLOg9m+JsUdKI7czikSA/GK2Z9y/Hk6pEYX
         Ag2Ajlnph9DodnMbc99VGN5yJDifi5LF63D6AL7K0NzGSCVvrgQR043n3QkyhQnzWwt3
         bxKTZv1P3OYicAnMDHwO0spFNjVofWjU4sxK8wLARN2JNMaP4im65ju8f7BuDVo+49X9
         XfavpZLeWW+zpWD10/Zodd46hIKtWz4YeohIqJLXh1fKHNggYH0sKr9Ll+65uXAtl3ll
         MwWnZ7y7j4TAHi2Lupnc2vVXWxRX9W+H97cg3l6GDCRSFj+TN3y1oH4bCKIR87Uv6fFb
         VH1A==
X-Gm-Message-State: AOAM53092pnYK8A46S2e8hUnen6hICQN0AkUQ3lIJdd01TvMM+FrCpUN
        CbfO3d1w8RTpuBqBcIF6mACAY4YzuRg/9MMzIE4JqQ==
X-Google-Smtp-Source: ABdhPJyLt44bzUjpu6Y8sHGTFfy5PZuO0xZAOmT/z6qaaoQpN60RFk8x0k4fYzlAfbSMW3PiuKVgCHpucU/OkVGtTwk=
X-Received: by 2002:a2e:b165:: with SMTP id a5mr10040263ljm.81.1612878535285;
 Tue, 09 Feb 2021 05:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20210205182806.17220-1-hannes@cmpxchg.org> <20210205182806.17220-9-hannes@cmpxchg.org>
In-Reply-To: <20210205182806.17220-9-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Feb 2021 05:48:44 -0800
Message-ID: <CALvZod6Sy-SAUdAFMP=Bot_gyzGQqW2LrOehRbE-qUEgveFF8Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] kselftests: cgroup: update kmem test for new vmstat implementation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 10:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> With memcg having switched to rstat, memory.stat output is precise.
> Update the cgroup selftest to reflect the expectations and error
> tolerances of the new implementation.
>
> Also add newly tracked types of memory to the memory.stat side of the
> equation, since they're included in memory.current and could throw
> false positives.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
