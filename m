Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D23360B33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhDON7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhDON7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:59:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:58:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g9so7394035wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVGfVGRf2lqFdi9u95Ww6kE/ExzJlYdE+7z23VB8v3A=;
        b=Z0jka7QMeObS2sH3XYnKMtcZ4M+L2HZkoTx+uQNaVYN+nTnBXgs0fEYg6T78vU3LFV
         qDZpyIW8TOta+/kYslVbnTPjvmjtqpXiDY1XCMyqpMbiwVqdXAj5vDjeadNyS7e+NZGa
         jLq5NZNngaZTTrcFqDuHveX3Q+DiMr977bfSZOiK3aAsuKsaS+hfmclUOcEncXJUY4/W
         MQ1Fb5QnEPB71KFqwhlkQXi5XFVOX0qdj6dKiTvlnrC+sCnCauNVpAo3tukc4z8M/03v
         lU/nq216h5ALBhFThVMbM/Om0t7BSMcjGKX5NWdu2+tUpggoHAtggXK9IY0oKiGKyy8k
         gkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVGfVGRf2lqFdi9u95Ww6kE/ExzJlYdE+7z23VB8v3A=;
        b=sw8tn4ChQqEzzKnq2X4l6xboPMRESJ8EXVarOZljO2Tw0NVTKcsxKqv4YCdzLS3tEw
         rvZ9LQrLhZYIWy2/6Je4Q75u+q+IxuuSo67mrWXSeZthAonFeiSJXg6cfeGxMPuMSmfT
         aPAF4wUr0vj5r2b5ee/vJOdGQi8WgTNE+abI2irS+tmwdPGzU7M1mzO/LCEaDyyPNT0E
         E67VRas+Fycsp3HiAPk/qg1CRf8KWB0mKAL62MVRWJ6YO+ayuugSt0VwjDvj9jFB8Kgx
         JGFPUvL6//j1/T9Kydj4xcrpNS5gMtzGMv7k5VV3hyqXeKSs6/DdKHTc48i500gcrIXY
         6AgA==
X-Gm-Message-State: AOAM531+WK0o8l9t3xf9AUb4/75AgVN9nVMSuFCU3L+08OkVbyMLHabx
        r6KiQriIQZuLcPP9jCFfGzqO8kvt+6gYrA==
X-Google-Smtp-Source: ABdhPJznICyWykrJyWx5i+dcomhTZnr4iAs69us/lf2jyAxWRzIkRsbO6Uykej8p9dT1E5Eg7kN5XA==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr3650522wrq.20.1618495137577;
        Thu, 15 Apr 2021 06:58:57 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-286-103.w109-210.abo.wanadoo.fr. [109.210.101.103])
        by smtp.gmail.com with ESMTPSA id e10sm3105582wrw.14.2021.04.15.06.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:58:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.12-rc8
Date:   Thu, 15 Apr 2021 15:58:51 +0200
Message-Id: <20210415135851.27595-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I waited until late with this non-urgent one hoping we'd get more fixes for this
release cycle to go with it but nothing's coming up so please pull this single
fix for an older problem with the sysfs interface.

Bartosz

The following changes since commit 6cb59afe9e5b45a035bd6b97da6593743feefc72:

  gpiolib: Assign fwnode to parent's if no primary one provided (2021-03-16 10:18:08 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.12-rc8

for you to fetch changes up to 23cf00ddd2e1aacf1873e43f5e0c519c120daf7a:

  gpio: sysfs: Obey valid_mask (2021-03-31 20:32:38 +0200)

----------------------------------------------------------------
gpio fixes for v5.12-rc8

- do not allow exporting GPIO lines which were marked invalid by the driver

----------------------------------------------------------------
Matti Vaittinen (1):
      gpio: sysfs: Obey valid_mask

 drivers/gpio/gpiolib-sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)
