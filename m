Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE96E3DA9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhG2RJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG2RJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91791C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:43 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i39-20020a9d17270000b02904cf73f54f4bso6597082ota.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isu5knoKM82mHKKPvZvU7A9KKB+tgB30G7ELkkDeyRs=;
        b=hKMGOwGzpeuDqov5O7QxZmfGxd6Md8Cp56XUnPzvuDYDdraTyCGDp97vrXjp1krgA7
         jcXmGm/7CPG1MRFMWgAzaqSLczvJI6xUt9hXPkQlKMggT27307gtAF+1kQGr65h/frCq
         +pHwn4OwH/pH6iAhfTgG9zS8jlpWfNyI1ObbJ/M5MWKDRVh5OxDMoQt93EJsjv2TBjCB
         mNA7jXNEaxWcgNPTVsvjQZ9aZ8ifpKiXFtM8fSNQfoE1OY7PzI24544RF4vyk6KGOT1M
         juN/xnEnrk7SzELkKWlwHPOD4i5+FkDoAdwg2ExWqZTcNe093Ysl9y2L4szJhpQFc2h8
         dZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=isu5knoKM82mHKKPvZvU7A9KKB+tgB30G7ELkkDeyRs=;
        b=ueE7b0qN17UGPGOAfhMIToZ9P2RCk61Ov1FQCggMcL9yDTzEiel7XG2cNs5C7/zQhq
         /6QJ4sL0oZtXBMIUvZmV1Tiq+a2gyDIS+lLY4XuNUH/RtnZB/Te0L3v3G9l7hN0M4Tv0
         0t/VRu2z8JInlCmb1hWY+mD9mTdL4zp63zWJ8j54fxNqmRxhlQvKkWHqLtnMOg4VwcII
         DbziijeJqLXMxGOK+iLr0JF13k+wjfuMVwWeDgiYuf59uwLsGtf1T5gppzO9CV0UHBw8
         QrS4oXPPFm6dQ6UleoqkY7tOMit1HTmAKLfcHLYEKSic3xokLbpHgpXnTRuN9UMpY6vO
         h4pQ==
X-Gm-Message-State: AOAM533KQ2+xWXlX+4hhRV4amqNFnOso/jjaOZAawUd1YqF0OmEUUrJ9
        djOQNLffhjmtjiffEFZ1O/s=
X-Google-Smtp-Source: ABdhPJwM+jCDmk0xnCoQVhRhh6+coXHZG1u6BoGw772syhaJWA/jCH7c4Y6K8iWqv7CHY/wDvHzjSA==
X-Received: by 2002:a05:6830:34a4:: with SMTP id c36mr3970253otu.57.1627578582970;
        Thu, 29 Jul 2021 10:09:42 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id a23sm614358otv.79.2021.07.29.10.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:09:42 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/6] Do more cleanup of the new rtl8188eu driver
Date:   Thu, 29 Jul 2021 12:09:24 -0500
Message-Id: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches eliminates several of the small header file by
moving their content into longer headers. One patch also removes the
code used to build the driver on kernels older than mainline.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>


Larry Finger (6):
  staging: r8188eu: Remove empty header file
  staging: r8188eu: Remove tests of kernel version
  staging: r8188eu: Remove include/rtw_qos.h
  staging: r8188eu: Remove header file include/usb_hal.h
  staging: r8188eu: Remove header file include/rtw_version.h
  staging: r8188eu: Add "fallthrough" statement to quiet compiler

 drivers/staging/r8188eu/core/rtw_debug.c      |  2 +-
 drivers/staging/r8188eu/core/rtw_led.c        | 12 ----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  2 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        | 53 ----------------
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 12 ----
 drivers/staging/r8188eu/core/rtw_recv.c       | 16 -----
 drivers/staging/r8188eu/core/rtw_xmit.c       |  8 ---
 drivers/staging/r8188eu/hal/hal_intf.c        |  1 -
 drivers/staging/r8188eu/hal/odm.c             |  9 ---
 drivers/staging/r8188eu/hal/odm_interface.c   | 10 ---
 drivers/staging/r8188eu/hal/usb_halinit.c     |  1 -
 drivers/staging/r8188eu/include/drv_types.h   |  4 +-
 .../staging/r8188eu/include/drv_types_linux.h |  7 ---
 drivers/staging/r8188eu/include/hal_intf.h    |  1 +
 drivers/staging/r8188eu/include/odm_precomp.h |  4 --
 .../staging/r8188eu/include/osdep_service.h   | 12 ----
 drivers/staging/r8188eu/include/rtw_led.h     |  4 --
 drivers/staging/r8188eu/include/rtw_mlme.h    | 11 ++--
 drivers/staging/r8188eu/include/rtw_qos.h     | 14 -----
 .../staging/r8188eu/include/rtw_security.h    |  8 ---
 drivers/staging/r8188eu/include/rtw_version.h |  2 -
 drivers/staging/r8188eu/include/usb_hal.h     | 10 ---
 drivers/staging/r8188eu/include/usb_ops.h     | 16 -----
 drivers/staging/r8188eu/include/wifi.h        |  3 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  1 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c   | 63 -------------------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 -
 drivers/staging/r8188eu/os_dep/recv_linux.c   | 16 -----
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  4 +-
 29 files changed, 12 insertions(+), 297 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/drv_types_linux.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_qos.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_version.h
 delete mode 100644 drivers/staging/r8188eu/include/usb_hal.h

-- 
2.32.0

