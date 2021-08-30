Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0213FB310
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhH3JW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhH3JWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:22:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE73C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:22:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so8923901wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LuqtcpP3rIjEbiNh0/a5W1SAUG+Ekfy76reIa1RHBEs=;
        b=FBdSJbcIU22yHl9jEkdT9tdDwyM/ddbwcyu/1ryWWeq5VZPT0zMi6z+prg4eD8jejv
         aHUloUPy+VVV6R1nNICO98ZjQljfH1cfBS6JUFo/deRZKpBHbIup/HLpPKGE9SY4ChoX
         b7+sBMskS4v+ognRYOvJlvk9hQtMFAdaVCivaignNFVGRvjLMEhYUHzdZGTeDfmN0LPI
         X5ZPw9mvbupp8U1Y7Qa/oayw7QmWP2TaMrZ8qCp5upXtTVQ5cM2a5gd+LOH4pzGvfsQj
         cm+5nPkD9dIRyqiEUctarquvPqFSiYuBpNXbd2Q4ecHrnasWdj36E83/yJ22SbdTnKEM
         P3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LuqtcpP3rIjEbiNh0/a5W1SAUG+Ekfy76reIa1RHBEs=;
        b=AIX0FxAz5Pja6bQJfATZf4aY6FXJS44LKnhJG9raPGLZCZ9VVaUkVoXEfDsqRa3Ksy
         Bdu/IFKqHgTkEo/1JvGL7cpjYhKtidsr3TX2KPstZ40AT/Kt8psvGb/q0kXDLCBk2ypb
         MiL+/uOmXmQ9rNHJ4UwjlKktcd8h/xPtAARgC+sMGWGH2L2tdCH54hYqN65d/NDiyDSI
         UFUuH+fg6f09LjM3Ktqqf2LsoFsUFh0clGxAS+8DKwDkERWd6Q+LWKTyYSylx+bG0KHd
         vOiGHJRs3mEdK3+9s33FMhc0c61QJI0eZLH9QKN0CHAu6/5LYRxAyrl43ouP73nlF8RH
         4QMg==
X-Gm-Message-State: AOAM532i0OD4ii8gAWV5xXhWqcQkGUTeLs1QHWjYK+BikXLiQHqAf6pI
        AtID9kcnq0AU1Cdl6ckhcdk=
X-Google-Smtp-Source: ABdhPJz1FCF7O+QYJq4HCDBbwo6YpsC55+HdwAa/JhSVk36SzPhTVgILbgJjiEGpxFeRvswxJe5/rA==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr15753616wmj.122.1630315321065;
        Mon, 30 Aug 2021 02:22:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id j1sm18378248wrd.50.2021.08.30.02.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 02:22:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: remove code for other chips
Date:   Mon, 30 Aug 2021 11:21:49 +0200
Message-Id: <20210830092153.9283-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some code that is valid only for other chips
than RTL8188EU and is not used in the driver.

Michael Straube (4):
  staging: r8188eu: remove Hal_MPT_CCKTxPowerAdjustbyIndex()
  staging: r8188eu: remove set but unused variable
  staging: r8188eu: remove ICType from struct HAL_VERSION
  staging: r8188eu: remove unused function SetBcnCtrlReg()

 drivers/staging/r8188eu/hal/hal_com.c         |  13 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  19 ---
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     | 139 ++----------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   2 +-
 drivers/staging/r8188eu/include/HalVerDef.h   |  61 --------
 .../staging/r8188eu/include/rtl8188e_hal.h    |   3 -
 drivers/staging/r8188eu/include/rtw_mp.h      |   1 -
 7 files changed, 12 insertions(+), 226 deletions(-)

-- 
2.33.0

