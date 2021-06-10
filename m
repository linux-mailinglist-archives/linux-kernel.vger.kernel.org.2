Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48293A287D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFJJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:40:10 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50576 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229935AbhFJJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:40:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uby7ylP_1623317889;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Uby7ylP_1623317889)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jun 2021 17:38:10 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nathan@kernel.org, ndesaulniers@google.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] selinux: Fix kernel-doc
Date:   Thu, 10 Jun 2021 17:38:03 +0800
Message-Id: <1623317883-54209-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in ss/services.c kernel-doc comment
to remove a warning found by running make W=1 LLVM=1.

security/selinux/ss/services.c:2437: warning: expecting prototype for
security_pkey_sid(). Prototype was for security_ib_pkey_sid() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3658488..bb043bf 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2423,7 +2423,7 @@ int security_port_sid(struct selinux_state *state,
 }
 
 /**
- * security_pkey_sid - Obtain the SID for a pkey.
+ * security_ib_pkey_sid - Obtain the SID for a pkey.
  * @subnet_prefix: Subnet Prefix
  * @pkey_num: pkey number
  * @out_sid: security identifier
-- 
1.8.3.1

