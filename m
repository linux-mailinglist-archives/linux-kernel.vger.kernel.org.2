Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866113D83DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhG0XWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhG0XWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:22:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35957C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:22:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u15so222770wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g6v+H+B6T3nPG6krl5rvzwCnp3n6PhFEUJV8wcRmOPM=;
        b=sTrsPh34KVfc2c4z3ySatBMEY2ABVi6if9p8w/YYrWeEeGw72eL8UpozSSMeJChDi6
         HikEnOy3prW8Nyucp6I2ZJLMtE4Tdz3ZzfVAkH0wBHNTEQiGAtxG+dV7IaU3/CzNqepM
         EnTCqtcIb+pXHazKNzWUfHXBqTe93b6xGvpUe47nrZt6SqE0p1WBCIJ5OgFZptT8pkNy
         YXk9ul10wdH58s0TBPpO/p1nEUXyb3bbNX6Qq32fdnaUse3er4kXqxURGGZHr+4U/hdG
         4pD+eufJEieYJ3QRBZIcK2l4D549EtnM7jKULtF7LomOQwEPpwq7zY1e371wpxac83F1
         QPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g6v+H+B6T3nPG6krl5rvzwCnp3n6PhFEUJV8wcRmOPM=;
        b=fqXpG89MaRb5qELscEJnFogBbxPyK41Zom2CwNezhGXDs2IS/p6v6LTtAoilZlgZj7
         ooEK4q5eHAg37Gut7gXdkZ5QjsAGO9yl6cArc0nnDXacZ4N61c4FChUjJOCztKlsQ/M9
         XtcwqSwc38ehUwd4yPsmRmARkuNRhNI3lm8OcvY93fISpaQSh0JdesVMuWZiWlFb+oBw
         xoXBW78XEkrjKI3+8fSWGWQ6DGQJUotKgLeCqHVEUJPwIR3P265VkymCg9hJl5nOvNmf
         DJ/u7UkAsOkaWymEqwvJPwafavDg0jAE5mY1Wya1jH0Jvol9XZLr1boAwwrX11IzpIDB
         O9vA==
X-Gm-Message-State: AOAM533BoFWnV/me8tzEkpQI1Tbudy+QXFXdwOp6BIJOQcEwZ6McGV5d
        ZZsPJLMuymAH6StuU8XhWZIqylaUDlPTZ/vt
X-Google-Smtp-Source: ABdhPJzLCuwrg3tbj18JlxiEOu/qF6yGCoMVjSzChXFYShVUyAY8RryRkOlnIENRj2RaL04KMH45yw==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr5949316wmp.165.1627428141707;
        Tue, 27 Jul 2021 16:22:21 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m7sm3848367wmq.20.2021.07.27.16.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:22:21 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com, martin@kaiser.cx
Subject: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu driver
Date:   Wed, 28 Jul 2021 00:22:13 +0100
Message-Id: <20210727232219.2948-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had to break this patchset up a bit to get around the file size limits
on the mailing list, and also I removed the hostapd stuff which is
userspace related and therefore not required.

The driver currently in staging is older and less functional than the
version on Larry Finger's GitHub account, based upon v4.1.4_6773.20130222.
This series of patches therefore:

(1) Marks the older driver as deprecated and changes its CONFIG_
    parameter and module name.
(2) Imports the GitHub version mentioned above into the r8188eu folder
    and configures the build system to allow the building of both drivers.

There is plenty of work to do to this driver, including to its Makefile,
but it is at least buildable/usable for now (albeit with a few build
warnings).

Revisions of this patch set:
V1: contained deletion of old driver as one patch and the whole new
    driver as another, so was too big for the mailing lists.
V2: split things up, but contained whitespace errorsm and various other
    mistakes.
V3: now based upon v4.1.4_6773.20130222 of the GitHub driver, with
    tweaks to the Makefile (which is already cleaner but needed additional
    tweaks) and the Kconfig to take into account feedback. There were
    several trailing whitespace warnings even in this branch/version which
    have now been corrected as well.
