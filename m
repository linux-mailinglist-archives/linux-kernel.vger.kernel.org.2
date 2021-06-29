Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8623B6F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhF2IYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2IYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:24:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6FDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:21:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d12so8865226pfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxHib6d2K90USWogCay1vwTHEN43n+hlATnAyEzxsfQ=;
        b=cgNbDDzaLpsFqfD5U/M/ogaZl5LZIK5vIuXcUeXU7bcqAVe489Xsq9PVQOa1R5dFpT
         8g1vMH9P/a3A053OZ+04Yhgx3AXOFF3lQN2xRYRnhs15+rIaHUNWF5xMoCqTD9x0gqxN
         rilMk5q2P+fdv3QaigtxXRmsIgHcl7gg2cbNHcuKYdS3trafyy9zCLUlvGp0534+/NHH
         mwo7bK9+RcdOKNQ+vse7Yij5OXlDHTQMzpPKe1Uva8+r+1ZZFsIudQRLdwh62QpaxigA
         wsQB5GhOPyBemc/FKOntJGBvYW8/+N7ms6cYJkfwt4j42RNJNyf5aKwglmwk2a5Z58lG
         qEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxHib6d2K90USWogCay1vwTHEN43n+hlATnAyEzxsfQ=;
        b=H84ZMr5RyWcBEi/OMamK0z5vB5pj/wAX3ohV7MDY423y9nK0IiNlOR2/a8lX3c233j
         TKKD1VKuB5LX6eCH/n0bemlvmu9yhMEGw6Hj4ttvjUDxwCiJ3jBdOdOj+op+aEBKRSDK
         oyZeltkw+m09DqZJSj+dIG2vfRCcHD63/KyrA+5Yt3Z7lMDiToNx0UDCEEBZFQ4hRJdy
         9IFuYcVkOdK+kzNxIjR5mRr/RBV9IJBkt2JlxAXSuKrKx1iFWFx7t+J+mk0LiWtYH2P6
         ItxFBNUemJz26CUwRo7IN0iukhycIwEiFbtKGD9noo0NqyhYfjW2UnxNUKy8Y7718Gsk
         ivhQ==
X-Gm-Message-State: AOAM531gv67ms+llfhNLvkPWqd10DDy+o4x122mW8pfzpBSgr2lRfmNS
        UcebWAkMD+7a6B6EKn3tbR8=
X-Google-Smtp-Source: ABdhPJyA0b6cE2R38QqM2s77Z01XxTbG4EMb5qtLKhIs9I7hU2ylXBPbOoRRcPQP4J+KmNYXsNY75Q==
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id s4-20020a056a0008c4b02902b48334ed4dmr28844309pfu.36.1624954894494;
        Tue, 29 Jun 2021 01:21:34 -0700 (PDT)
Received: from localhost.localdomain ([13.88.222.67])
        by smtp.gmail.com with ESMTPSA id 22sm16682073pfo.80.2021.06.29.01.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:21:34 -0700 (PDT)
From:   YeeLi <seven.yi.lee@gmail.com>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        seven.yi.lee@gmail.com
Subject: [PATCH] driver core: fix e1000e ltr bug
Date:   Tue, 29 Jun 2021 16:21:28 +0800
Message-Id: <20210629082128.255988-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In e1000e driver, a PCIe-like device, the max snoop/no-snoop latency
is the upper limit.So, directly compare the size of lat_enc and
max_ltr_enc is incorrect.

    In 1000Mbps, 0x8b9 < 0x1003, 189440 ns < 3145728 ns, correct.

    In 100Mbps, 0xc3a < 0x1003, 1900544 ns < 3145728 ns, correct.

    In 10Mbps, 0xe40 < 0x1003, 18874368 > 3145728, incorrect.

Decoded the lat_enc and max_ltr_enc before compare them is necessary.

Signed-off-by: YeeLi <seven.yi.lee@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 23 ++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 590ad110d383..3bff1b570b76 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -986,6 +986,27 @@ static s32 e1000_k1_workaround_lpt_lp(struct e1000_hw *hw, bool link)
 	return ret_val;
 }
 
+static u32 convert_e1000e_ltr_scale(u32 val)
+{
+	if (val > 5)
+		return 0;
+
+	return 1U << (5 * val);
+}
+
+static u64 decoded_ltr(u32 val)
+{
+	u64 decoded_latency;
+	u32 value;
+	u32 scale;
+
+	value = val & 0x03FF;
+	scale = (val & 0x1C00) >> 10;
+	decoded_latency = value * convert_e1000e_ltr_scale(scale);
+
+	return decoded_latency;
+}
+
 /**
  *  e1000_platform_pm_pch_lpt - Set platform power management values
  *  @hw: pointer to the HW structure
@@ -1059,7 +1080,7 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 				     E1000_PCI_LTR_CAP_LPT + 2, &max_nosnoop);
 		max_ltr_enc = max_t(u16, max_snoop, max_nosnoop);
 
-		if (lat_enc > max_ltr_enc)
+		if (decoded_ltr(lat_enc) > decoded_ltr(max_ltr_enc))
 			lat_enc = max_ltr_enc;
 	}
 
-- 
2.25.1

