Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A164B41CC97
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbhI2T2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbhI2T2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:28:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90649C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:27:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l8so13051400edw.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y488e6CDLwLyyYkVkTYy429bQEA/xkkUxIrk51eKMFQ=;
        b=B8Hid2T3zOSBobHK4/2b3MBnfmp50HXZypbsZsvwJ0G5HeSXfHCwjyepk+hlQuxqaM
         G4dBioCuCVrFrLDDOC3tZcZBwpSdl8egDoOizvXmlmOQRd87m8lje6kxHee0i6O3Xiwb
         /A38Hu5Rhry3IRk4EmXu4l7eOpDOZnessX2nr4O7PUbdNdg1glDuARR7+E1MEgaTruqo
         YQEoai50XfrBNdeYxWDKxpX5kTn2SJk+5IOgaD4t6xF0eO6DxnmmlD8s30krfxCrZg2o
         /Jn4dqzpoEiqNbvaVvJaAtXgyT81rgAjdwikK7XySZ8cMa3XWHNSt69MmTzLsZUPS/c9
         ejdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y488e6CDLwLyyYkVkTYy429bQEA/xkkUxIrk51eKMFQ=;
        b=Ne0f61432j1+Ztx6TNkXiL3v2xL/PZWyBwfJ8SvOQj8nQL1bwttK3utIv+DJgQ9JTZ
         kvcZREFIDRWACa+FzgRysR/dWRSdSpKf8XK1HIwgYzLwQDddTi3b00eGMBxopWf3eAJS
         IKs8g+gcRd0GBlC+PzUd+X46b64SersmMbugMbRIV/ylMW6pawkYmjkkpNemtHsOAz8C
         f5ZGmlTd/UM2p4X2z4cmwgyCMpqMNlHuoyXRfsgwAv9ZpoxLeIR6oxkr/nrAqkxtGEQ2
         uR3rjv/ZPGCBUbSyljZbIlyQzq7HIIZlhLfL4QK66zi2VriA55Fxico3hOyaI44a8Uj9
         67Vg==
X-Gm-Message-State: AOAM530L1jSQBfrkPeXcn8CuHKRM2oJ5imONG5u9WAEaqpgoF3ENZnT6
        XZZQ4Qyo/9agalID5i2Xbi4=
X-Google-Smtp-Source: ABdhPJx+psJXY9PhCGxcGtwgnSI+CYXay0ul45XOPMp/fo+7y+MBowaKa4fzL4PxouYpqZr8v4Os0A==
X-Received: by 2002:a17:906:7ac4:: with SMTP id k4mr1924983ejo.430.1632943625192;
        Wed, 29 Sep 2021 12:27:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::bfc8])
        by smtp.gmail.com with ESMTPSA id f10sm449019edu.70.2021.09.29.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:27:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/7] staging: r8188eu: remove some pointers from struct hal_ops
Date:   Wed, 29 Sep 2021 21:26:50 +0200
Message-Id: <20210929192657.9569-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some more pointers from struct hal_ops.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (7):
  staging: r8188eu: remove SetHalDefVarHandler from struct hal_ops
  staging: r8188eu: remove GetHalDefVarHandler from struct hal_ops
  staging: r8188eu: remove init_xmit_priv from struct hal_ops
  staging: r8188eu: remove init_recv_priv from struct hal_ops
  staging: r8188eu: remove free_recv_priv from struct hal_ops
  staging: r8188eu: remove inirp_init from struct hal_ops
  staging: r8188eu: remove inirp_deinit from struct hal_ops

 drivers/staging/r8188eu/core/rtw_cmd.c       |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c      | 14 ++---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |  8 +--
 drivers/staging/r8188eu/core/rtw_recv.c      |  7 +--
 drivers/staging/r8188eu/core/rtw_xmit.c      |  2 +-
 drivers/staging/r8188eu/hal/hal_intf.c       | 56 --------------------
 drivers/staging/r8188eu/hal/usb_halinit.c    | 38 ++-----------
 drivers/staging/r8188eu/include/hal_intf.h   | 33 ++----------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 10 ++--
 drivers/staging/r8188eu/os_dep/usb_intf.c    |  4 +-
 10 files changed, 34 insertions(+), 140 deletions(-)

-- 
2.33.0

