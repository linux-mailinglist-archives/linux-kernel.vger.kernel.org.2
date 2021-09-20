Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C84411258
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhITJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhITJ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:57:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E51160240;
        Mon, 20 Sep 2021 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632131761;
        bh=UMgc0ypSsQxjI//9tTpmdJQMwxV+y+7dPPyn1NAloNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jK5eEfPFq9arxUMS+0gscszPEiPaDBA6twyL8kDnYc5Nxd57Mt0FdjhPXcZbE7Rwj
         Cg4ZTFD6fTKdyraik9XBQzb/cSIn8bWpGELrN1QzR2bmN0cRK1Ru5Z7+9RQutAC40q
         zJwdMfk9t9ziQp00qFb8Ym+2Uu5lfu4XtY7zc1mZpnW+/9CjYhYJ4cdJx9LH/j4N3x
         Bgl8mHtcy04LpRWoYTfrecgm75nasY2Tb+VlMsgl1B4K26BHkMfDDicVkz+chA1Mk8
         XyY4upQjn1arnPDtuUDlEaTyHez8J1gWMxqM1DXjYUypSY+e1uYaf9hxlXWHYuknRe
         j4H8N/Ka4oEHg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: lg-laptop: Fix possible NULL pointer derefence
Date:   Mon, 20 Sep 2021 11:55:50 +0200
Message-Id: <20210920095556.1175269-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_DMI is disabled, dmi_get_system_info() returns a NULL
pointer, which is now caught by a warning:

In function 'strlen',
    inlined from 'acpi_add.part.0' at drivers/platform/x86/lg-laptop.c:658:6:
include/linux/fortify-string.h:25:33: error: argument 1 null where non-null expected [-Werror=nonnull]
   25 | #define __underlying_strlen     __builtin_strlen
      |                                 ^
include/linux/fortify-string.h:60:24: note: in expansion of macro '__underlying_strlen'
   60 |                 return __underlying_strlen(p);
      |                        ^~~~~~~~~~~~~~~~~~~
drivers/platform/x86/lg-laptop.c: In function 'acpi_add.part.0':
include/linux/fortify-string.h:25:33: note: in a call to built-in function '__builtin_strlen'
   25 | #define __underlying_strlen     __builtin_strlen
      |                                 ^
include/linux/fortify-string.h:60:24: note: in expansion of macro '__underlying_strlen'
   60 |                 return __underlying_strlen(p);
      |                        ^~~~~~~~~~~~~~~~~~~

The code in there does not appear essential, so an explicit
NULL check should be sufficient. The string is also printed
to the console, but printk() is able to handle NULL pointer
arguments gracefully.

Fixes: 8983bfd58d61 ("platform/x86: lg-laptop: Support for battery charge limit on newer models")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/lg-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 3e520d5bca07..88b551caeaaf 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -655,7 +655,7 @@ static int acpi_add(struct acpi_device *device)
 		goto out_platform_registered;
 	}
 	product = dmi_get_system_info(DMI_PRODUCT_NAME);
-	if (strlen(product) > 4)
+	if (product && strlen(product) > 4)
 		switch (product[4]) {
 		case '5':
 		case '6':
-- 
2.29.2

