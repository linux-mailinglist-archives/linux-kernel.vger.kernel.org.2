Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B4E356DC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347585AbhDGNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhDGNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0208CC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:49:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a12so8298478wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLDZxUjEmd8H03UIAZwbOELnb4PvWVwu2cigZdBcIQ8=;
        b=CXISKQLewVQGInvpUf/mMnS6BvtM4/uF7pOgJL2g+njL6Xae6CHqy5iA9RjmdC/H0Q
         WO1FhlHnQtNnlb/G+vsgDZQ3cCzW2fqokFURv4OszU6qhx6Kwnuwk/eRJqWApy6yc72b
         YbR7F1vVSWiWSB7qj3v4mK3uNUJnsO4SjTyF5cjePv+Z8OFK/PYv1Cz0fBptaYxJvnVs
         vOXFrB/VV8WPEIR54PpyR24m2cmCru93VVAkNZnIsuTqfvx+uw03kn/zZklBnIcxHwZQ
         GSvnaCJJWZ+cOzGocef16EqMPwLKKLPb9P+vNcQaCPFX01oR8hdB2YG4rDOXgLOMJQC/
         8K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLDZxUjEmd8H03UIAZwbOELnb4PvWVwu2cigZdBcIQ8=;
        b=oRdmhLljoUHAxjivtSKN0fSJpmtP/BHozZL/TDkVMF5itF0yVHlJacxN2dYwzpa0gf
         HWv1H8EQiI1KcgWLmbS79Ko7mTMuWqH7KhqdrTy2dNiahkFOinXelcBYfQwGZcNZE1Ae
         cCDejNMJeJrrXsG52ALEm499x5owQ1i8c0qhIG8TdEdfDQl/0JNLvc2yOGMU3yIMyjID
         rGtpeFPxQ43JKSz/kUfpuuHiv5P+brcoGbKjzCZrdvmU2ex2kmMUKfq9j2BQz/dxt0a1
         lmu4Lbc2fK7VK7hO74wzzRgpMDL3SZ2aRvBK2TwqAvQhspZTzer/KQFHs0zra5ESureL
         eF5Q==
X-Gm-Message-State: AOAM53113y3uJzc1RAYS88R/XbJILNVaBnOiJMQURr9tyc1MuoK03vrG
        rzj87YadEa2bwDMNol0gKzcJ5Z9tJV0tyA==
X-Google-Smtp-Source: ABdhPJx5Ztgk3j91FSUQSM63bgKDRbwsEtMnqxxyn4vCXUYF4+1+EV4JCN45wOzS0Y0CIRR7pPK4EQ==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr4504524wrr.350.1617803392737;
        Wed, 07 Apr 2021 06:49:52 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id t17sm27563265wrv.91.2021.04.07.06.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:49:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 00/19] staging: rtl8723bs: remove DBG_871X trace macro
Date:   Wed,  7 Apr 2021 15:49:24 +0200
Message-Id: <cover.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes all DBG_871X usages and definitions.

The whole private tracing system is not tied to a configuration
symbol and the default behaviour is _trace nothing_.

DBG_871X macros require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged, so just remove them as they are unused.

First patch fix a DBG_871X call. It has three args over only two
placeholders in the first format string argument.
If I would not make this fix, the semantic patch
used to bulk remove all macro occurences would ignore the abnormal
macro (the one with three args) and all subsequent occurrences in
the same file (core/rtw_recv.c).

The second patch applies the cocci script.

This is the semantic patch:

@@
expression a, b, c, d, e, f, g, h, i, j, k;
constant B, C, D, E;
@@

