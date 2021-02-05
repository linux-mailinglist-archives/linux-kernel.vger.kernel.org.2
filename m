Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE1310C1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhBENsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhBENoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:44:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED312C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:43:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m22so9947594lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFK8g5npGo6KT2vcpZ9kyna9nxoUOzooDft4HkgHWps=;
        b=Yiq/Fil/DtNCYjqVSXEuyGuEa4fa9yWBd1Y457pD1zkGqiN9rVet9U0VKYW3a/Nbo/
         5Ni4ALFcHymOLZ1hjOv5HaDGYNJ3ciucSKa0v5b0KK0gVhbFeVI1ISg00PNwAWB9ItpE
         g2XUSoJKebS7NbKdGN8VEydXPTVBcS1DSMUeM1FLyF11WKTKIBK93y8sabPYtWPHIH70
         ZUgT11AmuvlKjMhQPnd3uDvcOXCvXX1TZB1NZW484D4CN4G9kNtngIlR2nF4tQqZFsxj
         I/1sF4n1MiWe/9qvDqEtj/QRaHNkwGVgX5Qp1jE9r4GISKwWo89KoxljT/FOin5C0zkW
         PZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFK8g5npGo6KT2vcpZ9kyna9nxoUOzooDft4HkgHWps=;
        b=twOHtwS0PM2CXzC3d0KiPIgTRrHDGcvxzUaiP5RkHiaMXObb9cp2jiYbr9bkoa/ZAz
         VY4Syj7CAcViNYPe8qCAooUAmK3OhDJBxIru+dO9owiBP+4Gs6mvvA9ZA/Iamxj1wGWx
         EjgXm7BfmDG8GL8W1jXdzRTVU2LnrdYpanUM6QoJNbP1g98ENbK0YmK+dFe3AB5KYwBS
         XvwiqsMCkwrPqBwyD8C/hdAKfuP54BN/r2C4SH58Z8/4QChKvcuA+dGKN7BQkzkVfUPN
         VRmXXthY0CQlT/A1utrftWV7sojkVbI1PUnlR2befktKin9CXXGp9SdPYVYce/skaRby
         ZGyA==
X-Gm-Message-State: AOAM533XW/WJDq9/2z1NDt8AFzgzf+AbGGSX9Ihi2Ue0grIeU/+4jh5y
        RjOgXHRkEP6qq3ByxLheXJy8k9T0c8TuBjFR
X-Google-Smtp-Source: ABdhPJzI9n4dZXUbn/oWEs34ujvxcv/UFKDjr2Xzc0c+koZN+jHC3fo+PCDrXD8drL/b2KgryKZXMg==
X-Received: by 2002:a19:7f17:: with SMTP id a23mr2839628lfd.594.1612532628508;
        Fri, 05 Feb 2021 05:43:48 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-179.NA.cust.bahnhof.se. [98.128.180.179])
        by smtp.gmail.com with ESMTPSA id h7sm1031978lja.94.2021.02.05.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:43:46 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.11-rc7
Date:   Fri,  5 Feb 2021 14:43:45 +0100
Message-Id: <20210205134345.117659-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.11-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11-rc6

for you to fetch changes up to d7fb9c24209556478e65211d7a1f056f2d43cceb:

  mmc: sdhci-pltfm: Fix linking err for sdhci-brcmstb (2021-02-01 11:13:09 +0100)

----------------------------------------------------------------
MMC core:
 - Limit retries when analyse of SDIO tuples fails

MMC host:
 - sdhci: Fix linking err for sdhci-brcmstb

----------------------------------------------------------------
Fengnan Chang (1):
      mmc: core: Limit retries when analyse of SDIO tuples fails

Ulf Hansson (1):
      mmc: sdhci-pltfm: Fix linking err for sdhci-brcmstb

 drivers/mmc/core/sdio_cis.c    | 6 ++++++
 drivers/mmc/host/sdhci-pltfm.h | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)
