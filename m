Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64B238C4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhEUK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhEUK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:27:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6416C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 03:25:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q7so27587956lfr.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oog9kZJgpGJ5N8aQ8WVC8s7VGtvJFHDSbWmuwocv9KM=;
        b=ECjDFODKQMnIhmessO/4ZmF6bH9ia1QIPiL8Ylf1e3PyEqGL/bgsofLftVQG1KI3vp
         SfCD92bDE7cHsIBN4owKq+x94b/kjXJ5dj/+IKW+ynVJ1ZwHDbYnFePUeCLs5DWjGCHm
         4Z0hsyIflIR0Rj/jkLUV/Oir2aM8CJiEeFlamD0gR5LoRvFM32VrdIYwgaZlGO4p/WaN
         TaSfJpasa+trHyeAw8wVjeV/iSwy7Orq2vfHxVBJ6OGz7Mkqk1evEUaBd+W5KNyX7/Gv
         DisZ7GkV3ZsdHTj7yk0pvbYhehMUHpRp8H5rfikaauoC1UjPOlSSf0ZcPPrOYiP1ZAFb
         movw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oog9kZJgpGJ5N8aQ8WVC8s7VGtvJFHDSbWmuwocv9KM=;
        b=WasWkoiPjF1BCeZ+Kt5GjWs4n/sCgMoAUbiDmftwNxw1BchVaK7s5rRDgZhGR1U8RX
         9Xzu+ytD4N/7tsKimKluCR7oaOO58DQ+RQVizFirdzjH0lJgy1XG1fkUf5Uyyy1WuWfG
         LS2j4r4+Nrx3PREWIIdLl86Jr6aZOfmuyd9xT2Gjk6GqD5m3KVikTpUEyF97OiKrkZKm
         IxjjOSGnFbGJQXKRHHO2GoR2FW0mId8HV4LebcZ+wbVqbWYSY8IVaMgqDzXHzRiZcOlk
         Yx71gt7L3pTwUCd+B08CUc/8MDLnnLG6rZhyXgqdY4fAA2We4A1XO/Bul7Ovg4xNLDdq
         JNSA==
X-Gm-Message-State: AOAM533dtBwaQU9eLMlXYkpAwnVOlc7eT9fqH9+nLlYk8zI4YSUbEMes
        GzqeRcDAwSe1wPIOr0FkZe5c0mfD5UqWqLz1
X-Google-Smtp-Source: ABdhPJz9vlPNLZDJ6Gq9B0lcepjOxTYQXTmhPmNPy4UHSpDvvz1Q1K//2IhDzhNe3WPwCNldrDLy7w==
X-Received: by 2002:a19:6b18:: with SMTP id d24mr1739072lfa.103.1621592743078;
        Fri, 21 May 2021 03:25:43 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id y8sm597214ljy.7.2021.05.21.03.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 03:25:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.13-rc3
Date:   Fri, 21 May 2021 12:25:40 +0200
Message-Id: <20210521102540.104166-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.13-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc1

for you to fetch changes up to a1149a6c06ee094a6e62886b0c0e8e66967a728a:

  mmc: sdhci-pci-gli: increase 1.8V regulator wait (2021-05-10 14:39:06 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-pci-gli: Fix SD-card detection on Intel NUC10i3FNK4 (GL9755)
 - meson-gx: Replace WARN_ONCE with dev_warn_once for scatterlist offsets
 - meson-gx: Extend check of scatterlist size alignment with SD_IO_RW_EXTENDED

----------------------------------------------------------------
Daniel Beer (1):
      mmc: sdhci-pci-gli: increase 1.8V regulator wait

Neil Armstrong (2):
      mmc: meson-gx: make replace WARN_ONCE with dev_warn_once about scatterlist offset alignment
      mmc: meson-gx: also check SD_IO_RW_EXTENDED for scatterlist size alignment

 drivers/mmc/host/meson-gx-mmc.c  | 7 +++++--
 drivers/mmc/host/sdhci-pci-gli.c | 7 ++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)
