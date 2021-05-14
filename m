Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC9381415
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 01:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhENXIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 19:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234260AbhENXIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 19:08:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC2F6141F;
        Fri, 14 May 2021 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621033644;
        bh=kdqOL4iQVo27Z0kfmacTASJPX46YUz2HxoUSG7Gn1h4=;
        h=Date:From:To:Cc:Subject:From;
        b=rmzIlXcaKQpTEvi5twpHcJG6NufDl0HwzfWVgJd++m5+OBENXqosBigYVx0JzR4h+
         9OMFIN01K7M5GiyqarXxV2Samjz58MzVB05ER24I1hbggsZZuaK9HiJrXtDuz+hSnL
         yt7cGTTFrZzsYaVlr9tQWr+qCwQhFuH/B3V8lBQIRU96eJbI4HVNOIz+eIEHUgC0rz
         59dhJrH0vbL8XH3gcrZ+NfV8hIYNoskzp4t129IEW4ztA/OJjkHap4UPEdhdegPvP+
         3E4BnPebtJULkqgppYGai7+2rux1srmwUVnExADa4OMTAAMash9DFH6FhYHsShRwMV
         ia6j5duzTl4vg==
Date:   Fri, 14 May 2021 18:08:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] misc: bcm-vk: Replace zero-length array with flexible
 array member
Message-ID: <20210514230801.GA35863@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

Also, make use of the struct_size() helper in kzalloc().

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/misc/bcm-vk/bcm_vk_msg.c | 3 +--
 drivers/misc/bcm-vk/bcm_vk_msg.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index f40cf08a6192..6efc52b49af6 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -701,8 +701,7 @@ int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, u32 shut_type,
 		return -EINVAL;
 	}
 
-	entry = kzalloc(sizeof(*entry) +
-			sizeof(struct vk_msg_blk), GFP_KERNEL);
+	entry = kzalloc(struct_size(entry, to_v_msg, 1), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
 
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.h b/drivers/misc/bcm-vk/bcm_vk_msg.h
index 4eaad84825d6..56784c8896d8 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.h
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.h
@@ -116,7 +116,7 @@ struct bcm_vk_wkent {
 	u32 usr_msg_id;
 	u32 to_v_blks;
 	u32 seq_num;
-	struct vk_msg_blk to_v_msg[0];
+	struct vk_msg_blk to_v_msg[];
 };
 
 /* queue stats counters */
-- 
2.27.0

