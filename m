Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2055D4007E0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 00:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhICWWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 18:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhICWWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 18:22:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AADC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 15:21:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h1so977070ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2hoWJQN2mzjm7RN9/wyMT5DuqBSo/d9GUmVSbz0TJw=;
        b=Gc085IJlGgq95QEC60AuUrcwKvYlFA0D3Q9sv2Trn1ebudU66LqjDOYUXWMF6gr1sm
         f8xRaQvwmRs7om4gUhY2vJg1RGYwkIaxmuvcRvolFIg3jtushEc4EYI/RB6CZHJNZNqM
         jcqt/EJjawnGjgXzGIlHfPVqPxpR0J4DIIWLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2hoWJQN2mzjm7RN9/wyMT5DuqBSo/d9GUmVSbz0TJw=;
        b=lohTXqvqcWp2zrId9i2mHJ9sHUlTqSJ6Oi+bmc3lPOeqpCde11FbYqHkEYSNjF+vMb
         wLvUHHtJPQ1KUNeAQHabwp8Se8VQ5qedGqkFBJKCfBi51Xjaseup0mj7xtqmdFA/5JT3
         ATbkXHVJBTLS9pwn3dMRgpT1rt7TeRPTmI+rLkwE4Rh82bTkaSBKGkgZOmdwzozQ3Hzy
         MoWo0FTFG9iqoxeecfOD1rsKS8M6+mSPkSRU5NsgxBUPTENB/XMipLb+3PRfcRz0WJ6C
         FlJyk9ZvHeEBADRDsuUyPMhlajzWZRz6dYEbWm2Gj+uGZbyUpufvjfdzl95fyheTPucw
         0D9w==
X-Gm-Message-State: AOAM530uCKfeMDFzFkGaerPRJjfScLaBvLS5xuTZDe5im0WlBadWfc4K
        hKnEPfMncKFvmNDRPsdHRjYNdcY90E6/nzAYEbs=
X-Google-Smtp-Source: ABdhPJy9QeX1Gr5Rdt6h2IvwCI94MjehNUGzTxcLzaMt+AXvaz+PCMHoC8HicAZZr5XfWMJU7Unmxg==
X-Received: by 2002:a2e:9852:: with SMTP id e18mr800702ljj.173.1630707674872;
        Fri, 03 Sep 2021 15:21:14 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id d21sm45768ljo.70.2021.09.03.15.21.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 15:21:14 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id m4so978924ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 15:21:14 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr785657ljg.31.1630707673799;
 Fri, 03 Sep 2021 15:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <acdf065c-256d-47b0-5c20-203ff4b213d6@gmail.com>
In-Reply-To: <acdf065c-256d-47b0-5c20-203ff4b213d6@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 15:20:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiENdk_AXGRrmbbOYqq9zYptdv=vYszgG2ZzztDUTJwRA@mail.gmail.com>
Message-ID: <CAHk-=wiENdk_AXGRrmbbOYqq9zYptdv=vYszgG2ZzztDUTJwRA@mail.gmail.com>
Subject: Re: dozens of sysbot reports
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 1:44 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> I have a pile of (still under triage) sysbot reports coming after one of your patch
>
> Typical stack trace:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 24889 at mm/util.c:597 kvmalloc_node+0x111/0x120 mm/util.c:597
> Call Trace:
>  hash_ipport_create+0x3dd/0x1220 net/netfilter/ipset/ip_set_hash_gen.h:1524
>  ip_set_create+0x782/0x15a0 net/netfilter/ipset/ip_set_core.c:1100
>  nfnetlink_rcv_msg+0xbc9/0x13f0 net/netfilter/nfnetlink.c:296

So the real question is mainly just whether those huge allocations
actually make sense or not.

If they truly are sensible, we can remove the warning. But it would be
good to perhaps look at them more.

Because no:

> Do we want to fix all problematic callers, with ad-hoc patches like

Not insane patches like this, no.

>  ip_set_alloc(size_t size)
>  {
> +       if (size > INT_MAX)
> +               return NULL;
>         return kvzalloc(size, GFP_KERNEL_ACCOUNT);
>  }

But does that kind of size really make sense? I'm looking at the
particular caller, is it *really* senseible to have a 4GB+ hash table
size?

IOW, I don't think we want that warning to cause the above kinds of
ad-hoc patches.

But I _do_ want that warning to make people go "is that allocation
truly sensible"?

IOW, it sounds like you can send some netlink message that causes
insane hash size allocations. Shouldn't _that_ be fixed?

                   Linus
