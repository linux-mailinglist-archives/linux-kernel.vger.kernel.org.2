Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B943BE80C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhGGMhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhGGMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:36:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50A3C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 05:32:13 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g19so2837430ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0o/tc3UWp4uEa8O3pP1dD613UEK3mpfOAPKmpdjDsI8=;
        b=ACgWk2NrZg9VaCj/FjYB5IGKNNpBZ/D8CrXxoAuoXJE79u/wdmv/S6N0AcTSbUkuw8
         y+YZIzfW5lkZSWcQxk9Kq6nK5DnNcw0Za6syZOwIZ5RC6LIYWw/1k4xDvxuHuh56KB2z
         XarNb6nSoAOEDRaUIcYF8qJ3hL9n7INu5oh0/9IdbVStq5sBnWJgDX8nKJKxF26SVill
         Lji61Kn31sJgKiHxOjtAE9XGXXRonBnZJqMFv2t3frcIY77f+31WlvetD7c/O33Q/umb
         1A0KfUCBa9RY4i5ZML+9fMKfYdH8764vwUsbQPBnLstZOPjvpI0FSdY5k9biTlYKG5ea
         z0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0o/tc3UWp4uEa8O3pP1dD613UEK3mpfOAPKmpdjDsI8=;
        b=Yzu1j68Oz5Ms7tV7c3p9bFL0hZp/7hiMHpizvED4vns2Gd6nS7nAipdYRpRFzueeQi
         oT6aHQ8Mf/gUPirRjuH6bXLwLb7gGmY8VpDI0AUqe8dSnJfkx4QMPFcyFzoRdBWmiuOT
         tOEeYKml2CxutLT71rhLPOqQSTlxeJUolAI8+KyK/uOsBbgFc1OEQfI86HqIiu8OIvds
         11CMqtFjHWmczWDEEJCYZRCXIWgNd/aDKKolL0kCz5xrK2mr+tQRX7rsOQwGB2ueHN2d
         +1B+kp+oe78rVVnGzrau3E7KDw07u9SqfzNdIkNFlNTdHD7Cixlelf7OvJ2ERXGow9TN
         iSqA==
X-Gm-Message-State: AOAM531CPlWoHbtiYsXp3adK+4sqdCNAYCume40KjokzrzsKP+RepItb
        tQ6QBhygRBbKB1BNEQOOVO9eO4LUR5UdJrg+krlwgw==
X-Google-Smtp-Source: ABdhPJzdEt6naCpXmZ9IIJLYfixymIUHK/O+dc1wvW77AMMmlKGT0B4i8MkYGlsFRfJ19rkT10kapVerherDg84HPog=
X-Received: by 2002:a05:6902:4e2:: with SMTP id w2mr33237227ybs.132.1625661132215;
 Wed, 07 Jul 2021 05:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210707092731.2499-1-slyfox@gentoo.org>
In-Reply-To: <20210707092731.2499-1-slyfox@gentoo.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 7 Jul 2021 14:32:01 +0200
Message-ID: <CANn89iL=uQto2PSNj9Xjt5NFrqKQgVzvYY1T++-Kw_OTfsPwgA@mail.gmail.com>
Subject: Re: [PATCH] net: core: fix SO_TIMESTAMP_* option setting
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     netdev <netdev@vger.kernel.org>, Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 11:27 AM Sergei Trofimovich <slyfox@gentoo.org> wrote:
>
> I noticed the problem as a systemd-timesyncd (and ntpsec) sync failures:
>
>     systemd-timesyncd[586]: Timed out waiting for reply from ...
>     systemd-timesyncd[586]: Invalid packet timestamp.
>
> Bisected it down to commit 371087aa476
> ("sock: expose so_timestamp options for mptcp").
>
> The commit should be a no-op but it accidentally reordered option type
> and option value:
>
>     +void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
>     ...
>     -     __sock_set_timestamps(sk, valbool, true, true);
>     +     sock_set_timestamp(sk, valbool, optname);
>
> Tested the fix on systemd-timesyncd. The sync failures went away.
>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Florian Westphal <fw@strlen.de>
> CC: Mat Martineau <mathew.j.martineau@linux.intel.com>
> CC: David S. Miller <davem@davemloft.net>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---

I think this has been fixed five days ago in

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=81b4a0cc7565b08cadd0d02bae3434f127d1d72a
