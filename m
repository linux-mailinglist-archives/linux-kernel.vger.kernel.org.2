Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609E336F67D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhD3Hoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhD3How (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:44:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD094C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w3so103867022ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVubrsY2JZC5Vs7OTrJ5CTDcb8Ckyj/Ri95jZiKVPiI=;
        b=GYzq8BCFMMbX2PRdEkOp8fnW9BPieaHNg0p+ihboIXi2qykzA7/DXnia4d0Rvbi+Cl
         nOeKdD6N8SFTslmfeApTjveOOscrhMT7RcXurw2Kd9qXVy4k2BJAiwPk7oUZXVM+b5RV
         HKfOW3ZUkSvU3nCcAZzbogrtZ0DindeQFM0BStvTkwgRj/o6cZ76tvjFe+0MbENmYsP4
         Pc28yMJAQZ5IsXCUqETqDl76Oly1PmLFKtXPGbTVaiW0qUUsxSuzemnYQl9ZzcWGc17X
         s+Byeoi0226lIcPQrFeip4gPKDyJQHG6iME0RUVCmXqfoRFYnQbp80yYx+R+9G+KeA3m
         pO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVubrsY2JZC5Vs7OTrJ5CTDcb8Ckyj/Ri95jZiKVPiI=;
        b=IRfk+UFQvJKWoxg04CFCR7JvgXbnno8Ao0WeOlXTAplBVXpSOdboPE87WNwOa+4Tv5
         W4CR/s4i4EYXOoSVe/nVXddXJsNYQfoopNb0zJAwbOeLbHmJenNZ7gG291ZN3BVFX0EN
         gdhWsRWpdQpxAtbNGXJktZ1nm3CR7vvhXYeJ9/palT5hUBdMvOnk8YiXIM3kvjux8Psc
         623BS35jCIpV3aYDwM1pOzY1Bmf4j8YSRajVsh8ZRrp5eNIw3FWN9/BsmIrl1EI5BUtd
         58QacOhdKi6Td8iMCwCkBF+1XtFL6VCP7cEgMjDEApDdxiqCI0nuGauQUw4N4tgDlWfr
         6ydw==
X-Gm-Message-State: AOAM531ZJWKa2O7Ws2AFmC6gF3E3lU9pWsPi/1dJ92EK8L281ydV7RoV
        bjrt8Ml5dd+5ja/iUjl/uC0MmyLckcyrlw==
X-Google-Smtp-Source: ABdhPJwNTuCEhkyp+D8n9Y9GQoJFdf7fsNtdgI/ZNFO6gIRscAoBTqJHzTEbyIA56ehYKDnHjGshJA==
X-Received: by 2002:a17:906:858:: with SMTP id f24mr2852697ejd.347.1619768643432;
        Fri, 30 Apr 2021 00:44:03 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id c25sm651944edt.43.2021.04.30.00.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/43] staging: rtl8723bs: clean up driver from private debug facilities
Date:   Fri, 30 Apr 2021 09:43:18 +0200
Message-Id: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

Fabio Aiuto (43):
  staging: rtl8723bs: remove ODM_RT_TRACE logs
  staging: rlt8723bs: remove if-else blocks left empty by ODM_RT_TRACE
    deletion
  staging: rtl8723bs: remove empty functions
  staging: rtl8723bs: remove empty .c source file
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
  staging: rtl8723bs: remove empty file
  staging: rtl8723bs: remove member in dm_odm_t struct
  staging: rtl8723bs: remove DebugLevel member in dm_odm_t struct
  staging: rtl8723bs: remove odm_debug.h header file

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
 29 files changed, 6 insertions(+), 2970 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.h

-- 
2.20.1

