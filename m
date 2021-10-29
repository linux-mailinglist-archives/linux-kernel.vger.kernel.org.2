Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C90543FD73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhJ2NoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJ2NoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:44:01 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D4C061570;
        Fri, 29 Oct 2021 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=41apIq8a9GDN/a/OSjo7h01dZVhtoDupxLtERsksX+c=; b=6e
        sK1CzMJKekZqRdNGlYUjv/A2bgsA6jJvM06fHBnhncM6WwBPG+GvofOn05pmQ7zgU5rSdJRbdWImF
        k05PYJugWvzWzRREeVOQP66N9QSA/LFVOJBgLwABIeEZGFIsJ11sUxCfClkXb8efa6MRZFFon80b8
        Lu70fbNY3nQFLYaQsMaK+5mpM7mzCGgVntknz7Y0SJVB3M1+MQWD820NiyUSLPXB2/3h9I/AfZASe
        0C+nrTxRnBLigVjYkenUzTt4U0vpytca0ENhYJkTNQwv+9Px9YouMonkO3rjRpwjMZIYhJ23RPx2l
        uzMV/1pwxYf9aqjVywxi6eXHsE2czDhg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mgS8H-0004Nv-R2; Fri, 29 Oct 2021 14:41:21 +0100
From:   John Keeping <john@metanate.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     John Keeping <john@metanate.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] usb: gadget: f_midi: allow resetting index option
Date:   Fri, 29 Oct 2021 14:41:14 +0100
Message-Id: <20211029134115.351008-1-john@metanate.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other integral options supported by the MIDI gadget, index is
a signed integer and defaults to -1, which means "choose any sound card
index".  The generic store routine parses input into a u32 which fails
to properly read -1 if an attempt is made to set the value to the
default.

Add a new macro block for signed values to fix this, and use the correct
format string for unsigned values.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_midi.c | 48 ++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 71a1a26e85c7..fddf539008a9 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -1097,7 +1097,7 @@ static ssize_t f_midi_opts_##name##_show(struct config_item *item, char *page) \
 	int result;							\
 									\
 	mutex_lock(&opts->lock);					\
-	result = sprintf(page, "%d\n", opts->name);			\
+	result = sprintf(page, "%u\n", opts->name);			\
 	mutex_unlock(&opts->lock);					\
 									\
 	return result;							\
@@ -1134,7 +1134,51 @@ end:									\
 									\
 CONFIGFS_ATTR(f_midi_opts_, name);
 
-F_MIDI_OPT(index, true, SNDRV_CARDS);
+#define F_MIDI_OPT_SIGNED(name, test_limit, limit)				\
+static ssize_t f_midi_opts_##name##_show(struct config_item *item, char *page) \
+{									\
+	struct f_midi_opts *opts = to_f_midi_opts(item);		\
+	int result;							\
+									\
+	mutex_lock(&opts->lock);					\
+	result = sprintf(page, "%d\n", opts->name);			\
+	mutex_unlock(&opts->lock);					\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t f_midi_opts_##name##_store(struct config_item *item,	\
+					 const char *page, size_t len)	\
+{									\
+	struct f_midi_opts *opts = to_f_midi_opts(item);		\
+	int ret;							\
+	s32 num;							\
+									\
+	mutex_lock(&opts->lock);					\
+	if (opts->refcnt > 1) {						\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	ret = kstrtos32(page, 0, &num);					\
+	if (ret)							\
+		goto end;						\
+									\
+	if (test_limit && num > limit) {				\
+		ret = -EINVAL;						\
+		goto end;						\
+	}								\
+	opts->name = num;						\
+	ret = len;							\
+									\
+end:									\
+	mutex_unlock(&opts->lock);					\
+	return ret;							\
+}									\
+									\
+CONFIGFS_ATTR(f_midi_opts_, name);
+
+F_MIDI_OPT_SIGNED(index, true, SNDRV_CARDS);
 F_MIDI_OPT(buflen, false, 0);
 F_MIDI_OPT(qlen, false, 0);
 F_MIDI_OPT(in_ports, true, MAX_PORTS);
-- 
2.33.1

