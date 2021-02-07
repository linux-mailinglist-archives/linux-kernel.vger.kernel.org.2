Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C993122DB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBGIsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhBGIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:48:00 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC6C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 00:47:19 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id c132so8302166pga.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 00:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MSOtbkRts0dq72rCJZ6QlGW7loNrEWjczBlotgsaBB0=;
        b=XFxOhEMTTe33pjj2QaXwOpFkSitvEgDrNFDrY/Cl7on2fv7sryeOSZjFWFD4RwEYYV
         hwSKp3TpiG6HfoO8hUTcRGqHR5T6IkvHzdCbt4t4w1n8mwvfdUdl5pnVNymNMwuzz6Sp
         i3On5hW4ZyR7y5Z0/7kDcIgytYsoocq/OQWQsbeLKzOQEeiiohnsuwT5g8nVqFdZ9YGN
         UBswNGhOSVAcuMSA4t28jrURzv3iiBVmZ+P0A3VMhNG9LrFdSV8tgTzJ7kzm7Ht/ZVjZ
         9WHD1nhW9tOqs9sG7LBAF6Udg+xPMQeUk8LwFje2EcR12L6YzFWfFT1cDP/OVKXTsZwl
         Lowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSOtbkRts0dq72rCJZ6QlGW7loNrEWjczBlotgsaBB0=;
        b=OU/5cOiBbI443m4nYndepsmDBJPR6AU0YMl/5ipTQ7FowfBu4p8ON/HrN6CxT6RiZx
         LgA3Yg7EgYq8zlFspSBRBoPUcuzzhd+5A44/zIScip05cOSE41gZiNFguvLdgpkgU+mI
         nYw5JVnLC/MkedA8bSwmqsyCOvHuyfD/wa2QzwlqGhg3rLL8EnGryiBn68cLILyPKkt5
         uYTz9Wgi0eCL5doM6bbpGoHv6KqqRWXO3o5eoOQlXxpPEJQ4kGZOvRWlOvOhCgw5gH3h
         UShL6S3ofjgIv9DLJmHaUBDpDw7SsvWhNuwu3LgOgYmGtQ1vdvxVqFUDz3/Is3GPwdpN
         lUxA==
X-Gm-Message-State: AOAM533XNCiueRPkaxOp5/uMwxDoRIQHVFLLpscNgYbALYeKUEFllDFC
        PE76K63gh26lf2JLLdfBWck=
X-Google-Smtp-Source: ABdhPJx+Flg0aBOtmQsE/DkdjH6hG1Cz9wQHFXPH+ikdUSKdOno56Otfi20a7rMC4Vr52Va2RIBbYQ==
X-Received: by 2002:a63:c741:: with SMTP id v1mr12345015pgg.316.1612687638463;
        Sun, 07 Feb 2021 00:47:18 -0800 (PST)
Received: from localhost ([2402:3a80:11d2:b946:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id e185sm15380030pfe.117.2021.02.07.00.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 00:47:17 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] staging: emxx_udc: Make incorrectly defined global static
Date:   Sun,  7 Feb 2021 14:16:58 +0530
Message-Id: <20210207084658.269898-1-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YB+l1t/k4VuSw3B9@kroah.com>
References: <YB+l1t/k4VuSw3B9@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global gpio_desc pointer and int vbus_irq were defined in the header,
instead put the definitions in the translation unit and make them static as
there's only a single consumer, and these symbols shouldn't pollute the
global namespace.

This fixes the following sparse warnings for this driver:
drivers/staging/emxx_udc/emxx_udc.c: note: in included file:
drivers/staging/emxx_udc/emxx_udc.h:23:18: warning: symbol 'vbus_gpio' was not
declared. Should it be static?  drivers/staging/emxx_udc/emxx_udc.h:24:5:
warning: symbol 'vbus_irq' was not declared. Should it be static?

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 3 +++
 drivers/staging/emxx_udc/emxx_udc.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index a30b4f5b1..3536c03ff 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -34,6 +34,9 @@
 #define	DRIVER_DESC	"EMXX UDC driver"
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
+static struct gpio_desc *vbus_gpio;
+static int vbus_irq;
+
 static const char	driver_name[] = "emxx_udc";
 static const char	driver_desc[] = DRIVER_DESC;
 
diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index bca614d69..c9e37a1b8 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -20,8 +20,6 @@
 /* below hacked up for staging integration */
 #define GPIO_VBUS 0 /* GPIO_P153 on KZM9D */
 #define INT_VBUS 0 /* IRQ for GPIO_P153 */
-struct gpio_desc *vbus_gpio;
-int vbus_irq;
 
 /*------------ Board dependence(Wait) */
 
-- 
2.29.2

