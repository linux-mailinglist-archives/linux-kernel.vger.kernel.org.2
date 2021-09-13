Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B368E40A12D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbhIMXCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350151AbhIMXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:02:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36243C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:43:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f2so20050730ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpOEkgKG8NafgrWoZalakoEK1VhyBmhF7Y/WtmLd/Lg=;
        b=T5ELGMKQh/WTx6sFdvyr0FHHuaTzqk52ilOVadQrpui/HzUYzquSvX4ZbfGu94G3ge
         nTEseFMW7FCznEBsag51bLSvS5+rwLatAhdo2epXzKSYAv1LBYfLW4jhKFE1wE8Xggnq
         x0+1JZCwFtYYnL5he5N81fDIOPUxyItcGBT7RTnNl6evtY6UcBXTbwpMNnk8XEX9wIsb
         VXbjw6BTsQ9+N7sSC05xu2N514AN5PSgkoKHnhixAkED0kyG4ZvLwwVuSfk+3ASxkLjf
         YBUY/v3PPji3ut12qv1D+otpTo2ks05MRpyRc8do6MkN6pM4YQRtJ0PdX3WreEjad2bC
         9OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpOEkgKG8NafgrWoZalakoEK1VhyBmhF7Y/WtmLd/Lg=;
        b=6170fytgol+fkJGzuigDfUKpDmKF/HdrwDaKWjLGqpHZzPboWuVYElCvdgyZ4wJYOM
         sZBzKc7EGsrZGxfzj7qAIXU6yYG+uCvIZrkJE26KH5TAMtVb6OiX7J5axtsarFGn+DLP
         wL2Fu0ZHDKHHBpT+ZS7kYBn+F7urjyoTBNY0rwqb/FvswFBbvnIn4dW+FECcI1UfPDXV
         2n6C/XoOYOCu6bmTxZBjnCojlYBfoWsGCG/4sSE/FQb/kWtQZ1/OUF83ml+eKsqJ1eCK
         T0QJ5aUgM4fYSw+yf8KzTA5uNdRYsFoNSL1LE0rkRAevkyYKO/sq9zmJLH9caVTvCgKG
         R1Ag==
X-Gm-Message-State: AOAM533ii0FnxvLRgQ6Kn0CwEGrUUuNiZ7ijSKEgSEN+OGpHl1jKen1A
        RMsXEK/GdemvLH7WMzNo9/KdF2fE3WFwBo1oGo5rbw==
X-Google-Smtp-Source: ABdhPJzKO2FsVC4sg0vOItOJgZVIRszPr8OShfpu41ntSTwrHG41b5nNLLseS13wtPNoOwMAasLh+8NmvMAfmhBqi60=
X-Received: by 2002:a2e:b5b9:: with SMTP id f25mr12459004ljn.145.1631573037580;
 Mon, 13 Sep 2021 15:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210908162617.104962-1-andre.przywara@arm.com>
In-Reply-To: <20210908162617.104962-1-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Sep 2021 00:43:46 +0200
Message-ID: <CACRpkda7Ztt8xv1b0UBt1dNZNW-042hdrA5wwFhZVSjDohGBow@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompressor: Avoid UNPREDICTABLE NOP encoding
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adam Lackorzynski <adam@l4re.org>,
        Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 6:26 PM Andre Przywara <andre.przywara@arm.com> wrote:

> In the decompressor's head.S we need to start with an instruction that
> is some kind of NOP, but also mimics as the PE/COFF header, when the
> kernel is linked as an UEFI application. The clever solution here is
> "tstne r0, #0x4d000", which in the worst case just clobbers the
> condition flags, and bears the magic "MZ" signature in the lowest 16 bits.
>
> However the encoding used (0x13105a4d) is actually not valid, since bits
> [15:12] are supposed to be 0 (written as "(0)" in the ARM ARM).
> Violating this is UNPREDICTABLE, and *can* trigger an UNDEFINED
> exception. Common Cortex cores seem to ignore those bits, but QEMU
> chooses to trap, so the code goes fishing because of a missing exception
> handler at this point. We are just saved by the fact that commonly (with
> -kernel or when running from U-Boot) the "Z" bit is set, so the
> instruction is never executed. See [0] for more details.
>
> To make things more robust and avoid UNPREDICTABLE behaviour in the
> kernel code, lets replace this with a "two-instruction NOP":
> The first instruction is an exclusive OR, the effect of which the second
> instruction reverts. This does not leave any trace, neither in a
> register nor in the condition flags. Also it's a perfectly valid
> encoding. Kudos to Peter Maydell for coming up with this gem.
>
> [0] https://lore.kernel.org/qemu-devel/YTPIdbUCmwagL5%2FD@os.inf.tu-dresden.de/T/
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Adam Lackorzynski <adam@l4re.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Looks like a correct and clever solution to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
