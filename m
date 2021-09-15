Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49EB40C16D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhIOINi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbhIOINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:13:15 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9A7C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:11:52 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 13-20020ac8560d000000b0029f69548889so1831867qtr.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tE5kGBxc9PR5MYieHfGicxhFgO1boA1xk2XZYsANqZE=;
        b=KN5josXRk6vEJRYv7Y1XeBMkRQ8IZkeHu44xya1+5GcI4HNGbxj/PzNhRJv03Gm7gz
         vwZ+eUszHx3DpNx65e2e5tZwGBh4E735USu8tG5dL74IvqQS7GCR28Zet9kaZOkKGvfO
         1YhaL/yYj9lv4TJfaP0O95HgWwVHMxevZNv5+x9HkCTw8gLypeb4HuL1IHfm3jfS4XTH
         kgoGDssnvd/dlvR7WgNGENS05/uC5nXpQCEZw/0JIG5MksUhDetVqUVN7J3YRjO+aXuD
         xrMHTI1av5a7LngEXrGJW1Q3kTesixXypTyLae2F+0L6oZw4+JAiS73jCRIQsnHE+vJg
         obag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tE5kGBxc9PR5MYieHfGicxhFgO1boA1xk2XZYsANqZE=;
        b=dB4TUuOEmxd2qH4FWmqRImC7UvQfOzjxEJtOFnIE8aB5s2I85nu6KJz4sZMgpLicfH
         BgP3GWa+37UZBLcO8m9mhvQh3IgZC9r5OxaSlCkFVhs9OUPW/N0AUfuzPIzg5OmJOqQg
         gvP96oiohPQmlnuuRKeP6a104it5zfzrZq/a0ec88c82/3HIQN3Zos06OLbViR30YH6B
         7f4RVyG6FtI7T+2wVr+h64pn6CqypHLox3aTXPbgFhsi7G0z2c6bMgguTUg0mjV2QgIh
         0X7pvvvjXlaHTLIqioe5fu+CB09MIKYIYoZiMNyeeGq8eJ3le32MveGOzSm8gQoAtVX6
         yVRg==
X-Gm-Message-State: AOAM530UzvD45rnmIYYKyIGPgEBgbmNnChtO4TeriAqSXw6nbF22ZkEY
        JxDEzYrdBolR/xWsRLfuRbO2D15Xl6F0tfI=
X-Google-Smtp-Source: ABdhPJymuo/nGsFPIwVrp7CZBqqkEkLsixu4nf/KlVnpN+10WWdFz1i21Iee5Xghf2MWQiCPsNtZaWmaSD1VQvY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a0c:fca2:: with SMTP id
 h2mr9492302qvq.5.1631693511580; Wed, 15 Sep 2021 01:11:51 -0700 (PDT)
Date:   Wed, 15 Sep 2021 01:11:35 -0700
In-Reply-To: <20210915081139.480263-1-saravanak@google.com>
Message-Id: <20210915081139.480263-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210915081139.480263-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 3/6] driver core: Create __fwnode_link_del() helper function
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org,
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
index ca6c61a2e2e9..5e7faad4e083 100644
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
 
@@ -1868,9 +1875,7 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 		if (!own_link || ret == -EAGAIN)
 			continue;
 
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
+		__fwnode_link_del(link);
 	}
 }
 
@@ -1922,9 +1927,7 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
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

