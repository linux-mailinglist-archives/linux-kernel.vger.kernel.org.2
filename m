Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E4425145
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbhJGKl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhJGKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:41:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE94C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 03:39:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o20so17616617wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEr5pxyTFkXS8HPGn33416aSarN9buK1uX6Uaq4RTo0=;
        b=MToOgZx0Nfd1WywTkyUgTlFTxGlcWHQ/JBCjAa1hAERXLgaFTqT8IuWGGOhok1Wrff
         U5AFa1NioXGrLbMGj2FI9t4pvQ8VgkpmE/0loTli2AZGegTsbzMeYIcK2xPNXBVCAQBz
         L8edq+pQ3ILumZGK7cyBFtedi1nXT4Ze78X3e9gTHZfWlellivr9lPSgmxzP5rRMpv4k
         UDg6r3PvPYfiqFGXeXW/09MB0RKJ/wpIXEtliYI+1281yfd5KKMi7xV44sGNCjR6gkH4
         NqT8jcfPOvBUqLWFJzrykFII2Se/vAj8bURONJLnGQ9Bwjoi9Qzc5FuKsqqYmBKqlrt1
         nUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEr5pxyTFkXS8HPGn33416aSarN9buK1uX6Uaq4RTo0=;
        b=Lt+gnsF0MuphyykWFYj+VVDRAizCpcNN74vzmpxQ/18njDiZC+Je2emObavu9V70Vs
         B4SlqNIU0etzu+CYnz2jGIfNfPovk80u83y/4jK3NcICA5hZDWby9VDPSeIbcEB50e+h
         0GxwfeezF217kI/k+eSM2UV1Q62obKzdCNCLDCbmlFbeefUl5fe7pixFhnB5AJ0E+LLJ
         TKpKF+zsG6OOfCabkhPfBMgxHzqzaDKlKY9+FHF1dvutxlFdAS5Wzm2Amcd86cx9Ei8g
         Q+Hea/57/pP884Cg44TqposEDtLX4TMIvO6w3hbMByWw78A4Vr/JRXh+RTifnJ7MQhWN
         fRNw==
X-Gm-Message-State: AOAM533BmhfUTv3lQ3e1rsynmvz7bM62TfA4KNdHuK5L1ic1MT0knA05
        MhWQGM4q5qBY3riZTWUUJjM=
X-Google-Smtp-Source: ABdhPJwTmmmMH17pR4EJlSlFMlMqFDlo/ZTX7rrRVhtjDItdi3QxvMmLHoRUQRKE/1drAdktPjq0WQ==
X-Received: by 2002:a5d:58ea:: with SMTP id f10mr3344312wrd.188.1633603187891;
        Thu, 07 Oct 2021 03:39:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id n14sm10224853wms.0.2021.10.07.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:39:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove struct hal_ops
Date:   Thu,  7 Oct 2021 12:39:38 +0200
Message-Id: <20211007103943.8433-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the remaining pointers from struct hal_ops and
the struct itself.

Note that I sent the first two patches separately yesterday, so this
series makes the separately sent patches obsolete.

Tested with Inter-Tech DMG-02 on x86_64.

Michael Straube (5):
  staging: r8188eu: remove SetHwRegHandler from hal_ops
  staging: r8188eu: remove GetHwRegHandler from hal_ops
  staging: r8188eu: remove hal_init from hal_ops
  staging: r8188eu: remove hal_ops
  staging: r8188eu: rename rtl8188eu_set_hal_ops()

 drivers/staging/r8188eu/core/rtw_ap.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        | 12 +--
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       | 13 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 73 ++++++++-----------
 drivers/staging/r8188eu/core/rtw_p2p.c        | 16 ++--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  6 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 44 +++++------
 drivers/staging/r8188eu/hal/hal_com.c         |  3 +-
 drivers/staging/r8188eu/hal/hal_intf.c        | 16 +---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  6 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  8 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 18 ++---
 drivers/staging/r8188eu/include/drv_types.h   |  1 -
 drivers/staging/r8188eu/include/hal_intf.h    | 20 ++---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  6 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  4 +-
 19 files changed, 106 insertions(+), 148 deletions(-)

-- 
2.33.0

