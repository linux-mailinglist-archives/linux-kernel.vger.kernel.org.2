Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3C3F3FC7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhHVOgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhHVOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:36:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C7C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k5so32103541lfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwGYchbluTL/Rr9Br9K/KBCWqoTo7qNfUvW33GFs/0c=;
        b=VGvPzdShKdBQiKQY9zD6gpq7KzRdfQ2f5/TaNPZXr3yjeNbwJ45X4P5EoIO5kciMX4
         vRQYy+h9uWhVXRqanof6Db6c1qkb9j/78RxMkJ60h+4YOSTYT46JLQjsBxWLKcM6VpDo
         JUWF/O/452ijPzbfxNx2auDMR7ZXXtwGWz/CExryRxzqQYaO/D0afYED1eDamiwlhYG8
         Hs7LMYjoz0qH/le3MSPGvFBWS37iJJ3cpshIwgNyeha/jBccamh0slOjyRXcZbTclt+l
         OB2HJNPuvE2T1gdwmhXaCaYGqNTlfwpGsKbq8gsI3OY7VF0LxWg4IMTE2+htsTfKkBQC
         rM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwGYchbluTL/Rr9Br9K/KBCWqoTo7qNfUvW33GFs/0c=;
        b=NE5x8IrD1TccR870OvFDJlY7zTmDvSTb/cBuLCoktOmLXke065H4uUeldJgGzLX7eB
         TDDcjodeYkmZULVh0kmISBXXWsjAf8rDsVfeh//aNa4+cjSfm2Gg3jghQKhol0deNHli
         HXOf4+rYOmrXfBKkakKzwmUMDZ1TYsOWyV+VfVc7ckhRaNq9YaDD0yLd9qDRiZpniuKE
         dWssPb8t9GUX6JBAHsxFyyNDfu7XUY1gLi3wDH2ijiBj/2UUbV53ZS4sFi13O0YFRQGW
         DdOCwaUHEsjfX+YA4POgwva1IFT542yiA7Lv2Lmi0AqWeixmnY5jgp9EDCsi1TvBUV7S
         uu6A==
X-Gm-Message-State: AOAM532oYd1FSdHKcd8I4Ewj2eY1kuL2oR1TvzzPgNKDrnsGXA7Zg28m
        wX+E8MVT0okO6+yrm2Cp0Dk=
X-Google-Smtp-Source: ABdhPJw3AP3vBo5MFlZTq5EldHh5XUCerXexdGTstNkseXTKontATGYDg212fkAxA89RmWxvCaI9sg==
X-Received: by 2002:a19:4958:: with SMTP id l24mr21230787lfj.48.1629642921651;
        Sun, 22 Aug 2021 07:35:21 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id o28sm1208965lfg.238.2021.08.22.07.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:35:21 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
Date:   Sun, 22 Aug 2021 17:35:05 +0300
Message-Id: <cover.1629642658.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg, Larry and Phillip!

I noticed, that new staging driver was added like 3 weeks ago and I decided
to look at the code, because drivers in staging directory are always buggy.

The first thing I noticed is *no one* was checking read operations result, but
it can fail and driver may start writing random stack values into registers. It
can cause driver misbehavior or device misbehavior.

To avoid this type of bugs, i've changed rtw_read* API. Now all rtw_read
funtions return an error, when something went wrong with usb transfer.

It helps callers to break/return earlier and don't write random values to
registers or to rely on random values.

Why is this pacth series RFC?
  1. I don't have this device and I cannot test these changes.
  2. I don't know how to handle errors in each particular case. For now, function
     just returns or returns an error. That's all. I hope, driver maintainers will
     help with these bits.
  3. I guess, I handled not all uninit value bugs here. I hope, I fixed
     at least half of them


v1 -> v2:
  1. Make rtw_read*() return an error instead of initializing pointer to error
  2. Split one huge patch to smaller ones for each rtw_read{8,16,32} function
     changes
  3. Add new macro for printing register values (It helps to not copy-paste error
     handling)
  4. Removed {read,write}_macreg (Suggested by Phillip)
  5. Rebased on top of staging-next
  6. Cleaned checkpatch errors and warnings

Only build-tested, since I don't have device with r8118eu chip

Pavel Skripkin (6):
  staging: r8188eu: remove {read,write}_macreg
  staging: r8188eu: add helper macro for printing registers
  staging: r8188eu: add error handling of rtw_read8
  staging: r8188eu: add error handling of rtw_read16
  staging: r8188eu: add error handling of rtw_read32
  staging: r8188eu: make ReadEFuse return an int

 drivers/staging/r8188eu/core/rtw_debug.c      |  79 +++-
 drivers/staging/r8188eu/core/rtw_efuse.c      | 125 +++--
 drivers/staging/r8188eu/core/rtw_io.c         |  27 +-
 drivers/staging/r8188eu/core/rtw_mp.c         |  70 ++-
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  13 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   5 +-
 drivers/staging/r8188eu/core/rtw_sreset.c     |   9 +-
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |   8 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  21 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
 drivers/staging/r8188eu/hal/hal_com.c         |  23 +-
 drivers/staging/r8188eu/hal/hal_intf.c        |   6 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |  12 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  33 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 285 +++++++++---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  27 +-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c |  22 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  18 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 439 +++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  57 ++-
 drivers/staging/r8188eu/include/hal_intf.h    |   6 +-
 .../staging/r8188eu/include/odm_interface.h   |   6 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |   2 +-
 drivers/staging/r8188eu/include/rtw_debug.h   |  13 +
 drivers/staging/r8188eu/include/rtw_efuse.h   |   4 +-
 drivers/staging/r8188eu/include/rtw_io.h      |  18 +-
 drivers/staging/r8188eu/include/rtw_mp.h      |   2 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 179 +++++--
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   3 +-
 30 files changed, 1138 insertions(+), 389 deletions(-)

-- 
2.32.0

