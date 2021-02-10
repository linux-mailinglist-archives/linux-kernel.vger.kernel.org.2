Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7417131669F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhBJM2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhBJMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:24:54 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C52C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:24:14 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z22so1302288qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LISi+Oc9GTZ5oHTm+YUr6VLWACgROuri9cGJPLpozgI=;
        b=EW9Gs12uxdYBPULSVoXhyzBNha9rowbDBkjznSNaTFNaiTV56gKyrVP5MVjdlsaoBp
         SynP8rRSvYLNNcbAltAfGysTSBI9lsE9Nl+/l90licN9Ut8RU5i2wAdZMLR/dr6Z+vjQ
         ghbeYAQ2zgUg+JxD3Pys4HZTNJDGYOu1VEbns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LISi+Oc9GTZ5oHTm+YUr6VLWACgROuri9cGJPLpozgI=;
        b=HATor23oRHM9y1dyLpyhk2RIc3Wx/8mfpllZqhPP+/cB1YxARO9aiadPWBYK05riaK
         6oH0AJ56yk9hB8RPKh89zc+QwG1XMESIWxhD3hrFqN14+HBO40dSpF+BkSDB4ZtWe9FS
         /nzyh+1DrFI+kBqMSxoa4ADDKvHMLxT5zzc5QA2hjTeXtp6XxNEAndju4wXTsAxOETho
         Dg/T8oAkCkdOvQ0C4jC5tEW96/jIzh8TAO8Vy7iNix+go31FqIZV0RqAXxqbYUuSC0wD
         pjWpD0nS6f8At+NI1dXghuBqN0hd0scImptnb4HKoXZg6+YUZ542lU5I+ENd2OAN/5wd
         f0JA==
X-Gm-Message-State: AOAM531nP6byDuQ4y2z3AUqTlpH9+uTM6hU6Hh6R+PEAPjrU1GMh4TUV
        AIlDXaf+Zn2E5e55DpcALlSa102IeKlEIH7obgIOhw==
X-Google-Smtp-Source: ABdhPJxEfZ/WBSPKx1Tl0qBwSbg2IbGZqKcplsfGLH1uLBGHXIALkT/jB/LIe+Ss4Wptzn5AfhQO5Hz846E+WIqzIZk=
X-Received: by 2002:a05:622a:4ce:: with SMTP id q14mr2498595qtx.132.1612959853524;
 Wed, 10 Feb 2021 04:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20210204203951.52105-1-marcan@marcan.st> <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap> <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <YCOzLSqdsr83xf0b@atomide.com> <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
 <YCPE2lPpBlhCi7TH@atomide.com> <4dd911d8-ce84-bf4d-3aae-95ef321b4a97@marcan.st>
In-Reply-To: <4dd911d8-ce84-bf4d-3aae-95ef321b4a97@marcan.st>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 10 Feb 2021 21:24:02 +0900
Message-ID: <CAFr9PXkLRKHguszidJX2Qit0QUJ0QxFi3H=Wp2HDqpfJQYZEVw@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1) devicetree
To:     Hector Martin <marcan@marcan.st>
Cc:     Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@kernel.org>,
        DTML <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

On Wed, 10 Feb 2021 at 20:49, Hector Martin <marcan@marcan.st> wrote:

> > Yeah, just don't use an imaginary dummy index for the reg. Use a real
> > register offset from a clock controller instance base, and a register
> > bit offset too if needed.
>
> I mean for fixed input clocks without any particular numbering, or for
> temporary fake clocks while we figure out the clock controller. Once a
> real clock controller is involved, if there are hardware indexes
> involved that are consistent then of course I'll use those in some way
> that makes sense.

This exact problem exists for MStar/SigmaStar too.
As it stands there is no documentation to show what the actual clock
tree looks like so everything is guess and I need to come up with numbers.
I'm interested to see what the solution to this is as it will come up again
when mainlining chips without documentation.


> The purpose of the clock in this particular case is just to make the
> uart driver work, since it wants to know its reference clock; there is
> work to be done here to figure out the real clock tree

FWIW arm/boot/dts/mstar-v7.dtsi has the same issue: Needs uart,
has no uart clock. In that instance the uart clock setup by u-boot
is passed to the uart driver as a property instead of creating a fake
clock.

Cheers,

Daniel
