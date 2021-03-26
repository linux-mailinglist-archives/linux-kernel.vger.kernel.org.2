Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9632B34A3C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCZJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhCZJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711B7C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p19so2589517wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2qjc4Ksn1CALD5m37+MaDZfcs0eyhY3C8ypdEUFsu4=;
        b=XQwFi5PVQfdPE4b05vezd572XYU3ehOGE42j2jMFp6BjWDibY+2dr4mvDug/0IcCck
         /SOomcs8ZU98RrUoGkZ0UqaBniqh46t7AxzCrR1hMpF6D+tR3+B2P6rRjyY3YD0ylhif
         lQlkipHnGWQG+D6mMAEU1E6oRh1CjDeGfp9kQuGL1gwzxQF9ule5rvG5JYCyjFLSnuGx
         DHZYkHmB6zYgU8Yueq7bcM18/zPiFkQ/7EZtBl5pY/vklCH+fHDXGK66dGebFjUNw/UP
         GYnHWhEPTz93xdNiHzG69wSCrHpL59kaRQNJ6BSIEoIqJ7USWM2G7B4z5Bap4NUa4c7z
         qb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2qjc4Ksn1CALD5m37+MaDZfcs0eyhY3C8ypdEUFsu4=;
        b=CJe/qQ3Kh6R9xLnBXjaXKWryW0qtvASxqEfhTmt3UNVSIRpmmhtvl30L67rPH3tf67
         +Gr/NQuSkSAcQlYMs9rnlmi73q52xJvkvg1YmnvuO6h1aQH6a63NzqHhZDyGr+zHJ9Uw
         k9+shlYL2NVmGJxjus6CyzyrnCWM7xdh4YLjLL16agkhbWCz1WeCaPqPG1aO13hhYKzN
         6p9b8eXlHdPHWqQ/1RHtovcwpuuoboHccq5N5TDuGiX0fONW7PH9ouDaxAmm70/QaqQN
         svER5tWd8gbMqmJuS/XvGtKpnsWwBMSb5dN/094DQj2P/Cj/zeqciwxcvShpGV4mPhO2
         eDyA==
X-Gm-Message-State: AOAM5303CL1nQVqlKJfjgT5BSolV996tJx8/uxX8b9m1NF+rBTInxeRL
        X5/MVximfrwGsm/CirgNBDq7aeb/CeASjw==
X-Google-Smtp-Source: ABdhPJwpBoSopg1c0xkKwFJd+fCkwYykVXkNLKoTo4lBYTy7uBxaTnaCyUmk4Owat0StRQkq6Kb1QA==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr11901852wmq.18.1616749792194;
        Fri, 26 Mar 2021 02:09:52 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id s8sm11392541wrn.97.2021.03.26.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 07/15] staging: rtl8723bs: put parentheses on macros with complex values in include/hal_com_reg.h
Date:   Fri, 26 Mar 2021 10:09:14 +0100
Message-Id: <8b71e4bc52854aa5c3cd6888fa40c5dbd00fe5fb.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

ERROR: Macros with complex values should be enclosed in parentheses
710: FILE: drivers/staging/rtl8723bs/include/hal_com_reg.h:710:
+#define	RATE_ALL_CCK
			RATR_1M | RATR_2M | RATR_55M | RATR_11M
--
ERROR: Macros with complex values should be enclosed in parentheses
711: FILE: drivers/staging/rtl8723bs/include/hal_com_reg.h:711:
+#define	RATE_ALL_OFDM_AG
		RATR_6M | RATR_9M | RATR_12M | RATR_18M | RATR_24M |\
--
ERROR: Macros with complex values should be enclosed in parentheses
713: FILE: drivers/staging/rtl8723bs/include/hal_com_reg.h:713:
+#define	RATE_ALL_OFDM_1SS
		RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
--
ERROR: Macros with complex values should be enclosed in parentheses
715: FILE: drivers/staging/rtl8723bs/include/hal_com_reg.h:715:
+#define	RATE_ALL_OFDM_2SS
		RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_com_reg.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index b555826760d0..b5610dedc23e 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -707,13 +707,13 @@ Default: 00b.
 
 
 /*  ALL CCK Rate */
-#define	RATE_ALL_CCK				RATR_1M | RATR_2M | RATR_55M | RATR_11M
-#define	RATE_ALL_OFDM_AG			RATR_6M | RATR_9M | RATR_12M | RATR_18M | RATR_24M |\
-						RATR_36M | RATR_48M | RATR_54M
-#define	RATE_ALL_OFDM_1SS			RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
-						RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | RATR_MCS7
-#define	RATE_ALL_OFDM_2SS			RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\
-						RATR_MCS12 | RATR_MCS13 | RATR_MCS14 | RATR_MCS15
+#define	RATE_ALL_CCK				(RATR_1M | RATR_2M | RATR_55M | RATR_11M)
+#define	RATE_ALL_OFDM_AG			(RATR_6M | RATR_9M | RATR_12M | RATR_18M | RATR_24M |\
+						RATR_36M | RATR_48M | RATR_54M)
+#define	RATE_ALL_OFDM_1SS			(RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
+						RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | RATR_MCS7)
+#define	RATE_ALL_OFDM_2SS			(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\
+						RATR_MCS12 | RATR_MCS13 | RATR_MCS14 | RATR_MCS15)
 
 #define RATE_BITMAP_ALL			0xFFFFF
 
-- 
2.20.1

