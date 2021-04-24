Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB23F36A051
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhDXJEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhDXJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB568C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k14so765782wrv.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIhM6s/LWPN2qislBbfeytQsgbBH4Yl1FLgMdln/Wyk=;
        b=ssPNMkGOWzBKCuCGMww0jjdHGD6Xug2jimuwxTwVYEagQrxYTMGjBPVewUa7K3E8RH
         nSjoZmlG7EyHM6lzNHTh9/p+wLPGJ02TGFBR1kkwbNtRTBbV6T2D0HJg9DoE+FB+WbRv
         M23bOZJdADvAVq5Eaq94nojyu9pYxqU5qu+ltfdbXIOETVy5maVDAt9Jhp04PQly0ge9
         pHL6OYTrjKpcDZlDbloNXFAq3XQG5p6UQgtkF/8perTsCeOtFLqTkP1fX8KBpeKmfwMg
         J4kpF0qr34BnPIlf7q4ZtHE7WL1wzt2Mfr7XhS2mpC9b8fFGbNq4l+Jn6vDFe54IZxCL
         VZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIhM6s/LWPN2qislBbfeytQsgbBH4Yl1FLgMdln/Wyk=;
        b=NpMYPdAjvYgLUrMn4lYhtiTKiC0sbQIRO3QlYzWuBr3Bo9jEKqc9alw7AWXfjl2P+B
         /Acsl6hBSAVa4alXdPjtTHJkCq4W12bcKfD8VSGyPvQx6Jmz5cnINWzuCgsqnLgq47wq
         /nG2q4HvPsx6W+XOSq7YEYlgmewzFiw/voBnB+WfOKqnXH+n89YjDr6HCztOKhRIQ1dJ
         U4wtFSnMXX/Oh0hnjeDWCptGvbefCeGDEfcI1U6UsuMjm5QpUPiB9h828LpVY3Peh/6y
         rdZtqm5x5LdGxL4ynEO9iho77aoG/qOdJP3WR3YzKWUP3UTreIgmmrze4/bUsSoRPtHi
         XzVQ==
X-Gm-Message-State: AOAM530aakM+KnecJa385hrO/TWAqkd1C77mbYOpWROUT9IetlhJuAYd
        3sWhGpzSayyLvcADqwxp/1NJ77HvevL0aw==
X-Google-Smtp-Source: ABdhPJww3HKjIGR63C8N1YOYEe0r6MeYp68XgZlY7bfHoQaU/nqI+VS6+d+NczTahURo5k3O8ki5rw==
X-Received: by 2002:a05:6000:1564:: with SMTP id 4mr9766468wrz.197.1619254983756;
        Sat, 24 Apr 2021 02:03:03 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id m14sm387546wmi.39.2021.04.24.02.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/50] staging: rtl8723bs: remove debug macros related to os_dep/recv_linux.c tracing
Date:   Sat, 24 Apr 2021 11:02:00 +0200
Message-Id: <7461d3589ff726ad3c61bb8c6edb1f177fcb0532.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macros definitions related to os_dep/recv_linux.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 422d6bcfcc6f..d04f116bc9a4 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_recv_osdep_c_		BIT(3)
 #define _module_rtl871x_mlme_c_		BIT(4)
 #define _module_mlme_osdep_c_		BIT(5)
 #define _module_rtl871x_sta_mgt_c_		BIT(6)
@@ -40,9 +39,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RECV_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_recv_osdep_c_
-#elif defined _RTW_MLME_C_
+#if defined _RTW_MLME_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_mlme_c_
 #elif defined _MLME_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_mlme_osdep_c_
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index cd51430d4618..88a69c7ca8f2 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RECV_OSDEP_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <linux/jiffies.h>
-- 
2.20.1

