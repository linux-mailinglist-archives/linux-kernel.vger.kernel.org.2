Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97823EDEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhHPU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhHPU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:56:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DEBC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:56:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b7so28476675edu.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aoItqzXOHntzCchNL5rIsd8p+kh/W+iiqjyy5NjMfJA=;
        b=EDES33c8tZEwiq4s1gNTxOvGc9nSuJ0NdqPO+To/3fG5YOY+tbFJk0cnXg+H+FIYa5
         cdlu0+TIVwFf7sRo1EuoBxZVyowE3w0mGKWTfOWq54OBwuBCm2reiaCP91C9i5ODVqbE
         /L2dzhYDsknei+rjPa7kjDxZ08e9Zg6zeMrBM4VWNG9AenXwd42rpzk3bXpQ2GY2oJKF
         BaUeNLXgXzDU07YlFGkwebzeZOfRrEKsSHY16SKgroPCPNoT5e2PgK/0gVk1Oz+L4xhw
         sjK3uwydl4OWx/Gm8ur30s1qiRBarWJuignFTiH1m7scsubNtRcLsE2rkp93ATpKytyx
         l1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aoItqzXOHntzCchNL5rIsd8p+kh/W+iiqjyy5NjMfJA=;
        b=ikIsyZFCiku+Ac7LMoZMu7LRy/eYpPNyEcastZ64oyHUYhNdSE0P6d9+7iawegUKSS
         TXMWg/Bib0/EW93ndmZawAKrKpbThlzxLFg/FMjOuGNIyL7YjgibB1Wj23MlEh7odzdH
         SI1xfNWkcGVR8ArvBEaiUfZfQfBzZskTgAz1yqMDWD0yS4Hm3Tseq9FVaC0z7BQYIIxZ
         /I1ijQLNFoMPlqccMqwN2RzklJ+UywXqFDhbEJHTqKq8bB1QRW+olU7XEKsg94YC/68O
         OwFKtp8cGGokPoX0Zme6lXDpCbSfELmm/Lx7+bYkaCZctTR03xPSb9WGqxMFmJhKbxQI
         Z0TQ==
X-Gm-Message-State: AOAM532gecgPPznE6Q8xy9sDhAXF/4xqSFrs0hgFg9D6/lWLxBqDKkdp
        HZz4LYXc8n5D6Fs0s5CzoVHTBTbUbsw=
X-Google-Smtp-Source: ABdhPJzLWZa4CwGbYcc5OdSJcBncxavfel7BKlS+3cFTg+uXp3T/t4bwe+UX3FYUM1fyP+vFy3VVWw==
X-Received: by 2002:aa7:db47:: with SMTP id n7mr71967edt.15.1629147369305;
        Mon, 16 Aug 2021 13:56:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id ck17sm36967edb.88.2021.08.16.13.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:56:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: clean up spacing style issues in hal dir
Date:   Mon, 16 Aug 2021 22:55:08 +0200
Message-Id: <20210816205511.20068-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up coding style issues in the hal directory
reported by checkpatch --types SPACING.

Michael Straube (3):
  staging: r8188eu: clean up spacing style issues in hal dir, part 1
  staging: r8188eu: clean up spacing style issues in hal dir, part 2
  staging: r8188eu: clean up spacing style issues in hal dir, part 3

 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  48 ++--
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  22 +-
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |   6 +-
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   6 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 138 +++++-----
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   2 +-
 drivers/staging/r8188eu/hal/hal_com.c         |  36 +--
 drivers/staging/r8188eu/hal/hal_intf.c        |   4 +-
 drivers/staging/r8188eu/hal/odm.c             | 114 ++++-----
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  84 +++----
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  70 +++---
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |   8 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  74 +++---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 238 +++++++++---------
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  40 +--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  60 ++---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  66 ++---
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |   2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  10 +-
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  36 +--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 162 ++++++------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  20 +-
 23 files changed, 624 insertions(+), 624 deletions(-)

-- 
2.32.0

