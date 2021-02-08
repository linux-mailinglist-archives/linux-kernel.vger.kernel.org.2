Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C031291E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 03:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBHC4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 21:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHC4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 21:56:16 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C9C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 18:55:35 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id j12so8756749pfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 18:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cRQhiF2GEiPjRDo8n2Y99tRPesoEHMgxfbNm4llEXVw=;
        b=YvzighEBZPgRI0+B7YbURV5Uei8SR77KtaA/mEz3JnyIBexL5pWA/HLsYS8WPNrn+1
         CSipSRXJueQVKSi1n0XJOZ4PoT7vRsE2/RsWCJ3EyEjvL9G/437TCXNc1VKwnvpfTylp
         ETH7oezyngV3YIS2XZS340OmzVvSLAZN+lXU/sQSY4jEDzr/xHst7yebuT569oxO5gPP
         LiRDroRXK2sgmKQM1xKeK6xhpvmUahg3aX4UZyYl2Rvr6a5MZfu5afnmHfVvhdkwAtpE
         ASiepLulkJpcz74/ivCaR74dkalFhpMCBJtKSROvrCU6JHh8zBCZZ4Rmxzj1yN0n6YLD
         nDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cRQhiF2GEiPjRDo8n2Y99tRPesoEHMgxfbNm4llEXVw=;
        b=CH4xOkcrKaFKbU6zTUg9hBOeFNzHGYEiCoTCV+Zp1gJYfzuUdOZD8N5MVFu1BMVFms
         sPhyXtaFch5f1OJakTA3wtRTBMklQUDs4CNR3zXYynZP2toGyqNwTVdhDYizM5fkIcAE
         +WOWpQKu4a6gVsb+k8v94LJKzXQkKsuH+eCK7WEsq1Y3AuSgRjtLJXY8K7soZMQIxrBp
         1XLCNOLsxPtpifEDeLVo4p6NHbJtg7JoFSy1CYcXKQN2Xg3zMGmbzxTIuYQCf4dddvl5
         iiCCBQ6lGj2cuNUiZXMQ81QVJc56N1pTi1mNPZ1q7VSTpuRBYpzi67kHmNwDtoQYkii7
         KcCg==
X-Gm-Message-State: AOAM530YJVh2fi9u6WxSRY7/100OQ7kUKT9LV6k23b3MFpZ3PubF3srF
        62XiFqSx6PA9a52aIKe1rtw=
X-Google-Smtp-Source: ABdhPJxlyrOhirfCn4YYSv0rzIFzBuoTySDyB8uyOX7zJBXiw4W9hm42DYdBV+Uwg7TuLHRfa4iDAA==
X-Received: by 2002:a63:70f:: with SMTP id 15mr14818934pgh.250.1612752934934;
        Sun, 07 Feb 2021 18:55:34 -0800 (PST)
Received: from mahak-Inspiron-7570 ([103.153.208.42])
        by smtp.gmail.com with ESMTPSA id w13sm16759704pfc.7.2021.02.07.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 18:55:34 -0800 (PST)
From:   Mahak Gupta <gmahak1@gmail.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, rcy@google.com, benchan@chromium.org,
        toddpoynor@google.com, rspringer@google.com
Cc:     Mahak Gupta <gmahak1@gmail.com>
Subject: [PATCH] staging: gasket: fix indentation and lines ending with open parenthesis
Date:   Mon,  8 Feb 2021 08:25:08 +0530
Message-Id: <20210208025508.25714-1-gmahak1@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warnings of 'checkpatch.pl'. According to
Linux coding guidelines, code should be aligned properly to
match with open parenthesis and lines should not end with
open parenthesis.

Signed-off-by: Mahak Gupta <gmahak1@gmail.com>
---
Changes since v1:
 - Use temporary variables to shorten long lines. This variable was used multiple times.
---
 drivers/staging/gasket/gasket_ioctl.c | 42 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index e3047d36d8db..aa65f4fbf860 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -40,10 +40,11 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
 
 /* Read the size of the page table. */
 static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp)
+				       struct gasket_page_table_ioctl __user *argp)
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -51,8 +52,8 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	ibuf.size = gasket_page_table_num_entries(
-		gasket_dev->page_table[ibuf.page_table_index]);
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	ibuf.size = gasket_page_table_num_entries(table);
 
 	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
 					   ibuf.host_address,
@@ -66,10 +67,11 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 
 /* Read the size of the simple page table. */
 static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp)
+					      struct gasket_page_table_ioctl __user *argp)
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -77,8 +79,8 @@ static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	ibuf.size =
-		gasket_page_table_num_simple_entries(gasket_dev->page_table[ibuf.page_table_index]);
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	ibuf.size = gasket_page_table_num_simple_entries(table);
 
 	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
 					   ibuf.host_address,
@@ -92,11 +94,12 @@ static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
 
 /* Set the boundary between the simple and extended page tables. */
 static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp)
+				       struct gasket_page_table_ioctl __user *argp)
 {
 	int ret;
 	struct gasket_page_table_ioctl ibuf;
 	uint max_page_table_size;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -107,8 +110,8 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
-	max_page_table_size = gasket_page_table_max_size(
-		gasket_dev->page_table[ibuf.page_table_index]);
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	max_page_table_size = gasket_page_table_max_size(table);
 
 	if (ibuf.size > max_page_table_size) {
 		dev_dbg(gasket_dev->dev,
@@ -119,8 +122,7 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 
 	mutex_lock(&gasket_dev->mutex);
 
-	ret = gasket_page_table_partition(
-		gasket_dev->page_table[ibuf.page_table_index], ibuf.size);
+	ret = gasket_page_table_partition(table, ibuf.size);
 	mutex_unlock(&gasket_dev->mutex);
 
 	return ret;
@@ -131,6 +133,7 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 			      struct gasket_page_table_ioctl __user *argp)
 {
 	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -142,13 +145,12 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (gasket_page_table_are_addrs_bad(gasket_dev->page_table[ibuf.page_table_index],
-					    ibuf.host_address,
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	if (gasket_page_table_are_addrs_bad(table, ibuf.host_address,
 					    ibuf.device_address, ibuf.size))
 		return -EINVAL;
 
-	return gasket_page_table_map(gasket_dev->page_table[ibuf.page_table_index],
-				     ibuf.host_address, ibuf.device_address,
+	return gasket_page_table_map(table, ibuf.host_address, ibuf.device_address,
 				     ibuf.size / PAGE_SIZE);
 }
 
@@ -157,6 +159,7 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
 				struct gasket_page_table_ioctl __user *argp)
 {
 	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -168,12 +171,11 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (gasket_page_table_is_dev_addr_bad(gasket_dev->page_table[ibuf.page_table_index],
-					      ibuf.device_address, ibuf.size))
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	if (gasket_page_table_is_dev_addr_bad(table, ibuf.device_address, ibuf.size))
 		return -EINVAL;
 
-	gasket_page_table_unmap(gasket_dev->page_table[ibuf.page_table_index],
-				ibuf.device_address, ibuf.size / PAGE_SIZE);
+	gasket_page_table_unmap(table, ibuf.device_address, ibuf.size / PAGE_SIZE);
 
 	return 0;
 }
@@ -183,7 +185,7 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
  * corresponding memory.
  */
 static int gasket_config_coherent_allocator(struct gasket_dev *gasket_dev,
-	struct gasket_coherent_alloc_config_ioctl __user *argp)
+					    struct gasket_coherent_alloc_config_ioctl __user *argp)
 {
 	int ret;
 	struct gasket_coherent_alloc_config_ioctl ibuf;
-- 
2.17.1

