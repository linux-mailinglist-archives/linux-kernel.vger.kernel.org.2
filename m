Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE433B4AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFYXgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFYXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:36:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C273C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:34:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c11so14714972ljd.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nbwN286/f2tgx7HnIyRwNiSzfszBKdsaXIOOZleXegQ=;
        b=COTO6xK6XXzLj7QCuClwaJRAPiK+9eCHV3HNL+Y/ld2D3Xd90IgfXqbGgcrtNT+rsJ
         rkAIzNNivnFrLIXiydzLgrU/h86zq0d3C8XeMW2xwTrG26BUCfvPtLPlw2xmRuhwZslq
         Bjvy5/bUip9gjz2NDuU7EBpBoF0R3+mRdz2MKs/g3GK7zkhLZ1f0ayS9jQdyas2I8lMs
         WvudoOTIZ1UQLuRtBOJktFORJlW9emVliYMLHmjNPbq27/CxzIOFz6JMY8x1jbRieMkf
         eK8y1jsHyxLI7Qq8P/4agetfSATt+W+s21Vo313vskFd6FlSMSAiNdEaeP9NEdnmd0YO
         S59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nbwN286/f2tgx7HnIyRwNiSzfszBKdsaXIOOZleXegQ=;
        b=SOQ9i5MCFwuT3oNF3uE3xndgM8GwcO89gM8spBSUIkUUxEt9O7UYAvNRnVQ4jyc3/3
         BXvF1P60RcJ9/LmRgw5XnR/001YcCKr000+E1JjsUwdccNt5GmtQXCeHNLRExH79vL6A
         S1SLTMPs5ASfS77k+89aOcAWLlLgNgI5DCk5OHnN+Cm0ssfRoiQVXhw0Nn5iNinCrGso
         jPKrsVUY7NdPacXnRlG+qt5ngoYGUeivsmI+nv/HRx9PwX7hjrWdRyUSz0AbvXesFtz9
         UQijy+9zFxYk5oA4yBmfvAlDP7YYmfQDAqZbaLAm59SdkiEuKitHGwMNvphKnyKUFMBr
         Ek2Q==
X-Gm-Message-State: AOAM5314T+SIfc4Sk3XfPCEsZPbnHAokN9NvKYIGk0+TfgVb6H6IUPFV
        0ewl5RrqLg7Zg3ByALwB2FmHi2LITHuIFkwN8FjRJw==
X-Google-Smtp-Source: ABdhPJxcM7kT2apTAfxoGcZV8wqZQjXu4w+udp8r9dPXO/OseyIYAyQI7Ri4AMx8mrA3H0WE27jDQtxukgjXXcy+uKc=
X-Received: by 2002:a2e:9003:: with SMTP id h3mr10034672ljg.467.1624664052021;
 Fri, 25 Jun 2021 16:34:12 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Jun 2021 01:34:01 +0200
Message-ID: <CACRpkdaVqdFPKTxOuhFt=auFYjxCivRmRz7mQ7ank6rbcVQsQw@mail.gmail.com>
Subject: [GIT PULL] Last pin control fixes for v5.13
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some last minute pin control fixes. A bit late because
I have some vacation and midsommar. Two driver fixes,
details in the signed tag.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.13-3

for you to fetch changes up to 67e2996f72c71ebe4ac2fcbcf77e54479bb7aa11:

  pinctrl: stm32: fix the reported number of GPIO lines per bank
(2021-06-18 14:56:54 +0200)

----------------------------------------------------------------
Two fixes in the last minute:

- Put an fwnode in the errorpath in the SGPIO driver

- Fix the number of GPIO lines per bank in the STM32 driver

----------------------------------------------------------------
Andy Shevchenko (1):
      pinctrl: microchip-sgpio: Put fwnode in error case during ->probe()

Fabien Dessenne (1):
      pinctrl: stm32: fix the reported number of GPIO lines per bank

 drivers/pinctrl/pinctrl-microchip-sgpio.c | 4 +++-
 drivers/pinctrl/stm32/pinctrl-stm32.c     | 9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)
