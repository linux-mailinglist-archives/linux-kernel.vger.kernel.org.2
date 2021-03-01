Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6791B328096
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhCAOVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233004AbhCAOU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:20:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D51164DF1;
        Mon,  1 Mar 2021 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614608387;
        bh=3w1eF9LHp7QcFUvtQPp8CkuujhoRhLpfb9f+p7H8+lI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q2OqajdEdZNZKrpBvBcGOV1M4BqfNHN8CMoFQMi5JPUXoTuk2A26SGymG5mg8LEdX
         uDFBSbhz1lrr/IN+tHhfzoaPdR2VsS4dV9d8v3wTt3v4As4dWR0E89AiKLine5FEEJ
         dJmu9ZXnagrODfCE5MJLvjY9hBbadr8vj/Gb85KvqOtm/6GtkHzHAbMegwFDZ3ylJg
         eRcAM3GRKBH6QyemIVPv34SmyyO8/zKsLMOdz1n/cMSe/psDtEEvuZRXVGU9XrIJP4
         HVPfojUiZZDiB0i2RnkUSCEciCR+pQ/imdw+e9fsONZCG5RgdVaMyZrvGz+7Lzh1ZB
         sock6eqMjz1bw==
Received: by mail-ed1-f42.google.com with SMTP id f6so5167037edd.12;
        Mon, 01 Mar 2021 06:19:47 -0800 (PST)
X-Gm-Message-State: AOAM533/ipT+pxwnpPNJ0Q426wsF0ztsYit9GBTjoeYSMmzjRrJ3o0vA
        sETFOhKL6rAPqRK4VN9TtWIluvU7KawrtOT3Ag==
X-Google-Smtp-Source: ABdhPJyoWyrlgFuQBJLPu4G11AIf3KeGQsfFC5NHek+GZeLTK7S5sczR2Ftj/PQFWC69dZaEWfPrVxtgxWV8sxqdA9Y=
X-Received: by 2002:a05:6402:2d0:: with SMTP id b16mr16879109edx.194.1614608386039;
 Mon, 01 Mar 2021 06:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20210225125921.13147-1-will@kernel.org>
In-Reply-To: <20210225125921.13147-1-will@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 1 Mar 2021 08:19:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJX=TCCs7=gg486r9TN4NYscMTCLNfqJF9crskKPq-bTg@mail.gmail.com>
Message-ID: <CAL_JsqJX=TCCs7=gg486r9TN4NYscMTCLNfqJF9crskKPq-bTg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix CMDLINE_EXTEND handling for FDT "bootargs"
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Uvarov <muvarov@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 6:59 AM Will Deacon <will@kernel.org> wrote:
>
> Hi folks,
>
> We recently [1] enabled support for CMDLINE_EXTEND on arm64, however
> when I started looking at replacing Android's out-of-tree implementation [2]

Did anyone go read the common, reworked version of all this I
referenced that supports prepend and append. Here it is again[1].
Maybe I should have been more assertive there and said 'extend' is
ambiguous.

> with the upstream version, I noticed that the two behave significantly
> differently: Android follows the Kconfig help text of appending the
> bootloader arguments to the kernel command line, whereas upstream appends
> the kernel command line to the bootloader arguments. That is, except for
> the EFI stub, which follows the documented behaviour.
>
> I think the documented behaviour is more useful, so this patch series
> reworks the FDT code to follow that and updates the very recently merged
> arm64 idreg early command-line parsing as well.

I can just as easily argue that the kernel having the last say makes
sense. Regardless, I'm pretty sure there's someone out there relying
on current behavior. What is the impact of this change to other
arches?

Rob

[1] https://lore.kernel.org/lkml/20190319232448.45964-2-danielwa@cisco.com/
