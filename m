Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA8342EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 18:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCTR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 13:56:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 10:56:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f16so15999773ljm.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qr5T61t0/jc8E3lWW0Exv0s6IfP06gKKY0jxUzzXYFU=;
        b=B1YmUmWwUaXDPggGJ6vO+ghH6m2Ri+VzWlR67wsIyPChLMY3pfeYm6CmkhLzQCmBVH
         wbn4OjdhGJAhSvzsDb7a6/uL53bKrmKp0tk1wGio11cxJb/4Sh1R2K8npAqo9Jz1+jk2
         ridKCeAwmBRlqMigRH0RRKhcA0SWdEl78eQBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qr5T61t0/jc8E3lWW0Exv0s6IfP06gKKY0jxUzzXYFU=;
        b=fRgb7qo7ZME7gJHXArs90FpjzcQUmxZsqt4m+ql/NQw4nAN6mz2XxqqpZLyNWjPeVR
         WW7EUWo5Di9NarQC1b9uFzx2cayRTBkqDWv8kAkxHAhbmpGAdNXvu4DaNXT/fEOOtOOr
         FP+aUwiKvOG8dsGCfUi2bmcBJ9A2KAxjMKBKoL2jI/9birf1VQbe2FfGv/MEqXUxTTy5
         CeA5xh5ZYXcbjWZ/U+50R5HLnYb86tPuojQXwP7wVhf3fUqbMKgt2RASwtZ97hLMFNRt
         HRsN6gMY/9ZeU/aLq7ElryBf1DjpSTDHYe5Cl8xUMxr4MYnkMMOnNbOiyon634nomPMH
         /IYQ==
X-Gm-Message-State: AOAM532alxgR5HSjHQ7Gcr3bLgCSeyf2cqKP/8joLGGGPfGDx2s6fnFt
        byahptG9RHUKpV3YqFKP9GoZiqR1uEYszA==
X-Google-Smtp-Source: ABdhPJwUjs1zuuxOw6wqpuR+2QsgQr+0g45zUTlXuD2pJyKZ9UWRqqDDsrWrjQbw8vIHN6zW2wtpuA==
X-Received: by 2002:a2e:9b16:: with SMTP id u22mr4610134lji.184.1616263013265;
        Sat, 20 Mar 2021 10:56:53 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l5sm983180lfc.137.2021.03.20.10.56.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 10:56:52 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id g8so7795995lfv.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 10:56:52 -0700 (PDT)
X-Received: by 2002:a05:6512:3d1c:: with SMTP id d28mr3960217lfv.41.1616263012501;
 Sat, 20 Mar 2021 10:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210320153832.1033687-1-axboe@kernel.dk> <20210320153832.1033687-2-axboe@kernel.dk>
 <m1eeg9bxyi.fsf@fess.ebiederm.org>
In-Reply-To: <m1eeg9bxyi.fsf@fess.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Mar 2021 10:56:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLMy+J20ZSBec4iarw2NeSu5sWXm6wdMH59n-e0Qe06g@mail.gmail.com>
Message-ID: <CAHk-=wjLMy+J20ZSBec4iarw2NeSu5sWXm6wdMH59n-e0Qe06g@mail.gmail.com>
Subject: Re: [PATCH 1/2] signal: don't allow sending any signals to
 PF_IO_WORKER threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 9:19 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The creds should be reasonably in-sync with the rest of the threads.

It's not about credentials (despite the -EPERM).

It's about the fact that kernel threads cannot handle signals, and
then get caught in endless loops of "if (sigpending()) return
-EAGAIN".

For a normal user thread, that "return -EAGAIN" (or whatever) will end
up returning an error to user space - and before it does that, it will
go through the "oh, returning to user space, so handle signal" path.
Which will clear sigpending etc.

A thread that never returns to user space fundamentally cannot handle
this. The sigpending() stays on forever, the signal never gets
handled, the thread can't do anything.

So delivering a signal to a kernel thread fundamentally cannot work
(although we do have some threads that explicitly see "oh, if I was
killed, I will exit" - think things like in-kernel nfsd etc).

          Linus
