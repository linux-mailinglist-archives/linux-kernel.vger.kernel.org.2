Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2F536A040
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhDXJDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhDXJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g9so34661935wrx.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxqQngAtv5nDQvF1nMweGDryMsbGOYVjl3SPSVnCHbw=;
        b=TxJIrrzHLhaIwt4IBYlFLKup23gyOIgCi7XwRw3EJ24/5waowEk4jj3uOhCLo9Vil0
         xJYpRwlRD22jF3tbj1w7x0cQitsJB4crj4ffYJD5D3M4J85tg5PCusTZFJvoQxetrdfN
         WOvS1NzjKs0hK6La8EASJcqf4xuj2gqrXxBJm/qUjG7JHZExsNnGsuNbYv2bohNNmJFD
         GWNWEEnEiVppaSc0tkBg968dG42NGaH9gNl8dqvUO3RwqShF9e2C38j8N41t3iy9igpY
         gL3+KljjGWiFEwyxce6WAtXnNau1o9P7sTb6dizEQqXr5KEGknoukLGyuZan3+VffIZq
         Vwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxqQngAtv5nDQvF1nMweGDryMsbGOYVjl3SPSVnCHbw=;
        b=Kcy545IkL6QtYJOpZsm8mn+h6KxlMom+luoWoKBWx0jDMKdYw+fSV+D6yY5J2kf02N
         uxvkEYzjoFcwo4trWzf36fnbGpWglEiRkaCyD0MN/DavQrpFspaoH6MbFPFNlK0FrLcf
         CwNAiv/xMJgOcMpnsS8QXrDrpY8uH1FO09i8HX5UIRQXi99OlvN+yQKKGy77qwwC1HYh
         kkCml8VBm8Nm9OfSU7uJpbUSjfnVruH9Zh/3cxx9gSZQskMjFl0iGP2X46saMjmVE18/
         UQ8aQHQrGMw1FUzg9qf1LPLAXGyzmsPgMwDGaKH1i5LIeUWo0klRzbes+CJWDUUThFnr
         9F1w==
X-Gm-Message-State: AOAM532IV1QucFygqiodqw0aGGxkXjXVbEJS3dsTVusSVjZ77MZupsIh
        cZeOoUIuVC7jNhQqtp2F59U0qbUi9BbnZA==
X-Google-Smtp-Source: ABdhPJzlwYKm8sbkl0TWP5xkYbTWJQRybwyud8u4RxDedpvGe+mgR0V9KweMAQOhzYtWdj/Kz7Cg1Q==
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr9986779wri.125.1619254955505;
        Sat, 24 Apr 2021 02:02:35 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id l25sm10375457wmi.17.2021.04.24.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/50] staging: rtl8723bs: remove all remaining debug macros in rtw_debug.h
Date:   Sat, 24 Apr 2021 11:01:43 +0200
Message-Id: <cover.1619254603.git.fabioaiuto83@gmail.com>
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
-       DBG_871X_SEL(sel, args);
+       netdev_dbg(padapter->pnetdev, args);
        ...>

unused _DBG_871X_LEVEL macro declaration is removed.

Beautified register dump in core/rtw_debug.c 

Some code cleaning is done and all other private component tracing
macros are removed.

----------------------------------------------
Changes in v2:
	- Added a patch to improve register dump
	- Fix commit message and changelog in patch
	  removing an unneeded include directive

Fabio Aiuto (50):
  staging: rtl8723bs: remove unused log function
  staging: rtl8723bs: replace DBG_871X_SEL log macro with netdev_dbg()
  staging: rtl8723bs: add two functions to improve register dump in
    core/rtw_debug.c
  staging: rtl8723bs: remove DBG_871X_SEL macro declaration
  staging: rtl8723bs: remove unused _DBG_871X_LEVEL macro
  staging: rtl8723bs: remove unused mac_reg_dump() function argument
  staging: rtl8723bs: remove unused bb_reg_dump() function argument
  staging: rtl8723bs: remove unused rf_reg_dump() function argument
  staging: rtl8723bs: remove unused RTW_DBGDUMP macro definition
  staging: rtl8723bs: remove all defs related to _dbgdump macro
  staging: rtl8723bs: remove unused debug variables declarations and
    initialization
  staging: rtl8723bs: remove unneeded header file include
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
 drivers/staging/rtl8723bs/core/rtw_debug.c    |  74 ++++----
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
 24 files changed, 69 insertions(+), 288 deletions(-)

-- 
2.20.1

