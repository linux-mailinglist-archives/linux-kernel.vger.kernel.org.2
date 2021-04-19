Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4925D363FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhDSKnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDSKnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:43:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516B8C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:43:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z5so3570172edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toGvDtMWhMDYlPHFOwwA+K972K5Nm/twg4hNfuZONK8=;
        b=i4haUFMAsLCC0tNC+XnDfjdSsLhN08jIapT0VisQ9lskMtKK1Jwhzqky7Qjr6qLx6Y
         p3i90RJ3IIVe5/sCH9QudKZ5xrnMZa+1meWz59lHu4BT8/jZIt1jmW0IrqP/SJ9TPDxz
         hBuWk7+tDOxGRHQX1y1rplTBXzkn6WTNC9P7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toGvDtMWhMDYlPHFOwwA+K972K5Nm/twg4hNfuZONK8=;
        b=GUTTO5SJr+AFdUm9DBhELMDmFro7j4clGu7IWMeQeyXQP1eO56aFLQ8SKPDMh/d/W8
         9WDD/6zJvWbZs+5iRplUkJkxLsLJLfS+qG0a6syYNX55ZkA3swS9ei6+9CY9irt5lE30
         RdcZ5h9S2Y9n6+5a77DfH/tbPMQlyElpJtAjuaap1C6tpov+8qcUkWgl3bLc71ycYsbt
         cRrrFS2km76OsmMIPTpGK0qwF9KtB1pXrxIHoOLOnlOo+n6zjzpPJNmH7GgrL8pWsqV1
         8kXvMm2mRO/UVyeZJprxPkvHYAdS0esJ04MHiGABfCPH2//leKz06yu4mDpIkxuQ0eYD
         VtZw==
X-Gm-Message-State: AOAM532F5bczuRORdkTUjJyJF5Z+1nxYdWgZgoj2pjUGAVoybrkR5EOG
        dbA3iT9SnlSWwnsPsuljLtxPIQ==
X-Google-Smtp-Source: ABdhPJwqrtV7X+IYms1vvRKDl/1gqU2/QCLUUPSftWG0W2AHaImnxbgWGCg59YtsOyGfJfHeJl6LMg==
X-Received: by 2002:aa7:cc94:: with SMTP id p20mr25005010edt.353.1618828982889;
        Mon, 19 Apr 2021 03:43:02 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id mm8sm10094623ejb.28.2021.04.19.03.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:43:02 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: make device_set_deferred_probe_reason a no-op when !CONFIG_DEBUG_FS
Date:   Mon, 19 Apr 2021 12:42:56 +0200
Message-Id: <20210419104256.1709253-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugfs is not enabled, the deferred_probe_reason string is never
read. So there's no reason to spend time and memory on recording it.

There's still a bunch of redundant kfree(NULL) calls and NULL
assignments, but this gives most of the benefit (avoiding two
vsnprintf() and a kmalloc()) for the minimal amount of ifdeffery.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/dd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 37a5e5f8b221..6a197336c6a4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -216,9 +216,13 @@ void device_unblock_probing(void)
  * device_set_deferred_probe_reason() - Set defer probe reason message for device
  * @dev: the pointer to the struct device
  * @vaf: the pointer to va_format structure with message
+ *
+ * The ->deferred_probe_reason string is only ever read when debugfs
+ * is enabled, so this is a no-op for !CONFIG_DEBUG_FS.
  */
 void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf)
 {
+#ifdef CONFIG_DEBUG_FS
 	const char *drv = dev_driver_string(dev);
 
 	mutex_lock(&deferred_probe_mutex);
@@ -227,6 +231,7 @@ void device_set_deferred_probe_reason(const struct device *dev, struct va_format
 	dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
 
 	mutex_unlock(&deferred_probe_mutex);
+#endif
 }
 
 /*
-- 
2.29.2

