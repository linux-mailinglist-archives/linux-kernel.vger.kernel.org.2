Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225873D0FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbhGUNAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhGUM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FCDC061762
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id oz7so3316746ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNqnEuB+5OB8TJyJbR1IoAR5/BGotvCxYkvDB2PV0Co=;
        b=rgxF3s/V9nYfNtJgHVsGhWOhJPGQiSt3IWD7yiJHQzTdz1yCY6pV0TFPbtAMWpFANz
         Hesrf1GVTGxm2PJQhUYt3Jrh5sOBRHrfhBtD91CUQ9Sqt5u8t1a93goPIWSGH8/frWnO
         Gdbu40HG1mcet3eJXlZsTOJP5qSoDF0TLzAINRg1Rv/bEkIl5u/G0/5d+vCUhpfaPKb1
         61LbRWmGsg4RYY5QM5l1f+70vxd9NvNEb+S3LcQr32Bi/BhgFJUMCLp3eSAnOyN2lpeR
         UJnUJjPJtfoZ1jWMsukIAe4TDfLCCdhotrc8VumbeG6BUfKEIaoQOJgAAe00aROdgBIQ
         I/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNqnEuB+5OB8TJyJbR1IoAR5/BGotvCxYkvDB2PV0Co=;
        b=UXumI3A2FZUpa6TRMC1RgT2Ty+u89dXuPc4jB1RQfpQgRiVwFkKNl8cfY8sAsdH6fW
         BrjeI2uUVJ2kKvhGMnzdpKYuqFzEXM6kHVgGXlniPBUxKvLWDoz4V1z5iNzBDTn6MCPX
         rVAMYUczYUnrn7npezZ4JBxegjqws3jKwxaMoqshaIyGhXQwVVuctm4506sTs8eprfLe
         /RJichcfAluKyqXTfPOKnhSvvlVtyQZWirGfUu+DDEXH+WQWudSuZJtIHeqcfe0j7Vzw
         +vmR+sZxygf3XFqhm1We5PSJsUfPo/trDeBOYMO1D62ZT05JKPgD02RWXK2o12pRajcq
         oU4g==
X-Gm-Message-State: AOAM533pzEulHEXS1mDV3pJAQY513nGxGHVY9M5p1k2aGy1yE/eP3Hym
        0OMExmBWJ1SqC6HXm4cGZxFY5v6kR28=
X-Google-Smtp-Source: ABdhPJy2dcfZymYVJe6H9C+JYQB8LUIfTqWDEKybU6AQuwylVf7huAyl90wYbonbF6M/wxjTVZTnMw==
X-Received: by 2002:a17:906:bc48:: with SMTP id s8mr39318350ejv.453.1626874645461;
        Wed, 21 Jul 2021 06:37:25 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id o23sm8652136edv.22.2021.07.21.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] staging: rtl8723bs: remove residual 5 Ghz code and more code cleaning
Date:   Wed, 21 Jul 2021 15:37:07 +0200
Message-Id: <cover.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes some residual 5 Ghz dead code,
left undeleted from recent patches intended for
this aim.

Done some code cleaning as well (mainly camel case fixes)

Fabio Aiuto (16):
  staging: rtl8723bs: simplify function selecting channel group
  staging: rtl8723bs: fix camel case inside function
  staging: rtl8723bs: convert function name to snake case
  staging: rtl8723bs: add spaces around operator
  staging: rtl8723bs: remove 5Ghz code blocks
  staging: rtl8723bs: remove commented out condition
  staging: rtl8723bs: fix camel case in struct wlan_bssid_ex
  staging: rtl8723bs: fix camel case in struct ndis_802_11_conf
  staging: rtl8723bs: remove struct ndis_802_11_conf_fh
  staging: rtl8723bs: fix camel case in struct ndis_802_11_ssid
  staging: rtl8723bs: fix camel case in struct wlan_phy_info
  staging: rtl8723bs: fix camel case in struct wlan_bcn_info
  staging: rtl8723bs: fix camel case in IE structures
  staging: rtl8723bs: remove unused struct ndis_802_11_ai_reqfi
  staging: rtl8723bs: remove unused struct ndis_801_11_ai_resfi
  staging: rtl8723bs: fix camel case in struct ndis_802_11_wep

 drivers/staging/rtl8723bs/core/rtw_ap.c       | 124 ++++----
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  54 ++--
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  80 ++---
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  28 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 214 +++++++------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 287 +++++++++---------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 102 +++----
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       |   2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  22 +-
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  64 +---
 drivers/staging/rtl8723bs/include/rtw_mlme.h  |   6 +-
 .../staging/rtl8723bs/include/wlan_bssdef.h   |  90 +++---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  92 +++---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 190 ++++++------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   4 +-
 16 files changed, 641 insertions(+), 720 deletions(-)

-- 
2.20.1

