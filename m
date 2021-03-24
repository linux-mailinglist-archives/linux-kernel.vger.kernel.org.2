Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF953474D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhCXJku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhCXJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:40:28 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB9C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:40:27 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 8so13431339ybc.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fXoPqzOon3/AnLhTIqZhn57sU6mwxraeo5GXfFqhvg=;
        b=s9NvS4U8Ig4059GjRGpH2V1LgDT0SSmXw/RvxetCi6c5G8TdpLfrADMWS4lW9lAgc3
         pgIJig/Vst0Lnq9EYiDUPtXnVDQpQEXhDmGAXZT51Mpb6ear+Uh4s2Em/Z5IDBhQD6rW
         2QAD+3Z69BDVnW0Iq+i92MIZAiIUdu6OjIO4HDbAkiePNoEc7o1U02KydbUSAUWUtg54
         Jvu68paxqCGSrGvNEJwCdcB/MLR86o08vmbBblm5cCkMJU97VmF6bWuT7KL0xHiXHhPR
         at9CnKnBL+cx2KvA/KBIvKciWtYuNYymZHjjJysrgXRx/PGszgo/zSZeocwReWJQ9d7r
         H8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fXoPqzOon3/AnLhTIqZhn57sU6mwxraeo5GXfFqhvg=;
        b=sh9L6qYRWYtnDcg9RxmdNOvtuu1aa2Cl2vs0B3SxWFsAO6+QdU3I45u4JjKg1TzE9+
         Uq8ZwwBDm5MsEwBEnE2BHvZgJLWW6zHHUkPxasHkWqVrF8cqcgCuiemXtiC80Q6VoulM
         7Dfhr0595bbfL2etHFYBk0OKZzmURMaJb2yCoXjWWs+cGRN+zAr/AnCp68p00Xzbl0pn
         NHWXpVzhFvRlsV30Ah65ONrIeaBz5byffhyDCxyDstTI0Iwzc092QmFOV6VKXxvE0QBY
         pCuJ1dkIodcXDSaEB1e2UG6j53b1hDYWuFAZcNVx8Zk/VrcCBy/Y2G8M20Krla8zixiS
         //Xg==
X-Gm-Message-State: AOAM532vm5PPszBXmVlfGcnETbEnDpVrbBNzXkUBPgmDjwhNGbu46OzD
        ZBEHf+PuH074010Z/O+1omuMn+zYV33TcqJ0GoTFjuLGhN6Tzg==
X-Google-Smtp-Source: ABdhPJwbqJ2PbXW0TL6FBGkCFHGN+vTkmD0nM48igVc7R3eWp7LYzKexoFogTGRCPKrkFxjWxfUa5x+UHu+7n+4K5Z4=
X-Received: by 2002:a25:1f83:: with SMTP id f125mr3645600ybf.132.1616578826501;
 Wed, 24 Mar 2021 02:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210323064923.2098711-1-dvyukov@google.com>
In-Reply-To: <20210323064923.2098711-1-dvyukov@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Mar 2021 10:40:15 +0100
Message-ID: <CANn89iJOignHVg-QOtEB_RVqca=pMczJv-k=CEtPRH0d4fSdgA@mail.gmail.com>
Subject: Re: [PATCH v2] net: make unregister netdev warning timeout configurable
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Leon Romanovsky <leon@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 7:49 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> netdev_wait_allrefs() issues a warning if refcount does not drop to 0
> after 10 seconds. While 10 second wait generally should not happen
> under normal workload in normal environment, it seems to fire falsely
> very often during fuzzing and/or in qemu emulation (~10x slower).
> At least it's not possible to understand if it's really a false
> positive or not. Automated testing generally bumps all timeouts
> to very high values to avoid flake failures.
> Add net.core.netdev_unregister_timeout_secs sysctl to make
> the timeout configurable for automated testing systems.
> Lowering the timeout may also be useful for e.g. manual bisection.
> The default value matches the current behavior.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=211877
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Changes since v1:
>  - use sysctl instead of a config
> ---

>         },
> +       {
> +               .procname       = "netdev_unregister_timeout_secs",
> +               .data           = &netdev_unregister_timeout_secs,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_dointvec_minmax,
> +               .extra1         = SYSCTL_ZERO,
> +               .extra2         = &int_3600,
> +       },
>         { }
>  };
>

If we allow the sysctl to be 0, then we risk a flood of pr_emerg()
(one per jiffy ?)

If you really want the zero value, you need to change pr_emerg() to
pr_emerg_ratelimited()

Also, please base your patch on net-next, to avoid future merge conflicts
with my prior patch add2d7363107 "net: set initial device refcount to 1".
