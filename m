Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2C36FCF4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhD3O6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhD3O6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA72DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u17so105806763ejk.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSRdyXZZcxxoSZhQrgrWUXUUkaC+1Kk+0joSCnHO7Sk=;
        b=i33rYOTggasKM9qIUZXWBWuoQ68DxIDjCE26r7eMan0O4IwHCKTLILv3dSx8bkZHQ2
         mUsztz0pFnAX/wfFgkNmWmgk4WcSBmm92IcXIIwWasDOI2ESOo6ycSUf1ZrLQg7zr5l2
         HsWVJ+ahYRbenPyEwIxE997UePvqZvCSvTmuXUYzMNIUntoUxRIia/HDbIUZASqs/APV
         kZ5AenPSTI08iatUkNoEUDVaWVE6QCYPgqQ5d9QEqEYnjUPFnaEUtbfjpzPhSxSNbLUJ
         3vUa4ic2pmUwcDVNzX79aVKeQFVhcsC4PvWnd/YI/Q0rmb6R2mKPEc9VEH7iiIRwi0Eb
         Wj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSRdyXZZcxxoSZhQrgrWUXUUkaC+1Kk+0joSCnHO7Sk=;
        b=RvXhCBKmwEwDdNvHmvKIS0qQ470g8Bt77QHEqPbtAlQe1pXFUtCbMWIrrZHLcj8iVH
         kF77NSzjoMboOZ6Wh++wc80RcWm4dj1MKD4HKrgxQ9J/q0cVcwXtqKcv9+HbH+ZX85Y/
         P2h61gfbwl4LAZTQEmErIE46H60Ibb+sIfgcI40CgMcIeUp2ViN5UQlm+LEKml8jNsPD
         MrJvcD+PQp38w5vEj13k+ZULvP5cf736JTP2VAmi8Ds2QJVT8j21TRQO+Nlmtxnq/c5Y
         xgbbxpL+fnBZVFLzQf3T0/SFUYvySe4853kUpSDi/pLyoCP1efLHWNngpqOyP1TKcKeB
         x+pw==
X-Gm-Message-State: AOAM5326lkHllSQTJd6Hd9vuqhpPmAlCg083YkXqiyqmvqDOLuojBz2w
        di19fdr6Do8VvdVu3MgSCUU9Z5kwHCk=
X-Google-Smtp-Source: ABdhPJy+2OTz64h5SY2xinWf7VskuDaICWUurJeGybHZi9gn1cnxOAAtIv1F1FJuayNkQXw1xi0GHw==
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr1546111ejc.231.1619794635448;
        Fri, 30 Apr 2021 07:57:15 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id o6sm1474531edw.24.2021.04.30.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/43] staging: rtl8723bs: remove undefined function prototypes
Date:   Fri, 30 Apr 2021 16:56:27 +0200
Message-Id: <77c0c9027448be020a00e7ded9ffeb967341b588.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove undefined function prototypes.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_PathDiv.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h b/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
index 7a5bc00c3682..de69d5ea6ffd 100644
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
+++ b/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
@@ -8,14 +8,4 @@
 #ifndef	__ODMPATHDIV_H__
 #define    __ODMPATHDIV_H__
 
-void
-odm_PathDiversityInit(
-	void *pDM_VOID
-	);
-
-void
-odm_PathDiversity(
-	void *pDM_VOID
-	);
-
  #endif		 /* ifndef  __ODMPATHDIV_H__ */
-- 
2.20.1

