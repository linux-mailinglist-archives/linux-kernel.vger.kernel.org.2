Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62442F4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhJOOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240077AbhJOON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:13:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C57C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:11:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so2508598wmz.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Er3WiMyf17c0WY4AO4vNjbmHxPQdkdtX2SYw/tzJ4Tw=;
        b=nR5HWzmAsjCJD9ODhBtDt3y6oqRpgGprk/5xLr2UPVtU2heGvxseRGBWlJk/v5Bt0f
         ZhqEWvPvmUiZymr5y9D/M7N3bEBSogIfgHmDgxSJwgRYaSGonLb/40K/Ff93lgi8qcby
         4gSs1oHYhcKY1PVZUtymSvAsw/XWnZWZ1rnJzMuhO92R3SibtyxtejFd96HekOzR8jCn
         8PRcyVgOEOMRK4l/DxIYmoBk+4JnilAEM9Av3yIjVsBmtWTrW2+0vhrrWgARoZ5eomSs
         93PHWKI5mcBFp6ImL/EdqwQesDT7jImC0bKvwsjlV0VndfYHfuTLW4ZAZJI8CNwDL5w4
         RZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Er3WiMyf17c0WY4AO4vNjbmHxPQdkdtX2SYw/tzJ4Tw=;
        b=vUD9bP/yQ79+aVTbb96cb6Wk7HHnoxmHHwGirgf9h/yZQz/OAJY+4IcVYJs+taBTxj
         G+idPMXBgictwGC4gBlOVehjMXkRzONZOfIDJe2l65tQs2JfA+5IQYDFA9Tm5KSDsDNJ
         xJZiCfANd86M6b2AjySAmtBizXOF51q9YLp1DRk799HhVPn9oEtL1gTIjqw7blalsU0P
         /PtOdR0xnL4EyU0RTPZcp19/8klMiVRs2pK5a4bhuWlgoKzjdYGGqiecrDed7q05U29o
         oG1Su1OULPWehKjD/8o3gPiA97xIWu7dRVr0U+DKUs4HZLOZWEG6MimfLRyksLG7/R2d
         /+xA==
X-Gm-Message-State: AOAM532+9Bq8Zk5zwhSIaAaKoAG2UJCCU81OQjjZ7j2dG/LYgP+0av0M
        QmwM3CDLT/lOAxyekqBqELahXj5NhLlxDw==
X-Google-Smtp-Source: ABdhPJwyIbVf187jUvsiTcIXNn0XqSnzRXM1CqrDJkl8XcjfP478xbdHT9w+WChIiBS3Ervp3IbA3Q==
X-Received: by 2002:a05:600c:a43:: with SMTP id c3mr25776973wmq.193.1634307074986;
        Fri, 15 Oct 2021 07:11:14 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id o12sm4975125wrv.78.2021.10.15.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:11:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.15-rc6
Date:   Fri, 15 Oct 2021 16:11:12 +0200
Message-Id: <20211015141112.23965-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following set of fixes for the GPIO subsystem. Details are in
the signed tag as usual.

Best Regards,
Bartosz

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.15-rc6

for you to fetch changes up to 6fda593f3082ef1aa783ac13e89f673fd69a2cb6:

  gpio: mockup: Convert to use software nodes (2021-10-06 13:04:04 +0200)

----------------------------------------------------------------
gpio fixes for v5.15-rc6

- fix module autoloading on gpio-74x164 after a revert of OF modaliases
- fix problems with the bias setting in gpio-pca953x
- fix a use-after-free bug in gpio-mockup by using software nodes

----------------------------------------------------------------
Andy Shevchenko (2):
      gpio: pca953x: Improve bias setting
      gpio: mockup: Convert to use software nodes

Mark Brown (1):
      gpio: 74x164: Add SPI device ID table

 drivers/gpio/gpio-74x164.c  |  8 ++++++++
 drivers/gpio/gpio-mockup.c  | 21 ++++++++++++++++++---
 drivers/gpio/gpio-pca953x.c | 16 +++++++++-------
 3 files changed, 35 insertions(+), 10 deletions(-)
