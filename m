Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FCD31FB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBSOxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBSOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:53:02 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1826C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:52:21 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id c44so1905062uad.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkGdSPTq5AeCuNf8n2PzqaV7C84m+n/ihm8WMfF3VPQ=;
        b=aK4C27J5C8bDRXf/IDvGgxI9YiczGQSQCBBNuQplZZXpnfxTC0oPhGfIbfoUAlwkxU
         B7roDMXktTHhLZw1Zj6avE1hUYFdj2FQSteShrS8WLR27TD22+v7Y2sE2pAF2uzSXWXj
         kfhVjzdzBD/EreWNDmYCJWuJ3E6IVKQWxInOeugI1P/dn1YqUx6Pln2GWPatrKDThPK+
         b4Qab/KkUC4kPt6W8Yi8w8ILq6wX6cpEqU9wtNQOdvCkY6ABZHqzjZXN4irWttLuNQ9R
         4hYpzUMdR1NlwLGP4CdyZrAlxC9DtfXu8eZm+JJtsS+7XLDUYJaLM7ccdYKETvc0XjAM
         i2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkGdSPTq5AeCuNf8n2PzqaV7C84m+n/ihm8WMfF3VPQ=;
        b=n7DeYr7Ni6pCBHQ3aoc9x97bSjD/oHUab+3UT/C3KtjGHjZ0cmkSVVxzoBRdPta9ob
         4doODl6Csy/JDNMwW6VugATSQ71E2E8NYJO7MglTtEid2qr4WK+yW7+6e6vUX7kFNJqI
         kWXoXFtJ/HUiHtlB69DVzVosawRmWwCVDqsm8ffuKDD4pXYJbjsaytlbGpVCk6aPg4Yp
         ZfmvztyxIc7NdsqTdeF9wTflNk6Qwi0RYzkY9S3Xa0bFu3KiU2eGmvBb0NBFgbDbsfUH
         fZOCRFvegVjJTv357u4/xTqRdFewOCzUpyeVhUcqeFZbN8BugsRZQH6a107bsqE6rqTa
         r3rw==
X-Gm-Message-State: AOAM530nOfvYaxU0IeSDANmG6e5ntqmH6EoFKsbULoIYTqCHNtPmXFYI
        dVh0i8CVpZyTwkOh8Sz8dU0McHYMy7d3B9AY+DjNCQ==
X-Google-Smtp-Source: ABdhPJya37spnD+A3eGgX6QxzKyNmD2K0/jPU84Rh07UrGrvm53fQm1K7ltqEMVRNrFZpknUCo+XTC/KG/nVhfC+H8E=
X-Received: by 2002:ab0:2619:: with SMTP id c25mr7380583uao.46.1613746340724;
 Fri, 19 Feb 2021 06:52:20 -0800 (PST)
MIME-Version: 1.0
References: <20210219014852.GA16580@xsang-OptiPlex-9020>
In-Reply-To: <20210219014852.GA16580@xsang-OptiPlex-9020>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 19 Feb 2021 09:52:04 -0500
Message-ID: <CADVnQym38g5fjMU-S7fqoRS6sxDjK4y7-9c3XZeGVXjLTN5Xog@mail.gmail.com>
Subject: Re: [tcp] 9d9b1ee0b2: packetdrill.packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe_ipv4-mapped-v6.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Enke Chen <enchen@paloaltonetworks.com>,
        Jakub Kicinski <kuba@kernel.org>,
        William McCall <william.mccall@gmail.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 8:33 PM kernel test robot <oliver.sang@intel.com> wrote:
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 9d9b1ee0b2d1c9e02b2338c4a4b0a062d2d3edac ("tcp: fix TCP_USER_TIMEOUT with zero window")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I have pushed to the packetdrill repo a commit that should fix this test:

094da3bc77e5 (HEAD, packetdrill/master) net-test: update TCP tests for
USER_TIMEOUT ZWP fix
https://github.com/google/packetdrill/commit/094da3bc77e518d820ebc0ef8b94a5b4cf707a39

Can someone please pull that commit into the repo used by the test
bot, if needed? (Or does it automatically use the latest packetdrill
master branch?)

thanks,
neal
