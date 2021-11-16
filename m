Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD53452C66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhKPIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:09:23 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43065 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231718AbhKPII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:08:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uwq7A-D_1637049960;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Uwq7A-D_1637049960)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 16:06:01 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] x86/lib: Eliminate compilation warnings for misc
Date:   Tue, 16 Nov 2021 16:06:00 +0800
Message-Id: <20211116080600.31082-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following clang compilation warnings by including
necessary header files:

  arch/x86/lib/misc.c:7:5: warning: no previous prototype for function 'num_digits' [-Wmissing-prototypes]
  int num_digits(int val)
      ^
  arch/x86/lib/misc.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  int num_digits(int val)
  ^
  static

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/lib/misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/misc.c b/arch/x86/lib/misc.c
index a018ec4fba53..da8228f65455 100644
--- a/arch/x86/lib/misc.c
+++ b/arch/x86/lib/misc.c
@@ -4,6 +4,8 @@
  *
  * (Typed on and submitted from hpa's mobile phone.)
  */
+#include <asm/misc.h>
+
 int num_digits(int val)
 {
 	int m = 10;
-- 
2.32.0

