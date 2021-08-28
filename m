Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB353FA798
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhH1VZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 17:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhH1VZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:25:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44663C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 14:24:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so7687524wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7YDqqGJtJ3QDn9FqQDzakc4DzlPeBa/z6aADOfcvlk=;
        b=KYZY8ls3CXTujMl3yInD9mFM8A7RkDJXaAI9Mpr87n7IlkZWOvIRKHP1y3jh6N12GE
         ajYTIVKgkgqiYKeBP65ZJzVBgnTRTLmPHTbRIgduLfTWBfBS5enqA7T/NPdPKaBslIAT
         fl11FaoaI48vKxMm3kO4968hSsicqSHi3HSP7kABiTMuauVnNRzgg9N9LCDTQCTcpKFM
         gj+2YDzcPu2BkLMuuy6x+ZhA0u/KsjcpLDlj9rrqGI5Not1YKe2J8GBrGFMNG4E/F1x+
         MGj7QPmSbS1cdZ5mKCxOg588oRJDnGxzr5i1NyncKTOfMwk6RVZSE4fIibHqvY0uWSyl
         jkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7YDqqGJtJ3QDn9FqQDzakc4DzlPeBa/z6aADOfcvlk=;
        b=f0NpKw6mQ1TKWraRVDWNovUzuZsVS7RtwLGaJcRmgapED+vRuExR46WXArx2Evd3SR
         yoOPN2s+TYoqnlxMfUbBV2gCD4YNjG8ORlpmU8ZZppHT2Nma1oEbyL8h2qMbeLr6cuoy
         scwMJMnquci9sGXaGFotxV5eGy+a9LqJuQLU7nYKSqqHa1D2YPlZfGpSmdX6Mq6YSw2w
         ZYNOzlV79MwMlYDZS5aHUGlyG8dYqAeRtzZF7Ds4ziExQraIrlyKaFVMmGW1FYDPPqp9
         akFOjR/3ibhtH8xEjS1SUg3mAGFg4JJpi2SMXG+dSuLPt6thxsb6MRDKtlk/nIl4G0KY
         YPDQ==
X-Gm-Message-State: AOAM531PDhimDCaWxVg1Xw780B8Gsywf30BlfUzAmujM+CZ9cUlMEvXK
        nEPhMtQDwcFroFd9mrIjYuxveg==
X-Google-Smtp-Source: ABdhPJyCHNhJspkRjnJcy0D76OI4CN/ktjh2zAO6PvzgLZ1z3vWLnq1J9f6hum1jtJr8w6S2BlNPjw==
X-Received: by 2002:a1c:9d95:: with SMTP id g143mr15312898wme.187.1630185895896;
        Sat, 28 Aug 2021 14:24:55 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id u26sm8645847wrd.32.2021.08.28.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 14:24:55 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: r8188eu: remove c2h_handler field from struct hal_ops
Date:   Sat, 28 Aug 2021 22:24:51 +0100
Message-Id: <20210828212453.898-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210828212453.898-1-phil@philpotter.co.uk>
References: <20210828212453.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove c2h_handler function pointer field from struct hal_ops in
include/hal_intf.h, as it is never set in this driver, and remove
the check for a non-NULL value in the rtw_hal_c2h_handler wrapper
function in hal/hal_intf.c as well. As the function always returns
_FAIL anyway, just modify it to do this unconditionally.

The motivation for removing this field is that it is more code from
the unwanted HAL layer that can be stripped out.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 6 +-----
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index a6d589e89aeb..0c835f9cd181 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -428,11 +428,7 @@ void rtw_hal_reset_security_engine(struct adapter *adapter)
 
 s32 rtw_hal_c2h_handler(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt)
 {
-	s32 ret = _FAIL;
-
-	if (adapter->HalFunc.c2h_handler)
-		ret = adapter->HalFunc.c2h_handler(adapter, c2h_evt);
-	return ret;
+	return _FAIL;
 }
 
 c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fa252540e596..4603f9212030 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -251,8 +251,6 @@ struct hal_ops {
 
 	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
 	void (*hal_reset_security_engine)(struct adapter *adapter);
-	s32 (*c2h_handler)(struct adapter *padapter,
-			   struct c2h_evt_hdr *c2h_evt);
 	c2h_id_filter c2h_id_filter_ccx;
 };
 
-- 
2.31.1

