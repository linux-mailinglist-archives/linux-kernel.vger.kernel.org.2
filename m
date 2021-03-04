Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8957932D0DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbhCDKci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbhCDKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:32:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E44C0613E8
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 02:30:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o7-20020a05600c4fc7b029010a0247d5f0so4254192wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 02:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ileJ8i8PtBYWO//WNWntFWU//j32QRx+BmjBpxepfLE=;
        b=tvmTdM0p73GfZuWLxHXiv2yDFa9iCw2qZ0WMOdYVQ/xrH0Detz9DXMI1vZ78cqq1rO
         FZJgQ1pFkmXtA7oDm61oRVjhgnQxG2Bexztzb171OBm6ll3JleAgBNUD54+Cux9bGGMs
         w4pUH0+gyWw7SI92E9v5XI+vV2rN+HRndqDl8PYgpzd2PPemcplAzZqeQS4grAknekbo
         YD74HYtEFaDRFtYPjGjI1ryuN4UTY9hJuj7q/fG3KkbN+37Jtr+QRay7IZdlw8mdNHn8
         BAzK3GoQf2cHJBO2XYoITa9Y3dyPQG411MRIiW2wOmfsXPVqVFbjcnNDqPYVRY4rroxa
         0gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ileJ8i8PtBYWO//WNWntFWU//j32QRx+BmjBpxepfLE=;
        b=DAJhMJZpqvj+gOVU2NWZ+r/hVy9EMMWNdOvNywlItZkocvimhfk206C7DJvh8kIxB1
         sAqqKuRZYq55AIvU8oyyszLlfUsmwT3RkHSDsboY62icZ96rLAFNJUhXC2MXrS2WnQkB
         S5LzciW51+M8Wet4A8pihxtAFGs1p/VPDfI3jeHemjkj5Ri7peodEAEkI9D7yXQcBnTt
         VI07s3r7gV5d8F2pQ/txC8BadRU9EiHvYy/Tk8O7FcwlPLyfZqULzkgdfh29m7r+ZEs+
         vp7ZKwfSpyug7Yv3pvDf94R5YUea9+NspUG6q4/6Xt47Cgg9hv1cJBt02pqOr6eddBlN
         +dOg==
X-Gm-Message-State: AOAM5312avbjlDUI+7YCHwo/ntQ8gO9z2pGxZeUF+6jatO2dg22b0lSc
        o+zdfI9QTLb0EtMwCaa6XVtexw==
X-Google-Smtp-Source: ABdhPJwkM34kJi5nQesphQNuYENooFAw7OGpfBJegp+yS/GnfmJ1rzXhNx1/ymXUxz5/gZVJNcl9WQ==
X-Received: by 2002:a1c:2e8f:: with SMTP id u137mr3197705wmu.178.1614853813151;
        Thu, 04 Mar 2021 02:30:13 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id f7sm35501854wre.78.2021.03.04.02.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 02:30:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 08/12] drivers: export device_is_bound()
Date:   Thu,  4 Mar 2021 11:24:48 +0100
Message-Id: <20210304102452.21726-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20210304102452.21726-1-brgl@bgdev.pl>
References: <20210304102452.21726-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Export the symbol for device_is_bound() so that we can use it in gpio-sim
to check if the simulated GPIO chip is bound before fetching its driver
data from configfs callbacks in order to retrieve the name of the GPIO
chip device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9179825ff646..c62c02e3490a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -353,6 +353,7 @@ bool device_is_bound(struct device *dev)
 {
 	return dev->p && klist_node_attached(&dev->p->knode_driver);
 }
+EXPORT_SYMBOL_GPL(device_is_bound);
 
 static void driver_bound(struct device *dev)
 {
-- 
2.29.1

