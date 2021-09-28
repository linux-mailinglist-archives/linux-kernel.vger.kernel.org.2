Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF88141B9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbhI1WNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243022AbhI1WNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:13:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C108C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:11:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ba1so822569edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xpxr3RAhQnlxdqPs5z2YzYADDLX6tSSmdU82c8YOdl8=;
        b=HJwRmoevoSoyVu5/9HqZ0Kqe6kfGDRd9JpIEKI94u50c0A29R9CwPhCLc3Guci3B4T
         k2hT8mgzDV9xheA7tPao/OPFSzs1F2v39o+DIZyVsXwsS9ibN38eoDz8/lyyWjMC7lPb
         06MTR/doGz6psPOLD0Ahetjlmdj/TBuifsev0M+ITxKN/42et8zX8L/8P6GZY9wRjIjA
         CoMZHGv6ypB9y8sWKGesO+gStbYtvKmMy6jySWsJ6eXt0j0wyoj5TFb3hgntT9zHrieX
         s+PwDgNG0fGIMrOM839A7ptkAJMDzrcMhq5Y1qlAXsamu5Na4FfXaLHdPWuGkFG5lKoU
         tUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xpxr3RAhQnlxdqPs5z2YzYADDLX6tSSmdU82c8YOdl8=;
        b=550TfboembyIYVSygHxlhxZ9EHhiDW4FXdvMmki3awPysczXDbbs7gv1gpBiXF0jBv
         AO+tj9sHHP4h1XlP6MlEbQ1bGfussCPGW8jWZ52X+yE7Vwu6yXNW37zGqg/mE6cnfjoh
         s9DWC6GRC5+5IAR067zLU4JMyJWcObU5s7bZI17/f4X7Z6TAp/1aRsNFhs2Il0cr018s
         6n81z+5u9XkcwqRfnr3Z3xUkFS7DmEKjaP4n8oCSDl/ltIeUywkn1iTXN4mAEg0jzEbO
         Y99S70219219CW24iRfxIoWZlh/H3xgmsiT4ZFfVdySy2sNlKCIEBNc8Ayh7g6poMamy
         8vPg==
X-Gm-Message-State: AOAM533fE3REdgTWWzIorgWshe6VZaNqxqvoe7+Yf78bdUfvU3B5kgew
        uAntj1iNjKUeLBU6klfcUyvL6+W55JJTXJAYnBnQCg==
X-Google-Smtp-Source: ABdhPJxjhHEWSfAEH8e4e9l4H6wkl5+PC3y6ZtbJ/AlfC9hhDDvEIEin8x4ZDCx/DB9pZtYLF4VUEwtpmqWYr/XH4F4=
X-Received: by 2002:a50:e10d:: with SMTP id h13mr10605739edl.77.1632867084648;
 Tue, 28 Sep 2021 15:11:24 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Sep 2021 00:11:13 +0200
Message-ID: <CACRpkdYa_patWBGC=gnVHkPQeo5BtvKrG2hzNKi3vZGvo5bKQA@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some few pin control fixes for the v5.15 kernel cycle.
The most critical is the AMD fixes.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.15-2

for you to fetch changes up to 28406a21999152ff7faa30b194f734565bdd8e0d:

  pinctrl: qcom: sc7280: Add PM suspend callbacks (2021-09-23 23:09:14 +0200)

----------------------------------------------------------------
Pin control fixes for v5.15:

- Fix wakeup interrupts in the AMD driver affecting AMD laptops.

- Fix parent irqspec translation in the Qualcomm SPMI GPIO driver.

- Fix deferred probe handling in the Rockchip driver, this is a
  stopgap solution while we look for something more elegant.

- Add PM suspend callbacks to the Qualcomm SC7280 driver.

- Some minor doc fix (should have come in earlier, sorry)

----------------------------------------------------------------
Basavaraj Natikar (2):
      pinctrl: amd: Add irq field data
      pinctrl: amd: Handle wake-up interrupt

David Collins (1):
      pinctrl: qcom: spmi-gpio: correct parent irqspec translation

Heiko Stuebner (2):
      pinctrl/rockchip: add a queue for deferred pin output settings on probe
      gpio/rockchip: fetch deferred output settings on probe

Michal Simek (1):
      pinctrl: core: Remove duplicated word from devm_pinctrl_unregister()

Rajendra Nayak (1):
      pinctrl: qcom: sc7280: Add PM suspend callbacks

 drivers/gpio/gpio-rockchip.c             | 22 +++++++++++
 drivers/pinctrl/core.c                   |  2 +-
 drivers/pinctrl/pinctrl-amd.c            | 19 ++++++---
 drivers/pinctrl/pinctrl-amd.h            |  1 +
 drivers/pinctrl/pinctrl-rockchip.c       | 67 ++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-rockchip.h       | 10 +++++
 drivers/pinctrl/qcom/pinctrl-sc7280.c    |  1 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 37 ++++++++++++++++--
 8 files changed, 150 insertions(+), 9 deletions(-)
