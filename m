Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D024265BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhJHIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhJHITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:19:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA12BC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 01:17:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so27302632wri.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6iEJB4pcSblX4SdZfQ+pj8u1PpQ7EP4J6z216v/Emw=;
        b=vGw3X8yO89TItyj+jMgmELxwnXdGLcyFfexOwH/fc6JFQPHL/+8pAOe7Pl8wV2ZJzG
         RbH3vOUv4O9mCg6OlDscJwtdd97Lun/ak0v/RzFscaNocOU3nioAbzSkFMyz5PW9a7x1
         c+/YqujqZHKvl1rKE562fwHUrzEgLv/EKkZuXDhfFFTr9lN2bBBe6O4WnzhTSeqolpCD
         Y7raqkZtQppZk7UJgZsfKZxD3zDrOSp5tvG+SOlxxJlANsQk+oZ4frMQInpmNJkxHo1N
         WMAntgt3zHGEHxVw+9L5OTvTMwQ2Mc6fSpkEj1R4q2Adkpv1cCedkT+DVVBGQyGCLs6L
         BNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6iEJB4pcSblX4SdZfQ+pj8u1PpQ7EP4J6z216v/Emw=;
        b=Lg8RfPX1CLbdAerun+M8wAQ5UIx54XyGgkXWlsEW0VMppO+01bhZuBCW8R7AvB/Vnh
         c2Pu2s7ADTnT90+sNHyOZoLLK1EH5uyrvFxCjui8xH5vsJDucevCGCNAxYXqKcr/obdL
         pIYiLM1tb/hpA/ih/s1H/DPOYPsf5Wbm7vvq7rIHJIlTM6ec7H32SmnCqzgnOLNZoTwT
         5ruWsno6JuSTXb7hL/KYcXJuZ1Ex2RL1s4jzU6wVX74TSEEfwMlRdlAyCZ+ekRIQckN5
         2Nf2Anm3HdQ80cQGeakEw+wK7EumyFNVAkfPk7gG/J5dMzXvGULn8Yfey2W+xCannj92
         0MNA==
X-Gm-Message-State: AOAM533j0nb0vWYIdnzvOZfzrjtS7gneDe0B927F6Iv77janqObEWlbD
        zuyYsVqycCqErvnXvZUTybYtRQ==
X-Google-Smtp-Source: ABdhPJxo1cevac5/0rSCw2w5/xBAnVBjveraUMEl/Ke4EJgcGSnm5lbaUbum9WqkZEt7vylTFBZz9A==
X-Received: by 2002:a05:600c:1d1f:: with SMTP id l31mr1971391wms.44.1633681065285;
        Fri, 08 Oct 2021 01:17:45 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id i3sm1759530wrn.34.2021.10.08.01.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 01:17:45 -0700 (PDT)
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
Subject: [PATCH v7 2/8] configfs: use (1UL << bit) for internal flags
Date:   Fri,  8 Oct 2021 10:17:33 +0200
Message-Id: <20211008081739.26807-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211008081739.26807-1-brgl@bgdev.pl>
References: <20211008081739.26807-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better readability and maintenance: use the (1UL << bit) for flag
definitions.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/configfs/configfs_internal.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index c0395363eab9..0c7a3d857fde 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -44,16 +44,16 @@ struct configfs_dirent {
 	struct configfs_fragment *s_frag;
 };
 
-#define CONFIGFS_ROOT		0x0001
-#define CONFIGFS_DIR		0x0002
-#define CONFIGFS_ITEM_ATTR	0x0004
-#define CONFIGFS_ITEM_BIN_ATTR	0x0008
-#define CONFIGFS_ITEM_LINK	0x0020
-#define CONFIGFS_USET_DIR	0x0040
-#define CONFIGFS_USET_DEFAULT	0x0080
-#define CONFIGFS_USET_DROPPING	0x0100
-#define CONFIGFS_USET_IN_MKDIR	0x0200
-#define CONFIGFS_USET_CREATING	0x0400
+#define CONFIGFS_ROOT			(1UL << 0)
+#define CONFIGFS_DIR			(1UL << 1)
+#define CONFIGFS_ITEM_ATTR		(1UL << 2)
+#define CONFIGFS_ITEM_BIN_ATTR		(1UL << 3)
+#define CONFIGFS_ITEM_LINK		(1UL << 5)
+#define CONFIGFS_USET_DIR		(1UL << 6)
+#define CONFIGFS_USET_DEFAULT		(1UL << 7)
+#define CONFIGFS_USET_DROPPING		(1UL << 8)
+#define CONFIGFS_USET_IN_MKDIR		(1UL << 9)
+#define CONFIGFS_USET_CREATING		(1UL << 10)
 #define CONFIGFS_NOT_PINNED	(CONFIGFS_ITEM_ATTR | CONFIGFS_ITEM_BIN_ATTR)
 
 extern struct mutex configfs_symlink_mutex;
-- 
2.30.1

