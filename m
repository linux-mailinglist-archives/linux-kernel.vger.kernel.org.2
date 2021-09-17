Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004F14101B6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbhIQXc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhIQXcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849FEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y132so8512184wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=45s7FqIYZcidmMQaEScxKZj835mEUAMBISCO0i+Nfz0=;
        b=M0u746zxXY4GfqmtgyyyYz0XoB6tdlg0oBNuSvr1HoCYhygz7aawVjBdAwvKCBfd4d
         977LD0a8rFROsbGGxEtCy0/AybAUN220Sy5k3D9T7F7+rpiJ8kpkD6owVEgUVPxuDPQn
         Prqg/13UctjmAigImTTS8P+VEYNTMXQd1vFw6RvSXOjrTccD+PkRuKRYIb5CWBeayMM8
         E3APVFFctCUsg7/UGs827Ai4B+psZGevc56m4MkIUrNnov/1Hw6WatTry9hPq9dDt+qQ
         tcKu6/GasonUUmNuwTu4NoTuwmjGGT2A4ZM7Gkr5vb5xR0UBScgjfPhei+K5yRH9LKtj
         hKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=45s7FqIYZcidmMQaEScxKZj835mEUAMBISCO0i+Nfz0=;
        b=cdMZtMn82bgWsZWzeALo5mYOp8oROFt6hnFKxieFCYNAi/AsVTtoKMkxZM50l7ScUE
         ebuY9tWVNC0No3Epu+LKc5UsCT/cv7kJJ20RIyfvzAEAnh2V9/6SI55KyiLDTzzkEUMl
         fZqeV4wFUdKR7oKHuMNbQGKFa/6NKtocVEZDY5LhBcC8n2qXNHZIICyumFOfseRF2qfj
         LGQPAK2TcXhr5fGvrtNaTyr3WfvGcQl7relgUE0hT9vrs1VdRhzL3zlIlnXC6vDTMj7T
         53fRVSQwHl1ZRa4NinCIQ6O939GEW/qB6rL2de8raUHwNYSoCzFxQAO+AO6nkIT7ygyT
         M+BQ==
X-Gm-Message-State: AOAM530leuiPqQnQdsOSDOtUwl3wZZfzNqJ+v8w63q+VFzi8LTbw03ot
        86PSqVukcmow+4uRw9mXfz7foSbCJ/K7OQ==
X-Google-Smtp-Source: ABdhPJzT5TjeLvO9Y7I1i1OWpbPD1YyAszlWSNSUpLoVxS0Z5QUnUvtoBExMhkpGj+exiYP6B6ythg==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr17170283wmc.129.1631921461198;
        Fri, 17 Sep 2021 16:31:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/12] staging: r8188eu: remove odm_RegDefine11AC.h
Date:   Sat, 18 Sep 2021 01:30:36 +0200
Message-Id: <20210917233048.31677-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set removes macros and code that is valid only for 11ac chips and
therefore not needed/used in this driver. In the last patch we can
finally remove the odm_RegDefine11AC.h header.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (12):
  staging: r8188eu: remove comments from odm_interface.h
  staging: r8188eu: remove unused macros from odm_interface.h
  staging: r8188eu: remove _ic_type from macro _cat in odm_interface.h
  staging: r8188eu: remove dead code from ODM_Write_DIG()
  staging: r8188eu: remove unnecessary if statement
  staging: r8188eu: remove more dead code from ODM_Write_DIG()
  staging: r8188eu: remove macro ODM_REG
  staging: r8188eu: remove macro ODM_BIT
  staging: r8188eu: remove unnecessary if statements
  staging: r8188eu: remove dead code from odm.c
  staging: r8188eu: remove ODM_IC_11N_SERIES, ODM_IC_11AC_SERIES macros.
  staging: r8188eu: remove header file odm_RegDefine11AC.h

 drivers/staging/r8188eu/hal/odm.c             | 224 +++++++-----------
 drivers/staging/r8188eu/include/odm.h         |   5 -
 .../r8188eu/include/odm_RegDefine11AC.h       |  29 ---
 .../staging/r8188eu/include/odm_interface.h   |  41 ----
 drivers/staging/r8188eu/include/odm_precomp.h |   1 -
 5 files changed, 82 insertions(+), 218 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h

-- 
2.33.0

