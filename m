Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298733E346B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhHGJse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhHGJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA85C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b128so7127936wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mx7YnVaArPpQTcFJhBXfOWZF016uAcPsvF11YBATDfc=;
        b=XaS/bP7Q8cng9fdcuKhDyR8xHUq6foYAQ7Ste/AEMqxnJ053D8d0upWKMsYhiW0joB
         GmfMHgTLwap8ICBUbzvvu+BvGZWeU4ivgz0qEwTCHPbuW714GxZ3Pzha2r6uL9b5RlcY
         TgvMIUcl7rMdTLj7pDl27wZbEoGozVXDeZwjnc+4edewHDs1oPvT8HkXks3lvDG8xuvw
         ZyVUvREx9fCdv/W+zF2nJavZI8KqBv2zUqvyEOIVLsLTtxrikPTziwp37XpCW0GvvPcG
         djt1Uch98PO9aUGLaIz9Hn7kEdBiCCT+x0Cd9hg7H+76pfYUcRvYTYKgcQxmkiTUBZPU
         GCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mx7YnVaArPpQTcFJhBXfOWZF016uAcPsvF11YBATDfc=;
        b=Dd2oTocU3pm7jOzI3F7PykuC8yRq9Lf4GXdz/NtVYzio6ugn2WOFPAhUTjeQVGTIfZ
         2vgFnxdKuCX0A7OKYXA0z2kYc2lDMJ8ttCl0/QdGNcYdtatodWi5wdnNtR+nxqVnK/3p
         s1URQ8hqt3IMJiH9+Ps0J27x1LZeWxWsQ04xDq7l9xjMqTzrpLpFYgkQG3YNKa8n7NyG
         BKXCojL4M5P7hDCKnsSgiG4mDHaoqqQtBHgL1ZMgGLq5EOquFTMGzK1GkDwkNK/ZpQ0c
         BYp2X/zHt6/mCjaDo9oLDDH7ovL1mHlUwRwT2qvB7vIxzP0iHaVfeSVN3M+XqxKm/A7w
         avrQ==
X-Gm-Message-State: AOAM5312VMxiDUeoOxXtfZJ54L0gsReqWgCVP2A20LnKKuqDl2WNLzEO
        hnv0andXc28aoYsG4fIXpUnhno7YoRM=
X-Google-Smtp-Source: ABdhPJxZ5htXNHP+Hk19fnsycwzqB8xWP2sppLxfJiQEJ71x4/zPCJKe9YdARTa7X0PNMkbdTkJgHg==
X-Received: by 2002:a1c:452:: with SMTP id 79mr23956127wme.125.1628329695070;
        Sat, 07 Aug 2021 02:48:15 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id r15sm570825wmq.15.2021.08.07.02.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] staging: rtl8723b: remove some code related to other chips
Date:   Sat,  7 Aug 2021 11:47:52 +0200
Message-Id: <cover.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset remove some code related to other chips.
Code related to MCS index values bigger than 7 and
smaller than 32, unsupported multiple spatial streams,
rf paths, rf types.

Some code cleaning in removal sites is done as well.

Tested-on: Lenovo ideapad MiiX 300-10IBY

Fabio Aiuto (21):
  staging: rtl8723bs: remove code related to unsupported MCS index
    values
  staging: rtl8723bs: remove unneeded loop
  staging: rtl8723bs: do some code cleaning in modified function
  staging: rtl8723bs: move function to file hal/odm_HWConfig.c
  staging: rtl8723bs: remove empty files
  staging: rtl8723bs: remove wrapping static function
  staging: rtl8723bs: beautify function ODM_PhyStatusQuery()
  staging: rtl8723bs: fix right side of condition
  staging: rtl8723bs: clean driver from unused RF paths
  staging: rtl8723bs: remove unused macros
  staging: rtl8723bs: remove unused struct member
  staging: rtl8723bs: remove rf type branching (first patch)
  staging: rtl8723bs: remove rf type branching (second patch)
  staging: rtl8723bs: remove rf type branching (third patch)
  staging: rtl8723bs: remove rf type branching (fourth patch)
  staging: rtl8723bs: remove unused rtw_rf_config module param
  staging: rtl8723bs: remove unused macro in include/hal_data.h
  staging: rtl8723bs: remove RF_*TX enum
  staging: rtl8723bs: use MAX_RF_PATH_NUM as ceiling to rf path index
  staging: rtl8723bs: fix tx power tables size
  staging: rtl8723bs: remove unused RF_*T*R enum

 drivers/staging/rtl8723bs/Makefile            |   1 -
 drivers/staging/rtl8723bs/core/rtw_ap.c       |   8 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c    |  18 +-
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  73 +--
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |   6 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  36 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  38 +-
 .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c  |  17 +-
 .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c  |  86 +---
 drivers/staging/rtl8723bs/hal/HalPhyRf.c      |  52 +-
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 164 +++----
 drivers/staging/rtl8723bs/hal/hal_com.c       | 165 +------
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 446 +++---------------
 drivers/staging/rtl8723bs/hal/odm.c           |  52 +-
 drivers/staging/rtl8723bs/hal/odm.h           |  25 -
 .../staging/rtl8723bs/hal/odm_CfoTracking.c   |  36 +-
 .../staging/rtl8723bs/hal/odm_CfoTracking.h   |   2 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.c       |   3 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  | 341 ++++++-------
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h  |  29 +-
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  |  23 +-
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c  |  36 --
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h  |  14 -
 .../rtl8723bs/hal/odm_RegConfig8723B.c        |   7 +-
 .../rtl8723bs/hal/odm_RegConfig8723B.h        |  11 +-
 .../staging/rtl8723bs/hal/odm_RegDefine11N.h  |   2 -
 drivers/staging/rtl8723bs/hal/odm_precomp.h   |   1 -
 drivers/staging/rtl8723bs/hal/odm_reg.h       |   4 -
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |  10 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  19 +-
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  42 +-
 .../staging/rtl8723bs/hal/rtl8723b_rf6052.c   |  21 +-
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |   2 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |   2 -
 .../rtl8723bs/include/Hal8192CPhyReg.h        |   4 -
 drivers/staging/rtl8723bs/include/HalVerDef.h |  18 -
 drivers/staging/rtl8723bs/include/drv_types.h |   1 -
 drivers/staging/rtl8723bs/include/hal_com.h   |  35 +-
 .../rtl8723bs/include/hal_com_phycfg.h        |  20 +-
 .../staging/rtl8723bs/include/hal_com_reg.h   |  19 -
 drivers/staging/rtl8723bs/include/hal_data.h  |  24 +-
 drivers/staging/rtl8723bs/include/hal_pg.h    |   8 +-
 drivers/staging/rtl8723bs/include/hal_phy.h   |   3 +-
 drivers/staging/rtl8723bs/include/ieee80211.h |  26 +-
 .../staging/rtl8723bs/include/rtl8723b_xmit.h |   8 -
 drivers/staging/rtl8723bs/include/rtw_rf.h    |  10 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  23 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   4 -
 48 files changed, 501 insertions(+), 1494 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h

-- 
2.20.1

