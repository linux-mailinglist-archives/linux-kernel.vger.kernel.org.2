Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91B310E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhBEP2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBEP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:27:12 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CECC0617A9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:08:12 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id RV8B2400K4C55Sk06V8BMq; Fri, 05 Feb 2021 18:08:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l84aZ-003VXF-9p; Fri, 05 Feb 2021 18:08:11 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l84aY-008D0v-FS; Fri, 05 Feb 2021 18:08:10 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@suse.de>,
        Henk Vergonet <Henk.Vergonet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] uapi: map_to_7segment: Update example in documentation
Date:   Fri,  5 Feb 2021 18:08:09 +0100
Message-Id: <20210205170809.1956606-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_attribute .show() and .store() methods gained an extra
parameter in v2.6.13, but the example in the documentation for the
7-segment header file was never updated.  Add the missing parameters.

While at it, get rid of the (misspelled) deprecated symbolic
permissions, and switch to DEVICE_ATTR_RW(), which was introduced in
v3.11

Fixes: 54b6f35c99974e99 ("[PATCH] Driver core: change device_attribute callbacks")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/uapi/linux/map_to_7segment.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/map_to_7segment.h b/include/uapi/linux/map_to_7segment.h
index 13a06e5e966e53d2..8b02088f96e3733e 100644
--- a/include/uapi/linux/map_to_7segment.h
+++ b/include/uapi/linux/map_to_7segment.h
@@ -45,17 +45,22 @@
  * In device drivers it is recommended, if required, to make the char map
  * accessible via the sysfs interface using the following scheme:
  *
- * static ssize_t show_map(struct device *dev, char *buf) {
+ * static ssize_t map_seg7_show(struct device *dev,
+ *				struct device_attribute *attr, char *buf)
+ * {
  *	memcpy(buf, &map_seg7, sizeof(map_seg7));
  *	return sizeof(map_seg7);
  * }
- * static ssize_t store_map(struct device *dev, const char *buf, size_t cnt) {
+ * static ssize_t map_seg7_store(struct device *dev,
+ *				 struct device_attribute *attr, const char *buf,
+ *				 size_t cnt)
+ * {
  *	if(cnt != sizeof(map_seg7))
  *		return -EINVAL;
  *	memcpy(&map_seg7, buf, cnt);
  *	return cnt;
  * }
- * static DEVICE_ATTR(map_seg7, PERMS_RW, show_map, store_map);
+ * static DEVICE_ATTR_RW(map_seg7);
  *
  * History:
  * 2005-05-31	RFC linux-kernel@vger.kernel.org
-- 
2.25.1

