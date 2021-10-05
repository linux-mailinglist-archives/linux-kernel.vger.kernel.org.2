Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB832422A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhJEOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbhJEOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:12 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A629C08EAC7;
        Tue,  5 Oct 2021 07:03:43 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4HNznl6jjDzQjb8;
        Tue,  5 Oct 2021 16:03:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=WXuKKp05FgBaGzLWzaMwG93oVFh4NeKDYaS1W7hf3+E=;
        b=wZT8+cKRlm4pTDS0WGBbniGcmXdO5KH5T7XxgPxUceWTe0aeTPmuoUo0Xg8lnSwbuSrkUB
        K1BTHJQAzrdgvYaeLHf10pn2IZXqoF49doP4XxY/jwLVMya1u3B/bsnsMKQw2ylnfGKTQD
        Uqz60T7BzGRaHgUtA4z7ihRwdTFOWgVk4W4SI70NBWZp5U0qBBkIy83P9KmEager3KlkhU
        KwiA3sqfAJ66QgfEttmIzFbPZLOmqb/vjEeeGIDEcasVGGgzfEyM8/vkOgcHudDeRGtnfw
        LlTYNxm833cCsPP1wMMvhhEAdn5tmav6ewqQFY8DqA3823xtu3xlUe5Kpgb2ew==
X-Mailbox-Line: From 3e27773cc94bfc740374d0432e70e4b215c08c9a Mon Sep 17 00:00:00 2001
Message-Id: <3e27773cc94bfc740374d0432e70e4b215c08c9a.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 13:22:11 +0100
Subject: [PATCH 01/13] usb: core: config: Use tabs rather than spaces for new
 lines of args
X-Rspamd-Queue-Id: 2D114268
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl warning at lines 28, 499, 500, 606:

WARNING:LEADING_SPACE: please, no spaces at the start of a line

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index b199eb65f378..52b0edee5b55 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -25,7 +25,7 @@ static inline const char *plural(int n)
 }
 
 static int find_next_descriptor(unsigned char *buffer, int size,
-    int dt1, int dt2, int *num_skipped)
+		int dt1, int dt2, int *num_skipped)
 {
 	struct usb_descriptor_header *h;
 	int n = 0;
@@ -496,8 +496,8 @@ void usb_release_interface_cache(struct kref *ref)
 }
 
 static int usb_parse_interface(struct device *ddev, int cfgno,
-    struct usb_host_config *config, unsigned char *buffer, int size,
-    u8 inums[], u8 nalts[])
+		struct usb_host_config *config, unsigned char *buffer, int size,
+		s[], u8 nalts[])
 {
 	unsigned char *buffer0 = buffer;
 	struct usb_interface_descriptor	*d;
@@ -603,7 +603,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 }
 
 static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
-    struct usb_host_config *config, unsigned char *buffer, int size)
+		struct usb_host_config *config, unsigned char *buffer, int size)
 {
 	struct device *ddev = &dev->dev;
 	unsigned char *buffer0 = buffer;
-- 
2.32.0

