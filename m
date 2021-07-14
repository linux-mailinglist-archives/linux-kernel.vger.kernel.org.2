Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487653C814C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhGNJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbhGNJUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:20:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39E4C061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:18:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x84-20020a2531570000b029055d47682463so1846152ybx.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vw5Peyqjj1pTkLi4sY9bT/AGnFeqZYNI1XSYVd+RsmA=;
        b=vEVz9LPDXksWBMgvmxxNMwihjbHLL1vGRZYjpyEfgf/xEP04YwhwoNkyro9FOPrA9h
         m0DC1lp5A1Q6ziw4xfUah+lIF6GorCBw3UUo7qPxo1s3ZQ3WIZGs3jNNWjSxiWIYRzml
         AWAH3df/S4/Blvb4qxkq/DGqCtn28lP/ZT0XP6lNhFO8vGaMuKAScSFcf2Ef1KX4lgOO
         /RiJhtOUoI9uU6TeMgaRYg5+MmbL+sHZY31+20vxgNjnqAaQ9PeR0agSkYEDeGHXXXe4
         LVVo1TKeIfZW1MfQNihKotMRnUF/eyciQ6tRmdfjnMWD6SQMSh9rjh3YfImZKKgu0hC0
         OYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vw5Peyqjj1pTkLi4sY9bT/AGnFeqZYNI1XSYVd+RsmA=;
        b=bliIQjm7pCQ8sHbXlfP6Qe9w/+9cR7TylDk9YH9vxLp03vk88GVDrRqEvdRRl5uoIe
         TFT/yIcZQM8Ber2jTsD8n5ikdEolYvDn2Tj7kAy4xWK2ihYPaTVagAfw9M0+7eFzLclY
         viKKld7yxv0SMUsO46cJ7821t33MDt+fx2YwbGHFD10CxQgDPXhcOtDYTBGPzEUOpq/N
         RvlxN/68V858862Fq1/AMIIYxdrWuPW5f4NLHQiHLuDRcswdj+XGFhAKnYHB0CkLpk3f
         Wp9sKO3OOXQKBk/TOe5RqmTA5ExNDUJYpq3G+HuML5hYZg8SNz7wnOMbekUzWjdGOqiW
         IbSA==
X-Gm-Message-State: AOAM53224H1a/azjESm1jnnnB0mSOkneo40JmWF9T951CLF7DdnIgL63
        22WnWrmw7s21+O+I0N5hyZw8K2q7q+B7T8SZwdFqNPHpmvXDc5AguMn9VkOBKxLi6tWjMAGf1cR
        gGFF76eFsjIKCVuvUdEItf642n8T0tzPVsi+kk1E2PZNAw4WlX6wIcx30cAm7u4ezTQ==
X-Google-Smtp-Source: ABdhPJz1WFvQywevhWQJFJ+A0J4TTNUvbo7lLR4oqZ9RDSgByA2ep3BckRZ/icB8EbiiIRgWsXPI/bbFnQ==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:c569:463c:c488:ac2])
 (user=morbo job=sendgmr) by 2002:a25:7ec4:: with SMTP id z187mr12297784ybc.136.1626254280973;
 Wed, 14 Jul 2021 02:18:00 -0700 (PDT)
Date:   Wed, 14 Jul 2021 02:17:45 -0700
In-Reply-To: <20210714091747.2814370-1-morbo@google.com>
Message-Id: <20210714091747.2814370-2-morbo@google.com>
Mime-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 1/3] base: remove unused variable 'no_warn'
From:   Bill Wendling <morbo@google.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        "David S . Miller" <davem@davemloft.net>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build warning:

  drivers/base/module.c:36:6: error: variable 'no_warn' set but not used [-Werror,-Wunused-but-set-variable]
        int no_warn;

Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/base/module.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..81d84a066a38 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -33,7 +33,6 @@ static void module_create_drivers_dir(struct module_kobject *mk)
 void module_add_driver(struct module *mod, struct device_driver *drv)
 {
 	char *driver_name;
-	int no_warn;
 	struct module_kobject *mk = NULL;
 
 	if (!drv)
@@ -59,12 +58,11 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
 		return;
 
 	/* Don't check return codes; these calls are idempotent */
-	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
+	sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
 	driver_name = make_driver_name(drv);
 	if (driver_name) {
 		module_create_drivers_dir(mk);
-		no_warn = sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
-					    driver_name);
+		sysfs_create_link(mk->drivers_dir, &drv->p->kobj, driver_name);
 		kfree(driver_name);
 	}
 }
-- 
2.32.0.93.g670b81a890-goog

