Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53EC31F5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhBSIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBSIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:07:21 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC6BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:06:41 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id r23so15770239ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RlsUMZyywPPv6rRey6PD7JMivM7n44tU4Rz5J2JivFs=;
        b=lfQzXkaqrVPedySkAV2YH4sm9yksnW7wBJwfUETDPN7cRLj39OTnURXob/0iYL/pL8
         EMEzUgy1Q+THyS5zpVP/1WW37hqbdJ+SzLj7/kEpKj6LiX0tPAlRXEAB43cCJtUwqW5Q
         u757lHjqTgogPARvcX/lXQ3KG433Z15rKAuBznljFItnR8ujKh7E4w5pthPGmfLLenww
         GxtrQJ90qws0Ob/DNzJl4z5he4+MdSS9UF8ocwpD8MUn9FBVPJMVzFWlp2T0hvFJlVH4
         HkJQfXO3TP/OQtDK1W+kMpzbA6/iCGnx2F/k4MvCZ4bMajxr0of/+y0gakpaPq6FFXCd
         Uukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RlsUMZyywPPv6rRey6PD7JMivM7n44tU4Rz5J2JivFs=;
        b=awBYMXLtyS1cil1q96AYffxfRqeLbW4KQF0U7+ciDxYWqVVomd8oN8EjKVKfXuaOJk
         8fWT/Hvb8pormQJaPX1cleAGSXWFcQn9O8e8HXXsTkoZigBkpqDJPexBVhhlikt/wgt5
         o19K0RGVDbRslHzx+KNe5q+RE3g5VXmUEtfA6Q6QUboJmZRHK1B7m2Vyo12yExT5rvCh
         /WuVlER0spyncKnJUeTBuNI1m7a36m282SbNCnRH8FdXzFzGW4qN4iLMgIyXMNniALoK
         O3KsSrrpJfbV9ehXki3OZWigs58H9JWCEWfj2kyDIwNKTprscbNqqIALUM96Erane7HU
         ZV2A==
X-Gm-Message-State: AOAM531O/YNQzLhZ3VS3SHZBKIaGQUS9Yw1iI9qDj5D9bmORS3xle8of
        fzQ1vNWM1ext7we3PgklQaY=
X-Google-Smtp-Source: ABdhPJyjnthC6rpV/Ng2rzTbb2CAke4EkOdh0JyWndjzEfXQYupmlQzbOxA9/13CPUjdAkAGTltoLQ==
X-Received: by 2002:a2e:b16d:: with SMTP id a13mr5028924ljm.39.1613721999591;
        Fri, 19 Feb 2021 00:06:39 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id c12sm850815lfi.244.2021.02.19.00.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 00:06:39 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, sergiu.cuciurean@analog.com
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: kpc2000: code style: fix alignment issues
Date:   Fri, 19 Feb 2021 11:04:51 +0300
Message-Id: <20210219080451.19857-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <YC7TiCzbB+4ppzdk@kroah.com>
References: <YC7TiCzbB+4ppzdk@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warnings:

WARNING: line length of 124 exceeds 100 columns
CHECK: Alignment should match open parenthesis

in files kpc2000_i2c.c kpc2000_spi.c

Additionally some style warnings remain valid here and could be fixed by
another patch.

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---

v2: Edited changelog, as suggested by Greg KH <gregkh@linuxfoundation.org>

 drivers/staging/kpc2000/kpc2000_i2c.c | 6 ++++--
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 25bb5c97dd21..14f7940fa4fb 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -200,7 +200,9 @@ static int i801_check_post(struct kpc_i2c *priv, int status, int timeout)
 		outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
 		status = inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
 		if (status)
-			dev_warn(&priv->adapter.dev, "Failed clearing status flags at end of transaction (%02x)\n", status);
+			dev_warn(&priv->adapter.dev,
+				 "Failed clearing status flags at end of transaction (%02x)\n",
+				 status);
 	}
 
 	return result;
@@ -269,7 +271,7 @@ static int i801_block_transaction_by_block(struct kpc_i2c *priv,
 	}
 
 	status = i801_transaction(priv,
-			I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
+				  I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
 	if (status)
 		return status;
 
diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 44017d523da5..16ca18b8aa15 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -465,7 +465,7 @@ kp_spi_probe(struct platform_device *pldev)
 	}
 
 	kpspi->base = devm_ioremap(&pldev->dev, r->start,
-					   resource_size(r));
+				   resource_size(r));
 
 	status = spi_register_master(master);
 	if (status < 0) {
-- 
2.30.1

