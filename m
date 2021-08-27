Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3FB3F9B11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbhH0Oo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245257AbhH0Oo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:44:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2CAC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:44:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y6so11887940lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v52QZkpY4n+cV/XLVWZo335UUADqwiu3OoMdlE8T1G0=;
        b=MA5EhrHLuaH4soIsG+FjrQfbMRjujsWWapB4OvIk7+0oPoQhCJ6Tfa5NqUKWjc0nRk
         hdso7/dmQU+2ox7dy3x9Gsiea7eCJsprvIHuvbDHXLSpXNnLnAdnEbJocyHA7HbU/6Rk
         oKF4YT/gGliOn3++NbGTB7NSC8lSbR47Z3M42eOwJpl+NvAHUVGb0QX+ULYVin2xlCh1
         o4qAdHmu8z0kGP/vipunEGqwOBcjitOIDnJKt5w2ReXXC8VplxS+TiL+1XYpgxeshBKr
         4ul8UfKc2Cg9i4k4GVCWvQMOi9gv+hFMlG5OBaPDxEiY1InytNsKCp+sBPDGmC6NvieW
         unrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v52QZkpY4n+cV/XLVWZo335UUADqwiu3OoMdlE8T1G0=;
        b=Nmt0JKDUlXY/zdgt5RdgcpMasltuj0jGkA5Gd00dLyJOI7VGnljgEZP6iLXsPr3z+8
         5Vn3m/Hn3Vf/ezbzMB1gwZgeLFqWq4ihRz+jq91eRtUuyV2hGwGiNLCLPg9ruOHPxnt7
         Fd/9MJEDiDq3rFa3gGsnp+3aplsuFOOr/pBf723aklXLhrGpQjR4NqMeA0Ia8MdcweWr
         DcvvL41R+viRro2DYK75WXt5HXtah9D7FgHEc2ibuedZ5gXEmSoBZvfNew/42QGIGNml
         xg3e7mHpJCYcFzsB4MbhHT2BmcNQVdwCTI0gb1QMbw9vEs9cheeAJwB8YC27Tjgu9FtQ
         5MCQ==
X-Gm-Message-State: AOAM530tNZnYfpjP46AaSqPfaA2V+AFC9sIdVAFJRXIrxabEggmrTA1O
        WuBdFdT9ETa3RUqS4vD+vC94lQ==
X-Google-Smtp-Source: ABdhPJz/pC6PxLJLjwDo1CKl9k0B9oxjcQy7Ew22/SblUo2f7nWH9cxSLaYmeAabGjMt2q0KnFjmBA==
X-Received: by 2002:a2e:a7c7:: with SMTP id x7mr7947424ljp.406.1630075446506;
        Fri, 27 Aug 2021 07:44:06 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id 131sm702781ljj.52.2021.08.27.07.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 07:44:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.14-rc8
Date:   Fri, 27 Aug 2021 16:44:04 +0200
Message-Id: <20210827144404.504978-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.14-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc7

for you to fetch changes up to 885814a97f5a1a2daf66bde5f2076f0bf632c174:

  Revert "mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711" (2021-08-27 16:30:36 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-iproc: Fix clock error for ACPI rpi's

----------------------------------------------------------------
Ulf Hansson (1):
      Revert "mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711"

 drivers/mmc/host/sdhci-iproc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
