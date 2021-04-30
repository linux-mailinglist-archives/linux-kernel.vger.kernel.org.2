Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143A436FCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhD3OpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhD3OpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7964BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q6so23657215edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+CUfqVofGwbRg/bO3ni01EmvXazMrFhVhTH1nGz/NcM=;
        b=Wvouzm3vXmO6Km0zEjIqI5S2mCQBesiA8zlFv/Vj7gP8l1njEfqH1I2AelaEN1+W5G
         Qux7hClYi53A1/XAefQzS/sI0lvRu3d4gnzB63T9bqPmbiDAYpmApRBIKu12nH3RsyEu
         x0Y+kjg5cS5XuPBSn92c8zODVivEch0UbgeBPr+xJWbB8jqN39UNmkxv6eWrIwbyu8N4
         2ZZKb/uWEDRpsEVizsPuqRdaqgqTHxvhWGktCtCO5E6nqRDs5IvxDhAuo7GTBVZKpMul
         F31yel9H41P0qfYdDMP3534MW8aCqG8KPatJOiilYApEjRdr8Ta0fv/gszsPMEJt+50X
         N/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+CUfqVofGwbRg/bO3ni01EmvXazMrFhVhTH1nGz/NcM=;
        b=plDfCtJwws99X434J4JfMD4S71UR0AnYxrPPaLtm35CeFzMfhIREuCJFHH+k1EeFBn
         X0DsQ5HPpCbiT2Y93ZIzL0ps10cqj7/B50IRDRbNt1wqNw+8FjK0WRg+sFFhDhV2gYvy
         vUB77Bu8gg3LM3zlBoa31iSip7H+cwDVsF2fvenzY+Qu9BY6rrAsiSsQxSg/P9wupVDH
         K2CYyBIqyFAfePbeRohU65Pdh62ugnGG2aQR5BFEjpfjJI2betoXnycUInHYWGT9fI/2
         XMpE4MFmT6d//+R/17hqAKVD9CTNq0VAQi++jrE5lR6dUxQGTBdR/KZVKwYiQ6oRugMh
         m1EQ==
X-Gm-Message-State: AOAM530kXm4k6Ze21NwoEFXrzIyERJh2zOU4pulURxaE7zBAusT+Eqk2
        aRt2xz+cl5w/bIonnpWA3c/4b1sOBz4=
X-Google-Smtp-Source: ABdhPJyT9EWc2lhPSRcBW82ovVmzx2l0yhraOi6chwA+lo9qHr8fd4Pw5xevMoS7wOaUXl+ltm9P0A==
X-Received: by 2002:aa7:d413:: with SMTP id z19mr6450861edq.37.1619793854934;
        Fri, 30 Apr 2021 07:44:14 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id b9sm1442091edt.2.2021.04.30.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/43] staging: rtl8723bs: clean up driver from private debug facilities
Date:   Fri, 30 Apr 2021 16:43:30 +0200
Message-Id: <cover.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset remove all private debug facilities.
It removes unused macros and _do nothing_ ones (i.e. macros
whose behaviour is activated by manual code update).
Replace tracing macros wrapping raw printk calls by
netdev_dbg() calls which is best suited for a network
driver.

Remove all unused macros and function definition tied to
the whole private tracing facility.

------------------------------------------------
Changes in v2:
	- fix patch 4 did not compile due to missing removal
	  of target file in Makefile (as reported by
	  kernel test robot). Remove deleted file target.
	- patch 40 did not compile due to missing removal
	  of target file in Makefile. Remove deleted file
	  taget.
	- reword of both patches 4 and 40.

