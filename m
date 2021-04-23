Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3D369569
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbhDWPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243226AbhDWPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B60C06135A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n4-20020a05600c4f84b029013151278decso1399390wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSvvraOsyd4MG94jxJh7UJBUTaYacvAPHYnMkIY3E2M=;
        b=cK9AmNTBA2PSbDjcCom0pEAGI6jvCVQzk5s8YxOgZWGoOTijH+umBtK6Bb+ApTkvnj
         hkvq8KWi2idjg0l2zpc0T9e895iSROU3GT98x2PAz5Y/IjJB2H9Xk9B/xIq9f8Xn5Gpd
         MggnFfdo1+B2a2aQ5y6wLoBujfO1PKWoHfKzF48BFwRkGeVS51CryjaMqAzDF9v7FPr1
         WAKQJiPBki3SjIMFe/BJh7x3QNoqvXwPEA6dH1LvUv3esRbQ78RhZTyA5I9qWPhvMHpv
         oBA0xLpEhewX0OgeZsznVMvAuuW38blBEAtMWocC8jaeVJsqcQKY/m0aaOq1LZPBxwun
         k2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSvvraOsyd4MG94jxJh7UJBUTaYacvAPHYnMkIY3E2M=;
        b=TPUCqGFEJC3KRE7Zilm38gDkNTRBmOuehdK+fHGKSxtnMxLpzuKbYqrvHJAdpcGdw0
         +mhIYGuFJixrtvrQ+UQA31c2w4vfqRZ3gC5RllaUNZvokdyKVWEpvPo88UTy8UfX9qio
         2l06pKWXSf8fJQnKFcMwP+MME6zs2MkEH+K5lZsCbwPaEJ1YwTjgyDCEm8lldH33SzTa
         u3cfZ/BsDOQ2QMEBdDlpAOS0mLSC98vXoVVP1SidnPyECyjbPCgwhFf5wY/Lu+u5u+nl
         CSYIAatDLzEYNfB5UTS0dXl/KwnPKvZQZY+ei21eBkw4rG5Tfk/ZeZpJjRoMJT/wsaR0
         x36A==
X-Gm-Message-State: AOAM5326IY8b+jQcaS27jmkvGaScEYgtkYLAbGYU5YzU3tof1I0mrVWd
        iGMi+d/7i3sRlmLF3JqVFKGsrLUZWuo=
X-Google-Smtp-Source: ABdhPJwdKOO1KN41Oe4j65u9hcZu5yRrb1P6u0JJU8sG4CLL6/1JoqSy+LQnYubFgOcLy4yEtCTIpw==
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr5961545wmi.140.1619189977813;
        Fri, 23 Apr 2021 07:59:37 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id y19sm10940227wmj.28.2021.04.23.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 34/49] staging: rtl8723bs: remove unused debug macros tied to _RTL871X_PWRCTRL_C_ definition
Date:   Fri, 23 Apr 2021 16:58:25 +0200
Message-Id: <2cddf05171502de8660fda2d75621fa53a05d7cd.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
_RTL871X_PWRCTRL_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index be44d72599d3..8e324313ebf9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_pwrctrl_c_			BIT(19)
 #define _module_hci_intfs_c_			BIT(20)
 #define _module_hci_ops_c_			BIT(21)
 #define _module_osdep_service_c_			BIT(22)
@@ -24,9 +23,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_PWRCTRL_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_pwrctrl_c_
-#elif defined _RTW_PWRCTRL_C_
+#if defined _RTW_PWRCTRL_C_
 	#define	_MODULE_DEFINE_	1
 #elif defined _HCI_INTF_C_
 	#define	_MODULE_DEFINE_	_module_hci_intfs_c_
-- 
2.20.1

