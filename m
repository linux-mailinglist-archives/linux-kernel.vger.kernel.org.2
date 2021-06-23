Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD513B2418
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFWXvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhFWXvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:35 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90FBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:15 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g19so2361378qvx.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9afo+4mJE2XyS+iGuDebe+DFgAEacVkP6XxTR+UnoE=;
        b=vVfnXZpNBxOJEiPYEQwjxcu0/VHE6nkVPkzCpWgjL7sv66Lw6b3O13540tS06GnpaH
         iru9piJ01VDYbJ8CbrIicH04Jh/n3iy0nd/1qRFZVqHJ/LDlHOI6E5slRSlSEr7w5Ci6
         T9/HOhB/iSFvG/WWT9oqU5BlJ50IUIw3Ec1FQVfSYtpbki6CXMUsyHkVOSHvtGUYt7XP
         Vahc3QMiyHPjZb45luz7hsIyagcAz0I2reTQOVC7HO3M3lwUDC4AQzbw3JlXWUmRiUFS
         zVfvNYLlOMuLsYrvmDjzxYTL69InFrzKZaYfcd306HmqhzpNgPf9gSrm3624sUj+5cp4
         Abag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9afo+4mJE2XyS+iGuDebe+DFgAEacVkP6XxTR+UnoE=;
        b=lrzkzqWrDlWHybLpZ7wgCzNjlhN7fr4BBUosMCMPiSPLH5tbL0o9A9MkIFMfiQd2ns
         vaGsZlcIGVKJssae5MwhW2sitgaNvVyZHDlAwL1qap/6HRqX6H0t0O+dmRNYdN1rhQKT
         6vtbZwKjbIpgjBhqtWbXPVAlD414PlxalsEsZ+qo4LyFXDX5bMkOivfz1bCaUpkp2/8z
         VCHsqfYSsik8e6aYYKprhjFMWmWlRdXkej+MnC16sClhsCz2UkFYFV3RB/x/gWzuv3vr
         JfQnK3WhWbaSCMGlPMDhUpi8+E+/I6navoE8qMjuMgZNH9dO1+zgmgmZOzS9bNKF/t5b
         oPFg==
X-Gm-Message-State: AOAM530ndi08PkR8RnQTc8jraPid9jf26BvXBVACZKAgXarIR9xIkzEs
        SQUax/0zrIiFLOJPkl54kSSMvw==
X-Google-Smtp-Source: ABdhPJwYy9ZX56NcudFTMjbp5h1K1udUYMazzW1WiQPbt7dbpoXKxQaIUh2SMnGWrZN3npJs0DueTA==
X-Received: by 2002:a05:6214:b08:: with SMTP id u8mr2578429qvj.52.1624492155165;
        Wed, 23 Jun 2021 16:49:15 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:14 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 6/9] staging: rtl8188eu: remove DBG_88E_LEVEL macro from include/rtw_debug.h
Date:   Thu, 24 Jun 2021 00:48:59 +0100
Message-Id: <20210623234902.7411-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove definition of DBG_88E_LEVEL macro from include/rtw_debug.h, as it
no longer has any callers and does not follow kernel coding conventions.
Removing all such macros will ultimately allow the removal of this file.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_debug.h b/drivers/staging/rtl8188eu/include/rtw_debug.h
index a1b25ca16d28..ac123ddb8acb 100644
--- a/drivers/staging/rtl8188eu/include/rtw_debug.h
+++ b/drivers/staging/rtl8188eu/include/rtw_debug.h
@@ -58,12 +58,6 @@
 
 extern u32 GlobalDebugLevel;
 
-#define DBG_88E_LEVEL(_level, fmt, arg...)				\
-	do {								\
-		if (_level <= GlobalDebugLevel)				\
-			pr_info(DRIVER_PREFIX fmt, ##arg);	\
-	} while (0)
-
 #define MSG_88E(...)							\
 	do {								\
 		if (_drv_err_ <= GlobalDebugLevel)			\
-- 
2.31.1

