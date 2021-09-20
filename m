Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8345C410FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhITHD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhITHD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:03:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5194AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:02:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i25so64008267lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwX463CfZcgcAEGDKTQtHmIWmuhaxRyDNTp5tk3A/KU=;
        b=D57tUjfGKE06ipxPR5P/669BPlTAG/z2zkLzGnL3jZeR2GBp0t6GEGgEjHty2YJUUg
         0gYq3WVTJ3Ajki7NEG+gPcw/DR2hDbW9CPF75MYRygBkLvLEOMrJpjZ7hvtKSE14n04A
         5W3vtJCEiHdEWh8XzAjifehywwocmQUQ5fpSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwX463CfZcgcAEGDKTQtHmIWmuhaxRyDNTp5tk3A/KU=;
        b=EW0RNfGBrS6JIbIljHvoxqoKziqvb6Gn3sA5/dw5uPEpJL2+vE5XXgp/2bC1jNqgC2
         GBKWIc1l5U714QZ73N1Dx87DYKKZ6iFYGP2WJfDQRELwpU35ETkSXxDHwA3D9u32ZgeA
         AfoO44te2l0rpyBPJfAUCu8sUCMcwddVXJD+UpsZLJO3M641Db4/+XsMwtN6azSG8O1F
         pMRT9xKnot3sdbijZeps6/4uV78LN4Y12/KWwAQpuW29xvcMrpTXdy16jq8MHAS5FfbY
         WfOYmX3/VMOmuLETVU9rsO/rfZ3oO/3W6eEBEscm56PEwGpF3H1Ghwj9XMcg19gC3C+5
         ShCQ==
X-Gm-Message-State: AOAM531Ptg/4PTcw5rZNe6allAP+681ucmVsPtgdeG2IgnygnkvG4a1R
        bfJCIL5psAQmnBcWdNVMn/SJWQ==
X-Google-Smtp-Source: ABdhPJytlcqh48wCpOcBvVgtRr+vTQplqLvN+bYsTDdT2/dyjBZAlfjsHQtBMBXBO3l1MXzbh+4sIw==
X-Received: by 2002:a2e:a36c:: with SMTP id i12mr21816389ljn.427.1632121348630;
        Mon, 20 Sep 2021 00:02:28 -0700 (PDT)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id s30sm1286415lfb.90.2021.09.20.00.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:02:27 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: add MEMREAD ioctl
Date:   Mon, 20 Sep 2021 09:02:21 +0200
Message-Id: <20210920070221.10173-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User-space applications making use of MTD devices via /dev/mtd*
character devices currently have limited capabilities for reading data:

  - only deprecated methods of accessing OOB layout information exist,

  - there is no way to explicitly specify MTD operation mode to use; it
    is auto-selected based on the MTD file mode (MTD_FILE_MODE_*) set
    for the character device; in particular, this prevents using
    MTD_OPS_AUTO_OOB for reads,

  - all existing user-space interfaces which cause mtd_read() or
    mtd_read_oob() to be called (via mtdchar_read() and
    mtdchar_read_oob(), respectively) return success even when those
    functions return -EUCLEAN or -EBADMSG; this renders user-space
    applications using these interfaces unaware of any corrected
    bitflips or uncorrectable ECC errors detected during reads.

Note that the existing MEMWRITE ioctl allows the MTD operation mode to
be explicitly set, allowing user-space applications to write page data
and OOB data without requiring them to know anything about the OOB
layout of the MTD device they are writing to (MTD_OPS_AUTO_OOB).  Also,
the MEMWRITE ioctl does not mangle the return value of mtd_write_oob().

Add a new ioctl, MEMREAD, which addresses the above issues.  It is
intended to be a read-side counterpart of the existing MEMWRITE ioctl.

Update include/uapi/mtd/mtd-abi.h accordingly.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
This patch is a shameless calque^W^W^Wheavily inspired by MEMWRITE code,
so quite a lot of copy-pasting happened.  I guess it is somewhat
expected when adding a read-side counterpart of existing code which
takes care of writes, but please excuse me if I went too far.

Note that "scripts/checkpatch.pl --strict" returns two alignment
warnings for this patch.  Given that existing code triggers the same
warnings, I assumed that local consistency trumps checkpatch.pl's
complaints.

 drivers/mtd/mtdchar.c      | 60 ++++++++++++++++++++++++++++++++++++++
 include/uapi/mtd/mtd-abi.h | 43 +++++++++++++++++++++++----
 2 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 155e991d9d75..92e0024bdcf7 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -621,6 +621,58 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 	return ret;
 }
 
