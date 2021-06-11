Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37D3A4995
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFKTrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhFKTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:47:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEB7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:45:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o3so7192986wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDb8810oCpif6zfap6uDGjWQYilNRwSbod8qRYyAGqY=;
        b=sm1qDDyZtvVhi7pxOR6SBwLAfGjtZVmohr8bg7GIfjQGrxxlhIvj6re5ywBsNtY35S
         bEi2bfXOJJiPHD1WomKlzAb2t/YX6tOPykqpwSHpoaDg2DJHhpFB3tsU1Bf84jR4NCvJ
         0HCiuCkzQVJEeXg6NcEIvpEFEmsv5LIhtHkxF0kvjovW/aPS4gjS3jCyd5pe7iWqHYyP
         pSOh8QhaoITBiWwiVFcB4ufXN8bz7icnJFTW2IdIvx9RHBI7nTNZkK9+696IhOYq7gRw
         lVZkw4+Q4B6Wt2cs8ceMKZMjpZsmXjiOZN5ShVFJJel78YrE0S14Cm0TbI8ZK8FIs+Et
         cmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDb8810oCpif6zfap6uDGjWQYilNRwSbod8qRYyAGqY=;
        b=V9MOp9z7ii6ZWm7iPO3K9OJ8CigmsXav8MO6xKZ1NBTf/tYXvt7meSta2LnoTEFHvG
         g6LwZ9wdFfJAiBvRx4UYsY0sw5Q6rO5xQlbqdbSZ+TiGw6C8o1raA8lVUDTNp/QSbqqa
         59n0ODcLDpX3VP9ndbvldkK0+5AuXMHfaWS/45TxmAz9tfLrlLicQ/QfsWLIZ1f0EZb9
         FshOtCRx81F/uHK0RWOWHnwGnUsACfG6xTriFNK+NE+qPiqMtbA4P+h99UNxySj5/WPH
         LFsnOt6ALpCZ1Q/TZdEILWQCIHMdrPimBEXeUCCHJIkcoRzsRlP+yvEe1ZYhG7lT1ZTR
         WwsA==
X-Gm-Message-State: AOAM5316ryZ9h7ZxNGUGnKJmhRerkX80QEq5Gdn3EfMXEG1RMZh7wx8m
        weMpwEmXOccpm5gW1SqEVX0fFw==
X-Google-Smtp-Source: ABdhPJyS8qi/lr//hImDA5gRkv1QtJeYyC4mULN69ifLVC29Qbyr6KPVtV0ZFfDMkk9HJSobF8hqmg==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr5719112wrn.48.1623440734939;
        Fri, 11 Jun 2021 12:45:34 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-149-6.w2-15.abo.wanadoo.fr. [2.15.231.6])
        by smtp.gmail.com with ESMTPSA id u18sm6789431wmj.15.2021.06.11.12.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:45:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.13-rc6
Date:   Fri, 11 Jun 2021 21:45:30 +0200
Message-Id: <20210611194530.15593-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following fix for v5.13-rc6.

Best Regards,
Bartosz Golaszewski

The following changes since commit bdbe871ef0caa660e16461a2a94579d9f9ef7ba4:

  gpio: tegra186: Don't set parent IRQ affinity (2021-05-12 13:56:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.13-rc6

for you to fetch changes up to dbec64b11c65d74f31427e2b9d5746fbf17bf840:

  gpio: wcd934x: Fix shift-out-of-bounds error (2021-05-27 09:51:35 +0200)

----------------------------------------------------------------
gpio fixes for v5.13-rc6

- fix a shift-out-of-bounds error in gpio-wcd934x

----------------------------------------------------------------
Srinivas Kandagatla (1):
      gpio: wcd934x: Fix shift-out-of-bounds error

 drivers/gpio/gpio-wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
