Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303F232BE4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385506AbhCCRUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383008AbhCCNjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:39:35 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658CDC061222
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:38:50 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:cd47:42a6:c822:e50b])
        by andre.telenet-ops.be with bizsmtp
        id bpen2400W4huzR801penop; Wed, 03 Mar 2021 14:38:48 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lHRiB-004Q0m-I5; Wed, 03 Mar 2021 14:38:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lHRiA-00GWpg-Ui; Wed, 03 Mar 2021 14:38:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] docs: driver-model: device: Add ATTRIBUTE_GROUPS() example
Date:   Wed,  3 Mar 2021 14:38:45 +0100
Message-Id: <20210303133845.3939403-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303133845.3939403-1-geert+renesas@glider.be>
References: <20210303133845.3939403-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a paragraph about the ATTRIBUTE_GROUPS() helper macro, and use it in
the example.  Retain the old description, as it is still useful in case
of multiple groups.  Change the names of the group(s) structures, to
match the ATTRIBUTE_GROUPS() macro.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/driver-api/driver-model/device.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/driver-model/device.rst b/Documentation/driver-api/driver-model/device.rst
index 41c819fafd9c1aee..0833be568b06cace 100644
--- a/Documentation/driver-api/driver-model/device.rst
+++ b/Documentation/driver-api/driver-model/device.rst
@@ -82,19 +82,24 @@ organized as follows into a group::
 	NULL,
   };
 
-  static struct attribute_group dev_attr_group = {
+  static struct attribute_group dev_group = {
 	.attrs = dev_attrs,
   };
 
-  static const struct attribute_group *dev_attr_groups[] = {
-	&dev_attr_group,
+  static const struct attribute_group *dev_groups[] = {
+	&dev_group,
 	NULL,
   };
 
+A helper macro is available for the common case of a single group, so the
+above two structures can be declared using:::
+
+  ATTRIBUTE_GROUPS(dev);
+
 This array of groups can then be associated with a device by setting the
 group pointer in struct device before device_register() is invoked::
 
-        dev->groups = dev_attr_groups;
+        dev->groups = dev_groups;
         device_register(dev);
 
 The device_register() function will use the 'groups' pointer to create the
-- 
2.25.1

