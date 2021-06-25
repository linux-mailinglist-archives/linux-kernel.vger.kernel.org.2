Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20D23B39F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhFYAKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhFYAK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:27 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:07 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id f16so4310199qvs.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IdP6173OvGMXvCi/zM6T3ofP3z8rnih6Sxt2r3BfdM0=;
        b=VntY2aoDqoad8QmR907pbvocFofYK/i4WtxjG0SgmCL374+EqJFWY3KypPONDX9dHG
         ycnfrtZvzZN9t6tshJnH/yWVRSu0letVU4fCLSBbbbZFoGcRpW6/siP53hriGInUj9IJ
         kqrchinoRHBDWj6bYU96z3veIbblW7OQ0SDMuX0/KkzFHQI3OLnAIiMnYcmOSl+P02ep
         cho9dJTvNBRfXr78PmEHnuL5oqAEArxjbfT6opevChY17f2Kj/Dqg3kpro7YCTXVf8Py
         X1Is42Km5zm/igzXivtBG2SoUPrz6TKGNQZjiUX/k6IHykrm6Ja85hMrd1wFgYR8g50W
         4rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdP6173OvGMXvCi/zM6T3ofP3z8rnih6Sxt2r3BfdM0=;
        b=W4gnozCQiaFBzeIhoMaF8BL8mFQNLYQOw0X+R5c9gnNTS/+IWdnnxJYm2pgQqoC8Ul
         J+VbSrUPtFfIJb46e2NUm9qoLBe1OrxKH0djFsVzfhTcE344FDNScACjM6qtwinZEJYH
         nhH+HUOWAa3hXCMhuWg1pab8eOEBifpYyhEPuHCzG8nkmpDzltd+yoBdAy9sJX78QuXn
         TFfx8oe80xHYdVv5/GKCaI8QcSXnBkxjMUPf/92ZRztbAiWPK1jUOo/Sz7ZCKB1SnvIO
         /T3L5WWllwrAxPc5KpiYjHSDctIrB1cemw1J4YTwOw4mh2DZEQX/ELaiq7yDfXAK4JsD
         snWQ==
X-Gm-Message-State: AOAM531ZvofxbhyraRa1QxwUR/nCYOBhmwDPzheeE/+WMeq7MBLNp5kn
        FPBYwoq/RodX8X2Lp2m0+aggGA==
X-Google-Smtp-Source: ABdhPJzx7bF9fnG9gsVkf0UfdLMrIDFh/hZcE72ELSFONualK4kgZT1dawd/2OesiCc/IOSgISpejg==
X-Received: by 2002:ad4:574d:: with SMTP id q13mr214970qvx.20.1624579687053;
        Thu, 24 Jun 2021 17:08:07 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:06 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 04/23] staging: rtl8188eu: remove all RT_TRACE calls from os_dep/mlme_linux.c
Date:   Fri, 25 Jun 2021 01:07:37 +0100
Message-Id: <20210625000756.6313-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from os_dep/mlme_linux.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 8af58e847afb..f12d8a707376 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -87,12 +87,8 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	u8 *buff, *p, i;
 	union iwreq_data wrqu;
 
-	RT_TRACE(_module_mlme_osdep_c_, _drv_info_,
-		 ("+%s, authmode=%d\n", __func__, authmode));
 	buff = NULL;
 	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
-		RT_TRACE(_module_mlme_osdep_c_, _drv_info_,
-			 ("%s, authmode=%d\n", __func__, authmode));
 		buff = rtw_malloc(IW_CUSTOM_MAX);
 		if (!buff)
 			return;
-- 
2.31.1

