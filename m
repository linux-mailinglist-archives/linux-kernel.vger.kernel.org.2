Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921AD3DDC1D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhHBPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhHBPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:16:07 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7648AC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:15:58 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so17776392otu.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/ycPrXBrf/6vMGA/hMJXG9k3UdjT2X/h5Y1gF7KTcs=;
        b=rpHBULYxCnf3za8GmirLDgmBb3s38NbzbNVCZYyKZ+6PqVfY6dnNT3rCsy9ojBQfTn
         F1srTeAAMxlkjMOuU3Iq4kMAwurVh0PPsU7ahqdSDUTuxVfFi/RdXNCKlkUxA3PSChOh
         JDg1qd3qHUDHgtRPRwSqtJqCWcSRgZJRYfQ5f3JKwHFADjKgUPpimxk/ac+MaV+Iz54o
         ieW2p5zHjD+0hvgXWm+VFGYHIBabG2a+HZ60ept/NUtm4khFcQApkUKV9MLJQhRw9w3B
         xzeaIHlymFItcA5EbmvqxMmusBMi0CFCoAVVMibw2V/7WgkdS8plkKQJAX24IMLErxDn
         5Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6/ycPrXBrf/6vMGA/hMJXG9k3UdjT2X/h5Y1gF7KTcs=;
        b=J4EEGfN2sVTqtmD5Xqt9eBOC2uI0dOPdh0Kk9TkCC0MIrgPHxkvOqF4vmSKEYNgR7E
         r2Fya49jFpjHysQFVNuodS4aUznvHReZh9iEvqlLRBnBAnY3wD6v3nO1HKSI891Tdll4
         BTNt898YvYqhbWRFwMz+5dnsF767XWyU9N+nlsLw6hTyZyE+R2oHwHRZCDM9DHFWJ5Za
         znGkp8Ng/I39AFerO2nfGa5JihzKdDHyB4IkHSu1q5ck+ZIo7gtdX9rZmZgpYHhk0ZXh
         qHKXPEHSf8SVwqRBzYO4ctM4jX3sH4wDNMiekc0O5L1AmDdOVdyO6m1xyi8+PqY8yXIZ
         KkdA==
X-Gm-Message-State: AOAM5323YYnZ0sxE1MvmSf16ESYb0npqB7Rz/Bo3yakdVHIJL9Ax0Q9R
        XTIDDDa4uPzvcU35HJSXcsI=
X-Google-Smtp-Source: ABdhPJyEzTbAFj9m1y16SbmDB5ZHBzSWb8fHxs+EoHITbILH0+XWXM5kzajvBQoa9Atj++yhpBwYUg==
X-Received: by 2002:a05:6830:4188:: with SMTP id r8mr12035800otu.53.1627917357799;
        Mon, 02 Aug 2021 08:15:57 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id w16sm1807034oiv.15.2021.08.02.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:15:57 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/6] Clean up some extraneous wrappers and some empty routines
Date:   Mon,  2 Aug 2021 10:15:40 -0500
Message-Id: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code created some wrappers to handle the differences between
Linux and Windows. In a Linux-only version, these can be removed.

Larry Finger (6):
  staging: r8188eu: Remove wrappers for kalloc() and kzalloc()
  staging: r8188eu: Remove wrapper around vfree
  staging: r8188eu: Remove wrappers for atomic operations
  staging: r8188eu: Remove 4 empty routines from os_sep/service.c
  staging: r8188eu: Remove all calls to _rtw_spinlock_free()
  staging: r8188eu: Remove more empty routines

 drivers/staging/r8188eu/core/rtw_ap.c         |   8 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c     |   2 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c.rej |  11 ++
 drivers/staging/r8188eu/core/rtw_cmd.c        |  16 +--
 drivers/staging/r8188eu/core/rtw_efuse.c      |   4 +-
 drivers/staging/r8188eu/core/rtw_efuse.c.rej  |  20 ++++
 drivers/staging/r8188eu/core/rtw_mlme.c       |  15 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  44 +++----
 .../staging/r8188eu/core/rtw_mlme_ext.c.rej   | 107 ++++++++++++++++++
 drivers/staging/r8188eu/core/rtw_mp.c         |   5 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        |   8 +-
 drivers/staging/r8188eu/core/rtw_p2p.c.rej    |  18 +++
 drivers/staging/r8188eu/core/rtw_recv.c       |  16 +--
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  48 +-------
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |   2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |  26 +----
 drivers/staging/r8188eu/hal/odm_interface.c   |   2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |   2 +-
 .../staging/r8188eu/hal/rtl8188e_cmd.c.rej    |  11 ++
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  10 +-
 .../r8188eu/hal/rtl8188e_hal_init.c.rej       |  34 ++++++
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   3 +-
 .../staging/r8188eu/hal/rtl8188eu_recv.c.rej  |  12 ++
 drivers/staging/r8188eu/hal/usb_halinit.c     |   2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c.rej |  11 ++
 drivers/staging/r8188eu/include/drv_types.h   |   2 +-
 .../staging/r8188eu/include/odm_precomp.h.rej |  19 ++++
 .../staging/r8188eu/include/osdep_service.h   |  28 -----
 drivers/staging/r8188eu/include/rtw_cmd.h     |   2 +-
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   2 +-
 drivers/staging/r8188eu/include/usb_ops.h     |   4 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  70 ++++++------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 -
 .../staging/r8188eu/os_dep/osdep_service.c    | 105 +----------------
 drivers/staging/r8188eu/os_dep/rtw_android.c  |   2 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  10 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   2 +-
 .../staging/r8188eu/os_dep/xmit_linux.c.rej   |  11 ++
 39 files changed, 366 insertions(+), 333 deletions(-)
 create mode 100644 drivers/staging/r8188eu/core/rtw_br_ext.c.rej
 create mode 100644 drivers/staging/r8188eu/core/rtw_efuse.c.rej
 create mode 100644 drivers/staging/r8188eu/core/rtw_mlme_ext.c.rej
 create mode 100644 drivers/staging/r8188eu/core/rtw_p2p.c.rej
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_cmd.c.rej
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c.rej
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c.rej
 create mode 100644 drivers/staging/r8188eu/hal/usb_halinit.c.rej
 create mode 100644 drivers/staging/r8188eu/include/odm_precomp.h.rej
 create mode 100644 drivers/staging/r8188eu/os_dep/xmit_linux.c.rej

-- 
2.32.0