+static int mtdchar_read_ioctl(struct mtd_info *mtd,
+		struct mtd_read_req __user *argp)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+	struct mtd_read_req req;
+	struct mtd_oob_ops ops = {};
+	void __user *usr_data, *usr_oob;
+	int ret;
+
+	if (copy_from_user(&req, argp, sizeof(req)))
+		return -EFAULT;
+
+	usr_data = (void __user *)(uintptr_t)req.usr_data;
+	usr_oob = (void __user *)(uintptr_t)req.usr_oob;
+
+	if (!master->_read_oob)
+		return -EOPNOTSUPP;
+	ops.mode = req.mode;
+	ops.len = (size_t)req.len;
+	ops.ooblen = (size_t)req.ooblen;
+	ops.ooboffs = 0;
+
+	if (usr_data) {
+		ops.datbuf = kmalloc(ops.len, GFP_KERNEL);
+		if (IS_ERR(ops.datbuf))
+			return PTR_ERR(ops.datbuf);
+	} else {
+		ops.datbuf = NULL;
+	}
+
+	if (usr_oob) {
+		ops.oobbuf = kmalloc(ops.ooblen, GFP_KERNEL);
+		if (IS_ERR(ops.oobbuf)) {
+			kfree(ops.datbuf);
+			return PTR_ERR(ops.oobbuf);
+		}
+	} else {
+		ops.oobbuf = NULL;
+	}
+
+	ret = mtd_read_oob(mtd, (loff_t)req.start, &ops);
+
+	if (copy_to_user(usr_data, ops.datbuf, ops.retlen) ||
+	    copy_to_user(usr_oob, ops.oobbuf, ops.oobretlen))
+		ret = -EFAULT;
+
+	kfree(ops.datbuf);
+	kfree(ops.oobbuf);
+
+	return ret;
+}
+
 static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 {
 	struct mtd_file_info *mfi = file->private_data;
@@ -643,6 +695,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	case MEMGETINFO:
 	case MEMREADOOB:
 	case MEMREADOOB64:
+	case MEMREAD:
 	case MEMISLOCKED:
 	case MEMGETOOBSEL:
 	case MEMGETBADBLOCK:
@@ -817,6 +870,13 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		break;
 	}
 
+	case MEMREAD:
+	{
+		ret = mtdchar_read_ioctl(mtd,
+		      (struct mtd_read_req __user *)arg);
+		break;
+	}
+
 	case MEMLOCK:
 	{
 		struct erase_info_user einfo;
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index b869990c2db2..337e6e597fad 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -55,9 +55,9 @@ struct mtd_oob_buf64 {
  * @MTD_OPS_RAW:	data are transferred as-is, with no error correction;
  *			this mode implies %MTD_OPS_PLACE_OOB
  *
- * These modes can be passed to ioctl(MEMWRITE) and are also used internally.
- * See notes on "MTD file modes" for discussion on %MTD_OPS_RAW vs.
- * %MTD_FILE_MODE_RAW.
+ * These modes can be passed to ioctl(MEMWRITE) and ioctl(MEMREAD); they are
+ * also used internally. See notes on "MTD file modes" for discussion on
+ * %MTD_OPS_RAW vs. %MTD_FILE_MODE_RAW.
  */
 enum {
 	MTD_OPS_PLACE_OOB = 0,
@@ -91,6 +91,32 @@ struct mtd_write_req {
 	__u8 padding[7];
 };
 
+/**
+ * struct mtd_read_req - data structure for requesting a read operation
+ *
+ * @start:	start address
+ * @len:	length of data buffer
+ * @ooblen:	length of OOB buffer
+ * @usr_data:	user-provided data buffer
+ * @usr_oob:	user-provided OOB buffer
+ * @mode:	MTD mode (see "MTD operation modes")
+ * @padding:	reserved, must be set to 0
+ *
+ * This structure supports ioctl(MEMREAD) operations, allowing data and/or OOB
+ * reads in various modes. To read from OOB-only, set @usr_data == NULL, and to
+ * read data-only, set @usr_oob == NULL. However, setting both @usr_data and
+ * @usr_oob to NULL is not allowed.
+ */
+struct mtd_read_req {
+	__u64 start;
+	__u64 len;
+	__u64 ooblen;
+	__u64 usr_data;
+	__u64 usr_oob;
+	__u8 mode;
+	__u8 padding[7];
+};
+
 #define MTD_ABSENT		0
 #define MTD_RAM			1
 #define MTD_ROM			2
@@ -207,6 +233,12 @@ struct otp_info {
 #define MEMWRITE		_IOWR('M', 24, struct mtd_write_req)
 /* Erase a given range of user data (must be in mode %MTD_FILE_MODE_OTP_USER) */
 #define OTPERASE		_IOW('M', 25, struct otp_info)
+/*
+ * Most generic read interface; can read in-band and/or out-of-band in various
+ * modes (see "struct mtd_read_req"). This ioctl is not supported for flashes
+ * without OOB, e.g., NOR flash.
+ */
+#define MEMREAD			_IOWR('M', 26, struct mtd_read_req)
 
 /*
  * Obsolete legacy interface. Keep it in order not to break userspace
@@ -270,8 +302,9 @@ struct mtd_ecc_stats {
  * Note: %MTD_FILE_MODE_RAW provides the same functionality as %MTD_OPS_RAW -
  * raw access to the flash, without error correction or autoplacement schemes.
  * Wherever possible, the MTD_OPS_* mode will override the MTD_FILE_MODE_* mode
- * (e.g., when using ioctl(MEMWRITE)), but in some cases, the MTD_FILE_MODE is
- * used out of necessity (e.g., `write()', ioctl(MEMWRITEOOB64)).
+ * (e.g., when using ioctl(MEMWRITE) or ioctl(MEMREAD)), but in some cases, the
+ * MTD_FILE_MODE is used out of necessity (e.g., `write()',
+ * ioctl(MEMWRITEOOB64)).
  */
 enum mtd_file_modes {
 	MTD_FILE_MODE_NORMAL = MTD_OTP_OFF,
-- 
2.33.0

