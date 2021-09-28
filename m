Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D741ACCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbhI1KVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbhI1KV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:21:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B138C06176A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:19:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 17so20670143pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACQMAQ2ulH/5Q17RB32jjiGPW2/pxtJ2WgZ5l3NEtj0=;
        b=iHBMZUmK4E2NGOJAley17BgD2/LKGG1tTs5Lz+RIW9dLEcNAt+IgMpfsO8ioVZSdX3
         kLQEXzFY5v6Oy8dhDxxgVatIXc+S2+9PJV9ZfkyczdZcjDI/V3a/fZfsoMk6wX3fUcYB
         wo9C/Z3NOfaTY0T9CHNadMp3pKDxPRxQch9sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACQMAQ2ulH/5Q17RB32jjiGPW2/pxtJ2WgZ5l3NEtj0=;
        b=Fx+2QGnHvDqkFoFTwQXS9alDQp29Swos62TlqrNlvn/iE2PQ+WUIAd12xBjkLJS/ul
         Ya/kUUbDsor4hrwK/Zu7GRUkHh0VmRDkbBgsEhAXn6p2D17RuII8JG0QPdDm69M+XWAE
         GOclnnbyqei3L4l9MU8lhz2GLzI/pV2rQfiHRK7E27CZvHkwRJSZO01+jzzDvB5ZRqtl
         J/b7GV/g8VFfWHePAwwOw3+50Sk+peSQf7AQs7HM46v2JNoaCARm5KNle6dmtYB0pShM
         0FrP/2TM7Ae9v1sA7003wfBwH5ykB37RxSUDdYqRH/IPn31MWYyjYHfmRtrcCc5G5HQt
         neHw==
X-Gm-Message-State: AOAM532+wWZrfYqfclBn6ME/j/x5rOy66op4/uhNcD99ni30lDwboDH9
        WaIFHzjEWN0gTt2iRiZGCLYPm0T/jrw8wg==
X-Google-Smtp-Source: ABdhPJzmNL6vayKpA3EjzqxYCckmp1kx1YWIxyFG6UfBbHEEu0x0y0XdKU2nLhKarjqO/3pSYjwLlw==
X-Received: by 2002:a62:2f81:0:b0:44b:b390:956b with SMTP id v123-20020a622f81000000b0044bb390956bmr1194571pfv.30.1632824382687;
        Tue, 28 Sep 2021 03:19:42 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:f6d8:1ad1:cc75:70fb])
        by smtp.gmail.com with ESMTPSA id z9sm19734576pfr.124.2021.09.28.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:19:42 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 0/3] platform/x86: intel_scu_ipc: timeout fixes and cleanup
Date:   Tue, 28 Sep 2021 03:19:28 -0700
Message-Id: <20210928101932.2543937-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a short series to make some fixes and timeout value
modifications to the SCU IPC driver timeout handling.

Prashant Malani (3):
  platform/x86: intel_scu_ipc: Fix busy loop expiry time
  platform/x86: intel_scu_ipc: Increase virtual timeout to 10s
  platform/x86: intel_scu_ipc: Update timeout value in comment

 drivers/platform/x86/intel_scu_ipc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

