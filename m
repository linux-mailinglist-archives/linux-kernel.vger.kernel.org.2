Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF9354D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhDFHJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhDFHJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:09:52 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7031BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 00:09:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 82so4522567yby.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EptXV3n38qfCxuftfWu1eyuZks7dyBErMRQJNfNJOIw=;
        b=dPBeKzjaL6iXdjo55INdmRSg9kvQ096LpOmKKUeEuzcxP71MuVcXXRbdmYZ+gLq3L1
         EXBrkKBx0uTq9E0wsGlCLBkPX3bQS6RK//EixYEx1qy46wxknBiF5d0SLEioTtQlgt6a
         klR+DwWy34vOfVO784TsMf6rrb55v7DK9DBsfpuD+PdQhz012dkvKkLeGTunkvzbVg7b
         3xDYTRofrPUZhWUfybCdLOppYZowUV7koNxI8b0CPU3QnOQxWtXQSXS6WN6SOhEny7K4
         eoyTVWh86S5oYn6XRBuUWuAFLUlncsbt68Gqi6Eq5llCLOvrxaAFz/pGsj4qE25vO1wT
         JmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EptXV3n38qfCxuftfWu1eyuZks7dyBErMRQJNfNJOIw=;
        b=rn8KAiqA/AEvGwjQRnZeRf6rw9wmLlJwIGQU7ZPpRM5vTiVvrksbb7WfqYqVJCCqNL
         T4PJeAOf0i1eE6G78N2pj5x61wVE7Wtj2+0E2ckbr9VEoBDwUXvuIffeinr0doy0wgMU
         H5XNN6gcXKzbSsmdHGOqd0TGJ90tpqk8cWz7aCHSKN7++Hy1v+YKAuM/ORKXn6Sqs0hs
         gkmmngQsY4Wa0dY0uXfXYpV28WavMZ9wYHKLnOlpZzBs+QR/xHRUXI5irl9q6Cw79xp3
         RC2/lID8xDCNq8hXqHDelinNvMPtXcBFmqdpgPf2KcEARZs1+hgGlpE7OrcSWV9KADEB
         4oUw==
X-Gm-Message-State: AOAM533W/wPhK0TLSWqPPpbeIdUj58I4Kx08UynK4qRp5J6EgjrTVyon
        f20VhrjCnqn/OvpYL8dRHlcelAN3lGoSMuQsJRFJ4A==
X-Google-Smtp-Source: ABdhPJzYX8sAQaI3s4+gY2nPfHhx42OGH7m3I/dWejrqnQ/WakzWPT4gGfS08jVcXX36GEIwnBR1g9q8Et80+5Ufa4E=
X-Received: by 2002:a05:6902:4d2:: with SMTP id v18mr28480009ybs.303.1617692984148;
 Tue, 06 Apr 2021 00:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210406063924.GC7352@xsang-OptiPlex-9020>
In-Reply-To: <20210406063924.GC7352@xsang-OptiPlex-9020>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 6 Apr 2021 09:09:32 +0200
Message-ID: <CANn89iL+Df9hDAkt7fPH3Dc-2CDvuLWdUAOuZB77QMNWYu_yMw@mail.gmail.com>
Subject: Re: [tcp] 4ecc1baf36: ltp.proc01.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 8:41 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 4ecc1baf362c5df2dcabe242511e38ee28486545 ("tcp: convert elligible sysctls to u8")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>

I think this has been fixed with commit
d24f511b04b8b159b705ec32a3b8782667d1b06a ("tcp: fix tcp_min_tso_segs sysctl")

Thanks

>
> proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
> proc01      1  TFAIL  :  proc01.c:402: read failed: /proc/sys/net/ipv4/tcp_min_tso_segs: errno=EINVAL(22): Invalid argument

...

> proc01      2  TFAIL  :  proc01.c:471: readproc() failed with 1 errors.
> <<<execution_status>>>
> initiation_status="ok"
> duration=2 termination_type=exited termination_id=1 corefile=no
> cutime=13 cstime=233
> Oliver Sang
>
