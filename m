Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BF033AFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCOKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCOKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:13:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55CDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:13:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f12so8342935wrx.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZliOoleFek+zCl9Sad4KdcKZMptN2E4YKVdq/7vIxK4=;
        b=Xn3jkFwLBknSuHhSk/6vF8vuP8p9Bv0DVAAF+23s+0IYdd3CqUjZVMTBi3jvHbXPz0
         hziY03u2usakOa/KQr02jJziFGjoe/2d9wWpefZaZgz0wb8MKK0fm/yH/fWD/d0jJULr
         cbbbxdkO1+NDLZQxKdS9PSD2z5kNEGvcOnG1k0r6zWGdPIg9+o9kO3Z7ynYNzWJCb1v9
         ZsHgYP5fPvAw+1RXQAxdJrzAl1ZMDylXSH2poTXXJag5/KZVbM7E0EqZ1pCRlYpUo3TK
         lgSISNR2JMTX4SEr/WI43iMWXd0fPyN1agG5dpn5N3qjl0ThxXDusBxLupaI6rtUCnGD
         Ih4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZliOoleFek+zCl9Sad4KdcKZMptN2E4YKVdq/7vIxK4=;
        b=EHRDR+mooeTgg+rN9xu0pEReDXgbXPlONoroWZ9gCt5y0c37DNaF1G+lRuPCWD2Vzh
         Vvqg2L0pSBhX1r0qwSU361wpoCIYUOzpRtqNYLs+p9rtV6GfRItvxkVETslvnLowFsvr
         pwn/x2bIZh6i02BZDuSfww0c/0pfAm60cDY1uA5xcdviKfFFjhoSGzdF9gbUXKAvkxey
         3jSUKFoOl7NS9jWZpgDiV6g83FIQooNSCzSdHVZYqUj7+fFYj1xGNMUvnNA8W1HucBWS
         x/MhZyrJoduWPBAF6pmpXMcoSWSgfLNjA5VHtti11mqpfDU7iocLCYIEBd4A0i4CCfTi
         9nTQ==
X-Gm-Message-State: AOAM533GFIZeMxxb2fVLTVWOkh3oWmvVZPSkiXci3YUfhvhsBIKy4f1f
        PKovaR23SAXCxqp6C5GOtqMAPoO+fGw=
X-Google-Smtp-Source: ABdhPJzclMNZmPb2xWLeA2pLOny/6YhDnLUvik2kcgDRX076RVtc5FRJItVJmpx5pmGhJb3TPMjN5Q==
X-Received: by 2002:adf:a703:: with SMTP id c3mr10943533wrd.72.1615803232583;
        Mon, 15 Mar 2021 03:13:52 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id j30sm20195654wrj.62.2021.03.15.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:13:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:13:49 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] staging: rtl8723bs: remove unused code blocks
Message-ID: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused code blocks as required in TODO file

Fabio Aiuto (15):
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_AUTO_AP_MODE
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_HW_PWRP_DETECTION
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_QOS_OPTIMIZATION
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_AP_WOWLAN
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_PM
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_SIGNAL_DISPLAY_DBM
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_BACKGROUND_NOISE_MONITOR
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_SKIP_SIGNAL_SCALE_MAPPING
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_GPIO_API
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_EXT_CLK
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_CHECK_BT_HANG
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_SDIO_TX_TASKLET
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_SW_CHANNEL_PLAN
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_C2H_PACKET_EN
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_ODM_ADAPTIVITY

 drivers/staging/rtl8723bs/core/rtw_ap.c       |   4 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |   3 -
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 250 -------------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  35 --
 drivers/staging/rtl8723bs/core/rtw_recv.c     |  32 --
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 126 -------
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |   5 -
 drivers/staging/rtl8723bs/hal/hal_com.c       |  37 --
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  |   9 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 339 ------------------
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |   3 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  71 ----
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |   8 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 126 -------
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  37 --
 drivers/staging/rtl8723bs/include/drv_types.h |   6 -
 .../rtl8723bs/include/drv_types_sdio.h        |   5 -
 drivers/staging/rtl8723bs/include/hal_com.h   |  10 -
 .../staging/rtl8723bs/include/hal_com_h2c.h   |  30 --
 drivers/staging/rtl8723bs/include/hal_data.h  |   5 -
 drivers/staging/rtl8723bs/include/hal_intf.h  |   3 -
 .../staging/rtl8723bs/include/osdep_service.h |   7 -
 .../staging/rtl8723bs/include/rtl8723b_cmd.h  |   6 -
 .../staging/rtl8723bs/include/rtl8723b_hal.h  |  11 -
 drivers/staging/rtl8723bs/include/rtw_mp.h    |   3 -
 drivers/staging/rtl8723bs/include/rtw_recv.h  |   5 -
 drivers/staging/rtl8723bs/include/rtw_xmit.h  |   4 -
 drivers/staging/rtl8723bs/include/sdio_ops.h  |   7 -
 drivers/staging/rtl8723bs/include/sta_info.h  |   5 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   8 -
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 130 +------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 142 --------
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  41 ---
 33 files changed, 1 insertion(+), 1512 deletions(-)

-- 
2.20.1

