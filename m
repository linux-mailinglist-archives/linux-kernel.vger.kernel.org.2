Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654873A3D87
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhFKHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFKHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:53:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD914C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:51:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p7so7261530lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cuNXmPpzqFMD8TvtPMFEkUsp3qEPzEGNxmv7JPgaL4=;
        b=aZNBz3wjQ3bCk1aoPiSY3+mOUx5x9VV8dBiFQz46j4ZCz5nqZVQ4mPgmniF3i6af7Q
         IyTF7SbDpdWC1CyhitrZwlblRKTO/paLGnuCJuqSFjVkhPIG95C+3myB4Rb3dKtAb8kz
         96+aC1nUiQCzb3J+HvC34j40GR+HC/VcpxtIWQv8xuuwNwrjB9R6HzxgGJJPjpRvePl8
         UaLiG2S6nPrDUokW+PIwYPphpj2Owb1sp6AoRReKt+Wl4+OKbKcW7LevQzG90pwffW6Q
         4vuTqQtdHDter4AX62ZuObXLF6MkEvdb8E4JlyG50ZBPcgyyMIGviCIWYsAEeisjuJuN
         2DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cuNXmPpzqFMD8TvtPMFEkUsp3qEPzEGNxmv7JPgaL4=;
        b=WYzJ/6F5XcI8wp8SNA7EJbZGS2bd+Wq5KUMgSUHuv8JRJAkUJFjx42YK2KgBbuFYPV
         HbhVcxxhnPtmobuoQT9S/f2jP+UA5NnYBCAaUomfGwJagBinAdgbV5cCpRC2vEKvB9tY
         og7UcSe2o6vrrO5oQBVXLFusPuWCV2oPaEasewGIJR2IIUFwLlre3fI/QdhgVMsCh2a/
         x63ss8WQT3oLLkUtc5ErriLFZ7dzRUQc1PKQaXSqT+fPiCsiSST7QaCSseF65jVwj/z7
         TvTriGlvvv/rZAIgr3OAUGCjK7zCrr+c0CuLLDJNYxRmDEBcRwnYyDTslBZ0Xz8QuLYC
         0eTw==
X-Gm-Message-State: AOAM533xz8CdswCxVB5CngpvO48l1hxs9iBqy8YgjlZP/orlGJRjFYUS
        B4J7/WVVMBfGBGU0FsqC6HimaA==
X-Google-Smtp-Source: ABdhPJyP4OQaa36O2B2+/ZgQbDwBdwGzZD53zMHkIkyeWN5mM8PllibEwJ9EMRWbnrnA0rbiK5sCMA==
X-Received: by 2002:a19:6e41:: with SMTP id q1mr1843669lfk.409.1623397866001;
        Fri, 11 Jun 2021 00:51:06 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id j26sm227788lfh.254.2021.06.11.00.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:51:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.13-rc6
Date:   Fri, 11 Jun 2021 09:51:04 +0200
Message-Id: <20210611075104.153361-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.13-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc3

for you to fetch changes up to 6687cd72aa9112a454a4646986e0402dd1b07d0e:

  mmc: renesas_sdhi: Fix HS400 on R-Car M3-W+ (2021-06-08 14:56:54 +0200)

----------------------------------------------------------------
MMC host:
 - renesas_sdhi: Fix HS400 on R-Car M3-W+
 - renesas_sdhi: Abort tuning when timeout detected

----------------------------------------------------------------
Geert Uytterhoeven (1):
      mmc: renesas_sdhi: Fix HS400 on R-Car M3-W+

Wolfram Sang (1):
      mmc: renesas_sdhi: abort tuning when timeout detected

 drivers/mmc/host/renesas_sdhi_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
