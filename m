Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5597531CAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBPMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhBPMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:43:12 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:42:31 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id y128so10284211ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9HMUptyNWsJ5O8nTn609Xb6kh7fmzyYm2B08HuDzsA=;
        b=JUST5tkdd6dR1viqz3oYv3TXgE8VqtTlLpsRoZLuHfbTrDNybhq91kPhbyVzBwCRl9
         Z5oV4A4zDTl7NzyUfCK+8mDqdqaqRxDYuAG0pPiG4kH9j5WDa8dwyiJhFipv3VUKbPzw
         dktYkiugmnrY/hGpqGj48nqmLW6BLObkjGloJTL1Mo3mP5c+u/xGMAVgBvLYEY4pNpe3
         q41LcsIV/VFCVttuHBMEbSuzfhzeZzvosmY0EfV4LGNoJ79H6LoxHh6PBi0j0nIzsDDZ
         ue3+tRE/KtfiU95vm7My4OQ3sitCb4dSq4veeg/Luu86Tdt/7nXP43xWgJv0gRvk3uKZ
         wtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9HMUptyNWsJ5O8nTn609Xb6kh7fmzyYm2B08HuDzsA=;
        b=NIg0IEnug4xflppywivupCPdj+OuheC4yKx2Vgc7WYR1vbNY0rCXyFoTihd5p/S7hF
         T6G6PvxRQzKbS0ZHXUNiSSWQ3ZSGo6DKpNoClYP8YHZnjdeIDMl345H+f71qWeY3pkdB
         wg9CrprG+TKpSW91m2Ns/PtH7Iq8v4sDZGjW4pjAYwKd365ix0UXSWKnJxj1CfSR1jVN
         TOQ+PE5QqLUWWzf2CGmBAdtgKQKapoc7GqIYK1DiMgt92YqFPxYKCZKDkfB8Es7M2sQY
         GWfnXz6G5pZmF07PnfEncmXyFHdj9DSZxzksY2yV20PrpXAmeOGsiMU8Y6K8oNUsfFT9
         Qh7w==
X-Gm-Message-State: AOAM531MfQwpl6PONMxVLzzC9k8AByAa2OCxvulUKeaS5EcSmDbSgEoe
        4kRhkigNbkCOWXLgFuJyQWVAGfrynbBZAykQips=
X-Google-Smtp-Source: ABdhPJx5cDEN1OfVowzqd92kxmyO971svK2X2rtdTrA14WmKkbP/pB3/bXB8Z0g/9oxThFBiM2ZYxzbU/yCESbVBeH0=
X-Received: by 2002:a25:31c2:: with SMTP id x185mr28643027ybx.93.1613479350765;
 Tue, 16 Feb 2021 04:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
 <20210208190735.ibq44r5pc4cwzt7j@linutronix.de> <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de> <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de> <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
 <20210213165040.vzzieegx4aliyosd@linutronix.de> <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
 <20210216102856.dnaycukt3oqxoszp@linutronix.de>
In-Reply-To: <20210216102856.dnaycukt3oqxoszp@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 16 Feb 2021 13:42:19 +0100
Message-ID: <CANiq72mge40Uvqf3mb4uof2gi8ktvhjoodfyJY7uLW4guTnvDw@mail.gmail.com>
Subject: Re: [PATCH v3] auxdisplay: Remove in_interrupt() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 11:28 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Could we please avoid documenting the obvious? It is more or less common
> knowledge that the write callback (like any other) is preemptible user
> context (in which write occurs). The same is true for register/probe
> functions. The non-preemptible / atomic is mostly the exception because
> of the callback. Like from a timer or an interrupt.

It is not so much about documenting the obvious, but about stating
that 1) the precondition was properly taken into account and that 2)
nothing non-obvious is undocumented. When code is changed later on, it
is much more likely assumptions are broken if not documented.

In fact, from a quick git blame, that seems to be what happened here:
originally the function could be called from a public function
intended to be used from inside the kernel; so I assume it was the
intention to allow calls from softirq contexts. Then it was refactored
and the check never removed. In this case, the extra check is not a
big deal, but going in the opposite direction can happen too, and then
we will have a bug.

In general, when a patch for a fix is needed, it's usually a good idea
to add a comment right in the code. Even if only to avoid someone else
having to backtrack the calls to see it is only called form fs_ops
etc.

Cheers,
Miguel
