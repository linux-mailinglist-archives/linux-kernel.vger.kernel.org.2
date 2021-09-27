Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1B4196AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhI0Otx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234864AbhI0Ots (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:49:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6231604DC;
        Mon, 27 Sep 2021 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632754090;
        bh=0DBzSgWK5LF6Qt4sOIW1vtQh+POtPnCJ29sz4523Ckw=;
        h=From:To:Cc:Subject:Date:From;
        b=P5ZbKNKeM87fyRR6uZqqV9jjdRPWb8eks/bGJ5SzWtQFrqn5pPDYqiPdssaxoXb54
         8bwVuO6AMWDIk1u1mdtfq/4RiNp/HLCuaYOqbxKhshyP19LCY0EAMDW2P9r7K28SAh
         9iakllMLaGfOF0UtYK7fgmK4uFxWDIjSvWYunJTshTtTjo+l0th5HYyeLYtZ2Htl5h
         b9wM+QqwdyPRBuMeX810G09xqhOe6CDehklfUaZdeVdZxYAJ9m3/gfPnpCHUdI+/L5
         oJhQ0JfoHLdzJGFubp9vSWFxoSnJaLwz0to4ghOoNKkT2vEHEM51pjv5JWoYPlBlaj
         ZeJA3iq1w0Zog==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] firewire: fix function type cast warning
Date:   Mon, 27 Sep 2021 16:47:55 +0200
Message-Id: <20210927144807.2759586-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra complains about a suspicious cast:

rivers/firewire/core-cdev.c:985:8: warning: cast between incompatible function types from ‘void (*)(struct fw_iso_context *, dma_addr_t,  void *)’ {aka ‘void (*)(struct fw_iso_context *, long long unsigned int,  void *)’} to ‘void (*)(struct fw_iso_context *, u32,  size_t,  void *, void *)’ {aka ‘void (*)(struct fw_iso_context *, unsigned int,  long unsigned int,  void *, void *)’} [-Wcast-function-type]

The behavior is correct in the end, but this is more clearly
expressed using a transparent union.

Fixes: 872e330e3880 ("firewire: add isochronous multichannel reception")
Link: https://lore.kernel.org/lkml/20200530090839.7895-1-oscar.carter@gmx.com/
Link: https://lore.kernel.org/all/20210924105733.GA78013@embeddedor/
Link: https://lore.kernel.org/all/20201026215138.3893732-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
At least three people have submitted a version of this patch, but none
of them has made it into the kernel. I don't care which version gets
picked up, but I think we want it to get fixed.
---
 drivers/firewire/core-cdev.c |  6 +++---
 drivers/firewire/core-iso.c  |  2 +-
 include/linux/firewire.h     | 17 ++++++++---------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index fb6c651214f3..8d85d52b02ca 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -970,7 +970,7 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 		if (a->speed > SCODE_3200 || a->channel > 63)
 			return -EINVAL;
 
-		cb = iso_callback;
+		cb.sc = iso_callback;
 		break;
 
 	case FW_ISO_CONTEXT_RECEIVE:
@@ -978,11 +978,11 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 		    a->channel > 63)
 			return -EINVAL;
 
-		cb = iso_callback;
+		cb.sc = iso_callback;
 		break;
 
 	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
-		cb = (fw_iso_callback_t)iso_mc_callback;
+		cb.mc = iso_mc_callback;
 		break;
 
 	default:
diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index af70e74f9a7e..ddada648775a 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -145,7 +145,7 @@ struct fw_iso_context *fw_iso_context_create(struct fw_card *card,
 	ctx->channel = channel;
 	ctx->speed = speed;
 	ctx->header_size = header_size;
-	ctx->callback.sc = callback;
+	ctx->callback = callback;
 	ctx->callback_data = callback_data;
 
 	return ctx;
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index aec8f30ab200..59b5e02a6d42 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -431,11 +431,13 @@ void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer, struct fw_card *card);
 size_t fw_iso_buffer_lookup(struct fw_iso_buffer *buffer, dma_addr_t completed);
 
 struct fw_iso_context;
-typedef void (*fw_iso_callback_t)(struct fw_iso_context *context,
-				  u32 cycle, size_t header_length,
-				  void *header, void *data);
-typedef void (*fw_iso_mc_callback_t)(struct fw_iso_context *context,
-				     dma_addr_t completed, void *data);
+typedef union {
+	void (*sc)(struct fw_iso_context *context, u32 cycle,
+		   size_t header_length, void *header, void *data);
+	void (*mc)(struct fw_iso_context *context, dma_addr_t completed,
+		   void *data);
+} __attribute__ ((__transparent_union__)) fw_iso_callback_t;
+
 struct fw_iso_context {
 	struct fw_card *card;
 	int type;
@@ -443,10 +445,7 @@ struct fw_iso_context {
 	int speed;
 	bool drop_overflow_headers;
 	size_t header_size;
-	union {
-		fw_iso_callback_t sc;
-		fw_iso_mc_callback_t mc;
-	} callback;
+	fw_iso_callback_t callback;
 	void *callback_data;
 };
 
-- 
2.29.2

