Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351DE41441A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhIVIt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhIVIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:49:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA276C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:47:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q26so4476828wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDZbXCl9bSoGyZWgwef05HDv8VNeS1jh792KUo3neRA=;
        b=DZoVchhLRFdzVUSe0yYXFAwpDBWfu1vFZ0e8QBzM0DJRTQ/1IIRN8+wkYnyQ675Stt
         fvnYdZ2fO47NjBy82ZYQNVLi07vzSSdAAQnhqqL6lxF/OHNJiXVVlMF4a7/Y/pqK5I/E
         XeTXT93CXdY3TWrNl1gQ3HfjfPgtdsfqOxY/x1O6NXBWcow6ZNvykFwMk1RpIILJug+z
         5JofUn0Vz7jdiul7TFF1XgvvJR8oJWfa2WJhCxyD2Mnz4jV7AYPOBwCno3ejcw1UhUwW
         wj0WCf7mJjiKIgZIy8hXOmM3jHoJWMRNfSkXyjeQW+HqCcm8cYBY20j120GHWI/t4/zh
         L2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDZbXCl9bSoGyZWgwef05HDv8VNeS1jh792KUo3neRA=;
        b=caS1+wRE6uhHQOOTbTOLmfPzyInCUG7RrtkuWX/q3Y14HVTz/xScF9Vo+/HIRyP+aL
         1CLCVev85Vv4aELMSBfZye/On1zleIVa7vtfnR9bdiOa3br+lMfcCmFQ5ivVHBkNZoCp
         fIZoxuLo0gBAM9x261kGCl901RHdZZhDvDyhdkxat2Amw/qtgmhDo7dUgsPXRSkGfVsi
         Kxpx26SEWMDjWgRlXmKx0no5fTvTOKZwmi57qAoH/nC5lfLthjHiL/AX6dNqQugu/YQK
         cmeDYn62d3paYj5ItRuiOwxoTufO5YBOQs2MCSpYl4TLHvxinMcYIpPRsDoQGxQIAVf/
         DX0A==
X-Gm-Message-State: AOAM5334LNGuaFBdLNZoW+4+V6HWfMKTF7my1rwnELwA2VNHLyLAGwIz
        KPwQL+EcauMC7XafxD1FaqMTew==
X-Google-Smtp-Source: ABdhPJxeOvXJdOxLLJLg+I0IFMJsUNCZoiM3vmEEn5yFUSosTs2xx+btmuYiAJ/mjC10thMN/vVaPQ==
X-Received: by 2002:a5d:58c9:: with SMTP id o9mr41027703wrf.279.1632300475255;
        Wed, 22 Sep 2021 01:47:55 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id v10sm1591048wri.29.2021.09.22.01.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 01:47:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jack Winch <sunt.un.morcov@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v6 1/8] configfs: increase the item name length
Date:   Wed, 22 Sep 2021 10:47:26 +0200
Message-Id: <20210922084733.5547-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210922084733.5547-1-brgl@bgdev.pl>
References: <20210922084733.5547-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20 characters limit for item name is relatively small. Let's increase it
to 32 to fit '04-committable-children' - a name we'll use in the sample
code for committable items.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/configfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 97cfd13bae51..e398fb2e83b2 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -25,7 +25,7 @@
 #include <linux/kref.h>   /* struct kref */
 #include <linux/mutex.h>  /* struct mutex */
 
-#define CONFIGFS_ITEM_NAME_LEN	20
+#define CONFIGFS_ITEM_NAME_LEN	32
 
 struct module;
 
-- 
2.30.1

