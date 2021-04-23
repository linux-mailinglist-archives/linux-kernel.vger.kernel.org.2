Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B91E36953F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhDWO7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDWO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECD6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n4-20020a05600c4f84b029013151278decso1397892wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cgl8/i7gQs6yxgkvwobatiYWLGXODMXAcvLmSXV9bcg=;
        b=KIDPzoPzCXnEjke2W6kmWSqnfFGqG72dl8OncSLk5AODjpqcyieaAn7POj7SWXTW3G
         em/lCuQ9LCaEZ5NW+Cmw96VHE21Bx6oO+dCpPHKzzUZvv5b4n2jAjIx7A2n3M7tCBPlK
         DV5dcrXIAcbsg/VGvmJu13BuW8lTZtrNgHQQYpsLtj2e+569jBYMbO4UbSHhGhid76Rf
         VX3T6kHvbXH8yK3H7AVNcbQ5nTYWfcMkZf9n+2k3PQ3iNovlUrSwswZpWsO9dyag82Kp
         mv3xTsDskYu9Fj+QY7k1MN/2ca1PG9CrDeudONxukdNx5rEcyqxLtQodLZCxShLTh2Kx
         ykcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cgl8/i7gQs6yxgkvwobatiYWLGXODMXAcvLmSXV9bcg=;
        b=kq7CMFqNO+xbMkZV6oF/YKDxm69kHErP74BIIn8D4BLzlHhs0e6RWj8cz4sHUvN7lp
         vJ3RMDYHDac2JNTTAgm2U3ZhwKIfmzjp/6Vn2fQU9iOtXnjFJwSmSby8Vd/n6I05LcrI
         gZBrT7OiBEFexlIc7OR2fr404Yb9ejzH4k5fgyGDwrFDbbOQVhdBaeXItRs6xk8Pkwxs
         7CbWDOUkwKsVHe3NDm70ZnZGwbBfLPocZ3Ap9zsRt5X3XsZ7E4uGred4jF1vOD9vgCjr
         9sdugwBkUVLuw2K7elQ6kfcPa77wnXZzTAmcU1LU/qvPnDUgw2Rc4VTX/7dTJthlh4f1
         9ptw==
X-Gm-Message-State: AOAM532phj1QGesQWpDbKX0ygvfOv0JU8J1TLRhypv67K/VTNYeMv/k7
        3As20WaJj/QkQ/fBxxDeBB6fNZYEhmI=
X-Google-Smtp-Source: ABdhPJwcuVzhib37Sdj2Gl65PK5C/Cg5T9Io2Y2K3huCMlHvhCt4Mujt/pN/fqc6YyUlJHVgX3+Fgw==
X-Received: by 2002:a1c:e3c3:: with SMTP id a186mr5847197wmh.81.1619189922359;
        Fri, 23 Apr 2021 07:58:42 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id y125sm8076731wmy.34.2021.04.23.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/49] staging: rtl8723bs: remove all remaining debug macros in rtw_debug.h
Date:   Fri, 23 Apr 2021 16:57:51 +0200
Message-Id: <cover.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes all remaining debug macros in rtw_debug.h

DBG_871X_SEL macro is replaced with netdev_dbg() for it does
a raw printk call which is not best recommended for a driver.

@@
expression sel;
expression list args;
identifier padapter;
identifier func;
@@

