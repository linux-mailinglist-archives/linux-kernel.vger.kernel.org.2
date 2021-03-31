Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B47347212
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhCXHJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:09:56 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:14034 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhCXHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:09:50 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 74C14980276;
        Wed, 24 Mar 2021 15:09:46 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: lightnvm: Remove duplicate include
Date:   Wed, 24 Mar 2021 15:09:21 +0800
Message-Id: <20210324070921.736874-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk9OTk0eQ04YGRhOVkpNSk1OTUJMQ01NTkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Qhw*CD8IODgSTyEyPj0Z
        PxJPCSxVSlVKTUpNTk1CTENMTkpDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0pONwY+
X-HM-Tid: 0a78631160d0d992kuws74c14980276
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ifdef CONFIG_NVM, linux/blkdev.h and uapi/linux/lightnvm.h
would be included twice. So remove them.
By the way, I find that struct nvm_rq is declared twice. 
If removing the duplicated declaration really makes sense, it would 
be much clean up work to do in inlude/linux.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/lightnvm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 1db223710b28..1ddb41ee71eb 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -112,10 +112,8 @@ struct nvm_dev_ops {
 
 #ifdef CONFIG_NVM
 
-#include <linux/blkdev.h>
 #include <linux/file.h>
 #include <linux/dmapool.h>
-#include <uapi/linux/lightnvm.h>
 
 enum {
 	/* HW Responsibilities */
@@ -276,7 +274,6 @@ struct nvm_target {
 
 #define NVM_MAX_VLBA (64) /* max logical blocks in a vector command */
 
-struct nvm_rq;
 typedef void (nvm_end_io_fn)(struct nvm_rq *);
 
 struct nvm_rq {
-- 
2.25.1

