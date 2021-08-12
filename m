Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE52B3E9C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhHLBxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLBxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:53:08 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F151C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:52:44 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bj40so7741875oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hikIeodmpms+ptOTxs+0WU9ZF1QyEbMM/oI8jbMJBo=;
        b=lJMpS3sJZWxYSe98itQsP9CDbGlqreyl6H4K77FPFiwPjGfFYK9HJLihd74u6PckSx
         rGRCA189RpE8rjwFRWlbgNt7uj3Fs4/oMhCt4XtUHcen6j1ErP0SSCwVr7qlUl079Uhw
         KVrSGZS084s3pxR83fkzNLsT4chyoBMwOF6xHd/yudiZCjipGT4fOsdK16z+bpD4DPqF
         90DWKZwE0C+xwLfll/HWYkz7SAkh5CZ/njpjOqgGpuohD9bno7Dy8HhMIvd+pXP8dgK8
         vOm7JLp0iaO61v9npY5mx6RL2gMJZE0KLEh8x/ZCe6dQmIzwKKOs38Tp49yKfEXODwkW
         5F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5hikIeodmpms+ptOTxs+0WU9ZF1QyEbMM/oI8jbMJBo=;
        b=txzJnQKJwtjHxROVjyg3Xo70tv1UEDyyeKv0ahGTZXATXbE0VsORhJ8X0Mk7bzT57w
         +kg5X3lqw68R2823N3BkFUctR6pP7w45qtO1vVdra0s564rxb4GPhDNrHDOxb1iH2JX3
         yJ6BW9CbfVdSYQhzrDCrXMuhsS7opsHzQCKccigs4GSYt5wAwgPekfwhC2wkYEWpWj2N
         DXmT4CgeN8Adex7WlYLRHzaLUEHpWUNa+pHl7KQaa8uFdc3xKgT/fDT6hKFtX3DvxVBN
         j+d+XFwYHJlDjWacUSe+XE7xL37XPDezm4wsp1KTvqqs3GVtwJZ84mIkzRnhHFaeNJk7
         7TMg==
X-Gm-Message-State: AOAM531O33Y+fcU8/pDtj7IANP91cudYRH1YM1keUqZvm2vAnVAC6PAA
        4W1jYNRud66dGPw4qJQG4acejRcTzmI=
X-Google-Smtp-Source: ABdhPJwLnCOMTp/YFFiQt7qAgqGIafwa/Zvye9jq08+ok2LMtYykHbSs3cMKDUgiUAXTtpah6hTN0Q==
X-Received: by 2002:a05:6808:1388:: with SMTP id c8mr9551414oiw.172.1628733162848;
        Wed, 11 Aug 2021 18:52:42 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id q21sm305718otn.61.2021.08.11.18.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 18:52:42 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 0/3] staging: r8188eu: Clean up some smatch warnings and errors
Date:   Wed, 11 Aug 2021 20:52:29 -0500
Message-Id: <20210812015232.23784-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports a number of warnings ans a few errors. Most are places where
the indentation is messed up, but a few are unitialized variables or
dereferencing a pointer before checking it.

Smatch does output a false message concerning a potential memory leak.
The pointer is saved, and the memory freed in another routine.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

---
v2 - did a respin of the patches due to conflict
---
Larry Finger (3):
  staging: r8188eu: Fix Smatch warnings for core/*.c
  staging: r8188eu: Fix smatch problems in hal/*.c
  staging: r8188eu: Fix smatch warnings in os_dep/*.c

 drivers/staging/r8188eu/core/rtw_br_ext.c     |   2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        |   6 -
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |   2 +-
 drivers/staging/r8188eu/core/rtw_io.c         |   2 +-
 drivers/staging/r8188eu/core/rtw_led.c        |  20 +--
 drivers/staging/r8188eu/core/rtw_mlme.c       |  16 ++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  16 +--
 drivers/staging/r8188eu/core/rtw_mp.c         |   6 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        |   4 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  18 +--
 drivers/staging/r8188eu/core/rtw_security.c   |   6 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |   6 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  14 +--
 drivers/staging/r8188eu/core/rtw_xmit.c       |   4 +-
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  16 +--
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   2 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   2 +-
 drivers/staging/r8188eu/hal/odm.c             |  18 +--
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |   2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |   2 +-
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |   8 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  18 +--
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  87 +++++++------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  56 +++++----
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |   2 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |   8 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 117 +++++++++---------
 29 files changed, 226 insertions(+), 239 deletions(-)

-- 
2.32.0

