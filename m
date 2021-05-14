Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA53380AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhENOCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232397AbhENOCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:02:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5158561461;
        Fri, 14 May 2021 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621000865;
        bh=YBVxDA2n6V12Lg0MDx+EkiBQUWg1cEDOi3hovOPwyRU=;
        h=From:To:Cc:Subject:Date:From;
        b=DJxi/6vLAssmX79AjKCqNcNybte1yFq0SExBZ0p+CY8sOvqBFkK3BRK+FcHOJoEvn
         hiY8ZJph2Z9qckfU/R3neyXLvAhmqLuoYek79SJC1AffwfYqi0n4q9fl3bNNgbOZHU
         HSTC5+GMeZcu4XhHLkRc4kbGxfdkjEXrRPouOdtt3VmSLhGCGt+0LwZtABf087h4kV
         QFC4GYBEb8CIEakXkVGh1Pa8REff0/gutm7nCDzZfQqTOmjMHn0f/nn8YSMkxhccH+
         NyMyFggQHl93St5DeTsLupFiDpXAXiGFPU4yCj5ga/I20NHsW29VMQAeQYxMEowrZk
         xcoHS9oxXtklQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] kcsan: fix debugfs initcall return type
Date:   Fri, 14 May 2021 16:00:08 +0200
Message-Id: <20210514140015.2944744-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang points out that an initcall funciton should return an 'int':

kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
late_initcall(kcsan_debugfs_init);
~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
 #define late_initcall(fn)               __define_initcall(fn, 7)

Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kcsan/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index c1dd02f3be8b..e65de172ccf7 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -266,9 +266,10 @@ static const struct file_operations debugfs_ops =
 	.release = single_release
 };
 
-static void __init kcsan_debugfs_init(void)
+static int __init kcsan_debugfs_init(void)
 {
 	debugfs_create_file("kcsan", 0644, NULL, NULL, &debugfs_ops);
+	return 0;
 }
 
 late_initcall(kcsan_debugfs_init);
-- 
2.29.2

