Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C13DCA34
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 07:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhHAFza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 01:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhHAFz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 01:55:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32283C06175F;
        Sat, 31 Jul 2021 22:55:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so15944399plr.13;
        Sat, 31 Jul 2021 22:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7wqEtz/LmEA1yRT6bi97fna/gQALJQeGpTT3SSPXa1M=;
        b=JH6zYfR7GRp07+WRmIEfOWH/4hV1FvxK3iuYH+o016oLkAmY9OgeiuNt4ycC+vi6Ei
         SRhqB5xuB4tBvm3Auh/W4kLaZvIQkUg5kEckBnnpFDs0TdAx+XxDbkz1SXD4RigPE3/b
         3E6YvEO9JntmR5LBQJO+ydKvKrJhHfrOAdASQKmyg3unfwu9CtDSGerSHV7zJTxWbWHm
         dr+S0rtZTBGenRAQSd3DGi3X6xj0TANWgCK0xhNd5UQlg7sOETrORrULXV/QpVug//iJ
         yd7ffnGLz3vJttdZ9Q9O3IPgnvNmxKZDopzCQ3DaCcfS0PkRV2FgS6PshCVP6/HhxBLi
         M5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7wqEtz/LmEA1yRT6bi97fna/gQALJQeGpTT3SSPXa1M=;
        b=TPx67Uvre57dBRBmhRxhwhsLygXLxHo61NhyWgMZ0SyuwQIq7b3oX/32swGBRk1m+J
         CaMPCM9vNZkzms+Caoq8YV9R3QQs8R/pZqIX2ZInC/X4i0Zl02gdBsFfGjMDKz7F2g0R
         JOsMSHCJ9Z+RzvVJFN+upsQL2TNob1Nnz/7oh8JxSYHpxdbCo6X6V5zAY1TE98SSyAmE
         3yZhAh7uTqkJZ19Wwq61AlXtfI2blx7eX2pbynF1Yyow2m41mVKBALeDcViPgPYgIspL
         w7FML4NOIoDvBE7rslfHg4rWVtn0n2EiEgiqIVKIA/0Uss+jxg7bxPvRFIYNCEeArFXW
         PLOA==
X-Gm-Message-State: AOAM5335qD39VKstrNrboLlFhEwuJRqkE8Ettk66tt2o/y0zkUGYOT7u
        6avxfvLlqlBb1/ZJY3NE4lsPQBe57Gvc+x0m
X-Google-Smtp-Source: ABdhPJzABkD1Z6L8QcW4cGGc+a113vnAcmGKoCtyHI8vYQTDpEToPr79fjPq0++ocJ6nGBDQiGOunw==
X-Received: by 2002:a17:90b:4d0b:: with SMTP id mw11mr11670552pjb.122.1627797319382;
        Sat, 31 Jul 2021 22:55:19 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id s22sm7098746pfu.52.2021.07.31.22.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 22:55:19 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] usb: gadget: Fix inconsistent indent
Date:   Sun,  1 Aug 2021 13:54:54 +0800
Message-Id: <20210801055454.53015-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove whitespace and use tab as indent

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/configfs.c      | 8 ++++----
 drivers/usb/gadget/function/f_fs.c | 2 +-
 drivers/usb/gadget/legacy/inode.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 15a607ccef8a..8b73ee30745d 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -55,7 +55,7 @@ struct gadget_info {
 
 static inline struct gadget_info *to_gadget_info(struct config_item *item)
 {
-	 return container_of(to_config_group(item), struct gadget_info, group);
+	return container_of(to_config_group(item), struct gadget_info, group);
 }
 
 struct config_usb_cfg {
@@ -365,21 +365,21 @@ static struct configfs_attribute *gadget_root_attrs[] = {
 
 static inline struct gadget_strings *to_gadget_strings(struct config_item *item)
 {
-	 return container_of(to_config_group(item), struct gadget_strings,
+	return container_of(to_config_group(item), struct gadget_strings,
 			 group);
 }
 
 static inline struct gadget_config_name *to_gadget_config_name(
 		struct config_item *item)
 {
-	 return container_of(to_config_group(item), struct gadget_config_name,
+	return container_of(to_config_group(item), struct gadget_config_name,
 			 group);
 }
 
 static inline struct usb_function_instance *to_usb_function_instance(
 		struct config_item *item)
 {
-	 return container_of(to_config_group(item),
+	return container_of(to_config_group(item),
 			 struct usb_function_instance, group);
 }
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 9c0c393abb39..cc9a11b7fec9 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2081,7 +2081,7 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
 		break;
 
 	case USB_TYPE_CLASS | 0x01:
-                if (*current_class == USB_INTERFACE_CLASS_HID) {
+		if (*current_class == USB_INTERFACE_CLASS_HID) {
 			pr_vdebug("hid descriptor\n");
 			if (length != sizeof(struct hid_descriptor))
 				goto inv_length;
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index cd8e2737947b..539220d7f5b6 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1214,8 +1214,8 @@ dev_release (struct inode *inode, struct file *fd)
 static __poll_t
 ep0_poll (struct file *fd, poll_table *wait)
 {
-       struct dev_data         *dev = fd->private_data;
-       __poll_t                mask = 0;
+	struct dev_data         *dev = fd->private_data;
+	__poll_t                mask = 0;
 
 	if (dev->state <= STATE_DEV_OPENED)
 		return DEFAULT_POLLMASK;
-- 
2.25.1

