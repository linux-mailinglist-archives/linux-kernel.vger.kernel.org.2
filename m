Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EEA3122FF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBGJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:09:55 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 01:09:15 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q131so7739070pfq.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 01:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HDOBrsAzuKElcA7qlZ9yTgLVVQVK/JHfy+n859Oh30=;
        b=hTDqu+ogfbyEUrJBefH1NDZLWV/9R7Xns8v8K80ALJPTjTJyIrIi7JqY29rJ455pKI
         bplqftu8wsySlImyowff8faJjpcvGo9sjI/LWfBbd0O5OTp901md0n0uqD6FldDrSd4z
         m/h6q0kMKr/oWHJruQWB+HJ6WhUy1YTmbXDx4j16iTSeFTy+5JnP14ifsJhnnUr5Z/a6
         nbyHAiSvfAQrf6amn2nJoE/wKDb+ebEAnt/goAkmEbNUjqlvfML9ifNEVvkZd7HZcr+H
         oWBX5ewbjt7+P55E9u82rlm8eDf/j52Pw50R6NPMNpYEb7+6ewSC7LzUC6VJwYAu+sDr
         hicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HDOBrsAzuKElcA7qlZ9yTgLVVQVK/JHfy+n859Oh30=;
        b=tbVV7zXw5/3h+t9gWZ2P+pVlA9p4QileyGjdLWIjlk3zjMyoqWpj/PGzEJki79H4IB
         bVjwIsFlzreOrPtfRnMa16JPDE63Rb34+MYQKkoChem21ivt2GUGv20A6c/nglPXCevN
         /MvMTKEJ09ZFlnbj7DKT1W5RLZYX263G9mMZJpTsetbVjsTlZ//erZvS0gM3pZ+1qHMk
         tUwYoD+tzbYCCzVyEQcOqnrefv6/xZQm9J9zdaX2cAL8yIo28MivPJeEX3+sdbQeb7wp
         e1pk3JEssijyqCckYw8/Bo/phMLRsRZe3cmsrsM6J7dQumPBJy42P4go0/W1tpwNx9OL
         HQNQ==
X-Gm-Message-State: AOAM532PV6IuiDf92hNna6AQaYvY0CNbntpxPHLlGzNrxtAl5QqJIsH5
        uYJqm2jhYWBv1ElsXvGIwnzRbmXJ3cI=
X-Google-Smtp-Source: ABdhPJwPgES6MZO45w9RWQwiYHp+JPsOrKQM+/wkG5LHLtm0gIKRxBmePOcDQl8id3d+NlqBh0sXCA==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr12375480pgp.68.1612688953916;
        Sun, 07 Feb 2021 01:09:13 -0800 (PST)
Received: from localhost ([2402:3a80:11d2:b946:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id h11sm12883843pfr.201.2021.02.07.01.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 01:09:13 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3] staging: emxx_udc: Make incorrectly defined global static
Date:   Sun,  7 Feb 2021 14:29:12 +0530
Message-Id: <20210207085911.270746-1-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YB+qDND2OmY8WwA0@kroah.com>
References: <YB+qDND2OmY8WwA0@kroah.com>
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
Changes in v1:
Switch to variable with static linkage instead of extern
Changes in v2:
Resend a versioned patch
Changes in v3:
Include version changelog below the marker
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

