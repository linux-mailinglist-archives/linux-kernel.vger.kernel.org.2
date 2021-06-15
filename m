Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D23A8692
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOQg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:36:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA70C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:34:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id p21so11693347qtw.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Mpw+juSO14IXhbnXmpjJ5EumNB+SNd/QTzAxRngqZU0=;
        b=OwnhgWRxhm1q/Kky0ungmqIcs6YMw4kIeYIvfOPX05tXnfCQYLcWlXs3a49hwczWfv
         sityG8ukLre/6ZvG7QtHKDeDW0ooyQVt/8aiyd3+EYc4BfNRIKEue/5sPcAuptTUGhp4
         gr/DVnKkm31xdIPWXTKOl0neJU53IAzQh8mz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Mpw+juSO14IXhbnXmpjJ5EumNB+SNd/QTzAxRngqZU0=;
        b=fbYon50ZBXj/VGYaSD51mKm2XU/dZVemnGYbvCtlZ3JjLIjwcibob+ZxZHFZCsh7RK
         7uNGn2h66Ciy4v3Fmhvlsv2ZdHjH+CeHo2fltIT8195MrNw/UPTSasC7OUbHBi4DZITM
         0kiqzK899nFtUBj//6iEgNZeuOFtb/gRCmRaVWoAXEyBbal113YTfUyr4lSJ6I+DFrKf
         9iyTG2P0gEHoCcWf1WKBKVp3KBFMVlpBvYmpHg2Y6pSPJZldtvjGtdFAoQh1EdYff7y2
         8iRaOFWuA8x0p/YojfGxBjV7sIDfmDRTiAxyN4sQBM2GycTuodf1NuuKXIGviOCyMWjl
         GOeA==
X-Gm-Message-State: AOAM531exrBNQwEjjFOucqU3xd77sh/tNumrPnmHOr+E6MMdmqc4KlNe
        dRd+HaY8XgXugeHhl53p/p7ZzKwArGhCFTiCbP5ndQ==
X-Google-Smtp-Source: ABdhPJyTt6WC6RRYHejEop/0hhJ8D7+6OUmp+FmVlPNOOZpIo46ZetWalSW1J1VyjP8Z9QFGNO88p7XWWl8nsCiAgPU=
X-Received: by 2002:ac8:7ed8:: with SMTP id x24mr500539qtj.148.1623774861742;
 Tue, 15 Jun 2021 09:34:21 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 16 Jun 2021 01:36:25 +0900
Message-ID: <CAFr9PXknSfSso6Uq0Fn_qJM5ZnJ4QK=YjJ32kKt4XYPrHK5x6w@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: mstar for 5.14
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

 Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

 git://github.com/linux-chenxing/linux.git tags/mstar-dt-5.14

for you to fetch changes up to 8f610169a2865f6c6383d966ebbd6814c79d0116:

 ARM: dts: mstar: Add watchdog device node (2021-06-16 01:22:52 +0900)

----------------------------------------------------------------
Romain Perier (1):
     ARM: dts: mstar: Add watchdog device node

arch/arm/boot/dts/mstar-v7.dtsi | 14 ++++++++++++++
1 file changed, 14 insertions(+)
