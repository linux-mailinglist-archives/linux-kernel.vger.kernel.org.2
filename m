Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18370380151
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhENA6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhENA6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:58:42 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A90C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 17:57:30 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c16so5637358ilo.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8NQKucDlsKkxpg+tgse/goMcErijkf42rV8EohDD7E=;
        b=XPPSHBsT1q8Fxl+w7tsnDyetbBVg32loktCtiMutZPMZIISb8G6/GOpGW/bBxc7Fyk
         ovDFeN8lUi41edNc42vxwYIpcbQSWxIimpk/T9X4PdIro4BqkmTQEQIl2BRbrflIHNtL
         FR32/T6odk0CN7rtrJxiT9yaelI1GYH8zx7ipxdWXMtE3dENIKAEQcir1Y6jXo62X44O
         2B0r5QCCaySuiDu1AOCDk3UAYtbNJqNq9GXDlgLfPkJIWZ+NDzqKYJ/x80gq7GyD3zd4
         wecV1mmOxov5sOzjwH4D3cMXaUlU/PFSBZ3xaqkdtbKrJH7k5MiA/gs3wQ4kGBXtlwyq
         LHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8NQKucDlsKkxpg+tgse/goMcErijkf42rV8EohDD7E=;
        b=k7FMkRkwB5fWZx0oPLMnPTtc1XH6LGUsYyHaMun2sjR+mSAvz6fAlw5E6OqPKRewoh
         LLA7/Iibt5mjTIvnuofNyeIGqddM4q7aEoe9lkDEiOfUWjTmN9efTiXZQTh++khcG/dt
         qDDbArLXo4DhdgQrVEek/VpBD46a69zHIUZNdq7gRD2ruJ9R3+/QyxL68x7/6j54iqr+
         kFMuUarQaO8k9GnE9awoQK3uOCfSDfMcrLPc7+mYIpo0NLVkdlcW7rksrrBBGgy9vJc7
         WrCcnjxHSdlq13tdfUcT79Ena24GTds/jAfmjAfSHIsvSmU0w6Ai3ZSSrjdB9wzV8u79
         35fg==
X-Gm-Message-State: AOAM532ymknj6nUNXLuu9EbSkgaH9APFK1gUhlUvkWTSvy3o7bpq0ixE
        aSbBjQCkwfyMhfwZ7tSXN+E=
X-Google-Smtp-Source: ABdhPJz55umq4EwDtw961MeN5IVmysZGtNDtXlv5xDHKKiDYO8Bs+8fzkkIvkTpg7mxfFPiPP4ae6A==
X-Received: by 2002:a92:b751:: with SMTP id c17mr39545880ilm.121.1620953849854;
        Thu, 13 May 2021 17:57:29 -0700 (PDT)
Received: from localhost.localdomain (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id g25sm1981538ion.32.2021.05.13.17.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 17:57:29 -0700 (PDT)
From:   Connor Davis <connojdavis@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Connor Davis <connojdavis@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] xen: Export dbgp functions when CONFIG_XEN_DOM0 is enabled
Date:   Thu, 13 May 2021 18:56:49 -0600
Message-Id: <291659390aff63df7c071367ad4932bf41e11aef.1620952511.git.connojdavis@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
References: <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export xen_dbgp_reset_prep and xen_dbgp_external_startup
when CONFIG_XEN_DOM0 is defined. This allows use of these symbols
even if CONFIG_EARLY_PRINK_DBGP is defined.

Signed-off-by: Connor Davis <connojdavis@gmail.com>
Acked-by: Juergen Gross <jgross@suse.com>
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

