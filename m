Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC203D4394
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhGWXa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhGWXa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:30:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FC7C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:10:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q3so4080306wrx.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWegDAe5qyllBe7LEd6VHVexyNFSmLrJGHoOJT352Ew=;
        b=vgIjQD/UQueHFjOQ677yuIW/YpmUumlqPycQDeUG0ky5wKuFCo6WVsXXVRH9ZVjFs9
         sdazCPQI0xZYDs1oBm26qIbJeEST5Qjf8dMBpUxvUu1e4USOJ173345jSe+GklaiYk2T
         M6ynbYfLbZtq/sCW9nEKtRWu4iMAU3sOsnCKMTCvw0sYhViCJyJTi8yz6MSA6eXmeWId
         rdHq1uWmGiCyMh6GpfoJfpR7LI5PuePWn3fHx2/sUdF8C00boxa7vEErVAvdaAmCZNzi
         k+SV01foq7mYqNQOgOAr9jeNVve3WiKsVVKk+do4PMFm+fnI+9R1FCWhz7axO3qz58qb
         mmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWegDAe5qyllBe7LEd6VHVexyNFSmLrJGHoOJT352Ew=;
        b=a9t9RXMjFiSGKDqlhJX7B5g5tznn41ajGFhWthuGX519HsgkQCvQtkYfDhjfl4TlkK
         D2NQKnAVsYPWwMxcJGEEF/ryxShIpDGpldSyIcq/dC9NbCL4NYaM1YYZ/J/Y6D4PT8gH
         XnLFAl6cGwtIO05zTPoINVV9OUmm7hWYoSM36PrjygiF1j6d579+eRtUlrYh8+qPd63K
         8d9BL4rCSm9lEQrNgQLx/axQ9mDcdB8XLHyCBcddKE9zw3nEk2EvlntEwzVyX37srDtQ
         Uj0c8Gpk0IKHVyJ3FWV983f1AL2/sAfFd4CIWSiiyKGV+qvsu+ZrI9M271I4E6bXLMqh
         C3Hg==
X-Gm-Message-State: AOAM532KSeEHcTfM3Yu15+oDaOClRD1Fy05CnsJgRlKZne6JgmOX3tHP
        SR/IIAuUj+7ZDzUUQ8C6h1arXg==
X-Google-Smtp-Source: ABdhPJxCxf4t/kyRGcfveRuyYuwzuU5WzskcPPfgpDzbO8JSTpf9vk8etLkMVZNEBqyb4hUoW3+N6Q==
X-Received: by 2002:a5d:5606:: with SMTP id l6mr7496839wrv.190.1627085457830;
        Fri, 23 Jul 2021 17:10:57 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id k24sm35491305wrh.30.2021.07.23.17.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 17:10:56 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: [PATCH v3 0/7] staging: rtl8188eu: replace driver with better version
Date:   Sat, 24 Jul 2021 01:10:48 +0100
Message-Id: <20210724001055.1613840-1-phil@philpotter.co.uk>
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

(1) Removes the current driver from staging.
(2) Imports the GitHub version mentioned above in its place.

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

