Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1FF4132AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhIULhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhIULhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:37:23 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF57C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 04:35:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x124so5635518oix.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/NtL1eqdessLJJ7QAgmdSlgwRQ9C8fMojdqN92nFPU=;
        b=RcIeDxNz16hCkRCahO6aJoeYtQN4Ebe55P/m5406fDQxt64VMzUraHbWyBqK/6ufh4
         BNdPjU8lfKcmJV8oAdZqN4DyfcEBHJcdKHltk3Puk7isGHcBiWWKrbjuAzKfzxEMkf6z
         WK+CiSzWw0lkE7oMDxdZqr/xcGDbh66EE5ONRlrQCS6gqjLdEzgfeo6wBxMbyB31Z6yE
         wk6vUIoajrv7uHtvEzlRlCYoSCMbfzEC0cWLVF1ntmleky3Dz8fNFFSpHiHyeX02womR
         IzpCdjeT+ZlvQ9V0+WnPv6vHkSSd0gn8w3PlY3UTIqiviaOOly4K8xBNJYN5xhpND6Kh
         MFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/NtL1eqdessLJJ7QAgmdSlgwRQ9C8fMojdqN92nFPU=;
        b=BcDupYbiiDnvcke9razJwUx2IFbdx4nOcz/hBinzPJISoAyg185O2tmGZ96OBAinxo
         YXRUO3mAbtEKkOfcYhZcSX5o4OlL1F70nDieow/LgYJ6sb+zEVOkZQvcswGqvZk7/Dam
         fg7tcPVZuPASnLEGEpEIfiKzVcVSMDcqEG56HGNWlIuh6tIrDudDZiPbOWbxdLrBwga5
         jSKXgZ72gdZQeW84M2+6ZbmNDfjd+BkY0N5lluz4Fk5tPlClHGADX4X6Y4C/oJSN/G1V
         +wwQrTJi9a1S+ba8gCZ/mIZp4cb+Xz8BCNNgYbvdp7vdXSC1WVW/PPRuqGn66XQuGMgv
         7eNw==
X-Gm-Message-State: AOAM533yR2Avyecz/KLmy655dzzCHjZhBTc2CRbdYfPbALqYqGq1Ib9c
        +h4porABp9rVKh71yceT+rgxvkhrzgHDit+hE0RCyg==
X-Google-Smtp-Source: ABdhPJzC6ci1Dmx4ZzdOTG1OUQaNGftnP651SqaVwyJyYzS8AAG/+opo9hgOGWhtcljKstsEHUdVRsqjXvqiknzrXVw=
X-Received: by 2002:aca:4344:: with SMTP id q65mr3351129oia.70.1632224154781;
 Tue, 21 Sep 2021 04:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com> <20210921101014.1938382-4-elver@google.com>
 <CACT4Y+Z6Rss3+oiN5bcKHYeQgG=nZ9VDqwrhOS4VUZ=_a5NoBw@mail.gmail.com>
In-Reply-To: <CACT4Y+Z6Rss3+oiN5bcKHYeQgG=nZ9VDqwrhOS4VUZ=_a5NoBw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Sep 2021 13:35:42 +0200
Message-ID: <CANpmjNPuW47hwmLm=RXr6sXSzvAmz0_vo3m9UGgUbT_CQ=oSgg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kfence: limit currently covered allocations when
 pool nearly full
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 13:05, Dmitry Vyukov <dvyukov@google.com> wrote:
[...]
> > +/*
> > + * Adds (or subtracts) count @val for allocation stack trace hash
> > + * @alloc_stack_hash from Counting Bloom filter.
> > + */
> > +static void alloc_covered_add(u32 alloc_stack_hash, int val)
> > +{
> > +       int i;
> > +
> > +       if (!alloc_stack_hash)
> > +               return;
>
> Nice!
> I like the hash seed, non-evicting cache and that threshold become a
> command line parameter.
>
> This check is the only place I don't understand. What's special about
> alloc_stack_hash == 0? I see that even double-free's won't call this
> with 0.

Indeed, it's no longer required (I think it was in a previous version
I played with). At this point, it should only be true if jhash()
returns 0 for something, and in that case might not even want the
check.

I can also remove the unnecessary "meta->alloc_stack_hash = 0;" in
kfence_guarded_free().

Unless I hear otherwise, I'll remove the unneeded code (and send a v3
of this series in a few days).
