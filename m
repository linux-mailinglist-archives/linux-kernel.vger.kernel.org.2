Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1519034A3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCZJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhCZJJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A9C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so4916806wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0yMVqW3xU8ivRsQX9coWO8CDIq3UwDkxu+DQbFWhy4=;
        b=ssv9pVDqic1QfLIJEOGqjuWrhEDbMIbe//neuILBFdYD8dUkXxLNK3QBm+6x1LsiPs
         IrEzqIx4G7LPjNtVXfJQ6KKBgYRIMTrqt1yo+qyHUpLtzUbej2X0Xr/jPTAHHkLfnnpc
         YeSXlSKovcYeGn3iVAPA22E2rvWWQkpq/JUoSwHERaYdYZ1C0QKqAYMXAssxf4RfpoZB
         EWz5I3++CLSmNR3Se1jA31d8CSbcpmHNiR+wuDG62geOwXVYy60Q9GNAE6a9xfShAJQz
         QbWyTHsB//olwqxMKandZtRv39ranI2bMqXsiaCWDYDWUvHrvKCKMJhySokApTzISUoa
         v30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0yMVqW3xU8ivRsQX9coWO8CDIq3UwDkxu+DQbFWhy4=;
        b=KVJ7rvawKjRtmhGWNY1ZtRoZT2O28k3YSz4wBa6OmmtVnNhX2w1xsGrdW7qi8V8oni
         9ED25QtTtFqFqZdg7sgJN5oi+eaewihK9ZjKOP2sAZcbg+WDumzG3SGZlVZ3RYA1XapR
         a9UXgy/bScziQ1r3IsCtoxW7pcSb2MHdV9caNBuyphdU6ux/piAx3K/PHn8sUrSs4uPC
         KzeFGwWc4mqvZyeA9mXlNNqnMnYcqDScJxuqw/srpMtMP80d79p1cMENsaOnZPsOUAZQ
         ulyab5R0mvEkdc+V3UpPquXPj84SbCa9gU8DYSKxGf668vKRQtepd8Tewt4MULkv5ELB
         wKbQ==
X-Gm-Message-State: AOAM531wwb3Wkwy11jOc9K9iEPdT6B6AeiP7y65pGeeFBJ4AXOKePqpd
        KLx/RJABBksRqtcIozf83mU=
X-Google-Smtp-Source: ABdhPJwCmVxgl70iKvbHrURJuv/d7rGKRo6JnFdGfWmtBUxxo9hxjL7Sco8AsznpDx3wZTvJxKmbWw==
X-Received: by 2002:a5d:6c62:: with SMTP id r2mr13955449wrz.62.1616749785563;
        Fri, 26 Mar 2021 02:09:45 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id j20sm9648773wmp.30.2021.03.26.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 03/15] staging: rtl8723bs: put parentheses on macros with complex values in hal/odm_debug.h
Date:   Fri, 26 Mar 2021 10:09:10 +0100
Message-Id: <29c07f6a5b8fbb2d99321bc9f373631456a51613.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

ERROR: Macros with complex values should be enclosed in parentheses
153: FILE: drivers/staging/rtl8723bs/hal/odm_debug.h:153:
+#define ODM_RT_TRACE(pDM_Odm, comp, level, fmt) \
no_printk fmt
--
ERROR: Macros with complex values should be enclosed in parentheses
154: FILE: drivers/staging/rtl8723bs/hal/odm_debug.h:154:
+#define ODM_RT_TRACE_F(pDM_Odm, comp, level, fmt) \
no_printk fmt
--
ERROR: Macros with complex values should be enclosed in parentheses
155: FILE: drivers/staging/rtl8723bs/hal/odm_debug.h:155:
+#define ODM_RT_ASSERT(pDM_Odm, expr, fmt) \
no_printk fmt

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index be0d4c49a747..e6eb517c8685 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -150,9 +150,9 @@
 		} \
 	} while (0)
 #else
-#define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)		no_printk fmt
-#define ODM_RT_TRACE_F(pDM_Odm, comp, level, fmt)	no_printk fmt
-#define ODM_RT_ASSERT(pDM_Odm, expr, fmt)		no_printk fmt
+#define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)		(no_printk fmt)
+#define ODM_RT_TRACE_F(pDM_Odm, comp, level, fmt)	(no_printk fmt)
+#define ODM_RT_ASSERT(pDM_Odm, expr, fmt)		(no_printk fmt)
 #define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
 #define ODM_dbg_trace(str)				no_printk("%s", str)
-- 
2.20.1