(
-	DBG_871X(a);
|
-	DBG_871X(a, b);
|
-	DBG_871X(a, B);
|
-	DBG_871X(a, b, c);
|
-	DBG_871X(a, B, c);
|
-	DBG_871X(a, b, C);
|
-	DBG_871X(a, B, C);
|
-	DBG_871X(a, b, c, d);
|
-	DBG_871X(a, B, c, d);
|
-	DBG_871X(a, b, C, d);
|
-	DBG_871X(a, b, c, D);
|
-	DBG_871X(a, B, C, d);
|
-	DBG_871X(a, B, c, D);
|
-	DBG_871X(a, b, C, D);
|
-	DBG_871X(a, B, C, D);
|
-	DBG_871X(a, b, c, d, e);
|
-	DBG_871X(a, B, c, d, e);
|
-	DBG_871X(a, b, C, d, e);
|
-	DBG_871X(a, b, c, D, e);
|
-	DBG_871X(a, b, c, d, E);
|
-	DBG_871X(a, B, C, d, e);
|
-	DBG_871X(a, B, c, D, e);
|
-	DBG_871X(a, B, c, d, E);
|
-	DBG_871X(a, b, C, D, e);
|
-	DBG_871X(a, b, C, d, E);
|
-	DBG_871X(a, b, c, D, E);
|
-	DBG_871X(a, B, C, D, e);
|
-	DBG_871X(a, B, C, d, E);
|
-	DBG_871X(a, B, c, D, E);
|
-	DBG_871X(a, b, C, D, E);
|
-	DBG_871X(a, B, C, D, E);
|
-	DBG_871X(a, b, c, d, e, f);
|
-	DBG_871X(a, b, c, d, e, f, g);
|
-	DBG_871X(a, b, c, d, e, f, g, h);
|
-	DBG_871X(a, b, c, d, e, f, g, h, i);
|
-	DBG_871X(a, b, c, d, e, f, g, h, i, j);
|
-	DBG_871X(a, b, c, d, e, f, g, h, i, j, k);
)

The third one removes an unmatched macro call,
maybe due to the trailing \, because the occurrence is
inside a macro expansion.

The fourth one deletes all commented out call spread all over
the rtl8723bs code.

Fifth one removes definitions.

All remaining patches do some code cleaning on all
places where DBG_871X has been removed.

Fabio Aiuto (19):
  staging: rtl8723bs: remove DBG_871X log argument
  staging: rtl8723bs: remove all DBG_871X logs
  staging: rtl8723bs: remove DBG_871CX log unmatched by cocci
  staging: rtl8723bs: remove commented out DBG_871X logs
  staging: rtl8723bs: remove DBG_871X macro definitions
  staging: rtl8723bs: remove all if-else empty blocks left by DBG_871X
    removal
  drivers: rtl8723bs: rewrite comparison to null
  staging: rtl8723bs: put constant on the right side in if condition
  staging: rtl8723bs: remove empty for cycles left by DBG_871X removal
  staging: rtl8723bs: remove empty tracing function dump_rx_packet
  staging: rtl8723bs: remove empty #ifdef blocks after DBG_871X removal
  staging: rtl8723bs: remove unnecessary bracks on DBG_871X removal
    sites
  staging: rtl8723bs: remove unnecessary parentheses in if condition
  staging: rtl8723bs: add spaces around operators
  staging: rtl8723bs: rewrite comparison to null
  staging: rtl8723bs: remove unnecessary parentheses
  staging: rtl8723bs: fix comparison in if condition
  staging: rtl8723bs: split long lines
  staging: rtl8723bs: remove unnecessary parentheses

 drivers/staging/rtl8723bs/core/rtw_ap.c       | 158 +------
 drivers/staging/rtl8723bs/core/rtw_btcoex.c   |  12 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  51 +--
 drivers/staging/rtl8723bs/core/rtw_efuse.c    |  11 -
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  48 +-
 drivers/staging/rtl8723bs/core/rtw_io.c       |   7 +-
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  11 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 170 +------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 366 ++-------------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 144 +-----
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 251 +----------
 drivers/staging/rtl8723bs/core/rtw_security.c |  26 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  10 -
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 154 ++-----
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 141 +-----
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |  11 -
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c  |   9 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   2 -
 drivers/staging/rtl8723bs/hal/hal_com.c       |  49 +-
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 208 ++-------
 drivers/staging/rtl8723bs/hal/hal_intf.c      |  12 +-
 drivers/staging/rtl8723bs/hal/odm.c           |   3 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  92 +---
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |   5 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  90 +---
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  15 +-
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |   9 -
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  37 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  31 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  23 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h |   6 -
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |   3 -
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |   1 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 208 +--------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 421 +-----------------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |   6 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  90 +---
 .../staging/rtl8723bs/os_dep/osdep_service.c  |   2 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |   5 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  27 +-
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c |  97 +---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  21 +-
 42 files changed, 299 insertions(+), 2744 deletions(-)

-- 
2.20.1

