Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA79F32430C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhBXRST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhBXRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:18:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C41C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:17:34 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d3so4147707lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYBdoP96cyQRYv1FhbQIANzdHpvYhEawFInfbX+0I5I=;
        b=XBy3xiSWhvQAEAL40mALdcAlI+Cox5aPXE7tNtrbTb1YpVW3IpuFWWBvgC5jL+g2iy
         FlDJtfj6JaLPP4iOnhwtcFCGcVb+mWpT6rE21kfERoAZL5JWel8Zxj2IAj3rPtbSmtcf
         Yg8HRxeQvf5vrgfnt+SWTDiCWmYO1RPTc9INU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYBdoP96cyQRYv1FhbQIANzdHpvYhEawFInfbX+0I5I=;
        b=Sz0FAkbidyMof7jv3WPleNYe309sLMc1RSok6SpOzG3vRyn1wDdhBqT99ccQY5BZmU
         /c42AETopJ/zQZBomXnkOINNpXekiGA6VmI5BZ2Mpf7uBKrnim/Pr3suHku4DCRkFDk1
         8F0fkyJ4CSqP/cZpEiepwjxOkw8tOyKQ8f28oui+tyx6Xs2iyS1vI8tyYf/wX6ypUuU2
         d9+sxJi+EjvS9IAmHTSMuoecf995VnPn79e2BvkmrQiljEg/86xQVj5J4SYX2PUqgqo1
         ewgSyqYz6hbslF98zAV8bWDBPpwqxNYUHZq9FPZyobCY4CiJLPlUrtS5VQv41V4FZkJ3
         b8AA==
X-Gm-Message-State: AOAM532GaMIYmKOT/otLloKK8IwekFPGMl/tKTxPevd3hHhQrYzLgOGi
        PqAnFV3X+5SJE83lHkl+HV1p5CzMHdCjow==
X-Google-Smtp-Source: ABdhPJzbIUiwgwndTRYppNBzGV9yHnpTk1OgnUw/V+4pqKiza3gvhIIcGcpjmV/PNHiib32xbP1LSA==
X-Received: by 2002:ac2:48b1:: with SMTP id u17mr5268790lfg.627.1614187052184;
        Wed, 24 Feb 2021 09:17:32 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 187sm603415lfh.116.2021.02.24.09.17.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 09:17:31 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id u4so3303156lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:17:30 -0800 (PST)
X-Received: by 2002:a2e:a306:: with SMTP id l6mr2234860lje.251.1614187050274;
 Wed, 24 Feb 2021 09:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk> <20210224142909.2092914-2-linux@rasmusvillemoes.dk>
In-Reply-To: <20210224142909.2092914-2-linux@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Feb 2021 09:17:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgw1Eg9kDGUiEY6EL+6dTC8tVqAhstvcmUBgrF5hdoApQ@mail.gmail.com>
Message-ID: <CAHk-=wgw1Eg9kDGUiEY6EL+6dTC8tVqAhstvcmUBgrF5hdoApQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/2] init/initramfs.c: allow asynchronous unpacking
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 6:29 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> So add an initramfs_async= kernel parameter, allowing the main init
> process to proceed to handling device_initcall()s without waiting for
> populate_rootfs() to finish.

Hmm. This is why we have the whole "async_schedule()" thing (mostly
used for things like disk spin-up etc). Is there some reason you
didn't use that infrastructure?

           Linus
