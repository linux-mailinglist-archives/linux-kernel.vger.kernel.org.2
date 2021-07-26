Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5484A3D680F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhGZTjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhGZTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:39:03 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDEDC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:19:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 7-20020a0562140d47b02902d89f797d08so9076897qvr.17
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dtq28Xg8/uLolUu+qWIKeO61eazTXjlrFQKAF/MncPI=;
        b=hz0ZRwZXl5oZHOaXjrQRjl2HnZZcPnSKBtMsJXpFVgVs49kEYZDETQnbXjsHMkKaD2
         0q70L1uD6/YSbaMbT94Kh3w5QcOGxS9iZEVgPRXs4T4KIytYvYwytkGvJCPv44cKed+A
         Jx2e3lGmgKXaVLkoHV/ye5c8QTgzzRl/QnKkoqe36ST0qM2ptLulRN7hL9BTXm0aNSOo
         sHl5nu+5DiX6Wrr4Jx9Lhyul/5A3lbF+7T7PSan7G/xURtsRYcoh4yP9g+zHzFEqKzPM
         m/19zx8izWOJXhRgChVehgR+Czxi7wG6owsMcpZbaH9PhB3AM1+VAV8t1r3Szvve8Dmg
         Iy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dtq28Xg8/uLolUu+qWIKeO61eazTXjlrFQKAF/MncPI=;
        b=MjJE7KtLe9C6KZjXWuQLk+/8C7gLXnNGNEr92EWKTNiTUGiEjAZIvJ6/6biphktjJN
         dsm0jRAP1OXffSuHWbaD29aZcRzsLOgj0KnkxRc244qrxx/B3ecYG9104phfAfvf+cJI
         V3MHTBzGooERkdvRUrROC9iMnfyVvCWiVz12smb1oQ/xAsV38nKjNp8DP+FHpwLh0zyI
         GtdIoIvynLbcW+lI5q1xnickIJ/HVM+4uHNcWeXMJv4RfuGDZB0tEzc4jp7XgIy7ds5h
         aJu5OCTG1HJ9dh9/C6t/XV/U53yXZWM87VYI2RyZbAKZ7ruALCZT3oWGVL2uc9e9htua
         fRvw==
X-Gm-Message-State: AOAM530ps5yPjKF7c8i/q8m/kJ4OK28vcYnACnvLzdZdqBR/oSe/2Z0y
        YXoQHT9+XiXP+eqUaVcP1PrV1E/0m8i8dVieoay1IAigwyBbvZxEPGSLaEaZOlhCZhZdmgEto8r
        /CmSkJJpt9+CT7lJTzkznKBvmhgaOCGdO8jwvsYXA7rEjgHzm0L9nNkhKL4tAmmhXXQ==
X-Google-Smtp-Source: ABdhPJyWjm8hvRlnL19m07zY5k1mL8W4fLKVX43wTTv/q2nEIW5TXdtGEIi490bOn5d3qy09VnkgMF6pBw==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:ccf7:db54:b9d7:814f])
 (user=morbo job=sendgmr) by 2002:a05:6214:1747:: with SMTP id
 dc7mr15897755qvb.27.1627330770376; Mon, 26 Jul 2021 13:19:30 -0700 (PDT)
Date:   Mon, 26 Jul 2021 13:19:22 -0700
In-Reply-To: <20210726201924.3202278-1-morbo@google.com>
Message-Id: <20210726201924.3202278-2-morbo@google.com>
Mime-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 1/3] base: mark 'no_warn' as unused
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

This variable is used to remove another warning, but causes a warning
itself. Mark it as 'unused' to avoid that.

Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/base/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..10494336d601 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -33,7 +33,7 @@ static void module_create_drivers_dir(struct module_kobject *mk)
 void module_add_driver(struct module *mod, struct device_driver *drv)
 {
 	char *driver_name;
-	int no_warn;
+	int __maybe_unused no_warn;
 	struct module_kobject *mk = NULL;
 
 	if (!drv)
-- 
2.32.0.432.gabb21c7263-goog

