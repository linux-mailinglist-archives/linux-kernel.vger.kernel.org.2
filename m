Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398D9444E02
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 05:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKDEsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 00:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhKDEso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 00:48:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27510C06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 21:46:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br12so7653738lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 21:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSdbnulbptk0ZuR/Tz6LR9TZS4PNPngbTJ9ZV4hqiAY=;
        b=eWNZQn6h0mRAvVFSonm4jcoNEVKE/t4wJ+QJnDr+UOtXF6oepsc0b+7nfrhBRZ8SYa
         1KHFb3PivXYs5Rcw+87v/wFeEhb/xtx5QMVOaa0dDC+AXJ6XbaeZxtZJyQPzv9auyGHp
         Pl2YPMtYNB29dUXB+VVhcax2qSCRj+kLte3Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSdbnulbptk0ZuR/Tz6LR9TZS4PNPngbTJ9ZV4hqiAY=;
        b=zk146bAHaG3Im+0HtqZIzpRnLAgx50tDn+QCK2W6Y2a2wBI35DhJe9ubeTbyXml5bM
         pxULFMbqVIrVfC/1GwHDSnvqxlcjqdBMRtebC38WWLNUaqZMBiVo0Nolqt0IV9G8NpzV
         wsssLO0G6cK9LsNPXGnFNNEUM9o492/cy3j4fe7P34rCdY36qcfV3DQCFfRrvSCWZCi2
         OU+Qj+5ZdvZTjEejndJqVtxG74bAd/MTjR+X228CZvGGpGPh3Sy/u/mg7cfkuRZtRHpO
         i8Etu1PJStJ454f6+37uwkeSQ032IcOs1gX7GOr8YgKMV0h6kOOOnK/k2VrdxOomANJB
         UIkA==
X-Gm-Message-State: AOAM5311uP7X7sM2SNpVvy39Frn/nG5aQkU39AS3tCAc2SNc/n85QMYV
        rUyt6atK3osp9TYrHeP0p0OL1CxwLYdQrQFF
X-Google-Smtp-Source: ABdhPJxr8udua2bxqDd8/wMGIRgWNM01NVRi+FYAgb2v+B9OwVDM9t/CnmyrExQLQ9Q6k9hGQpmodA==
X-Received: by 2002:ac2:4570:: with SMTP id k16mr39067237lfm.611.1636001164990;
        Wed, 03 Nov 2021 21:46:04 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s10sm18558ljh.27.2021.11.03.21.46.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 21:46:04 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id br12so7653619lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 21:46:03 -0700 (PDT)
X-Received: by 2002:a19:384b:: with SMTP id d11mr453337lfj.678.1636001163584;
 Wed, 03 Nov 2021 21:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211104031554.GA34798@roeck-us.net> <CAHk-=wjvWORtC5vwgavJxpBtV3-q9GGidezS_2NjtUFvqg7H5Q@mail.gmail.com>
 <77dc70f4-879a-eb5c-2dd6-682b4c7cfd03@roeck-us.net>
In-Reply-To: <77dc70f4-879a-eb5c-2dd6-682b4c7cfd03@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 21:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZo3yj46FwVi0BNKfy5fZ4-UeWkeQ6nhcAbbnKS7K=dQ@mail.gmail.com>
Message-ID: <CAHk-=wjZo3yj46FwVi0BNKfy5fZ4-UeWkeQ6nhcAbbnKS7K=dQ@mail.gmail.com>
Subject: Re: parisc build failures in mainline kernel
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>,
        linux-parisc <linux-parisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 9:30 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Unfortunately not. With that patch it complains about task_struct.

Gaah. You'll need something like this too

-       DEFINE(TASK_CPU, offsetof(struct task_struct, cpu));
+       DEFINE(TASK_CPU, offsetof(struct task_struct, thread_info.cpu));

in arch/parisc/kernel/asm-offsets.c.

And really, it should probably be renamed as TASK_TI_CPU, but then you
have to rename all the uses too.

There might be other details like that lurking.

                   Linus
