Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8834B795
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhC0OZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhC0OY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:24:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC2C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x7so8364120wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9EXnh/EfbGVwvr6MY60PRrODm9ziLDg93tkWyqzj3g=;
        b=ZA5EGu0ud2zEnuChU6hbdGDHPlPcTMKVLai9ZEbicfP2ug/TgPfTtXGi2UTT7zFGk/
         OakhYOwBFuFpjakEEmukq0JCFY57WfzPGhUnzd3nGNyZxLsjV+qqZgpYNIFhWvz1/rcR
         B8f00qYGitLlPWEF/SHyUZBQy/jcL0YQGSM70m3JtQzu8cq+8gX0Yb+FQ2E5IavJdC45
         mLkuJ4+EmAUSYiCN4nMkUlvWo4sUD9mHTfGrc2eWgI/tM8tUE4fvM473UBV1A2tpnZRr
         5bpxZIFvs2o8Rdcc3EsDSUp5fCjmcYsJ0wZcDlGLQuslqpScPeswPIaxzEYbPdr3MwMU
         WXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9EXnh/EfbGVwvr6MY60PRrODm9ziLDg93tkWyqzj3g=;
        b=ToJ8mEeVhwzcQDUHY/bsEyk9fxQD+IR5U0AGgMokso+ugyydUQVn5xFlqICVtJI6/v
         LcGCVOHj61OWiOcluChJpNRoCHLVTaea22L1MTlbj/QVyU/vRup7PwKzJwBvYdXKuVgw
         ebx2ZLqbluIIOFlLV2Gb40JeREVI5nF09DmIBclBPQO+PoK7heLKIW6oyr4OcxDB6HmF
         PDzhuREkot3vsMafInI1Jm0HtlkIzydjQn0EtXEJ1D5i/6DOkfLNSOOf9o20eI3W66pu
         XOuhyH6CLfygc6P/51Gp9J6MbS86xWpmXBP5YRuMyKqO1frjg1KR4UmZ26OxlIlTbWV2
         pA/g==
X-Gm-Message-State: AOAM533xmaQN9KiMCXnErvM7Pi7pAFk3VrFkl5lZcn4v35zX1WtGfc+l
        mx58WJILpk2+2YyF2NYwkFc=
X-Google-Smtp-Source: ABdhPJymKO2w3lHlkqq+xhsTS2wnQh8r5q2m5GXpR5Tij5oLkjE5xc7nRDB4SjGacK8shEK0mL/Vdw==
X-Received: by 2002:a5d:58fc:: with SMTP id f28mr10776643wrd.180.1616855095899;
        Sat, 27 Mar 2021 07:24:55 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id t8sm20164012wrr.10.2021.03.27.07.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:24:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 07/20] staging: rtl8723bs: add spaces around operators in include/hal_data.h
Date:   Sat, 27 Mar 2021 15:24:06 +0100
Message-Id: <4186cc811caa92fe0625d06b3803e73f424059a6.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add spaces around operators in a macro

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index 655528ab8c7c..df5c7b747498 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -46,7 +46,7 @@ enum rt_ampdu_burst {
 	RT_AMPDU_BURST_8723B	= 7,
 };
 
-#define CHANNEL_MAX_NUMBER		(14+24+21)	/*  14 is the max channel number */
+#define CHANNEL_MAX_NUMBER		(14 + 24 + 21)	/*  14 is the max channel number */
 #define CHANNEL_MAX_NUMBER_2G		14
 #define CHANNEL_MAX_NUMBER_5G		54			/*  Please refer to "phy_GetChnlGroup8812A" and "Hal_ReadTxPowerInfo8812A" */
 #define CHANNEL_MAX_NUMBER_5G_80M	7
-- 
2.20.1

