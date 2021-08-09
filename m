Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC963E4A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhHIQvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhHIQvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6ABC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u1so1044611wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Hcj1n4ozk+H6CYKuRnd8vgH5o6uUv5uupFh+O9qQl4=;
        b=WtcM64WlOV+7U8pgoWNEv8nRbRAxnA4ykdMJyImAh7O9jjfgnNmVskKRhQVIE2QpXD
         khFH1HE+DZWoF6esCyvl5y7eO3s6OH1ATBpkf5Lpmt7G5joLq6s3nlAfZnjLRloeN/MZ
         BnBpQWvB3U4cOWSnLBhPs8NSESEMOeWpgo74xYJvX1bBKdvTAkK/RD/tVY9oeqfYBVIn
         C65xJfIX4S9xC425154Y57LkVH0xbZwI+49xlkDnLswu7izhhEn0DBFJUo2FIZqvtx+/
         yqUoiGOQv9HfSrnp3SaMQKMwzmMPFwHrfcCyCKovNPYtcSpONezTeRjLYVXt0oebXAmZ
         Z6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Hcj1n4ozk+H6CYKuRnd8vgH5o6uUv5uupFh+O9qQl4=;
        b=f1oFNZDVAK7q6/tuwQP/3lnw8GW9lQER6bllDJ/bHvpHLCwrvsum+eeM2e7kPqJhPq
         vNKjBsoAlYb4Ehitzgg2/q777HkUaiwlZGK8iXUjd8PkR0URjM76eqcPova0sQqngmP9
         Pfm2tq+zqd+d9cJqWbizvf33ZUPChX00Ae6O6mItv3qKCCFXga6xg77VOhuINbkZkaZF
         bQnQ8VZd4t5OroGUboPgonM2SfVNQqn90ydaJHQz0sl1ArXAknuvkm5iIUgHoYdRkB1j
         E5UTumIJzehmOwO0/XCgiXagL0zOdbdI27x9gqA10KVGvhIyX3cfrVLt/HsTKI2pvJ2y
         2fHg==
X-Gm-Message-State: AOAM533L5mAd9+BZsTti8T7CPjEz5rJwIolSYozNo4FrV0dPfT2yuPba
        OSs0MWqQitEyqJbvvTuSW+RO3o6vV/g=
X-Google-Smtp-Source: ABdhPJwa8Fvmjbw3awsQK7/5rPmYWF5OG9Cb/L1TsDRt/O3nQJhpxWV3BNI3a3S2ta9bTYTPSp5y2g==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr45612wmk.69.1628527846078;
        Mon, 09 Aug 2021 09:50:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 00/17] staging: r8188eu: remove unnecessary parentheses
Date:   Mon,  9 Aug 2021 18:49:50 +0200
Message-Id: <20210809165007.23204-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unnecessary parentheses.
Most of them reported by checkpatch.

v1 -> v2
Updated patch 3 and 7 to remove some more parentheses that were not
reported by checkpatch.

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

