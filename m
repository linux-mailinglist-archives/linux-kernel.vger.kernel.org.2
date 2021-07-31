Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC83DC20B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhGaAj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhGaAjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6695FC061796
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso3784607wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2g9UxZdEMaE3vJpbZr7oUx7+ltJAKf8EpUn9f9NHS/M=;
        b=yt4sC2HCLdHy+96eNPNSvuOROQ70MFk+iw/9dU7k7X1NFYSKMJh7bzpfZq2Tv5aGYY
         gE5hDVSz4bNTmb9+vAxkkOq0NYvDjPL3cOqBOAQJul7TlKypFYcfhfrv/JN75dsNvOo+
         BMO9LGnWdiJy+d+G2oFDzKDpH/e087j5Ni74jdcn6MkpFAcBn7/pC9YLCH3H/aSu54ca
         79SyUvKE96i+rYgQAnDY3lX1Cm8H5QYzE1B1La5EjKNHX0Cxnr8m0DZgHwBq6LEjnG+w
         tLkW3pPiBZmMXGXsP+1fc/6FgOUJlJUyx/vD4NzDrWErS/WLZDADAMDqVCBoO4CGSnv4
         73Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2g9UxZdEMaE3vJpbZr7oUx7+ltJAKf8EpUn9f9NHS/M=;
        b=JXmFfpOgF0RYMW/5iM8w6V2FaVz1nx69Byy7KP3CBihLPwZr6YDPnN2mTwllnGTngH
         RGuLVHUnhGd0wz1mkk3FnI60+UrpN+RKA24kHQhNqWPvmf/gSzutGhzeuc+6Zi65eMq0
         TFBzwWy8ktXC7JUQc/Jr3EqDhd1aHDXtk8QAwYEOomiL30RZ6QCYvH+VY7wNJDK+ckVh
         gOJAzlouvZ8mzc4C7SWtxXh7sJ+s1wwjbrxpCVty0j2I1u9zKaJZv+kblvajKFf010Ao
         8GJa7E+vOYM0LC+A84ajxG/28gaZjhKEmIUyQFXFtkD5KpEH1aPLWRwoluMGMFc6yZZp
         FHvg==
X-Gm-Message-State: AOAM530o5L5Q0vzELFPe0dVblE2RgOfAk08X9TLzqomFEgagM55CeFw/
        NmfOGoOxBtp0eq2c+vTSMy4b4w==
X-Google-Smtp-Source: ABdhPJxA0gOJ29/kWaucIm/hfxV+YOor3TlXyBCoVNhhQpgmEMhALINYtlrNomGuoaZyJ3P5odPcbg==
X-Received: by 2002:a05:600c:354e:: with SMTP id i14mr5581038wmq.96.1627691983052;
        Fri, 30 Jul 2021 17:39:43 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:42 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14 resent] staging: r8188eu: remove ASSERT ifndef and macro definition
Date:   Sat, 31 Jul 2021 01:39:28 +0100
Message-Id: <20210731003937.68615-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ASSERT ifndef and macro definition from include/odm_debug.h, as
these are unused and therefore superfluous.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/odm_debug.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index ef0d6b84b2d5..c70fe73e3339 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -68,10 +68,6 @@
 #define RT_PRINTK(fmt, args...)				\
 	DbgPrint( "%s(): " fmt, __func__, ## args);
 
-#ifndef ASSERT
-	#define ASSERT(expr)
-#endif
-
 #define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)				\
 	if (((comp) & pDM_Odm->DebugComponents) &&			\
 	    (level <= pDM_Odm->DebugLevel)) {				\
-- 
2.31.1

