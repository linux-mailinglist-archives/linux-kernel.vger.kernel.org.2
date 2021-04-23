Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74486368EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbhDWIRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:17:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F36CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:16:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u187so6014139wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/r5EpnXaI5U7tlqfGBGqY3r9Ngvu2wCkl5+7uVuv3U=;
        b=PxTDZenHzMATHanoKADuLSrDnSMt4Z5DK0T1jiS4yfilAWdmuKo81Gf+AKflpDtJML
         R1dOos36ph+rNa/VFedWmAyqxLq6sJLLyIv277Co8szT8bg1FGS86UWypyqBpGlP7SKB
         5pg+NqSbHu/GQkA0PlDZY8LOvgWFmdA2FFFPzQz4I1ivclYLefDJK32lYkXmuQIeWCJp
         ZvBxm/Fm7UbQRvhrM7uPqNR45zsXToIXHtR7rnGyBTihmuu/PX2+cCRKQoald0j26qtJ
         r91zJn0czFPaOVeis2h6T+NH7D3sMxIbn3X9EpP1cwfp7YgoDiiW38wMayxxWm3ZwWgy
         UlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/r5EpnXaI5U7tlqfGBGqY3r9Ngvu2wCkl5+7uVuv3U=;
        b=oslplVkinZIl17/8+ngfLA83nFDTzoJjNi+AI+BfIgruAW3R1sqtaboZZ5azKJl/w9
         myb3QUp/OiJqdvjKaWWSv0a0Gy7I/4YGmHXMdgvzVxce1TNrp/OkKCEAApCBiiCfthAO
         VWZkzEdjSE1I2ficuNBlQBMEaYczh508XhyPrXwslv+B2fciDFE30h6qZxNWacJYm3JW
         voiOVR6hZtD3QuyGVu1OSm3tTU6pbP7l9PykqMYbdkYO9OSY4cWa+2no2aNS9PAotinv
         pIK8gyFDoYLz10HiouDsGqyglQL0t8aOumyyjXzXou2byQiXD0FC4sORBnEg2MKpJdsP
         tSzA==
X-Gm-Message-State: AOAM531JSwgVgMTKS2vbU4Q8o0LZazyId+lUY7geztEqrwe6sQHj0tU/
        kq7mWiKM/7TzOUV899NaaCFGH9tp0a0F1Q==
X-Google-Smtp-Source: ABdhPJzYXQrI+mNN2pnnY30L1/7Yk2xVdUuGRGuUcrA5EsX1qDCHZgHLi6RSe6Z15tA5egG8v8KJAw==
X-Received: by 2002:a7b:cbc1:: with SMTP id n1mr4270492wmi.50.1619165800032;
        Fri, 23 Apr 2021 01:16:40 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-149-6.w2-15.abo.wanadoo.fr. [2.15.231.6])
        by smtp.gmail.com with ESMTPSA id b15sm9665302wmj.46.2021.04.23.01.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 01:16:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.12
Date:   Fri, 23 Apr 2021 10:16:38 +0200
Message-Id: <20210423081638.16925-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the last fix for this release-cycle. It addresses a power-management
issue in gpio-omap.

Please pull!

Bartosz

The following changes since commit 23cf00ddd2e1aacf1873e43f5e0c519c120daf7a:

  gpio: sysfs: Obey valid_mask (2021-03-31 20:32:38 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.12

for you to fetch changes up to ddd8d94ca31e768c76cf8bfe34ba7b10136b3694:

  gpio: omap: Save and restore sysconfig (2021-04-21 16:43:51 +0200)

----------------------------------------------------------------
gpio fixes for v5.12

- save and restore the sysconfig register in gpio-omap

----------------------------------------------------------------
Tony Lindgren (1):
      gpio: omap: Save and restore sysconfig

 drivers/gpio/gpio-omap.c                | 9 +++++++++
 include/linux/platform_data/gpio-omap.h | 3 +++
 2 files changed, 12 insertions(+)
