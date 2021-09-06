Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00F3401F84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbhIFS0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhIFS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15131C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so10495704edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yk5iTFNaloAXMSb8ZHzRcfuP8bkhzFyauDwjq9HvArE=;
        b=DLbtfSYMWIdqh/gVIcG6c2H++U//oBsK/Atjw1gMs0h3qAGCnTN3zLrvk1avzHnotz
         TWV+/fyLuo4DCNmZOUQztfqcf58fMWm1GtlThlkVMIwSpxXqvY/mcYPG/m9WoKB9aWUI
         YWNfLo3wiMuSJ+mi3gnq2Vuu845aqHBg0FbxPeHWFtaABJrUtg/0XgYBLaN58oAhEB4r
         Kce5taJq8OUqdHRUw1t45HXQ61vH09VDwbgyGFDqLkURt92d5vCY/rvt16biSMmlhIqM
         spwmORbqvzEjj6ogfsa9xqf21840do+l37b0HkBFOl5Ee964QjZYyQbJ+rWXIsR/NSUI
         pLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yk5iTFNaloAXMSb8ZHzRcfuP8bkhzFyauDwjq9HvArE=;
        b=Sm/6YDtWJBPOj5O+WXL/Z0nEDCL6A5T+KjmCYMsytvmX7QRF3PjOuA4Xp+IMNmM732
         LNwqa1lZTCUG2+UQigpwS27Ft6+Xra22q5yjqXmPr0LO5DNSV56AW9TymlJMnp7uCqei
         3hKdzN8V/gygyQE+ZDfx3IIQqOKfFkPRZt4xLO323q0jEuR25RCFLsIWb04I9nqcKmQG
         aJQ9hibidDnEn4/nBzsAupuqXkK0XETfB8UoYRmsW/r+8LBq5tYe5h4Z7HvaZVgJd+lZ
         V3zjdsUFrpzmE7bTMAp/j0O4mKFEjMM4adqKJactqrscPjrtGEGYI49CKyaXh7MuF+yl
         1tnQ==
X-Gm-Message-State: AOAM530iLocXeGUNZUk2xzEJvdL4hFwZSdrn7bHfYcsZTK0/mHVM1Gjl
        BAx8HMZ9w84e19/HC66z2wc=
X-Google-Smtp-Source: ABdhPJyY/BOFsCGw3OJDsJR5IK1x9ayz9dEIw5aqcRBiuY709K0nZAkn6PucrADyRBJnAPA1xcVOxA==
X-Received: by 2002:a50:c90b:: with SMTP id o11mr5072083edh.216.1630952700555;
        Mon, 06 Sep 2021 11:25:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/40] staging: r8188eu: remove function pointers from struct hal_ops
Date:   Mon,  6 Sep 2021 20:23:58 +0200
Message-Id: <20210906182438.5417-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get rid of the HAL layer this series removes the next
bunch of function pointers from struct hal_ops.

Also it removes some empty functions and cleans up some minor style
issues I stumbled upon.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (40):
  staging: r8188eu: remove InitSwLeds from hal_ops
  staging: r8188eu: remove DeInitSwLeds from hal_ops
  staging: r8188eu: remove dm_init from hal_ops
  staging: r8188eu: remove dm_deinit from hal_ops
  staging: r8188eu: remove SetHalODMVarHandler from hal_ops
  staging: r8188eu: remove empty functions
  staging: r8188eu: remove unused function rtw_interface_ps_func()
  staging: r8188eu: remove interface_ps_func from hal_ops
  staging: r8188eu: remove hal_dm_watchdog from hal_ops
  staging: r8188eu: remove set_bwmode_handler from hal_ops
  staging: r8188eu: remove set_channel_handler from hal_ops
  staging: r8188eu: remove unused enum hal_intf_ps_func
  staging: r8188eu: remove Add_RateATid from hal_ops
  staging: r8188eu: remove hal_power_on from hal_ops
  staging: r8188eu: remove sreset_init_value from hal_ops
  staging: r8188eu: remove sreset_reset_value from hal_ops
  staging: r8188eu: remove silentreset from hal_ops
  staging: r8188eu: remove sreset_xmit_status_check from hal_ops
  staging: r8188eu: remove sreset_linked_status_check from hal_ops
  staging: r8188eu: remove sreset_get_wifi_status from hal_ops
  staging: r8188eu: remove EfusePowerSwitch from hal_ops
  staging: r8188eu: rename hal_EfusePowerSwitch_RTL8188E()
  staging: r8188eu: remove wrapper Efuse_PowerSwitch()
  staging: r8188eu: remove ReadEFuse from hal_ops
  staging: r8188eu: remove EFUSEGetEfuseDefinition from hal_ops
  staging: r8188eu: remove EfuseGetCurrentSize from hal_ops
  staging: r8188eu: remove empty comments
  staging: r8188eu: remove Efuse_PgPacketRead from hal_ops
  staging: r8188eu: remove Efuse_PgPacketWrite from hal_ops
  staging: r8188eu: remove Efuse_WordEnableDataWrite from hal_ops
  staging: r8188eu: remove useless assignment
  staging: r8188eu: remove AntDivBeforeLinkHandler from hal_ops
  staging: r8188eu: remove AntDivCompareHandler from hal_ops
  staging: r8188eu: remove empty function rtl8188e_start_thread()
  staging: r8188eu: remove empty function rtl8188e_stop_thread()
  staging: r8188eu: remove hal_notch_filter from hal_ops
  staging: r8188eu: remove free_hal_data from hal_ops
  staging: r8188eu: remove unused function rtl8188e_clone_haldata()
  staging: r8188eu: remove SetBeaconRelatedRegistersHandler from hal_ops
  staging: r8188eu: remove UpdateHalRAMask8188EUsb from hal_ops

 drivers/staging/r8188eu/core/rtw_ap.c         |   9 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        |   6 +-
 drivers/staging/r8188eu/core/rtw_efuse.c      | 182 ++++--------------
 drivers/staging/r8188eu/core/rtw_mlme.c       |   7 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |   5 +-
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  18 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        |   4 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   8 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |   2 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |   8 +-
 drivers/staging/r8188eu/hal/hal_intf.c        | 170 +---------------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 123 +++---------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  36 +---
 drivers/staging/r8188eu/include/hal_intf.h    | 123 ++----------
 .../staging/r8188eu/include/rtl8188e_hal.h    |   5 -
 drivers/staging/r8188eu/include/rtw_efuse.h   |   9 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |   2 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  31 +--
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  21 +-
 19 files changed, 142 insertions(+), 627 deletions(-)

-- 
2.33.0

