Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2E40CBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhIOR3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhIOR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:29:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79685C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:28:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so4549992yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/o/E1/qVLhSpmI35/Ak3XUf7xiiUPVWmvu2PpbOhvuA=;
        b=oDuQPjge0/MuLHYw2ZSy1IQ6iagP+HhFM+gYM6shsQ7NrncaCJ4uEVTn+zBXpQjozT
         CccGpk6XXxflwPrYtTuS4a8weVh/2WpvQFZ8HKzu9uHVlil8QmkLyfrgEiuGOF9coKDI
         KPSA0vZGr0jyNdTDDSgfGgIFjWH6btewi1p6Yy6E4T3omZkZzXJHZkuPxunTGY+TvKPH
         l36oQz1Zo2rSKrOzp4eG8CkYxFsVmz6vSFvhCvztKBxzitW6eiGHqvfCs2pzJkXAB222
         P7IoNjLVJ/EpfxOOaC7b8LxJJ3EXtImDS7l5or8wAM3afG1NBLYFpd90h6UNtmlPutte
         Yl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/o/E1/qVLhSpmI35/Ak3XUf7xiiUPVWmvu2PpbOhvuA=;
        b=6jt/CdkGbBuNkN+DFZQbzzNr74WkC3egt2/NQcawU92HzdAstDoJS1gwGuuQr7izLe
         bicgWXj3mhrXfJBqswW1hBwt5ebkxD+0Suo0dv54NgDNOmJihZ9sYt7JeanjMGzz59cf
         VF1Rp1RhXgz7opSwbE7fJK5YWdLvHvG2eJkqK8WvWc4YmOuDXJDNjZ3Iw2FF7Q3wiVU0
         tQdt9eQyuHPzpbAjDcm+aUR2Qb5Vg02ADuAv9WAIJYak4mzfR34r9GRSaSXV4DKhSfRZ
         6YuywsaWnOe3TIWpFjn+JrKGHjD4XFVDZpCk1bdB9L7dPeeW1vOSKRrIXKfzBg4+FA6u
         cfKA==
X-Gm-Message-State: AOAM530tOpffHFH4sbnzABvunOLXHFGVmfmR2N/B3est5seDdUJ6EDw/
        AUfKi25eDLEHlvGAFcN5B+zqiazIa9asiGw=
X-Google-Smtp-Source: ABdhPJxuh/CN2H3Qo4pViEnUjFXl/5qYaqMIWhT4gnQM/WLw7Fv0M0xTnQqqBiUplQew77HHgWCgPhFTDDm0p3I=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a25:2d5b:: with SMTP id
 s27mr1554246ybe.68.1631726901734; Wed, 15 Sep 2021 10:28:21 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:28:07 -0700
In-Reply-To: <20210915172808.620546-1-saravanak@google.com>
Message-Id: <20210915172808.620546-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210915172808.620546-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 3/3] driver core: Add debug logs when fwnode links are added/deleted
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

This will help with debugging fw_devlink issues.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e215220545f8..15986cc2fe5e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -95,6 +95,8 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
 
 	list_add(&link->s_hook, &sup->consumers);
 	list_add(&link->c_hook, &con->suppliers);
+	pr_debug("%pfwP Linked as a fwnode consumer to %pfwP\n",
+		 con, sup);
 out:
 	mutex_unlock(&fwnode_link_lock);
 
@@ -109,6 +111,8 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
  */
 static void __fwnode_link_del(struct fwnode_link *link)
 {
+	pr_debug("%pfwP Dropping the fwnode link to %pfwP\n",
+		 link->consumer, link->supplier);
 	list_del(&link->s_hook);
 	list_del(&link->c_hook);
 	kfree(link);
-- 
2.33.0.309.g3052b89438-goog

