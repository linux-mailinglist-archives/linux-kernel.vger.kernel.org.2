Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6141B35B33A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhDKK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:56:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BB9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:56:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s15so11570672edd.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHx18mF3ktk2YplTBeeApgIQRTSoHFYgv6heZZ9xW9g=;
        b=KMPxHPi3msD31s5XLMr7zp+W0NmAA7YCJPuimu1bLKsdZ3MjxhzAMGv+mgC3kO6797
         WtPg+Wv1bLoiig/qHodOzxlUQTY6vxHwFkucInTqdO0ILz4p7dagK583GrqeyXj/6F/o
         wxiq97mPDSt5hXrA6b2gyDAD2mrdxpH2xMYUqKygog9m8b2Ne4+/7UZWYRrCHls+TtTk
         9ra+5rfCKrOIasSKXTmaO7i0dhO5D982/IGgSMqYJpNiqJGDM7uTgD7K1bZ+552GjDmg
         zcuM/shjB7/ODS1KdWlxryKNwH3/vJMhH2cwG1YFQ32rwkBiK37+sPzEaYk4IsBGAuo8
         Meqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHx18mF3ktk2YplTBeeApgIQRTSoHFYgv6heZZ9xW9g=;
        b=Q8JuH3xhaD3el5c19NwYqH7f5Tw/REeh87q5Km4bkU7Tp+NXW/YLHKG6Hqd4cVwTgr
         tLwYvXNAleTNfZPcJJH5OLqqdCQu5g+xS+EjMLyTbcF41jaQF9RgbEOgbSB7SIx4Rwip
         JhswZ4t1Ssn+ORyQkwCyU7Br3gVYZMwFjYnNHihGl8rqK/EktDoSclA90RzY18WmwVKw
         PrUahu2t2hlKIxnpQH+PQkjgRBWYLJyjy/Mmrw6IUhCx2NlhmLSPdz7H6hpM1de1lemF
         LrvJrmwgo/EewQT27DWe5CyUAT0KH5rOKJT42aOouqt7rOW7aVrZhDhJGVEkl+q/XLdJ
         Se8A==
X-Gm-Message-State: AOAM530eTP9+U5bpQSff5K32b6htQi+urk/bI6ihLdDWsRHVCLJ1DdxJ
        Y0cV+LSVkCGyl2XoWsXmljE=
X-Google-Smtp-Source: ABdhPJyxJrKAsJw7E71R5myTf6zgKeV3eh2FRl1vheBsoSMFOp/Z6p3rLUmv6CE0MuPx68LYYgzbQQ==
X-Received: by 2002:a05:6402:42d3:: with SMTP id i19mr24911008edc.220.1618138573320;
        Sun, 11 Apr 2021 03:56:13 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id f10sm4369100edd.29.2021.04.11.03.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 03:56:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v4 0/4] staging: rtl8723bs: Change several files of the driver
Date:   Sun, 11 Apr 2021 12:56:04 +0200
Message-Id: <20210411105608.12900-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove camelcase, correct misspelled words in comments, change 
the type of a variable and its use, change comparisons with 'true'
in controlling expressions.

Changes from v3: Move changes of controlling expressions in patch 4/4.
Changes from v2: Rewrite subject in patch 0/4; remove a patch from the
series because it had alreay been applied (rtl8723bs: core: Remove an unused variable).
Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.

Fabio M. De Francesco (4):
  staging: rtl8723bs: Remove camelcase in several files
  staging: rtl8723bs: include: Fix misspelled words in comments
  staging: rtl8723bs: include: Change the type of a variable
  staging: rtl8723bs: Change controlling expressions

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  2 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 18 +++++-----
 drivers/staging/rtl8723bs/hal/hal_intf.c      |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |  6 ++--
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  2 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c      | 14 ++++----
 .../rtl8723bs/include/Hal8192CPhyReg.h        |  8 ++---
 .../staging/rtl8723bs/include/basic_types.h   |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
 drivers/staging/rtl8723bs/include/hal_com.h   |  2 +-
 .../staging/rtl8723bs/include/hal_com_reg.h   | 34 +++++++++----------
 drivers/staging/rtl8723bs/include/hal_data.h  |  2 +-
 .../staging/rtl8723bs/include/hal_pwr_seq.h   |  2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |  6 ++--
 drivers/staging/rtl8723bs/include/rtw_mlme.h  | 18 +++++-----
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 +-
 drivers/staging/rtl8723bs/include/rtw_mp.h    |  2 +-
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  4 +--
 drivers/staging/rtl8723bs/include/rtw_recv.h  |  4 +--
 drivers/staging/rtl8723bs/include/rtw_xmit.h  |  2 +-
 drivers/staging/rtl8723bs/include/sta_info.h  |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h      |  2 +-
 23 files changed, 70 insertions(+), 70 deletions(-)

-- 
2.31.1

