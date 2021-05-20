Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13CB38AF35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbhETMxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhETMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F42C06916E
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so17390565wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOKvWZ5W14w9Rdyd0lrBNMdUXShmRKJk0T/dMQYbPTI=;
        b=qds6VnIU8Q6QcxOi3JJYyxxHuWKa93zJE1shGrcEINr/JYHTNJYMMv3vMPHLkouNbR
         rrtV26ZIKhOHd2jcUMjVjHwm3aelyn4GmXuumAscO1Dw4yqn7QR6wyIz1pqQ9qZPcEJz
         ew/9fwg6Tsu88vCz3NssYsX3lJnoo1AHoZFL7hpzWzAGoA8taoCbXV1pUoqUdzxbDPIr
         oHw2moawVbOfawzqc9ptKvjW2zqyY+58WtQ21QhjufV5XrTtNf30PIPWmmD6zlNjrbMV
         h+lWHIva6lvG9U+PNB8IUebnbfrM+qevniiFNVHOtYDjilt21hpSdNQp1LPbZbp9l9rR
         11DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOKvWZ5W14w9Rdyd0lrBNMdUXShmRKJk0T/dMQYbPTI=;
        b=EoXakiJXAWPlpMvPkIfUeQJcyfqhICrtoNhWj40ZU0lSYaYu85LUTo5+GaZIzD2uMy
         DK4glZhgvwWSedGlFPCm7oo0DhsC6UFck8DLQURlTWzwe9FwPPHJJmkG9VY83halvJz0
         WmZVhV62UiB0JIr+MuDbph2vHadior2HZXLcDCMVzimwEWVxqfJiK+rV6+ka3gkYFV9y
         Xz29MnVIbiiMweliBoLEDBtOMrtQ5iPheskjGnVpOSqGrVEYItOnbf1/LqDrp8BM92h5
         rm8+ocY48toVC4QScoj8OJpceZlHj4EY7Li2b74jPQx9Y34yIFlEx0qZSzPHrGQyLodm
         I7Mg==
X-Gm-Message-State: AOAM533061XUKdtHu7Ot9a1WPTyHZ0cANgSPWqVV0OIzhVurXdYIz0Ef
        h26uYbuyYxoSLC9MUv1dd54bNuZiI/yX+A==
X-Google-Smtp-Source: ABdhPJybjfYRwX+nuYeEzAy2dspxscfDqMSnmtNpXHIPEOy6ZXbbE+3buOiKWLDAgbbEEMT3SlhQCQ==
X-Received: by 2002:a5d:6d8f:: with SMTP id l15mr3990195wrs.313.1621512846868;
        Thu, 20 May 2021 05:14:06 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: [PATCH 11/16] char: agp: via-agp: Remove unused variable 'current_size'
Date:   Thu, 20 May 2021 13:13:42 +0100
Message-Id: <20210520121347.3467794-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/agp/via-agp.c: In function ‘via_configure_agp3’:
 drivers/char/agp/via-agp.c:131:28: warning: variable ‘current_size’ set but not used [-Wunused-but-set-variable]

Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/agp/via-agp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index 87a92a044570e..dc594f4eca38a 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -128,9 +128,6 @@ static int via_fetch_size_agp3(void)
 static int via_configure_agp3(void)
 {
 	u32 temp;
-	struct aper_size_info_16 *current_size;
-
-	current_size = A_SIZE_16(agp_bridge->current_size);
 
 	/* address to map to */
 	agp_bridge->gart_bus_addr = pci_bus_address(agp_bridge->dev,
-- 
2.31.1

