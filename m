Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968F9369568
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbhDWPBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243216AbhDWPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A8EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso1397968wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLOdNZ/idN2fC5170Bm5seBXbd2GYVgAZ5BDCqnR19c=;
        b=aod7+aPNiNKQAMp0W2plcRzk8x31djc5622YBkgxfjyMSqtcUqvCCiDQzPmmPCskvT
         eIjHX1JI/ENQyVezzC1KeaHFqG6Cauifv6mkamS1K+PF/Yqx8SL8e84y+aFiTQONunrB
         kwPMtVOKSrmAvRmKsiRFwDe/+ca6s29btZVXwAS4JfbewoFHgupiJ33g63zWOd5DiCl0
         WBzPPPfqw5LxfX+6uMLQcsnhOdzDra0EKRs9Oy8woEFtV9d0viz1adOZ93sFqDWxOUhu
         VzzIagbiAj4T+zpCp8hokdYiwLthidQHjK4fDckPZJiiRDwC0g70PVC/FDqzcHXT1lpm
         d6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLOdNZ/idN2fC5170Bm5seBXbd2GYVgAZ5BDCqnR19c=;
        b=Em/BdttZfn3WBaGyW0XupoXPRS7UgklauK+D47sC1nYTB+7vnSqGh3Q+ig9w1yjm7S
         eIH85FLFyOWo7Aw5a+HZu/kd+M8ga4T46buT4uhoHOQgm9K0wY/UnnkaUJzrHfoAY7nz
         y8WWiCyJAhA/SvEOSDopIR54sRpt12qfnqBd1+ml9nxVfxp6ys1iHb/F6jWMvDWWAfEX
         V98Z3+xrHSEWV5IklZiONtgqXRJBMUnx6gYIdpkHVSi43TT1C23Kz4k51wh2/XkQzcwf
         XVuxOj54uTpaRKTkQw9yd+rwPd27x6ndOLTTl/+H2YDhDaxMz6AmwIJpIt4UK/jcSr9g
         phSw==
X-Gm-Message-State: AOAM532kOgheat9A/NfQipB1w1q261/mheGDV3K6XCBnWRX+NFmc9wKY
        woZGJbwVzAA+SFXjVIYgDgY5ohU7jxE=
X-Google-Smtp-Source: ABdhPJxQwwfWTy9bI4BHrXeCngvD4Sxiknfc5S9lQoPOc5ozpOoQfLoKJbDjEgfnkMPoHtF01c25bA==
X-Received: by 2002:a05:600c:4ca3:: with SMTP id g35mr4698508wmp.16.1619189974410;
        Fri, 23 Apr 2021 07:59:34 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id i4sm9884907wrx.56.2021.04.23.07.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 32/49] staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_SET_C_ definition
Date:   Fri, 23 Apr 2021 16:58:23 +0200
Message-Id: <2c8bb6a90d94b91056edfcfb26aaae112ad1402d.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
 _RTL871X_IOCTL_SET_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 501155c8c9cf..7f84bc03e9c7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_ioctl_set_c_		BIT(17)
 #define _module_rtl871x_ioctl_query_c_	BIT(18)
 #define _module_rtl871x_pwrctrl_c_			BIT(19)
 #define _module_hci_intfs_c_			BIT(20)
@@ -26,9 +25,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_IOCTL_SET_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_set_c_
-#elif defined _RTL871X_IOCTL_QUERY_C_
+#if defined _RTL871X_IOCTL_QUERY_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_query_c_
 #elif defined _RTL871X_PWRCTRL_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_pwrctrl_c_
-- 
2.20.1

