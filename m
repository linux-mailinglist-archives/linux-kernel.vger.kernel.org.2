Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5540201D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbhIFTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhIFTDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:03:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B37C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i6so10662181edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PO6F0PLy3skmTq6TzkYcUppzHCkPtXZClzXkABZ9IuQ=;
        b=gfRu6o7XrqKizmOlC/woI+Bb5UoEaO+DSfwwRTga9hdHlxFNjPuP8n98MnT23KqvTq
         8Jfzndb0JF5icx53UmoAX0oahXFyDhTeDcMK+6gRN73UZ3N9/D8sRJKYg9X+lo0u9DF0
         5w3TPaeKjAoOfM19gunAZs4GxmjG7I/wbtlXWOFsU65wnUVfCXAwY+mireTfnSHpIDuR
         G3IdPhXIyOsAdEHv1lac9hJztYvyzDp90t8xMyhSgHMVXlC8joXuwYh1FtM4seuRSvdy
         bUm10Hn/u4CvQ+FVO1WBPb4h4LBWtVSr8s7H4C5rHf1OF/CLQvPaxFptSI+hJH5EIckr
         Ik3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PO6F0PLy3skmTq6TzkYcUppzHCkPtXZClzXkABZ9IuQ=;
        b=qBy0BcGJtuVy8jhIm5onqnD+ZYMxwTm7jCMdb233dZEtF+eocHhrd1igd1png7+8Em
         0dXIp51aVdfK9V5tAS01VCeVfY2vMz+g87Sk4LPGQlliwO4EX3h1b60s3zCUT2PyXAqS
         99TgMOuhbvNQ+dsEIw6CtPd6n1Po3T6bI7oLB2clBRAZ1hnfdqkt9TEkh6AoUCJrjmIl
         Nch8si+3+/rr8iA9rjkyDhfPlpKPxAwjPnefaLdwCAjhOWCRXRB5ZT4kepp+RnVgnRVD
         BI0OgUaAA6bJaIbbljXwvf9QVfaDTQNsPYZn+BUH8sFONhspFIRF618cJXSsIkNs9+Y/
         Z5hw==
X-Gm-Message-State: AOAM533GGusstga6kV9jDEzfeN30400PnXQWmZMJ2lqJ1t0BhLV+OjKi
        GSYt8rQGgVc7RtJ6qTHUIaI=
X-Google-Smtp-Source: ABdhPJyRbOYZmg6bFh7qgvEYDxjAJZdHZLyunnFLtOm6Z1D/6zjH2nQao0TC5/rwYY7FRPhW0/HLcA==
X-Received: by 2002:aa7:c5d4:: with SMTP id h20mr14901035eds.88.1630954965317;
        Mon, 06 Sep 2021 12:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 00/40] staging: r8188eu: remove function pointers from struct hal_ops
Date:   Mon,  6 Sep 2021 21:01:43 +0200
Message-Id: <20210906190223.11396-1-straube.linux@gmail.com>
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


v1 -> v2
Fixed typos in commit messages.

v2 -> v3
Added this missing patchset version changelog.

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

