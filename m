Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E434456E63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhKSLkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhKSLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476ACC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so17695499wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWVXu/ms1DWB88MCrLPmGvw1OfnOEM7Rjp0ZFtoPX4E=;
        b=AoYwp/6rhPAkss+lD7aFtIea238KFnYzo52MVcSwWBESJvnLR/d5IQhCdbpZvPtYQz
         k9AAgYPLbD3lZf/nw/mzTINbmRmhevncozSAAv4n0x1nkfHhWccohHvEGDiXjCikBdo3
         PZknpZN7osSOr3IfVlRA4E+m1vtuPPMJWnNGCo4ClDzalsr/e0kW7uS6M5VjZMo4SzyQ
         tsnuJ+XJ4UBCid1rNfPCIcuCZ3jCCayuE9Aieh3VabH3gOCej3llUWLLV3NGRcyKGBRs
         SP2Sr9B9P4grpAsazX9erW5IzNTwV9qwIAOe7cz23DR9Yg0VtlrFqsDBrlIQFuotJ7ub
         4YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWVXu/ms1DWB88MCrLPmGvw1OfnOEM7Rjp0ZFtoPX4E=;
        b=l2ZQy5i1bKxqHjftoM13Gg9u6g2xi0nP7uTp9FogiVet1YFSgIkEsVVsR6n0aYjM47
         10KfSw3i0pnE4bZShDg534VF87opXCpxG4NMx1EC0FA65eswDvDANfweAdCnfE2AVvgE
         81LWxWTHUtYkVUSibCuKQGU6VN2CBjhisrLm87u2kYKF7P+ffnSi5V5F4BPS/bvfmOtl
         ZzteTSbmjXyPYBhEsNRFhnA9Z6TWJ1WxCDGrKuYJvbtpuvfUz3Uf7jBQ10GR8k4L1P3+
         72dWsGiVguib0jVUtjZ+XIaIUVvEvTJ9VIvxkMfw6JXIRZ10JCiCB0Rx9CSmvrp6pOZ7
         HCcw==
X-Gm-Message-State: AOAM530HooJwsFTFlJqWzefU2HA4H5s5OfIVdYDLuvhlF2Vb5wg3V0Eh
        6JadtdE1mn08FO3LIZ8BxvxWdvEGY/csYw==
X-Google-Smtp-Source: ABdhPJyQKpcoNkKl9M3VY6VCJEHokEeVZMtgNVhj1QjUWJ7EbtCVJwmHd1aZBOQGXd3GSwcqQbLfVQ==
X-Received: by 2002:a05:6000:156a:: with SMTP id 10mr6504824wrz.87.1637321838912;
        Fri, 19 Nov 2021 03:37:18 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:18 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 10/17] linux/container_of.h: Implement container_of_safe() in terms of container_of()
Date:   Fri, 19 Nov 2021 12:36:38 +0100
Message-Id: <20211119113644.1600-11-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid duplicate code.  There's only one different statement.  Let it be so.

Note:  I'm not sure if we really need a void pointer for IS_ERR_OR_NULL(),
       or we could remove that line altogether.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/container_of.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 45aa73f5e392..addd3993fa60 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -30,12 +30,13 @@
  *
  * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
  */
-#define container_of_safe(ptr, type, member) ({				\
+#define container_of_safe(ptr, type, member)  (				\
+{									\
 	void *__mptr = (void *)(ptr);					\
-	static_assert(__same_type(*(ptr), memberof(type, member)) ||	\
-		      __same_type(*(ptr), void),			\
-		      "pointer type mismatch in container_of_safe()");	\
+									\
 	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
-		((type *)(__mptr - offsetof(type, member))); })
+				 container_of(ptr, type, member);	\
+}									\
+)
 
 #endif	/* _LINUX_CONTAINER_OF_H */
-- 
2.33.1

