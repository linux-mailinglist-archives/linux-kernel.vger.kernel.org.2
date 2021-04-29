Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA936E93B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbhD2K7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhD2K7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:59:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B78C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:58:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k14so16497832wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N22HpYWXUzBgK+T0RJEQQdoyzlJYcc1uUBLY1VBnpyY=;
        b=wm+9EZRDEj76bRf5XfYHJE+tul/xFGbN6ELREbBcUsjT7MWScuKHKhq5KqyPXc4fmT
         Qj9/P0VePFfhoYb1yrhZIMfxs07QWa3UAh6WnWnTx3rPzFeb21vLGb7VVkruJNXRlXZx
         xMa0ekRwupMBwkjKcagQGGlBPKdd8u04uqiMGwDAnDs2x74bT6VBrLOvWBp9sPHOBVeB
         eHioJYFIvX7OnVcZok48Yo2csCos8nksL3VrS1UQ0lzPgwN1EkqijDIBtU3D1plMcS39
         vyDVLYyezMUo9Tofc2jcLLs84383y7TBRiivsnLsRwuVym6cqalszGOc4L5a8KzHdPvU
         GZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N22HpYWXUzBgK+T0RJEQQdoyzlJYcc1uUBLY1VBnpyY=;
        b=KATE64KnmgrxNwZe7+T4ILTPW+hAI6o+uUbhJSllsrpvPto1LCqGdDmT8VPCHv/yen
         Lf6W55/CDQIaq1YBet+doNB/OmGjCzqrORnMZklGP3/aGI6QtQ5ci0eud6FyKEsOg1ek
         tUZOLxD9DU//STSl0/PvAu9kRoBh9yXUmFIle9d0iwEhSwHePdyZh+iJi2Do4dClowxX
         L6RjshKpQOYMdp+9CZyoxM0V7ycJ9vlMshHMwnrqbwSXg8kCV5+m5nh7WK19NgyaMv5I
         zajGWWp+8nSOGYPCUH/7M2OarKJDSWNWliHticjf/wOt0DmiI2wkP7C//jSd2Woee2cU
         LOLg==
X-Gm-Message-State: AOAM5323lxSzPC5V2W1BPu8Z4KQoZPpYOl+aV/5fzJZIeUHqGxm+xynX
        18YsgLBG4oFrBza9ySYiSCuwQw==
X-Google-Smtp-Source: ABdhPJyqhv4JL4izT6rVt/yzDldPItU1j0UidqdkrgOMSN0zyV+sapSMoVpnwc65V0jgi/6dudyyfw==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr34715750wrw.142.1619693900443;
        Thu, 29 Apr 2021 03:58:20 -0700 (PDT)
Received: from localhost.localdomain (hst-221-29.medicom.bg. [84.238.221.29])
        by smtp.gmail.com with ESMTPSA id a9sm3372903wmj.1.2021.04.29.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:58:20 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/3] Qualcomm custom compressed pixfmt
Date:   Thu, 29 Apr 2021 13:58:12 +0300
Message-Id: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds two compressed pixel formats used by
Qualcomm SoCs to optimize interconnect bandwidth.

Regards,
Stan

Stanimir Varbanov (3):
  v4l: Add Qualcomm custom compressed pixel formats
  venus: Add a handling of QC8C compressed format
  venus: Add a handling of QC10C compressed format

 .../media/v4l/pixfmt-reserved.rst              | 12 ++++++++++++
 drivers/media/platform/qcom/venus/helpers.c    |  4 ++++
 drivers/media/platform/qcom/venus/vdec.c       | 18 ++++++++++++++++--
 drivers/media/v4l2-core/v4l2-ioctl.c           |  2 ++
 include/uapi/linux/videodev2.h                 |  2 ++
 5 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.25.1

