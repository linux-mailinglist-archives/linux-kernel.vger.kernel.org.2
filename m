Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7212F43C7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbhJ0Kgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbhJ0Kgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:36:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C2C061767
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d3so3278202wrh.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GEuhmJt1EbG7eS8Znq+HuEo/CA/NDTjfu/Nxazhdm9Y=;
        b=NX/oGmqLbSpHqAFabpzBNDb+3zZB8GnHTluimoJTA3PqE433VoDhBvG1adUZR52HNG
         Qr82xQeUTuPueOdhoR0YT0mnZUhXycM4MF4NSEbNzH5xCywXvmBPaMTjhH3DmmtFO+Fq
         qiRALv1gekguTlQ3oBsE+8jn5ANn+h49MofYlQX/U7by5dFKv98Tv14aBLdpbsypc/PH
         ahqtpbi8/GFt/Ib+3whIymw7tRG7HmuvHxRjoeSEUd/aowlX79xdy0XRUUgRBLw5+uMD
         Txc0yKF7HctqKC5R2JcKR2dfaVZKykie75ZRP3yt/+G8XZZE44eVX8WdU3A3raGoLzNU
         BiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GEuhmJt1EbG7eS8Znq+HuEo/CA/NDTjfu/Nxazhdm9Y=;
        b=8QwNPufjWtO3dKuG10IVvaybFqk+kP3AuxdPBhVI1tTRo2RxmcxvkBKpoMuPQHyfB7
         T0qwO8PG2c5j6PYAr7mNajcNB+pFnSNeDsaM3tfNXY6QfC628k8ED2tpmyEzOtAvboU/
         Pw0LPwhEOpK14moTk7zWv3tjcihdrbQ2w9eg0182gdaK3OaM4ciMjZXd2wmdoINeM8wn
         dAxSCutK5MhSsOmoLJn7fQIIuEezuya5QV9Wn1GBD3f7qbvKMM79T2A+UcIQ2obQmprT
         wQejRUNr5iBjud874DDPv+yQfTkP+1dEGKknSnrv5NnD5dQuVc4kYnY0ao0cBaUOzqYB
         7LlQ==
X-Gm-Message-State: AOAM533oTh3Mk9RMS3EefzdLaHHcj0Qk2UiemuCmVOYHzzIpKbRYs+Qh
        Vd+V7VTMZ7imdsRVlAGdZEQ=
X-Google-Smtp-Source: ABdhPJzWPYfxHa1mpBqlglKHre7xfLAvWd+B/Cwy12NPxDJWKvtN2EajYm8K39U6M7nlGu41QZWWkg==
X-Received: by 2002:adf:a486:: with SMTP id g6mr38845485wrb.130.1635330852262;
        Wed, 27 Oct 2021 03:34:12 -0700 (PDT)
Received: from authentaworks.lxd (ip5f5be9ad.dynamic.kabel-deutschland.de. [95.91.233.173])
        by smtp.gmail.com with ESMTPSA id j10sm7140198wrx.94.2021.10.27.03.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:34:11 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 3/4] mtd: add advanced protection and security ioctls
Date:   Wed, 27 Oct 2021 10:33:51 +0000
Message-Id: <20211027103352.8879-4-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027103352.8879-1-sshivamurthy@micron.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Added new ioctls for advanced protection and security features.
These features are currently supported by new Micron SPI NOR flashes.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/mtdchar.c      | 145 +++++++++++++++++++++++++++++++++++++
 include/uapi/mtd/mtd-abi.h |  11 +++
 2 files changed, 156 insertions(+)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 155e991d9d75..97b97b80276d 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -654,6 +654,16 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	case MTDFILEMODE:
 	case BLKPG:
 	case BLKRRPART:
+	case SECURE_PACKET_READ:
+	case SECURE_PACKET_WRITE:
+	case RD_VLOCK_BITS:
+	case WR_VLOCK_BITS:
+	case RD_NVLOCK_BITS:
+	case WR_NVLOCK_BITS:
+	case ER_NVLOCK_BITS:
+	case RD_GLOBAL_FREEZE_BITS:
+	case WR_GLOBAL_FREEZE_BITS:
+	case RD_PASSWORD:
 		break;
 
 	/* "dangerous" commands */
@@ -1017,6 +1027,141 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		ret = 0;
 		break;
 	}
