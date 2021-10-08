Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE842662C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhJHIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJHIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:47:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9CDC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 01:45:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so36107824lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kt2zeS8aw7UOEZ6UIIHWzjYYnKYswwjSSwV1Raxj+m8=;
        b=fTfPNAJ5Cgq1rDMNmAMyd5mDbrysDz/ytlWtUV45dO3zjXDMHMp90D5WNdtSMFyek7
         JoXip2UNiYzW6vU9UEoYArzBXBTu8Idi0B19hue3jzH5Ii8rkR8QJkvDrH0auuIDhqTm
         +QsHn2+DDmuMlWEsrcmZz22zIj1/sgIVSroD8RzRE2JjvPWoLOa0hvSDLQz0mL2og7Zq
         eKId3iiMm+kql6bK6BLyM/XH25r4zzpK1ibfffX3K04w4kvlJnGj14BFkoj0bneeKngQ
         e/tRPYS4i+4pAa67dBMvB8Km+CUk+FZVewgAgXfnkbY1A3YTG+SFhkLpFbsAIlgd3Y4J
         h/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kt2zeS8aw7UOEZ6UIIHWzjYYnKYswwjSSwV1Raxj+m8=;
        b=mmYCgNtHP9eV114fDF4k2mK0yroN0HEY5wmsGxd/vy8atPyraQViLauxPwptW7CI+J
         sLJhUIeGyTEn4tmP+4KjCPoaKWqstxTsy/xh5o5MktTF9/Z2Vm47WRFHZsU68XOcv4X8
         uOc0G6bmUzT8RIltxD2SZEKP3OAFAVmWsqUY38lk6oTampfjh0zXMbOSUglTUiiDml5U
         nTZZ7sutEh+qWAxMSmBrBjANiDK16nSt6IWtGVYM96k/nLYMp11YBJXeUJPmm8YFMv1s
         1b5JTkG0Fb1GEyk4+4BiM9QB9iGxfzGinFJQTVnixz6Q+xFpCUg1mTy2orvtFyR+T8CC
         RIOQ==
X-Gm-Message-State: AOAM532APPIG2Le44fvTIy0MhO3yWMne24XBxf4gN+IItCylJS+Yy7E1
        yzKPQceqWrKOJl2qdP1aZcZ50N/ak1EkHA==
X-Google-Smtp-Source: ABdhPJwrtpQdAJ79EajjX9Yv8er2FlDFohRG70iBpVkmrPgMcTjYV9LLJ/a3T2xsfVopSXy3NUB6iw==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr2205874ljo.326.1633682700097;
        Fri, 08 Oct 2021 01:45:00 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id h2sm186649lfe.134.2021.10.08.01.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 01:44:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.15-rc5
Date:   Fri,  8 Oct 2021 10:44:58 +0200
Message-Id: <20211008084458.30104-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.15-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-rc4

for you to fetch changes up to 8a38a4d51c5055d0201542e5ea3c0cb287f6e223:

  mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk (2021-10-06 17:23:28 +0200)

----------------------------------------------------------------
MMC host:
 - meson-gx: Fix read/write access for dram-access-quirk
 - sdhci-of-at91: Fix calibration sequence

----------------------------------------------------------------
Claudiu Beznea (2):
      mmc: sdhci-of-at91: wait for calibration done before proceed
      mmc: sdhci-of-at91: replace while loop with read_poll_timeout

Neil Armstrong (1):
      mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk

 drivers/mmc/host/meson-gx-mmc.c  | 73 ++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci-of-at91.c | 22 ++++++------
 2 files changed, 70 insertions(+), 25 deletions(-)
