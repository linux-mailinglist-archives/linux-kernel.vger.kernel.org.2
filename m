Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F6F311A8B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhBFDzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhBFCvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:51:13 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A53C061A31
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:11:12 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id y15so7221343ilj.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhwlK/0Dz6i4rhS6CqV6gw/YDZHe+oacHIsDYWLXy98=;
        b=a/EGLZiT4ynqoWW1KvNwfvuiT5usb63C9ZVCnNxL2lz0b+PYz6gj8PsP7D+x78hPop
         CqC+9iRL80c2q/RQ+8wotrshRmRtgGH8kBjIddcEWqBxm+KSEJB32GtubSsL/g2TGBI8
         cuI2wfmoamucduV0RqSqaady5XE65BJ7PR0Cnq1chXpn+JLvbdA+tSXyqRIXxLqWtlwc
         WBO1RTlav3lIEWSH9HSY8w8wXCk0WpqT0b2hbd81GA1eTkiQCBLBRNu91Jf8Lgdkb9Fv
         SJp4xIqAx/4UeU7OitYrQlH2s/dOTYR/3s8td4LERYlIoK403sh4/UFHnm53GktyZ+1b
         4zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhwlK/0Dz6i4rhS6CqV6gw/YDZHe+oacHIsDYWLXy98=;
        b=ccskaizyZu2GiWFEcWBy6bgnj4hWfdR9/Spf3+SlDWRmAP7Z78obJN2m+2tnWQPkS3
         1jUc/dEL70dokCnGbuz839spmfSs7w4QRT8AWp8V74ya13o2htWfsB5RK69xRty/Nisw
         JoUgM5KNlNMGtLZNNx4pG3T4JXj2LL3ff0foUAv6gW4vEbkKIp8F9tVB5kOGy0RMmnJy
         9UrCpybxLr1ALx8na0ndu4P+zTtvfcrnGwPiLCmKGE+Li1EqhyqNeY3SBkadt19XWxkq
         N12fiiNpxPIqj/n+KNBX6IyVHpcpQi/TwapmdukC/bWhTDd+6Od7u58dfHaWvA98HRiv
         a2wA==
X-Gm-Message-State: AOAM532x9dsHtHF5jbVKa/avEuseg8JcMyJRcrWfbSoNKxl7Y20gVCxG
        /1XmuQ9XbI0TNP1qF70HBsDRQw==
X-Google-Smtp-Source: ABdhPJzFaFCbDDW3MO58MHKJgOa1yAImKVDH3hvJCIrRKXZA7O30+aUdLKMVF+CKYQowH+wOSUiuog==
X-Received: by 2002:a05:6e02:188d:: with SMTP id o13mr5609957ilu.223.1612563071546;
        Fri, 05 Feb 2021 14:11:11 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m15sm4647171ilh.6.2021.02.05.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:11:10 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/7] net: ipa: remove two unused register definitions
Date:   Fri,  5 Feb 2021 16:10:57 -0600
Message-Id: <20210205221100.1738-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210205221100.1738-1-elder@linaro.org>
References: <20210205221100.1738-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not support inter-EE channel or event ring commands.  Inter-EE
interrupts are disabled (and never re-enabled) for all channels and
event rings, so we have no need for the GSI registers that clear
those interrupt conditions.  So remove their definitions.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_reg.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
index 0e138bbd82053..299456e70f286 100644
--- a/drivers/net/ipa/gsi_reg.h
+++ b/drivers/net/ipa/gsi_reg.h
@@ -59,16 +59,6 @@
 #define GSI_INTER_EE_N_SRC_EV_CH_IRQ_OFFSET(ee) \
 			(0x0000c01c + 0x1000 * (ee))
 
-#define GSI_INTER_EE_SRC_CH_IRQ_CLR_OFFSET \
-			GSI_INTER_EE_N_SRC_CH_IRQ_CLR_OFFSET(GSI_EE_AP)
-#define GSI_INTER_EE_N_SRC_CH_IRQ_CLR_OFFSET(ee) \
-			(0x0000c028 + 0x1000 * (ee))
-
-#define GSI_INTER_EE_SRC_EV_CH_IRQ_CLR_OFFSET \
-			GSI_INTER_EE_N_SRC_EV_CH_IRQ_CLR_OFFSET(GSI_EE_AP)
-#define GSI_INTER_EE_N_SRC_EV_CH_IRQ_CLR_OFFSET(ee) \
-			(0x0000c02c + 0x1000 * (ee))
-
 #define GSI_CH_C_CNTXT_0_OFFSET(ch) \
 		GSI_EE_N_CH_C_CNTXT_0_OFFSET((ch), GSI_EE_AP)
 #define GSI_EE_N_CH_C_CNTXT_0_OFFSET(ch, ee) \
-- 
2.20.1

