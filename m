Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878183AA492
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhFPTvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhFPTvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:51:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12F616023C;
        Wed, 16 Jun 2021 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623872955;
        bh=V1c2oiAhwllBJsNOnuqfRkhRhp5+LBGbB0+KsLMNU/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R9U24BhAP23w2lxorpjvSW1AiTl1cuQV57e/XTSTt6eB7dX7K6+W7FR8L4Sj4YVmG
         8g2Ovj/iap75GwocVdPhYt7itWUvYkq+8J5r0Ltfhwrts4SPflHY79G4w0TMg7zeYq
         GMWjM/wy44NIhv43TGk1SDyt+1/4mX5wUiZSxD+sCKBtoYh76A2ypK0JA+V7BJ/ysu
         N+rxow+953YocxQeB41BBL+QFMiv2pLpblGHyYIAMimgvlGA0DboAQP6Qwf7t84n+2
         +n+4PhN2k4BDre0/Lj2B85UTHNfwSQufmVAkqe4ZFrvlncHJQFKtzlCvs6e/nKFOL+
         rQYavdKh+u9bA==
Received: by mail-ej1-f45.google.com with SMTP id ho18so5706700ejc.8;
        Wed, 16 Jun 2021 12:49:14 -0700 (PDT)
X-Gm-Message-State: AOAM530V49dna3kF5QyEJ/9vbVspdg+WuexvJlgZTWTDTpLuAG2sW4JQ
        K56Ck8LoGBC2QNcvWRcS1Jegdhsq7sPoA+QoqA==
X-Google-Smtp-Source: ABdhPJyh23HvZxYiCkKbIrPFDBjZJxZKd53XFwqzjUyqur0BZSP4hmcT9vv13l2nFPOSvbJQilQ/IctrdrK8EjJpG6E=
X-Received: by 2002:a17:906:9419:: with SMTP id q25mr1173382ejx.341.1623872953640;
 Wed, 16 Jun 2021 12:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623835273.git.geert+renesas@glider.be> <a4e07a0c1efea913ce5a61136162b5b720b96b48.1623835273.git.geert+renesas@glider.be>
 <CAL_JsqKXWOb7i8aBOmRhsSUVad=v2r095uw7gFHMqf_+96eEyw@mail.gmail.com> <CAMuHMdUpuws0TRYVD9HPYO-K77VvhuqF-f1cQ5dH3p5zB_kS0A@mail.gmail.com>
In-Reply-To: <CAMuHMdUpuws0TRYVD9HPYO-K77VvhuqF-f1cQ5dH3p5zB_kS0A@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jun 2021 13:49:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLBU3FizWB+V_tcgYZLuA3B6LxKG2=znsJJY_X6yJ4DQ@mail.gmail.com>
Message-ID: <CAL_JsqJLBU3FizWB+V_tcgYZLuA3B6LxKG2=znsJJY_X6yJ4DQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: kexec: Always use FDT_PROP_INITRD_START and FDT_PROP_INITRD_END
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 1:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Wed, Jun 16, 2021 at 7:14 PM Rob Herring <robh+dt@kernel.org> wrote:
> > On Wed, Jun 16, 2021 at 3:27 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Commit b30be4dc733e5067 ("of: Add a common kexec FDT setup function")
> > > introduced macros FDT_PROP_INITRD_* to refer to initrd properties, but
> > > didn't use them everywhere.  Convert the remaining users from string
> > > literals to macros.
> >
> > I'm not really a fan of the defines, so if anything I'd get rid of
>
> Oh, as you authored that patch, I thought you liked them ;-)
> And I was thinking of moving them to a header file, so they can be
> used by other .c files, too...
>
> Upon closer inspection, I see you just copied them from arm64, which
> was not that visible due to commit ac10be5cdbfa8521 ("arm64: Use
> common of_kexec_alloc_and_setup_fdt()") being a separate commit...

That all was largely a 'this is what you need to implement' review.

> > them. But the bigger problem is what you brought to light with the
> > variable size. As I mentioned, we should refactor this and the fdt.c
>
> The number of cells to use for the initrd properties doesn't seem to
> be well-defined.
> drivers/of/fdt.c derives it from the length of the property, which
> more or less always works ("be strict when sending, be liberal when
> receiving").  Some code hardcodes it to 1 or 2.

The not well defined ship has sailed, so we need to support either.

> I suspect (didn't
> check) there's also code out there that uses the root number of cells?

Given it's a single value, there's not really any need to do that.
Unlike some of the kexec properties which combine the start and length
for example.

> > code to have a common function to read the initrd start and end.
>
> What with code that needs to set the start and end?

I'm not sure we can consolidate that as those are mostly in early arch
boot code.

> It needs to use what the receiving end will expect...

That should be fine given fdt.c is flexible already.

Rob
