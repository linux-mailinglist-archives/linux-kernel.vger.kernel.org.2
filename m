Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F25F449963
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbhKHQYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhKHQYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:24:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6C2C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 08:21:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o29so9676930wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 08:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=dpmRz1MyhI1QzWGayhX/75lRs6a4pCQQeiwKC+SRo58=;
        b=n9L1fQrVlNdptMAyoxU2c2Ho24mxZgyl57kLHEem8LWUwvQFZ4Z8SC0Z8XvBolUiL7
         H7FV7JQgr1HrySd1bT3iuStqjhhq2Imt2QoisacnOKrrKNx8vTsg52zV890gYvvtQyqx
         MnSyBDrSVXt2cEklJzYrqJu/e3mptNL1TOmmZSVya8jnTlzJ+qmUqhlkhjLEXAUOc7Oy
         Zks33LEI4yS9lVWA1ScJMmFRs8ArK0Z/D3TdPqU1G0oJUaTWHqaU/VzBcNB2/ebq5yO2
         q4NzpCUVYdEG/aAixKkTytXZZxheNEwNFiekDiERqNYDjGlenJVVHPsPgqrxwfk6Mozq
         mWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=dpmRz1MyhI1QzWGayhX/75lRs6a4pCQQeiwKC+SRo58=;
        b=WR4Ven0BKB0Ad0Zh2KRlrO4bucwu4i2XnVV5QqcvyWdg/d7rDtYN8ItQnXjC5g8gIb
         GQ14HvGmpIZfSBOPuOEKpsvUTiR2PizBctQiXHmwT/Nydpq3eUnTTiu2oefjoik889GM
         PZoDSzGvqJ0N8JC6rDkJmAXK/pJ6A23VO9A59qPtvFgc18/MxEs1EbTJUUdZ8CqnywOv
         y1UT+5Yglm1u0dRYtOm8QeWRbVMwHD6iYZuOwT1tW0xemyGzT9a1ry2n3+D3k8/qutHb
         88X7WawgQEAVWkUWSWbmmMg5+CTQs4pSta7Ud6YM6ZZwH83D4jJUNyKn1qheKQg2ffpg
         YtwA==
X-Gm-Message-State: AOAM530Ym0t+a4BNEgLEH2/qF9+1XZJ+9mcGRUD65k4wzxBk0gmjpbH4
        KS5TOmtM15LQzAr030xBi0r8mpfMzGAAtQ==
X-Google-Smtp-Source: ABdhPJwVBB/07MIRvsd5NxI07PYzkcAhx4225lp5Uxnzy3p6N1BYfBkuG3lV62/05/jptDXvvZ7E/A==
X-Received: by 2002:a1c:2047:: with SMTP id g68mr55600238wmg.181.1636388494690;
        Mon, 08 Nov 2021 08:21:34 -0800 (PST)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id n7sm17267791wro.68.2021.11.08.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 08:21:34 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:21:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.16
Message-ID: <YYlOh1l+4T4ir4aM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.16

for you to fetch changes up to 3976e974df1fd3a718627b0c9bdfee1953baa0d5:

  video: backlight: ili9320: Make ili9320_remove() return void (2021-10-20 15:13:59 +0100)

----------------------------------------------------------------
 - Fix-ups
   - Standardise *_exit() and *_remove() return values; ili9320, vgg2432a4

 - Bug Fixes
   - Do not override maximum brightness; backlight
   - Propagate errors from get_brightness(); backlight

----------------------------------------------------------------
Marek Vasut (1):
      video: backlight: Drop maximum brightness override for brightness zero

Thomas Weißschuh (1):
      backlight: Propagate errors from get_brightness()

Uwe Kleine-König (1):
      video: backlight: ili9320: Make ili9320_remove() return void

 drivers/video/backlight/backlight.c | 28 +++++++++++++++++-----------
 drivers/video/backlight/ili9320.c   |  3 +--
 drivers/video/backlight/ili9320.h   |  2 +-
 drivers/video/backlight/vgg2432a4.c |  4 +++-
 4 files changed, 22 insertions(+), 15 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
