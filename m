Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2375B38AFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbhETNKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243452AbhETNKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:10:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9BF5611AD;
        Thu, 20 May 2021 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621516128;
        bh=CYa2LOxXf2LsBJRTZ1TMDFLX33gaa2nHIfU3Y70KYV0=;
        h=From:To:Cc:Subject:Date:From;
        b=vy1yyce97swvOVF3gLcl6soN1haSydmCZiUxwwENrENgCjqSib8DrYNuFQsE56DM/
         jphpGaFb+AvEfEEg0HFNvYsy/DM31oQkV/hS7DQ0DJaZ2hfYCyjQ56IH5+6QGw7x8s
         9mtn/ySgAm28GkVQnGi3UQhi3vJzhnTupVieF5q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: [PATCH] kgdb: fix gcc-11 warnings harder
Date:   Thu, 20 May 2021 15:08:39 +0200
Message-Id: <20210520130839.51987-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

40cc3a80bb42 ("kgdb: fix gcc-11 warning on indentation") tried to fix up
the gcc-11 complaints in this file by just reformatting the #defines.
That worked for gcc 11.1.0, but in gcc 11.1.1 as shipped by Fedora 34,
the warning came back for one of the #defines.

Fix this up again by putting { } around the if statement, now it is
quiet again.

Fixes: 40cc3a80bb42 ("kgdb: fix gcc-11 warning on indentation")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/kgdbts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 64d33e368509..67c5b452dd35 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -101,8 +101,9 @@
 		printk(KERN_INFO a);	\
 } while (0)
 #define v2printk(a...) do {		\
-	if (verbose > 1)		\
+	if (verbose > 1) {		\
 		printk(KERN_INFO a);	\
+	}				\
 	touch_nmi_watchdog();		\
 } while (0)
 #define eprintk(a...) do {		\
-- 
2.31.1

