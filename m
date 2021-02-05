Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BCC31116A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhBEP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhBEPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:25:33 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21BBC06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:06:13 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id RV6A240054C55Sk06V6A3q; Fri, 05 Feb 2021 18:06:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l84Yb-003VWh-O8; Fri, 05 Feb 2021 18:06:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l84Yb-008Cuk-21; Fri, 05 Feb 2021 18:06:09 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH trivial] device.h: Remove bogus "the" in kerneldoc
Date:   Fri,  5 Feb 2021 18:06:08 +0100
Message-Id: <20210205170608.1956223-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the bogus word "the" from "...once the it is..." in the
documentation describing the "dev_groups" member of the device_driver
structure.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/device/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index ee7ba5b5417e5105..a498ebcf49933d30 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -75,7 +75,7 @@ enum probe_type {
  * @resume:	Called to bring a device from sleep mode.
  * @groups:	Default attributes that get created by the driver core
  *		automatically.
- * @dev_groups:	Additional attributes attached to device instance once the
+ * @dev_groups:	Additional attributes attached to device instance once
  *		it is bound to the driver.
  * @pm:		Power management operations of the device which matched
  *		this driver.
-- 
2.25.1

