Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB53C1B2B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhGHVq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhGHVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 17:46:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F383C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 14:44:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so9345937lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNUdXmAdyTLugzbXax99lK0jKXoIs2WTSE5WoZskvj0=;
        b=gbipal36mpQN7Afd0MiNy7ScPAzJbvar3bRjj/hZUcY5WhNk1EXDqng/H6wGZVJcW8
         yZ5nU1zw1U1j2XelewznZsv6R6ukoU2jfO4kRGVp2Dda3GDHEFTsbS7A7BAxIuJRTgTC
         k/bIveMZzbvdSdNgfrU8F4UlijzvkE1tTP+d63RGShTDmzDWhaj6vBrlxPyd84mR2AGw
         n2xWD8XfQ1QqRBb+/D1o27iXvJcObT5EKdHUJlBr38Nar30nX6s4hq/M+vgTFqhUcBCF
         pINtMibejBlp+pzAEh7V+hVPBl0mVAytJ4jPIAQvv6wQQl6XzSkK4ycJWwpPYNmgVKIt
         vDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNUdXmAdyTLugzbXax99lK0jKXoIs2WTSE5WoZskvj0=;
        b=Er3IIPyGcXJdu7Nx4PQc0O5ZxuGsVFd8YX7gH0uwC4kJ/EZ94bx+wvmapPjyPbTj7h
         3K0RJ5mHrInYVp+nMSq69XoNrOsj8Vs8WC7g0L72bivBfJqGTPy2z0oKdgzpOfmKMdo2
         NqnAK4fvgRjhMKQYBFiuilCM/Zj82D6yKfrtstgjugpxzuuCsehQ9KZ3smlul03lJLNa
         G896L+pJcxWAkOAiqWpghEAnjzSu4tzapzQR+9+X0/S1qXYjnNZ8Ayr885YyTA/xRq8l
         o8PL8ohxJAej2OFRD9vJJfLU5sP9F7dfMuzyEgOAVhQor/cbS+IqoW9qVak+ASuUwNek
         YPVA==
X-Gm-Message-State: AOAM533dkQqx8C5e3jex9uYZcnLmFYOqlSblGgX1ZE+FXc2xkRtt83J5
        8D/xK+WUcyLYEHYjdxFqRoJrzo7izMR3SXnE+tKL+HqqLR0=
X-Google-Smtp-Source: ABdhPJz3WVDNPE2LfCzF+PEm4pDEl4OsjSePR4Mcd3LkAUO+MuEH/Fu5Nap7ddow2Wj2S3QASzxD/bK9rc1SmAPl6xQ=
X-Received: by 2002:ac2:4d4a:: with SMTP id 10mr15224978lfp.125.1625780651756;
 Thu, 08 Jul 2021 14:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <YMJTyVVdylyHtkeW@hirez.programming.kicks-ass.net> <96842d90-7d3b-efac-fe1f-6e90b6a83ee5@uwaterloo.ca>
In-Reply-To: <96842d90-7d3b-efac-fe1f-6e90b6a83ee5@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 8 Jul 2021 14:44:00 -0700
Message-ID: <CAPNVh5d12sEqwKj-=aXWOQjxBXLcmwgQ9KiRNSTtGhL9PVT9vw@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        pjt@google.com, posk@posk.io, Peter Buhr <pabuhr@uwaterloo.ca>,
        Martin Karsten <mkarsten@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 10:45 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
> Hi,
> I wanted to way-in on this. I am one of the main developer's on the Cforall
> programming language (https://cforall.uwaterloo.ca), which implements
> its own
> M:N user-threading runtime. I want to state that this RFC is an interesting
> feature, which we would be able to take advantage of immediately, assuming
> performance and flexibility closely match state-of-the-art implementations.

Hi Thierry,

Thank you for your message! I just posted a new version/approach:

https://lore.kernel.org/lkml/20210708194638.128950-1-posk@google.com/

Let's move the discussion to the new thread.

Thanks,
Peter

[...]
