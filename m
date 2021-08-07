Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837F43E34A4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhHGKM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhHGKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B92EC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z11so16812879edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OU67HbwUr4do4pKiu+mprt4x/hHymYLyxHmplXnMyk=;
        b=qEBvSFM4ZWwzTqRLRXTSHiybKOUxWmGFiGsGwQWeKOr7LaN/7qptLh55siwChx5jbQ
         9QYgRuf4I3jzfrkTwZ6fY9BuARbfDk4K161QGYemaWqA2HR8MxbUwfUYJ1tM3wRKso4r
         gLqm8cyx/JTMLV9OyrFR30WVsuI/xEuFm/ys2Cz4Udosb0Je1iUJSdTe6CEyEQWI37lW
         1SMJv4eVjjY5j1p2d4Z9sNcFNMoa81b2kAXdN9AY6zL89cyXOTQBcsyju8IGz+vdjs8e
         TQJCeRKTHitUWrq8czBRW2vcShO23LBGOQIffaE7EBrX/W2R0h4gyoIpi3Mv189EPepI
         nfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OU67HbwUr4do4pKiu+mprt4x/hHymYLyxHmplXnMyk=;
        b=XDzSnasvWnapYN5z8Fzm5YExAKbVhOupYijvEUs1fjisLxr52//xE9W7Mqw7d4VoFQ
         VNflNdLm9wDh6WrYJfjUN7zUmO2sTO//OsHsgRL9uJDagTn4Pl6g+maA71cgXAnGkFa4
         YCNzV9KABW/ZjnBoR5eq1szYmJL7jxjZRezHLF0Z9+R6KqhMp5mKyKcbQ7AcQ5qmcR9G
         IF0oNNDrkY7O9nBDuXxjJHzmCZ3F2ZSxAzHC8uaPRnot8yOER7X4XRvHaFUAhcnXoKwG
         9FiJO6YXgMAI/0X6uC9kmOyBrq1Bsr16xKJjxFcZUt6HN3Vy8Kh7wo0m6NaMcjW9R1US
         JPBQ==
X-Gm-Message-State: AOAM530Cil/UdVckylSp11zKXhKcEfXZ0/rluK0CzmI7inORNbfJy6du
        clqboM3g2sbcryJBwKH7bM8=
X-Google-Smtp-Source: ABdhPJwRb/SaWQSJbZpmSrjSg+gknlPts8QLcsJW14g2tDk7rj44La14pFsuB8GBDzJMTt99nLEqsA==
X-Received: by 2002:a50:f113:: with SMTP id w19mr17549606edl.107.1628331126241;
        Sat, 07 Aug 2021 03:12:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/17] staging: r8188eu: remove unnecessary parentheses
Date:   Sat,  7 Aug 2021 12:11:02 +0200
Message-Id: <20210807101119.16085-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unnecessary parentheses reported by checkpatch.

Michael Straube (17):
  staging: r8188eu: remove unnecessary parentheses in os_dep dir
  staging: r8188eu: remove unnecessary parentheses in hal dir
  staging: r8188eu: remove unnecessary parentheses in
    core/rtw_mlme_ext.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_ap.c
  staging: r8188eu: remove unnecessary parentheses in
    core/rtw_wlan_util.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_led.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_p2p.c
  staging: r8188eu: clean up comparsions to true/false
  staging: r8188eu: remove unnecessary parentheses in core/rtw_mlme.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_xmit.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_sta_mgt.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_recv.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_pwrctrl.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_io.c
  staging: r8188eu: remove unnecessary parentheses in
    core/rtw_ioctl_set.c
  staging: r8188eu: remove unnecessary parentheses in core/rtw_cmd.c
  staging: r8188eu: remove remaining unnecessary parentheses in core dir

 drivers/staging/r8188eu/core/rtw_ap.c         |  80 +--
 drivers/staging/r8188eu/core/rtw_br_ext.c     |   6 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        |  36 +-
 drivers/staging/r8188eu/core/rtw_debug.c      |  14 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |   4 +-
 drivers/staging/r8188eu/core/rtw_io.c         |  32 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  22 +-
 drivers/staging/r8188eu/core/rtw_iol.c        |   2 +-
 drivers/staging/r8188eu/core/rtw_led.c        | 354 +++++------
 drivers/staging/r8188eu/core/rtw_mlme.c       | 110 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 586 +++++++++---------
 drivers/staging/r8188eu/core/rtw_mp.c         |  10 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        |  78 +--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  20 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  26 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  22 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  70 +--
 drivers/staging/r8188eu/core/rtw_xmit.c       |  56 +-
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |   8 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  16 +-
 drivers/staging/r8188eu/hal/hal_intf.c        |   2 +-
 drivers/staging/r8188eu/hal/odm.c             |  44 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  10 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  56 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  30 +-
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |   8 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |   2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  12 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  10 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  32 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |   6 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 162 ++---
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   4 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |   4 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |   4 +-
 drivers/staging/r8188eu/os_dep/rtw_android.c  |   2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   2 +-
 37 files changed, 971 insertions(+), 971 deletions(-)

-- 
2.32.0

