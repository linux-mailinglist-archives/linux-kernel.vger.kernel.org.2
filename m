Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8E542F850
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbhJOQhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhJOQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:37:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC51AC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so3491554wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1PMu4QAwnFdhyl5MyRkydRYCLGimc4yHFMSZWmKWD4=;
        b=YbgH7ZeFLSY+Sr9DQUnX3m0U3snryOHajTm4PeqNFYU82r39vzi42aJfeWcdXy1GFs
         Se/W14SsCvMZ9LIQC6DnOrJhw3hG4e3BuMSzaw8UGI0U9kLrgTNQQ/EuagJnH/8palD3
         X1ju7UtJtFq2mA8aiu0a/WSbDYqUAWN4Zx98F66dR0EMlAu2yMqv8HVSARFfiRBpvFsk
         fUWrNlYrfKscj1TNHRO6ZjJIRgytdzZVfk9C6rHNGjo9Kz/Bob9+d3wvyyaJuSEIJ+MT
         Mk7F5lQol/SIJCkv13ER3Cg1wcx8pUY7j04uPz5/9kEAlRIxHwcx8V9uOn+lFmGcR8I5
         CCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1PMu4QAwnFdhyl5MyRkydRYCLGimc4yHFMSZWmKWD4=;
        b=p065dT2bsDLLFonQQJXNBRVdk84hkWJFO+cF7/Yd5jKIzwdjZUam3nzXsc7r8d5XYD
         E0R6KV3+n5nhu5yYteysadiBTL+SV7cpQDCoz+lQzTU2KI4dd4T3qIFeh7TrJoj3R9ZU
         gsrEDehmH95kcOvdOVn4jIVto7U9nGuSfOKw51yGIRui2xholsOSnQh0VrePq58W2niK
         uDkKRSYH96gyathKHk+6NfDAEKRzh7IO+GS5VE+2MMB7aCwfhjqMowdYflPNAKGongZ6
         azYil/gk1uhKluNXtmsDOnbQYV6hGjtgJOV5ODIeFDEdqYN8stmFwqTzZh7IEg71pUBX
         +lSw==
X-Gm-Message-State: AOAM532W9bBPFiSjFgnObwFOIbePm6Hb4gZL1y6SCO4yn+zHoi72NCYe
        c5CDE5n8r1sSnpA/S8+IQhc=
X-Google-Smtp-Source: ABdhPJzp0aLJi4nzd/LntAwUGY3NXnUXGK84X4wHqwczdgXCgnDyzlLwnF/AD3UnG391LDq360PHAg==
X-Received: by 2002:a05:600c:a43:: with SMTP id c3mr26535192wmq.193.1634315715460;
        Fri, 15 Oct 2021 09:35:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ad78])
        by smtp.gmail.com with ESMTPSA id c17sm5489593wrq.4.2021.10.15.09.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:35:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/7] staging: r8188eu: odm cleanups
Date:   Fri, 15 Oct 2021 18:35:00 +0200
Message-Id: <20211015163507.9091-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes:
- empty / unused functions from odm.c
- two never set / unused fields from odm_dm_struct
- the function ODM_CmnInfoPtrArrayHook()

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (7):
  staging: r8188eu: remove empty functions from odm.c
  staging: r8188eu: remove ODM_SingleDualAntennaDefaultSetting()
  staging: r8188eu: remove GetPSDData()
  staging: r8188eu: remove ODM_AntselStatistics_88C()
  staging: r8188eu: pBandType is never set
  staging: r8188eu: pMacPhyMode is not used
  staging: r8188eu: remove ODM_CmnInfoPtrArrayHook()

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |   2 +-
 drivers/staging/r8188eu/hal/odm.c             | 144 ------------------
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |   7 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |   5 -
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |   5 +-
 drivers/staging/r8188eu/include/odm.h         |  38 -----
 .../staging/r8188eu/include/odm_interface.h   |   2 -
 drivers/staging/r8188eu/include/odm_precomp.h |   2 -
 9 files changed, 6 insertions(+), 201 deletions(-)

-- 
2.33.0

