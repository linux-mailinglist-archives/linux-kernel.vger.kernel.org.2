Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35E03511DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhDAJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhDAJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38914C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o19so1164810edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wl6s0kMWInDA7oyts2o7JhzYN9mrmysD32zfqaTxb3g=;
        b=OJI8klOEbuo4dHNEoVl8cIvakmNAR3swgVQQnrwDTgIY5Ezsmlg/8zj+7dySpxH1NX
         Z187TXHN1qY6ZowBlxtTiqbQmgiDHJEN6trrP4IDJj93DT4XZwhtJARbOIbyUNOW8AiX
         2rVt71zyoLhm6kw8GO9CXEsZyVEQTffBb3VEqvdowdT1bYdAtaMeRoxDiYqpB+nWxymw
         t/V82lD6qvxpZWsAxMg3wG5XuHJR5cxh70q0R2xBz6y1tXKKIAUkKpeXNfUnB5oXaGqZ
         g4m5XvsIfKBQumyXQaBH8LQ3MX2YaFc+tFmMTV1E6uSFLS2nGs1bAHHmvbaR0ExJyNP2
         dtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wl6s0kMWInDA7oyts2o7JhzYN9mrmysD32zfqaTxb3g=;
        b=l9xuDM+fFkxZlsRaFyA9H/EsVoquZ+pQqrq+lu2kLkcNa+ZV+DM5zSNWPOo8uCl/H6
         ytlPd4sXfe8n3jLvIcxdK1fomSbONlrjM8GRb9oz3AlUVZ3Jn1v6KfJjuCZIUObMuJqU
         JBSGZYzpGCqzbWS4enCz8oV88IIa7gNXUwz0imE/HUY++QQmqVZILXc0h3I2vtf/C1Hd
         /fWPugtKmToE/R29gykU4dYe5LDnaHtsETCNZLTy16/FXihfasCbEhiixYcNxVe8CLn+
         2aPV3syoL+FwyQ2gL+nkl/zBLyUk2k2b4FUryVFda+qJFnI9woXVlv91UP5ipWyWzfmp
         N98Q==
X-Gm-Message-State: AOAM531vN1opxGQ0iQslVSiVPfo4nEHh+8qA729Cc6RaYrS+xgaI6BGN
        we8Z7XkVyQ5UDlxwK5UprZM=
X-Google-Smtp-Source: ABdhPJz0emFrpAMqDDLb9lLRZNOcOfVzF3cmlTm/Bpz480tjT7lvUjc3AEpAEZiabzKbag326rr+tg==
X-Received: by 2002:a05:6402:2215:: with SMTP id cq21mr8889640edb.281.1617268882986;
        Thu, 01 Apr 2021 02:21:22 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id r13sm3239116edy.3.2021.04.01.02.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 00/49] staging: rtl8723bs: remove all RT_TRACE usages
Date:   Thu,  1 Apr 2021 11:20:30 +0200
Message-Id: <cover.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes all RT_TRACE usages and declaration.

The whole private tracing system is not tied to a configuration
symbol and the default behaviour is _trace nothing_. It's verbose
and relies on a private log level tracing doomed to be
removed.

Fabio Aiuto (49):
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_xmit.c
  staging: rtl8723bs: remove empty else blocks
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
  staging: rtl8723bs: remove empty if block in core/rtw_security.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_eeprom.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_pwrctrl.c
  staging: rtl8723bs: make one single if statement out of two nested
    ones
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_cmd.c
  staging: rtl8723bs: remove empty if-else blocks and unused variable
  staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme.c
  staging: rtl8723bs: remove empty if-else block in core/rtw_mlme.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme_ext.c
  staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_recv.c
  staging: rtl8723bs: remove empty for cycle in core/rtw_recv.c
  staging: rtl8723bs: remove empty if-block in core/rtw_recv.c
  staging: rtl8723bs: remove commented RT_TRACE call in
    core/rtw_ioctl_set.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ioctl_set.c
  staging: rtl8723bs: remove empty if-block in core/rtw_ioctl_set.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_wlan_util.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_sta_mgt.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ieee80211.c
  staging: rtl8723bs: remove empty for cycles
  staging: rtl8723bs: remove RT_TRACE logs in hal/HalPwrSeqCmd.c
  staging: rtl8723bs: remove RT_TRACE logs in hal/rtl8723b_hal_init.c
  staging: rtl8723bs: remove empty #ifdef blocks in
    hal/rtl8723b_hal_init.c
  staging: rtl8723bs: remove empty if blocks in hal/rtl8723bs_hal_init.c
  staging: rtl8723bs: added driver prefix in log messages
  staging: rtl8723bs: remove RT_TRACE logs in hal/sdio_ops.c
  staging: rtl8723bs: remove commented code block in
    hal/hal_com_phycfg.c
  staging: rtl8723bs: remove RT_TRACE logs in hal/rtl8723b_phycfg.c
  staging: rtl8723bs: remove empty else-blocks in hal/rtl8723b_phycfg.c
  staging: rtl8723bs: remove RT_TRACE logs in hal/hal_intf.c
  staging: rtl8723bs: remove RT_TRACE logs in hal/rtl8723bs_xmit.c
  staging: rtl8723bs: remove RT_TRACE logs in hal/sdio_halinit.c
  staging: rtl8723bs: remove RT_TRACE logs in hal/rtl8723bs_recv.c
  staging: rtl8723bs: remove commented RT_TRACE calls in
    hal/HalPhyRf_8723B.c
  staging: rtl8723bs: remove commented RT_TRACE calls in
    hal/rtl8723b_rf6052.c
  staging: rtl8723bs: remove commented RT_TRACE calls in
    os_dep/ioctl_linux.c
  staging: rtl8723bs: remove RT_TRACE logs in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove RT_TRACE logs in os_dep/mlme_linux.c
  staging: rtl8723bs: remove RT_TRACE logs in os_dep/ioctl_cfg80211.c
  staging: rtl8723bs: remove RT_TRACE logs in os_dep/recv_linux.c
  staging: rtl8723bs: remove RT_TRACE logs in os_dep/sdio_intf.c
  staging: rtl8723bs: remove RT_TRACE logs in os_dep/xmit_linux.c
  staging: rtl8723bs: remove RT_TRACE logs in os_dep/osdep_service.c
  staging: rtl8723bs: remove RT_TRACE logs in os_dep/os_intfs.c
  staging: rtl8723bs: remove obsolete macro

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  37 ------
 drivers/staging/rtl8723bs/core/rtw_eeprom.c   |  15 +--
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  54 +-------
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  71 ----------
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  76 +----------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  25 ----
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  51 +------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 125 ------------------
 drivers/staging/rtl8723bs/core/rtw_security.c |  37 ------
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  25 ----
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  16 ---
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  66 +--------
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |   3 -
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c  |  47 -------
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    |  20 ---
 drivers/staging/rtl8723bs/hal/hal_intf.c      |   2 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 101 +-------------
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  33 +----
 .../staging/rtl8723bs/hal/rtl8723b_rf6052.c   |   2 -
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |   2 -
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  32 -----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  30 -----
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  31 -----
 drivers/staging/rtl8723bs/include/rtw_debug.h |  18 ---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   6 -
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  57 --------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |   4 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  45 -------
 .../staging/rtl8723bs/os_dep/osdep_service.c  |   1 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |   9 --
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  14 --
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |   5 -
 32 files changed, 13 insertions(+), 1047 deletions(-)

-- 
2.20.1

