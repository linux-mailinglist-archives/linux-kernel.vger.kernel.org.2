Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308033CC3E3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhGQO7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 10:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbhGQO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:59:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEEC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:56:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r11so15510985wro.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3rld2y4g3oKdC1plK0u/GeRkKkJxxY7jgCFCd5QmmiI=;
        b=dEnJvbFyIWpioDrk7Cjp9ER9a8Wty7gUM8B2lyId6bjBkwevFBYKNS8t/I3AyY8Qdx
         AFHUpyQE1xBRyRxhbCe61oDMmU960OvAjJeyEgSwk9T5gk/5i74BixC7+sqHOM4N8yDJ
         BueZNOAwv0TBd5ReCzJ89I+7YciplQKgi2+prRpUcFjk8DFrNNh29nEoq4RU/8OsmSlv
         yqrhIBuVYlghbocwqMboTAPrGZmilWfy10tpQ0osTY1JLZ3FpoBEZkFp4kEc798SD0Is
         5XH4z4IPiFh7TYt4Kzj9+BD7Zpdt6umQzL3CbQ7Q/oKdBCbfUekHAYCmF1z9SDWO4+Ww
         rDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3rld2y4g3oKdC1plK0u/GeRkKkJxxY7jgCFCd5QmmiI=;
        b=DLCehfW3v8KmKc+sFWHj8jyCWz3dxDaWl+2Ocv1tjBsmm8chG/PjP5c29VUCWgDnet
         8RIbVGNUxHIvuc8UlNOzqruhUJz5BKd0gjtuh6i3OB+zzuppWlhWHPNRsvlEGGfkgBLL
         uzqcSa2zdXn5Pb+awpOEzcOVQApg9imLa+ygk7RbN9aoDMsoHhMH+s1G6DUeOH3/mrX9
         K1SHe9CMLSerLtSkNGKKjIIhrGsEton0ITFIhhCZZtObuitfxZ1PNSEx4JrNsDYSybRr
         QI+U1eMPNnZl0+rl8Vni4+uGxSm5z9CXh4664nsI5Oq6XdFdR53eNauqF7C4dqjFFWve
         h26Q==
X-Gm-Message-State: AOAM531Nb5GEdIjzgdUoH36CIx/6+Jycb3qlaWc2GM0yjjhjOCTkuNYl
        VFcInt8JsNbQrludIb+FZ3GROgTwFt0=
X-Google-Smtp-Source: ABdhPJzoqAlgjnQd8+QeC7of1G75LpwzUvcEEOTR2mAdDmt84TAKR4/DvNxjz4qBOCh0NAv0qG6lUw==
X-Received: by 2002:a5d:434e:: with SMTP id u14mr3802047wrr.378.1626533813549;
        Sat, 17 Jul 2021 07:56:53 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id a207sm16851597wme.27.2021.07.17.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:56:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] staging: rtl8723bs: add get_channel implementation
Date:   Sat, 17 Jul 2021 16:56:41 +0200
Message-Id: <cover.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds cfg80211 get_channel implementation.
One of the benefits is having displayed channel info
in iw dev output.

Done some code cleaning as well.

Tested-on: Lenovo Ideapad MiiX-300-10IBY

Fabio Aiuto (10):
  staging: rtl8723bs: add get_channel cfg80211 implementation
  staging: rtl8723bs: convert IsSupportedHT to snake_case
  staging: rtl8723bs: fix camel case issue
  staging: rtl8723bs: fix camel case name in macro IsLegacyOnly()
  staging: rtl8723bs: fix camel case in argument of macro is_legacy_only
  staging: rtl8723bs: fix camel case name in macro IsSupported24G
  staging: rtl8723bs: fix post-commit camel case issues
  staging: rtl8723bs: remove unused macros in include/ieee80211.h
  staging: rtl8723bs: fix camel case name in macro IsSupportedTxCCK
  staging: rtl8723bs: fix camel case argument name in macro
    is_supported_tx_cck

 drivers/staging/rtl8723bs/core/rtw_ap.c       |  2 +-
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  2 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  4 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |  2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       |  4 +-
 drivers/staging/rtl8723bs/include/ieee80211.h | 16 ++----
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 53 ++++++++++++++++++-
 8 files changed, 64 insertions(+), 21 deletions(-)

-- 
2.20.1

