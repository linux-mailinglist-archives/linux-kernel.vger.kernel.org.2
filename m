Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57938292C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhEQKAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34602 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbhEQKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:00:02 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1M-0002Tu-Mx
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:44 +0000
Received: by mail-ed1-f69.google.com with SMTP id c21-20020a0564021015b029038c3f08ce5aso3627412edu.18
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2qu6Q8DMEDwsWMFc9vBq6PJobrXpavUOxlKC4xNczg=;
        b=ZxYtSTjIfx9ix8r1RjxyNf9FDQAxRdriI1psd4NQczMmQ48PNj/JuaZQYkIvJrd+OY
         AyjnFaEXo2i/6H/qm8IxuXuUgT4kbdWD3fsF4kc5fg4RLWpYqhOj9KLWVcV7t3uGkZEu
         YRv0ZPo7SVm//6lotA7WAjehBBA7YclByNKKsm+qnRCiIp8LTpxvIFYqVsIsIsRmLtYr
         1cao2tBLMMVFeL6VraV41UAX00VdDaA2jwSLs/H7XyPNLBC4zLJ8kzUS1H2XfzAb7QnH
         ZXaohoPfa23Waq52mfzGaNwEcHPNL14IO0uXZN4GKIzZMJ33Zz8zp8lCIWYQwBXLRMab
         VNYg==
X-Gm-Message-State: AOAM533bfyhIn2nbZrZ2g4LGS4cHrzZTZSUKm3gT/jiY0FQPNyUublg2
        cHLuMLF71yznnDJefeBWJaYh7a/pOiqngxm9rokplXVo6rDbx6kdvcCQv4wFynKHLOdg22cYVNo
        cHXCU85VfKZPIQidCuUHQhzsji4obqeYgVAUzJm/REw==
X-Received: by 2002:a50:bec7:: with SMTP id e7mr72666288edk.295.1621245524416;
        Mon, 17 May 2021 02:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFowFZH854ZyPgDxPy3K92gwcL4/ZB7mDunYrzdSpyUnr65muv6dFEcWwC2r0SdH5OdjkVvA==
X-Received: by 2002:a50:bec7:: with SMTP id e7mr72666282edk.295.1621245524296;
        Mon, 17 May 2021 02:58:44 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id i5sm4177351edt.11.2021.05.17.02.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:44 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] virtio: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:42 +0200
Message-Id: <20210517095842.81883-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find drivers/virtio -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index ce1b3f6ec325..3b3644d60d11 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -128,7 +128,7 @@ config VIRTIO_MMIO
 	 This drivers provides support for memory mapped virtio
 	 platform device driver.
 
- 	 If unsure, say N.
+	 If unsure, say N.
 
 config VIRTIO_MMIO_CMDLINE_DEVICES
 	bool "Memory mapped virtio devices parameter parsing"
-- 
2.27.0

