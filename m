Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE13B39EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhFYAKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYAKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:22 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAE0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:01 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u8so997167qvg.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LU8t8n/y6U/YMGuulzehFo/mO+G15t7XeGsTRxbtGWk=;
        b=Z0PV5x5OIqcWh17O23MwOZQnaQCa3qNCvXdlnhcWU/sFC1LZNKA7VkdQa3rp7wuqow
         ItwfhxYIT2bNlTdoK5Gn7Bz1X/9cn0sX0xOkol6G6klTMem1uoJCWpuzRT1tl/T5LpdV
         Ee47iqRP/4GuIWxO0GjePXqlSaGhhpbIFVgb0wCtiojCPxq0HCNot396Bq87EwE3oM+9
         MKKFcZI2q0IJJfZkn0HXOu41tx7t0YdhdBZOUmfrVnjB+KUuyQYsL/3vNiiEltW3s9+V
         eenjcXzU6pi+tfgP83Q15wJ7ziO0NXxALinGjtVzyAyQxFTRKomWgLd59ZPqi2sB6ogF
         4lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LU8t8n/y6U/YMGuulzehFo/mO+G15t7XeGsTRxbtGWk=;
        b=nswSKi2cOxK00aS4QN/lNYJ91AydxxuUXFwV4OTigrgj1JRrLhSchEduV/hbsmnneW
         qBnzfCazOutRYQod955UkzsnIwwWLKJR4s3vxigQjRyLQeBZ+fQ5UpIwz5hkIcWBVAPm
         URIuOT3VS1SYLK1Cm1X8YGecW4qDEgpQTF1Er+CHJJHcKCKqjc0pJ9T/dQc/CWCihz0P
         UMDsKgh6jSeQvFxX0RfvX4glltRvXfU9gZOnTAyjzH7ybfc+vXYDzxJ8PE3uMcBt+i3W
         r/vnpensfySg22h3usKBUu7UwrK4VVSRL3Fj2EyfsLoubi1RdCrXOzvI7kBHtqtjxUjF
         bzGA==
X-Gm-Message-State: AOAM5328KAdVva6w6CB8uV6EWHsrMR5c9jAhYy7crrYUuwmynodjuF/E
        hdvDnUiDf3m8e7I3tfvmKwuTgw==
X-Google-Smtp-Source: ABdhPJxkygGYfwIZm3iN298xnfG/dxxBbCoq4FUOYU+iYHuxkfiNrkZiCuMOqBoUVry/gq6QYtg8Qw==
X-Received: by 2002:ad4:4852:: with SMTP id t18mr8372496qvy.33.1624579680330;
        Thu, 24 Jun 2021 17:08:00 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:07:59 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 00/23] staging: rtl8188eu: remove include/rtw_debug.h
Date:   Fri, 25 Jun 2021 01:07:33 +0100
Message-Id: <20210625000756.6313-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes all RT_TRACE calls from the driver, and the
associated macro from include/rtw_debug.h, as well as cleaning up the
last few other parts of this header that are still used. It then removes
the whole file, thereby cleaning up the driver's codebase substantially.

Phillip Potter (23):
  staging: rtl8188eu: remove all RT_TRACE calls from
    os_dep/ioctl_linux.c
  staging: rtl8188eu: remove all RT_TRACE calls from os_dep/xmit_linux.c
  staging: rtl8188eu: remove all RT_TRACE calls from os_dep/os_intfs.c
  staging: rtl8188eu: remove all RT_TRACE calls from os_dep/mlme_linux.c
  staging: rtl8188eu: remove all RT_TRACE calls from os_dep/recv_linux.c
  staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_security.c
  staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_sta_mgt.c
  staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_mlme_ext.c
  staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_mlme.c
  staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_led.c
  staging: rtl8188eu: remove all RT_TRACE calls from
    core/rtw_wlan_util.c
  staging: rtl8188eu: remove all RT_TRACE calls from
    core/rtw_ieee80211.c
  staging: rtl8188eu: remove all RT_TRACE calls from
    core/rtw_ioctl_set.c
  staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_recv.c
  staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_pwrctrl.c
  staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_xmit.c
  staging: rtl8188eu: remove all RT_TRACE calls from
    hal/rtl8188eu_xmit.c
  staging: rtl8188eu: remove all RT_TRACE calls from hal/hal_intf.c
  staging: rtl8188eu: remove all RT_TRACE calls from
    hal/rtl8188eu_recv.c
  staging: rtl8188eu: remove RT_TRACE macro
  staging: rtl8188eu: remove DRIVER_PREFIX preprocessor definition
  staging: rtl8188eu: remove GlobalDebugLevel variable
  staging: rtl8188eu: remove include/rtw_debug.h header

 .../staging/rtl8188eu/core/rtw_ieee80211.c    |  71 +-----
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    |  89 +-------
 drivers/staging/rtl8188eu/core/rtw_led.c      |  17 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c     | 133 ++---------
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  41 +---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c  |  27 +--
 drivers/staging/rtl8188eu/core/rtw_recv.c     | 215 ++----------------
 drivers/staging/rtl8188eu/core/rtw_security.c |  21 +-
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c  |  21 +-
 .../staging/rtl8188eu/core/rtw_wlan_util.c    |  27 +--
 drivers/staging/rtl8188eu/core/rtw_xmit.c     | 101 +-------
 drivers/staging/rtl8188eu/hal/hal_intf.c      |   3 -
 drivers/staging/rtl8188eu/hal/odm.c           |   2 -
 .../staging/rtl8188eu/hal/rtl8188eu_recv.c    |   2 -
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    |   9 -
 drivers/staging/rtl8188eu/include/drv_types.h |   1 -
 drivers/staging/rtl8188eu/include/rtw_debug.h |  70 ------
 drivers/staging/rtl8188eu/include/rtw_mlme.h  |   2 -
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |   4 +-
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    |  52 +----
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c |   4 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   |  43 +---
 drivers/staging/rtl8188eu/os_dep/recv_linux.c |   8 +-
 .../staging/rtl8188eu/os_dep/rtw_android.c    |   1 -
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c |  12 +-
 25 files changed, 69 insertions(+), 907 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_debug.h

-- 
2.31.1

