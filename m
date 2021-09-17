Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E640740F3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbhIQIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbhIQIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:08:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9735C061767
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:06:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so2903244wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+ZicbaCnRFRwPjtdSj14+R6QkztHEiM+wYFY8ONJ5c=;
        b=pu0Dnk+nvamRG842FpR3b13PDb3WZdRxm1P1gVCMMAMA19PPKxbUKJD49+3WfaSW0O
         H2jhL9GaewoOcHcVvda+Kp7BJQ2s7JlzB6IDVuQwTkYC5x7QPNKTy9AqYB3Sif15AK88
         NK3F08u/ewF3rLWUaLp1M9DR4xaJEzPO3e1Hwyasf14nUIvqIrZkLHqVMeYQn4IQmzXX
         C7sakh8HpP5BGMEiH8zmAJ9+sJy/ApFNzOZCvl4xFgkjgg+C76t6xy/oXWk3WUo677jx
         NbnYLpSmFRuSnjggiScuhoHPn1k1ps1HVT62Lvp9z8lSjRJzldmuqWdR5zT3aBNtecia
         0iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+ZicbaCnRFRwPjtdSj14+R6QkztHEiM+wYFY8ONJ5c=;
        b=BZOzyAqDYsvLxj5zb4AnXGDcKowpBuFqAez+kZxh3Y2TJtKmnp9ClhmbBvSwbslM7G
         Mat+qGk8OyPmTCD2FwYNnk83WK3uIMUvVWgsK5hPf4awh5CPiDoqtMNKDKicEYIV+BEK
         6rKHw6oNrOnv/ik4sNMDsZK7Yi8tEytHhq5gPy/I7CQ+FAVordQHtV1CMcHNjZk1wobh
         u/Oq6FI1uQ27EXT1ehESAymUrX85ue8rzCHuy9an8zb2FOSazK8DXqf4XF0NT0JOIyb1
         EOTpXF8NS/3V68GXj5sObR92QIAReVeb2T52n3z0wew0IQbPqp4+GEb3DjcvkImBuMZ4
         inlg==
X-Gm-Message-State: AOAM533O429kcW1KseaKKUCWYhBfEE05l+BnYyml5EaMRNX+4J7b72jO
        Af5yZEGpLxzrgKGJfpLxJxGlM6Oi+G6o8Q==
X-Google-Smtp-Source: ABdhPJxUBah5feVFGpcLPDwTARF9Qf3N5vDMhWmMs7d/5q61eoGg1W5jbDt/LBUhSUGpB86MaZb/+g==
X-Received: by 2002:a1c:3543:: with SMTP id c64mr13933848wma.78.1631865991558;
        Fri, 17 Sep 2021 01:06:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id r129sm5690890wmr.7.2021.09.17.01.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:06:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: remove some unused code
Date:   Fri, 17 Sep 2021 10:06:11 +0200
Message-Id: <20210917080615.25819-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTL8188EU chips are 1T1R. This set removes some code that is valid
only for 1T2R and 2T2R chips.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: remove IS_1T1R, IS_1T2R, IS_2T2R macros
  staging: r8188eu: remove if test that is always true
  staging: r8188eu: remove NumTotalRFPath from struct hal_data_8188e
  staging: r8188eu: remove switches from phy_RF6052_Config_ParaFile()

 drivers/staging/r8188eu/hal/hal_com.c         |  10 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  60 ++++-----
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |   5 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |   8 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 125 ++++++------------
 drivers/staging/r8188eu/include/HalVerDef.h   |   9 --
 .../staging/r8188eu/include/rtl8188e_hal.h    |   1 -
 7 files changed, 74 insertions(+), 144 deletions(-)

-- 
2.33.0

