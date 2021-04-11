Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3428E35B26D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhDKI3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 04:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhDKI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 04:29:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 01:29:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u21so15176963ejo.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbd5H0UwYLbMR62cEsPc4FBrxl4fQyEDt4D7w7SlNtw=;
        b=Xv+wlrWwbWGUutpihPJnRxfmD1h93HBgETHnKDs03pQmldV52gKO05pW6sz3C7biTv
         K1mTrXxIAkBzz7G9vs1kg9aJm9sCLn+kH76GDBbkLpftIzSV56bNGbUoLZ5NdSoC3fZJ
         UNnaP4ApddRQ4NgTYZR+p30Y5uC9Zi4QqzzmL1SJsvBZc9MnAB+s3bThHq1qIzHODgVf
         7xvlmYG7upHGLnvRilaJDLRNub+8JkZYMLSobfhGwhtvQPEEryxAQ4OHikY30Wmztunw
         TXtXp8yskYxwJQcOgiG+uwvMqdOqmdrIVlug47ZcVg34gUchpxzd2l7of34ao4NC6EwI
         bUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbd5H0UwYLbMR62cEsPc4FBrxl4fQyEDt4D7w7SlNtw=;
        b=Vea72L2ky+dsmVoG8336emZBjP++WNDcrC1nK/ZXJJkA4sWHHf0gwUX3102hT5x2AS
         S5lB2MuPUd71XaHJQVcNFCpuAg+ZvY7MkvqyRHWznwfobywvOPtaUUAzHUhB92ONVK67
         QFLJHXs+NV+z1UnSGpqkPXz/T8kuheJbOimiz9THfUm/M+ABh6+2LdSaJ5zEVX3H8wMS
         VMxL5V02F8aOQbTcltffYQ9TqYH04uWnFWzbg4vThyEwd6Zl5vTAMwFuwFKLiKZgOepp
         K1ywkJ+WrRBw8U7Kut7oOmI/TeHV5KSKNVd0Hydkik6gPzLkMP/nor5RwgTZWc9KQsCq
         n4Fg==
X-Gm-Message-State: AOAM533xmefT//Je9cBo8qUTjFo6X2LPeongBLOn/r4xdtuwifJl1yQ4
        Gvm8R4J1PZ5sOB/bkn0/QZU=
X-Google-Smtp-Source: ABdhPJyNZirbhS9ukY9aKtE53LirNOwGRzkMtW5FM9oJo2ZMZMXY123Z07csy+YcgkKhcas4pr7UZQ==
X-Received: by 2002:a17:906:9b2:: with SMTP id q18mr22788236eje.147.1618129754397;
        Sun, 11 Apr 2021 01:29:14 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id hp12sm3682541ejc.46.2021.04.11.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 01:29:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v3 0/4] staging: rtl8723bs: Change several files of the driver
Date:   Sun, 11 Apr 2021 10:29:04 +0200
Message-Id: <20210411082908.31876-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove camelcase, correct misspelled words in comments, change 
the type of a variable and its use, change comparisons with 'true'
in controlling expressions.

Changes from v2: Rewrite subject in patch 0/4; remove a patch from the
series because it had alreay been applied (rtl8723bs: core: Remove an unused variable).
Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.

Fabio M. De Francesco (4):
  staging: rtl8723bs: Remove camelcase in several files
  staging: rtl8723bs: include: Fix misspelled words in comments
  staging: rtl8723bs: Change the type and use of a variable
  staging: rtl8723bs: core: Change a controlling expression

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  2 +-
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
 23 files changed, 70 insertions(+), 70 deletions(-)

-- 
2.31.1

