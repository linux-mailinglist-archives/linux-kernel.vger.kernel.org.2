Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDD3EA516
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhHLNDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbhHLNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:02:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E75C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:02:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d11so11405747eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7pHKxayGFMZlOwIq/bHkeKVOMFNUJ88V3SLok4nSRM=;
        b=AyScEMSOxALQVA7V7H0KBjnoYK1AjzL1m1zPaNebYAx4mp4BLFUEGi5Njdc30IszK3
         4CZ8q2CP66DEHbi3lNMPHseEX5gETKpNv/vpphK8qK4GyIz07y14K/lc1XyQv9jg+3Pi
         xK4cS82KOtsHAdQ0A4B67bBFW8tAM10e7fVDRIT1Kd8b6X1XuQNTDWg4+u6H9/9sfreC
         MF3VCCarR9k7QmUk/jjXymaQuiR1mn9nN2W6kMBM9Kjyly+qB6UBkNMU7Al1WxGhLD6w
         XPcwPmQOSZgEpLiy4DNcHxluKtXo1cAtFkWz7TQBfacaQ93Q/llEihP7PxraRhFZjeY1
         t1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7pHKxayGFMZlOwIq/bHkeKVOMFNUJ88V3SLok4nSRM=;
        b=FhsAonNipAOKvJfyTHyWq5/NvJ2tiMPyRtGB8Pwm56J4DtUGhWX/c35SfOED2XYWBv
         WMo3HF8x9i6NpS5Qfn8jeZp494Ws72zgOyACKbTkF+XTglXbDTRRKaI08X3UrIuUVYdD
         nW0vAEKnLzoF687PVXXvEJHY+/3fxtma0MNp/5tohTbAFOX2V5tdU9KzJPWLEJCfP1/H
         fqgr2UMW/QDOkAuNFqVhUjTPtYE3rUVFvDZmAa68CAcN9YMJHZFA57ZKz6DpJjgtTHi9
         seglAR4EE+mx8vAQgfCM3o3RAHVhiqWUE/Uju/a5pt6ljhD1N7eg2q6kBtpRlhiM2+nN
         rN3A==
X-Gm-Message-State: AOAM533eBzMfHCDgt/GHVp4jAh7Sl73aa7Ph6/sl1qdYRXhjYkJ1XlqV
        A3WUYUQtSyuN3m4f5Cyj+OB2I/ZsFbHvFQEP/W4=
X-Google-Smtp-Source: ABdhPJw3NPmerm1ZyyZkYaCjvjDhCk6Sy/iLaJPCoxxlPk0pqhzjVJJ7SFB1aOFUKhcgIGH20Q+OxQQG5FQrS7BcSRM=
X-Received: by 2002:a17:906:53d3:: with SMTP id p19mr3522667ejo.509.1628773351053;
 Thu, 12 Aug 2021 06:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <c3cd2a383e757e27dd9131635fc7d09a48a49cf9.1628709663.git.andreyknvl@gmail.com>
 <CANpmjNM6hn8UrozaptUacuNJ7EtsprDJWDmOk-F6BaNZ6Hgchg@mail.gmail.com>
In-Reply-To: <CANpmjNM6hn8UrozaptUacuNJ7EtsprDJWDmOk-F6BaNZ6Hgchg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 12 Aug 2021 15:02:20 +0200
Message-ID: <CA+fCnZfGagaxUkrr5FxaQwTVr+C5OpmahPgiwCuXeZkp2nNOkg@mail.gmail.com>
Subject: Re: [PATCH 2/8] kasan: test: avoid writing invalid memory
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:57 AM Marco Elver <elver@google.com> wrote:
>
> On Wed, 11 Aug 2021 at 21:21, <andrey.konovalov@linux.dev> wrote:
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Multiple KASAN tests do writes past the allocated objects or writes to
> > freed memory. Turn these writes into reads to avoid corrupting memory.
> > Otherwise, these tests might lead to crashes with the HW_TAGS mode, as it
> > neither uses quarantine nor redzones.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> although if you need a write primitive somewhere that doesn't corrupt
> memory, you could use atomic_add() or atomic_or() of 0. Although
> technically that's a read-modify-write.

Interesting idea. I'd say let's keep the volatile reads for now, and
change them if we encounter any problem with those.

> For generic mode one issue is
> that these are explicitly instrumented and not through the compiler,
> which is only a problem if you're testing the compiler emits the right
> instrumentation.

On a related point, it seems we have no KASAN tests to check atomic operations.

Filed https://bugzilla.kernel.org/show_bug.cgi?id=214055 for this.

Thanks!
