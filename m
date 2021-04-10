Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA535AEA1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhDJPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 11:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhDJPAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 11:00:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA12C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:00:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s15so9856264edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMhLL/zmfb0UTfjF/sD2Sc2fOjk1wvP7x0u+3C18oCY=;
        b=W59pRIcct6yXQX+TT3XK6OB0EQPzdKY93PYF/MoLTjbXvLETtuDWkvXb2RHDswlLlY
         OTGMcF09BYPVmmu16v8IZzLbsIyf/Agm5TVRWPQdHnV91bQRFRHiOXKQ05c61/4r7ZZ4
         o0/8cHxDNf/ZAVQEbuv8WmF5LWCk+SwEv1HbkyfUu4mu0BOtjTj+xgSC7bVElZ7eXB1W
         Xw6v++W2bDtAS40BYAsCysTqYWHeP4n1hxb2VbFHU1xVpriIM4wbSkX1VCkG7UtMtWXY
         a1s12/wTQS2bk/KbEMmwmP1uyX/k9smBqexOgLWBFbxsNd5nBnzI103StT4m5dCUA2OE
         yntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMhLL/zmfb0UTfjF/sD2Sc2fOjk1wvP7x0u+3C18oCY=;
        b=uUmkB37aZShgMJaku1WuejoqrciPMlgxQlW+a9FYrcDBAcDK5NiCwCLyTxoKDxTQbk
         eUCYJkfghkHZySgrlSvxaIpq5Tl97O9uyB+1wQ9uH1oLvme7nbzX6C9J2f4FHaQsUVam
         weIXLDfK4czA/SCS5SNiX6tY8VNGJqqjGac8iqzklp+Bv3M6IlRIzHBjoijWDhFHGur4
         n2VpJYrTedqlk953DUjuz0XvVYfnA2oku1BfefZOGTDRhN+A5MVGygFzdocostJT5MxO
         MJAHneTouJSsWAgsCoOORLdNU5DJcNdR7210l0DPNgsUIc+QzHviZu2lZQC2kPirjcne
         A9Fw==
X-Gm-Message-State: AOAM532zRQ4h/D8huqgSxPjlv8utLJDyLbdor0UUbX/ZwcpNMdbWi3On
        ui0VtimHFWYijuD12Q6rMpQ=
X-Google-Smtp-Source: ABdhPJw7FSWaqhkVVFBs/1LXOF8G6W3WYP6O8sO027EixpBG1DwLbnYg03RM1An6rLOGTKelp1cyKQ==
X-Received: by 2002:a05:6402:4386:: with SMTP id o6mr23039910edc.307.1618066819873;
        Sat, 10 Apr 2021 08:00:19 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gb4sm2719494ejc.122.2021.04.10.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 08:00:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2 0/5] staging: rtl8723bs: Change
Date:   Sat, 10 Apr 2021 17:00:03 +0200
Message-Id: <20210410150008.5460-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove camelcase, correct misspelled words in comments, remove an unused
variable, change the type of a variable and its use, change comparisons
with 'true' in controlling expressions.

Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.

Fabio M. De Francesco (5):
  staging: rtl8723bs: Remove camelcase in several files
  staging: rtl8723bs: include: Fix misspelled words in comments
  staging: rtl8723bs: core: Remove an unused variable
  staging: rtl8723bs: Change the type and use of a variable
  staging: rtl8723bs: core: Change a controlling expression

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  2 +-
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  4 +--
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  2 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 18 +++++-----
 drivers/staging/rtl8723bs/hal/hal_intf.c      |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |  6 ++--
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  2 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c      | 14 ++++----
 .../rtl8723bs/include/Hal8192CPhyReg.h        |  8 ++---
 .../staging/rtl8723bs/include/basic_types.h   |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
 drivers/staging/rtl8723bs/include/hal_com.h   |  2 +-
 .../staging/rtl8723bs/include/hal_com_reg.h   | 34 +++++++++----------
 drivers/staging/rtl8723bs/include/hal_data.h  |  2 +-
 .../staging/rtl8723bs/include/hal_pwr_seq.h   |  2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |  6 ++--
 drivers/staging/rtl8723bs/include/rtw_mlme.h  | 18 +++++-----
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 +-
 drivers/staging/rtl8723bs/include/rtw_mp.h    |  2 +-
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  4 +--
 drivers/staging/rtl8723bs/include/rtw_recv.h  |  4 +--
 drivers/staging/rtl8723bs/include/rtw_xmit.h  |  2 +-
 drivers/staging/rtl8723bs/include/sta_info.h  |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h      |  2 +-
 24 files changed, 71 insertions(+), 73 deletions(-)

-- 
2.31.1

