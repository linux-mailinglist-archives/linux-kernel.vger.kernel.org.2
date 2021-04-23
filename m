Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B47369575
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbhDWPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbhDWPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:01:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48D5C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso1398997wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qN9q3YqqahsKFdZjoFQK7gigKnmNtZ3S2NITUyAA5T8=;
        b=Z6BDBr6dS5da9xwSSivzLrMPYrLrS5q2H3C+QkjR7jmqzIjTq4OWiY53IdLbjoko/m
         neBEQOasHg4a2aMnOY93NZYd94KNhf5PcL+pfVzG490gqkhFQ9xAah0oOE0mYntN3XQu
         7362UgO0IYisD02sQReW/P8nfV/oX4kbHbM9049XM7Lt7cHm1uXQZ404HQ3c9ppwEsOb
         q4qskTzwZJqp+6vwxMZ5vHZH9jElZNmAAPP0BpZo0l0CyEBSF6DLwQMaR3gdoO7/k3Jp
         j738DQr3S+mOz29fZP6A3CROffSx3Goc4eZIjdWA9kvJeiPn3ppZLyucoq/ssdG1q3lR
         inPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qN9q3YqqahsKFdZjoFQK7gigKnmNtZ3S2NITUyAA5T8=;
        b=WcomjaxKaBn4fbgeZvzmbK7sUxTpVDCGAAgsNW76iEGw8l4hUcVUJqSGW6s1501m1F
         A3y5Qln0GMS2KVzvXNYChsEU2X0GmIxhkKL0/nXM6Hlj1F5mEjL/3M8rE229fYfJyrg7
         CEhn74B8tRiQc+4F3ilOrk5at/cTWI3VqMEm6Wo1+ZzZzujugSrVKE0iiEokRMczYzEX
         Az6cCYIUXynyLL8jx9d/SreAc3hY6rsfhXuEysCpiOD37UBQZPRCHfHWHsLst9ScJ1d/
         nCDUW49hEFTIkUR7zN1b0gnpzHiuEz1zDaVNSRipjI1VXDsZhemiHzwD9IjDpar9jsPE
         PV/w==
X-Gm-Message-State: AOAM531rP31s0+zI1ogEKHP6PGZtBLg9qOk5LrEqIp89Y/3C7Q7zwg+V
        7tLJ2fcWh+jJcdHilwb6TFLtN8I2X7Q=
X-Google-Smtp-Source: ABdhPJxnNN6SxX1zS8aS0ZDxmiYxqGewL1l6jaZ5ChjtD5AnemZQux5nlo2dV9l75ovQBmbcYPjcTQ==
X-Received: by 2002:a1c:2c85:: with SMTP id s127mr4637079wms.83.1619189991951;
        Fri, 23 Apr 2021 07:59:51 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id u3sm8145835wmg.48.2021.04.23.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 42/49] staging: rtl8723bs: remove unused macros tied to _RTL871X_IOCTL_LINUX_C definition
Date:   Fri, 23 Apr 2021 16:58:33 +0200
Message-Id: <43868b841442c9e49a9bc77ed7a0e72805b976bb.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros tied to
_RTL871X_IOCTL_LINUX_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index a6c2956133ed..550cff9b1147 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_ioctl_os_c		BIT(25)
 #define _module_rtl8712_cmd_c_		BIT(26)
 /* define _module_efuse_			BIT(27) */
 #define	_module_rtl8192c_xmit_c_ BIT(28)
@@ -18,9 +17,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_IOCTL_LINUX_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_os_c
-#elif defined _RTL8712_CMD_C_
+#if defined _RTL8712_CMD_C_
 	#define	_MODULE_DEFINE_	_module_rtl8712_cmd_c_
 #elif defined _RTL8192C_XMIT_C_
 	#define	_MODULE_DEFINE_	1
-- 
2.20.1