Phillip Potter (7):
  staging: rtl8188eu: remove existing staging driver
  staging: r8188eu: introduce new core dir for RTL8188eu driver
  staging: r8188eu: introduce new hal dir for RTL8188eu driver
  staging: r8188eu: introduce new os_dep dir for RTL8188eu driver
  staging: r8188eu: introduce new include dir for RTL8188eu driver
  staging: r8188eu: introduce new supporting files for RTL8188eu driver
  staging: r8188eu: attach newly imported driver to build system

 drivers/staging/Kconfig                       |    2 +-
 drivers/staging/Makefile                      |    2 +-
 .../staging/{rtl8188eu => r8188eu}/Kconfig    |    2 -
 drivers/staging/r8188eu/Makefile              |  129 +
 .../{rtl8188eu => r8188eu}/core/rtw_ap.c      |  987 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c     | 1184 +++
 drivers/staging/r8188eu/core/rtw_cmd.c        | 2206 +++++
 drivers/staging/r8188eu/core/rtw_debug.c      |  943 ++
 drivers/staging/r8188eu/core/rtw_efuse.c      |  872 ++
 drivers/staging/r8188eu/core/rtw_ieee80211.c  | 1625 ++++
 drivers/staging/r8188eu/core/rtw_io.c         |  323 +
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 1118 +++
 drivers/staging/r8188eu/core/rtw_iol.c        |  209 +
 drivers/staging/r8188eu/core/rtw_led.c        | 1705 ++++
 .../{rtl8188eu => r8188eu}/core/rtw_mlme.c    | 1431 ++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 8407 +++++++++++++++++
 drivers/staging/r8188eu/core/rtw_mp.c         | 1000 ++
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   | 1352 +++
 drivers/staging/r8188eu/core/rtw_p2p.c        | 2068 ++++
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  655 ++
 .../{rtl8188eu => r8188eu}/core/rtw_recv.c    | 1198 ++-
 .../{rtl8188eu => r8188eu}/core/rtw_rf.c      |   34 +-
 drivers/staging/r8188eu/core/rtw_security.c   | 1757 ++++
 drivers/staging/r8188eu/core/rtw_sreset.c     |   79 +
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  609 ++
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 1690 ++++
 .../{rtl8188eu => r8188eu}/core/rtw_xmit.c    | 1112 ++-
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c  |   86 +
 .../hal/Hal8188ERateAdaptive.c}               |  286 +-
 .../hal/HalHWImg8188E_BB.c}                   |  497 +-
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  230 +
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |  268 +
 drivers/staging/r8188eu/hal/HalPhyRf.c        |   49 +
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 1505 +++
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  132 +
 .../{rtl8188eu => r8188eu}/hal/hal_com.c      |  204 +-
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
 .../hal/rtl8188e_rxdesc.c                     |   51 +-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c |   80 +
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   |   91 +
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  111 +
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  136 +
 .../hal/rtl8188eu_xmit.c                      |  255 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 2334 +++++
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  717 ++
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  269 +
 .../staging/r8188eu/include/Hal8188EPhyReg.h  | 1088 +++
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  |  173 +
 .../include/Hal8188ERateAdaptive.h}           |   47 +-
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
 .../include/basic_types.h                     |   66 +-
 drivers/staging/r8188eu/include/cmd_osdep.h   |   32 +
 drivers/staging/r8188eu/include/drv_types.h   |  346 +
 .../staging/r8188eu/include/drv_types_linux.h |   23 +
 drivers/staging/r8188eu/include/ethernet.h    |   41 +
 drivers/staging/r8188eu/include/h2clbk.h      |   32 +
 .../{rtl8188eu => r8188eu}/include/hal_com.h  |   34 +-
 drivers/staging/r8188eu/include/hal_intf.h    |  430 +
 .../include/ieee80211.h                       |  663 +-
 .../staging/r8188eu/include/ieee80211_ext.h   |  287 +
 drivers/staging/r8188eu/include/if_ether.h    |  111 +
 .../staging/r8188eu/include/ioctl_cfg80211.h  |  107 +
 drivers/staging/r8188eu/include/ip.h          |  125 +
 drivers/staging/r8188eu/include/mlme_osdep.h  |   35 +
 .../staging/r8188eu/include/mp_custom_oid.h   |  349 +
 drivers/staging/r8188eu/include/nic_spec.h    |   41 +
 .../{rtl8188eu => r8188eu}/include/odm.h      |  301 +-
 .../include/odm_HWConfig.h}                   |   44 +-
 .../staging/r8188eu/include/odm_RTL8188E.h    |   56 +
 .../r8188eu/include/odm_RegConfig8188E.h      |   43 +
 .../r8188eu/include/odm_RegDefine11AC.h       |   46 +
 .../r8188eu/include/odm_RegDefine11N.h        |  160 +
 drivers/staging/r8188eu/include/odm_debug.h   |  143 +
 .../staging/r8188eu/include/odm_interface.h   |  164 +
 .../include/odm_precomp.h                     |   54 +-
 drivers/staging/r8188eu/include/odm_reg.h     |  116 +
 drivers/staging/r8188eu/include/odm_types.h   |   61 +
 drivers/staging/r8188eu/include/osdep_intf.h  |   83 +
 .../staging/r8188eu/include/osdep_service.h   |  489 +
 drivers/staging/r8188eu/include/recv_osdep.h  |   54 +
 .../include/rtl8188e_cmd.h                    |   54 +-
 drivers/staging/r8188eu/include/rtl8188e_dm.h |   62 +
 .../include/rtl8188e_hal.h                    |  241 +-
 .../staging/r8188eu/include/rtl8188e_led.h    |   34 +
 .../staging/r8188eu/include/rtl8188e_recv.h   |   69 +
 drivers/staging/r8188eu/include/rtl8188e_rf.h |   35 +
 .../include/rtl8188e_spec.h                   |  686 +-
 .../staging/r8188eu/include/rtl8188e_sreset.h |   31 +
 .../include/rtl8188e_xmit.h                   |   42 +-
 .../include/rtw_android.h                     |   16 +-
 .../{rtl8188eu => r8188eu}/include/rtw_ap.h   |   24 +-
 drivers/staging/r8188eu/include/rtw_br_ext.h  |   66 +
 drivers/staging/r8188eu/include/rtw_cmd.h     |  991 ++
 drivers/staging/r8188eu/include/rtw_debug.h   |  274 +
 .../include/rtw_eeprom.h                      |   34 +-
 drivers/staging/r8188eu/include/rtw_efuse.h   |  150 +
 drivers/staging/r8188eu/include/rtw_event.h   |  113 +
 drivers/staging/r8188eu/include/rtw_ht.h      |   44 +
 drivers/staging/r8188eu/include/rtw_io.h      |  387 +
 .../include/rtw_ioctl.h                       |   41 +-
 .../staging/r8188eu/include/rtw_ioctl_rtl.h   |   79 +
 .../staging/r8188eu/include/rtw_ioctl_set.h   |   49 +
 drivers/staging/r8188eu/include/rtw_iol.h     |   84 +
 drivers/staging/r8188eu/include/rtw_led.h     |  201 +
 drivers/staging/r8188eu/include/rtw_mlme.h    |  649 ++
 .../include/rtw_mlme_ext.h                    |  358 +-
 drivers/staging/r8188eu/include/rtw_mp.h      |  492 +
 .../staging/r8188eu/include/rtw_mp_ioctl.h    |  339 +
 .../r8188eu/include/rtw_mp_phy_regdef.h       | 1079 +++
 drivers/staging/r8188eu/include/rtw_p2p.h     |  135 +
 .../include/rtw_pwrctrl.h                     |   77 +-
 drivers/staging/r8188eu/include/rtw_qos.h     |   30 +
 drivers/staging/r8188eu/include/rtw_recv.h    |  473 +
 .../{rtl8188eu => r8188eu}/include/rtw_rf.h   |   38 +-
 .../staging/r8188eu/include/rtw_security.h    |  382 +
 drivers/staging/r8188eu/include/rtw_sreset.h  |   50 +
 drivers/staging/r8188eu/include/rtw_version.h |    1 +
 .../{rtl8188eu => r8188eu}/include/rtw_xmit.h |   63 +-
 .../{rtl8188eu => r8188eu}/include/sta_info.h |   61 +-
 drivers/staging/r8188eu/include/usb_hal.h     |   26 +
 drivers/staging/r8188eu/include/usb_ops.h     |  115 +
 .../staging/r8188eu/include/usb_ops_linux.h   |   55 +
 drivers/staging/r8188eu/include/usb_osintf.h  |   45 +
 .../staging/r8188eu/include/usb_vendor_req.h  |   51 +
 drivers/staging/r8188eu/include/wifi.h        | 1105 +++
 .../include/wlan_bssdef.h                     |  153 +-
 drivers/staging/r8188eu/include/xmit_osdep.h  |   67 +
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 8178 ++++++++++++++++
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |  302 +
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 1283 +++
 .../staging/r8188eu/os_dep/osdep_service.c    |  535 ++
 drivers/staging/r8188eu/os_dep/recv_linux.c   |  270 +
 .../os_dep/rtw_android.c                      |  134 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  863 ++
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  283 +
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |  282 +
 drivers/staging/rtl8188eu/Makefile            |   56 -
 drivers/staging/rtl8188eu/TODO                |   14 -
 drivers/staging/rtl8188eu/core/mac_cfg.c      |  120 -
 drivers/staging/rtl8188eu/core/rtw_cmd.c      | 1219 ---
 drivers/staging/rtl8188eu/core/rtw_efuse.c    |  850 --
 .../staging/rtl8188eu/core/rtw_ieee80211.c    |  990 --
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    |  512 -
 drivers/staging/rtl8188eu/core/rtw_iol.c      |   19 -
 drivers/staging/rtl8188eu/core/rtw_led.c      |  460 -
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 5172 ----------
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c  |  581 --
 drivers/staging/rtl8188eu/core/rtw_security.c |  869 --
 drivers/staging/rtl8188eu/core/rtw_sreset.c   |   21 -
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c  |  479 -
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 1373 ---
 drivers/staging/rtl8188eu/hal/fw.c            |  202 -
 drivers/staging/rtl8188eu/hal/hal_intf.c      |   60 -
 drivers/staging/rtl8188eu/hal/odm.c           |  966 --
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c  |  397 -
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c  |  335 -
 drivers/staging/rtl8188eu/hal/phy.c           | 1276 ---
 drivers/staging/rtl8188eu/hal/pwrseq.c        |   36 -
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c     |   72 -
 drivers/staging/rtl8188eu/hal/rf.c            |  289 -
 drivers/staging/rtl8188eu/hal/rf_cfg.c        |  247 -
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c  |  591 --
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c   |  217 -
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c |  517 -
 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c |   25 -
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c |   55 -
 .../staging/rtl8188eu/hal/rtl8188eu_recv.c    |   83 -
 drivers/staging/rtl8188eu/hal/usb_halinit.c   | 1862 ----
 drivers/staging/rtl8188eu/include/HalVerDef.h |   37 -
 drivers/staging/rtl8188eu/include/drv_types.h |  176 -
 drivers/staging/rtl8188eu/include/fw.h        |   44 -
 .../rtl8188eu/include/hal8188e_phy_cfg.h      |  175 -
 .../rtl8188eu/include/hal8188e_phy_reg.h      |  201 -
 drivers/staging/rtl8188eu/include/hal_intf.h  |  203 -
 .../staging/rtl8188eu/include/mlme_osdep.h    |   21 -
 drivers/staging/rtl8188eu/include/mon.h       |   28 -
 .../staging/rtl8188eu/include/odm_rtl8188e.h  |   39 -
 drivers/staging/rtl8188eu/include/odm_types.h |   24 -
 .../staging/rtl8188eu/include/osdep_intf.h    |   35 -
 .../staging/rtl8188eu/include/osdep_service.h |   81 -
 drivers/staging/rtl8188eu/include/phy.h       |   26 -
 drivers/staging/rtl8188eu/include/phydm_reg.h |   22 -
 .../rtl8188eu/include/phydm_regdefine11n.h    |   53 -
 drivers/staging/rtl8188eu/include/pwrseq.h    |  130 -
 drivers/staging/rtl8188eu/include/pwrseqcmd.h |   48 -
 .../staging/rtl8188eu/include/recv_osdep.h    |   26 -
 drivers/staging/rtl8188eu/include/rf.h        |   12 -
 .../staging/rtl8188eu/include/rtl8188e_dm.h   |   40 -
 .../staging/rtl8188eu/include/rtl8188e_recv.h |   53 -
 drivers/staging/rtl8188eu/include/rtw_cmd.h   |  361 -
 drivers/staging/rtl8188eu/include/rtw_efuse.h |   67 -
 drivers/staging/rtl8188eu/include/rtw_event.h |   81 -
 drivers/staging/rtl8188eu/include/rtw_ht.h    |   26 -
 .../staging/rtl8188eu/include/rtw_ioctl_set.h |   28 -
 drivers/staging/rtl8188eu/include/rtw_iol.h   |   14 -
 drivers/staging/rtl8188eu/include/rtw_led.h   |   98 -
 drivers/staging/rtl8188eu/include/rtw_mlme.h  |  355 -
 drivers/staging/rtl8188eu/include/rtw_recv.h  |  262 -
 .../staging/rtl8188eu/include/rtw_security.h  |  241 -
 .../staging/rtl8188eu/include/rtw_sreset.h    |   30 -
 .../staging/rtl8188eu/include/usb_ops_linux.h |   26 -
 drivers/staging/rtl8188eu/include/wifi.h      |  355 -
 .../staging/rtl8188eu/include/xmit_osdep.h    |   32 -
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 2705 ------
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c |  167 -
 drivers/staging/rtl8188eu/os_dep/mon.c        |  183 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   |  657 --
 .../staging/rtl8188eu/os_dep/osdep_service.c  |   63 -
 drivers/staging/rtl8188eu/os_dep/recv_linux.c |  138 -
 drivers/staging/rtl8188eu/os_dep/usb_intf.c   |  479 -
 .../staging/rtl8188eu/os_dep/usb_ops_linux.c  |  644 --
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c |  189 -
 233 files changed, 75527 insertions(+), 31326 deletions(-)
 rename drivers/staging/{rtl8188eu => r8188eu}/Kconfig (96%)
 create mode 100644 drivers/staging/r8188eu/Makefile
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_ap.c (57%)
 create mode 100644 drivers/staging/r8188eu/core/rtw_br_ext.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_cmd.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_debug.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_efuse.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_ieee80211.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_io.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_ioctl_set.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_iol.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_led.c
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_mlme.c (50%)
 create mode 100644 drivers/staging/r8188eu/core/rtw_mlme_ext.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_mp.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_mp_ioctl.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_p2p.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_pwrctrl.c
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_recv.c (50%)
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_rf.c (60%)
 create mode 100644 drivers/staging/r8188eu/core/rtw_security.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_sreset.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_sta_mgt.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_wlan_util.c
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_xmit.c (53%)
 create mode 100644 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
 rename drivers/staging/{rtl8188eu/hal/hal8188e_rate_adaptive.c => r8188eu/hal/Hal8188ERateAdaptive.c} (57%)
 rename drivers/staging/{rtl8188eu/hal/bb_cfg.c => r8188eu/hal/HalHWImg8188E_BB.c} (53%)
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPhyRf.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/hal_com.c (58%)
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
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/rtl8188e_rxdesc.c (79%)
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_sreset.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_xmit.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_led.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/rtl8188eu_xmit.c (68%)
 create mode 100644 drivers/staging/r8188eu/hal/usb_halinit.c
 create mode 100644 drivers/staging/r8188eu/hal/usb_ops_linux.c
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyReg.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
 rename drivers/staging/{rtl8188eu/include/hal8188e_rate_adaptive.h => r8188eu/include/Hal8188ERateAdaptive.h} (69%)
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
 rename drivers/staging/{rtl8188eu => r8188eu}/include/basic_types.h (68%)
 create mode 100644 drivers/staging/r8188eu/include/cmd_osdep.h
 create mode 100644 drivers/staging/r8188eu/include/drv_types.h
 create mode 100644 drivers/staging/r8188eu/include/drv_types_linux.h
 create mode 100644 drivers/staging/r8188eu/include/ethernet.h
 create mode 100644 drivers/staging/r8188eu/include/h2clbk.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/hal_com.h (78%)
 create mode 100644 drivers/staging/r8188eu/include/hal_intf.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/ieee80211.h (52%)
 create mode 100644 drivers/staging/r8188eu/include/ieee80211_ext.h
 create mode 100644 drivers/staging/r8188eu/include/if_ether.h
 create mode 100644 drivers/staging/r8188eu/include/ioctl_cfg80211.h
 create mode 100644 drivers/staging/r8188eu/include/ip.h
 create mode 100644 drivers/staging/r8188eu/include/mlme_osdep.h
 create mode 100644 drivers/staging/r8188eu/include/mp_custom_oid.h
 create mode 100644 drivers/staging/r8188eu/include/nic_spec.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/odm.h (81%)
 rename drivers/staging/{rtl8188eu/include/odm_hwconfig.h => r8188eu/include/odm_HWConfig.h} (60%)
 create mode 100644 drivers/staging/r8188eu/include/odm_RTL8188E.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegConfig8188E.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11N.h
 create mode 100644 drivers/staging/r8188eu/include/odm_debug.h
 create mode 100644 drivers/staging/r8188eu/include/odm_interface.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/odm_precomp.h (52%)
 create mode 100644 drivers/staging/r8188eu/include/odm_reg.h
 create mode 100644 drivers/staging/r8188eu/include/odm_types.h
 create mode 100644 drivers/staging/r8188eu/include/osdep_intf.h
 create mode 100644 drivers/staging/r8188eu/include/osdep_service.h
 create mode 100644 drivers/staging/r8188eu/include/recv_osdep.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_cmd.h (52%)
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_dm.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_hal.h (53%)
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_led.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_recv.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_rf.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_spec.h (59%)
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_sreset.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_xmit.h (70%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_android.h (67%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_ap.h (63%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_br_ext.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_cmd.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_debug.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_eeprom.h (72%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_efuse.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_event.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ht.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_io.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_ioctl.h (60%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_set.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_iol.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_led.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mlme.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_mlme_ext.h (63%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp_ioctl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_p2p.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_pwrctrl.h (76%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_qos.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_recv.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_rf.h (71%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_security.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_sreset.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_version.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_xmit.h (84%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/sta_info.h (83%)
 create mode 100644 drivers/staging/r8188eu/include/usb_hal.h
 create mode 100644 drivers/staging/r8188eu/include/usb_ops.h
 create mode 100644 drivers/staging/r8188eu/include/usb_ops_linux.h
 create mode 100644 drivers/staging/r8188eu/include/usb_osintf.h
 create mode 100644 drivers/staging/r8188eu/include/usb_vendor_req.h
 create mode 100644 drivers/staging/r8188eu/include/wifi.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/wlan_bssdef.h (63%)
 create mode 100644 drivers/staging/r8188eu/include/xmit_osdep.h
 create mode 100644 drivers/staging/r8188eu/os_dep/ioctl_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/mlme_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/os_intfs.c
 create mode 100644 drivers/staging/r8188eu/os_dep/osdep_service.c
 create mode 100644 drivers/staging/r8188eu/os_dep/recv_linux.c
 rename drivers/staging/{rtl8188eu => r8188eu}/os_dep/rtw_android.c (57%)
 create mode 100644 drivers/staging/r8188eu/os_dep/usb_intf.c
 create mode 100644 drivers/staging/r8188eu/os_dep/usb_ops_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/xmit_linux.c
 delete mode 100644 drivers/staging/rtl8188eu/Makefile
 delete mode 100644 drivers/staging/rtl8188eu/TODO
 delete mode 100644 drivers/staging/rtl8188eu/core/mac_cfg.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_cmd.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_efuse.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_ieee80211.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_iol.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_led.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_security.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_sreset.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_wlan_util.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/fw.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/hal_intf.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm_hwconfig.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/phy.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/pwrseq.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/pwrseqcmd.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rf.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rf_cfg.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/usb_halinit.c
 delete mode 100644 drivers/staging/rtl8188eu/include/HalVerDef.h
 delete mode 100644 drivers/staging/rtl8188eu/include/drv_types.h
 delete mode 100644 drivers/staging/rtl8188eu/include/fw.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal8188e_phy_reg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal_intf.h
 delete mode 100644 drivers/staging/rtl8188eu/include/mlme_osdep.h
 delete mode 100644 drivers/staging/rtl8188eu/include/mon.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_rtl8188e.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_types.h
 delete mode 100644 drivers/staging/rtl8188eu/include/osdep_intf.h
 delete mode 100644 drivers/staging/rtl8188eu/include/osdep_service.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phy.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phydm_reg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phydm_regdefine11n.h
 delete mode 100644 drivers/staging/rtl8188eu/include/pwrseq.h
 delete mode 100644 drivers/staging/rtl8188eu/include/pwrseqcmd.h
 delete mode 100644 drivers/staging/rtl8188eu/include/recv_osdep.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rf.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtl8188e_dm.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtl8188e_recv.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_cmd.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_efuse.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_event.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_ht.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_ioctl_set.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_iol.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_led.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_mlme.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_recv.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_security.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_sreset.h
 delete mode 100644 drivers/staging/rtl8188eu/include/usb_ops_linux.h
 delete mode 100644 drivers/staging/rtl8188eu/include/wifi.h
 delete mode 100644 drivers/staging/rtl8188eu/include/xmit_osdep.h
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/mlme_linux.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/mon.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/os_intfs.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/osdep_service.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/recv_linux.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/usb_intf.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/xmit_linux.c

-- 
2.31.1

