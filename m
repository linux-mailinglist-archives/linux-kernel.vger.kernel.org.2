Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6C308027
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhA1VE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhA1VEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:04:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:03:42 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id q20so4821060pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WONUXtOBA+aimidJBvuVmUVV583MRFRwJEB2kxrPYs=;
        b=YBojJS9p5xbUaHKy2Lz2exq+I/GlOwWsVyMzlakgcN5k6/BM6757RCUFuEhsw8dCfB
         9UEEpZeZj1zog1T/mkmttEZM8l3dbQVyYDv6LBQdB/UPJOe03VCWXD5VBq0BRQX4KiLH
         ma3VCoVUws7V3pu4w1LfWsKEv02ZUmn/UfmGg4GY77V1wJvPlaOdIRlro9d6Dp9PopvF
         kM5Qmt/lRx5kDPtA06kkMyG3RDp0Pu3B/eGPIRRA9JzNr98Sey/KnZuJbIt1nh8oIh5l
         SHsqgSF3FTXSJpCCzOoNGuU48b99UVXx/HwVY7lwCRKEnfBuDbIIZ09OjEDuXF+ikVee
         C3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WONUXtOBA+aimidJBvuVmUVV583MRFRwJEB2kxrPYs=;
        b=p5TIN6xEZe380/fEtxw+AXDfMYTGd+npsquMiA4j6Tx0BkF6IZFuC1hn/3vShfyfg2
         1nq4IHTDqq0qotlO11bGEkwVOXLh4m6X58pMrZvMVDmeS1pDvoKQSZnl4GyJkjtHdzTZ
         SmWJEefMQgsALv+Pb9H86v5U+BpGxHlH/JqaAEYrOCRbd9TtvqoPBFZ5BPqK6+MRSegC
         csR3QH2E+NZf6vLS7H3otOndZWlDbnlaxd90fXNbXYjrdXBtw/q2U5MKS79W/hABJLcp
         8i5JAiE06UOWtd8gRdPw6HLmW2+nO38KsZ6x6P1ct+NxDmOuvVW6nsEOXdABGzY24Do4
         YpoQ==
X-Gm-Message-State: AOAM533JLjen332ey5AmZZhHvBNU31dlncPD09/L4szVHRF2lZf1EsLu
        vNjxpJ1O8+dOdDZkQCv+cSzXPA==
X-Google-Smtp-Source: ABdhPJyjDHTf5cZ2T8LWCexxoeNi+YORZrAIIvHkgQ9CukxkleXU959cZ4xsh58LnwRvlkSO+tlCgw==
X-Received: by 2002:a65:62d3:: with SMTP id m19mr1313991pgv.180.1611867821498;
        Thu, 28 Jan 2021 13:03:41 -0800 (PST)
Received: from wildbow.anholt.net ([75.164.105.146])
        by smtp.gmail.com with ESMTPSA id l2sm6753295pga.65.2021.01.28.13.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 13:03:40 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 0/3] drm/msm: fix for "Timeout waiting for GMU OOB set GPU_SET: 0x0"
Date:   Thu, 28 Jan 2021 13:03:29 -0800
Message-Id: <20210128210332.1690609-1-eric@anholt.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated commit messages over v2, no code changes.

Eric Anholt (3):
  drm/msm: Fix race of GPU init vs timestamp power management.
  drm/msm: Fix races managing the OOB state for timestamp vs timestamps.
  drm/msm: Clean up GMU OOB set/clear handling.

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 105 +++++++++++++++-----------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  49 ++++--------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |   8 +-
 3 files changed, 84 insertions(+), 78 deletions(-)

-- 
2.30.0

