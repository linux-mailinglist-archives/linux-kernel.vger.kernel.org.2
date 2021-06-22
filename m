Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373AA3B0466
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhFVMcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhFVMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30835C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a13so1652225wrf.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5ViW9L7DTOJj5z9qhVebpVLgq9tad1v9oBNuUcvwzo=;
        b=Dub4jveNq5XRXKA1o18pWv8P4mBETg/EfvBPCWSFoG30oPDJi/IxktGCMEJFaaPtny
         Bm76az3OSwVXkyD7lA87WeG2qkER+O7N88P3UMzsRo0FY/crov+iTdsJ82FhgimgX2JI
         aRzipesXywrRg8lRYIdCzDluufHoTL1hFR+DBI7WLtksyxV729/dWw5SCwXowA/qf4U6
         21A/g+jN3De3CULnNflfcESlXBzE6qgS5DZMhQCLP2PWzmfb6tiDL1bs++R5TYzcJBi+
         oyPbnAHPKE8JPdBPES0KDHKdKTm/PsI8/3y8/dgXyHHUKCjw1aJXCTBu2ch07rXDoqyw
         YfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5ViW9L7DTOJj5z9qhVebpVLgq9tad1v9oBNuUcvwzo=;
        b=dEUizt1pAl9kdAIPisw+NeShZo97f7tK/7uAwSEyswpsMBwKQgUe8sEtScT/RmOyFX
         nHCKuWCDbIvk3ceb8rKGoFzwqt/RIjlXIqzQfJn7IWID6+l+UeV4wNHRfH01RA265ToJ
         eW5k9cGU4avyj7yY1C8LjwDwsBKwz84y2lm0tRGqqPFdSMAew1D89VEo53UPZDRLQtYp
         lZ+KvItpcWUMqJKvu2uNb9XDqPzbqixFt0g/uWvoaOE1tgkeaY5MsefRMCE6fA02spwC
         MqRAXl8RAKDp1uw2fVovvwelz4DLRjf30WOSwJgwV9t5qW0yyPvBHpCVvG83/zfbByxk
         Ik2g==
X-Gm-Message-State: AOAM533vUm0SGHnxZUE3I6cFV6A6VZvubXLzhyNk6CrQSk7KiduqbQ2u
        HYFOAOKy0vPkFnWMuJS7i7uA4yaPUxcK8A==
X-Google-Smtp-Source: ABdhPJxuApZaHtB6uOWVzFt09TmbveXZ5wPZEqVv8F6Z38PMP5O4ifon4WM6RHG+LdBhp7LhaakDVQ==
X-Received: by 2002:adf:8061:: with SMTP id 88mr4380195wrk.233.1624364984803;
        Tue, 22 Jun 2021 05:29:44 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id n16sm11085603wrx.85.2021.06.22.05.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:29:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Auto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 00/17] staging: rtl8723bs: remove 5Ghz code
Date:   Tue, 22 Jun 2021 14:29:25 +0200
Message-Id: <cover.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes all occurences of 5Ghz code over the
driver as required from driver's TODO list:

        - find and remove remaining code valid only for 5 GHz.
          most of the obvious one have been removed, but things
          like channel > 14 still exist.

rtl8723bs work on 2.4Ghz band and supports 802.11bgn standards.
So all code related to 802.11a/ac standard is removed, as well
as code related to channel numbers above 14.

VHT code is deleted as well, for it's related to 802.11ac.

Comments are fixed accordingly and many unused variables are
deleted.

Every single patch of this series has been tested on a
Lenovo Ideapad MIIX 300-10IBY except for the last one,
for obvious reason (it deletes just the TODO item).

So:

Tested-by: Fabio Auto <fabioaiuto83@gmail.com>
------------------------------------------------
Changes in v2:
	- drop v1 15/18 patch, for it deliberately
	  does register writes as pointed by Hans.

Fabio Aiuto (17):
  staging: rtl8723bs: remove all 5Ghz network types
  staging: rtl8723bs: remove code related to unsupported channel
    bandwidth
  staging: rtl8723bs: remove unused enum items related to channel
    bonding
  staging: rtl8723bs: rename enum items related to channel bonding
  staging: rtl8723bs: remove 5Ghz field in struct registry_priv
  staging: rtl8723bs: remove struct rt_channel_plan_5g
  staging: rtl8723bs: remove all branchings between 2.4Ghz and 5Ghz band
    types
  staging: rtl8723bs: beautify prototypes in include/hal_com_phycfg.h
  staging: rtl8723bs: remove 5Ghz code related to channel plan
    definition
  staging: rtl8723bs: remove some unused 5Ghz macro definitions
  staging: rtl8723bs: remove 5Ghz code related to RF power calibration
  staging: rtl8723bs: remove VHT dead code
  staging: rtl8723bs: remove unused ODM_CMNINFO_BOARD_TYPE enum item
  staging: rtl8723bs: fix macro value for 2.4Ghz only device
  staging: rtl8723bs: remove obsolete 5Ghz comments
  staging: rtl8723bs: fix check allowing 5Ghz settings
  staging: rtl8723bs: remove item from TODO list

 drivers/staging/rtl8723bs/TODO                |    2 -
 drivers/staging/rtl8723bs/core/rtw_ap.c       |   10 +-
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |   22 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |   10 -
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  328 ++---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |   29 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |    5 +-
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   |    4 +-
 .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   |    5 +-
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |    1 -
 .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c  |   17 +-
 .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c  |  595 ++++-----
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |   19 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |    4 -
 drivers/staging/rtl8723bs/hal/hal_com.c       |  241 ----
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 1059 +++--------------
 drivers/staging/rtl8723bs/hal/odm.c           |   50 -
 drivers/staging/rtl8723bs/hal/odm.h           |   42 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.c       |    2 -
 .../rtl8723bs/hal/odm_EdcaTurboCheck.c        |    4 +-
 .../rtl8723bs/hal/odm_RegConfig8723B.c        |    5 +-
 .../rtl8723bs/hal/odm_RegConfig8723B.h        |    2 -
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |    1 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |   41 +-
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |   43 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |    5 -
 .../rtl8723bs/include/Hal8192CPhyReg.h        |    2 -
 drivers/staging/rtl8723bs/include/drv_types.h |   10 +-
 drivers/staging/rtl8723bs/include/hal_com.h   |   62 +-
 .../rtl8723bs/include/hal_com_phycfg.h        |  198 +--
 .../staging/rtl8723bs/include/hal_com_reg.h   |    1 -
 drivers/staging/rtl8723bs/include/hal_data.h  |   40 +-
 drivers/staging/rtl8723bs/include/hal_pg.h    |    2 -
 drivers/staging/rtl8723bs/include/hal_phy.h   |   10 -
 drivers/staging/rtl8723bs/include/ieee80211.h |   67 +-
 .../staging/rtl8723bs/include/rtl8723b_xmit.h |   21 -
 drivers/staging/rtl8723bs/include/rtw_ht.h    |    4 -
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |   52 +-
 drivers/staging/rtl8723bs/include/rtw_rf.h    |   33 +-
 drivers/staging/rtl8723bs/include/wifi.h      |    1 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |    4 -
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |    8 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   13 +-
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c  |    4 -
 44 files changed, 640 insertions(+), 2438 deletions(-)

-- 
2.20.1

