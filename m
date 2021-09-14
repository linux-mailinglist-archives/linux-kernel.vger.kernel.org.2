Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3764840A580
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhINElB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbhINElA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:41:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso15795720ybq.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=muUBQx1iVUomOqVpwguh6GkU76otYm46ekQ1wKZnR6w=;
        b=a4fZEfV+b+ZTxF9ceJ1Rtzapoo9diYaevA1FJ9Kze8mTwxibcdlKMuCbxMM0/NO7to
         G63XDUsKVQgtp8rhZufyNFuWtNfhSSstou1F+GAIHkx0Yyt1Hf2bwSobQDMvbFlik0zS
         gFqrJOn3AwCmRjAQszoIGa8RW2TF6YLQppOievHYnukuPsl9JdRrBnDKRLC3BltKzWkP
         u7h4v2Jgv3ELyfJlPtBjWw5zaUlVVY7FRdtzoAZyckrhBfYB+6V6KQP1AvO3D/yNf6HV
         5mQHmkcir3CGvDakwiXlZQp0Moc2aNMpzFdWSHc5X98GwgUASIbtfQh7UGiln3/T2kqP
         1wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=muUBQx1iVUomOqVpwguh6GkU76otYm46ekQ1wKZnR6w=;
        b=l1VTYm29vubWChZ1b27YlD4xdfNfrNAdy0SRG5bTfS9lpV5mn6lRCkZeOfGCn7ttgk
         O6M+4HFdRy6vzIMv8yAWo5NkGey+Ilmz3i3eQ7fjX0D1IrtP1gUi0mIVEbfA7rshlZkX
         4EotdAF8iMTYcM98xIxO5jSPdKfYwU3+PQ8K4Z596kLjt3wZS/FnUxfTUWnYDm91MzeC
         zSbMzvxcs+s+LiQWrqkSmc1gwMQNHmB3+e4v/0c3t6cesfbcWg7rbQWpAmi+R5zOWeJ4
         BRo60dwg2cjCf+xlfsbNFoVgttHLViiyAqKzPYVKYQEbqzvWYA4M6v3BvFdNpDI50NKh
         fzrg==
X-Gm-Message-State: AOAM532Vr85of962opqqSTaL1YYc9xhVvqiYoWAu9Evd+YcVYb388Pg7
        wCM0/2bOFAFqgE4utJeXdzEExGhCQCIM5r0=
X-Google-Smtp-Source: ABdhPJzfczGSAy+5DBr5QuTYk7w4A+0OxwVYux509XsS0gvYOR6lprXa1YvfF9T+tEft6o3SaqLPL4OZzZMaVL4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:48b:108c:f6a1:56f3])
 (user=saravanak job=sendgmr) by 2002:a25:6b43:: with SMTP id
 o3mr20421881ybm.6.1631594382354; Mon, 13 Sep 2021 21:39:42 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:39:25 -0700
In-Reply-To: <20210914043928.4066136-1-saravanak@google.com>
Message-Id: <20210914043928.4066136-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v1 3/5] driver core: Create __fwnode_link_del() helper function
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same code is repeated in multiple locations. Create a helper
function for it.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 41f456904272..516a5c498b88 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -101,6 +101,19 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
 	return ret;
 }
 
+/**
+ * __fwnode_link_del - Delete a link between two fwnode_handles.
+ * @link: the fwnode_link to be deleted
+ *
+ * The fwnode_link_lock needs to be held when this function is called.
+ */
+static void __fwnode_link_del(struct fwnode_link *link)
+{
+	list_del(&link->s_hook);
+	list_del(&link->c_hook);
+	kfree(link);
+}
+
 /**
  * fwnode_links_purge_suppliers - Delete all supplier links of fwnode_handle.
  * @fwnode: fwnode whose supplier links need to be deleted
@@ -112,11 +125,8 @@ static void fwnode_links_purge_suppliers(struct fwnode_handle *fwnode)
 	struct fwnode_link *link, *tmp;
 
 	mutex_lock(&fwnode_link_lock);
-	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
-	}
+	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook)
+		__fwnode_link_del(link);
 	mutex_unlock(&fwnode_link_lock);
 }
 
@@ -131,11 +141,8 @@ static void fwnode_links_purge_consumers(struct fwnode_handle *fwnode)
 	struct fwnode_link *link, *tmp;
 
 	mutex_lock(&fwnode_link_lock);
-	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
-	}
+	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook)
+		__fwnode_link_del(link);
 	mutex_unlock(&fwnode_link_lock);
 }
 
@@ -1895,9 +1902,7 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 		if (!own_link || ret == -EAGAIN)
 			continue;
 
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
+		__fwnode_link_del(link);
 	}
 }
 
@@ -1949,9 +1954,7 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 		if (!own_link || ret == -EAGAIN)
 			continue;
 
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
+		__fwnode_link_del(link);
 
 		/* If no device link was created, nothing more to do. */
 		if (ret)
-- 
2.33.0.309.g3052b89438-goog

