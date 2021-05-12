Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1212637B2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 02:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhELATj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 20:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELATj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 20:19:39 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 17:18:32 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e14so18705249ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVffP2AoY7DIGJlRpw6y32EVHjpd/fv+1cj2j/7FT4M=;
        b=HKnovley9S67BXN2eY+XSVLSSfFtLlQ2kmN/4O2HSj64YCc9GppYzEoOrRHHfVAP1J
         op9/qFDgSnmNQF7nldySt19Ck/ztvAFJ6asAk7LlNvKUjYpm3cxnJwCx7KhTqMgBAhmR
         1miUzwF4xB96xw+Vz0cMh4OX2JIlMJ+ufYnYZPt0bs/0GIqb4Co9/FvPEZHjq0lL+uyH
         7U3ZRyoftT1gtjpnIhcVjYD3xlF3jJVWxk1LSuTxfQORCUjyi3/7t9WLCssbc2fObi3C
         Ypz+I4182NPMJ9Awk/vb3fDmosz2pjnGIuXCdvirAz8HKUTvzI/iYCdH93CH5EPbwBT9
         nIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVffP2AoY7DIGJlRpw6y32EVHjpd/fv+1cj2j/7FT4M=;
        b=EB64RsmcvsiMP7S0B/+66GcDx4wFDZoloyPi3wzZGxTCy3TCulKEcMS8O6bkH8fVeL
         DWeAFL2A2v3MlwQyN/mxTkM16gjne27dd/SbLwvcS6hjb+8HYZ2IRdFj0cZQcuQQgpgZ
         9dYW4OBDG4SzvIaYeEbzULRe7ukg7wqFZa+7dwwhI9pX4MENy0iIfHXaPkdK1s01Lhbe
         3g0QQPjXwTGvJ7WDJk2oJUQa0toDj8RyNw8/7m2AUGHr3vrOGML0EezYxW8MfEJhYmLx
         mYvJlNDV18zLgdc6EsDPObJ0Fm8e5BuGK8xbtVaq1GtrHFjr0ldMH0lrQYaOldcSYjk6
         FI6A==
X-Gm-Message-State: AOAM533BYUbsPZoyagmnEM1TOLbXdBA9CtKSznbGm6kTlo3HEvMPml2t
        EtwTFDpudpFIFXqp8dDMGhw=
X-Google-Smtp-Source: ABdhPJyGiX9C7qlPKoElf5vX50Gg7NyKG09/3UfVmVSHmJj770UiKDP6hzvjmA6DUZd/5xzM6KdSFg==
X-Received: by 2002:a05:6e02:1b06:: with SMTP id i6mr14387567ilv.139.1620778709944;
        Tue, 11 May 2021 17:18:29 -0700 (PDT)
Received: from localhost.localdomain (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id v4sm8241490iol.3.2021.05.11.17.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:18:29 -0700 (PDT)
From:   Connor Davis <connojdavis@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Connor Davis <connojdavis@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] xen: Export dbgp functions when CONFIG_XEN_DOM0 is enabled
Date:   Tue, 11 May 2021 18:18:20 -0600
Message-Id: <291659390aff63df7c071367ad4932bf41e11aef.1620776161.git.connojdavis@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620776161.git.connojdavis@gmail.com>
References: <cover.1620776161.git.connojdavis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export xen_dbgp_reset_prep and xen_dbgp_external_startup
when CONFIG_XEN_DOM0 is defined. This allows use of these symbols
even if CONFIG_EARLY_PRINK_DBGP is defined.

Signed-off-by: Connor Davis <connojdavis@gmail.com>
---
 drivers/xen/dbgp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/dbgp.c b/drivers/xen/dbgp.c
index cfb5de31d860..fef32dd1a5dc 100644
--- a/drivers/xen/dbgp.c
+++ b/drivers/xen/dbgp.c
@@ -44,7 +44,7 @@ int xen_dbgp_external_startup(struct usb_hcd *hcd)
 	return xen_dbgp_op(hcd, PHYSDEVOP_DBGP_RESET_DONE);
 }

-#ifndef CONFIG_EARLY_PRINTK_DBGP
+#if defined(CONFIG_XEN_DOM0) || !defined(CONFIG_EARLY_PRINTK_DBGP)
 #include <linux/export.h>
 EXPORT_SYMBOL_GPL(xen_dbgp_reset_prep);
 EXPORT_SYMBOL_GPL(xen_dbgp_external_startup);
--
2.31.1

