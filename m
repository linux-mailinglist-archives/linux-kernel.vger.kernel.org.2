Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1763B2F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhFXMfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhFXMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:35:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D540C061766
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:32:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d13so7480363ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSWDVqAOh+Ag5QvJMiD9g+xY5O9tKZC36bQUG3SCwlI=;
        b=AyK1i/Hds9BUcdFDxiD15yeXufdfK1Q3svp2aMbZSxlTB4ye7gIlfdluRCnbOhc43T
         Tnzigg0k9aQed2xnZxdjbg4eAqwfeVUY7aGZAoD38xoU3B8agonKtI0t4LngLfAzrlgg
         VL1bMM/qOz9rJkpJnKUqvajlIyPe5l1R0abFlKOeoxssu5QVSN+AFGsPR8bA0RJlbmer
         A79pKUireUbr27xngyR9/+BbzI2/qynBchIXPEHbKCk5pOzKAOMokvWSAzufKU7ykDLI
         +0xlXqsw8atXiZvdWSpF5hq00ghFxrRSmydsOjJbhV3qLbVCJ4RZRWwg/uYW5T5dhnQh
         8v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSWDVqAOh+Ag5QvJMiD9g+xY5O9tKZC36bQUG3SCwlI=;
        b=T4ln+AeomxvAJi0/2vjF2kMylYJyq9Oxb7I1PNkbP06mIS7mwTzytqsi3ZQIGAA2oC
         dgUDAKYQwqUV+ecm+Ic4jeWhuva5yc3uWS8b/jwyBdl2HIb3c0Qy9FONnDc5t0/kSEtW
         Hmm8jBTn/HuI24YRfJzLH1Nb7iKmZJ2Wk8zgrAW574+mhUV5TI2RYZ14/PniLMeaG/p3
         QrOIG4lhiwhiqJKOodUDM95XskEloCNbpeB+2vxbSDTSrBPF/+fvrh9TImCN84Qg5Jv1
         NJuizjrhG66fbW5GSD0x6SDBhzcxYkUwk1dIazOMK99ci3sZVCDcmJjndPTcKoYM3BpL
         VuVA==
X-Gm-Message-State: AOAM530O/vgGMBFCSTyVJmz618FFOXIhnGke2ypEXCo0nUDISJ8P8sfZ
        7ldsQF+/e2u22kzPzCYWPRUCmA==
X-Google-Smtp-Source: ABdhPJw7e5ghg9iO+MSG0sN32yxoB2rCbgrLPRu2ehwGsu3zQoxfsaJ2AmI6kj7c/BJxTlFc90YD3w==
X-Received: by 2002:a2e:a4b7:: with SMTP id g23mr3764933ljm.210.1624537973013;
        Thu, 24 Jun 2021 05:32:53 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id c33sm278706ljr.85.2021.06.24.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:32:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.13-rc8
Date:   Thu, 24 Jun 2021 14:32:51 +0200
Message-Id: <20210624123251.191299-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.13-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc6

for you to fetch changes up to 103a5348c22c3fca8b96c735a9e353b8a0801842:

  mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk (2021-06-14 14:02:33 +0200)

----------------------------------------------------------------
MMC host:
 - meson-gx: Use memcpy_to/fromio for dram-access-quirk

----------------------------------------------------------------
Neil Armstrong (1):
      mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk

 drivers/mmc/host/meson-gx-mmc.c | 50 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)
