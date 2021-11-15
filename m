Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950C64502F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbhKOLC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhKOK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:34 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED2C061766
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p18so4157206wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTBXnapqkVFlBYxNariu8PZzYpFF1+dh6PCGaUsL4VA=;
        b=VjkSs0poiWDZzogiZvuAQrpasCXjxw+5vmonR5qwXMBRrDwi5cvlD/8kd0ccuU89Bt
         N1fkPREZ4X67mH3VMzatu8JdTCNPjXTwKoxtLutR6UeQBW+Bfg1PjmyVxqtqzGh4Rwke
         uUC92A33pFJcriJEyF0Y6qpH1rPs+xK3CmqiLy7vTQZOf3yfvlb+c44ETv7qHwfEhgdR
         txaaE5fMY318Vcaprh9x9J75f1GTyoGRCymiHyKNylE5vf1HiagGM3F+YLjbIjtmUdA6
         ipwvBMAJd0AP6yUN083d+zqMDslSWVYf5yMilmhhpq5906JqEGaDw6VtM8ptNdkPipr0
         zLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTBXnapqkVFlBYxNariu8PZzYpFF1+dh6PCGaUsL4VA=;
        b=Vb5ZbaqJ1BvkBO3ECNEr8vRQFaevMrl6cYZHXT6t+s/sHtYNrvhBPLqR8LjFSUex/l
         FlJ6NEPXONZ5aTMFkysL20T4fK93NAdDDaPvhCRRocz+YAUJM227ChqZpIDLqfnYAvqp
         Jc797KFazfMO18anRbagpgf/DTqNzlbLNlwI9BWnVZQ2AQuSoZP7uW/8YVMFL8kabEcR
         xtAV+RBIRn8MBBQoGOoStEwc9yH+HC1Pd7/+qTgrBG0NJ3iSpka/Cw1XHFzcBWPhQGuj
         769nvnKITlPW2ksGadsS0befBH9evo8upJLdlaKNbaeXyxIkX9CKB3NdPi4bCG8YgD2Y
         5vVQ==
X-Gm-Message-State: AOAM530lXZX8ij+iNR0TFBBjTwuysrcTSREAL8zQJXemddVH+ZT1JPCK
        1UxA0ZCxAMjt0oW8yahg7mZHf2FTzYw=
X-Google-Smtp-Source: ABdhPJy3zxH0wl4CUIcRQoDNkh9NMSy2X6CBC+uheQfkt1MI02valrM+zHKSKmscYwesVq0E81GmJg==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr56453882wmb.28.1636973790577;
        Mon, 15 Nov 2021 02:56:30 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:30 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v3 6/8] staging: vt6655: Update comment for `rf_write_wake_prog_syn`
Date:   Mon, 15 Nov 2021 10:55:47 +0000
Message-Id: <be06c8f0df043598f3280a15397ad66aabefeaf4.1636729147.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the function description to include the actual parameters.
Update the comment on the return type.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 569b430dd9ae..d4c18d9bfc67 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -669,11 +669,11 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
  *
  * Parameters:
  *  In:
- *      iobase      - I/O base address
- *      channel     - channel number
- *      bySleepCnt  - SleepProgSyn count
+ *      priv        - Device Structure
+ *      rf_type     - RF type
+ *      channel     - Channel number
  *
- * Return Value: None.
+ * Return Value: true if succeeded; false if failed.
  *
  */
 bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
-- 
2.30.2

