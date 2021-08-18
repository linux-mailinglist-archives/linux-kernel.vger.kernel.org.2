Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284F43F0EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhHRXnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhHRXnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:43:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A63C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2920013wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeNW5DL4/3VbSlgVXKYBeMDXXKxQSxKIYvKsB82ru7I=;
        b=N8zNZEkhwZR8dq8CbaOVy2PGnejQZWfiehnBvT+o2+VaOeITtXV3hTTwW7fjm36CAP
         VI/iayXUI2gHwTca4QNAFw+gdwZNZVHrgS3bh1eFz2M3SMFyBrH1Ju1BoQkrsmw1iW42
         yd/+lwMeF9gZlO3UacU+1iaWL6gBT4lhoKZT7kLloAbuTQUNtLaOG2jXHbfyomtk4gbL
         sRBqRXsE1NLv0A1tnXcZytdVmzraGBiv+fzBvhD2yGICt1cuTzDII4iPgFYKPaO1khsN
         JogHSACTOZlR8pv2H6ndrpBGWfAJoviBCbqPgDTz19UGzi0l7SBjd9w+7yC60rYMeFi3
         AwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeNW5DL4/3VbSlgVXKYBeMDXXKxQSxKIYvKsB82ru7I=;
        b=rcHYriRsUTPEElIPeFrAQ2ZkNn1wDTfFkNrtteljFTRxdYClxyD387BObDhq4v18Ou
         n6b6as1jCkB2u1yj0JY2xbDeG4Wmr0UUtti7PaTL6U003P+wUibsTHGlJQo1BP8jF7Ql
         SpwLg1qzAff37eiOs1/b+cWmV41rAzTO/sVSGu4cqg6H1TLhVylQsyHMRfQSWa+9Kzp8
         CTOkAkLbnxQ/rJG4OhQF9bq+1pFT+10VITT9rq75M2eqhuGBA7tnk5iNO40o34Hji1BJ
         8tS5HoI0P1cbg0PoPkvc23vuxxRsYLv2/Vi8ycvdcrrRJXpe6lUn6nzY/FsUjIksa8+q
         ks8Q==
X-Gm-Message-State: AOAM53003Q3jj8GHU5bXAglcNftlOhktLYe3pTAD4zlXYzKi0KqJDscB
        ybOrufx0djK487AtgVA/1AOrlvfeByqLZvc7
X-Google-Smtp-Source: ABdhPJznmV2FO3EfZOhEB6HIY/INZZuAsl/nxk8pr2DChtIFysgnaqSPxtJaQNlb/hwkzzeVu0UkkA==
X-Received: by 2002:a1c:7506:: with SMTP id o6mr11217330wmc.112.1629330174665;
        Wed, 18 Aug 2021 16:42:54 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1194926wrt.77.2021.08.18.16.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:42:54 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 0/6] staging: r8188eu: HAL related cleanups
Date:   Thu, 19 Aug 2021 00:42:47 +0100
Message-Id: <20210818234253.208271-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides cleanups related to the driver's HAL layer, by
removing certain code which is no longer necessary.

Phillip Potter (6):
  staging: r8188eu: remove _dbg_dump_tx_info function
  staging: r8188eu: remove unused function dump_txrpt_ccx_88e
  staging: r8188eu: remove txrpt_ccx_sw_88e and txrpt_ccx_qtime_88e
    macros
  staging: r8188eu: remove empty function rtl8188eu_free_xmit_priv
  staging: r8188eu: remove function rtw_hal_free_xmit_priv
  staging: r8188eu: remove free_xmit_priv field from struct hal_ops

 drivers/staging/r8188eu/core/rtw_xmit.c       |  2 -
 drivers/staging/r8188eu/hal/hal_intf.c        |  6 ---
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 53 -------------------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  5 --
 drivers/staging/r8188eu/hal/usb_halinit.c     |  1 -
 drivers/staging/r8188eu/include/hal_intf.h    |  2 -
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  9 ----
 7 files changed, 78 deletions(-)

-- 
2.31.1

