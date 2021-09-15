Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86FA40CBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhIOR3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhIOR3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:29:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFC7C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:28:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z6-20020a257e06000000b0059bad6decfbso4529245ybc.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=34G7+Fqj0WJAh7t5lE/h98KDx/voMNWfP1UsFwW9Dtg=;
        b=puqB96KD/Gk+vyE3hqdruU5XWYJhWWJ2rYFtENUssN5dq5dRPQdFeE+K4z18nO3rPQ
         leUcyhfbEzEr5GwS7YrKxGYoz19jho5rqasLE47Piub+Jjl+o+JboUwrKw5KRwoSsQeU
         tfpSXKAg2yx519B+w4F9g7jfIATN4iBrmuAobakPgTuHfjA1xYui2w4Cenoay27W1DTs
         crcl/uSKH4Mtyr8FsxxAKxNf2+6VNoQNYoLCQtmGiJUwaEMJTC3eMBV8ZYvDqxXmV5xs
         3PO/VDMV1Up/Aqc+rLE7UpfdJhtMLb+hpwhu0MqIYwNO9Tv/A5sNz5uKbIy5JcPcJ+Bx
         MO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=34G7+Fqj0WJAh7t5lE/h98KDx/voMNWfP1UsFwW9Dtg=;
        b=zFMt4CpkKTcHashJoOODlvZIqZD9AbixgePcIMsNKdgLqpeFCCb/pH5J8pWqZHSCSw
         pNFiUCGU2kvZGJhNZ50jq6mPVEui+R0cdHRhnQCjMSqm8kTTH/ZIFIZznloDDjOeaT6b
         Za1abhDYkHAS8ImSQXSfbORhMALs8ucc93DA+BP8pgQnNjjZTtBgXjyjhZZNj72Ws/NL
         EzcWlqSb3W5zCb2tmX4TQiWE7H3eFYaG2HbFkG0SaeufBfCaiR35pjdRUKnNBl0bdcn4
         /v+pByEqUaJH7dy3nNZQnNzvld/orERv9XAEQPFt1TJFhNmQ/xigBq9NgkbFQinVZ7/n
         G67A==
X-Gm-Message-State: AOAM530Fl8UJcNhL6ttt7QgHrUzYSVMO0oADt8gX0YgVrd4732TYK3nU
        pyYN7VshReGM3Bupbf3s7K2eFVsjH/P+OZI=
X-Google-Smtp-Source: ABdhPJzg/lAC3s6bYbQhG7lhLC3ST7jm+Phs4Ndfi4zES6v/Nxz/KbDXpcOXMfaoMiKceJYTDXjHXPTVxX275C8=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a25:5ec5:: with SMTP id
 s188mr1413541ybb.523.1631726898900; Wed, 15 Sep 2021 10:28:18 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:28:06 -0700
In-Reply-To: <20210915172808.620546-1-saravanak@google.com>
Message-Id: <20210915172808.620546-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210915172808.620546-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 2/3] driver core: Create __fwnode_link_del() helper function
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

The same code is repeated in multiple locations. Create a helper
function for it.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/core.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bf008040b101..e215220545f8 100644
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
 
@@ -1887,9 +1894,7 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 		if (!own_link || ret == -EAGAIN)
 			continue;
 
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
+		__fwnode_link_del(link);
 	}
 }
 
@@ -1941,9 +1946,7 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
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

