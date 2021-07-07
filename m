Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7618A3BECF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhGGRVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGGRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:21:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F7C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 10:18:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p1so5715298lfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=phystech-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ypxDnWif+H1Ur0uToOJNpXylwlZDL/gdovpiZt5z82o=;
        b=IC5AgO9ygAj8ApySXTjmmQ1KSRN0cdqozzHfdj+K2tcM8hm0jOqYro9VjT7rBDRTuG
         vq96jbhyu3H0Guey3tXVh2+IDVFs5M/aOsu0/rfVbG+21L/qlTgU4I9U46fPByKW8Z1A
         YSIzGUUAZik7JSRdzuYfI72eXdMQZNJ/V7EUYDenIDFA/A//+T2mgyV55iCj7mBd0qyL
         kAFVP8K4L5rCkyJJ3dYeFk3J3rdnHGDI5UaNh8w76d4ErteHIqVGV5cTGkBaGG0IJsSn
         ebBCdUf6GuHyd8JUGxxSD+0ZrrEzX+HxaIz/Spjeq0R+bbGQdev5Ew7FeD4yLgwYv9vz
         YRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypxDnWif+H1Ur0uToOJNpXylwlZDL/gdovpiZt5z82o=;
        b=shsrIdVC0LwOhpgmmTkDB1G/SHucYKxwsvYiAISiKuv8F7nLkpoN7C90ge9aqR5vSz
         u0AQstxkin5QIzJ7dFK/GXg00Ttju+fsw44SJA9RXmMz5J33i5VCQFLl5JdmBAKZNaIE
         Vc6R+cN3kIw7uI8hDOlNeyeh6aZEs6MDJrNGvZ1lhdsxnYGxK5iFnvPC8dRZIxHcNDqR
         BDYruOJSIPcH5P7BfuM2v/A5MmPxyNhzWhC6IT6iuSDR5qN4nsaX5Tu1mNYZmB1cvnk3
         8gr6iDrnTVJhHx+5eF0/LmPLxKJOmUK76UHbBbZTL1Ylm+x7JVcg/9iWnFcCTjAujbqx
         5BrQ==
X-Gm-Message-State: AOAM530DWdnYfimbUZ4CDxXwWb6Qx6paA6IzvibemTW+R/IJyeC/vjbg
        byns26YerjgrnO6CqV6yHBr2pw==
X-Google-Smtp-Source: ABdhPJz8VSZiE1GbRIW2zEZJUmJvzpwEzRHId//RA7YGJlorwou9uYQ720aDMZGQWPSk0jqptMEGCA==
X-Received: by 2002:ac2:4191:: with SMTP id z17mr19059617lfh.457.1625678331172;
        Wed, 07 Jul 2021 10:18:51 -0700 (PDT)
Received: from 192.168.1.3 ([2a00:1370:810e:abfe:9c62:44e3:b0ab:76fd])
        by smtp.gmail.com with ESMTPSA id z9sm1652235lfu.120.2021.07.07.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:18:50 -0700 (PDT)
From:   Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com,
        Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: [PATCH] fixup! media: rc: introduce Meson IR blaster driver
Date:   Wed,  7 Jul 2021 20:18:28 +0300
Message-Id: <20210707171828.6967-1-viktor.prutyanov@phystech.edu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210707141323.20757-3-viktor.prutyanov@phystech.edu>
References: <20210707141323.20757-3-viktor.prutyanov@phystech.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix building error. I mistakenly sent the patch from dirty git tree.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 drivers/media/rc/meson-irblaster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/meson-irblaster.c b/drivers/media/rc/meson-irblaster.c
index bfcdf47e2100..f6cb47593392 100644
--- a/drivers/media/rc/meson-irblaster.c
+++ b/drivers/media/rc/meson-irblaster.c
@@ -215,7 +215,7 @@ static void irb_send(struct irblaster_dev *irb)
 {
 	reinit_completion(&irb->completion);
 
-	dev_dbg(irb->dev, "tx started, buffer length = %u\n", len);
+	dev_dbg(irb->dev, "tx started, buffer length = %u\n", irb->buf_len);
 	irb_send_buffer(irb);
 	wait_for_completion_interruptible(&irb->completion);
 	dev_dbg(irb->dev, "tx completed\n");
-- 
2.21.0

