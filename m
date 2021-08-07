Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9443D3E3474
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhHGJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhHGJsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF64C0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b11so14348519wrx.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqppnh/WDI71rpOyjNOzTEItDQOlRTUr1XfwQG6H1rM=;
        b=P6AXXTYG+26CjAKpIk0O/LpIDfcOZQTT8qKju2eQYMDDZVmdUjz1yOrqt52FIEkMf3
         pHD1pW5ddu/8GNhlcM23kmoSuXcn2Q6H/cvBTditOwcIXhjfH48FTnr5IJF1BoMoAPbY
         ft4+xv3HUyqIbpDDj2sf5YUXRMHUG5BBipC4VQ10zOcpPuQRDaNTvYy98gqjvRIij2XJ
         aBG8DxcVva3jNP8U75o0Bu6WEzT4x8G0vMKjFsnA5OnU96unE20/dBR1dWkH6WBBl9KS
         jgeRHVDE7qbHcnfVMuAc1Hniczy1+8r3+WflgC7Oyor5o2VmTJ7xmaNlqqelBEpGQGzZ
         EPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqppnh/WDI71rpOyjNOzTEItDQOlRTUr1XfwQG6H1rM=;
        b=Aco07xbsxfogbG2UUUpDHMl4cKvXbjTLuUybdiYXaNgOcqRcwrUIFAaBpcdNEsrY1U
         J2dXn1xloNLqXK2j/MqTh1uAA7te8lwyW7am/Z5AIeJ+vr+tHg36iVTQYYim39+V23HS
         nSW+DUx3EkjR3kV1snGELIDgNZsUpOuMKRLaG/Nd0DlTrNdqufvU9kaS7Ym8iNvmWZy0
         yfuf5ruLs3jWTjiYPZj9S4gIbo9KwCiQnEISMOcwBbdyvlZkso7dlGYLONQCTK4vHB8b
         yg9Q3sXZ2XujijK3zIXjOY9e00+K2LjthJiab5MIbWiIQnRsgHUwDfDYApXefPNTLBay
         Mz+Q==
X-Gm-Message-State: AOAM531aJQV0HfFLCAmt/yfCpe+z6hgwika16ArByphTViJN4o0IMHmx
        GAG+944V19eGbXBW2ZBwv5BMlpWXtyI=
X-Google-Smtp-Source: ABdhPJzl4Zid6qFXPJqUrpt/5jQyA8gZMbpjW5nRh3H+gqSbC0SlEaYP+9NokymvsaoNTuZkDEB27w==
X-Received: by 2002:adf:f590:: with SMTP id f16mr15486485wro.162.1628329705856;
        Sat, 07 Aug 2021 02:48:25 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id p14sm1064600wro.3.2021.08.07.02.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/21] staging: rtl8723bs: fix right side of condition
Date:   Sat,  7 Aug 2021 11:48:00 +0200
Message-Id: <147631fe6f4f5de84cc54a62ba71d739b92697be.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TxNum value is compared against ODM_RF_PATH_D,
which is inconsistent. Compare it against
RF_MAX_TX_NUM, as in other places in the same file.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 03c174aab08d..a47a0a1cae22 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -350,7 +350,7 @@ static void PHY_StoreTxPowerByRateNew(
 	if (RfPath > ODM_RF_PATH_D)
 		return;
 
-	if (TxNum > ODM_RF_PATH_D)
+	if (TxNum > RF_MAX_TX_NUM)
 		return;
 
 	for (i = 0; i < rateNum; ++i) {
-- 
2.20.1

