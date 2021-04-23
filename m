Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3EB369543
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbhDWO7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242700AbhDWO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801D7C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n127so14393454wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAeg4inHkDxK0M8FI/mGa+6PBLw6yGrM2ERnE7fCtjI=;
        b=CVQjSvljvbG6xUtKh+ulDigfUwYns2XS7fg5eBwtQslGmz5dATxFEnV3+hUQva3Jh8
         0GVVOM9o7J3HjkxC9EgCs8iy6kBVjkRBLZONpyrCUXklYLEJ2adzoUJS3Jf1ayJgFPF4
         bherexMZQAzPfAcTU+PYu+FtYFCY6nhFUVSIRDZ1TC/+6hgJl/rkDf+Jb1OL+JIJcPXa
         2IepGHloA0D0vszzddKTEKUciNa3YtSTDFKe9cG/wvOVRjpkp8TcXB18iRli3QsW+LbG
         6F0r+Qq+3fpzMFQTrDXFX+ofVqMCH5uw3N1Y55xGIG0BsqL0ptVlj/KsKI5pOEz1yyk+
         Cstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAeg4inHkDxK0M8FI/mGa+6PBLw6yGrM2ERnE7fCtjI=;
        b=gxV2QHZTfSw0IRzWjJ+A0P4qRjXCiJOefq1fMVOgqARQwROPHrFJaMPTICSB2++zwD
         SCiSOY68zaQjNZ2ax9WSLYbuASy+GSvfnBaqP9DoKDWGXAisKnQKNOUPJjS1BtA6AFE7
         AAYXqcup1GErTOZBZCGk38cl+6maN2oMHeJ6D9/ONSG4ibLpg2i8G1frRZdo8zuXnn+S
         Nvk6DHzkabzGDkLtKok1T74gkhlMtEUbQ0iDtg3qIrL+E7aQxf+ELlty5USBrKqly3VB
         LRCa+tViBNwA3oCsjim7uA9/sGGmWZ80GcwJyudzsqxH97DN3j8OFQ2+5Hlhlr0MTDbh
         6xpg==
X-Gm-Message-State: AOAM531bPYS5Xm7Y8ewrxjeFc5LpJQA26Ov/B7YzrowtmIGPPnqmbPOS
        ezaKpITljfFuJeR7G9vxe31M7+YiLrQ=
X-Google-Smtp-Source: ABdhPJzY5I9BSYdtT7z6LiXR+eXapOw9usCh6YmMzqTApbJ9s52jkgR8t8qQw6HAez/VZ2h6hRQtMg==
X-Received: by 2002:a05:600c:350b:: with SMTP id h11mr6011378wmq.103.1619189927084;
        Fri, 23 Apr 2021 07:58:47 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id l8sm8347489wme.18.2021.04.23.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/49] staging: rtl8723bs: remove DBG_871X_SEL macro declaration
Date:   Fri, 23 Apr 2021 16:57:54 +0200
Message-Id: <8fbd19c077ab080bced83dc3219e8ecbac43462f.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DBG_871X_SEL macro declaration.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index ed75db1b16f8..fbae0d3b168c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -158,15 +158,6 @@
 
 #define RTW_DBGDUMP NULL /* 'stream' for _dbgdump */
 
-/* dump message to selected 'stream' */
-#define DBG_871X_SEL(sel, fmt, arg...)					\
-	do {								\
-		if (sel == RTW_DBGDUMP)					\
-			_DBG_871X_LEVEL(_drv_always_, fmt, ##arg);	\
-		else							\
-			seq_printf(sel, fmt, ##arg);			\
-	} while (0)
-
 #endif /* defined(_dbgdump) */
 
 void mac_reg_dump(void *sel, struct adapter *adapter);
-- 
2.20.1

