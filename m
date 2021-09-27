Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1F441A138
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhI0VPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhI0VPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:15:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3111AC061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:13:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g41so83044119lfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=StkEwZukQIXbK1uuB3PfKHlHFMrtoXm8L/aNxJSj/hI=;
        b=RKYGFrdRGUY0Qr4PrQoA7DMKX7/lPkgHNsgatrG4a4+upKxYnI9RUCkzF2W4SC8OSM
         /bPbvm3yhSi1Ya1CWbiyJiQLV7y1tbZm2WjnakYCf00rhvgCMJOPpvf39D3PxEEC/ExW
         b0tRnT3yAPubfdQTf7dbw5P0j6l1RwO7Bh1biJ1IuLAk5CyOYbeWeWbKDh4+mSoDYliM
         2KnoyUqKcFUHdEm0fG+WtbbS7yiKi5w0MnFzG+Eoo6oxsZnLmr6M37W6K7NdDCtm6zAz
         8ZRnTq0fOlKHvltoaXSRd/DQtuVSFcq03kyh2Qk6htu2dMZxOjUvxFcpEGoal31V1zkK
         JjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=StkEwZukQIXbK1uuB3PfKHlHFMrtoXm8L/aNxJSj/hI=;
        b=xt56ZI/w3WIMJ0O52LBH9OO1PodTld/vBx/IPRkVFoed4MHL+B2eUPjYf5khezyeq8
         30cPbSkK41gQhxfEFb91ZyTT1ED4lhaivBPM227BRWKl9W6xiPH1d/xnJTowngawSF6L
         dsh6tGdekvOUjfWDcdQmv4imsJtwEaS5bJkS4dzdFcTxbPeY0Lxqm7IaKarY4FBSLB2p
         fasl9S+ShS59mxDjASGrlAc5LotWbnxWirqBGjMlsba3a9IRu/G++8EtM7HgAhtB5vp8
         EWQtuu1k2/b4wN8dyh2PmAd/dX8WbGa1WehIZZ4KDRLxUPuTDAD8EYrBxqJfVEUN0HOs
         1RbA==
X-Gm-Message-State: AOAM533aYEe1QKnkkyQUZmuVf/ul0RarLsDTvjMsPZtCJNbvuvk6X4Wf
        avGpTKcnOvy1QLYNf//5m2IBMg==
X-Google-Smtp-Source: ABdhPJxsGvDOsHqzStbGibFeaveUORepFkw5kE7+/rNCfQBFIjMTzwvhwTl21th2x6sxeU3Uu8zF5A==
X-Received: by 2002:a05:6512:3e03:: with SMTP id i3mr1995773lfv.374.1632777235106;
        Mon, 27 Sep 2021 14:13:55 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id t12sm1706864lfd.112.2021.09.27.14.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 14:13:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.15-rc4
Date:   Mon, 27 Sep 2021 23:13:52 +0200
Message-Id: <20210927211352.21266-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.15-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 27151f177827d478508e756c7657273261aaf8a9:

  Merge tag 'perf-tools-for-v5.15-2021-09-04' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux (2021-09-05 11:56:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-2

for you to fetch changes up to b81bede4d138ce62f7342e27bf55ac93c8071818:

  mmc: renesas_sdhi: fix regression with hard reset on old SDHIs (2021-09-06 18:10:49 +0200)

----------------------------------------------------------------
MMC host:
 - renesas_sdhi: Fix regression with hard reset on old SDHIs
 - dw_mmc: Only inject fault before done/error

----------------------------------------------------------------
Vincent Whitchurch (1):
      mmc: dw_mmc: Only inject fault before done/error

Wolfram Sang (1):
      mmc: renesas_sdhi: fix regression with hard reset on old SDHIs

 drivers/mmc/host/dw_mmc.c            | 15 ++++++++++++---
 drivers/mmc/host/renesas_sdhi_core.c |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)
