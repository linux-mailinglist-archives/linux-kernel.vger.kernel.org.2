Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32B63D30F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhGWABw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhGWABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:01:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2811C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:42:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l6so4342887wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACeCDz/QOjaDVyOu3iAQW2dcknoATmWCYVydgraocTk=;
        b=kyrdhPeILkctpqIJJScUo1Fj4CqpU+hyEzyVSefrbhQAndTrv3IrnKl5sgl04smZhl
         cKE7evgp7zIMW2p51Th+StbTbU+Ic0yN/PoQ99GEF1q4uQGX46aS1MC4vkpC13WPwnAg
         QEUy6E9Adfl4Uad4Ipo5zZ46P+7oyQCI/d37FS/Og7jT0bXiPkrkZ9Yt/ORI7BhcBZ1q
         KPXTAZ8DNT061v08Q5HanZ7StmCy3gVH/zBkWf3fCBASVMpEGOED9k4/Yd/WcAgCZaB9
         /9xabDZzm/F2I+k1fodlc6IH8/TqkRn55/BLnS6YuwEzwkqGC1BrlKlJy+GrZuJGlz96
         AkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACeCDz/QOjaDVyOu3iAQW2dcknoATmWCYVydgraocTk=;
        b=rrnRSKBwdMTXcGfrv/rPDvkqfnsYeYk61tB1RCTZzwN61uCdVIJA64mEnPiFlLKUtl
         a1QvNxiFzd68iSVLNxUSccy921nfzPtkTTUx82QDUSmwxv07eg0JH12IapnqkwgOBYza
         /SibA5S+6fRLHpP01JgImiJjvlzklg5qrNi3bGvzPp9DOyG7D8SKyv7TgCWsyZIcfygF
         tVTVAvKb1QNg+oo5oY506dciGA+5B94eXw3wXoHrFGeR6wJBBTo8j0z6wn5bRkP2ZWTI
         znWlzT9lXiMHWi2qHoWed/1uOARPZPBhScu6rSfBXYWcERkZ1ZLxjD8j0b/KEnPpigki
         zkJA==
X-Gm-Message-State: AOAM530oa12ISBXJcf/jehy+L1iCvrxaWYGxtEKspNjfpBmDowEr4A24
        mRFeY+dJuVP987TeN4yj6+lDFQ==
X-Google-Smtp-Source: ABdhPJxamuNfyREQAK21PZ54N+7PV4vxCsb9f2n9DRlhHFPiR6TKheFBRE+gcy8YLn8+4FzZZk0GXQ==
X-Received: by 2002:a05:600c:35d3:: with SMTP id r19mr2029127wmq.84.1627000936125;
        Thu, 22 Jul 2021 17:42:16 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m4sm31630498wrs.14.2021.07.22.17.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 17:42:15 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: [PATCH 0/7] staging: rtl8188eu: replace driver with better version
Date:   Fri, 23 Jul 2021 01:42:07 +0100
Message-Id: <20210723004214.912295-1-phil@philpotter.co.uk>
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
version on Larry Finger's GitHub account, branch v5.2.2.4. This series
of patches therefore:

(1) Removes the current driver from staging.
(2) Imports the GitHub version mentioned above in its place.

There is plenty of work to do to this driver, including to its Makefile,
but it is at least buildable/usable for now.

