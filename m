Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1344F21C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 09:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhKMIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 03:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhKMIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 03:09:13 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D81CC061766;
        Sat, 13 Nov 2021 00:06:18 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636790777;
        bh=CVgak5rLZGWpqYIgRSwjJO+cIS2KYNwHgY4TaH4p39Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Fh+sgQ6toASetZCAKUFNyOjead23zs7No2BcDxv1AhTeTUDxYQgvxj5KTUusF1nKg
         ufPOakrgpox1T5Dt4x+nM7SwyCkwqPy6VhGWRTWfy9moAXlUDHR25gWhO5XB2GP+8w
         CNO7rNYFz8mpDgD5UyJrCY4qB3cG+qw8gCz1JzUQ=
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-wmi-descriptor: disable by default
Date:   Sat, 13 Nov 2021 09:05:51 +0100
Message-Id: <20211113080551.61860-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dell-wmi-descriptor only provides symbols to other drivers.
These drivers already select dell-wmi-descriptor when needed.

This fixes an issue where dell-wmi-descriptor is compiled as a module
with localyesconfig on a non-Dell machine.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/dell/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index 821aba31821c..dbc71a936339 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -187,7 +187,7 @@ config DELL_WMI_AIO
 
 config DELL_WMI_DESCRIPTOR
 	tristate
-	default m
+	default n
 	depends on ACPI_WMI
 
 config DELL_WMI_LED

base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.33.1

