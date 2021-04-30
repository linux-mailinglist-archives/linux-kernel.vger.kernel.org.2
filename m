Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70D336FCEF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhD3O6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhD3O55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:57:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90690C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q6so23706793edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=df9NKpr+RHTxODabaE6CN4rT06czTK+Qf9TuY2WIm5Y=;
        b=Vj997fu1q4XILY4tRvaGlfo6sZx4L+uQOOjEwS1JuliMrKlXF/35OrJXd/23pebxFc
         Nn+68oT1vjyaO6nM9IRPihQwpQVyTIOQnHcFwZgZY9uA1mdWMZ8PT/dyyjWn2IO/bvzn
         SsUkezlbkRUU21/r2lDKUWfEJKXwKhUNbko1h9wD1QNwTRmehQsHZDfEMCG72fAwGSSS
         T5Lk8Eg3mFJjJhQANtvYhx+jJu2blS07U6mcmjjB18c/59J9efhINFJw36bRJ3SzDPE1
         MA9zpPAgxqWl6TyeRBFbVXt8LlBr+0Oy84Lb462vIFhuytWC+xupNNGGqkbk3S22yhoJ
         cFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=df9NKpr+RHTxODabaE6CN4rT06czTK+Qf9TuY2WIm5Y=;
        b=pc53TSdIig9HoamDJ2ZNLCip+2XwAJ35BKar+MALlwkhsuljytVJnNSZB7Bx20r3gy
         BvbCSsBwvHhRvBT77hlCVethvFkaQ06vQ0AMegjEEuxW5L0sE0JdzQbaK+CXuL8fJ9Of
         v4Unun4h7o55npLSCdo3kxXVmLV+68k6oKu7TQm+qltQbxlGGU2U5gC1t+I09HmnUebV
         HE6RjnI27uhAOdTEEZOg4liivYkcYEDcNCLVjOIyaJHImDCni73zkBiejZ6D9AAb2cBN
         DsOpB9PcoSw68ScidCQl42o+5GvapwWS/MHd7EEntZcK1SrAM5gNbgEcX2CCdS/fFnoJ
         7MQg==
X-Gm-Message-State: AOAM532oEHYX4CIj+gnryaTzIyYHrEdlE6KZh3R5GEc2U2cRmj9uIB1x
        UTf+SnXLciu2hpQMWRRIrOq7RPvU/bo=
X-Google-Smtp-Source: ABdhPJx6yKeb+c5oJ+8p8a3GPIJcMqJ/4+erpGQHkN8r0jVJ81LX/TtQycc4sMsNsW346E2M4WXtOw==
X-Received: by 2002:a05:6402:453:: with SMTP id p19mr6455656edw.88.1619794627061;
        Fri, 30 Apr 2021 07:57:07 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id j20sm2059382ejc.110.2021.04.30.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/43] staging: rtl8723bs: clean up driver from private debug facilities
Date:   Fri, 30 Apr 2021 16:56:22 +0200
Message-Id: <cover.1619794331.git.fabioaiuto83@gmail.com>
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
Changes in v3:
	- fix spelling error in subject of patch 2
	  as reported by Bryan Brattlof.
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
  staging: rtl8723bs: remove if-else blocks left empty by ODM_RT_TRACE
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