func(..., struct adapter *padapter, ...) {
	<...
-	DBG_871X_SEL(sel, args);
+	netdev_dbg(padapter->pnetdev, args);
	...>

unused _DBG_871X_LEVEL macro declaration is removed.

Some code cleaning is done and all other private component tracing
macros are removed.

Fabio Aiuto (49):
  staging: rtl8723bs: remove unused log function
  staging: rtl8723bs: replace DBG_871X_SEL log macro with netdev_dbg()
  staging: rtl8723bs: remove DBG_871X_SEL macro declaration
  staging: rtl8723bs: remove unused _DBG_871X_LEVEL macro
  staging: rtl8723bs: remove unused mac_reg_dump() function argument
  staging: rtl8723bs: remove unused bb_reg_dump() function argument
  staging: rtl8723bs: remove unused rf_reg_dump() function argument
  staging: rtl8723bs: remove unused RTW_DBGDUMP macro definition
  staging: rtl8723bs: remove all defs related to _dbgdump macro
  staging: rtl8723bs: remove unused debug variables declarations and
    initialization
  staging: rtl8723bs: remove unneeded header file
  staging: rtl8723bs: remove unused debug macro definitions
  staging: rtl8723bs: remove debug macros related to core/rtw_xmit.c
    tracing
  staging: rtl8723bs: remove debug macros related to os_dep/xmit_linux.c
    tracing
  staging: rtl8723bs: remove debug macros related to core/rtw_recv.c
    tracing
  staging: rtl8723bs: remove debug macros related to os_dep/recv_linux.c
    tracing
  staging: rtl8723bs: remove debug macros related to core/rtw_mlme.c
    tracing
  staging: rtl8723bs: remove debug macros related to os_dep/mlme_linux.c
    tracing
  staging: rtl8723bs: move static array definition from header to .c
    file
  staging: rtl8723bs: remove debug macros related to core/rtw_mlme_ext.c
    tracing
  staging: rtl8723bs: remove debug macros related to core/rtw_sta_mgt.c
    tracing
  staging: rtl8723bs: remove debug macros related to core/rtw_cmd.c
    tracing
  staging: rtl8723bs: remove obsolete debug macro definitions
  staging: rtl8723bs: remove debug macros related to core/rtw_io.c
    tracing
  staging: rtl8723bs: remove obsolete _IO_OSDEP_C_ debug macro
    definition
  staging: rtl8723bs: remove debug macros related to os_dep/os_intfs.c
    tracing
  staging: rtl8723bs: remove debug macros related to core/rtw_security.c
    tracing
  staging: rtl8723bs: remove debug macros related to core/rtw_eeprom.c
    tracing
  staging: rtl8723bs: remove debug macros related to hal/hal_intf.c
    tracing
  staging: rtl8723bs: remove debug macros related to hal/sdio_halinit.c
    tracing
  staging: rtl8723bs: remove unused debug macros tied to
    _RTL871X_IOCTL_C_ definition
  staging: rtl8723bs: remove unused debug macros tied to
    _RTL871X_IOCTL_SET_C_ definition
  staging: rtl8723bs: remove unused debug macros tied to
    _RTL871X_IOCTL_QUERY_C_ definition
  staging: rtl8723bs: remove unused debug macros tied to
    _RTL871X_PWRCTRL_C_ definition
  staging: rtl8723bs: remove unused macros tied to core/rtw_pwrctrl.c
    debug
  staging: rtl8723bs: remove unused macros tied to os_dep/sdio_intf.c
    debug
  staging: rtl8723bs: remove unused debug macros tied to _HCI_OPS_C_
    definition
  staging: rtl8723bs: remove unused debug macros tied to hal/sdio_ops.c
    debug
  staging: rtl8723bs: remove unused debug macros tied to
    os_dep/osdep_service.c debug
  staging: rtl8723bs: remove unused _module_mp_ def
  staging: rtl8723bs: remove unused macros tied to _HCI_OPS_OS_C_
    definition
  staging: rtl8723bs: remove unused macros tied to
    _RTL871X_IOCTL_LINUX_C definition
  staging: rtl8723bs: remove unused macros tied to _RTL8712_CMD_C_
    definition
  staging: rtl8723bs: remove commented out macro definition
  staging: rtl8723bs: remove unused debug macro definitions
  staging: rtl8723bs: remove unused macros tied to core/rtw_efuse.c
    debug
  staging: rtl8723bs: remove unsed debug macros tied to no particular
    code debug
  staging: rtl8723bs: remove last unused debug macros
  staging: rtl8723bs: macro DRIVER_PREFIX expands to lowercase driver
    name

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |   2 -
 drivers/staging/rtl8723bs/core/rtw_debug.c    |  39 ++--
 drivers/staging/rtl8723bs/core/rtw_eeprom.c   |   2 -
 drivers/staging/rtl8723bs/core/rtw_efuse.c    |   2 -
 drivers/staging/rtl8723bs/core/rtw_io.c       |   2 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |   2 -
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  32 +++-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |   2 -
 drivers/staging/rtl8723bs/core/rtw_recv.c     |   2 -
 drivers/staging/rtl8723bs/core/rtw_security.c |   2 -
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |   2 -
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |   2 -
 drivers/staging/rtl8723bs/hal/hal_intf.c      |   3 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |   2 -
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |   2 -
 drivers/staging/rtl8723bs/include/rtw_debug.h | 170 +-----------------
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  32 ----
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |   6 +-
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |   4 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   2 -
 .../staging/rtl8723bs/os_dep/osdep_service.c  |   4 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |   2 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |   2 -
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |   2 -
 24 files changed, 48 insertions(+), 274 deletions(-)

-- 
2.20.1

