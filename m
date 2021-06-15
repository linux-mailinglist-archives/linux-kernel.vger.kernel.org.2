Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6D3A7D76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFOLrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhFOLrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC68C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l1so21992599ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1eH0Ej+5T7porb0G6RAMCsURpi7I/GRLLvy18cQifk=;
        b=DfGsCnLzOTYcQNI244P2gyMDnho2hr4KC/+Zzx9z+Ow7ozz2e93vsnW4OJuyXIZUp2
         DZKO3BpCHgOjL3G4cmTTmbShPS2zTKyR8LHxLVJa5Z962GEdD5c8Sno4StglcTX8IYeO
         Zm+N+qa5TuJC+dKMwOeshVaKQe8bY/02E8ZqCSeuy/wZTG8/7HMZOrgMc825hgLZva8q
         2SVlvJ95+UqGBUMKy1U4PkbSkFR5i6+y/4IqwA8J+vKlQ3wX2IyjEmSnyQiBnQ9GbWrY
         VrV54AXvikpWbyO88Ui1TeAfe0meUSczu2KUpjRbUQZegiWisTnWkQ+Z3Tp5/jdGjPgu
         Z9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1eH0Ej+5T7porb0G6RAMCsURpi7I/GRLLvy18cQifk=;
        b=phve+tX3BMiSYQqdZ86OYLnHe4p9ceiIHpeKslZZ1uWON0MtG7733AwhZ20llFG25P
         jJtvYkeCTldbTNi2jSgFPe7FTznEny7TZsKYX3RRwnYUxItzp8S7GhPi8B4KEX5jm9S4
         LDK+Khw9E1c1HEg6kieCo9YHPPTtyk7ZF27jFeq+RXynophyeQMi9//Amh0sdkZQonRn
         7WzrgtWM76qkprZFgkEAxLsg1T61AaTG2HHKLsNEDg89601YLNx5Kf1VKkzucyTuQTLt
         7FT6R6ouGyoZIeSkZV7wotZo5MHBlkyTazF4TgsyYJTFj1lz5wzMluupvHNvondHO8BZ
         R+dA==
X-Gm-Message-State: AOAM531KMYlFgMq46Bu9ogrRsMrs1MNKayj+3s5lP8d70x8qKT/l2biS
        NiSGgxrjMw11LPayo1rCTATLfHC9TzhEvg==
X-Google-Smtp-Source: ABdhPJy0F0ZTJ1mVbFIcLibf8PfNhpU/5igmzTMwuUxzQiVU8nvl91UoOwfA1CgazjCF9V9Kr63+qQ==
X-Received: by 2002:a17:906:f298:: with SMTP id gu24mr20021153ejb.452.1623757540008;
        Tue, 15 Jun 2021 04:45:40 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id u21sm7145699eja.59.2021.06.15.04.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: rtl8723bs: remove unneeded files from tree
Date:   Tue, 15 Jun 2021 13:45:30 +0200
Message-Id: <cover.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes some unneeded files.

autoconf.h seems to be the output of some automatic
header file generation foreign to the linux kernel
configuration and build system.

To toggle some part of code one is asked to
force an edit by hand on this file.

Other unneeded definitions were deleted recently,
now we complete the job.

Removed core/rtw_eeprom.c and include/drv_conf.h as well,
for they are excluded from the build process.

Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>

Fabio Aiuto (8):
  staging: rtl8723bs: remove unused debug macro
  staging: rtl8723bs: remove unneeded comments
  staging: rtl8723bs: remove unused WAKEUP_GPIO_IDX macro definition
  staging: rtl8723bs: remove unneeded DISABLE_BB_RF macro
  staging: rtl8723bs: remove HAL_{BB,MAC,RF,FW}_ENABLE macros
  staging: rtl8723bs: move LPS_RPWM_WAIT_MS macro
  staging: rtl8723bs: remove include/autoconf.h header file from tree
  staging: rtl8723bs: remove two unused files from tree

 drivers/staging/rtl8723bs/core/rtw_eeprom.c   | 208 ------------------
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |   7 -
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  16 --
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  15 --
 drivers/staging/rtl8723bs/include/autoconf.h  |  50 -----
 drivers/staging/rtl8723bs/include/drv_conf.h  |  19 --
 drivers/staging/rtl8723bs/include/drv_types.h |   1 -
 .../staging/rtl8723bs/include/hal_btcoex.h    |   2 +
 drivers/staging/rtl8723bs/include/hal_phy.h   |  14 --
 .../staging/rtl8723bs/include/rtl8723b_spec.h |   2 -
 10 files changed, 2 insertions(+), 332 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_eeprom.c
 delete mode 100644 drivers/staging/rtl8723bs/include/autoconf.h
 delete mode 100644 drivers/staging/rtl8723bs/include/drv_conf.h

-- 
2.20.1

