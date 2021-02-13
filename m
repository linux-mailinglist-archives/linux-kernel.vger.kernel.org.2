Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC18C31AD45
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBMQwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhBMQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:52:47 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A9C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:52:07 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id i3so3293149oif.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gc4FZQoLFpjrjBvJ5zV+ImqklQ0xOESHz74DuFiIHsQ=;
        b=IJc6s7RnxywqkaHHKfqNpelipqAsA6UxO0E7+Zul8oNEFLWqa/GhkRPV+O3LOm6MwE
         T/5T0JwcezmFv7soctyMOxOQkoL5NeADH+EwzLEGXL6hOn+8z6QvWZ5AfP+LE0rYw3ZU
         QmtVrKr8r2LZ0imwens5ke9KAWi4e1XmAJ52zQ0EgVi3BzKOG5MtHg213ScvqYQBVf4k
         zzYY6ITsJEcahMhJJuSUHGLo142bZHHvRAJ9yi6MwJIaglGV0HawBPdnGm0g66kVV13o
         np03stm29+SBYZDuLJH4Je4yQxurKc7zakuZ+/bpoVYvNlkzEEgyputQ8SL6MgoFMDiz
         iJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gc4FZQoLFpjrjBvJ5zV+ImqklQ0xOESHz74DuFiIHsQ=;
        b=NJX9CX+AHw1wNTtBmsKiqcWCLFRN2dDzm5Ra5lf2qR3jwV0KkfOoPRm7WenyIlpjSF
         /9A+bO0j7iJUZzwpydRdY6x+A/EShwn0NJsfYaMsF3V+43Ihuf+UKuUnbgLEQg1n/30b
         DlyC9p/T5xoogqVdCB18yCcm5a1jUIMhWulFb8cr069SXbKJInhhayklPt1FAYrDwMhP
         GY7YtLACQKTfv+sDnMq263vaGYIjKq1m93dEJOKtjsZjS5gbLMzRBWMBdFca8Me6YJwK
         Pd57a7o0X7Avmy85vcJngyGcMe/3SmhdciyqvoX0CI704huYRMp8/JVgfPaU4gw1qcp6
         6scQ==
X-Gm-Message-State: AOAM531dw0JIrFG0hr4Y2D2nmubqgmje88DVsKbcqZB+TwhFEG5hgxd8
        5Q/bP99658nXHkqtHKly7RW+h1kk32zi4w==
X-Google-Smtp-Source: ABdhPJwKudWopUJfjFHzJEHBg/99AA9kH0i+C64AaIBO41PqvohhUuBvR51iyIaOkEwkQDDpMbWGhQ==
X-Received: by 2002:a17:90a:f2d3:: with SMTP id gt19mr7774206pjb.212.1613234804489;
        Sat, 13 Feb 2021 08:46:44 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id p8sm12643984pgi.21.2021.02.13.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:46:44 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 1/8] mtd: Add helper macro for register_mtd_blktrans boilerplate
Date:   Sun, 14 Feb 2021 00:45:53 +0800
Message-Id: <20210213164600.409061-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210213164600.409061-1-zhengdejin5@gmail.com>
References: <20210213164600.409061-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the module_mtd_blktrans macro which is a convenience
macro for mtd blktrans modules similar to module_platform_driver.
It is intended to be used by drivers which init/exit section does nothing
but register/unregister the mtd blktrans driver. By using this macro it is
possible to eliminate a few lines of boilerplate code per mtd blktrans
driver.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 include/linux/mtd/blktrans.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index 3c668cb1e344..15cc9b95e32b 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -77,5 +77,16 @@ extern int add_mtd_blktrans_dev(struct mtd_blktrans_dev *dev);
 extern int del_mtd_blktrans_dev(struct mtd_blktrans_dev *dev);
 extern int mtd_blktrans_cease_background(struct mtd_blktrans_dev *dev);
 
+/**
+ * module_mtd_blktrans() - Helper macro for registering a mtd blktrans driver
+ * @__mtd_blktrans: mtd_blktrans_ops struct
+ *
+ * Helper macro for mtd blktrans drivers which do not do anything special in
+ * module init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_mtd_blktrans(__mtd_blktrans) \
+	module_driver(__mtd_blktrans, register_mtd_blktrans, \
+					deregister_mtd_blktrans)
 
 #endif /* __MTD_TRANS_H__ */
-- 
2.25.0

