Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39F401E18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbhIFQOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhIFQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:14:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878DC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:13:23 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v2so9365383oie.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSHWLdRniClMLbNX/vMWN1xbfEPKJ8OMc5qP3DmQu0A=;
        b=IxYvyvZzricv+JQAlndessS8MQviEWJRmtsZpVl63E1YrMf+RcCzdvsT1+QVskKZOH
         Vem7F8yfI9FU2jGcEK12Mz+yuCui2fTbo041O1chTetSesNYOyRBLhh+dTtMd0Ebchtw
         Iz+5pS+byB+JbwjwD3AzC38hfkKvCMIQSaTYt5ZugaJ3DSOtz6yn6XdkqXHVqmif9ugW
         a2192wEDiY7rpzyfQ2ppI/kmeAfjbGDLQYCQOECAUmaCvkxAvUPrgoV5Nvo9Pt59cxU8
         wQ07aucV39UJeop9dTDvnIMJrh8aF4TVwlBtSg84eijSKM1I05+kiQYDu95uFLc9pvSI
         j7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSHWLdRniClMLbNX/vMWN1xbfEPKJ8OMc5qP3DmQu0A=;
        b=a9HPy99tqWwPQ9VyK6f7ybSCqx9WvTtt0GN21GhMcONoDzMmS5pDhSN4YE+uM1/82A
         NzSJ6PQQQM4XgxRrrEFEELDtbtvhca2zeF2m0r+rGYgd3UkrNHiNSvhLPu8Ldlh1b+xL
         0GaDY6jl7X7OupHiRQcmfXYueRp65FPHC/0S/fbqEfrGgqrjD11ytTaAP6+/Y4OObfuv
         i/fo0Op2ZeWmMpoBqzECYfPXiX9sHq4J+abaP9JGPFn/9AgVycQboteWAo18BXTSQ21I
         RxXyAhBngoh/AcgTMyR96okJr+c869rFqPvObKBVGRpQxXAAXXSihU+TFqF8A9pBYHby
         6V+Q==
X-Gm-Message-State: AOAM531SKQDkUpQd0JsMC9jW8TynublyHlsm44bKL3uknM2E9cXHkrxh
        aoTfbUCoBv+pokSVqdmMh+wND0pWJ0cHCwmglpwQSXV1nI4zZw==
X-Google-Smtp-Source: ABdhPJxXUQ06WnN7/hZlpgf62x4QOfkuUmsoCH68vCcbFUDAmI2ww+Umqn2DGBmre5S8Zx9RiSazha2SK4hXrjudW80=
X-Received: by 2002:aca:4344:: with SMTP id q65mr9355069oia.70.1630944802829;
 Mon, 06 Sep 2021 09:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172627.267989-1-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-1-bigeasy@linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Mon, 6 Sep 2021 18:13:11 +0200
Message-ID: <CANpmjNPZMVkr5BpywHTY_m+ndLTeWrMLTog=yGG=VLg_miqUvQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] kcov: PREEMPT_RT fixup + misc
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 19:26, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> The last patch in series is follow-up to address the PREEMPT_RT issue
> within in kcov reported by Clark [0].
> Patches 1-3 are smaller things that I noticed while staring at it.
> Patch 4 is small change which makes replacement in #5 simpler / more
> obvious.
> I tested this with the three examples in the documentation folder and I
> didn't notice higher latency with kcov enabled. Debug or not, I don't
> see a reason to make the lock a raw_spin_lock_t annd it would complicate
> memory allocation as mentioned in #5.

Thanks for sorting this out. Given syzkaller is exercising all of
KCOV's feature, I let syzkaller run for a few hours with PROVE_LOCKING
(and PROVE_RAW_LOCK_NESTING) on, and looks fine:

    Acked-by: Marco Elver <elver@google.com>
    Tested-by: Marco Elver <elver@google.com>

> One thing I noticed and have no idea if this is right or not:
> The code seems to mix long and uint64_t for the reported instruction
> pointer / position in the buffer. For instance
> __sanitizer_cov_trace_pc() refers to a 64bit pointer (in the comment)
> while the area pointer itself is (long *). The problematic part is that
> a 32bit application on a 64bit pointer will expect a four byte pointer
> while kernel uses an eight byte pointer.

I think the code is consistent in using 'unsigned long' for writing
regular pos/IP (except write_comp_data(), which has a comment about
it). The mentions of 64-bit in comments might be inaccurate though.
But I think it's working as expected:

- on 64-bit kernels, pos/IP can be up to 64-bit;
- on 32-bit kernels, pos/IP can only be up to 32-bit.

User space necessarily has to know about the bit-ness of its kernel,
because the coverage information is entirely dependent on the kernel
image. I think the examples in documentation weren't exhaustive in
this regard. At least that's my take -- Dmitry or Andrey would know
for sure (Dmitry is currently on vacation, but hopefully can clarify
next week).

Thanks,
-- Marco
