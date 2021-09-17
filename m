Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35F64101BF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbhIQXdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbhIQXch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D406C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i23so17658623wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVr0STWCT0vadAEVLvK4H+2tlmiDZVUwHL67IoyY9r8=;
        b=UwBBKehRXoIdIhAznDWq1YgzBlKTXIKjVdkNas6jDWfhdvm0jZZVLk5aBtRt7rZr2k
         EKJ2A12wInuUeoVBBMUI76lqMM92MASbV8JX023hDIFW03EWVQ2x1PEvPRAntd+y0tKW
         gxAW+kevC00k5jchmMzI05b9hRozo+DhZvsBuRcvYg0UejJMioK9oZKGIPIQwYuHsxCz
         A6W9mfc6GeTJyjietMHl0zwbSYT6ICRCiq8LH5vKhApj4avRkIqYityJJmZjMNBMm7MQ
         Yhzr4tDR1bT0TwV69Zju5m74R0WKZ5GTjY+iorJc3q2EL3HpdueFCL1KjJOCFYB02GKl
         fuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVr0STWCT0vadAEVLvK4H+2tlmiDZVUwHL67IoyY9r8=;
        b=ckwq1M0xjW/M+aoQjIsuYz9ZZjrTLC8C+v24+lmkYs6ITFbrCM1QkjwMNzMAEJjPbd
         S9jKktPwtcSgzfEKWhlP0NkidXnK4vW4GzpOJUfeBKpFqy+X5PW4r9B0avYExWLO21x9
         CV7AC3AVsHdn2XgZDbPV+YMCjLBRlwiW+Ep1xZxRJf+dWkOEcF1MD3uDWIV0StcJZwtJ
         2z+KzqHmb8wCxbg3zwkb36I71JqljgskMYEjDhLJ8TTt0sSyhe2VbC8lzuPs77I9J+Ya
         C6FZP++KggUlzDHwYCc84FivpwQguYIJWPgt5FvGq7neblOvaQSmp6IwDwiywIANeHlX
         1XqQ==
X-Gm-Message-State: AOAM5322TK/XySrOL4GNFIAYlSUDQHGOY+f17qzTWMUtm8R1hws/zQJY
        5piBiM4nFV/giWXsPqNa6xQ=
X-Google-Smtp-Source: ABdhPJwD1eLXjR5TRvW7s7+q2x47kcBu+xG7oEGfcnMIfZxBjlLj2ORKg4xEIKPO6eZYXlZnGMqeKw==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr14864823wrn.400.1631921473151;
        Fri, 17 Sep 2021 16:31:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/12] staging: r8188eu: remove ODM_IC_11N_SERIES, ODM_IC_11AC_SERIES macros.
Date:   Sat, 18 Sep 2021 01:30:47 +0200
Message-Id: <20210917233048.31677-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros ODM_IC_11N_SERIES and ODM_IC_11AC_SERIES are unused now.
Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 265583a43494..0d85e4fff6be 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -460,11 +460,6 @@ enum odm_ic_type {
 	ODM_RTL8821	=	BIT(6),
 };
 
-#define ODM_IC_11N_SERIES						\
-	(ODM_RTL8192S | ODM_RTL8192C | ODM_RTL8192D |			\
-	 ODM_RTL8723A | ODM_RTL8188E)
-#define ODM_IC_11AC_SERIES		(ODM_RTL8812)
-
 /* ODM_CMNINFO_CUT_VER */
 enum odm_cut_version {
 	ODM_CUT_A	=	1,
-- 
2.33.0

