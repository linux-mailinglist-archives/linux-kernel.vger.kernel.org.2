Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C00339DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 12:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhCML5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 06:57:35 -0500
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:60720 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCML5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 06:57:10 -0500
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Mar 2021 06:57:10 EST
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id 179B5540216;
        Sat, 13 Mar 2021 19:50:18 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] umh: fix some spelling mistakes
Date:   Sat, 13 Mar 2021 03:48:59 -0800
Message-Id: <1615636139-4076-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTRkZTxlISR9CTEpKVkpNSk5NSE1JSkNKTExVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PiI6Lxw5Ej8WA1ExMzA#Ezc4
        LiNPCRdVSlVKTUpOTUhNSUpDTk1LVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlPSUo3Bg++
X-HM-Tid: 0a782b6c4127d995kuws179b5540216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling mistakes, and modify the order of the parameter
comments to be consistent with the order of the parameters passed
to the function.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 kernel/umh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index 3f64661..3a337a5 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -336,8 +336,8 @@ static void helper_unlock(void)
  * @argv: arg vector for process
  * @envp: environment for process
  * @gfp_mask: gfp mask for memory allocation
- * @cleanup: a cleanup function
  * @init: an init function
+ * @cleanup: a cleanup function
  * @data: arbitrary context sensitive data
  *
  * Returns either %NULL on allocation failure, or a subprocess_info
@@ -348,7 +348,7 @@ static void helper_unlock(void)
  * exec.  A non-zero return code causes the process to error out, exit,
  * and return the failure to the calling process
  *
- * The cleanup function is just before ethe subprocess_info is about to
+ * The cleanup function is just before the subprocess_info is about to
  * be freed.  This can be used for freeing the argv and envp.  The
  * Function must be runnable in either a process context or the
  * context in which call_usermodehelper_exec is called.
@@ -384,7 +384,7 @@ EXPORT_SYMBOL(call_usermodehelper_setup);
 
 /**
  * call_usermodehelper_exec - start a usermode application
- * @sub_info: information about the subprocessa
+ * @sub_info: information about the subprocess
  * @wait: wait for the application to finish and return status.
  *        when UMH_NO_WAIT don't wait at all, but you get no useful error back
  *        when the program couldn't be exec'ed. This makes it safe to call
-- 
2.7.4

