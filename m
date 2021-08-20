Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41AE3F3123
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhHTQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhHTQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:07:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ABFC061A08
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:01:33 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g9so12884754ioq.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SeHRAWquHTn4hGLpQjsJcxnYwY3Lu6w2QiJLnpMqNOw=;
        b=VkGzd/mYw2ewB6X0l3s7Qa1BcA3xgxV/9O62Y88d0q2q1fbCCTDxQSO/YfFL466rLA
         4YSbTQQKMbJwwtJAAM1+mUPeo7aoACvGfygD7xuxjVmIMQSPtesyau+0pIVq9EX0uAIM
         IQEYMWvHU2IgGAbhuU/bTnSHBFLzBUfaEAKqaD9x+9gT/caACHqzKvMFfsavmvx86MvE
         aJqblb1ZVaQVUIjsq38FilCMC3HF3iFDND7UeGvMOVrkM5+9fBAeTmCDbAhUd+3GAce7
         M7+fewihWraxndx8n2GAG5DIWpP/+DNRMq/E8Kfqb6f/cJ4Pdh+5d49le8ESfclSOJF4
         d+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SeHRAWquHTn4hGLpQjsJcxnYwY3Lu6w2QiJLnpMqNOw=;
        b=gj/43wWpxIbzPyOU7HoLr742VKuxr3319i0x1dfTNvAwkQDRq72E26tZdk7YkyH47o
         CcSTedXaGnJjCPCZ42XW0bLiNOQwcmN3ZMJJU5N7ZHjI8/glAo75cxvnbh+3bwshLlNI
         F1gUUY2dRndjX9ozbxcgCpVntKpHzLSt2WdCWK0GO3FTSi4DKzKzad6RnG3/SlcKfQb8
         AIip0gQG8JzmCvw48E2TqDG+TbQpuoqzZNci0csABHYSux4hOimYHQ6gRG3yoaJwCEGz
         NvVZH/CAdfhVXGLTUr0Ru9hCSfMOdAnNjJ1x9tBZUWB8iofGP3UHh/wdEmpU+Ku7VoDz
         hqDA==
X-Gm-Message-State: AOAM5326y2X5f3u4W9KZOnesnNLlmWlq7QLgSV9GDN6bgmaFJV+ozRSR
        wdIcVOKWzN0+bIl9qOhRTiitRw==
X-Google-Smtp-Source: ABdhPJxEryUpSXb0eR/hAZkq3gGR4Yk/Q+EKBaQjC9zkxmEO5fbUl85GV13NJee6IqFQBKsOt8JIOA==
X-Received: by 2002:a02:a488:: with SMTP id d8mr18090104jam.50.1629475292937;
        Fri, 20 Aug 2021 09:01:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a8sm3521317ilq.63.2021.08.20.09.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 09:01:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: ipa: enable automatic suspend
Date:   Fri, 20 Aug 2021 11:01:26 -0500
Message-Id: <20210820160129.3473253-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At long last, the first patch in this series enables automatic
suspend managed by the power management core.  The remaining two
just rename things to be "power" oriented rather than "clock"
oriented.

					-Alex

Alex Elder (3):
  net: ipa: use autosuspend
  net: ipa: rename ipa_clock_* symbols
  net: ipa: rename "ipa_clock.c"

 drivers/net/ipa/Makefile                     |   2 +-
 drivers/net/ipa/ipa.h                        |  20 +--
 drivers/net/ipa/ipa_data-v3.1.c              |   4 +-
 drivers/net/ipa/ipa_data-v3.5.1.c            |   4 +-
 drivers/net/ipa/ipa_data-v4.11.c             |   4 +-
 drivers/net/ipa/ipa_data-v4.2.c              |   4 +-
 drivers/net/ipa/ipa_data-v4.5.c              |   4 +-
 drivers/net/ipa/ipa_data-v4.9.c              |   4 +-
 drivers/net/ipa/ipa_data.h                   |  10 +-
 drivers/net/ipa/ipa_endpoint.c               |   4 +-
 drivers/net/ipa/ipa_interrupt.c              |   3 +-
 drivers/net/ipa/ipa_main.c                   |  45 ++---
 drivers/net/ipa/ipa_modem.c                  |  20 ++-
 drivers/net/ipa/{ipa_clock.c => ipa_power.c} | 163 +++++++++----------
 drivers/net/ipa/{ipa_clock.h => ipa_power.h} |  26 +--
 drivers/net/ipa/ipa_smp2p.c                  |  66 ++++----
 drivers/net/ipa/ipa_smp2p.h                  |   2 +-
 drivers/net/ipa/ipa_uc.c                     |  26 +--
 drivers/net/ipa/ipa_uc.h                     |  10 +-
 19 files changed, 217 insertions(+), 204 deletions(-)
 rename drivers/net/ipa/{ipa_clock.c => ipa_power.c} (72%)
 rename drivers/net/ipa/{ipa_clock.h => ipa_power.h} (69%)

-- 
2.27.0

