Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF93E456E65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhKSLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbhKSLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AC7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s13so17671044wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8WTMZAS1nVolBpu7e74CtYd/OF8mZi/Wlz6jd7/Ta7o=;
        b=PnPNQEk/XVUSkYisOQYVgt2d9YY2aKX8FMYuAHCiwdCkuJsCwTUfGRtnTAxwj3a/vQ
         s0uFfKHPmX9TvvyqLbJHRSb0nxO4V7XOZT4ciE4JcRDyMpEWQqnIJLZolZI1U5eOzu0n
         rvBDMKkrHj7fjDhZ7GCMq1aJ21vSTwLAFrdKyuRBxOTyoh9xbHe3+M55CweVU7L8/TWM
         42Uq6FNu7KGKhkaZj3rU46AUqd/4PEZGWmipUOWFi7zK17WOh/3Ten9ZEBH6IBxOJWYn
         KztDKpOXtZORzPUcwCr5/mtaateeUACzN1EgxCMBvsZ++gWIB0G3m5JuyekeDnrfbTvg
         vSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WTMZAS1nVolBpu7e74CtYd/OF8mZi/Wlz6jd7/Ta7o=;
        b=ZQuK2tHvD0He8J3P+QvO8tsUEShpvubKkm+K+FW6SZjmsPDEmI56OWVRp0jjK682Ko
         UiyRUvSIhTN3Zh6Ijv4nuqt5ggxJMImmHCsmcFpSwuxvm4Mcs2uIntsbbuKA+0sQy06l
         CKZwGocIKKYzUgDDPg0Zc/Qz5TmtthOgqPnWuvXVP9oZhrmSHbIumQuYNe4glwA3dprt
         /ydWj4a5iF9bpyebtYCVXtBw7zWpzT+/Ny3Sb7di+TDAIrgwe5DwKMiRILvq8W9lVEcW
         Uwc+Nr7ZYR0vs9M7/j3Q52bFLKhksojotAvYvfbL+LVx08M6REcCl0Pk9ctRE/FqtYtt
         uF4A==
X-Gm-Message-State: AOAM533fMCa5LV+VrGT9dvEa9kaGvnh2gZHzDHSzO4i8E3iRmt76FtuH
        YShqG6MVOjpPZ4Nz74ar5L5+XDRkaEdeWA==
X-Google-Smtp-Source: ABdhPJxH6z5sTFFPRQdvOJfpzU/VwUBKyZibyNtb9karNQpgOzfuIr7KbC2Isfk5BKrhe0u8sr0TSw==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr6494505wrx.292.1637321840381;
        Fri, 19 Nov 2021 03:37:20 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:20 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 12/17] linux/container_of.h: Remove unnecessary cast to (void *)
Date:   Fri, 19 Nov 2021 12:36:40 +0100
Message-Id: <20211119113644.1600-13-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casts are dangerous.
Every pointer converts implicitly to (void *).
Remove the unnecessary cast.

Since this macro is used with some pointers-to-const,
removing the cast triggers warnings about that
(implicit conversion from poitner-to-const to pointer-to-void).

To solve it, since we don't use the pointer to modify its contents,
we can simply use a (const void *).

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/container_of.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2100adb9d109..62df2ba21c20 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -17,7 +17,7 @@
  */
 #define container_of(ptr, type, member)  (				\
 {									\
-	void *__mptr = (void *)(ptr);					\
+	const void *__mptr = (ptr);					\
 									\
 	static_assert(__same_type(*(ptr), memberof(type, member)) ||	\
 		      __same_type(*(ptr), void),			\
@@ -36,7 +36,7 @@
  */
 #define container_of_safe(ptr, type, member)  (				\
 {									\
-	void *__mptr = (void *)(ptr);					\
+	const void *__mptr = (ptr);					\
 									\
 	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
 				 container_of(ptr, type, member);	\
-- 
2.33.1

