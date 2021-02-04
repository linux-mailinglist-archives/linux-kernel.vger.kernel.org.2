Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4020430DD8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBCPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhBCPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:03:22 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C5C061573;
        Wed,  3 Feb 2021 07:02:08 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e15so17693133qte.9;
        Wed, 03 Feb 2021 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceBeYw6trMyX9icUO9/UnuzLMEhUPL/aH1HNbz7oF3Q=;
        b=vD9/Ue7PxW/Z2vG/7u+rqESf8dgzp+ZJReLBO2EdjOL0tQ0gIJ9aD263aB1w1qMr2+
         NI8rc+2xbf9rG3VwHTZJwPQcgB8pubqhAf8IDm7PVmFwss1LsPWiDExS1GaDSpLLgp9V
         9bGDVIAfBVuFmEqJ8PKB4Y68p1Zg5rIXGDPbDGJnWIa/dqvjhb6kDnFi/txglHl5OJTX
         AWBg9PA3dnurMilA1xNSBs4gLIaEkCrgq3m6ceyiznnv/NvlGJEjtRqCNClYRN1i/y24
         1Ci9UCQz+AA1ALeZPXGVcM87ah2iCxJYdZ5Fw31WKvYjhcOhJyutSQVRlLlxrr/mJo+C
         TAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceBeYw6trMyX9icUO9/UnuzLMEhUPL/aH1HNbz7oF3Q=;
        b=Bs2FEXlBA8k6SP0nPaPTq2RKj9MHWwtM2GI8V2j8Y32P4A2k1J0k7TW7+vo53Uv0PN
         3JUBcbpKcv92STfjZXS1pBfwaZ4b98AR7WPD+dXF6PAvBTeixn8EpRnqQQUfOYF4oMyD
         29M8lk4AGYe99NuVuc9YAVY/2bfpa+qvaEYR1KJpaQ2nbtbHuKDz3q0IzxguW2lFCKUG
         /W69mfs6f/HGfDkhIWDWbnmTT6h0syzp/HLezSQWj/F1WKDVEkrr++bYaAOHvkwQU0sA
         IvsOteBw31NHYSqtDfBxlv/uuOA0B47Ved3MzPJ7N73nWeBaM0tDb1g0Nkg3Eb4p3NLZ
         TSxQ==
X-Gm-Message-State: AOAM532XuxTyTL354jlw9F5RbZ1LE1PHnXKPAafTOnMInglcwIRJnBng
        lbshjWJYc1PJwhfJ/oe30/M=
X-Google-Smtp-Source: ABdhPJzTiF2UZG+gbbqg8qzBv0b9tZfPYMxL8oLL48ifh1UUZFctS5K5qiRLlz7uZod3fzcjPmCtEw==
X-Received: by 2002:a05:622a:3ca:: with SMTP id k10mr2831602qtx.270.1612364527803;
        Wed, 03 Feb 2021 07:02:07 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id m10sm1486429qtp.72.2021.02.03.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:02:06 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: crypto: qat: qat_common: Two different lines fix the same spelling in the file adf_vf2pf_msg.c
Date:   Wed,  3 Feb 2021 20:31:48 +0530
Message-Id: <20210203150148.25671-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/messge/message/  ..two different lines

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/crypto/qat/qat_common/adf_vf2pf_msg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
index 2c98fb63f7b7..e85bd62d134a 100644
--- a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
@@ -8,7 +8,7 @@
  * adf_vf2pf_init() - send init msg to PF
  * @accel_dev:  Pointer to acceleration VF device.
  *
- * Function sends an init messge from the VF to a PF
+ * Function sends an init message from the VF to a PF
  *
  * Return: 0 on success, error code otherwise.
  */
@@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(adf_vf2pf_init);
  * adf_vf2pf_shutdown() - send shutdown msg to PF
  * @accel_dev:  Pointer to acceleration VF device.
  *
- * Function sends a shutdown messge from the VF to a PF
+ * Function sends a shutdown message from the VF to a PF
  *
  * Return: void
  */
--
2.26.2

