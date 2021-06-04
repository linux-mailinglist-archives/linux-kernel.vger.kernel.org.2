Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A839B47F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFDIDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDIDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:03:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD96AC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:01:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f11so12713340lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Bw4taStS0TYq1pg5UC4LSk9Au6BM49fh5en5WhcGhE=;
        b=ur14HaR+Deo/iMCQLi4x+4jC05/k1wiyntjUayr32Bcbnj+5gVjebq9KEm/HJEJ8+v
         0p5vibE++OtpvxWXz40k9GbfxEaBflRCeigjtInQQ2bQPi0AiR6CiKvsB6goJowfAQGw
         dOZk5wd/2I155FXqj5h4Kl8bMunugGzElqEwCf4N5NxuTlinMyetl+YLfXr4vGGqC1kI
         QqgTKT0qtNCS/JbMQjXG1Pzdde16POOcPApsifjmoL3okk4PqYyCtlfzgd3eCfakaCph
         Mlfhs0qfhJdK9wd7ssmMRGjuafYUtSkBwxfrEGsgrFs9gSAr5kix4/lkWHoTVI96KZ4e
         eUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Bw4taStS0TYq1pg5UC4LSk9Au6BM49fh5en5WhcGhE=;
        b=hKWMn95rGZWPzcoMVTKDqqqdykXdr7a/d92JO+4caz3EDh7gw/jrBc5IUzBIyFmYgb
         +f4i+2PQNk8qFGFBHt2os1+tfOwWOWoh2deqi9lodiTJbzNKhJMxZ2laLxFRSgg52lVg
         i0YvaygN2GGHkCqgetrPV0Q3JNw4BzNeB2fOw6S/1ensdVkOhFbf1Wn8mjT+b3qUEcom
         OsCcQE/e7wYNmh3ZMR4/rZH0aREx4VkhRjYxQkbmJyJX2Bd350W91bWUrDvaU0FGTm4O
         v/P1TwREL8WB2xYduzNM/Nfhn10qy9Fw/N/oh3fFfKZ0fwLkiUML/4nuuBMNvN6mbNcE
         nI/w==
X-Gm-Message-State: AOAM532AgBi6LePkAzMg7omu1y1UYuFUiKY9z6dN3Pxn0ABiLvJxXe7e
        VfKCoeDHlccMy+smX1dKCSzi1vFghmCPrgLQ/Y7Tag==
X-Google-Smtp-Source: ABdhPJwBqdYA3oPQgKBi2zU4QEMvIT3pto2rMxLubgXqM5I09bxsqOjHjuGSYlqFDkF4xp8cjxOitNwbigTvKyKt4U4=
X-Received: by 2002:a19:f616:: with SMTP id x22mr1904400lfe.291.1622793678476;
 Fri, 04 Jun 2021 01:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210602120329.2444672-1-j.neuschaefer@gmx.net> <20210602120329.2444672-4-j.neuschaefer@gmx.net>
In-Reply-To: <20210602120329.2444672-4-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 10:01:07 +0200
Message-ID: <CACRpkdY7AqcE4CMAdZHR-DfV-3ZCO3h9kYUZoZCUodLQmyyfXw@mail.gmail.com>
Subject: Re: [PATCH 3/8] ARM: dts: wpcm450: Add global control registers (GCR) node
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 2:04 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> The Global Control Registers (GCR) are a block of registers in Nuvoton
> SoCs that expose misc functionality such as chip model and version
> information or pinmux settings.
>
> This patch adds a GCR node to nuvoton-wpcm450.dtsi in preparation for
> enabling pinctrl on this SoC.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

As noted I would name this architecture-neutral with
syscon@...

Yours,
Linus Walleij
