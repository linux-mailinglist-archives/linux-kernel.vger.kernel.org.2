Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD731233D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBGJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:46:47 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36665 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:46:43 -0500
Received: by mail-oi1-f174.google.com with SMTP id k204so10984277oih.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 01:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCzHsHOfsw/92ruMuZqxGmd0Y8mzeC+auWD82Of4Qj4=;
        b=k8VPfF+tDD5ZRJRgVxhNf1vUJejdyp3X8KMEQTQIm0WWJ7GOvuD4oqIMaCyZtRyPqz
         DY9DNdQBkEBW8QQ3Lsw5JQfX+IWXvh1M6HIimRjMXuKHJIuA7Kq1tUZQWWhGlnmD+tao
         B34T2iWPiIr6te3GbN5EqAD6d5C5OGhFFBKFG/o57a+mCTxgToX2yy2mWfBYDljb6Wj4
         myOG8mo6Wlvn1QWndUxRRcsgl2fPPxMVSl3soBtKjX6HAjw/o+NTo1BxRb6wmatD7Rqi
         4quk6QnEXb/K8ivKfHwukCZY0KbWnhrHvfG/RZfDft2LOAXMpnoCMFzNIXa2bMFFZ9FO
         jhZg==
X-Gm-Message-State: AOAM5337slpdSWfWASs60Gi1NIKkpEJPs4kPrcfjK788QhBiZ3PsQWtZ
        0PyKbpm9+Se5UQMR34+gNd4BwsQpYu4mH+FfsGA438DiLE0=
X-Google-Smtp-Source: ABdhPJwCKZmBf9CKasiV5sqSR6MM4vEWX6alfoIfk5diGVjc45PrwAyDnkunUISqepwXGVYfzTgDqynqUomYuLHwUDQ=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr7876328oiy.148.1612691162656;
 Sun, 07 Feb 2021 01:46:02 -0800 (PST)
MIME-Version: 1.0
References: <baa95d7235921dff23bed6320518f3fa90396603.1612681353.git.fthain@telegraphics.com.au>
 <8e3f7657-7e37-a8f1-ea20-2bd984fccd81@physik.fu-berlin.de>
In-Reply-To: <8e3f7657-7e37-a8f1-ea20-2bd984fccd81@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 7 Feb 2021 10:45:51 +0100
Message-ID: <CAMuHMdUoHENnX9xDp3awgAxgbNpmKwqAR_MdunUA3O_3gGvK8g@mail.gmail.com>
Subject: Re: [PATCH] m68k: Drop -fno-strength-reduce from KBUILD_CFLAGS
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Sun, Feb 7, 2021 at 9:51 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 2/7/21 8:02 AM, Finn Thain wrote:
> > References: commit 565bae6a4a8f ("[SCSI] 53c7xx: kill driver")
>
> Does that mean there is currently no driver for the A4091?

Supported by the replacement driver:
45804fbb00eea27b ("[SCSI] 53c700: Amiga Zorro NCR53c710 SCSI")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
