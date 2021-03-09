Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1698E333074
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhCIU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhCIU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:59:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C5C061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:59:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so5080620wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h87jccumC6oS/Oglf5H2ioMoJmQRJZD6wd7xhfpKIok=;
        b=fZVB/QGG9EbB5+T+UR94Xnpw6QNQ921+Fz8r5lwjpB9Khl+Tow82FJsb9Io2XFA5SA
         bR9K9JlxSqYTckTQ3Ts7ONMkXbCR5kGgUKjI0JzOwAnGvXUCTr8Rvi5CA3aoEdGUYinl
         TsgIAftrebZgUyQXtW2B3vq+l6m8gX55cEDN19ZPrpQIejK7HV4eVB/BO4a1pztV21rs
         0SOoqh2pJcdVdlx6ge/S62DsUY3VqZkqx8jcUuM5p7gXS2J6/Uye4re3fJnHwa+69osm
         j8fCAxmQe0CKoNhp3WpA/DyfgxmwqRwtzbympBm/v3uMd/BybE/xDuYS4RR+dnOioZkP
         U92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h87jccumC6oS/Oglf5H2ioMoJmQRJZD6wd7xhfpKIok=;
        b=uIHPSB4glR5rhc7hjFgHuC6ouRflEBzqoYgXptkqzzdprX41O+f4ViMJ5V5NxT0xPA
         mu3v/4OU5KTZ5fj3+qeOCov+bjXuxpB82W3L8txrweJFkJ6UITQqN1xu+l3BQJXXfBBU
         W99Sdkfr0NpXtZQcXPHZCSmNNGtS04of1a0Ugfz34GDbD4IKCJfKVH2G1SCIQpMxZ2QE
         szyHw+42XvG9ApyNvfEugi4BIbGFwrpdcerHxu3ybSYUgMmkzOcqw35WL8hOwtP8qYJm
         M710YGjlDlex/8q8tQ97XAI16Dm4YncKpsPnMXn60K6AXeh4h6WsX54MdzIzbf8C9ynJ
         BeXg==
X-Gm-Message-State: AOAM533vNp0A/50Cl5SuZT1dVIc1/4gsfpvaRYAs1hJHBLlcLCd+8mt5
        mVZHNkKmtZGPfXQEI/j5xR/3hg==
X-Google-Smtp-Source: ABdhPJwj2H2vR6x+JBM8OMVIat1b7I4XyvRBqoZlPgrqY7coics7xEB+cMJzqKv3wVFqDlnCyVkg2g==
X-Received: by 2002:a1c:a5cb:: with SMTP id o194mr5962641wme.129.1615323573594;
        Tue, 09 Mar 2021 12:59:33 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id j6sm5501305wmq.16.2021.03.09.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 12:59:33 -0800 (PST)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 01/11] configfs: increase the item name length
Date:   Tue,  9 Mar 2021 21:59:11 +0100
Message-Id: <20210309205921.15992-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309205921.15992-1-brgl@bgdev.pl>
References: <20210309205921.15992-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

20 characters limit for item name is relatively small. Let's increase it
to 32 to fit '04-committable-children' - a name we'll use in the sample
code for committable items.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/configfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2e8c69b43c64..4f76dcc08134 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -27,7 +27,7 @@
 #include <linux/kref.h>   /* struct kref */
 #include <linux/mutex.h>  /* struct mutex */
 
-#define CONFIGFS_ITEM_NAME_LEN	20
+#define CONFIGFS_ITEM_NAME_LEN	32
 
 struct module;
 
-- 
2.30.1

