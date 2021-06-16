Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6883AA468
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhFPTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:38:26 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:45887 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFPTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:38:26 -0400
Received: by mail-vk1-f175.google.com with SMTP id az3so838869vkb.12;
        Wed, 16 Jun 2021 12:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsbmcWdS/YIcLL6mMGFfj7bfGnV28eL04LNJ7iHjaEA=;
        b=B2TaLiYeyaPqkprl5UyTzZmJ4sspOtcRjPiFZjyHrilX/44isXVZZ1z9kM9W5fprKE
         /INT2rkLyIxqA20X2IMMkwOGVBtMUA+jadfrZuOG+ppI4IHeyb0lhDK4TWPdOJgiymn9
         jtlVrDqh+I9/9OLoxmIVSnkapeqgPaWKYPfLyo3i1HPxXSVFREXqT6NdsEi2N1ev5aOD
         EkX1X1iX8NWdIN6gcayMPb17zsrimw2OR+PAXt/eCXVwVUZz02/0WHczuNM5zF1IPPog
         xa36g9GbpJe3n1qYppC4RDv4n2D+D2Q3a7TCkSQU/QRGHVUTcxGkh21wb7+9cCXYPJ14
         HiMg==
X-Gm-Message-State: AOAM531OcOda1ckXeepQB0T81ZAp+SI8AnsppZi2vYtBBM2Xp+S+lhX+
        6LXEh5g2hcOJT8LccBCaTuM4EPs57R12XhSH+nE=
X-Google-Smtp-Source: ABdhPJzqGm51arrUrMl0aTP+uwwFDBsx5MeCxtx7wzPxZA712Pa2d1LQUizgKKK/Ll2E2T9LKwClHF908Se8M8zvKM8=
X-Received: by 2002:a1f:d8c3:: with SMTP id p186mr772309vkg.1.1623872178323;
 Wed, 16 Jun 2021 12:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623835273.git.geert+renesas@glider.be> <a4e07a0c1efea913ce5a61136162b5b720b96b48.1623835273.git.geert+renesas@glider.be>
 <CAL_JsqKXWOb7i8aBOmRhsSUVad=v2r095uw7gFHMqf_+96eEyw@mail.gmail.com>
In-Reply-To: <CAL_JsqKXWOb7i8aBOmRhsSUVad=v2r095uw7gFHMqf_+96eEyw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Jun 2021 21:36:07 +0200
Message-ID: <CAMuHMdUpuws0TRYVD9HPYO-K77VvhuqF-f1cQ5dH3p5zB_kS0A@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: kexec: Always use FDT_PROP_INITRD_START and FDT_PROP_INITRD_END
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jun 16, 2021 at 7:14 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Jun 16, 2021 at 3:27 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Commit b30be4dc733e5067 ("of: Add a common kexec FDT setup function")
> > introduced macros FDT_PROP_INITRD_* to refer to initrd properties, but
> > didn't use them everywhere.  Convert the remaining users from string
> > literals to macros.
>
> I'm not really a fan of the defines, so if anything I'd get rid of

Oh, as you authored that patch, I thought you liked them ;-)
And I was thinking of moving them to a header file, so they can be
used by other .c files, too...

Upon closer inspection, I see you just copied them from arm64, which
was not that visible due to commit ac10be5cdbfa8521 ("arm64: Use
common of_kexec_alloc_and_setup_fdt()") being a separate commit...

> them. But the bigger problem is what you brought to light with the
> variable size. As I mentioned, we should refactor this and the fdt.c

The number of cells to use for the initrd properties doesn't seem to
be well-defined.
drivers/of/fdt.c derives it from the length of the property, which
more or less always works ("be strict when sending, be liberal when
receiving").  Some code hardcodes it to 1 or 2.  I suspect (didn't
check) there's also code out there that uses the root number of cells?

> code to have a common function to read the initrd start and end.

What with code that needs to set the start and end?
It needs to use what the receiving end will expect...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