+	case SECURE_PACKET_READ:
+	{
+		struct mtd_oob_buf buf;
+		u8 *oobbuf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		oobbuf = kmalloc(buf.length, GFP_KERNEL);
+		ret = master->_secure_packet_read(master, buf.length, oobbuf);
+		if (copy_to_user(buf.ptr, oobbuf, buf.length))
+			ret = -EFAULT;
+		break;
+	}
+
+	case SECURE_PACKET_WRITE:
+	{
+		struct mtd_oob_buf buf;
+		u8 *oobbuf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		oobbuf = memdup_user(buf.ptr, buf.length);
+		ret = master->_secure_packet_write(master, buf.length, oobbuf);
+		break;
+	}
+
+	case RD_VLOCK_BITS:
+	{
+		struct mtd_oob_buf buf;
+		u8 *oobbuf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		oobbuf = kmalloc(buf.length, GFP_KERNEL);
+		ret = master->_read_vlock_bits(master, buf.start, buf.length,
+					       oobbuf);
+		if (copy_to_user(buf.ptr, oobbuf, buf.length))
+			ret = -EFAULT;
+		break;
+	}
+
+	case WR_VLOCK_BITS:
+	{
+		struct mtd_oob_buf buf;
+		u8 *oobbuf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		oobbuf = memdup_user(buf.ptr, buf.length);
+		ret = master->_write_vlock_bits(master, buf. start, buf.length,
+						oobbuf);
+		break;
+	}
+
+	case RD_NVLOCK_BITS:
+	{
+		struct mtd_oob_buf buf;
+		u8 *oobbuf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		oobbuf = kmalloc(buf.length, GFP_KERNEL);
+		ret = master->_read_nvlock_bits(master, buf.start, buf.length,
+						oobbuf);
+		if (copy_to_user(buf.ptr, oobbuf, buf.length))
+			ret = -EFAULT;
+		break;
+	}
+
+	case WR_NVLOCK_BITS:
+	{
+		struct mtd_oob_buf buf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		ret = master->_write_nvlock_bits(master, buf.start);
+		break;
+	}
+
+	case ER_NVLOCK_BITS:
+	{
+		ret = master->_erase_nvlock_bits(master);
+		break;
+	}
+
+	case RD_GLOBAL_FREEZE_BITS:
+	{
+		struct mtd_oob_buf buf;
+		u8 *oobbuf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		oobbuf = kmalloc(buf.length, GFP_KERNEL);
+		ret = master->_read_global_freeze_bits(master, buf.length,
+						       oobbuf);
+		if (copy_to_user(buf.ptr, oobbuf, buf.length))
+			ret = -EFAULT;
+		break;
+	}
+
+	case WR_GLOBAL_FREEZE_BITS:
+	{
+		struct mtd_oob_buf buf;
+		u8 *oobbuf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		oobbuf = memdup_user(buf.ptr, buf.length);
+		ret = master->_write_global_freeze_bits(master, buf.length,
+							oobbuf);
+		break;
+	}
+
+	case RD_PASSWORD:
+	{
+		struct mtd_oob_buf buf;
+		u8 *oobbuf;
+
+		if (copy_from_user(&buf, argp, sizeof(buf)))
+			ret = -EFAULT;
+
+		oobbuf = kmalloc(buf.length, GFP_KERNEL);
+		ret = master->_read_password(master, buf.length, oobbuf);
+		if (copy_to_user(buf.ptr, oobbuf, buf.length))
+			ret = -EFAULT;
+		break;
+	}
 	}
 
 	return ret;
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index b869990c2db2..dbd7bf60d484 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -208,6 +208,17 @@ struct otp_info {
 /* Erase a given range of user data (must be in mode %MTD_FILE_MODE_OTP_USER) */
 #define OTPERASE		_IOW('M', 25, struct otp_info)
 
+#define SECURE_PACKET_READ	_IOWR('M', 26, struct mtd_oob_buf)
+#define SECURE_PACKET_WRITE	_IOWR('M', 27, struct mtd_oob_buf)
+#define RD_VLOCK_BITS		_IOWR('M', 28, struct mtd_oob_buf)
+#define WR_VLOCK_BITS		_IOWR('M', 29, struct mtd_oob_buf)
+#define RD_NVLOCK_BITS		_IOWR('M', 30, struct mtd_oob_buf)
+#define WR_NVLOCK_BITS		_IOWR('M', 31, struct mtd_oob_buf)
+#define ER_NVLOCK_BITS		_IO('M', 32)
+#define RD_GLOBAL_FREEZE_BITS	_IOWR('M', 33, struct mtd_oob_buf)
+#define WR_GLOBAL_FREEZE_BITS	_IOWR('M', 34, struct mtd_oob_buf)
+#define RD_PASSWORD		_IOWR('M', 35, struct mtd_oob_buf)
+
 /*
  * Obsolete legacy interface. Keep it in order not to break userspace
  * interfaces
-- 
2.25.1

