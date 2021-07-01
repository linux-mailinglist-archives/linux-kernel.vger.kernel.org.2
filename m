Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E262E3B8F20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhGAIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhGAIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:54:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956E0C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:52:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z4so3265532plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6W/gfONsUZrNXPhyPqnFqKh+3w6fVEWhg1g3hpovGw=;
        b=p4s5qHxDA5OZ53mahGIgaTOPINm9xBX4mqw7jKAYUFfRfusCt7aIFUn1VNTX6vxSJm
         Xv4N65H+ZEkv0tpZwmHSrh+T3QxgiIcnlhmeY6x8ZaP+XfQ/eBbCVHJJPQJgCH0n4a1/
         PNG56ixVB/SPKtn2x1oASjvo2HM4WmQxalCELH5jysvf7MAvKc3b0D9FKyzO72/RKXPT
         Ri47kaGUh2OzLPN7ZuK5m1p6Xqb71UEaQ+xVyRebyD6UZgiZkjTzxCG32p3yBLWbiWWC
         GJncIp/4urTrHSrv0HyGrKSw+0kd33D/r7KrmvMb6VA4OPWjdOsts5TYuN3l0BGJfMbk
         VIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6W/gfONsUZrNXPhyPqnFqKh+3w6fVEWhg1g3hpovGw=;
        b=RYqCaZL/Tl4BOa/LjZ5rbQ5COI73aM7tx7+mcuGgI6qPLuLKDXsd4r/WtciNq7Jvk6
         h5jXmgH1gVDztQL1EVjzdse0BuNmdNEAmk2juKPV/3s1PWi7DQg+bQFgI/tlEzYNYEkS
         ni59rUiYATQ4/wdagvU3wrLrARgXwYhonWNai/EyMf2Uqc6HCUfrRRnQvtxU47DTpInC
         4HslzAtDDQyg+GEeI4U4IKreYlk6IkAZODIbvg0at7+Ub5x1UXRK5Fzkl/aWpDhy7wJx
         T4XlYyIQH/6JOEkfm8odGujSGEmtPBbJFJfqRys8a4OdxwDnZWMth9rgBjYDFe+Bzqyf
         DmLw==
X-Gm-Message-State: AOAM531rAJVFaLmF9ZrgpvBg74yJsNEC7ReQBP/hj23liEJb2TpodroD
        TOtg25OrQjsuBUWxUGGwmtA=
X-Google-Smtp-Source: ABdhPJxsk4G5boQsMNvp0tUKtEmugKGGscDqRMElhfAcRt0j9c25YnzA1MWTzF4bzb9jMFp+8WnMbw==
X-Received: by 2002:a17:90a:db16:: with SMTP id g22mr44256605pjv.111.1625129531128;
        Thu, 01 Jul 2021 01:52:11 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i27sm24926973pgl.78.2021.07.01.01.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 01:52:10 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add module build support for timer driver
Date:   Thu,  1 Jul 2021 16:51:56 +0800
Message-Id: <20210701085159.208143-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patchset was based on the previous one [1], and add a few
boilerplate macros for module build purpose according to comments
from Thomas Gleixner on the patch [2].

Also switch sprd timer driver to use the help macros for support
module build.

[1] https://lkml.org/lkml/2020/3/24/72
[2] https://www.spinics.net/lists/arm-kernel/msg826631.html

Chunyan Zhang (2):
  clocksource/drivers/timer-of: Add boilerplate macros for timer module
    driver
  clocksource/drivers/sprd: Add module support to Unisoc timer

Saravana Kannan (1):
  drivers/clocksource/timer-of: Remove __init markings

 drivers/clocksource/Kconfig      |  2 +-
 drivers/clocksource/timer-of.c   | 30 ++++++++++++++++++++++--------
 drivers/clocksource/timer-of.h   | 24 ++++++++++++++++++++++--
 drivers/clocksource/timer-sprd.c | 15 +++++++++++++--
 4 files changed, 58 insertions(+), 13 deletions(-)

-- 
2.25.1