Fabio Aiuto (43):
  staging: rtl8723bs: remove ODM_RT_TRACE logs
  staging: rlt8723bs: remove if-else blocks left empty by ODM_RT_TRACE
    deletion
  staging: rtl8723bs: remove empty functions
  staging: rtl8723bs: remove empty hal/odm_PathDiv.c source file
  staging: rtl8723bs: remove undefined function prototypes
  staging: rtl8723bs: remove empty header file
  staging: rtl8723bs: remove ODM_RT_TRACE* unused macro defs
  staging: rtl8723bs: remove all commented out ODM_RT_TRACE logs
  staging: rtl8723bs: replace ODM_RT_ASSERT with netdev_dbg()
  staging: rtl8723bs: remove unused ODM_RT_ASSERT macro
  staging: rtl8723bs: remove unused ODM_PRINT_ADDR macro
  staging: rtl8723bs: remove unused ODM_dbg_trace macro
  staging: rtl8723bs: remove unused ODM_dbg_enter
  staging: rtl8723bs: remove unused ODM_dbg_exit macro
  staging: rtl8723bs: remove empty ifdef block
  staging: rtl8723bs: remove unused ASSERT macro
  staging: rtl8723bs: remove empty #ifndef block
  staging: rtl8723bs: remove commented out RT_ASSERT occurrences
  staging: rtl8723bs: remove unused RT_PRINTK macro
  staging: rtl8723bs: remove BTC_PRINT logs
  staging: rtl8723bs: remove empty if-else blocks after BTC_PRINT
    removal
  staging: rtl8723bs: remove braces around single statement in if block
  staging: rtl8723bs: remove commented out BTC_PRINT logs
  staging: rtl8723bs: remove BTC_PRINT macro definitions
  staging: rtl8723bs: remove BTC_PRINT_ADDR macro definitions
  staging: rtl8723bs: remove BTC_PRINT_DATA definitions
  staging: rtl8723bs: remove BTC_PRINT_F macro definition
  staging: rtl8723bs: remove empty #ifdef block
  staging: rtl8723bs: remove unsed hal_btcoex_SetDBG() function
  staging: rtl8723bs: remove hal_btcoex_GetDBG() function
  staging: rtl8723bs: remove unnecessary halbtcoutsrc_DbgInit() function
  staging: rtl8723bs: remove obsolete GLBtcDbgType array declarations
  staging: rtl8723bs: remove unused enum
  staging: rtl8723bs: remove obsolete debug macros
  staging: rtl8723bs: remove commented out DbgPrint logs
  staging: rtl8723bs: remove unused DbgPrint macro
  staging: rtl8723bs: remove commented out *RT_DISP logs
  staging: rtl8723bs: remove RT_DISP macro definition
  staging: rtl8723bs: remove ODM_InitDebugSetting() function
  staging: rtl8723bs: remove empty hal/odm_debug.c file
  staging: rtl8723bs: remove member in dm_odm_t struct
  staging: rtl8723bs: remove DebugLevel member in dm_odm_t struct
  staging: rtl8723bs: remove odm_debug.h header file

 drivers/staging/rtl8723bs/Makefile            |   2 -
 drivers/staging/rtl8723bs/core/rtw_efuse.c    |   1 -
 drivers/staging/rtl8723bs/core/rtw_recv.c     |  22 -
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 604 +-----------------
 .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   | 502 +--------------
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |  67 --
 .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c  |  62 --
 .../staging/rtl8723bs/hal/HalHWImg8723B_MAC.c |  49 --
 .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c  |  63 --
 drivers/staging/rtl8723bs/hal/HalPhyRf.c      | 332 ----------
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 177 +----
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    | 171 -----
 drivers/staging/rtl8723bs/hal/hal_com.c       |  14 -
 drivers/staging/rtl8723bs/hal/odm.c           |  53 +-
 drivers/staging/rtl8723bs/hal/odm.h           |   4 -
 .../staging/rtl8723bs/hal/odm_CfoTracking.c   | 107 ----
 drivers/staging/rtl8723bs/hal/odm_DIG.c       | 320 ----------
 .../rtl8723bs/hal/odm_EdcaTurboCheck.c        |  18 -
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  |  38 --
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  |  27 -
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c   |  34 -
 drivers/staging/rtl8723bs/hal/odm_PathDiv.h   |  21 -
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c  |   1 -
 .../rtl8723bs/hal/odm_RegConfig8723B.c        |  66 --
 drivers/staging/rtl8723bs/hal/odm_debug.c     |  44 --
 drivers/staging/rtl8723bs/hal/odm_debug.h     | 165 -----
 drivers/staging/rtl8723bs/hal/odm_precomp.h   |   2 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |   3 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |   7 -
 .../staging/rtl8723bs/include/hal_btcoex.h    |   2 -
 30 files changed, 6 insertions(+), 2972 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.h

-- 
2.20.1

