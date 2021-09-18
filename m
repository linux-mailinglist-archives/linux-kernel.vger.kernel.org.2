Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D368410818
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbhIRSVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbhIRSUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69551C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c21so42711801edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=reovVjRvWVVgh0neDi2EWdAtfsrfN9OXCYPujWCZGUs=;
        b=HKfImwqMFYaXWyvS41+saMk56CfzFm2ioXn5+Z9hfCfexWI6eZKu+9RU7XccGNDgsG
         gzVYpt8r2FeYUo6i0u8OMxvuCznuGaj9FXr0X/kfq1VpT4215OOB79XxfK8lngWed1Xc
         AGYuq2IMrSQN4dthOGT1tB0XgfEr5jD2p4Ar8EudaR0j/6o1y3VbiqUE7zhGbMwBJW3G
         b5zBRINFTjO/rGbsy3GVKMmx4b9Pl1hMmLsdMfEAtKXoBr8WAop7xJ2PBAwcsUQ9YNfB
         A6Dcq+b2QkSK9LE4xiQa1lth25YfY9ozSf8bsi1Cu5UrhWFCPE22yG89b7LLVhJcwxf8
         GtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=reovVjRvWVVgh0neDi2EWdAtfsrfN9OXCYPujWCZGUs=;
        b=NKiY6qLTHnM5dFs5sGqBIpnV1ztbsgQoKEsKxOWHn/9KtGn4bVTeLtEIDHg6IxgVsh
         rkPuKv7k7twvw0uMh4Z4zXghrITThQZh0rK3l5q+iEcgDO8S+K0z/SwZW7EoIYJruFTQ
         wbHJcVARxT0U42UAbxLFrhsSTLrF8ZON6MybdrBYVm+zoh+Ef10zqmk9LmR5rbuvz3Lz
         oad5UxPYPOs1IQBD+ogSFUqJR3L8GkTT1vYqEbmINnjSuqXzBTyvGGdLb4+SXi+rqUjy
         W+kdcP+J0Gqw/dvowLOFufXnSGycpK5+jGNN6MzXyP6mDgwXK/m3jexqpLNXNzJJzlc2
         0IZw==
X-Gm-Message-State: AOAM532vlesUiOSuRSuvu/36zntpBhweQp8lS0SgBDFyUzDOxYnRrcKm
        hEQUoN3MTJkz2Vp+QK3F0SnzmYQdG5T6nw==
X-Google-Smtp-Source: ABdhPJwQKHtl97wrZSF00SqANVeBp3XiYKVSvfMfFF/gPeT+nTK75EkuVfhC/c0WQzRj49jcKR4n3Q==
X-Received: by 2002:a17:906:dbd7:: with SMTP id yc23mr19177092ejb.187.1631989170033;
        Sat, 18 Sep 2021 11:19:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 12/14] staging: r8188eu: remove header file odm_RegDefine11AC.h
Date:   Sat, 18 Sep 2021 20:19:02 +0200
Message-Id: <20210918181904.12000-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally the header odm_RegDefine11AC.h is unused now.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../r8188eu/include/odm_RegDefine11AC.h       | 29 -------------------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 30 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h

diff --git a/drivers/staging/r8188eu/include/odm_RegDefine11AC.h b/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
deleted file mode 100644
index bba7511cf244..000000000000
--- a/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef	__ODM_REGDEFINE11AC_H__
-#define __ODM_REGDEFINE11AC_H__
-
-/* 2 RF REG LIST */
-
-/* 2 BB REG LIST */
-/* PAGE 8 */
-/* PAGE 9 */
-#define	ODM_REG_OFDM_FA_RST_11AC		0x9A4
-/* PAGE A */
-#define	ODM_REG_CCK_CCA_11AC				0xA0A
-#define	ODM_REG_CCK_FA_RST_11AC			0xA2C
-#define	ODM_REG_CCK_FA_11AC				0xA5C
-/* PAGE C */
-#define	ODM_REG_IGI_A_11AC				0xC50
-/* PAGE E */
-#define	ODM_REG_IGI_B_11AC				0xE50
-/* PAGE F */
-#define	ODM_REG_OFDM_FA_11AC			0xF48
-
-/* 2 MAC REG LIST */
-
-/* DIG Related */
-#define	ODM_BIT_IGI_11AC				0xFFFFFFFF
-
-#endif
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index ffc6f8ecafc0..cd8e3d2db212 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -18,7 +18,6 @@
 
 #include "odm.h"
 #include "odm_HWConfig.h"
-#include "odm_RegDefine11AC.h"
 #include "odm_RegDefine11N.h"
 
 #include "HalPhyRf_8188e.h"/* for IQK,LCK,Power-tracking */
-- 
2.33.0

