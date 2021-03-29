Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A334D697
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhC2SGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhC2SFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:05:33 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1ECC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:05:32 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r193so13689272ior.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSxMJsHsrNVv3MWw4uspz06NBuEFbC6jAlhbAG5q4Yc=;
        b=KanirahK5a2fMzGRvcgSGzRv8cGLlNCgBBXQxqsjdAU1B3j+mD5nOEyRTU6WvsOSBc
         CGmlHF+dYa5MM2EFls0NYmMPNpMcrnC8nmjoPC9RqRscSmy3tKU+J9bgsQvfECakkMbt
         pybULaBeChlhfhiBSkrErTYSc74wBm/pYTRws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSxMJsHsrNVv3MWw4uspz06NBuEFbC6jAlhbAG5q4Yc=;
        b=h30cYBvQ8334/Ffnegl8m66EN9FUfvDajdPokxspdI7mkMm4q+LJmhLiqBUhIvyYrL
         IuFgijrvIQLBrZLme9Ducr2Xqhuu8dYCffF7VfK7RzMSdBmAB55LY0OMalDNdEnFomRG
         Y7ulltsQgkl2/x2JvDR/ZAHwVy69LKqcNQfkyEPts31ICY4uvxx7/jXKZzCP6QyVHVdN
         ymKZOFr4UQ3ZsHMK5lUwv3BKtsgL3hV5inZ1JEZwvxTM4GoxR1/ixxeECSowQClokk5o
         ginGnzHLcFJOkb5wLfyCtqy2LYBd6ps6ylO4c2LGeL7vt+lHoM6t/yjiwQGHDbCkriXB
         Yg7g==
X-Gm-Message-State: AOAM531yOgeBFTBnGjj4DXM37cSkr/g93dIwgadQwFYodLYm890twsjl
        1oSpC+DmdYywo94HF56t64iDCjuOcJHVsg==
X-Google-Smtp-Source: ABdhPJzrSkJCetnQCmMOZUlZg+/Q52o6CjuItR9qQFQ5tMpfAtN0jSMkmdqBQS7CUT0uTaG/eykrMg==
X-Received: by 2002:a6b:bf07:: with SMTP id p7mr9526853iof.15.1617041131432;
        Mon, 29 Mar 2021 11:05:31 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id r15sm9984357iot.5.2021.03.29.11.05.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 11:05:31 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id f19so13694892ion.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:05:30 -0700 (PDT)
X-Received: by 2002:a02:850a:: with SMTP id g10mr25402626jai.140.1617041130498;
 Mon, 29 Mar 2021 11:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg89U6PLp1AGhaqUx4KAZtkvKS6kuNmb+zObQhf1jez+g@mail.gmail.com>
 <20210329020746.GA250550@roeck-us.net>
In-Reply-To: <20210329020746.GA250550@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Mar 2021 11:05:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMoP9PifpuUnQ3xmAM_LmGARr+fxFuOSX1rvh2mz35Mw@mail.gmail.com>
Message-ID: <CAHk-=wiMoP9PifpuUnQ3xmAM_LmGARr+fxFuOSX1rvh2mz35Mw@mail.gmail.com>
Subject: Re: Linux 5.12-rc5
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 7:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This is not really a new problem. I enabled devicetree unit tests
> in the openrisc kernel and was rewarded with a crash.
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> has all the glorious details.

Hmm.

I'm not sure I love that patch.

I don't think the patch is _wrong_ per se, but if that "require 8 byte
alignment" is a problem, then this seems to be papering over the issue
rather than fixing it.

So your patch protects from a NULL pointer dereference, but the
underlying issue seems to be a regression, and the fix sounds like the
kernel shouldn't be so strict about alignment requirements.

I guess we could make ARCH_SLAB_MINALIGN be at least 8 (perhaps only
if the allocations is >= 8) but honestly, I don't think libfdt merits
making such a big change. Small allocations are actually not uncommon
in the kernel, and on 32-bit architectures I think 4-byte allocations
are normal.

So I'd be inclined to just remove the new

        /* The device tree must be at an 8-byte aligned address */
        if ((uintptr_t)fdt & 7)
                return -FDT_ERR_ALIGNMENT;

check in scripts/dtc/libfdt/fdt.c which I assume is the source of the
problem. Rob?

Your patch to then avoid the NULL pointer dereference seems to be then
an additional safety, but not fixing the actual regression.

          Linus
