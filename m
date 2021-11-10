Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2B44BA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhKJCAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 21:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJCAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 21:00:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9227C061764;
        Tue,  9 Nov 2021 17:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WxJ7AaomevfmvuBVwAfQsKHxkblqaJGiiptTvJ3ff5s=; b=KOAfIrSqS5nm3e64ocHR6Uew+w
        51Qd6YzKNuiLZ04xXDV+6cyn+2nopw0br4FA0n/Ie/1nwYUAyZxf0GULHNgjuqJ2QIDUuYZIHqBjZ
        7/D9GxqA48v6PVT6p+qbwK13p3KP1SIgMW8+NdsNCKcJDIwmUZ2x/M7jQLFXX4KRW49z2l1T57cMQ
        WJtOhG4MbM2B0+aBytJDcv7MPiMyNDruZ8i1K5UqlgpFJLBg1yvdkpWulAMxj1zTUztZRclSc/aT/
        LH+Yg9+rB2eOeusVZqYAqXklrzZUAlRmDY/8bg44hK6zcyG854HdUzzll53v7et7kAHMtqqHxmfAy
        d1nbQhwA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkcrR-008qQI-8m; Wed, 10 Nov 2021 01:57:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH -next] parisc: stacktrace: add <linux/kernel.h> to prevent build error
Date:   Tue,  9 Nov 2021 17:57:08 -0800
Message-Id: <20211110015708.6512-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stacktrace.c uses __kernel_text_address() so it needs to
include <linux/kernel.h>.  Otherwise there is a build error:

arch/parisc/kernel/stacktrace.c: In function 'walk_stackframe':
arch/parisc/kernel/stacktrace.c:25:21: error: implicit declaration of
function '__kernel_text_address'
[-Werror=implicit-function-declaration]
   25 |                 if (__kernel_text_address(info.ip))

Fixes: aeb1e833a4c3 ("parisc: Switch to ARCH_STACKWALK implementation")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/kernel/stacktrace.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211109.orig/arch/parisc/kernel/stacktrace.c
+++ linux-next-20211109/arch/parisc/kernel/stacktrace.c
@@ -8,6 +8,7 @@
  *
  *  TODO: Userspace stacktrace (CONFIG_USER_STACKTRACE_SUPPORT)
  */
+#include <linux/kernel.h>
 #include <linux/stacktrace.h>
 
 #include <asm/unwind.h>
