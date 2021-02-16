Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11E31D23C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhBPVjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPVjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:39:47 -0500
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Feb 2021 13:39:02 PST
Received: from gmmr3.centrum.cz (gmmr3.centrum.cz [IPv6:2a00:da80:0:502::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 691F8C061574;
        Tue, 16 Feb 2021 13:39:02 -0800 (PST)
Received: from gmmr-1.centrum.cz (unknown [10.255.254.26])
        by gmmr3.centrum.cz (Postfix) with ESMTP id 4BB2B18009BD1;
        Tue, 16 Feb 2021 22:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
        t=1613511375; bh=BOQwvYaKx+mwGwDldsCzFpXiNGdtuG61UIvQL5tA15M=;
        h=Date:From:To:Cc:Subject:From;
        b=JfMehplcrYvrRZwr+9Dyc38b0a+oQfLg1AUCcxEnAjz9CLLmpQj2FRZM0fqxTKTkF
         A3A6DEKtssRnk9+KBc14qOOk5W/DnquYZRIeEAhNbYRy47jHPLRJ7wDWwBX8bWFu/E
         y15OsPI1ho+S4ZpSfv29Dz5nxpvoJx7U7ixpSH54=
Received: from vm2.excello.cz (vm2.excello.cz [IPv6:2001:67c:15a0:4000::b])
        by gmmr-1.centrum.cz (Postfix) with QMQP
        id 49C8130007702; Tue, 16 Feb 2021 22:36:15 +0100 (CET)
Received: from vm2.excello.cz by vm2.excello.cz
 (VF-Scanner: Clear:RC:0(2a00:da80:0:502::7):SC:0(-2.8/5.0):CC:0:;
 processed in 0.3 s); 16 Feb 2021 21:36:15 +0000
X-VF-Scanner-ID: 20210216213615.027371.571.vm2.excello.cz.0
Received: from gmmr-1.centrum.cz (2a00:da80:0:502::7)
  by out1.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 16 Feb 2021 22:36:15 +0100
Received: from gm-smtp11.centrum.cz (unknown [10.255.254.29])
        by gmmr-1.centrum.cz (Postfix) with ESMTP id F34E82005DD88;
        Tue, 16 Feb 2021 22:36:14 +0100 (CET)
Received: from arkam (unknown [78.45.77.139])
        by gm-smtp11.centrum.cz (Postfix) with ESMTPA id D278618054D25;
        Tue, 16 Feb 2021 22:36:14 +0100 (CET)
Date:   Tue, 16 Feb 2021 22:36:13 +0100
From:   Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
Subject: [PATCH] platform/x86: fix typo in Kconfig
Message-ID: <YCw6zavnfeHRGWgr@arkam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uses by -> used by

Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 91e6176cdfbd..94f2f05bc133 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1372,7 +1372,7 @@ config INTEL_PMT_CLASS
 	tristate "Intel Platform Monitoring Technology (PMT) Class driver"
 	help
 	  The Intel Platform Monitoring Technology (PMT) class driver provides
-	  the basic sysfs interface and file hierarchy uses by PMT devices.
+	  the basic sysfs interface and file hierarchy used by PMT devices.
 
 	  For more information, see:
 	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
-- 
2.26.2