V4: don't remove old driver now, just mark as deprecated and modify to
    allow building alongside the new driver.

Phillip Potter (6):
  staging: r8188eu: introduce new core dir for RTL8188eu driver
  staging: r8188eu: introduce new hal dir for RTL8188eu driver
  staging: r8188eu: introduce new os_dep dir for RTL8188eu driver
  staging: r8188eu: introduce new include dir for RTL8188eu driver
  staging: r8188eu: introduce new supporting files for RTL8188eu driver
  staging: r8188eu: attach newly imported driver to build system

 drivers/staging/Kconfig                       |    2 +
 drivers/staging/Makefile                      |    3 +-
 drivers/staging/r8188eu/Kconfig               |   25 +
 drivers/staging/r8188eu/Makefile              |  129 +
 drivers/staging/r8188eu/core/rtw_ap.c         | 1976 ++++
 drivers/staging/r8188eu/core/rtw_br_ext.c     | 1184 +++
 drivers/staging/r8188eu/core/rtw_cmd.c        | 2206 +++++
 drivers/staging/r8188eu/core/rtw_debug.c      |  943 ++
 drivers/staging/r8188eu/core/rtw_efuse.c      |  872 ++
 drivers/staging/r8188eu/core/rtw_ieee80211.c  | 1625 ++++
 drivers/staging/r8188eu/core/rtw_io.c         |  323 +
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 1118 +++
 drivers/staging/r8188eu/core/rtw_iol.c        |  209 +
 drivers/staging/r8188eu/core/rtw_led.c        | 1705 ++++
 drivers/staging/r8188eu/core/rtw_mlme.c       | 2354 +++++
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 8407 +++++++++++++++++
 drivers/staging/r8188eu/core/rtw_mp.c         | 1000 ++
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   | 1352 +++
 drivers/staging/r8188eu/core/rtw_p2p.c        | 2068 ++++
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  655 ++
 drivers/staging/r8188eu/core/rtw_recv.c       | 2252 +++++
 drivers/staging/r8188eu/core/rtw_rf.c         |   88 +
 drivers/staging/r8188eu/core/rtw_security.c   | 1757 ++++
 drivers/staging/r8188eu/core/rtw_sreset.c     |   79 +
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  609 ++
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 1690 ++++
 drivers/staging/r8188eu/core/rtw_xmit.c       | 2370 +++++
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c  |   86 +
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  760 ++
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  720 ++
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  230 +
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |  268 +
 drivers/staging/r8188eu/hal/HalPhyRf.c        |   49 +
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 1505 +++
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  132 +
 drivers/staging/r8188eu/hal/hal_com.c         |  381 +
 drivers/staging/r8188eu/hal/hal_intf.c        |  468 +
 drivers/staging/r8188eu/hal/odm.c             | 2174 +++++
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  601 ++
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  400 +
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  130 +
 drivers/staging/r8188eu/hal/odm_debug.c       |   32 +
 drivers/staging/r8188eu/hal/odm_interface.c   |  205 +
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  762 ++
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  267 +
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 2390 +++++
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  851 ++
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 1135 +++
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  569 ++
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  202 +
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c |   80 +
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   |   91 +
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  111 +
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  136 +
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  703 ++
 drivers/staging/r8188eu/hal/usb_halinit.c     | 2334 +++++
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  717 ++
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  269 +
 .../staging/r8188eu/include/Hal8188EPhyReg.h  | 1088 +++
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  |  173 +
 .../r8188eu/include/Hal8188ERateAdaptive.h    |   75 +
 drivers/staging/r8188eu/include/Hal8188EReg.h |   44 +
 .../r8188eu/include/HalHWImg8188E_BB.h        |   44 +
 .../r8188eu/include/HalHWImg8188E_FW.h        |   33 +
 .../r8188eu/include/HalHWImg8188E_MAC.h       |   30 +
 .../r8188eu/include/HalHWImg8188E_RF.h        |   30 +
 drivers/staging/r8188eu/include/HalPhyRf.h    |   30 +
 .../staging/r8188eu/include/HalPhyRf_8188e.h  |   58 +
 .../staging/r8188eu/include/HalPwrSeqCmd.h    |  126 +
 drivers/staging/r8188eu/include/HalVerDef.h   |  166 +
 drivers/staging/r8188eu/include/autoconf.h    |   43 +
 drivers/staging/r8188eu/include/basic_types.h |  184 +
 drivers/staging/r8188eu/include/cmd_osdep.h   |   32 +
 drivers/staging/r8188eu/include/drv_types.h   |  346 +
 .../staging/r8188eu/include/drv_types_linux.h |   23 +
 drivers/staging/r8188eu/include/ethernet.h    |   41 +
 drivers/staging/r8188eu/include/h2clbk.h      |   32 +
 drivers/staging/r8188eu/include/hal_com.h     |  172 +
 drivers/staging/r8188eu/include/hal_intf.h    |  430 +
 drivers/staging/r8188eu/include/ieee80211.h   | 1261 +++
 .../staging/r8188eu/include/ieee80211_ext.h   |  287 +
 drivers/staging/r8188eu/include/if_ether.h    |  111 +
 .../staging/r8188eu/include/ioctl_cfg80211.h  |  107 +
 drivers/staging/r8188eu/include/ip.h          |  125 +
 drivers/staging/r8188eu/include/mlme_osdep.h  |   35 +
 .../staging/r8188eu/include/mp_custom_oid.h   |  349 +
 drivers/staging/r8188eu/include/nic_spec.h    |   41 +
 drivers/staging/r8188eu/include/odm.h         | 1182 +++
 .../staging/r8188eu/include/odm_HWConfig.h    |  133 +
 .../staging/r8188eu/include/odm_RTL8188E.h    |   56 +
 .../r8188eu/include/odm_RegConfig8188E.h      |   43 +
 .../r8188eu/include/odm_RegDefine11AC.h       |   46 +
 .../r8188eu/include/odm_RegDefine11N.h        |  160 +
 drivers/staging/r8188eu/include/odm_debug.h   |  143 +
 .../staging/r8188eu/include/odm_interface.h   |  164 +
 drivers/staging/r8188eu/include/odm_precomp.h |  103 +
 drivers/staging/r8188eu/include/odm_reg.h     |  116 +
 drivers/staging/r8188eu/include/odm_types.h   |   61 +
 drivers/staging/r8188eu/include/osdep_intf.h  |   83 +
 .../staging/r8188eu/include/osdep_service.h   |  489 +
 drivers/staging/r8188eu/include/recv_osdep.h  |   54 +
 .../staging/r8188eu/include/rtl8188e_cmd.h    |  122 +
 drivers/staging/r8188eu/include/rtl8188e_dm.h |   62 +
 .../staging/r8188eu/include/rtl8188e_hal.h    |  471 +
 .../staging/r8188eu/include/rtl8188e_led.h    |   34 +
 .../staging/r8188eu/include/rtl8188e_recv.h   |   69 +
 drivers/staging/r8188eu/include/rtl8188e_rf.h |   35 +
 .../staging/r8188eu/include/rtl8188e_spec.h   | 1438 +++
 .../staging/r8188eu/include/rtl8188e_sreset.h |   31 +
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  177 +
 drivers/staging/r8188eu/include/rtw_android.h |   64 +
 drivers/staging/r8188eu/include/rtw_ap.h      |   67 +
 drivers/staging/r8188eu/include/rtw_br_ext.h  |   66 +
 drivers/staging/r8188eu/include/rtw_cmd.h     |  991 ++
 drivers/staging/r8188eu/include/rtw_debug.h   |  274 +
 drivers/staging/r8188eu/include/rtw_eeprom.h  |  130 +
 drivers/staging/r8188eu/include/rtw_efuse.h   |  150 +
 drivers/staging/r8188eu/include/rtw_event.h   |  113 +
 drivers/staging/r8188eu/include/rtw_ht.h      |   44 +
 drivers/staging/r8188eu/include/rtw_io.h      |  387 +
 drivers/staging/r8188eu/include/rtw_ioctl.h   |  120 +
 .../staging/r8188eu/include/rtw_ioctl_rtl.h   |   79 +
 .../staging/r8188eu/include/rtw_ioctl_set.h   |   49 +
 drivers/staging/r8188eu/include/rtw_iol.h     |   84 +
 drivers/staging/r8188eu/include/rtw_led.h     |  201 +
 drivers/staging/r8188eu/include/rtw_mlme.h    |  649 ++
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  874 ++
 drivers/staging/r8188eu/include/rtw_mp.h      |  492 +
 .../staging/r8188eu/include/rtw_mp_ioctl.h    |  339 +
 .../r8188eu/include/rtw_mp_phy_regdef.h       | 1079 +++
 drivers/staging/r8188eu/include/rtw_p2p.h     |  135 +
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  282 +
 drivers/staging/r8188eu/include/rtw_qos.h     |   30 +
 drivers/staging/r8188eu/include/rtw_recv.h    |  473 +
 drivers/staging/r8188eu/include/rtw_rf.h      |  145 +
 .../staging/r8188eu/include/rtw_security.h    |  382 +
 drivers/staging/r8188eu/include/rtw_sreset.h  |   50 +
 drivers/staging/r8188eu/include/rtw_version.h |    1 +
 drivers/staging/r8188eu/include/rtw_xmit.h    |  383 +
 drivers/staging/r8188eu/include/sta_info.h    |  384 +
 drivers/staging/r8188eu/include/usb_hal.h     |   26 +
 drivers/staging/r8188eu/include/usb_ops.h     |  115 +
 .../staging/r8188eu/include/usb_ops_linux.h   |   55 +
 drivers/staging/r8188eu/include/usb_osintf.h  |   45 +
 .../staging/r8188eu/include/usb_vendor_req.h  |   51 +
 drivers/staging/r8188eu/include/wifi.h        | 1105 +++
 drivers/staging/r8188eu/include/wlan_bssdef.h |  343 +
 drivers/staging/r8188eu/include/xmit_osdep.h  |   67 +
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 8178 ++++++++++++++++
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |  302 +
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 1283 +++
 .../staging/r8188eu/os_dep/osdep_service.c    |  535 ++
 drivers/staging/r8188eu/os_dep/recv_linux.c   |  270 +
 drivers/staging/r8188eu/os_dep/rtw_android.c  |  303 +
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  863 ++
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  283 +
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |  282 +
 drivers/staging/rtl8188eu/Kconfig             |    9 +-
 drivers/staging/rtl8188eu/Makefile            |    4 +-
 159 files changed, 89176 insertions(+), 7 deletions(-)
 create mode 100644 drivers/staging/r8188eu/Kconfig
 create mode 100644 drivers/staging/r8188eu/Makefile
 create mode 100644 drivers/staging/r8188eu/core/rtw_ap.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_br_ext.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_cmd.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_debug.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_efuse.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_ieee80211.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_io.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_ioctl_set.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_iol.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_led.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_mlme.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_mlme_ext.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_mp.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_mp_ioctl.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_p2p.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_pwrctrl.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_recv.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_rf.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_security.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_sreset.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_sta_mgt.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_wlan_util.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_xmit.c
 create mode 100644 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
 create mode 100644 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPhyRf.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
 create mode 100644 drivers/staging/r8188eu/hal/hal_com.c
 create mode 100644 drivers/staging/r8188eu/hal/hal_intf.c
 create mode 100644 drivers/staging/r8188eu/hal/odm.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_HWConfig.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_RTL8188E.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_debug.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_interface.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_cmd.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_dm.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_mp.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_sreset.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_xmit.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_led.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
 create mode 100644 drivers/staging/r8188eu/hal/usb_halinit.c
 create mode 100644 drivers/staging/r8188eu/hal/usb_ops_linux.c
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyReg.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EReg.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
 create mode 100644 drivers/staging/r8188eu/include/HalPhyRf.h
 create mode 100644 drivers/staging/r8188eu/include/HalPhyRf_8188e.h
 create mode 100644 drivers/staging/r8188eu/include/HalPwrSeqCmd.h
 create mode 100644 drivers/staging/r8188eu/include/HalVerDef.h
 create mode 100644 drivers/staging/r8188eu/include/autoconf.h
 create mode 100644 drivers/staging/r8188eu/include/basic_types.h
 create mode 100644 drivers/staging/r8188eu/include/cmd_osdep.h
 create mode 100644 drivers/staging/r8188eu/include/drv_types.h
 create mode 100644 drivers/staging/r8188eu/include/drv_types_linux.h
 create mode 100644 drivers/staging/r8188eu/include/ethernet.h
 create mode 100644 drivers/staging/r8188eu/include/h2clbk.h
 create mode 100644 drivers/staging/r8188eu/include/hal_com.h
 create mode 100644 drivers/staging/r8188eu/include/hal_intf.h
 create mode 100644 drivers/staging/r8188eu/include/ieee80211.h
 create mode 100644 drivers/staging/r8188eu/include/ieee80211_ext.h
 create mode 100644 drivers/staging/r8188eu/include/if_ether.h
 create mode 100644 drivers/staging/r8188eu/include/ioctl_cfg80211.h
 create mode 100644 drivers/staging/r8188eu/include/ip.h
 create mode 100644 drivers/staging/r8188eu/include/mlme_osdep.h
 create mode 100644 drivers/staging/r8188eu/include/mp_custom_oid.h
 create mode 100644 drivers/staging/r8188eu/include/nic_spec.h
 create mode 100644 drivers/staging/r8188eu/include/odm.h
 create mode 100644 drivers/staging/r8188eu/include/odm_HWConfig.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RTL8188E.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegConfig8188E.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11N.h
 create mode 100644 drivers/staging/r8188eu/include/odm_debug.h
 create mode 100644 drivers/staging/r8188eu/include/odm_interface.h
 create mode 100644 drivers/staging/r8188eu/include/odm_precomp.h
 create mode 100644 drivers/staging/r8188eu/include/odm_reg.h
 create mode 100644 drivers/staging/r8188eu/include/odm_types.h
 create mode 100644 drivers/staging/r8188eu/include/osdep_intf.h
 create mode 100644 drivers/staging/r8188eu/include/osdep_service.h
 create mode 100644 drivers/staging/r8188eu/include/recv_osdep.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_cmd.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_dm.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_hal.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_led.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_recv.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_rf.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_spec.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_sreset.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_xmit.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_android.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ap.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_br_ext.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_cmd.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_debug.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_eeprom.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_efuse.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_event.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ht.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_io.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_set.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_iol.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_led.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mlme.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mlme_ext.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp_ioctl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_p2p.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_pwrctrl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_qos.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_recv.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_rf.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_security.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_sreset.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_version.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_xmit.h
 create mode 100644 drivers/staging/r8188eu/include/sta_info.h
 create mode 100644 drivers/staging/r8188eu/include/usb_hal.h
 create mode 100644 drivers/staging/r8188eu/include/usb_ops.h
 create mode 100644 drivers/staging/r8188eu/include/usb_ops_linux.h
 create mode 100644 drivers/staging/r8188eu/include/usb_osintf.h
 create mode 100644 drivers/staging/r8188eu/include/usb_vendor_req.h
 create mode 100644 drivers/staging/r8188eu/include/wifi.h
 create mode 100644 drivers/staging/r8188eu/include/wlan_bssdef.h
 create mode 100644 drivers/staging/r8188eu/include/xmit_osdep.h
 create mode 100644 drivers/staging/r8188eu/os_dep/ioctl_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/mlme_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/os_intfs.c
 create mode 100644 drivers/staging/r8188eu/os_dep/osdep_service.c
 create mode 100644 drivers/staging/r8188eu/os_dep/recv_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/rtw_android.c
 create mode 100644 drivers/staging/r8188eu/os_dep/usb_intf.c
 create mode 100644 drivers/staging/r8188eu/os_dep/usb_ops_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/xmit_linux.c

-- 
2.31.1