Phillip Potter (7):
  staging: rtl8188eu: remove existing staging driver
  staging: rtl8188eu: introduce new core dir for RTL8188eu driver
  staging: rtl8188eu: introduce new hal dir for RTL8188eu driver
  staging: rtl8188eu: introduce new os_dep dir for RTL8188eu driver
  staging: rtl8188eu: introduce new include dir for RTL8188eu driver
  staging: rtl8188eu: introduce new supporting files for RTL8188eu
    driver
  staging: rtl8188eu: attach newly imported driver to build system

 drivers/staging/Kconfig                       |     4 +-
 drivers/staging/Makefile                      |     2 +-
 drivers/staging/rtl8188eu/COPYING             |   356 +
 drivers/staging/rtl8188eu/Makefile            |   565 +-
 drivers/staging/rtl8188eu/TODO                |    14 -
 drivers/staging/rtl8188eu/core/mac_cfg.c      |   120 -
 drivers/staging/rtl8188eu/core/rtw_ap.c       |  3577 ++-
 .../staging/rtl8188eu/core/rtw_beamforming.c  |  3071 +++
 drivers/staging/rtl8188eu/core/rtw_br_ext.c   |  1529 ++
 drivers/staging/rtl8188eu/core/rtw_btcoex.c   |  1632 ++
 .../rtl8188eu/core/rtw_btcoex_wifionly.c      |    26 +
 drivers/staging/rtl8188eu/core/rtw_cmd.c      |  4738 +++-
 drivers/staging/rtl8188eu/core/rtw_debug.c    |  4800 +++++
 drivers/staging/rtl8188eu/core/rtw_efuse.c    |  1995 +-
 .../staging/rtl8188eu/core/rtw_ieee80211.c    |  2249 +-
 drivers/staging/rtl8188eu/core/rtw_io.c       |   473 +
 .../staging/rtl8188eu/core/rtw_ioctl_query.c  |     6 +
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    |   949 +-
 drivers/staging/rtl8188eu/core/rtw_iol.c      |   356 +-
 drivers/staging/rtl8188eu/core/rtw_led.c      |  1693 +-
 drivers/staging/rtl8188eu/core/rtw_mi.c       |  1198 +
 drivers/staging/rtl8188eu/core/rtw_mlme.c     |  4134 +++-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 17993 ++++++++++++----
 drivers/staging/rtl8188eu/core/rtw_mp.c       |  2620 +++
 drivers/staging/rtl8188eu/core/rtw_odm.c      |   430 +
 drivers/staging/rtl8188eu/core/rtw_p2p.c      |  5351 +++++
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c  |  2497 ++-
 drivers/staging/rtl8188eu/core/rtw_recv.c     |  3787 +++-
 drivers/staging/rtl8188eu/core/rtw_rf.c       |  1119 +-
 drivers/staging/rtl8188eu/core/rtw_security.c |  3112 ++-
 drivers/staging/rtl8188eu/core/rtw_sreset.c   |   292 +-
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c  |   999 +-
 drivers/staging/rtl8188eu/core/rtw_tdls.c     |  3092 +++
 .../staging/rtl8188eu/core/rtw_wlan_util.c    |  4601 +++-
 drivers/staging/rtl8188eu/core/rtw_xmit.c     |  4746 +++-
 .../staging/rtl8188eu/hal/Hal8188EPwrSeq.c    |    71 +
 .../rtl8188eu/hal/HalEfuseMask8188E_USB.c     |    84 +
 .../rtl8188eu/hal/HalEfuseMask8188E_USB.h     |    23 +
 drivers/staging/rtl8188eu/hal/HalPwrSeqCmd.c  |   145 +
 drivers/staging/rtl8188eu/hal/bb_cfg.c        |   681 -
 .../staging/rtl8188eu/hal/btc/halbtcoutsrc.h  |   997 +
 .../staging/rtl8188eu/hal/btc/mp_precomp.h    |    49 +
 drivers/staging/rtl8188eu/hal/efuse_mask.h    |     2 +
 drivers/staging/rtl8188eu/hal/fw.c            |   202 -
 .../rtl8188eu/hal/hal8188e_rate_adaptive.c    |   646 -
 drivers/staging/rtl8188eu/hal/hal8188e_s_fw.c |  7283 +++++++
 drivers/staging/rtl8188eu/hal/hal8188e_s_fw.h |    26 +
 drivers/staging/rtl8188eu/hal/hal8188e_t_fw.c |  7730 +++++++
 drivers/staging/rtl8188eu/hal/hal8188e_t_fw.h |    25 +
 .../rtl8188eu/hal/hal8188erateadaptive.c      |  1022 +
 .../rtl8188eu/hal/hal8188erateadaptive.h      |    65 +
 drivers/staging/rtl8188eu/hal/hal8188ereg.h   |    48 +
 drivers/staging/rtl8188eu/hal/hal_btcoex.c    |  3786 ++++
 .../rtl8188eu/hal/hal_btcoex_wifionly.c       |   131 +
 drivers/staging/rtl8188eu/hal/hal_com.c       | 10501 ++++++++-
 drivers/staging/rtl8188eu/hal/hal_com_c2h.h   |   103 +
 .../staging/rtl8188eu/hal/hal_com_phycfg.c    |  5150 +++++
 drivers/staging/rtl8188eu/hal/hal_dm.c        |   186 +
 drivers/staging/rtl8188eu/hal/hal_dm.h        |     9 +
 drivers/staging/rtl8188eu/hal/hal_intf.c      |  1281 +-
 drivers/staging/rtl8188eu/hal/hal_mcc.c       |  1862 ++
 drivers/staging/rtl8188eu/hal/hal_mp.c        |   883 +
 drivers/staging/rtl8188eu/hal/hal_phy.c       |   244 +
 drivers/staging/rtl8188eu/hal/hal_usb.c       |   452 +
 drivers/staging/rtl8188eu/hal/hal_usb_led.c   |  4235 ++++
 drivers/staging/rtl8188eu/hal/halcomtxbf.h    |   135 +
 drivers/staging/rtl8188eu/hal/halhwimg.h      |    78 +
 .../staging/rtl8188eu/hal/halhwimg8188e_bb.c  |  1730 ++
 .../staging/rtl8188eu/hal/halhwimg8188e_bb.h  |    42 +
 .../staging/rtl8188eu/hal/halhwimg8188e_mac.c |   272 +
 .../staging/rtl8188eu/hal/halhwimg8188e_mac.h |    22 +
 .../staging/rtl8188eu/hal/halhwimg8188e_rf.c  |  2183 ++
 .../staging/rtl8188eu/hal/halhwimg8188e_rf.h  |   112 +
 .../staging/rtl8188eu/hal/halphyrf_8188e_ce.c |  1973 ++
 .../staging/rtl8188eu/hal/halphyrf_8188e_ce.h |    92 +
 drivers/staging/rtl8188eu/hal/halphyrf_ap.h   |    76 +
 drivers/staging/rtl8188eu/hal/halphyrf_ce.c   |   635 +
 drivers/staging/rtl8188eu/hal/halphyrf_ce.h   |    81 +
 .../staging/rtl8188eu/hal/haltxbfinterface.h  |    14 +
 drivers/staging/rtl8188eu/hal/haltxbfjaguar.h |    74 +
 drivers/staging/rtl8188eu/hal/mp_precomp.h    |     3 +
 drivers/staging/rtl8188eu/hal/odm.c           |   966 -
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c  |   397 -
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c  |   335 -
 drivers/staging/rtl8188eu/hal/phy.c           |  1276 --
 drivers/staging/rtl8188eu/hal/phydm.c         |  2341 ++
 drivers/staging/rtl8188eu/hal/phydm.h         |  1069 +
 drivers/staging/rtl8188eu/hal/phydm_acs.c     |   167 +
 drivers/staging/rtl8188eu/hal/phydm_acs.h     |    50 +
 .../staging/rtl8188eu/hal/phydm_adaptivity.c  |   823 +
 .../staging/rtl8188eu/hal/phydm_adaptivity.h  |   159 +
 .../rtl8188eu/hal/phydm_adc_sampling.c        |   594 +
 .../rtl8188eu/hal/phydm_adc_sampling.h        |   123 +
 drivers/staging/rtl8188eu/hal/phydm_antdect.c |   847 +
 drivers/staging/rtl8188eu/hal/phydm_antdect.h |    78 +
 drivers/staging/rtl8188eu/hal/phydm_antdiv.c  |  3194 +++
 drivers/staging/rtl8188eu/hal/phydm_antdiv.h  |   516 +
 .../staging/rtl8188eu/hal/phydm_beamforming.h |    27 +
 drivers/staging/rtl8188eu/hal/phydm_ccx.c     |   389 +
 drivers/staging/rtl8188eu/hal/phydm_ccx.h     |   102 +
 .../staging/rtl8188eu/hal/phydm_cfotracking.c |   297 +
 .../staging/rtl8188eu/hal/phydm_cfotracking.h |    53 +
 drivers/staging/rtl8188eu/hal/phydm_debug.c   |  2357 ++
 drivers/staging/rtl8188eu/hal/phydm_debug.h   |   294 +
 drivers/staging/rtl8188eu/hal/phydm_dfs.c     |   241 +
 drivers/staging/rtl8188eu/hal/phydm_dfs.h     |    59 +
 drivers/staging/rtl8188eu/hal/phydm_dig.c     |  1305 ++
 drivers/staging/rtl8188eu/hal/phydm_dig.h     |   292 +
 .../rtl8188eu/hal/phydm_dynamic_rx_path.c     |   271 +
 .../rtl8188eu/hal/phydm_dynamic_rx_path.h     |    93 +
 .../hal/phydm_dynamicbbpowersaving.c          |    90 +
 .../hal/phydm_dynamicbbpowersaving.h          |    41 +
 .../rtl8188eu/hal/phydm_dynamictxpower.c      |   132 +
 .../rtl8188eu/hal/phydm_dynamictxpower.h      |    69 +
 .../rtl8188eu/hal/phydm_edcaturbocheck.c      |   192 +
 .../rtl8188eu/hal/phydm_edcaturbocheck.h      |    49 +
 .../staging/rtl8188eu/hal/phydm_features.h    |    38 +
 .../rtl8188eu/hal/phydm_hal_txbf_api.c        |    72 +
 .../rtl8188eu/hal/phydm_hal_txbf_api.h        |    28 +
 .../staging/rtl8188eu/hal/phydm_hwconfig.c    |  2102 ++
 .../staging/rtl8188eu/hal/phydm_hwconfig.h    |   547 +
 .../staging/rtl8188eu/hal/phydm_interface.c   |   451 +
 .../staging/rtl8188eu/hal/phydm_interface.h   |   351 +
 drivers/staging/rtl8188eu/hal/phydm_iqk.h     |    49 +
 drivers/staging/rtl8188eu/hal/phydm_kfree.c   |   164 +
 drivers/staging/rtl8188eu/hal/phydm_kfree.h   |    29 +
 .../rtl8188eu/hal/phydm_noisemonitor.c        |   270 +
 .../rtl8188eu/hal/phydm_noisemonitor.h        |    31 +
 drivers/staging/rtl8188eu/hal/phydm_pathdiv.c |    95 +
 drivers/staging/rtl8188eu/hal/phydm_pathdiv.h |   136 +
 .../rtl8188eu/hal/phydm_powertracking_ce.c    |   646 +
 .../rtl8188eu/hal/phydm_powertracking_ce.h    |   285 +
 .../staging/rtl8188eu/hal/phydm_pre_define.h  |   578 +
 drivers/staging/rtl8188eu/hal/phydm_precomp.h |    60 +
 drivers/staging/rtl8188eu/hal/phydm_rainfo.c  |  2198 ++
 drivers/staging/rtl8188eu/hal/phydm_rainfo.h  |   484 +
 drivers/staging/rtl8188eu/hal/phydm_reg.h     |   116 +
 .../rtl8188eu/hal/phydm_regconfig8188e.c      |   184 +
 .../rtl8188eu/hal/phydm_regconfig8188e.h      |    79 +
 .../rtl8188eu/hal/phydm_regdefine11ac.h       |    77 +
 .../rtl8188eu/hal/phydm_regdefine11n.h        |   196 +
 .../staging/rtl8188eu/hal/phydm_rtl8188e.c    |    56 +
 .../staging/rtl8188eu/hal/phydm_rtl8188e.h    |    51 +
 drivers/staging/rtl8188eu/hal/phydm_types.h   |   142 +
 drivers/staging/rtl8188eu/hal/pwrseq.c        |    36 -
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c     |    72 -
 drivers/staging/rtl8188eu/hal/rf.c            |   289 -
 drivers/staging/rtl8188eu/hal/rf_cfg.c        |   247 -
 drivers/staging/rtl8188eu/hal/rtchnlplan.c    |   287 +
 drivers/staging/rtl8188eu/hal/rtchnlplan.h    |   615 +
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c  |   897 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c   |   390 +-
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c |  4846 ++++-
 .../staging/rtl8188eu/hal/rtl8188e_phycfg.c   |  1713 ++
 .../staging/rtl8188eu/hal/rtl8188e_rf6052.c   |   245 +
 .../staging/rtl8188eu/hal/rtl8188e_rxdesc.c   |   191 +-
 .../staging/rtl8188eu/hal/rtl8188e_sreset.c   |    84 +
 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c |   287 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c |   149 +-
 .../staging/rtl8188eu/hal/rtl8188eu_recv.c    |    80 +-
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    |  1041 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c   |  2855 +--
 drivers/staging/rtl8188eu/hal/usb_ops_linux.c |   246 +
 .../staging/rtl8188eu/hal/version_rtl8188e.h  |    10 +
 .../rtl8188eu/include/Hal8188EPhyCfg.h        |   230 +
 .../rtl8188eu/include/Hal8188EPhyReg.h        |  1089 +
 .../rtl8188eu/include/Hal8188EPwrSeq.h        |   159 +
 .../rtl8188eu/include/Hal8188FPhyCfg.h        |   123 +
 .../rtl8188eu/include/Hal8188FPhyReg.h        |  1154 +
 .../rtl8188eu/include/Hal8188FPwrSeq.h        |   198 +
 .../staging/rtl8188eu/include/HalPwrSeqCmd.h  |   119 +
 drivers/staging/rtl8188eu/include/HalVerDef.h |   177 +-
 drivers/staging/rtl8188eu/include/autoconf.h  |   340 +
 .../staging/rtl8188eu/include/basic_types.h   |   371 +-
 drivers/staging/rtl8188eu/include/circ_buf.h  |    12 +
 drivers/staging/rtl8188eu/include/cmd_osdep.h |    15 +
 .../staging/rtl8188eu/include/custom_gpio.h   |    22 +
 drivers/staging/rtl8188eu/include/drv_conf.h  |   270 +
 drivers/staging/rtl8188eu/include/drv_types.h |  1357 +-
 .../rtl8188eu/include/drv_types_linux.h       |     8 +
 drivers/staging/rtl8188eu/include/ethernet.h  |    25 +
 drivers/staging/rtl8188eu/include/fw.h        |    44 -
 drivers/staging/rtl8188eu/include/h2clbk.h    |    15 +
 .../rtl8188eu/include/hal8188e_phy_cfg.h      |   175 -
 .../rtl8188eu/include/hal8188e_phy_reg.h      |   201 -
 .../include/hal8188e_rate_adaptive.h          |    74 -
 .../staging/rtl8188eu/include/hal_btcoex.h    |    77 +
 .../rtl8188eu/include/hal_btcoex_wifionly.h   |    47 +
 drivers/staging/rtl8188eu/include/hal_com.h   |   743 +-
 .../staging/rtl8188eu/include/hal_com_h2c.h   |   535 +
 .../staging/rtl8188eu/include/hal_com_led.h   |   268 +
 .../rtl8188eu/include/hal_com_phycfg.h        |   332 +
 .../staging/rtl8188eu/include/hal_com_reg.h   |  1795 ++
 drivers/staging/rtl8188eu/include/hal_data.h  |   901 +
 .../staging/rtl8188eu/include/hal_ic_cfg.h    |    38 +
 drivers/staging/rtl8188eu/include/hal_intf.h  |   637 +-
 drivers/staging/rtl8188eu/include/hal_pg.h    |   785 +
 drivers/staging/rtl8188eu/include/hal_phy.h   |   227 +
 .../staging/rtl8188eu/include/hal_phy_reg.h   |    14 +
 drivers/staging/rtl8188eu/include/hal_sdio.h  |    20 +
 drivers/staging/rtl8188eu/include/ieee80211.h |  1350 +-
 .../staging/rtl8188eu/include/ieee80211_ext.h |   277 +
 drivers/staging/rtl8188eu/include/if_ether.h  |    95 +
 drivers/staging/rtl8188eu/include/ip.h        |   121 +
 .../rtl8188eu/include/linux/wireless.h        |    70 +
 .../staging/rtl8188eu/include/mlme_osdep.h    |    27 +-
 drivers/staging/rtl8188eu/include/mon.h       |    28 -
 .../staging/rtl8188eu/include/mp_custom_oid.h |   337 +
 drivers/staging/rtl8188eu/include/nic_spec.h  |    30 +
 drivers/staging/rtl8188eu/include/odm.h       |  1059 -
 .../staging/rtl8188eu/include/odm_hwconfig.h  |   101 -
 .../staging/rtl8188eu/include/odm_precomp.h   |    63 -
 .../staging/rtl8188eu/include/odm_rtl8188e.h  |    39 -
 drivers/staging/rtl8188eu/include/odm_types.h |    24 -
 .../staging/rtl8188eu/include/osdep_intf.h    |   128 +-
 .../staging/rtl8188eu/include/osdep_service.h |   606 +-
 .../rtl8188eu/include/osdep_service_linux.h   |   442 +
 drivers/staging/rtl8188eu/include/phy.h       |    26 -
 drivers/staging/rtl8188eu/include/phydm_reg.h |    22 -
 .../rtl8188eu/include/phydm_regdefine11n.h    |    53 -
 drivers/staging/rtl8188eu/include/pwrseq.h    |   130 -
 drivers/staging/rtl8188eu/include/pwrseqcmd.h |    48 -
 .../staging/rtl8188eu/include/recv_osdep.h    |    52 +-
 drivers/staging/rtl8188eu/include/rf.h        |    12 -
 .../staging/rtl8188eu/include/rtl8188e_cmd.h  |   120 +-
 .../staging/rtl8188eu/include/rtl8188e_dm.h   |    40 +-
 .../staging/rtl8188eu/include/rtl8188e_hal.h  |   519 +-
 .../staging/rtl8188eu/include/rtl8188e_led.h  |    14 +
 .../staging/rtl8188eu/include/rtl8188e_recv.h |   144 +-
 .../staging/rtl8188eu/include/rtl8188e_rf.h   |    16 +
 .../staging/rtl8188eu/include/rtl8188e_spec.h |  1209 +-
 .../rtl8188eu/include/rtl8188e_sreset.h       |    13 +
 .../staging/rtl8188eu/include/rtl8188e_xmit.h |   267 +-
 .../staging/rtl8188eu/include/rtw_android.h   |    65 +-
 drivers/staging/rtl8188eu/include/rtw_ap.h    |    99 +-
 .../rtl8188eu/include/rtw_beamforming.h       |   374 +
 .../staging/rtl8188eu/include/rtw_br_ext.h    |    56 +
 drivers/staging/rtl8188eu/include/rtw_bt_mp.h |   277 +
 .../staging/rtl8188eu/include/rtw_btcoex.h    |   428 +
 .../rtl8188eu/include/rtw_btcoex_wifionly.h   |    11 +
 drivers/staging/rtl8188eu/include/rtw_cmd.h   |  1337 +-
 drivers/staging/rtl8188eu/include/rtw_debug.h |   596 +
 .../staging/rtl8188eu/include/rtw_eeprom.h    |   115 +-
 drivers/staging/rtl8188eu/include/rtw_efuse.h |   214 +-
 drivers/staging/rtl8188eu/include/rtw_event.h |   114 +-
 drivers/staging/rtl8188eu/include/rtw_ht.h    |   201 +-
 drivers/staging/rtl8188eu/include/rtw_io.h    |   431 +
 drivers/staging/rtl8188eu/include/rtw_ioctl.h |   151 +-
 .../rtl8188eu/include/rtw_ioctl_query.h       |     7 +
 .../staging/rtl8188eu/include/rtw_ioctl_rtl.h |    64 +
 .../staging/rtl8188eu/include/rtw_ioctl_set.h |    46 +-
 drivers/staging/rtl8188eu/include/rtw_iol.h   |   120 +-
 drivers/staging/rtl8188eu/include/rtw_led.h   |    98 -
 drivers/staging/rtl8188eu/include/rtw_mcc.h   |   205 +
 drivers/staging/rtl8188eu/include/rtw_mem.h   |    25 +
 drivers/staging/rtl8188eu/include/rtw_mi.h    |   220 +
 drivers/staging/rtl8188eu/include/rtw_mlme.h  |  1189 +-
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |  1397 +-
 drivers/staging/rtl8188eu/include/rtw_mp.h    |   823 +
 .../staging/rtl8188eu/include/rtw_mp_ioctl.h  |   535 +
 .../rtl8188eu/include/rtw_mp_phy_regdef.h     |  1074 +
 drivers/staging/rtl8188eu/include/rtw_odm.h   |    39 +
 drivers/staging/rtl8188eu/include/rtw_p2p.h   |   152 +
 .../staging/rtl8188eu/include/rtw_pwrctrl.h   |   562 +-
 drivers/staging/rtl8188eu/include/rtw_qos.h   |    18 +
 drivers/staging/rtl8188eu/include/rtw_recv.h  |   682 +-
 drivers/staging/rtl8188eu/include/rtw_rf.h    |   285 +-
 drivers/staging/rtl8188eu/include/rtw_sdio.h  |    15 +
 .../staging/rtl8188eu/include/rtw_security.h  |   542 +-
 .../staging/rtl8188eu/include/rtw_sreset.h    |    54 +-
 drivers/staging/rtl8188eu/include/rtw_tdls.h  |   157 +
 .../staging/rtl8188eu/include/rtw_version.h   |     1 +
 drivers/staging/rtl8188eu/include/rtw_vht.h   |   128 +
 drivers/staging/rtl8188eu/include/rtw_wapi.h  |   214 +
 .../staging/rtl8188eu/include/rtw_wifi_regd.h |    25 +
 drivers/staging/rtl8188eu/include/rtw_xmit.h  |   641 +-
 drivers/staging/rtl8188eu/include/sta_info.h  |   508 +-
 drivers/staging/rtl8188eu/include/usb_hal.h   |    21 +
 drivers/staging/rtl8188eu/include/usb_ops.h   |    60 +
 .../staging/rtl8188eu/include/usb_ops_linux.h |    93 +-
 .../staging/rtl8188eu/include/usb_osintf.h    |    17 +
 .../rtl8188eu/include/usb_vendor_req.h        |    37 +
 drivers/staging/rtl8188eu/include/wifi.h      |  1195 +-
 .../staging/rtl8188eu/include/wlan_bssdef.h   |   335 +-
 .../staging/rtl8188eu/include/xmit_osdep.h    |    43 +-
 .../staging/rtl8188eu/os_dep/ioctl_cfg80211.c |  7113 ++++++
 .../staging/rtl8188eu/os_dep/ioctl_cfg80211.h |   307 +
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 12265 +++++++++--
 drivers/staging/rtl8188eu/os_dep/ioctl_mp.c   |  2028 ++
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c |   713 +-
 drivers/staging/rtl8188eu/os_dep/mon.c        |   183 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   |  4282 +++-
 .../staging/rtl8188eu/os_dep/osdep_service.c  |  1710 +-
 drivers/staging/rtl8188eu/os_dep/recv_linux.c |   786 +-
 .../staging/rtl8188eu/os_dep/rtw_android.c    |  1171 +-
 .../staging/rtl8188eu/os_dep/rtw_cfgvendor.c  |  1330 ++
 .../staging/rtl8188eu/os_dep/rtw_cfgvendor.h  |   229 +
 drivers/staging/rtl8188eu/os_dep/rtw_proc.c   |  3216 +++
 drivers/staging/rtl8188eu/os_dep/rtw_proc.h   |    49 +
 drivers/staging/rtl8188eu/os_dep/usb_intf.c   |  1420 +-
 .../staging/rtl8188eu/os_dep/usb_ops_linux.c  |  1248 +-
 drivers/staging/rtl8188eu/os_dep/wifi_regd.c  |   354 +
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c |   466 +-
 303 files changed, 229418 insertions(+), 28580 deletions(-)
 create mode 100644 drivers/staging/rtl8188eu/COPYING
 mode change 100644 => 100755 drivers/staging/rtl8188eu/Makefile
 delete mode 100644 drivers/staging/rtl8188eu/TODO
 delete mode 100644 drivers/staging/rtl8188eu/core/mac_cfg.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_beamforming.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_br_ext.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_btcoex.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_btcoex_wifionly.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_debug.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_io.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_ioctl_query.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_mi.c
 mode change 100644 => 100755 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_mp.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_odm.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_p2p.c
 mode change 100644 => 100755 drivers/staging/rtl8188eu/core/rtw_recv.c
 create mode 100644 drivers/staging/rtl8188eu/core/rtw_tdls.c
 create mode 100644 drivers/staging/rtl8188eu/hal/Hal8188EPwrSeq.c
 create mode 100644 drivers/staging/rtl8188eu/hal/HalEfuseMask8188E_USB.c
 create mode 100644 drivers/staging/rtl8188eu/hal/HalEfuseMask8188E_USB.h
 create mode 100644 drivers/staging/rtl8188eu/hal/HalPwrSeqCmd.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/bb_cfg.c
 create mode 100644 drivers/staging/rtl8188eu/hal/btc/halbtcoutsrc.h
 create mode 100644 drivers/staging/rtl8188eu/hal/btc/mp_precomp.h
 create mode 100644 drivers/staging/rtl8188eu/hal/efuse_mask.h
 delete mode 100644 drivers/staging/rtl8188eu/hal/fw.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal8188e_s_fw.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal8188e_s_fw.h
 create mode 100644 drivers/staging/rtl8188eu/hal/hal8188e_t_fw.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal8188e_t_fw.h
 create mode 100644 drivers/staging/rtl8188eu/hal/hal8188erateadaptive.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal8188erateadaptive.h
 create mode 100644 drivers/staging/rtl8188eu/hal/hal8188ereg.h
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_btcoex.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_btcoex_wifionly.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_com_c2h.h
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_com_phycfg.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_dm.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_dm.h
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_mcc.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_mp.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_phy.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_usb.c
 create mode 100644 drivers/staging/rtl8188eu/hal/hal_usb_led.c
 create mode 100644 drivers/staging/rtl8188eu/hal/halcomtxbf.h
 create mode 100644 drivers/staging/rtl8188eu/hal/halhwimg.h
 create mode 100644 drivers/staging/rtl8188eu/hal/halhwimg8188e_bb.c
 create mode 100644 drivers/staging/rtl8188eu/hal/halhwimg8188e_bb.h
 create mode 100644 drivers/staging/rtl8188eu/hal/halhwimg8188e_mac.c
 create mode 100644 drivers/staging/rtl8188eu/hal/halhwimg8188e_mac.h
 create mode 100644 drivers/staging/rtl8188eu/hal/halhwimg8188e_rf.c
 create mode 100644 drivers/staging/rtl8188eu/hal/halhwimg8188e_rf.h
 create mode 100644 drivers/staging/rtl8188eu/hal/halphyrf_8188e_ce.c
 create mode 100644 drivers/staging/rtl8188eu/hal/halphyrf_8188e_ce.h
 create mode 100644 drivers/staging/rtl8188eu/hal/halphyrf_ap.h
 create mode 100644 drivers/staging/rtl8188eu/hal/halphyrf_ce.c
 create mode 100644 drivers/staging/rtl8188eu/hal/halphyrf_ce.h
 create mode 100644 drivers/staging/rtl8188eu/hal/haltxbfinterface.h
 create mode 100644 drivers/staging/rtl8188eu/hal/haltxbfjaguar.h
 create mode 100644 drivers/staging/rtl8188eu/hal/mp_precomp.h
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm_hwconfig.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/phy.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_acs.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_acs.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_adaptivity.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_adaptivity.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_adc_sampling.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_adc_sampling.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_antdect.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_antdect.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_antdiv.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_antdiv.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_beamforming.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_ccx.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_ccx.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_cfotracking.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_cfotracking.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_debug.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_debug.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dfs.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dfs.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dig.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dig.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dynamic_rx_path.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dynamic_rx_path.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dynamicbbpowersaving.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dynamicbbpowersaving.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dynamictxpower.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_dynamictxpower.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_edcaturbocheck.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_edcaturbocheck.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_features.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_hal_txbf_api.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_hal_txbf_api.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_hwconfig.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_hwconfig.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_interface.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_interface.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_iqk.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_kfree.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_kfree.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_noisemonitor.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_noisemonitor.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_pathdiv.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_pathdiv.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_powertracking_ce.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_powertracking_ce.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_pre_define.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_precomp.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_rainfo.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_rainfo.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_reg.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_regconfig8188e.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_regconfig8188e.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_regdefine11ac.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_regdefine11n.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_rtl8188e.c
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_rtl8188e.h
 create mode 100644 drivers/staging/rtl8188eu/hal/phydm_types.h
 delete mode 100644 drivers/staging/rtl8188eu/hal/pwrseq.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/pwrseqcmd.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rf.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rf_cfg.c
 create mode 100644 drivers/staging/rtl8188eu/hal/rtchnlplan.c
 create mode 100644 drivers/staging/rtl8188eu/hal/rtchnlplan.h
 create mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_phycfg.c
 create mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_rf6052.c
 create mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_sreset.c
 create mode 100644 drivers/staging/rtl8188eu/hal/usb_ops_linux.c
 create mode 100644 drivers/staging/rtl8188eu/hal/version_rtl8188e.h
 create mode 100644 drivers/staging/rtl8188eu/include/Hal8188EPhyCfg.h
 create mode 100644 drivers/staging/rtl8188eu/include/Hal8188EPhyReg.h
 create mode 100644 drivers/staging/rtl8188eu/include/Hal8188EPwrSeq.h
 create mode 100644 drivers/staging/rtl8188eu/include/Hal8188FPhyCfg.h
 create mode 100644 drivers/staging/rtl8188eu/include/Hal8188FPhyReg.h
 create mode 100644 drivers/staging/rtl8188eu/include/Hal8188FPwrSeq.h
 create mode 100644 drivers/staging/rtl8188eu/include/HalPwrSeqCmd.h
 create mode 100644 drivers/staging/rtl8188eu/include/autoconf.h
 create mode 100644 drivers/staging/rtl8188eu/include/circ_buf.h
 create mode 100644 drivers/staging/rtl8188eu/include/cmd_osdep.h
 create mode 100644 drivers/staging/rtl8188eu/include/custom_gpio.h
 create mode 100644 drivers/staging/rtl8188eu/include/drv_conf.h
 create mode 100644 drivers/staging/rtl8188eu/include/drv_types_linux.h
 create mode 100644 drivers/staging/rtl8188eu/include/ethernet.h
 delete mode 100644 drivers/staging/rtl8188eu/include/fw.h
 create mode 100644 drivers/staging/rtl8188eu/include/h2clbk.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal8188e_phy_reg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_btcoex.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_btcoex_wifionly.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_com_h2c.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_com_led.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_com_phycfg.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_com_reg.h
 create mode 100755 drivers/staging/rtl8188eu/include/hal_data.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_ic_cfg.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_pg.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_phy.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_phy_reg.h
 create mode 100644 drivers/staging/rtl8188eu/include/hal_sdio.h
 create mode 100644 drivers/staging/rtl8188eu/include/ieee80211_ext.h
 create mode 100644 drivers/staging/rtl8188eu/include/if_ether.h
 create mode 100644 drivers/staging/rtl8188eu/include/ip.h
 create mode 100644 drivers/staging/rtl8188eu/include/linux/wireless.h
 delete mode 100644 drivers/staging/rtl8188eu/include/mon.h
 create mode 100644 drivers/staging/rtl8188eu/include/mp_custom_oid.h
 create mode 100644 drivers/staging/rtl8188eu/include/nic_spec.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_hwconfig.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_precomp.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_rtl8188e.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_types.h
 create mode 100644 drivers/staging/rtl8188eu/include/osdep_service_linux.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phy.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phydm_reg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phydm_regdefine11n.h
 delete mode 100644 drivers/staging/rtl8188eu/include/pwrseq.h
 delete mode 100644 drivers/staging/rtl8188eu/include/pwrseqcmd.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rf.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtl8188e_led.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtl8188e_rf.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtl8188e_sreset.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_beamforming.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_br_ext.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_bt_mp.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_btcoex.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_btcoex_wifionly.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_debug.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_io.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_ioctl_query.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_ioctl_rtl.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_led.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_mcc.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_mem.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_mi.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_mp.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_mp_ioctl.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_mp_phy_regdef.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_odm.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_p2p.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_qos.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_sdio.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_tdls.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_version.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_vht.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_wapi.h
 create mode 100644 drivers/staging/rtl8188eu/include/rtw_wifi_regd.h
 create mode 100644 drivers/staging/rtl8188eu/include/usb_hal.h
 create mode 100644 drivers/staging/rtl8188eu/include/usb_ops.h
 create mode 100644 drivers/staging/rtl8188eu/include/usb_osintf.h
 create mode 100644 drivers/staging/rtl8188eu/include/usb_vendor_req.h
 create mode 100644 drivers/staging/rtl8188eu/os_dep/ioctl_cfg80211.c
 create mode 100644 drivers/staging/rtl8188eu/os_dep/ioctl_cfg80211.h
 create mode 100644 drivers/staging/rtl8188eu/os_dep/ioctl_mp.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/mon.c
 create mode 100644 drivers/staging/rtl8188eu/os_dep/rtw_cfgvendor.c
 create mode 100644 drivers/staging/rtl8188eu/os_dep/rtw_cfgvendor.h
 create mode 100644 drivers/staging/rtl8188eu/os_dep/rtw_proc.c
 create mode 100644 drivers/staging/rtl8188eu/os_dep/rtw_proc.h
 create mode 100644 drivers/staging/rtl8188eu/os_dep/wifi_regd.c

-- 
2.31.1

