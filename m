Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91336956A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbhDWPBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242931AbhDWPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA9FC061344
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so1403715wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmVSxO1mcykbvIqMdlxGXo0H35C2W5D9ZAmsoCB0GTI=;
        b=OLdxmp9Av/zsk0s5yqwtB/NZ4dyzqW22K1eV1Rxujsq5dYtdFSqEB4IufHB9+ZVNQ/
         5WL3es+6P6s+TqZ/IIDi/lPeX9+chJk2dPJmRR2xYBK20SJlYtiH6ZTPU9Rfpa4HFTIg
         +CMYzdihE9uzV1NwuKF7yrDlFL3HmUpHpQJGiuuuCeBpJN3uQPrgA5ji2tkkz+0MkEbX
         bOr7jB6VMv7aYMV4D6yz2w2wdgGrMw4LWO7jvaAjkWLGxlXQmtKg+2FVDieFogmWevt2
         JJb1RAMY8s6vy0uznCc16VBpG8uwjXPWeuL28E2ACuhA3mcVD9LPO2uVU4/1p/eXi8Mq
         PuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmVSxO1mcykbvIqMdlxGXo0H35C2W5D9ZAmsoCB0GTI=;
        b=ouud5EX2b9r9lC1zmXaigMd+kt132WkNe5D/K9Sw6n02CQFudyFsEzB6JB/sv7TATU
         g77gppq0hqEd59mWDsxF881OsuAwkXKIcQPDEWVJqPri4Ea4v9Q8OxEfUJWcl9hJOdY6
         k4WgEuw5a+YEBWwNMKX1mddD/9ySZj+eYwsDfPgljcBuDq8NGuYauhahD/SKlCWUFDvw
         WloLE47C3sfAzaqtrIL/VLe3nV7K0BFF6cGpQ/1CyCGHahRq8T4C2DOjzQNDGjAj5saW
         pee3d5fNb9wjSuFPGHbWALbFBO5+CCyLWj9P1YgT8PzZUAuBhtk8/7oJ3eIpFc5/+xZj
         UeBA==
X-Gm-Message-State: AOAM531LzEzy+gVXU0DygHN1rDXhDLfDKm9PyOA78aaqJXqKmnSS2gvt
        xYoZUgJSOHbCFEzVP6PB2iAhYgTDk1Q=
X-Google-Smtp-Source: ABdhPJxkduUPOHFYCC1TaWEO49AfrlnQGaw0jwkhd0Y3LkAsIYb7fAjvw77/b1WubWA16u+BLbm4Gg==
X-Received: by 2002:a1c:64c4:: with SMTP id y187mr6041955wmb.162.1619189976216;
        Fri, 23 Apr 2021 07:59:36 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id z14sm11149597wrt.54.2021.04.23.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 33/49] staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_QUERY_C_ definition
Date:   Fri, 23 Apr 2021 16:58:24 +0200
Message-Id: <42b01fca3bd206812b42be5716cf35ef5e4f9c80.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
_RTL871X_IOCTL_QUERY_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 7f84bc03e9c7..be44d72599d3 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_ioctl_query_c_	BIT(18)
 #define _module_rtl871x_pwrctrl_c_			BIT(19)
 #define _module_hci_intfs_c_			BIT(20)
 #define _module_hci_ops_c_			BIT(21)
@@ -25,9 +24,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_IOCTL_QUERY_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_query_c_
-#elif defined _RTL871X_PWRCTRL_C_
+#if defined _RTL871X_PWRCTRL_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_pwrctrl_c_
 #elif defined _RTW_PWRCTRL_C_
 	#define	_MODULE_DEFINE_	1
-- 
2.20.1

