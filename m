Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE539705E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhFAJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:29:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38322 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhFAJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:29:39 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo0gm-0001rw-Tn
        for linux-kernel@vger.kernel.org; Tue, 01 Jun 2021 09:27:57 +0000
Received: by mail-wr1-f72.google.com with SMTP id g14-20020a5d698e0000b0290117735bd4d3so689923wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LpP1wbaBTd6CznJkAVeLVRWdOIhuA1LgB5xje3HBMh4=;
        b=U8k6d+BpE6qrVfyifzzjV2NXhAN5ERJa/3OtEf/q/jc+Tu+B3+yKwDii3qYhvB8mX/
         MEsAxHC+X8VMmw4vc/POau9Bov0LKlfIAyx3RbLjxb2cXZG7Pt3hqkm9TX7byVP5Jl2u
         9ZnzRI4qOATCz8ahnajyOEikN9T9+8va3AhGzcYjC8sVGWfSnv4bXQrl5OqpARXu9m5X
         VWuGJ2JP/SXWGsXTdoy81NGiM+kaT4zO/2sBzXFQChF5pN8bK1fjTpVrpcZMzDgr/OHY
         1tT5gMTal+On+fWLBOwnP/bMAWtgUB0dkPJhJFJTGZA5uKwTuGKsLsCFt/Pg6DMQqc+x
         wVtw==
X-Gm-Message-State: AOAM530xKbbL+KHK0/HRD7RZ7RHef8cLvmEp7gTtvjJ7bwWepWgQlOb9
        ZXaU0lY1MtFirZlusnc0VbBpRiP9LPm1Kk/qtbBEeO8HSqjj9U4ECAU2nEjvGVbFlw6tkaNZQrZ
        znPqxqHAksPbcExFmQEEj35BgUf/b18RgGEWRwVmMKQ==
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr26128733wrz.79.1622539676590;
        Tue, 01 Jun 2021 02:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlt27WwKmWPgGZjKKTi+R3wpNAquWKWHEBbnXQTizR9DhlKa/nCvounLTe/91cT5Daw9FHrA==
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr26128711wrz.79.1622539676431;
        Tue, 01 Jun 2021 02:27:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id k82sm2053571wmf.11.2021.06.01.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:27:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] EDAC, altera: skip defining unused structures for specific configs
Date:   Tue,  1 Jun 2021 11:27:04 +0200
Message-Id: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altera EDAC driver has several features conditionally built
depending on Kconfig options.  The edac_device_prv_data structures are
conditionally used in of_device_id tables.  They reference other
functions and structures which can be defined as __maybe_unused.  This
silences build warnings like:

    drivers/edac/altera_edac.c:643:37: warning:
        ‘altr_edac_device_inject_fops’ defined but not used [-Wunused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/edac/altera_edac.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 61c21bd880a4..2949edb93454 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -539,10 +539,18 @@ module_platform_driver(altr_edac_driver);
  * trigger testing are different for each memory.
  */
 
+#ifdef CONFIG_EDAC_ALTERA_OCRAM
 static const struct edac_device_prv_data ocramecc_data;
+#endif
+#ifdef CONFIG_EDAC_ALTERA_L2C
 static const struct edac_device_prv_data l2ecc_data;
+#endif
+#ifdef CONFIG_EDAC_ALTERA_OCRAM
 static const struct edac_device_prv_data a10_ocramecc_data;
+#endif
+#ifdef CONFIG_EDAC_ALTERA_L2C
 static const struct edac_device_prv_data a10_l2ecc_data;
+#endif
 
 static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 {
@@ -569,9 +577,9 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 	return ret_value;
 }
 
-static ssize_t altr_edac_device_trig(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t __maybe_unused
+altr_edac_device_trig(struct file *file, const char __user *user_buf,
+		      size_t count, loff_t *ppos)
 
 {
 	u32 *ptemp, i, error_mask;
@@ -640,27 +648,27 @@ static ssize_t altr_edac_device_trig(struct file *file,
 	return count;
 }
 
-static const struct file_operations altr_edac_device_inject_fops = {
+static const struct file_operations altr_edac_device_inject_fops __maybe_unused = {
 	.open = simple_open,
 	.write = altr_edac_device_trig,
 	.llseek = generic_file_llseek,
 };
 
-static ssize_t altr_edac_a10_device_trig(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos);
+static ssize_t __maybe_unused
+altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
+			  size_t count, loff_t *ppos);
 
-static const struct file_operations altr_edac_a10_device_inject_fops = {
+static const struct file_operations altr_edac_a10_device_inject_fops __maybe_unused = {
 	.open = simple_open,
 	.write = altr_edac_a10_device_trig,
 	.llseek = generic_file_llseek,
 };
 
-static ssize_t altr_edac_a10_device_trig2(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos);
+static ssize_t __maybe_unused
+altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
+			   size_t count, loff_t *ppos);
 
-static const struct file_operations altr_edac_a10_device_inject2_fops = {
+static const struct file_operations altr_edac_a10_device_inject2_fops __maybe_unused = {
 	.open = simple_open,
 	.write = altr_edac_a10_device_trig2,
 	.llseek = generic_file_llseek,
@@ -1697,9 +1705,9 @@ MODULE_DEVICE_TABLE(of, altr_edac_a10_device_of_match);
  * Based on xgene_edac.c peripheral code.
  */
 
-static ssize_t altr_edac_a10_device_trig(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t __maybe_unused
+altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
+			  size_t count, loff_t *ppos)
 {
 	struct edac_device_ctl_info *edac_dci = file->private_data;
 	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
@@ -1729,9 +1737,9 @@ static ssize_t altr_edac_a10_device_trig(struct file *file,
  * slightly. A few Arria10 peripherals can use this injection function.
  * Inject the error into the memory and then readback to trigger the IRQ.
  */
-static ssize_t altr_edac_a10_device_trig2(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t __maybe_unused
+altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
+			   size_t count, loff_t *ppos)
 {
 	struct edac_device_ctl_info *edac_dci = file->private_data;
 	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
-- 
2.27.0

