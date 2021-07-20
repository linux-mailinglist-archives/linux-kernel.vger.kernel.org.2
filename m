Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568573CF566
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhGTG4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhGTG4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:56:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218DCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:37:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m83so18879199pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwbSHIBLxgN9zlEsecgswveri3V8MEcEgSNn8jds2Tc=;
        b=f+ZpcNdyeBneAeWjVRGw6Bdsa73D3S6JwUB+9vz0k13cRWodFdl3JotZDuHy678rf+
         GMscKndaIV5JWODN6mftvEkPdQeWkfSsZr3ZSquwkHTmgAwewAu799ggUNfgxt5qoHJY
         8mS5dt+lmntFbvJkAyMP1he8RRLsZ542Iwn6D9EBZis+1NvRRst50/I/AI7a5QZ7Mxhx
         0Yc+VWcrHNSvrH3ie5AzU2E9obEtD/twmsv01SBpfZqKFvQm/5G1/yKDXNjcKnXtxHRq
         v1dmgMI4jrupltLtRLMfUJI1g+HRM/Ciwdx1RaUA23JxUIJn1lAY7U8dfm7IY8VGqTzG
         VgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwbSHIBLxgN9zlEsecgswveri3V8MEcEgSNn8jds2Tc=;
        b=P3T1xOqbc5vV3UFxm1NrDVRxM2+l0B/arxA+ULxB1Y34czl9jFe9dBpvxG2ehsaszh
         ZfKLb/meDrqOuml/B0A/KMOJealpQRBj3ExgaPVdSP2qGY3uYgYqP+tMSVdju0Vncfgs
         /rAYTRem3VqfUgN0QB/kTd5e4x73NoyVELQ5MA5pWKKRpDDye8CxusleWAg2H0gVUcHv
         jgYL530lpFrGAFFa64ETo+yHzlOflkbh7jfZ09DYWxVruyUr8UAeqPCtcaYkHhONMOkD
         A37U2uLRhytBngbXwFQdmhkOI9gff3iuHlTYx7UCYdPECXn/2gQkvkHiMvilF1jM5gAs
         RLvw==
X-Gm-Message-State: AOAM531PO3VWx9pntDx6F5i77Lf89IFcA/kPKKi+8Gzd44vnWvEmvyWv
        0+LtkEWw5s0N51zYa0agCbWqqczI5i+Nsfu49FI=
X-Google-Smtp-Source: ABdhPJzFWcLQF3eTm9OTmlEo/y25MSkBplyhQU9Inkqwk7d7oypSRqJ5LXTAaZ9I9btB9hnt3sMki1wPA+fBfVqJPQs=
X-Received: by 2002:a63:114d:: with SMTP id 13mr29931210pgr.180.1626766627504;
 Tue, 20 Jul 2021 00:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210121221207.GB2174@grain>
In-Reply-To: <20210121221207.GB2174@grain>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 20 Jul 2021 00:33:11 -0700
Message-ID: <CANaxB-zuh-TvODuQ9pdycqGUyXfO4rXXtyFmXFh905+es6AOXQ@mail.gmail.com>
Subject: Re: [PATCH] prctl: allow to setup brk for et_dyn executables
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 2:12 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> Keno Fischer reported that when a binray loaded via
> ld-linux-x the prctl(PR_SET_MM_MAP) doesn't allow to
> setup brk value because it lays before mm:end_data.
>
> For example a test program shows
>
>  | # ~/t
>  |
>  | start_code      401000
>  | end_code        401a15
>  | start_stack     7ffce4577dd0
>  | start_data      403e10
>  | end_data        40408c
>  | start_brk       b5b000
>  | sbrk(0)         b5b000
>
> and when executed via ld-linux
>
>  | # /lib64/ld-linux-x86-64.so.2 ~/t
>  |
>  | start_code      7fc25b0a4000
>  | end_code        7fc25b0c4524
>  | start_stack     7fffcc6b2400
>  | start_data      7fc25b0ce4c0
>  | end_data        7fc25b0cff98
>  | start_brk       55555710c000
>  | sbrk(0)         55555710c000
>
> This of course prevent criu from restoring such programs.
> Looking into how kernel operates with brk/start_brk inside
> brk() syscall I don't see any problem if we allow to setup
> brk/start_brk without checking for end_data. Even if someone
> pass some weird address here on a purpose then the worst
> possible result will be an unexpected unmapping of existing
> vma (own vma, since prctl works with the callers memory) but
> test for RLIMIT_DATA is still valid and a user won't be able
> to gain more memory in case of expanding VMAs via new values
> shipped with prctl call.
>
> Reported-by: Keno Fischer <keno@juliacomputing.com>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Dmitry Safonov <0x7f454c46@gmail.com>
> CC: Andrey Vagin <avagin@gmail.com>

Acked-by: Andrey Vagin <avagin@gmail.com>
Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
direct loader exec")

> CC: Kirill Tkhai <ktkhai@virtuozzo.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> ---
> Guys, take a look please once time permit. Hopefully I didn't
> miss something 'cause made this patch via code reading only.
>
> Andrey, do we still have a criu container which tests new kernels,
> right? Would be great to run criu tests with this patch applied
> to make sure everything is intact.

Sorry for the delay. I run tests and everything works as expected.

Thanks,
Andrei
