Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F59458731
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 00:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhKUXiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 18:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhKUXio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 18:38:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEBBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:35:38 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso26288420ote.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaBwOZhHd4DxX6OyrXmhy1nl2ZJax3QUSfV+91vGF7M=;
        b=K+j7e9qBhUAibBOZEuR3+OvgRRz5+9kXuJpfy7hOrCUUI5mVAVvfPjVaSaQWagEtmD
         VaQjSDZvZCKKfl/PaO0UdwCeIlqMJ7eJooO6eT7GjoXW1uvDDryVqntBnxqhbhpAdjE3
         CmxKLcWB9dGg5+uW12IGRoofHXHVRV9TegwAW6qUaX/HiDYCvGQYSP2/TGLWo1eJk41q
         HLONx6bHVQumcQ5Vy4Z+6fD/ZgNYF7VwvELj9YticGsmN4Q2lcnFiWT5fPI5W1ugXnAY
         wRaew207TxZ9kuepimcJjzsp7th6vntEkiki7IDzihCyEVwhCSWDlcpKyzXN5bcdu5J+
         tDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaBwOZhHd4DxX6OyrXmhy1nl2ZJax3QUSfV+91vGF7M=;
        b=q/AlMXr3F9Kaa1jDukCh+QOiR+yZ9ZjoR/olFuTaCTg1plDeC/uWH7s/n2Ens/qaLE
         9OFohKFwNLaJoBFdEoZBRM0eVuxeTMOC/P4q8td/IYRGu4NvKC1MVimumLYa6iq/VlC+
         vSSKA9GZ4aBgNoTQSMbHwu10XrjOYxcXx465xh/3cQP+JYt+AgNInMdq4jKEXgksegbf
         IlaLr6eOGUhNHdscbfTNZ4rXH5uFlXexfpkxMsE9PyVGE8HYw9hz1giTK4n93vwLP3mS
         QgmFrNN9Akr+N1SZu3z5pTDGk4IH1PAXifWVwHJsDZQkiKBZmnnjaBrE5IlVQ6pdCcSC
         Xz9g==
X-Gm-Message-State: AOAM530IoX8tkf2eas6tV3vA81nEfKLyK7tnv9Qx9TcQvOXkHisVeVUB
        vW+q5yWgGm6Tt+RK9BlFCX3WdUb6r6adZHe7GNF9FA==
X-Google-Smtp-Source: ABdhPJxP1hm4dAk3hP5iwxGTmVS5kCY5d1BVX1iWfJPo1f0KYbx3q9C2qhLGJ7JQjety/S6BZHEqWcsnr8krInQwy+4=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr21475101otg.179.1637537737964;
 Sun, 21 Nov 2021 15:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20211116150119.2171-1-kernel@esmil.dk> <20211116150119.2171-13-kernel@esmil.dk>
In-Reply-To: <20211116150119.2171-13-kernel@esmil.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Nov 2021 00:35:26 +0100
Message-ID: <CACRpkdbsRg3KB=xvhUPF3gVjE92pTwsbV+1SOJ=DXSE7c9VNHw@mail.gmail.com>
Subject: Re: [PATCH v4 12/16] pinctrl: starfive: Add pinctrl driver for
 StarFive SoCs
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Drew Fustini <drew@beagleboard.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Huan Feng <huan.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 4:02 PM Emil Renner Berthing <kernel@esmil.dk> wrote:

> Add a combined pinctrl and GPIO driver for the JH7100 RISC-V SoC by
> StarFive Ltd. This is a test chip for their upcoming JH7110 SoC, which
> is said to feature only minor changes to these pinctrl/GPIO parts.
>
> For each "GPIO" there are two registers for configuring the output and
> output enable signals which may come from other peripherals. Among these
> are two special signals that are constant 0 and constant 1 respectively.
> Controlling the GPIOs from software is done by choosing one of these
> signals. In other words the same registers are used for both pin muxing
> and controlling the GPIOs, which makes it easier to combine the pinctrl
> and GPIO driver in one.
>
> I wrote the pinconf and pinmux parts, but the GPIO part of the code is
> based on the GPIO driver in the vendor tree written by Huan Feng with
> cleanups and fixes by Drew and me.
>
> Datasheet: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
> Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Drew Fustini <drew@beagleboard.org>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Overall there is nothing wrong with this, and it is in nice shape.
Let's merge it:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
