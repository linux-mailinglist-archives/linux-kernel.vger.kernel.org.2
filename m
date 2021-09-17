Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7C4101C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbhIQXdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbhIQXci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54786C0613D8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so11117156wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=reovVjRvWVVgh0neDi2EWdAtfsrfN9OXCYPujWCZGUs=;
        b=f2JnfPpwNYC3DgKQ5UVHPgdGHhIA3j4OFIgXMjuFy6xRZn7hcN3bneicvyaohtF+zB
         b8wNdKCvoUYHV1ZVNyZRfF2xrGKVO01w53AUN3B188ie3bMf4+P364xT9TmQHst0p3LX
         R7MwX7hcHgDIHjrRFn7/XbqbgqLYx6dw7e9/+YkogPs9wPgnZ442ptKEaP4iFTm4//RB
         bkg0JUfwjrVcHuqXjHWRYzEe/b4H5l1a7nsKUFky1YhA2KBCCeU6MCZxKCBN1nyHzDHu
         1aTtvfp1RkxdBMApjGgGHtWDafyPp+ELw1TlksRBVRjx6rNBwQP0D+6pXlzEjemFioLH
         +NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=reovVjRvWVVgh0neDi2EWdAtfsrfN9OXCYPujWCZGUs=;
        b=eM087TyFbn0w/nyJ8UuDxwKimDQ4UIpy7bM4KkrQvgG/a/wh6LA64FdfI/sAWEagbx
         /PbjttDCo9Cd73X8a673Z5/H8DKLy2d8yZZTB0SEg2CD9KAnEABMw0LRRIMNlWgNWjOm
         E8pan5Umw3FrYf6Yqf+ijmA+UFIGrzCN2n/6AZrIgw3IP1WySc6pM3rIqd4XgpqTI1SY
         AW1+fMcy4pqscb5nNwSlTZ/QOwd+TCB8k4wb5rjAD8Q2YRvl/cjlStuXEmSTYZxJ5Kvx
         M771ZEfzWmyXbKzBSO5Z2TrsxNLSAdFTaQur33CFT3ZqZKo/kC587GruMYwVEpzHfBcd
         ctdw==
X-Gm-Message-State: AOAM530GTqD0p5fGCltlYyVFGzccCE06HCuFJ0W6jcbi14u6UAhSUCb/
        9FLcINQqlb9OJiDIBkJ40Rk=
X-Google-Smtp-Source: ABdhPJzbo72sv1OoQMFHo+mbPwx99y2o0A7ljN9jcf0dGmuyL+jgnjwrFtcmQZ3c+n7nAWzUB3bUWA==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr17153712wmq.159.1631921473977;
        Fri, 17 Sep 2021 16:31:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/12] staging: r8188eu: remove header file odm_RegDefine11AC.h
Date:   Sat, 18 Sep 2021 01:30:48 +0200
Message-Id: <20210917233048.31677-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
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

