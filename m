Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2773DEF58
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhHCNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbhHCNws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:52:48 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CE5C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:52:36 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q6so28184534oiw.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhbzsY+tTnAKgzXZh/xEXBKlkdc8m0ej+2cuyOJY7qM=;
        b=RNJ7I2mB/n6aVDf8Ywh0+t7JQKfZvVqXZgBP6k4hyWkMMYoY6V/p/OlceVb3mPstCR
         RzIot8pNNjuKWSalD5ELgd7m1Q0egvwzFBpDGjWi5/dfU5Ii12eDUtUqk2/fUbRtN5iz
         aK9mZE6K8ARI2bKof3yF8rKGaNMOxKME47iLWjjv2aSjNOY6jcKdX+CVi8FuEWVyfWer
         goyMcGTkk/BTlXiyFGP09SlagHfcrU/wEQXdIoH4qk+M2syqb0NSFU31Obj3dc2fBf1E
         VcbeKlUfwp49+qJP+8rVDFM2PgIEwIkOSWon8shIGiB6N/6w+Tf05n99SZrKj9DhMzUK
         ojng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vhbzsY+tTnAKgzXZh/xEXBKlkdc8m0ej+2cuyOJY7qM=;
        b=s7fW5h4dWyb36sRlH7xDgO9yXqiarMwoPRZqCawpcV8RHr5Ezr72bwHnt0a8dkgq/w
         vN4qOzcOO6WFeH8hUjol8ODzV6A1EL06V3qC8Kk20/t+cBrQOBHG6wUWOS5fUDgNzr1D
         FMpqhJ0cYHO2DN4+FanRBx2YOyoC+ba1HY9Y4X6y/2sCPRGUftFYV1xjihZ03tBA+uV0
         oKSaCdJlfe/141lEAtbTbsBhh4I4Ty7ITq8yLJVfalRNtUFEOtV0DwCj1CBAMdU91Md/
         JFQnEvvyoqxoGOQQ5GXpxOSkFgYZQEsh2QwEEwSdG27Ol8mv2wXIBgJ37Tju0bIzOK4e
         FlBw==
X-Gm-Message-State: AOAM531av2dtiSb+629UF6dM16HeS4qKznFFVT56Cq+UhJAOCeiFPH9i
        RmQ3EZwTWG8BWFaqjDbse+0=
X-Google-Smtp-Source: ABdhPJzEGIfraRaSh4d3PQ9mRDv6iyramH0iY0/hZy0gki+8lEQmlNB/XdCMTp2kYsLmFGUew8OHGg==
X-Received: by 2002:a05:6808:1981:: with SMTP id bj1mr1656302oib.8.1627998755958;
        Tue, 03 Aug 2021 06:52:35 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com. [2603:8090:2005:39b3::1010])
        by smtp.gmail.com with ESMTPSA id y26sm2504106otq.23.2021.08.03.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:52:35 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 00/10] Various cleanups of driver
Date:   Tue,  3 Aug 2021 08:52:13 -0500
Message-Id: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches removes some wrappers around simple actions,
and replaces some of the home-built bit manipulation macros.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>


Larry Finger (10):
  staging: r8188eu: Remove wrappers for kalloc() and kzalloc()
  staging: r8188eu: Remove wrapper around vfree
  staging: r8188eu: Remove wrappers for atomic operations
  staging: r8188eu: Remove 4 empty routines from os_sep/service.c
  staging: r8188eu: Remove all calls to _rtw_spinlock_free()
  staging: r8188eu: Remove more empty routines
  staging: r8188eu: Remove rtw_division64()
  staging: r8188eu: Remove wrapper around do_div
  staging: r8188eu: Remove some unused and ugly macros
  staging: r8188eu: Remove some bit manipulation macros

 drivers/staging/r8188eu/core/rtw_ap.c         |   8 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c     |   2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        |  16 +--
 drivers/staging/r8188eu/core/rtw_efuse.c      |   4 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       |  15 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  44 +++----
 drivers/staging/r8188eu/core/rtw_mp.c         |   5 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        |   8 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  16 +--
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  48 +-------
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |   2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |  26 +---
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |   2 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |   2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |   2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  10 +-
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   3 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |   5 +-
 .../r8188eu/include/Hal8188ERateAdaptive.h    |  59 ++++-----
 drivers/staging/r8188eu/include/basic_types.h |  45 -------
 drivers/staging/r8188eu/include/drv_types.h   |   2 +-
 drivers/staging/r8188eu/include/odm_types.h   |  12 +-
 .../staging/r8188eu/include/osdep_service.h   |  70 -----------
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  26 ++--
 drivers/staging/r8188eu/include/rtw_cmd.h     |   2 +-
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   2 +-
 drivers/staging/r8188eu/include/usb_ops.h     |   4 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  70 +++++------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 -
 .../staging/r8188eu/os_dep/osdep_service.c    | 116 +-----------------
 drivers/staging/r8188eu/os_dep/rtw_android.c  |   2 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  10 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   2 +-
 34 files changed, 156 insertions(+), 489 deletions(-)

-- 
2.32.0

