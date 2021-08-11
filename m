Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6A3E9AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhHKV6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 17:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhHKV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 17:58:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D58C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 14:58:12 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o20so6840546oiw.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ffEovo72jB0896lCY2QBWVkyqJIjuYfWFlsrTfJBxg=;
        b=mObmYPmrUe5F/Sce0a+/DAl71hlQHvvp3ewU5maNAgyvE2N+FDBnuSoptCVq4xVvIK
         L8cYBF5b/t49KCwixfnFIaNfpgFzkqgWI5opBQsYeJl2rL90RoRGVyJWdfbRsIOLX/qt
         rEypFxSq9f5Oy0Fd5ziFDJttLUjCNh2+zMjW6slETmJWcV5JVjQ/Xt5rtr/dc/mitzt/
         MdvTW6PMuLRQ5/JRG0G06NdFxt0xCG7puDN4ev/LTR19j6qp+JeGofChyd3T9Uvzn9V/
         PGmcDEYYsfEaj90huTo92iwNL3XGNW5GdvSOb77YxbSidAebHRsOVcEzFrGBsWM/foFF
         SxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4ffEovo72jB0896lCY2QBWVkyqJIjuYfWFlsrTfJBxg=;
        b=ZNfvpCDpo+M7eGBX/MT1BdKuAGeH7WxuSO/WmPMGnPlx6ZVgiaJOgdw7BY9pWJYmMk
         bOptQfPw9+k0aZ0lyVLGS2eJoSt0q91lzNzts7frx4Y7NODBPFscbjgK2yZjQspb5kYB
         OZ7IfDEYJlrU68Je1UN02dHu3gkqgkwthxjcQgXwqNKvWhfe+tSQ1Ozz6FVAdSY7SRCK
         Wm9dyc4Qas/DVRnBqwrMH4eTQjYGSn/UjTN6YV4hF3KLslIC0nL3Y4qaNkfvuN48+nWC
         41MNm4JTY+zS1EVxJm6u+5PwIZlHpCAyR9Dyw8KaqsfqQo0geODfipxtpblMI1xiN02Z
         AUqQ==
X-Gm-Message-State: AOAM531egY7SVfLzKEONalL8v48kFSYON7mjHJu4WHOCIxok4fnV1+TZ
        sx8MUEQzK+CEZU/CFpV2n+XJLsfkaQw=
X-Google-Smtp-Source: ABdhPJwCwqc5nxBifSF7+iCKeyF4RlYjCeQu5PIyYosqeOKKe5yY68G0Ixz5/IUJsMPUTVwSWpN6nw==
X-Received: by 2002:a54:4197:: with SMTP id 23mr8857720oiy.159.1628719091809;
        Wed, 11 Aug 2021 14:58:11 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id u126sm105852ooa.23.2021.08.11.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:58:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/3] staging: r8188eu: Clean up some smatch warnings and errors
Date:   Wed, 11 Aug 2021 16:58:03 -0500
Message-Id: <20210811215806.20426-1-Larry.Finger@lwfinger.net>
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
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  58 ++++-----
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |   2 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |   8 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 117 +++++++++---------
 29 files changed, 227 insertions(+), 240 deletions(-)

-- 
2.32.0

