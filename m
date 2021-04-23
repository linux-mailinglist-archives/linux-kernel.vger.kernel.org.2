Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB90B36956C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbhDWPB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243084AbhDWPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0415C06135D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n127so14395031wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2ZqN65XK5OLpZsVVr1uV7MpQbBGCFzPUcE3WgPQfd8=;
        b=LU6fG8LK5Nq/hu42LHl4OviF94U0MEb0Sl10IkPPqTO0r6LlES2WyC+wZfLXGeb+eh
         PE7b5xphwJREZBCe9PQTFwFZWyN2V62Kjre5D29TD10ZRRyC4Ndji9MeWSd4db5ihU7d
         Kmo5n3I06Po2pidoIcB3bXCLQb6JF2BarffmjigqLobXNLVt1IYTentnIHdvBN/Bh7l3
         rely0EpbUtfPe67IZ18VWBIljD6ZzZCStANNt6ZP6DNNS7eFtUcc7nBtGdvgXffJ4IdD
         WCROW02n+x4Rjnq75l9UoK/aibH5W32m3i0h1Ki/BG5xYSuGek3Nd5Nw0iZSrdEiUern
         9HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2ZqN65XK5OLpZsVVr1uV7MpQbBGCFzPUcE3WgPQfd8=;
        b=fNXsx7rccaYtBLg1nGNJQoo1C747DY0o24n1042J1TjDzweSfCN+o165zkaOq+oa4D
         KuyF5NwlUe7qsVWiCfTJumtBUeSKQQZt18pgz7P5c6TCUv4YHgCPX38l/Y61MaduJOKD
         pdd1PJzEkYwU5aatkVfpSC3hRUU8CSw9C+2lgEuhaXZ+1/pKAYu49PdtvMf0gxbFSiAZ
         XAxnnRlcQ/dFRjygmxG1b+JIvkDTV/ht49NmdHBYaXIQBiB4YT9SxkXGbnXdKI1FalAu
         U6w18660jgOFdlZnQCh11E83RkUPl8OmeRxJErh+7KbB4ypGhP/qqpwjsVD5HYkZc/xf
         wQig==
X-Gm-Message-State: AOAM5314otL1QXGIoSriELF1j7OKN/1GIjUtF33Fy5Is3v/quUwJNILL
        8RFtjDyeV+0pyeQSD1b3Em1BkvVtRPs=
X-Google-Smtp-Source: ABdhPJyIsuH1zpUltFbE6JMtTB0sdJtKZ7cysrosmMsM3pcILp1rVlX98IUQugXQbCkYCxvx8tzK1g==
X-Received: by 2002:a7b:cf38:: with SMTP id m24mr6103496wmg.148.1619189979455;
        Fri, 23 Apr 2021 07:59:39 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id h14sm11169749wrq.45.2021.04.23.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 35/49] staging: rtl8723bs: remove unused macros tied to core/rtw_pwrctrl.c debug
Date:   Fri, 23 Apr 2021 16:58:26 +0200
Message-Id: <f237c8cd3c81b652d73e56f9be3557488234d0c6.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macro definitions tied to
core/rtw_pwrctrl.c debug.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 251b9abdf591..a392d5b4caf2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_PWRCTRL_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_data.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 8e324313ebf9..a7f6827c282f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -23,9 +23,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_PWRCTRL_C_
-	#define	_MODULE_DEFINE_	1
-#elif defined _HCI_INTF_C_
+#if defined _HCI_INTF_C_
 	#define	_MODULE_DEFINE_	_module_hci_intfs_c_
 #elif defined _HCI_OPS_C_
 	#define	_MODULE_DEFINE_	_module_hci_ops_c_
-- 
2.20.1

