Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208403751B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhEFJmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhEFJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:42:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 02:41:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d11so4868970wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=im3bW5S/RccCslH1ytS/60IAtgmqJ8ojz0Ph9k/9qWs=;
        b=xfTmqsaKXwpEB/rXveA+jNE+YDH8DxS5V8W4znJwi7rH20ezI1Xrtcq77tNM9VCLV8
         HrR9Bfv/QVMfw60TQz+HIJJaTUqJvXQjqXzcUyrmrLqiwqOWvVMTYCVka+RlavzOpDSh
         yD4N4CdTVSS0b+pRv53KUui/kPT6g2IqFzXv4pvOkQod92RjSJFxucoGlcCspr5Rguz1
         5hy5Ow9EnjvhZzHZIEFt71R0XjY2fLujLcUYBmqCoTCIFwEpCIM4Ha2oPlYqf5tMCazS
         HvkSZQEh7TNwa0vgDVMoMIlAr34PaHPupBnbldtf6jpgDGC55ojrm8k42PZYLQ2N/isB
         VxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=im3bW5S/RccCslH1ytS/60IAtgmqJ8ojz0Ph9k/9qWs=;
        b=XOmAOzPhSYo4QtwnAWXNnTOwXVmLRD5i8UXnXuJblSM/oI0H7Nor2AWMeehXRckaQC
         n/JofpnZoEPrTBxKxy29TMhhrSLMobACZt/igX6GyCKbj0UOYPGZDeac1jLQqzr6uWa2
         ORJrA2oqK4a82al+j1eYGxZO2xwZv1QEKQx9v6VUnC1/j14t5QLHLftcYvnm34e+eqAp
         fOvLFuFtdR1/02GkaIRQ3kVFfcMiHvDmx2kOlVvHptAC0y8HRrM+L/5IDPYla5PAR5z8
         qMusc03A2qoizWlrDAPZ+zAAfQxu1lWPJCfJ4AYg126H5cWdYTG11/sosAqd617+M1Lg
         tXcQ==
X-Gm-Message-State: AOAM530/L1ZPeF+gRjKQavmsdG18xJySI3Yj9VnKdc6ER+pEA3YBc3vo
        OCqZz3jiZmQCrAPmkv0Cf9s/Xg==
X-Google-Smtp-Source: ABdhPJyyacVKUsInWu2QNVxNsp4hBSCs/PIda849V+LVCcMhPZfTLMy8u/hxAPB4PZauPG21v3Qb1A==
X-Received: by 2002:a5d:47a9:: with SMTP id 9mr3987777wrb.298.1620294082122;
        Thu, 06 May 2021 02:41:22 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:2492:c5b6:6c3f:6de4])
        by smtp.gmail.com with ESMTPSA id y14sm3360421wrs.64.2021.05.06.02.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 02:41:21 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/3] MT6358 PMIC button support
Date:   Thu,  6 May 2021 11:41:12 +0200
Message-Id: <20210506094116.638527-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MT6358 PMIC has support for two buttons: PWR and HOME.

The interrupt logic is a little different than other PMICs from the
same family:
* for MT6323 and MT6397, we have one interrupt source per button
* for MT6358, we have two interrupts lines per button: the press and
* release interrupts are distinct sources.

This series depends on [1]

[1] https://lore.kernel.org/linux-arm-kernel/20210429143811.2030717-1-mkorpershoek@baylibre.com/

Mattijs Korpershoek (3):
  mfd: mt6397: add mt6358 register definitions for power key
  mfd: mt6397: keys: use named IRQs instead of index
  mfd: mt6397: add PMIC keys for MT6358

 drivers/mfd/mt6397-core.c            | 20 ++++++++++++++++----
 include/linux/mfd/mt6358/registers.h |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.27.0

