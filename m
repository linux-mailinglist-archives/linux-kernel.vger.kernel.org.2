Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A167932BE4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385517AbhCCRUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383004AbhCCNjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:39:35 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6146AC0617A9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:38:50 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:cd47:42a6:c822:e50b])
        by baptiste.telenet-ops.be with bizsmtp
        id bpeo240064huzR801peouU; Wed, 03 Mar 2021 14:38:48 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lHRiB-004Q0l-Ky; Wed, 03 Mar 2021 14:38:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lHRiA-00GWpc-U6; Wed, 03 Mar 2021 14:38:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] docs: driver-model: device: Add DEVICE_ATTR_{RO,RW} examples
Date:   Wed,  3 Mar 2021 14:38:44 +0100
Message-Id: <20210303133845.3939403-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303133845.3939403-1-geert+renesas@glider.be>
References: <20210303133845.3939403-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus.rst, driver.rst, and hwmon-kernel-api.rst refer to the
DEVICE_ATTR_* macros for devices, but device.rst does not mention them.

Add a paragraph about these helper macros, and use them in the examples.
Retain the old description, as it is still useful for less common values
of mode.  Change the names of the example "show" and "store" methods, to
match the expectations of the DEVICE_ATTR_* macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/driver-api/driver-model/device.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/driver-model/device.rst b/Documentation/driver-api/driver-model/device.rst
index b9b022371e856e83..41c819fafd9c1aee 100644
--- a/Documentation/driver-api/driver-model/device.rst
+++ b/Documentation/driver-api/driver-model/device.rst
@@ -63,8 +63,14 @@ Attributes are declared using a macro called DEVICE_ATTR::
 
 Example:::
 
-  static DEVICE_ATTR(type, 0444, show_type, NULL);
-  static DEVICE_ATTR(power, 0644, show_power, store_power);
+  static DEVICE_ATTR(type, 0444, type_show, NULL);
+  static DEVICE_ATTR(power, 0644, power_show, power_store);
+
+Helper macros are available for common values of mode, so the above examples
+can be simplified to:::
+
+  static DEVICE_ATTR_RO(type);
+  static DEVICE_ATTR_RW(power);
 
 This declares two structures of type struct device_attribute with respective
 names 'dev_attr_type' and 'dev_attr_power'. These two attributes can be
-- 
2.25.1

