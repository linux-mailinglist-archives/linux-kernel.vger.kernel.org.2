Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1C39CFCE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhFFPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:40:43 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:37702 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhFFPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:40:41 -0400
Received: by mail-pj1-f53.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so10352566pjs.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vnKyon0BcZHjnZrJ0xlKombfXzk4vzVJpJjJjwKlCw0=;
        b=S4qqQCV8l/WZwmDOSOCiHzmajb9QpI9byGlaa2sFI8tFcOgWXx4wCV/cFnHZLAvjM+
         CkjACl0WA6g37z/+5yOQSGKT8YtTZjeJTMOUnw1XHmet+sybTABZHJdDNtexHjKDiwYW
         E7AJXXBI6AIm1F3q4g+KK1ZRm/lbyjsmVAWjti7mKHSxBu+mZNnZgsQ0O+9Fjkts2/FH
         EgG2enNNy+t5T2RRb5KlPp92AJlcKhuHoVvGp4EbwJGSUz/m2wafANkW08kwXrcxO9Xx
         8VAtqcKt0BOSU+jHBTDiI/nb2Kab5Z6v4IwrhJC/7mhY6S3nWazQyXaJqauZygIMurst
         iTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnKyon0BcZHjnZrJ0xlKombfXzk4vzVJpJjJjwKlCw0=;
        b=YCpVQwGT5Y81zchkCaOINp829/ZygmMkazSbx58RRMM5LQtAdllQPMmB07VuYWZLAW
         Fyam2H6dQenMQnfbBITuESPZottj45DxEYaeZXSVjpwoOChWTAGukFtmcd7tFKh2zBS4
         KSq2gIxsIjlCwVthRgxK0TeOejjWvgG2FOT6qh3PTBxS47vgzDcCnm2vNr97884wARbW
         6motw3tYHu3IDULyP48Sp8BdoildzamSbfqzr5WcNEXQ4MZ0rCtFWSzfB5hWK4qiSjOv
         icZJGYmp94/O7OZRE10uZVdDJ/4n4SabUIOXx9Le2bcwXb7ZB0YvA4C+e3h3QO1qbctR
         usNg==
X-Gm-Message-State: AOAM532RTxTCNAn0Fbjd/XQRf7rMXoKYzxG339l9nHJY+06KTSoY6R+b
        iJuD7UxIIEUWdOJrHHBqPE7G
X-Google-Smtp-Source: ABdhPJyrAQ/kVqlRYsphz+hZKXC3rP9BMTSAkQdpxZAPtARy5hiQCUp0cP0rqj+rjte/dFqFNC1XkA==
X-Received: by 2002:a17:902:aa42:b029:ee:f55a:b2c1 with SMTP id c2-20020a170902aa42b02900eef55ab2c1mr13915434plr.15.1622993871882;
        Sun, 06 Jun 2021 08:37:51 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.59])
        by smtp.gmail.com with ESMTPSA id g29sm6497919pgm.11.2021.06.06.08.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 08:37:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarvis.w.jiang@gmail.com, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] bus: mhi: pci_generic: T99W175: update channel name from AT to DUN
Date:   Sun,  6 Jun 2021 21:07:39 +0530
Message-Id: <20210606153741.20725-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606153741.20725-1-manivannan.sadhasivam@linaro.org>
References: <20210606153741.20725-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarvis Jiang <jarvis.w.jiang@gmail.com>

According to MHI v1.1 specification, change the channel name of T99W175
from "AT" to "DUN" (Dial-up networking) for both channel 32 and 33,
so that the channels can be bound to the Qcom WWAN control driver, and
device node such as /dev/wwan0p3DUN will be generated, which is very useful
for debugging modem

Fixes: aac426562f56 ("bus: mhi: pci_generic: Introduce Foxconn T99W175 support")
Signed-off-by: Jarvis Jiang <jarvis.w.jiang@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20210429014226.21017-1-jarvis.w.jiang@gmail.com
[mani: changed the dev node to /dev/wwan0p3DUN]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/pci_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 7c810f02a2ef..8c7f6576e421 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -311,8 +311,8 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 32, 1),
 	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(32, "AT", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(33, "AT", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
 	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
 };
-- 
2.25.1

