Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB41312498
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBGOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhBGOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:10:28 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA6C061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:09:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a1so13999388wrq.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OG1Z720HiLI9TnXhLnBUmjf5XIxwOfpZr3RRpPSXgXQ=;
        b=GfsaJtmnGDEpBhuLitsDTYUsTz64nplZRyNBtdJpb486s9lXKCtHilA3fpiApDplH3
         4CDoarxDiA934iORYhlKJWX1+PAAtdYLb98tzM+WJ/upRbmnKKWUR/hreMXjZNY4Cxa/
         pSLmUGvN10759ojMa98twMbNDyyyT75Hh4GQ94IuSO+JpmXyDCpqs7lbzNqTPO54C0AV
         7ZY/IdamEpZ7mPIKuwi3a1FLz/NKpy7Y9QsSRgf+9CfZONvXYBwThW4nrI4rbaD0LgVy
         a410LPmAp0V8TEc1F7YCnqFbxF8F2ryrdfmWgcMvMfhnyK0x++XWwDsPpKE+tkISIYXa
         GZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OG1Z720HiLI9TnXhLnBUmjf5XIxwOfpZr3RRpPSXgXQ=;
        b=HBN9+mx5cP8WJzQuTInsuVymBpWQAodvX34vWZ0xElckP+iGOXjw/JCZtgxjUjJ0Lr
         NZIHKB4VvgnDuw5M+FPwrwP5pG6zdn3i4venPsYdYjkrA7Q25kfVNPDx+rmS2SUqKc4y
         2hvAEBuFRzaHq3sT7nuzFNScy7rrtpdwm8imBL+mg9PMRc9cYsdGYZpIFUnF4HKRvRB2
         T0T9DEWedSS/NTPsDBuK5MHA2rUcQduj9KMYtrOI+5H5vDWeOteZbIXw7oUtzpTqWPVp
         braUi/xrBrd5A9d+ZdlG5z2sjptoru+5r+iGbNMlPsgYRvYrM9pR0Vgqu8xvZpWt8kg1
         h/Yw==
X-Gm-Message-State: AOAM533TVChFNQXCxWSCOc2iMpc0KoYuzE8V4K3CYT+3NCN8IrASkRfC
        mCJhvbp90r/sHriDWrnlpZ0=
X-Google-Smtp-Source: ABdhPJzoppnoztlFXc9Mnu2L51Ulp5+l73hpF4TySI7ZzlwTO/JM1danrGQ+bgtcI06kEfUN4YW+WQ==
X-Received: by 2002:adf:cd01:: with SMTP id w1mr15008526wrm.316.1612706985388;
        Sun, 07 Feb 2021 06:09:45 -0800 (PST)
Received: from mahak-Inspiron-7570 ([103.153.208.42])
        by smtp.gmail.com with ESMTPSA id v5sm2049044wro.71.2021.02.07.06.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:09:44 -0800 (PST)
From:   Mahak Gupta <gmahak1@gmail.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, rcy@google.com, benchan@chromium.org,
        toddpoynor@google.com, rspringer@google.com
Cc:     Mahak Gupta <gmahak1@gmail.com>
Subject: [PATCH] staging: gasket: fix indentation and lines ending with open parenthesis
Date:   Sun,  7 Feb 2021 19:39:28 +0530
Message-Id: <20210207140928.11029-1-gmahak1@gmail.com>
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
 drivers/staging/gasket/gasket_ioctl.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index e3047d36d8db..a966231bad42 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -40,7 +40,7 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
 
 /* Read the size of the page table. */
 static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp)
+				       struct gasket_page_table_ioctl __user *argp)
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
@@ -51,8 +51,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	ibuf.size = gasket_page_table_num_entries(
-		gasket_dev->page_table[ibuf.page_table_index]);
+	ibuf.size = gasket_page_table_num_entries(gasket_dev->page_table[ibuf.page_table_index]);
 
 	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
 					   ibuf.host_address,
@@ -66,7 +65,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 
 /* Read the size of the simple page table. */
 static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp)
+					      struct gasket_page_table_ioctl __user *argp)
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
@@ -92,7 +91,7 @@ static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
 
 /* Set the boundary between the simple and extended page tables. */
 static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp)
+				       struct gasket_page_table_ioctl __user *argp)
 {
 	int ret;
 	struct gasket_page_table_ioctl ibuf;
@@ -107,8 +106,8 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
-	max_page_table_size = gasket_page_table_max_size(
-		gasket_dev->page_table[ibuf.page_table_index]);
+	max_page_table_size = gasket_page_table_max_size
+		(gasket_dev->page_table[ibuf.page_table_index]);
 
 	if (ibuf.size > max_page_table_size) {
 		dev_dbg(gasket_dev->dev,
@@ -119,8 +118,7 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 
 	mutex_lock(&gasket_dev->mutex);
 
-	ret = gasket_page_table_partition(
-		gasket_dev->page_table[ibuf.page_table_index], ibuf.size);
+	ret = gasket_page_table_partition(gasket_dev->page_table[ibuf.page_table_index], ibuf.size);
 	mutex_unlock(&gasket_dev->mutex);
 
 	return ret;
@@ -183,7 +181,7 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
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

