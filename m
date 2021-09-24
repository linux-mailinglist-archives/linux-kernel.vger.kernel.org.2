Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C62416A55
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbhIXDQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhIXDQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:16:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:15:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bj3-20020a17090b088300b0019e6603fe89so5039507pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6fS1DVa+oGMJZcW6Uz3T+yOtBK6Lvc/2ZNbTXLJgz0=;
        b=Ze6NHDvtiRMdTKWjXCMz1w+dhfGXV7s3sIb6YWRzKHHMVBFKMxLvhu0oRSnrykO9gk
         fO6B9nuhnAXlw6X7vm0UDNaBPfaie06CFbVgUCimbrGf1+1mrMBPVOGxCKJ8afV3728Q
         hkXPwP5Q3i+iYfo9Um8aio0JP1Iox+3Fe3wMEhltStefR1T/Et6IMOY4fECVcbNIrgkt
         l4h4JBHJnuiMnvafyJwqFg7FTcUjZnHtsfP4fr3NaXX5C3TFu5TPvtUAVnuhPmBqxjV3
         9+PYzaXN299ceGHb1EM3ohy2QKqf40RDoWE9DsktqVPUC+WsobzU+6qIxCI+gjgtJ0y8
         ka8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6fS1DVa+oGMJZcW6Uz3T+yOtBK6Lvc/2ZNbTXLJgz0=;
        b=T92SF/eZs9Of2QkRf3AdQO8wp9PnD2GZ/sjW3WYVRg9p8ZxaJ1QN6iS8f+MxMehDdx
         JoBKUuQER0CWa54JyHrgE3iKAgNnWUg4D949UuXoLzSMdONw1Hyw/5T97K7pD4tQC4lY
         zk5RHrsIl9c9dHpKYwDDB083tar//NNKpEuXyC2hJfWXUm62yi0lBtgMDWeHqsRu2ZlG
         F8A0kmmaODBIMVMraifD+jm1AX10z9UBt5f+MtFZslmMFlHIUrAKDBtpNQX/IKTt3c6q
         EhlgVGmsqZzNSZhe8b3ZAcAp7E5t1w8iEyup9yJzVyht2QPfllW00OJ6GdqBcMNFyy0f
         lreQ==
X-Gm-Message-State: AOAM531ZhmItye30xUk85iZzt0Bnt5PLznB05rH7CbX4w53DUyg4aSnu
        zz8f18C0AMx0w+ZzXvXrlqol/NCQQiU=
X-Google-Smtp-Source: ABdhPJyHOt5JYruQ/YJX8Dtw9HlMFSAo6RvNET7t4nd72ymNfrnwu5HAEeBvzhiLwGchfZuPAfnDmQ==
X-Received: by 2002:a17:90b:3890:: with SMTP id mu16mr22224281pjb.78.1632453306979;
        Thu, 23 Sep 2021 20:15:06 -0700 (PDT)
Received: from 7YHHR73.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gp11sm9880532pjb.2.2021.09.23.20.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 20:15:06 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB DPFE
        DRIVER), Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM STB DPFE
        DRIVER)
Subject: [PATCH] memory: Allow building Broadcom STB DPFE as module
Date:   Thu, 23 Sep 2021 20:14:59 -0700
Message-Id: <20210924031459.8911-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow building the Broadcom STB DPFE driver as a module, it is already a
platform driver proper with all of the resource releasing device
managed.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/memory/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 72c0df129d5c..0ebb83b35a64 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -55,8 +55,8 @@ config ATMEL_EBI
 	  SRAMs, ATA devices, etc.
 
 config BRCMSTB_DPFE
-	bool "Broadcom STB DPFE driver" if COMPILE_TEST
-	default y if ARCH_BRCMSTB
+	tristate "Broadcom STB DPFE driver"
+	default ARCH_BRCMSTB
 	depends on ARCH_BRCMSTB || COMPILE_TEST
 	help
 	  This driver provides access to the DPFE interface of Broadcom
-- 
2.25.1

