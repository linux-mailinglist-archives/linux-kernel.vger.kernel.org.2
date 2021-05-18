Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC17387805
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348877AbhERLuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348871AbhERLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:50:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A9AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:48:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gm21so5357944pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDpKt1nEvx/rV8xz3CLdiIIy1PWlTjaS6Ot+fK3HSMg=;
        b=PNWtRN0i5SS6qUPy6hmb4ayw2vJXw8xPP+uHJTpfYnMcQVWRavF+QZFdhC49fBT5yI
         SxPR6gfu+YjlkvROQ1nAQ4mzYPeBBjIChg+gMkVbGwef3pL3TTgzhbo+1R3Ykw+JKsXq
         MqhmdOyYxq0aMkb+TElsGM/j4cCJMvO+6Nd88Oe5FbapQ8ifLOSbLGFFd3rLH3rm2M0Z
         EJXlj5gf/cTyq8o1Xd1AbRchDAhumQUkIxzBSlwMsAB4xLCOiQSSlUsuytnYaAbOscAm
         9N+sXeY4SSs1A/ajvyi9kZBE/6XcB6zw1Tm/IuQA3CKhy1qumD1HC3BHcVDcZyZUldzB
         VHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDpKt1nEvx/rV8xz3CLdiIIy1PWlTjaS6Ot+fK3HSMg=;
        b=jQSJ4cmKQZKpoHZbhn/Ykaf49FSzaE7qEEq5GxcJcEcPH+FckfHVW4STvNaCBX94Xk
         5ENUhx69lgzvYsZnnWWiQqI5N8n8lIPXYbPioUHcT4nXpR/WxEdEzwzf23o0jJ/x38sO
         0wks5zDfbnBsA5Xdgn8T8k3LPzz+OUSw14QnK/sOAKULDkwWxmf376hmFVQXj76kzr+5
         o3jWuo27AadWnJrzuv4b1J8Ls34Qhb1o4OaAItANT+wL2zLfih64Tx507SFjUpnbInzo
         ZcjXra3BeONohY/CKattEMpQ6cRIyooNDgTJmr4fzL12YRVkLmUDlttwyKu7rCT/I0iO
         tv0w==
X-Gm-Message-State: AOAM533npNiAA53tBvCvPI7EJKcq5hqas7JpdZ58PD3vbd6xXGliMWLe
        u1AJnPR/yrMK1PuXR82fkyFkVw==
X-Google-Smtp-Source: ABdhPJz3P+LGt0NtDZPXAEP6cw9T5fCA3U+F5kBGefzOFsO5Gi70/dvOUEX9DmfXlG5oVj4sQHwzhw==
X-Received: by 2002:a17:90a:880c:: with SMTP id s12mr4052199pjn.66.1621338533475;
        Tue, 18 May 2021 04:48:53 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id ck21sm12864851pjb.24.2021.05.18.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 04:48:53 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd71815: Fix missing include files
Date:   Tue, 18 May 2021 19:48:43 +0800
Message-Id: <20210518114843.1495152-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include linux/of.h and linux/gpio/consumer.h to fix below errors:
error: implicit declaration of function ‘of_match_ptr’
error: implicit declaration of function ‘devm_gpiod_get_from_of_node’

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd71815-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
index a4e8d5e36b40..a079efa80092 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -13,6 +13,8 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-- 
2.25.1

