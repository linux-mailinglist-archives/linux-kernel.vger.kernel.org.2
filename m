Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF13BDEB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 23:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGFVFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 17:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhGFVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 17:05:24 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A55C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 14:02:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso111857otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqllhjvy+JBsSCDAkjrZiAVB90dLi/AxPLsyAiU4K+g=;
        b=dk/DHZVzt8tIwEO+gChHOFOAVM7dUHMs3hVqeYDLYR9/gpHFnwmmOGevqCgyQt1VQ0
         No9uPR9DI/sbvNRPp34lm2eQDXBURHfspwU00EvPX5NZsfEE7ufyK4DCrcQnB32OyWY6
         rSJ+z1LcHcwmfV3sfzXVOfpPaRqqzrWuXtCbweFJqzalIg4QhV642KADVFXUQwmauTLE
         5kVKOtoGTvhxTuvazwn/6gSxQtdVD4fgds/jlAhFLQrsDLVubK4o2fPMvAiPc2X+/1aH
         +S0tAGsWErGO7R/yKkXAownJzdjkGkjYSDGBhOzM1LnWJkVkhLGI8ujak76MvfngEyuX
         VdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqllhjvy+JBsSCDAkjrZiAVB90dLi/AxPLsyAiU4K+g=;
        b=ivH/6DqAJtVlKRhx2HerMWVrPODVdkMaUgbbkLTlJW5hW8l8oU5KMsf9/ZgAbdd2/i
         rnycn2oB2GZBBRrjloprWQuZ1SSqZADPNP27ZQPhR+UGN8gNlr2W555wdqLl/TFpDeB2
         mYdTm0/cPBf4KpG3w31K77gXOtcp2Ke2ooxcCKAFhQGjh66mN/Z0T2dUQ/osI00hDI5/
         ED2psV1/9xvpHiyn3vo4St+Mgrn2XwoUtuXcug2u3YiYUQr7zzry+mXs/lqmZfotSndZ
         bs93QqSx/Uh2RS2hov8RpHW/vYpW4Aeza/1C0ge8pz8s8IYCaaafx+6RsGn8zEY/v29o
         /BIQ==
X-Gm-Message-State: AOAM533s+J7ad6xf/sZ0RBAVRBPqpYusIYym53ISAcJvTceXK1aS4810
        7klrY9gJkMdjkttqcFesqLnJGQ==
X-Google-Smtp-Source: ABdhPJzB16qrXoUTUZkx/sa7f5on0guLIeaNVO4uztaEqkXNOpQOxU4OYc0EwmwCIoPL3PWv6H+L6g==
X-Received: by 2002:a9d:7b56:: with SMTP id f22mr16165717oto.71.1625605365192;
        Tue, 06 Jul 2021 14:02:45 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 5sm3086988oot.29.2021.07.06.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:02:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Suman Anna <s-anna@ti.com>
Subject: [GIT PULL] hwspinlock updates for v5.14
Date:   Tue,  6 Jul 2021 16:02:44 -0500
Message-Id: <20210706210244.1229537-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.14

for you to fetch changes up to 234462bc7f2303afce4b61125d2107ecd7611bff:

  dt-bindings: hwlock: sun6i: Fix various warnings in binding (2021-06-14 15:54:10 -0500)

----------------------------------------------------------------
hwspinlock updates for v5.14

This adds a driver for the hardware spinlock in Allwinner sun6i.

----------------------------------------------------------------
Suman Anna (1):
      dt-bindings: hwlock: sun6i: Fix various warnings in binding

Wilken Gottwalt (2):
      dt-bindings: hwlock: add sun6i_hwspinlock
      hwspinlock: add sun6i hardware spinlock support

 .../hwlock/allwinner,sun6i-a31-hwspinlock.yaml     |  48 +++++
 MAINTAINERS                                        |   6 +
 drivers/hwspinlock/Kconfig                         |   9 +
 drivers/hwspinlock/Makefile                        |   1 +
 drivers/hwspinlock/sun6i_hwspinlock.c              | 210 +++++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/sun6i_hwspinlock.c
