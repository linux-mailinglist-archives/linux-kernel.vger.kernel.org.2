Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4961D40784E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhIKNaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbhIKN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2962EC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y132so3131014wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKII3Em85GyFUd+5hxL85RzFtfvRmJ11W1HrzpygBZ4=;
        b=URQg6z1jECqKTCbCvTfRwLLNc6qlLOmgo7dUIiZ7oyshy0EiZ6z33cSJg31PjAJSrL
         0U3izzVHjPWtpkbIjeZsnaN0VEudmvwt0B/10bX2wjV/QRpmzX9gYnJvv/hhbKqBewRK
         XxbFQy0SRn6gRsX0Af1Kl6M/LucLEoPSEDKdNtdWiwG9B/1geOzTSjd5X7eERRdOrNKj
         mAzjdw4MudxW6HsspsZ/swPNjYmvFioZwtjWyBE6B0bn6Dl5PA8DS+5yJh/BNWjwoUMF
         RwKclO5rlJp0V+S4j3guDgyDlzZyTcm4+bTnQRVJ1RsWhtfkINF+g+wf4PyvFgneuXlU
         NwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKII3Em85GyFUd+5hxL85RzFtfvRmJ11W1HrzpygBZ4=;
        b=GsehNG7l9GD/HQt+heq18QgJtx4dwS8cFL3fcs7N63Wij1IQ8AKsK1GxqrmSM1NC5W
         D2lfZk4RHVlyMtOT1GEMWHROnGLPk6xnVA06m4Nc5iUoF1wIAZwjWIQ6ghh4Fo6RwRcg
         Wr8XcoV2m6EerJifVUba1MdEPkTc9xlA1jhoFjYM+HzjtR6RkMvnFB26YnTistnP92aT
         h1JbGXTUCRe9+x/aLxiELGBA48RVqLcmo+vuynEuRbYwucqUNv6ACr9k6n3TSj6A80Xw
         abkCaXHEXHBwhSYzsWDYxU/l/Hxs1/ojmf2nZasvuyJ8yiLuV5cx8uiJqydP3qLZYVxL
         yJuQ==
X-Gm-Message-State: AOAM533DizMArgoZyrY24moPe5pfxKlUjFLR3hjtXUBpvmZuAyEcjaqh
        loMX0z30OZmz4ZNQD8VxTVA=
X-Google-Smtp-Source: ABdhPJzxob19wjYW06XrZiII6gI5UMEr4reug45vt16neQ4dK/Z5v8dt2Gs6WKn56C73IWsZhjw47g==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr2720004wmb.190.1631366822441;
        Sat, 11 Sep 2021 06:27:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/18] staging: r8188eu: remove unused functions from odm_interface.c
Date:   Sat, 11 Sep 2021 15:26:17 +0200
Message-Id: <20210911132635.30369-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused and/or empty functions from the file
hal/odm_interface.c.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (18):
  staging: r8188eu: remove empty ODM_ReleaseTimer()
  staging: r8188eu: remove unused ODM_AcquireSpinLock()
  staging: r8188eu: remove unused ODM_ReleaseSpinLock()
  staging: r8188eu: remove unused ODM_FillH2CCmd()
  staging: r8188eu: remove unused ODM_sleep_us()
  staging: r8188eu: remove unused ODM_InitializeWorkItem()
  staging: r8188eu: remove unused ODM_StartWorkItem()
  staging: r8188eu: remove unused ODM_StopWorkItem()
  staging: r8188eu: remove unused ODM_FreeWorkItem()
  staging: r8188eu: remove unused ODM_ScheduleWorkItem()
  staging: r8188eu: remove unused ODM_IsWorkItemScheduled()
  staging: r8188eu: remove unused ODM_SetTimer()
  staging: r8188eu: remove unused ODM_Read2Byte()
  staging: r8188eu: remove unused ODM_FreeMemory()
  staging: r8188eu: remove unused ODM_AllocateMemory()
  staging: r8188eu: remove unused prototype ODM_InitializeTimer()
  staging: r8188eu: remove unused ODM_CancelAllTimers()
  staging: r8188eu: remove unused ODM_InitAllTimers()

 drivers/staging/r8188eu/hal/odm.c             | 17 ----
 drivers/staging/r8188eu/hal/odm_interface.c   | 80 -------------------
 drivers/staging/r8188eu/include/odm.h         |  6 --
 .../staging/r8188eu/include/odm_interface.h   | 45 -----------
 4 files changed, 148 deletions(-)

-- 
2.33.0

