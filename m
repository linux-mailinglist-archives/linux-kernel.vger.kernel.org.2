Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329BF40CBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhIOR3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhIOR3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:29:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36B3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:28:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q17-20020a25b591000000b005a07d27bbdaso4589465ybj.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PsNziD4Hw6F2OOpCR/MaIqkoLk5qX+QWjcPv3d7KBvI=;
        b=K4TWT6QVMJbFrwrC6u5MyUk0BEKpSYH2S04AScrkev2bbDfBGxQLiD8bpRp1c8BNHJ
         10ueh/ya0Ut5+h/cYcGGhIgaAkMwcFNxK07fWnx0PeJidKGY02FkTzRFlGNWsw/ZoQgV
         yufLZ6dQI0lWPoTIy6qjX0vSx5Z3yBIbcZ/d8DAJNapnwO4XoT2bgTLOZix5w4Lfe7eY
         X1ZSeTu0Lx0NQPXuOIyzO8YYREeXYCzKHQ2K5R26zbAdjjIddl+pRfGp3CZlgmlhTvte
         wzsos6Y0mOVY7Y0JNR4RuZp8ez23BuGbeWz2N9d9M5lLl01NSOtCOhTYkaxibBY26m+X
         PtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PsNziD4Hw6F2OOpCR/MaIqkoLk5qX+QWjcPv3d7KBvI=;
        b=U/5TCly9nvkMO24+cVaSbS/EJvDOdOKZkyzAXY6ErPdhBEExOOP16yHEkfiePRxCS2
         MB8eln2d/xdhPoWs9JqWr7hdTm87M5y5GMif9IdcuwM7n+aJhribV1JGr9QHwIi2/39A
         ZzPGMMZVf5WRjm3oVOno7U1jiz4lLKNWx7ydAN7lvsMz7jpaguIa/wRXEBIu9NKayHO8
         RTQ5qEv28KaYhyTAcqO0+qrTeTu9NP14K34nLayoZTVwAKSLPaifBNqaCQQwJ/9lOG7j
         FhfnVv3UHUCdu1ER2GcRg8KiSxiyg4Ev4K4fBvQc6lGBgaJD5pLyXA3IEvMBKbeUXXaU
         ai1A==
X-Gm-Message-State: AOAM532tWCINHmajaPD6RLyS/TUlWm2MgI+5k0lRhaffgjyutNazjLrV
        HW6kT1489o9REQmGmhjzKZ0uxYFSr44rzes=
X-Google-Smtp-Source: ABdhPJxyhDj0O6qRkbfqsToTeRnAJjJnN2Di+UOhSFSQGZs2qCCJ9GvU96WcPja2so4DcSnZnJSl8Ov8alT7jC0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a25:9ac6:: with SMTP id
 t6mr1471338ybo.190.1631726896006; Wed, 15 Sep 2021 10:28:16 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:28:05 -0700
In-Reply-To: <20210915172808.620546-1-saravanak@google.com>
Message-Id: <20210915172808.620546-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210915172808.620546-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 1/3] driver core: Set deferred probe reason when deferred by
 driver core
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver core defers the probe of a device, set the deferred
probe reason so that it's easier to debug. The deferred probe reason is
available in debugfs under devices_deferred.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 21d4cb5d3767..bf008040b101 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -975,6 +975,7 @@ int device_links_check_suppliers(struct device *dev)
 {
 	struct device_link *link;
 	int ret = 0;
+	struct fwnode_handle *sup_fw;
 
 	/*
 	 * Device waiting for supplier to become available is not allowed to
@@ -983,10 +984,11 @@ int device_links_check_suppliers(struct device *dev)
 	mutex_lock(&fwnode_link_lock);
 	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
 	    !fw_devlink_is_permissive()) {
-		dev_dbg(dev, "probe deferral - wait for supplier %pfwP\n",
-			list_first_entry(&dev->fwnode->suppliers,
-			struct fwnode_link,
-			c_hook)->supplier);
+		sup_fw = list_first_entry(&dev->fwnode->suppliers,
+					  struct fwnode_link,
+					  c_hook)->supplier;
+		dev_err_probe(dev, -EPROBE_DEFER, "wait for supplier %pfwP\n",
+			      sup_fw);
 		mutex_unlock(&fwnode_link_lock);
 		return -EPROBE_DEFER;
 	}
@@ -1001,8 +1003,9 @@ int device_links_check_suppliers(struct device *dev)
 		if (link->status != DL_STATE_AVAILABLE &&
 		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
 			device_links_missing_supplier(dev);
-			dev_dbg(dev, "probe deferral - supplier %s not ready\n",
-				dev_name(link->supplier));
+			dev_err_probe(dev, -EPROBE_DEFER,
+				      "supplier %s not ready\n",
+				      dev_name(link->supplier));
 			ret = -EPROBE_DEFER;
 			break;
 		}
-- 
2.33.0.309.g3052b89438-goog

