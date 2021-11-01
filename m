Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7871B4422A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhKAVan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhKAVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:30:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1343C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:28:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu18so21703148lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xLKY9lCpyvZNoEu8M6BvcHltpeK4GJwIA7SWvQrASo=;
        b=bTyTa8GFDGm1GIV5rVwG17STM9BQxiyLgEGPh2zBtRYFA2DT421rhVti2QubhynzLC
         Rdefd+PjyNbs1wI61kZFef0SHjs5a9GhyzSFr8023Vu1qamqRAZnlcxs5ramJX0AbuD8
         xPUu3wtaUv7GzJYFEyJ+WAMo2zNS0eZq4vSDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xLKY9lCpyvZNoEu8M6BvcHltpeK4GJwIA7SWvQrASo=;
        b=vYyVhmKg8ivXWtoN0G2ZtoyMxZENk4oIwKgViGfN3YAxGZEXGGNew+m+kUd+6KUJNZ
         L4kp60KR3j4qSLOlLEdFEF3GPUKD3EG64Jk3vO5sn/CM05dqFY243+XKXu2f8o060I2B
         vBUOcrdic0MIJ74KJz5RVUCeF3Z6fGjTCFRmS8IOV5EGEdrrkL8wTBPutLPEUOvEIT3k
         1BGQ4MgG09ULOUZls4m8oe27Z4b+Q/3AlSxgeES1tC+KlHAOcKcfYVpzkyCD2aT/s7Sh
         K4zTWdnm03SW3E7mE8kDsSkRDPeT2wSx2cOn49bvjrUlQo3L9eMBSPMTeic/5rj3fL2q
         zrhQ==
X-Gm-Message-State: AOAM5307E5zlnUvMYFSxMCXN3dO2qvXtfI9sxZn55/ozQmLvZVZp9Dmd
        A8Y26gda6EhmIl9NtI3OVAdz0yezCgiqiwMR
X-Google-Smtp-Source: ABdhPJwMEHeHw++bLnuRrwokJiepnHVAGeF/YAHzqNzxNowtaNbou3mX8jFIwBMI+kOBInuEDSQRlA==
X-Received: by 2002:a05:6512:3989:: with SMTP id j9mr29121171lfu.126.1635802086952;
        Mon, 01 Nov 2021 14:28:06 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id n13sm97292lfq.225.2021.11.01.14.28.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:28:05 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id k24so12115598ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:28:05 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr5712129ljp.68.1635802085111;
 Mon, 01 Nov 2021 14:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864855.3357115.17938524897008353101.tglx@xen13> <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
In-Reply-To: <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 14:27:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwxyA11LQ+0y73nJAS4ZB=s8CeYM6OGCEzKiy+8fyLiw@mail.gmail.com>
Message-ID: <CAHk-=whwxyA11LQ+0y73nJAS4ZB=s8CeYM6OGCEzKiy+8fyLiw@mail.gmail.com>
Subject: Re: [GIT pull] sched/core for v5.16-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 2:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Unwinders that need locks because they can do bad things if they are
> working on unstable data are EVIL and WRONG.

Note that this is fundamental: if you can fool an unwider to do
something bad just because the data isn't stable, then the unwinder is
truly horrendously buggy, and not usable.

It could be a user process doing bad things to the user stack frame
from another thread when profiling is enabled.

It could be debug code unwinding without locks for random reasons.

So I really don't like "take a lock for unwinding". It's a pretty bad
bug if the lock required.

I have to say, that commit message is pretty bad too. It doesn't
actually explain why this is needed. It just talks about the alleged
reasons why it should be stable, with no explanation of why that would
be an issue, and worth taking a core lock over.

The "Link" in the commit also is entirely useless, pointing back to
the emailed submission of the patch, rather than any useful discussion
about why the patch happened.

          Linus
